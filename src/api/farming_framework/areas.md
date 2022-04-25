---
id: areas
name: Areas
title: Areas
---

# Areas

The **Areas** system is meant to be used to chunk your environment into discrete pieces that can be loaded on demand.
This provides a much more performant experience for Players and lets creators include much more content in their
games.

As Players move through Areas they can be moved to specific spawn points, be placed into pools of Areas, have
templates loaded into the client, server, static contexts, and more.

## Events

| Event Name | Return Type | Description | Tags |
| ---------- | ----------- | ----------- | ---- |
| `AreaFinishedLoading` | `Event`<`areaId`> | This event is sent every time an Area finishes loading. | Server |
| `AreaFinishedUnloading` | `Event`<`areaId`> | This event is sent every time an Area finishes unloading. | Server |
| `PlayerAreaChanged` | `Event`<[`Player`](../api/player.md), `areaId`, `lastAreaId`> | This event is sent every time a Player moves to an Area. | Server |
| `PlayerFinishedLoadingArea` | `Event`<[`Player`](../api/player.md)> | This event is sent from the client to the server when a Player finishes loading an Area. | Server |
| `TeleportToArea` | `Event`<[`Player`](../api/player.md), `areaId`, `areaKey`, `targetPosition`, [`targetRotation`](../api/targetrotation.md), `spawnPointKey`> | This event is sent from the client to the server, or server to server when a Player enters a portal or clicks | Server |

## Functions

| Class Function Name | Return Type | Description | Tags |
| ------------------- | ----------- | ----------- | ---- |
| `AssignArea(string, string)` | `None` | Assigns a key to an Area. | None |
| `CanPlayerBeAssignedToArea(string, string)` | `boolean` | Returns true if the Player can be assigned to an Assignable Area with an optional area group key. | None |
| `FindAreaByAncestors(CoreObject)` | `string` | Locates an Area by searching upward from the provided CoreObject and returns the Area ID if found. | None |
| `FindAreaByAssignKey(string)` | `string` | Returns and Area ID for an Area that matches the provided assign key. | None |
| `FindAreaByName(string)` | `string` | Returns and Area ID for an Area that matches the provided name. | None |
| `GetAllAreas()` | `Array<string>` | Returns all registered Areas. | None |
| `GetAllAssignableAreas(string)` | `Array<string>` | Returns all Area IDs under a specific Assignable Area Group. | None |
| `GetAndAssignArea(string, string|nil, string|nil)` | `string` | Given a key, this function will either find an 'assignable' area that has the same key, or find an empty 'assignable' area and assign it to this key. Returns the Area ID if one is found or assigned. | None |
| `GetArea(string)` | `table` | Returns an Area. | None |
| `GetAreaState(string)` | `table` | Returns the state of an Area. | None |
| `GetPlayerArea(Player)` | `string` | Returns the Area ID of the Area the Player is currently in. | None |
| `GetPlayersInArea(string)` | `table` | Returns all Players in a specific Area. | None |
| `IsInAssignableAreaGroup(CoreObject, string|nil)` | `boolean` | Returns true if the Area is part of an assignable Areas group. | None |
| `IsPlayerInArea(Player, string)` | `boolean` | Returns true if the Player is in the provided Area. | None |
| `LockPlayer(Player)` | `None` | Restricts Player movement. | None |
| `RegisterArea(string, table)` | `None` | Registers an Area. | None |
| `RegisterAssignableAreaGroup(string, string, integer)` | `None` | Registers an assignable Area group. | None |
| `SendPlayerToArea(Player, string)` | `None` | Assigns a Player to a specific Area. | None |
| `UnlockPlayer(Player)` | `None` | Allows a Player to move. | None |

## Examples

Example using:

### `GetPlayersInArea`

### `PlayerAreaChanged`

In this example, players in a specific area will get 5 coins per pickup. For example, going to the Quarry area could give players bonus coins just for that area.

```lua
-- Server script.
local AREAS = require(script:GetCustomProperty("APIAreas"))
local ITEM_PICKUPS = require(script:GetCustomProperty("APIItemPickups"))
local CURRENCY = require(script:GetCustomProperty("APICurrency"))

local TO_AREA = script:GetCustomProperty("ToArea"):WaitForObject()

local currencyId = "coins"
local currencyAmount = 5
local players = {}

local function OnPlayerAreaChanged(player, areaId)
    local muid, area = CoreString.Split(TO_AREA.id, ":")

    if areaId == TO_AREA.id then
        players[player.id] = true
    else
        players[player.id] = false
    end

    print(string.format("Total players in %s area: %s", area, #AREAS.GetPlayersInArea(areaId)))
end

local function OnItemPickupItems(player)
    if players[player.id] then
        CURRENCY.AddCurrencyAmount(player, currencyId, currencyAmount)
    end
end

local function OnPlayerJoined(player)
    players[player.id] = false
end

local function OnPlayerLeft(player)
    players[player.id] = nil
end

Events.Connect(AREAS.Events.PlayerAreaChanged, OnPlayerAreaChanged)
Events.ConnectForPlayer(ITEM_PICKUPS.Events.PickupItems, OnItemPickupItems)

Game.playerJoinedEvent:Connect(OnPlayerJoined)
Game.playerLeftEvent:Connect(OnPlayerLeft)
```

See Also: [ItemPickups.OnItemPickupItems](itempickups.md) | [Currency.AddCurrencyAmount](currency.md)
