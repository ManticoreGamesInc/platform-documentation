---
id: inventory
name: Inventory
title: Inventory
---

# Inventory

**Inventory** is a drop-in system that provides ready to go Player Inventory management without any code required. It also provides a full API for creators with scripting knowledge to allow them to expand on or change how the Inventory works.

The Inventory comes with a few potential setups. You can use a combined Inventory and Hotbar, Hotbar, or individual Inventory Settings templates to create the Inventory you want for your game.

Inventory items can be dragged and dropped across Inventories. Items can also be dropped into the world or destroyed by being dropped on the trash icon in the provided UI.

Clicking Items that have been configured to be Equipment will optionally equip the item. Other custom actions could be created by listening for the Events that the Inventory broadcasts.

## Events

| Event Name | Return Type | Description | Tags |
| ---------- | ----------- | ----------- | ---- |
| `InventoryAdded` | `Event<[Player](../api/player.md), inventoryId, itemType, itemId, amountData>` | Sent each time an Item is added to an Inventory for a Player. This event sends on the server as well as the | Server |
| `InventoryCleared` | `Event<[Player](../api/player.md), inventoryId, resetToStartingItems>` | Sent each time an Inventory is cleared for a Player. Clearing an Inventory can optionally reset it to have its | Server |
| `InventoryLoaded` | `Event<[Player](../api/player.md), inventoryId>` | Sent when an Inventory is loaded on both server and the client for the Player that loaded the Inventory. | Server |
| `InventoryRegistered` | `Event<inventoryId>` | Sent when an Inventory is registered on the server. Probably not super useful, but could be listened to to | Server |
| `InventoryRemoved` | `Event<[Player](../api/player.md), inventoryId, itemType, itemId, amountData>` | Sent each time an Item is removed from an Inventory for a Player. This event sends on the server as well as | Server |
| `InventorySaved` | `Event<[Player](../api/player.md), inventoryId>` | Sent on the server each time an Inventory for a Player is saved. | Server |
| `InventoryTransferred` | `Event<[Player](../api/player.md), sourceInventoryId, sourceSlotIndex, targetInventoryId, targetSlotIndex>` | Sent each time an Item is moved from one slot to another in the same or to another Inventory for a Player. | Server |
| `InventoryUnregistered` | `Event<inventoryId>` | Sent when an Inventory is unregistered on the server. | Server |
| `SlotClicked` | `Event<[Player](../api/player.md), inventoryId, slotIndex>` | Sent from the provided InventoryScreenSlot when clicked. If a custom UI is created this Event will need to be | Client |
| `SlotDropped` | `Event<[Player](../api/player.md), sourceInventoryId, sourceSlotIndex, dropTargetId, targetInventoryId, targetSlotIndex>` | Sent from the provided InventoryScreenSlot when dropped. If a custom UI is created this Event will need to be | Client |
| `SlotEquipped` | `Event<inventoryId, slotIndex>` | Sent to the client of the Player that equipped the Item in their Inventory. | Client |
| `SlotRightClicked` | `Event<[Player](../api/player.md), inventoryId, slotIndex>` | Sent from the provided InventoryScreenSlot when right-clicked. If a custom UI is created this Event will need to be | Client |
| `SlotUnequipped` | `Event<inventoryId, slotIndex>` | Sent to the client of the Player that unequipped the Item in their Inventory. | Client |

## Functions

| Class Function Name | Return Type | Description | Tags |
| ------------------- | ----------- | ----------- | ---- |
| `AddToInventory(Player, string|nil, integer, string, integer, integer, boolean, boolean)` | `boolean` | Adds an amount of an item to one or More Inventories for a Player. If slotIndex is used this will only use that slot, otherwise it will look for available slots. | None |
| `CanAddItemsToInventory(Player, string|nil, table<string, integer>, boolean)` | `string`, `boolean` | Returns true if the list of Items can fit in the Inventory specified, or in any available Inventories. | None |
| `CanAddToInventory(Player, string, integer, string, integer, integer, boolean)` | `string`, `boolean` | Returns true if an amount of an item can be added to a specific Inventory for a Player. If slotIndex is used this will only check that slot, otherwise, it will look for available slots. | None |
| `CanAddToInventoryFromDrops(Player, string|nil, table, boolean)` | `boolean` | Returns true if a set of Drops can fit in the Inventory specified, or in any available Inventories. | None |
| `CanRemoveFromInventory(Player, string|nil, integer, string, integer, integer, boolean)` | `boolean` | Returns true if an amount of an item can be removed from a specific Inventory for a Player. If slotIndex is used this will  only check that slot, otherwise, it will check the entire Inventory. | None |
| `CanRemoveItemsFromInventory(Player, string|nil, table<string, integer>, boolean)` | `string`, `boolean` | Returns true if the list of Items can be removed from the Inventory specified, or from any available Inventories. | None |
| `CanTransferToInventory(Player, string, integer, string, integer)` | `boolean` | Returns true if a slot can be moved from one Inventory to another, or to another slot in the same Inventory. If targetSlotIndex is not  defined a target slot will be found. | None |
| `ClearAllInventories(Player)` | `None` | Resets all storage keys for inventories from a given player, and clears any inventory data from player storage. | None |
| `ClearInventory(Player, string, boolean, boolean)` | `boolean` | Clears an Inventory for a Player. | None |
| `CreateInventoryData()` | `table` | Creates a default Inventory contents table. | None |
| `GetAmountInInventory(Player, string|nil, integer, string, integer, boolean)` | `integer` | Returns the amount of an item in one or more Inventories for a Player. If slotIndex is used this will only check that slot. | None |
| `GetAvailableSlotIndex(Player, string, integer, string, number, table|nil)` | `integer` | Returns the index of the first available slot for an amount of an item, or 0 if none are found. | None |
| `GetBaseInventoryId(string)` | `string` | Returns the base Inventory Id from a generated container Id. | None |
| `GetContainerItemId(string)` | `string` | Returns the Item Id a container was generated from if a container id is provided. | None |
| `GetFirstEmptySlotIndex(Player, string)` | `integer` | Returns the index of the first empty slot. Will return 0 if no slot is available. | None |
| `GetInventories()` | `table` | Returns all registered Inventories. | None |
| `GetInventory(Player, string)` | `table` | Gets the Inventory contents for a specific Player. | None |
| `GetInventoryIdFromKey(string)` | `string` | Returns the Inventory id associated with an Inventory key. | None |
| `GetInventoryKey(string)` | `string` | Returns the key used for storage and networking for an Inventory. | None |
| `GetItemInSlot(Player, string, integer)` | `table` | Returns the contents of a slot for a Player | None |
| `GetItemType(string)` | `integer` | Returns the ItemType for an Item id. | None |
| `GetPriorityInventoryId(integer, string, integer, integer, boolean, function|nil, boolean)` | `string` | Returns the highest priority Inventory id that can fit the supplied item. Does not include containers. | None |
| `GetRemainingSlotCapacity(Player, string, integer)` | `integer` | Returns the amount of remaining capacity available in a specific slot of an Inventory for a Player. If the slot is empty, it will return the maximum slot capacity. | None |
| `GetSetting(string, InventorySetting)` | `any` | Gets a setting for a specific Inventory. | None |
| `GetSettings(string)` | `table` | Gets the table of all settings for a specific Inventory. | None |
| `GetSlotIndexForItem(Player, string, integer, string)` | `integer` | Returns the index of a slot containing an item. This will return the slot with the smallest amount of the item, or 0 if none are found. | None |
| `GetUniqueContainerId(Player, string|nil, string)` | `string` | Returns a unique(ish) container id. | None |
| `HasAmountInInventory(Player, string|nil, integer, string, integer, integer, boolean)` | `boolean` | Returns true if the Player has the amount of an item in one or more Inventories. If slotIndex is used this will only check that slot. | None |
| `IsAnyInventoryRegistered(boolean)` | `boolean` | Returns true if any Inventory has been registered. | None |
| `IsContainerInventory(string)` | `boolean` | Returns true of the Inventory is a container. | None |
| `IsContainerInventoryId(string)` | `boolean` | Returns true if the Inventory Id is a generated container Id. | None |
| `IsInventoryKey(string)` | `boolean` | Returns true if a string represents an Inventory key. | None |
| `IsInventoryLoaded(Player, string)` | `boolean` | Returns true if the Inventory has been loaded for a specific Player. | None |
| `IsInventoryRegistered(string)` | `boolean` | Returns true if the Inventory has been registered. | None |
| `RegisterInventory(string, boolean)` | `None` | Server Only. Registers and loads an Inventory. | None |
| `RemoveFromInventory(Player, string, integer, string, integer, integer, boolean, boolean)` | `boolean` | Removes an amount of an item from a specific Inventory for a Player. If slotIndex is used this will only check that slot, otherwise  it will check the entire Inventory. | None |
| `TransferToInventory(Player, string, integer, string, integer, boolean)` | `boolean` | Moves the contents of a slot from one Inventory to another, or within the same Inventory. If the target slot has content this will swap  it with the source slot. If targetSlotIndex is not defined a target slot will be found. | None |
| `UnregisterInventory(string)` | `None` | Server Only. Unregisters a Container Inventory. | None |
