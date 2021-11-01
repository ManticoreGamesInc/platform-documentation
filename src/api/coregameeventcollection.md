---
id: coregameeventcollection
name: CoreGameEventCollection
title: CoreGameEventCollection
tags:
    - API
---

# CoreGameEventCollection

Contains a set of results from [CorePlatform.GetGameEventCollection()](coreplatform.md) and related functions. Depending on how many events are available, results may be separated into multiple pages. The `.hasMoreResults` property may be checked to determine whether more events are available. Those results may be retrieved using the `:GetMoreResults()` function.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `hasMoreResults` | `boolean` | Returns `true` if there are more events available to be requested. | Read-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetResults()` | `Array`<[`CoreGameEvent`](coregameevent.md)> | Returns the list of events contained in this set of results. This may return an empty table. | None |
| `GetMoreResults()` | [`CoreGameEventCollection`](coregameeventcollection.md) | Requests the next set of results for this list of events and returns a new collection containing those results. Returns `nil` if the `hasMoreResults` property is `false`. This function may yield until a result is available, and may raise an error if an error occurs retrieving the information. | None |

## Examples

Example using:

### `GetResults`

In this example, we listen for the `Game.roundStartEvent`. At the start of each round we clear all equipment on players and give them one equipment to play with. Usually they will get a default equipment, that is the basis of this game. However, there is a special equipment that only appears during Game Events. This is given as the primary equipment instead of the default one, if there is an active Game Event with a `Reference Name` that matches what we are looking for.

```lua
local NORMAL_EQUIPMENT = script:GetCustomProperty("NormalEquipment")
local EVENT_EQUIPMENT = script:GetCustomProperty("EventEquipment")
local GAME_ID = script:GetCustomProperty("GameID")
local EVENT_REF_NAME = script:GetCustomProperty("EventRefName")

function IsEventActive(refName)
    local collection = CorePlatform.GetGameEventsForGame(GAME_ID)
    for i, eventData in ipairs(collection:GetResults()) do
        if eventData.state == CoreGameEventState.ACTIVE
        and eventData.referenceName == refName then
            return true
        end
    end
    return false
end

function RemoveAllEquipment(player)
    for _, equipment in pairs(player:GetEquipment()) do
        if Object.IsValid(equipment) then
            equipment:Destroy()
        end
    end
end

function OnRoundStart()
    local useEventEquipment = IsEventActive(EVENT_REF_NAME)

    for _, player in ipairs(Game.GetPlayers()) do
        RemoveAllEquipment(player)

        local equipment = nil
        if useEventEquipment then
            equipment = World.SpawnAsset(EVENT_EQUIPMENT)
        else
            equipment = World.SpawnAsset(NORMAL_EQUIPMENT)
        end
        equipment:Equip(player)
    end
end

Game.roundStartEvent:Connect(OnRoundStart)
```

See also: [Game.roundStartEvent](game.md) | [CorePlatform.GetGameEventsForGame](coreplatform.md) | [CoreGameEvent.state](coregameevent.md) | [CoreGameEventState](enums.md#coregameeventstate) | [Player.GetEquipment](player.md) | [Equipment.Equip](equipment.md) | [World.SpawnAsset](world.md) | [CoreObject.Destroy](coreobject.md) | [Object.IsValid](object.md)

---

Example using:

### `GetResults`

### `GetMoreResults`

### `hasMoreResults`

In this example we look at all the events for a given game. The status of each one is printed to the Event Log. Events can be Active or Scheduled, in which case they have a remaining time or upcoming time, respectively. Events can also be in a "Canceled" state, but we ignore those. The advantages of using countdowns to express the end of an event (or wait for an upcoming one) are to build anticipation in the eyes of players, but also to avoid any complications with time zones for players around the world.

```lua
local GAME_ID = "a3040c7ff0ca4a148d98191c701afe9a"

local collection = CorePlatform.GetGameEventsForGame(GAME_ID)

function PrintCollection()
    local gameEvents = collection:GetResults()
    for i, eventData in ipairs(gameEvents) do
        if eventData.state == CoreGameEventState.ACTIVE then
            local eventEnd = eventData:GetEndDateTime()
            local time = eventEnd.secondsSinceEpoch - DateTime.CurrentTime().secondsSinceEpoch
            print(eventData.name.." is active. Ends in "..time.." seconds")

        elseif eventData.state == CoreGameEventState.SCHEDULED then
            local eventStart = eventData:GetStartDateTime()
            local time = eventStart.secondsSinceEpoch - DateTime.CurrentTime().secondsSinceEpoch
            print(eventData.name.." is scheduled. Starts in "..time.." seconds")
        end
    end
end

function NextPage()
    if collection and collection.hasMoreResults then
        collection = collection:GetMoreResults()
    end
end

PrintCollection()
```

See also: [CorePlatform.GetGameEventsForGame](coreplatform.md) | [CoreGameEvent.state](coregameevent.md) | [CoreGameEventState](enums.md#coregameeventstate) | [DateTime.CurrentTime](datetime.md)

---

## Learn More

[CorePlatform.GetGameEventCollection()](coreplatform.md)
