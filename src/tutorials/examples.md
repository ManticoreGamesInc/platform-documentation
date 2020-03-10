---
id: examples
name: Examples and Snippets
title: Examples and Snippets
categories:
    - Misc
---

# Examples and Snippets

## Trigger Examples

In the following examples it's assumed the script is placed as a child of a trigger in the hierarchy.

### `beginOverlapEvent`

In this example, players die when they walk over the trigger.

```lua
local trigger = script.parent

function OnBeginOverlap(theTrigger, player)
  -- The object's type must be checked because CoreObjects also overlap triggers, but we only call :Die() on players.
  if player:IsA("Player") then
    player:Die()
  end
end
trigger.beginOverlapEvent:Connect(OnBeginOverlap)
```

### `endOverlapEvent`

As players enter/exit the trigger the script keeps a table with all currently overlapping players.

```lua
local trigger = script.parent
local activePlayers = {}

function OnBeginOverlap(theTrigger, player)
  if player:IsA("Player") then
    table.insert(activePlayers, player)
    print("The trigger contains " .. #activePlayers .. " players")
  end
end

function OnEndOverlap(theTrigger, player)
  if (not player:IsA("Player")) then return end

  for i,p in ipairs(activePlayers) do
    if (p == player) then
      table.remove(activePlayers, i)
      break
    end
  end
  print("The trigger contains " .. #activePlayers .. " players")
end
trigger.beginOverlapEvent:Connect(OnBeginOverlap)
trigger.endOverlapEvent:Connect(OnEndOverlap)
```

### `interactedEvent`

In this example, the trigger has the "Interactable" checkbox turned on. When the player walks up to the trigger and interacts with the <kbd>F</kbd> key they are propelled into the air.

```lua
local trigger = script.parent
trigger.isInteractable = true

function OnInteracted(theTrigger, player)
  -- In this case there is no need to check the type with IsA("Player") because only players can trigger the interaction.
  player:SetVelocity(Vector3.New(0, 0, 10000))
end
trigger.interactedEvent:Connect(OnInteracted)
```

### `IsOverlapping(CoreObject)`

In this example, a physics sphere is placed in the scene. Every second the sphere is in the trigger, team 1 scores a point.

```lua
local trigger = script.parent
local sphere = World.FindObjectByName("PhysicsSphere")
local teamToReward = 1

while true do
  Task.Wait(1)
  if (sphere and trigger:IsOverlapping(sphere)) then
    Game.IncreaseTeamScore(teamToReward, 1)
    print("Team " .. teamToReward .. " score = " .. Game.GetTeamScore(teamToReward))
  end
end
```

### `IsOverlapping(Player)`

In this example, players score points for their teams for each second they are inside the trigger.

```lua
local trigger = script.parent

while true do
  Task.Wait(1)
  local allPlayers = Game.GetPlayers()
  for _, player in ipairs(allPlayers) do
    if (trigger:IsOverlapping(player)) then
      local teamToReward = player.team
      Game.IncreaseTeamScore(teamToReward, 1)
      print("Team " .. teamToReward .. " score = " .. Game.GetTeamScore(teamToReward))
    end
  end
end
```

### `GetOverlappingObjects()`

In this example, any objects that overlap with the trigger are pushed upwards until they no longer overlap. If the trigger overlaps with non-networked objects this will throw an error.

```lua
local trigger = script.parent
function Tick()
  local objects = trigger:GetOverlappingObjects()
  for _, obj in pairs(objects) do
    local pos = obj:GetWorldPosition()
    pos = pos + Vector3.New(0, 0, 10)
    obj:SetWorldPosition(pos)
  end
end
```

### `isInteractable`

In this example, the trigger has a 4 second "cooldown" after it is interacted.

```lua
local trigger = script.parent
trigger.isInteractable = true

function OnInteracted(theTrigger, player)
  print("INTERACTED!")
  trigger.isInteractable = false
  Task.Wait(4)
  trigger.isInteractable = true
end
trigger.interactedEvent:Connect(OnInteracted)
```

### `interactionLabel`

In this example, the trigger moves left and right and changes its label dynamically. To use this as a sliding door place a door asset as a child of the trigger.

```lua
local trigger = script.parent
local slideDuration = 2
local startPos = trigger:GetWorldPosition()
local isOpen = false

trigger.isInteractable = true

function SetState(newState)
  isOpen = newState

  if isOpen then
    trigger.interactionLabel = "Close"
    trigger:MoveTo(startPos, slideDuration)
  else
    trigger.interactionLabel = "Open"
    trigger:MoveTo(startPos + Vector3.New(0, 150, 0), slideDuration)
  end
end
SetState(true)

function OnInteracted(theTrigger, player)
  SetState(not isOpen)
end
trigger.interactedEvent:Connect(OnInteracted)
```

### `team`

In this example, players score points when they enter a trigger that belongs to the enemy team.

```lua
local trigger = script.parent

function OnBeginOverlap(theTrigger, player)
  local teamToReward = player.team
  if (player:IsA("Player") and teamToReward ~= trigger.team) then
    Game.IncreaseTeamScore(teamToReward, 1)
    print("Team " .. teamToReward .. " score = " .. Game.GetTeamScore(teamToReward))
  end
end
trigger.beginOverlapEvent:Connect(OnBeginOverlap)
```

### `isTeamCollisionEnabled`

In this example, when a player interacts with a trigger it joins their team and they can no longer interact with it, but enemies can.

```lua
local trigger = script.parent
trigger.isInteractable = true

function OnInteracted(theTrigger, player)
  trigger.team = player.team
  trigger.isTeamCollisionEnabled = false
  print("The objective now belongs to team " .. player.team)
end
trigger.interactedEvent:Connect(OnInteracted)
```

### `isEnemyCollisionEnabled`

In this example, when a player interacts with a trigger it joins their team and enemies can no longer interact with it. Each time they interact their team gains a point. When the last player to interact with the trigger is killed the trigger returns to it's original neutral form.

```lua
local trigger = script.parent
trigger.isInteractable = true
trigger.team = 0
local onDiedListener = nil

function OnPlayerDied(player, dmg)
  onDiedListener:Disconnect()
  trigger.team = 0
  trigger.isEnemyCollisionEnabled = true
  print("The objective is neutral again.")
end

function OnInteracted(theTrigger, player)
  local teamToReward = player.team
  if (teamToReward == trigger.team) then
    Game.IncreaseTeamScore(teamToReward, 1)
    print("Team " .. teamToReward .. " score = " .. Game.GetTeamScore(teamToReward))
  else
    trigger.team = teamToReward
    trigger.isEnemyCollisionEnabled = false
    print("The objective now belongs to team " .. player.team)
  end

  if onDiedListener then
    onDiedListener:Disconnect()
  end
  onDiedListener = player.diedEvent:Connect(OnPlayerDied)
end
trigger.interactedEvent:Connect(OnInteracted)
```

## Storage

The following examples assume the hierarchy has a GameSettings object with **"Enable Player Storage**" turned on.

### Storage.GetPlayerData(Player)

This example detects when a player joins the game and fetches their XP and level from storage. Those properties are moved to the player's resources for use by other gameplay systems.

```lua
function OnPlayerJoined(player)
    local data = Storage.GetPlayerData(player)
    -- In case it's the first time for this player we use default values 0 and 1
    local xp = data["xp"] or 0
    local level = data["level"] or 1
    -- Each time they join they gain 1 XP. Stop and play the game again to test that this value keeps going up
    xp = xp + 1
    player:SetResource("xp", xp)
    player:SetResource("level", level)
    print("Player " .. player.name .. " joined with Level " .. level .. " and XP " .. xp)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

### Storage.SetPlayerData(Player, table)

This example detects when a player gains XP or level and saves the new values to storage.

```lua
function OnResourceChanged(player, resName, resValue)
    if (resName == "xp" or resName == "level") then
        local data = Storage.GetPlayerData(player)
        data[resName] = resValue
        local resultCode,errorMessage = Storage.SetPlayerData(player, data)
    end
end

function OnPlayerJoined(player)
    player.resourceChangedEvent:Connect(OnResourceChanged)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

## Contexts

In Core, contexts are like folders and exist in one of two states: networked and non-networked. You can nest multiple contexts but only the outermost one has any effect. Inside of it, every child context acts like a folder.

When a script spawns an object, it inherits the script's context, even if it is somewhere else in the hierarchy. This means that a script in a server context can never spawn objects that clients can see or interact with.

There are five types of contexts, **Client Context**, **Non-Networked**, **Static Context**, **Server Context** and **Networked**.

### Overview

|                    | **Default (Non-Networked)** | **Networked**        | **Client Context** | **Server Context** | **Static Context** |
| ------------------ | ----------------------------| ---------------------| -------------------| -------------------| -------------------|
| Objects can change | No                          | Yes (only by server) | Yes                | Yes                | No                 |
| Collision          | Yes                         | Yes                  | No                 | No                 | Yes                |
| Objects exist on   | Client and Server           | Client and Server    | Client             | Server             | Client and Server  |
| Scripts run on     | Server                      | Server               | Client             | Server             | Client and Server  |

### Default (Non-Networked)

- Cannot change.
- Can have collision.
- Seen by server and client.
- Scripts run on the server only.

### Networked

- Can be changed by the server.
- Clients will see those changes.
- Scripts run on the server only.

### Client Context

- Objects can change.
- Objects will collide with "Default" and "Networked" objects, but they will not impart any momentum back to those objects.
- Objects will block any cameras unless explicitly set otherwise.
- Scripts can access "Default" or "Networked" scripts because they occupy a place in the hierarchy.
    - You could traverse through them, read their position, or read networked properties on them.
- Scripts run on the client only.

### Server Context

- Objects do not have collision.
- Objects inside get removed from the client-side copy of the game sent to players.
- Provides a safeguard for creators if they want to conceal game logic.
- Scripts run on the server only.

### Static Context

- Almost like the default state (non-networked).
- Scripts can spawn objects inside a static context.
- Scripts run on both the server and the client.
- Useful for things reproduced easily on the client and server with minimal data (procedurally generated maps).
    - Send a single networked value to synchronize the server and clients’ random number generators.
    - Saves hundreds of transforms being sent from the server to every client.

!!! warning Beware of desync issues!
    Performing any operations from a static context that might diverge during server/client execution of a script will almost certainly cause desync issues.
    Static scripts are run independently on the server and all clients so you should avoid performing any script actions that can exhibit different behavior depending on the machine. Specifically, avoid any logic that is conditional on:
    - Server-only or client-only objects.
    - Random number generators with different seeds.
    - Logic based around local `time()`.

## Needed

* What isn't represented here? Let us know!
* To add more, enter the details in the form [here](https://forms.gle/br8ZjanQGU2LkBvPA).
