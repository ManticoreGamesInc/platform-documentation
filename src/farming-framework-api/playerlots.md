---
id: player lots
name: Player Lots
title: Player Lots
---

# Player Lots

Player Lots offer a way for creators to define sections in their game that belong to individual Players. Lots can be mixed with several other systems and the main benefits they provide are ownership, permissions and persistence.

A Player can "own" any number of Player Lots, and Lots can exist only while the owner is online, or stay even after they leave the game.

Lots can even be combined with Areas to let you create pools of Area/Lots that dynamically load and unload as Players enter and exit them. This is used to create things like the interior of a Players house that only loads when a Player enters it.

## Functions

| Class Function Name | Return Type | Description | Tags |
| ------------------- | ----------- | ----------- | ---- |
| `CanOwnLot(string, string, boolean)` | `boolean` | Returns true if the Player can own the Lot in question. | None |
| `ClearPlayerLotSaveData(string)` | `None` | Clears save data for a Lot. | None |
| `FindAvailableLots(string|nil, boolean)` | `Array<string>` | Finds all the lots that aren't 'owned' by any Players, or that are owned by offline Players. | None |
| `FindLotByAncestors(CoreObject)` | `string` | Finds the id of the Lot this core object is contained inside. | None |
| `FindLotForOwner(string, string|nil)` | `string` | Find the id of the first Lot for a Player that optionally matches the provided Lot type. | None |
| `FindLotReplicator(string)` | `string` | Finds the id of the first Replicator on a Lot. | None |
| `FindLotReplicatorByIdentifier(string, string)` | `string` | Find the id of the first Replicator on a Lot that has a specific identifier. | None |
| `FindPlayerOwnedLots(string, string|nil)` | `Array<string>` | Returns all the ids for Lots that are owned by a Player, with an optional Lot type filter. | None |
| `GetLotReplicatorIdentifier(string, string)` | `string` | Get the identifier of a Replicator on a Lot. | None |
| `GetLotReplicators()` | `table` | Returns all registered Player Lot Replicators. | None |
| `GetLotRoot(string)` | `CoreObject` | Returns the root object of a Lot. | None |
| `GetLotState(string)` | `LotState` | Returns the state for a Lot. | None |
| `GetLots(string|nil)` | `Array<string>` | Returns a list of all Lot ids with an optional filter on Lot Type. | None |
| `GetOrAssignLot(string, string|nil, boolean)` | `None` | Returns an assigned Lot or assigns the Player as the owner on an available Lot. | None |
| `GetOwner(string)` | `Player` | Returns the owner of a Player Lot. | None |
| `IsOwnerOnly()` | `None` | None | None |
| `RegisterLot(string, any)` | `None` | Registers a Lot. | None |
| `RegisterLotReplicator(string, table)` | `None` | Registers a Replicator on a Lot. | None |
| `ResetLot(string)` | `None` | Resets a Lot. | None |
| `SaveLot(string)` | `None` | Invokes the Save method on all the things inside the lot | None |
| `SetLotActive(string, boolean)` | `None` | Activates or deactivates a Lot. | None |
| `SetLotActiveForPlayer(string, Player, boolean)` | `None` | Activates or deactivates a Lot for a specific Player. | None |
| `SetLotOwner(string, string, boolean)` | `None` | Sets the owner of the Lot. | None |
| `SetMaxOwnedLots(string, integer)` | `None` | Sets a maximum amount of a Lot Type that a Player can own at a time. | None |

## Examples

Example using:

### `FindPlayerOwnedLots`

-- Get all the lots owned by a player.
--

```lua
-- local PLAYER_LOTS = require(script:GetCustomProperty("APIPlayerLots"))
-- local LOCAL_PLAYER = Game.GetLocalPlayer()

-- local function OnTeleportedToLot()
-- print(PLAYER_LOTS.FindLotByAncestors(LOCAL_PLAYER))
-- end

-- Events.Connect(PLAYER_LOTS.Events.TeleportedToLot, OnTeleportedToLot)

--
```
