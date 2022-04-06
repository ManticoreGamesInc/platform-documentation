---
id: crafting
name: Crafting
title: Crafting
---

# Crafting

The Crafting system can be used to turn one thing into another over a period of time. This can be done at individual Crafting Stations or through a screen not associated to a station.

## Events

| Event Name | Return Type | Description | Tags |
| ---------- | ----------- | ----------- | ---- |
| `CraftingCollected` | `Event<craftingStationId, recipeId, amount>` | Sent when a crafted Recipe is collected from a Crafting Station or Global crafting. | Client |
| `CraftingReadyForCollect` | `Event<craftingStationId, recipeId, amount>` | Sent when a Crafting Station or Global crafting finishes crafting a Recipe. | Client |
| `CraftingReset` | `Event<craftingStationId>` | Sent when a Crafting Station is reset. This can happen during load for Crafting Stations being used by | Server |
| `StartedCrafting` | `Event<craftingStationId, recipeId, amount>` | Sent when a Crafting Station or Global crafting starts crafting a Recipe. | Client |

## Functions

| Class Function Name | Return Type | Description | Tags |
| ------------------- | ----------- | ----------- | ---- |
| `CanCollect(Player, string)` | `string`, `boolean` | Returns true if the Player can collect from the Crafting Station or global crafting. Returns false and an error message if they cannot. | None |
| `CanCraft(Player, string|nil, string, integer)` | `boolean` | Returns true if the Player can craft a Recipe at the Crafting Station if one is provided, otherwise checks against global crafting status if that is allowed. | None |
| `Collect(Player, string)` | `None` | Collect a finished Recipe. | None |
| `FindCraftingStationIdByAncestors(CoreObject)` | `string` | Returns a Crafting Station id if one exists in the targets ancestors. | None |
| `GetCraftRate(string)` | `number` | Returns the craft rate for a Recipe on a Crafting Station. | None |
| `GetCraftingState(string)` | `None` | Returns the global crafting state. | None |
| `GetCraftingStationData()` | `None` | None | None |
| `GetCraftingStationId(CoreObject, table|nil)` | `string` | Returns an id formatted as a Crafting Station id for a target object if possible. | None |
| `GetCraftingStationState(string)` | `CraftingStationState` | Returns the state of a Crafting Station. | None |
| `GetOutputText()` | `None` | None | None |
| `GetRecipeData()` | `None` | None | None |
| `GetRecipeIdByStorageId()` | `None` | None | None |
| `GetRecipeStorageIdByRecipeId()` | `None` | None | None |
| `GetSetting(integer)` | `None` | Gets a crafting setting. | None |
| `GetValidRecipeIds(string)` | `None` | Returns a table of recipe ids that can be crafted on the crafting station. | None |
| `IsCrafting(Player, string|nil)` | `None` | Returns true if the crafting station is currently crafting a recipe. If craftingStationId is nil then the global crafting state will be checked. | None |
| `IsCraftingStationRegistered(string)` | `boolean` | Returns true if the Crafting Station has been registered. | None |
| `IsPlayerUsing(Player, string)` | `boolean` | Returns true if the Player is currently using the Crafting Station. | None |
| `RegisterCraftingStation(string, table)` | `None` | Registers a Crafting Station to the system. | None |
| `ResetCrafting(Player)` | `None` | Resets Crafting state for a Player. | None |
| `SetSettings(table)` | `None` | Sets crafting settings. | None |
| `StartCrafting(Player, string|nil, string, integer)` | `None` | Starts crafting a recipe. If craftingStationId is nil then the global crafting state will be used. | None |
| `UnregisterCraftingStation(string)` | `None` | When destroying a Crafting Station it is important to unregister it. | None |
