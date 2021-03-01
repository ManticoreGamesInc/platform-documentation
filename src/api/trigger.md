---
id: trigger
name: Trigger
title: Trigger
tags:
    - API
---

# Trigger

A trigger is an invisible and non-colliding CoreObject which fires events when it interacts with another object (e.g. A Player walks into it):

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `isInteractable` | `boolean` | Interactable Triggers expect Players to walk up and press the <kbd>F</kbd> key to activate them. | Read-Write |
| `interactionLabel` | `string` | The text players will see in their HUD when they come into range of interacting with this trigger. | Read-Write |
| `team` | `integer` | Assigns the trigger to a team. Value range from 0 to 4. 0 is neutral team. | Read-Write |
| `isTeamCollisionEnabled` | `boolean` | If `false`, and the Trigger has been assigned to a valid team, players on that team will not overlap or interact with the Trigger. | Read-Write |
| `isEnemyCollisionEnabled` | `boolean` | If `false`, and the Trigger has been assigned to a valid team, players on enemy teams will not overlap or interact with the Trigger. | Read-Write |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `IsOverlapping(CoreObject)` | `boolean` | Returns true if given CoreObject overlaps with the Trigger. | None |
| `IsOverlapping(Player)` | `boolean` | Returns true if given player overlaps with the Trigger. | None |
| `GetOverlappingObjects()` | `Array<`[`Object`](object.md)`>` | Returns a list of all objects that are currently overlapping with the Trigger. | None |

## Events

| Event Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `beginOverlapEvent` | `Event<`[`Trigger`](trigger.md), trigger, Object other`>` | Fired when an object enters the Trigger volume. The first parameter is the Trigger itself. The second is the object overlapping the Trigger, which may be a CoreObject, a Player, or some other type. Call `other:IsA()` to check the type. | None |
| `endOverlapEvent` | `Event<`[`Trigger`](trigger.md), trigger, Object other`>` | Fired when an object exits the Trigger volume. Parameters the same as `beginOverlapEvent.` | None |
| `interactedEvent` | `Event<`[`Trigger`](trigger.md), trigger, Player`>` | Fired when a player uses the interaction on a trigger volume (<kbd>F</kbd> key). The first parameter is the Trigger itself and the second parameter is a Player. | None |

## Examples

Using:

- `beginOverlapEvent`

In this example, players die when they walk over the trigger. The script assumes to be a child of the trigger.

```lua
local trigger = script.parent

function OnBeginOverlap(theTrigger, player)
    -- The object's type must be checked because CoreObjects also overlap triggers, but we
    -- only call :Die() on players.
    if player and player:IsA("Player") then
        player:Die()
    end
end

trigger.beginOverlapEvent:Connect(OnBeginOverlap)
```

See also: [CoreObject.parent](coreobject.md) | [other.IsA](other.md) | [Player.Die](player.md) | [Event.Connect](event.md)

---

Using:

- `endOverlapEvent`

As players enter/exit the trigger the script keeps a table with all currently overlapping players. The script assumes to be a child of the trigger.

```lua
local trigger = script.parent
local activePlayers = {}

function OnBeginOverlap(theTrigger, player)
    if player and player:IsA("Player") then
        table.insert(activePlayers, player)
        print("The trigger contains " .. #activePlayers .. " players")
    end
end

function OnEndOverlap(theTrigger, player)
    if (not player or not player:IsA("Player")) then return end

    for i, p in ipairs(activePlayers) do
        if p == player then
            table.remove(activePlayers, i)
            break
        end
    end
    print("The trigger contains " .. #activePlayers .. " players")
end

trigger.beginOverlapEvent:Connect(OnBeginOverlap)
trigger.endOverlapEvent:Connect(OnEndOverlap)
```

See also: [CoreObject.parent](coreobject.md) | [other.IsA](other.md) | [Trigger.beginOverlapEvent](trigger.md) | [Event.Connect](event.md)

---

Using:

- `interactedEvent`

In this example, the trigger has the "Interactable" checkbox turned on. When the player walks up to the trigger and interacts with the F key they are propelled into the air. The script assumes to be a child of the trigger.

```lua
local trigger = script.parent
trigger.isInteractable = true

function OnInteracted(theTrigger, player)
    -- In this case there is no need to check the type with IsA("Player") because only
    -- players can trigger the interaction.
    player:SetVelocity(Vector3.New(0, 0, 10000))
end

trigger.interactedEvent:Connect(OnInteracted)
```

See also: [CoreObject.parent](coreobject.md) | [Trigger.isInteractable](trigger.md) | [Player.SetVelocity](player.md) | [Event.Connect](event.md)

---

Using:

- `GetOverlappingObjects`

In this example, any objects that overlap with the trigger are pushed upwards until they no longer overlap. If the trigger overlaps with non-networked objects this will throw an error. The script assumes to be a child of the trigger.

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

See also: [CoreObject.parent](coreobject.md) | [Vector3.New](vector3.md)

---

Using:

- `IsOverlapping`

In this example, a physics sphere is placed in the scene. Every second the sphere is in the trigger, team 1 scores a point. The script assumes to be a child of the trigger.

```lua
local trigger = script.parent
local sphere = World.FindObjectByName("PhysicsSphere")
local teamToReward = 1

while true do
    Task.Wait(1)
    if sphere and trigger:IsOverlapping(sphere) then
        Game.IncreaseTeamScore(teamToReward, 1)
        print("Team " .. teamToReward .. " score = " .. Game.GetTeamScore(teamToReward))
    end
end
```

See also: [CoreObject.parent](coreobject.md) | [World.FindObjectByName](world.md) | [Task.Wait](task.md) | [Game.IncreaseTeamScore](game.md)

---

Using:

- `IsOverlapping`

In this example, players score points for their teams for each second they are inside the trigger. The script assumes to be a child of the trigger.

```lua
local trigger = script.parent

while true do
    Task.Wait(1)
    local allPlayers = Game.GetPlayers()

    for _, player in ipairs(allPlayers) do
        if trigger:IsOverlapping(player) then
            local teamToReward = player.team
            Game.IncreaseTeamScore(teamToReward, 1)
            print("Team " .. teamToReward .. " score = " .. Game.GetTeamScore(teamToReward))
        end
    end
end
```

See also: [CoreObject.parent](coreobject.md) | [Task.Wait](task.md) | [Game.GetPlayers](game.md) | [Player.team](player.md)

---

Using:

- `interactionLabel`

In this example, the trigger moves left and right and changes its label dynamically. To use this as a sliding door place a door asset as a child of the trigger. The script assumes to be a child of the trigger.

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

See also: [CoreObject.parent](coreobject.md) | [Trigger.isInteractable](trigger.md) | [Vector3.New](vector3.md) | [Event.Connect](event.md)

---

Using:

- `isEnemyCollisionEnabled`

In this example, when a player interacts with a trigger it joins their team and enemies can no longer interact with it. Each time they interact their team gains a point. When the last player to interact with the trigger is killed the trigger returns to it's original neutral form. The script assumes to be a child of the trigger.

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

    if teamToReward == trigger.team then
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

See also: [CoreObject.parent](coreobject.md) | [Trigger.isInteractable](trigger.md) | [EventListener.Disconnect](eventlistener.md) | [Player.team](player.md) | [Game.IncreaseTeamScore](game.md) | [Event.Connect](event.md)

---

Using:

- `isInteractable`

In this example, the trigger has a 4 second "cooldown" after it is interacted. The script assumes to be a child of the trigger.

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

See also: [CoreObject.parent](coreobject.md) | [Task.Wait](task.md) | [Trigger.interactedEvent](trigger.md) | [Event.Connect](event.md)

---

Using:

- `isTeamCollisionEnabled`

In this example, when a player interacts with a trigger it joins their team and they can no longer interact with it, but enemies can. The script assumes to be a child of the trigger.

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

See also: [CoreObject.parent](coreobject.md) | [Trigger.isInteractable](trigger.md) | [Player.team](player.md) | [Event.Connect](event.md)

---

Using:

- `team`

In this example, players score points when they enter a trigger that belongs to the enemy team. The script assumes to be a child of the trigger.

```lua
local trigger = script.parent

function OnBeginOverlap(theTrigger, player)
    local teamToReward = player.team

    if (player and player:IsA("Player") and teamToReward ~= trigger.team) then
        Game.IncreaseTeamScore(teamToReward, 1)
        print("Team " .. teamToReward .. " score = " .. Game.GetTeamScore(teamToReward))
    end
end

trigger.beginOverlapEvent:Connect(OnBeginOverlap)
```

See also: [CoreObject.parent](coreobject.md) | [Player.team](player.md) | [other.IsA](other.md) | [Game.IncreaseTeamScore](game.md) | [Trigger.beginOverlapEvent](trigger.md) | [Event.Connect](event.md)

---
