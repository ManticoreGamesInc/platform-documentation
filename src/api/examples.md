---
id: examples
name: Examples and Snippets
title: Examples and Snippets
tags:
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

## Events

Core uses events to communicate data and changes to game state. Events appear as properties on several objects. Scripts can listen to these events by registering a function for each desired event. Events allow two separate scripts to communicate, without the need to reference each other directly.

### Connect

To hook up your function to an event, you have to call `Connect(function YourFunction, [...])` to register it. Now it will be called every time the event is fired.

Example:

```lua
function OnPlayerDamaged(player, dmg)
    print("Player " .. player.name .. " took " .. dmg.amount .. " damage. New health = " .. player.hitPoints)
end

function OnPlayerJoined(player)
    player.damagedEvent:Connect(OnPlayerDamaged)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

Connects the `OnPlayerDamaged` function to the `damagedEvent` event to the `damagedEvent` event on all players who join the game. Now every time a player takes damage, `OnPlayerDamaged` will be called.

`Connect()` also returns an `EventListener` which can be used to disconnect from the event or check if the event is still connected via the `isConnected` property. It also accepts any number of additional arguments after the listener function, those arguments will be provided after the event's own parameters.

### Disconnect

Pretty simple, you just call `Disconnect()` on the returned `EventListener` to disconnect a listener from its event, so it will no longer be called when the event is fired.

Example:

```lua
local damagedEventListener

function OnPlayerJoined(player)
    damagedEventListener = player.damagedEvent:Connect(OnPlayerDamaged)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)

function OnDestroyed(obj)
    if damagedEventListener then
        damagedEventListener:Disconnect()
        damagedEventListener = nil
    end
end

script.destroyEvent:Connect(OnDestroyed)
```

### Broadcast

If your script runs on a server, you can broadcast game-changing information to your players. In this example the `OnExecute` function was connected to an ability objects `executeEvent`. It adds a few checks to using an ability, a bandage in this case.

```lua
function OnExecute(ability)
    if ability.owner:GetResource("Bandages") <= 0 then
        Events.BroadcastToPlayer(ability.owner, "BannerSubMessage", "No Bandages to Apply")
        return
    end

    if ability.owner.hitPoints < ability.owner.maxHitPoints then
        ability.owner:ApplyDamage(Damage.New(-30))
        ability.owner:RemoveResource("Bandages", 1)
    else
        Events.BroadcastToPlayer(ability.owner, "BannerSubMessage", "Full Health")
    end
end

myAbility.executeEvent:Connect(OnExecute)
```

Both error and success cases get communicated back to the client via `BroadcastToPlayer`. If you want to do the reverse, to update a server side stored value from a player script, you'd use `BroadcastToServer` instead.

## Needed

* What isn't represented here? Let us know!
* To add more, enter the details in the form [here](https://forms.gle/br8ZjanQGU2LkBvPA).
