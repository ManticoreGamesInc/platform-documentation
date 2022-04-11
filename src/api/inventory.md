---
id: inventory
name: Inventory
title: Inventory
tags:
    - API
---

# Inventory

Inventory is a CoreObject that represents a container of InventoryItems. Items can be added directly to an inventory, picked up from an ItemObject in the world, or transferred between inventories. An Inventory may be assigned to a Player, and Players may have any number of Inventories.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `owner` | [`Player`](player.md) | The Player who currently owns the inventory. May be `nil`. Change owners with `Assign()` or `Unassign()`. | Read-Only |
| `slotCount` | `integer` | The number of unique inventory item stacks this inventory can hold. Zero or negative numbers indicate no limit. | Read-Only |
| `emptySlotCount` | `integer` | The number of slots in the inventory that do not contain an inventory item stack. | Read-Only |
| `occupiedSlotCount` | `integer` | The number of slots in the inventory that contain an inventory item stack. | Read-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Assign(Player player)` | `None` | Sets the owner property of the inventory to the specified player. When a networked inventory is assigned to a player, only that player's client will be able to access the inventory contents. | None |
| `Unassign()` | `None` | Clears the owner property of the inventory. The given inventory will now be accessible to all clients. | None |
| `GetItem(integer slot)` | [`InventoryItem`](inventoryitem.md) | Returns the contents of the specified slot. Returns `nil` if the slot is empty. | None |
| `GetItems([table parameters])` | `table` | Returns a table mapping integer slot number to the inventory item in that slot. Note that this may leave gaps in the table if the inventory contains empty slots, so use with `ipairs()` is not recommended. Returns an empty table if the inventory is empty. <br/>Supported parameters include: <br/>`itemAssetId (string)`: If specified, filters the results by the specified item asset reference. Useful for getting all inventory items of a specific type. | None |
| `ClearItems()` | `None` | Removes all items from the inventory. | None |
| `SortItems()` | `None` | Reorganizes inventory items into sequential slots starting with slot 1. Does not perform any consolidation of item stacks of the same type. Use `ConsolidateItems()` first if this behavior is desired. | None |
| `ConsolidateItems()` | `None` | Combines stacks of inventory items into as few slots as possible based on the `maximumStackCount` of each item. Slots may be emptied by this operation, but are otherwise not sorted or reorganized. | None |
| `CanResize(integer newSize)` | `boolean` | Checks if there are enough slots for all current contents of the inventory if the inventory were to be resized. Returns `true` if the inventory can be resized to the new size or `false` if it cannot. | None |
| `Resize(integer newSize)` | `boolean` | Changes the number of slots of the inventory. There must be enough slots to contain all of the items currently in the inventory or the operation will fail. This operation will move items into empty slots if necessary, but it will not consolidate item stacks, even if doing so would create sufficient space for the operation to succeed. Use `ConsolidateItems()` first if this behavior is desired. Returns `true` if the operation succeeded. Returns `false` and logs a warning if the operation failed. | None |
| `CanAddItem(string itemAssetId, [table parameters])` | `boolean` | Checks for room to add the specified item to this inventory. If the item can be added to the inventory, returns `true`. If the inventory is full or the item otherwise cannot be added, returns `false`. Supports the same parameters as `AddItem()`. | None |
| `AddItem(string itemAssetId, [table parameters])` | `boolean` | Attempts to add the specified item to this inventory. If the item was successfully added to the inventory, returns `true`. If the inventory was full or the item otherwise wasn't added, returns `false`. <br/>Supported parameters include: <br/>`count (integer)`: Specifies the number of items to create and add to the inventory. Defaults to 1. <br/>`slot (integer)`: Attempts to create the item directly into the specified slot. If unspecified, the inventory will either look to stack this item with other items of the same `itemAssetId`, or will look to find the first empty slot. <br/>`customProperties (table)`: Applies initial property values to any dynamic properties on the item. Attempting to specify a property that does not exist will yield a warning. Attempting to specify a property that does exist and is not dynamic will raise an error. Providing a property value of the incorrect type will raise an error. | None |
| `CanPickUpItem(ItemObject item, [table parameters])` | `boolean` | Checks for room in an existing stack or free inventory slots to add the given item to the inventory. If the item can be added to the inventory, returns `true`. If the inventory is full or the item otherwise cannot be added, returns `false`. Supports the same parameters as `PickUpItem()`. | None |
| `PickUpItem(ItemObject item, [table parameters])` | `boolean` | Creates an inventory item from an ItemObject that exists in the world, taking 1 count from the ItemObject. Destroys the ItemObject if the inventory item is successfully created and the ItemObject count has been reduced to zero. Returns `true` if the item was picked up. Returns `false` and logs a warning if the item could not be picked up. <br/>Supported parameters include: <br/>`count (integer)`: Determines the number of items taken from the specified ItemObject. If the ItemObject still has a count greater than zero after this operation, it is not destroyed. Defaults to 1. <br/>`all (boolean)`: If `true`, picks up all of the given item's count instead of just 1. Overrides `count` if both are specified. | None |
| `CanMoveFromSlot(integer fromSlot, integer toSlot, [table parameters])` | `boolean` | Checks if an item can be moved from one slot to another. If the item can be moved, returns `true`. Returns `false` if it cannot be moved. Supports the same parameters as `MoveFromSlot()`. | None |
| `MoveFromSlot(integer fromSlot, integer toSlot, [table parameters])` | `boolean` | Moves an inventory item and its entire count from one slot to another. If the target slot is empty, the stack is moved. If the target slot is occupied by a matching item, the stack will merge as much as it can up to its `maximumStackCount`. If the target slot is occupied by a non-matching item, the stacks will swap. Returns `true` if the operation succeeded. Returns `false` and logs a warning if the operation failed. <br/>Supported parameters include: <br/>`count (integer)`: Specifies the number of items to move. When swapping with another stack containing a non-matching item, this operation will fail unless `count` is the entire stack. | None |
| `CanRemoveItem(string itemAssetId, [table parameters])` | `boolean` | Checks if an item can be removed from the inventory. If the item can be removed, returns `true`. Returns `false` if it cannot be removed. Supports the same parameters as `RemoveItem()`. | None |
| `RemoveItem(string itemAssetId, [table parameters])` | `boolean` | Deletes 1 item of the specified asset from the inventory. Returns `true` if the operation succeeded. Returns `false` and logs a warning if the operation failed. <br/>Supported parameters include: <br/>`count (integer)`: Specifies the number of the item to be removed. Defaults to 1. <br/>`all (boolean)`: If `true`, removes all of the specified items instead of just 1. Overrides `count` if both are specified. | None |
| `CanRemoveFromSlot(integer slot, [table parameters])` | `boolean` | Checks if an item can be removed from an inventory slot. If the item can be removed, returns `true`. Returns `false` if it cannot be removed. Supports the same parameters as `RemoveFromSlot()`. | None |
| `RemoveFromSlot(integer slot, [table parameters])` | `boolean` | Deletes the inventory item and its entire count from the specified inventory slot. Returns `true` if the operation succeeded. Returns `false` and logs a warning if the operation failed. <br/>Supported parameters include: <br/>`count (integer)`: Specifies the number of the item to be removed. Defaults to the total count in the specified slot. | None |
| `CanDropItem(string itemAssetId, [table parameters])` | `boolean` | Checks if an item can be dropped from the inventory. If the item can be dropped, returns `true`. Returns `false` if it cannot be dropped. Supports the same parameters as `DropItem()`. | None |
| `DropItem(string itemAssetId, [table parameters])` | `boolean` | Removes 1 item of the specified asset from the inventory and creates an ItemObject with the item's properties. Spawns the ItemObject at the position of the inventory in the world, or at the position of the owner player's feet if the inventory has been assigned to a player. Returns `true` if the operation succeeded. Returns `false` and logs a warning if the operation failed. <br/>Supported parameters include: <br/>`count (integer)`: Specifies the number of the item to be dropped. Defaults to 1. <br/>`all (boolean)`: If `true`, drops all of the specified items instead of just 1. Overrides `count` if both are specified. <br/>`dropTo (ItemObject)`: Specifies a pre-existing ItemObject to drop the items onto. Doing this will add to that ItemObject's count. If the ItemObject's maximum stack count would be exceeded by this operation, it will fail, and this function will return false. <br/>`parent (CoreObject)`: Creates the new ItemObject as a child of the specified CoreObject. Can only be used if `dropTo` is not specified. <br/>`position (Vector3)`: Specifies the world position at which the ItemObject is spawned, or the relative position if a parent is specified. Can only be used if `dropTo` is not specified. <br/>`rotation (Rotation or Quaternion)`: Specifies the world rotation at which the ItemObject is spawned, or the relative rotation if a parent is specified. Can only be used if `dropTo` is not specified. <br/>`scale (Vector3)`: Specifies the world scale with which the ItemObject is spawned, or the relative scale if a parent is specified. Can only be used if `dropTo` is not specified. <br/>`transform (Transform)`: Specifies the world transform at which the ItemObject is spawned, or the relative transform if a parent is specified. Can only be used if `dropTo` is not specified, and is mutually exclusive with `position`, `rotation`, and `scale`. <br/>Additional parameters supported by `World.SpawnAsset()` may also be supported here. | None |
| `CanDropFromSlot(integer slot, [table parameters])` | `boolean` | Checks if an item can be dropped from an inventory slot. If the item can be dropped, returns `true`. Returns `false` if it cannot be dropped. Supports the same parameters as `DropFromSlot()`. | None |
| `DropFromSlot(integer slot, [table parameters])` | `boolean` | Drops the entire contents of a specified slot, creating an ItemObject with the item's properties. Spawns the ItemObject at the position of the inventory in the world, or at the position of the owner player's feet if the inventory has been assigned to a player. Returns `true` if the operation succeeded. Returns `false` and logs a warning if the operation failed. If the full item count is successfully dropped, the slot will be left empty.<br/>Supported parameters include: <br/>`count (integer)`: Specifies the number of the item to be dropped. If not specified, the total number of items in this slot will be dropped. <br/>`dropTo (ItemObject)`: Specifies a pre-existing ItemObject to drop the items onto. Doing this will add to that ItemObject's count. If the ItemObject's max stack count would be exceeded by this operation, it will fail, and this function will return false. <br/>`parent (CoreObject)`: Creates the new ItemObject as a child of the specified CoreObject. Can only be used if `dropTo` is not specified. <br/>`position (Vector3)`: Specifies the world position at which the ItemObject is spawned, or the relative position if a parent is specified. Can only be used if `dropTo` is not specified. <br/>`rotation (Rotation or Quaternion)`: Specifies the world rotation at which the ItemObject is spawned, or the relative rotation if a parent is specified. Can only be used if `dropTo` is not specified. <br/>`scale (Vector3)`: Specifies the world scale with which the ItemObject is spawned, or the relative scale if a parent is specified. Can only be used if `dropTo` is not specified. <br/>`transform (Transform)`: Specifies the world transform at which the ItemObject is spawned, or the relative transform if a parent is specified. Can only be used if `dropTo` is not specified, and is mutually exclusive with `position`, `rotation`, and `scale`. <br/>Additional parameters supported by `World.SpawnAsset()` may also be supported here. | None |
| `CanGiveItem(string itemAssetId, Inventory recipient, [table parameters])` | `boolean` | Checks if an item can be transferred to the specified recipient inventory. If the item can be transferred, returns `true`. Returns `false` if it cannot be transferred. Supports the same parameters as `GiveItem()`. | None |
| `GiveItem(string itemAssetId, Inventory recipient, [table parameters])` | `boolean` | Transfers an item, specified by item asset ID, from this inventory to the given recipient inventory. Returns `true` if the operation succeeded. Returns `false` and logs a warning if the operation failed. <br/>Supported parameters include: <br/>`count (integer)`: Specifies the number of the item to be transferred. Defaults to 1. <br/>`all (boolean)`: If `true`, transfers all of the specified items instead of just 1. Overrides `count` if both are specified. | None |
| `CanGiveFromSlot(integer slot, Inventory recipient, [table parameters])` | `boolean` | Checks if a slot can be transferred to the specified recipient inventory. If the item can be transferred, returns `true`. Returns `false` if it cannot be transferred. Supports the same parameters as `GiveFromSlot()`. | None |
| `GiveFromSlot(integer slot, Inventory recipient, [table parameters])` | `boolean` | Transfers the entire stack of a given slot to the given recipient inventory. Returns `true` if the operation succeeded. Returns `false` and logs a warning if the operation failed. <br/>Supported parameters include: <br/>`count (integer)`: Specifies the number of the item to be transferred. If not specified, the total number of items in this slot will be transferred. | None |

## Events

| Event Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `ownerChangedEvent` | [`Event`](event.md)<[`Inventory`](inventory.md) inventory> | Fired when the inventory's owner has changed. | None |
| `resizedEvent` | [`Event`](event.md)<[`Inventory`](inventory.md) inventory> | Fired when the inventory's size has changed. | None |
| `changedEvent` | [`Event`](event.md)<[`Inventory`](inventory.md) inventory, `integer` slot> | Fired when the contents of an inventory slot have changed. This includes when the item in that slot is added, given, received, dropped, moved, resized, or removed. | None |
| `itemPropertyChangedEvent` | [`Event`](event.md)<[`Inventory`](inventory.md) inventory, [`InventoryItem`](inventoryitem.md) item, `string` propertyName> | Fired when an inventory item's dynamic custom property value has changed. | None |

## Examples

Example using:

### `itemPropertyChangedEvent`

### `GetItems`

In this example, a pair of server/client scripts are placed under an Inventory. If any of the inventory items has a dynamic custom property called "Freshness", then that item becomes less fresh over time, until the "Freshness" property reaches zero. The server script is responsible for changing the freshness, while the client script listens for the changes and prints them to the Event Log.

```lua
-- SERVER SCRIPT:
local INVENTORY = script:FindAncestorByType("Inventory")
local DECAY_PERIOD = 5

function Tick()
    Task.Wait(DECAY_PERIOD)

    for _,item in pairs(INVENTORY:GetItems()) do
        local value, hasProperty = item:GetCustomProperty("Freshness")
        if hasProperty and value > 0 then
            item:SetCustomProperty("Freshness", value - 1)
        end
    end
end

-- CLIENT SCRIPT:
local INVENTORY = script:FindAncestorByType("Inventory")

function OnPropertyChanged(inventory, item, propertyName)
    local value = item:GetCustomProperty(propertyName)

    print("Item ".. item.name ..":".. propertyName .." = ".. tostring(value))

    if propertyName == "Freshness" then
        if value == 1 then
            print("One of your items is almost rotten!")

        elseif value == 0 then
            print(item.name .." is now rotten.")
        end
    end
end

INVENTORY.itemPropertyChangedEvent:Connect(OnPropertyChanged)
```

See also: [InventoryItem.SetCustomProperty](inventoryitem.md) | [CoreObject.FindAncestorByType](coreobject.md) | [Task.Wait](task.md)

---

Example using:

### `Assign`

In this example each player is given an inventory when they join the game. The inventory is a template with networking enabled and is assigned as a custom property to the script.

```lua
local INVENTORY_TEMPLATE = script:GetCustomProperty("Inventory")

function OnPlayerJoined(player)
    local inventory = World.SpawnAsset(INVENTORY_TEMPLATE)
    player.serverUserData.inventory = inventory

    inventory:Assign(player)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

See also: [CoreObject.GetCustomProperty](coreobject.md) | [World.SpawnAsset](world.md) | [Player.serverUserData](player.md) | [Game.playerJoinedEvent](game.md)

---

Example using:

### `CanDropFromSlot`

### `DropFromSlot`

This example shows how to drop items from a player's inventory. When the player presses the 1 or 2 keys, any items found in their inventory's slots 1 or 2 are dropped to the ground.

```lua
-- Add binding set action names as custom properties.
local SLOT1_ACTION = script:GetCustomProperty("Slot1Action")
local SLOT2_ACTION = script:GetCustomProperty("Slot2Action")

function DropItemFromSlot(player, slotNumber)
    local inventory = player:GetInventories()[1]
    if not inventory then return end

    local deltaZ = 100
    if player.isCrouching then
         deltaZ = 50
    end

    local params = {
        count = 1,
        position = player:GetWorldPosition() - Vector3.UP * deltaZ
    }

    if inventory:CanDropFromSlot(slotNumber, params) then
        inventory:DropFromSlot(slotNumber, params)
    end
end

function OnActionPressed(player, action)
    if action == SLOT1_ACTION then
        DropItemFromSlot(player, 1)
    elseif action == SLOT2_ACTION then
        DropItemFromSlot(player, 2)
    end
end

Input.actionPressedEvent:Connect(OnActionPressed)
```

See also: [Player.GetInventories](player.md) | [Game.playerJoinedEvent](game.md) | [Input.actionPressedEvent](input.md) | [CoreObject.GetCustomProperty](coreobject.md) | [Vector3.UP](vector3.md)

---

Example using:

### `CanMoveFromSlot`

### `MoveFromSlot`

In games with more complex inventories players will want to reorganize their items. In this example, we implement a "Move" operation by using a server event with `Events.ConnectForPlayer()`. This allows a client UI script to react to input and call `Events.BroadcastToServer("MoveItemStack", fromSlot, toSlot)`.

```lua
function OnMove(player, fromSlot, toSlot)
    local inventory = player:GetInventories()[1]

    if inventory:CanMoveFromSlot(fromSlot, toSlot) then
        inventory:MoveFromSlot(fromSlot, toSlot)
    end
end

Events.ConnectForPlayer("MoveItemStack", OnMove)
```

See also: [Player.GetInventories](player.md) | [Events.ConnectForPlayer](events.md)

---

Example using:

### `CanPickUpItem`

### `PickUpItem`

This example shows how to pick up items and add them to a player's inventory. The trigger is part of the template that is assigned to the `Item Asset`, in its property `Item Template`.

```lua
local TRIGGER = script:GetCustomProperty("Trigger"):WaitForObject()

function PickUpItem(player, itemObject)
    local inventory = player:GetInventories()[1]
    if not inventory then return end

    local params = {all = true}

    if inventory:CanPickUpItem(itemObject, params) then
        inventory:PickUpItem(itemObject, params)
    end
end

function OnBeginOverlap(_, player)
    if player:IsA("Player") then
        local item = TRIGGER:FindAncestorByType("ItemObject")
        PickUpItem(player, item)
    end
end

TRIGGER.beginOverlapEvent:Connect(OnBeginOverlap)
```

See also: [Player.GetInventories](player.md) | [Trigger.beginOverlapEvent](trigger.md) | [CoreObject.FindAncestorByType](coreobject.md) | [Other.IsA](other.md)

---

Example using:

### `CanRemoveFromSlot`

### `RemoveFromSlot`

### `GetItem`

Some games may want to offer a "Scrap" operation to players, which destroyes items in exchange for some resource. The type of resource is defined as a custom property. In this example we implement a Scrap operation by using a server event with `Events.ConnectForPlayer()`. This allows a client UI script to react to a button press and call `Events.BroadcastToServer("ScrapItem", slotNumber)`.

```lua
local RESOURCE_NAME = script:GetCustomProperty("ScrapResourceName")

function Scrap(inventory, slotNumber)
    if inventory:CanRemoveFromSlot(slotNumber) then
        local item = inventory:GetItem(slotNumber)
        local resourceGain = item.count

        inventory:RemoveFromSlot(slotNumber)

        return resourceGain
    end
    return 0
end

function OnScrapItem(player, slotNumber)
    local inventory = player:GetInventories()[1]
    local resourceGain = Scrap(inventory, slotNumber)
    player:AddResource(RESOURCE_NAME, resourceGain)
end

Events.ConnectForPlayer("ScrapItem", OnScrapItem)
```

See also: [InventoryItem.count](inventoryitem.md) | [Player.AddResource](player.md) | [CoreObject.GetCustomProperty](coreobject.md) | [Events.ConnectForPlayer](events.md)

---

Example using:

### `ClearItems`

In this example, when a player dies they lose all items that were in all of their inventories.

```lua
function OnPlayerDied(player, _)
    for _,inventory in ipairs(player:GetInventories()) do
        inventory:ClearItems()
    end
end

Game.playerJoinedEvent:Connect(function(player)
    player.diedEvent:Connect(OnPlayerDied)
end)
```

See also: [Player.GetInventories](player.md) | [Game.playerJoinedEvent](game.md)

---

Example using:

### `ConsolidateItems`

### `SortItems`

Depending on the game it can be a good idea to offer a "Compact" operation to players, where the items in their inventory will sort to the top and different stacks of the same item will combine. In this example we implement a Compact operation by using a server event with `Events.ConnectForPlayer()`. This allows a client UI script to react to a button press and call `Events.BroadcastToServer("CompactInventories")`.

```lua
function Compact(inventory)
    inventory:ConsolidateItems()
    inventory:SortItems()
end

function OnCompactInventories(player)
    for _,inventory in ipairs(player:GetInventories()) do
        Compact(inventory)
    end
end

Events.ConnectForPlayer("CompactInventories", OnCompactInventories)
```

See also: [Player.GetInventories](player.md) | [Events.ConnectForPlayer](events.md)

---

Example using:

### `GetItem`

### `slotCount`

### `changedEvent`

In this example, a client script prints to the Event Log all the contents of the local player's inventory. If the inventory contents change, the new list of contents is printed. In case the player has more than one inventory only the first one will be printed.

```lua
local VERBOSE = false
local player = Game.GetLocalPlayer()
local currentInventory = nil

function RefreshInventoryUI()
    print("\nInventory:")

    for i = 1, currentInventory.slotCount do
        local item = currentInventory:GetItem(i)
        if item then
            print(item.name .." x"..item.count)

            if VERBOSE then
                print("  itemAssetId: "..item.itemAssetId)
                print("  itemTemplateId: "..item.itemTemplateId)
                print("  maxStackCount: "..item.maximumStackCount)
                print("  inventory: "..item.inventory.name)
                print("  slot: "..item.slot)
            end
        end
    end
end

while currentInventory == nil do
    currentInventory = player:GetInventories()[1]
    if currentInventory then
        currentInventory.changedEvent:Connect(RefreshInventoryUI)
        RefreshInventoryUI()
    else
        Task.Wait()
    end
end
```

See also: [InventoryItem.itemAssetId](inventoryitem.md) | [Player.GetInventories](player.md) | [Task.Wait](task.md) | [Game.GetLocalPlayer](game.md)

---

Example using:

### `occupiedSlotCount`

### `GetItem`

In this example, we periodically check how many inventories each player has and print the result to the Event Log.

```lua
function Tick()
    for _,player in ipairs(Game.GetPlayers()) do
        local inventories = player:GetInventories()
        local totalItems = 0
        for _,inventory in ipairs(inventories) do
            totalItems = totalItems + ComputeItemCount(inventory)
        end
        print(player.name.." has "..totalItems.." items across "..#inventories .." inventories.")
    end
    Task.Wait(3)
end

function ComputeItemCount(inventory)
    if inventory.occupiedSlotCount == 0 then return 0 end
    local total = 0
    for i = 1, inventory.occupiedSlotCount do
        local item = inventory:GetItem(i)
        if item then
            total = total + item.count
        end
    end
    return total
end
```

See also: [Player.GetInventories](player.md) | [InventoryItem.count](inventoryitem.md) | [Game.GetPlayers](game.md)

---

Example using:

### `owner`

### `slotCount`

### `Unassign`

### `CanGiveFromSlot`

### `GiveFromSlot`

### `ownerChangedEvent`

In this example, a player's entire inventory object drops when they die. For it to work, the inventory template should have a trigger child object, as well as a visual element (for example, a crate) so that other players can see it after it drops.

```lua
local INVENTORY_TEMPLATE = script:GetCustomProperty("InventoryWithPickup")

function OnPlayerDied(player, dmg)
    -- The player's inventory is dropped upon death
    local inventory = player.serverUserData.inventory
    player.serverUserData.inventory = nil
    inventory:Unassign()
    inventory:SetWorldPosition(player:GetWorldPosition())
end

function OnInteracted(trigger, player)
    -- Dead players cannot pickup an inventory
    if player.isDead then return end

    local inventory = trigger.parent
    if player.serverUserData.inventory == nil then
        -- The player picks up the inventory
        inventory:Assign(player)
        player.serverUserData.inventory = inventory

    elseif inventory.slotCount >= 1 then
        -- They already have an inventory. Transfer the items
        local targetInventory = player.serverUserData.inventory
        for i = 1,inventory.slotCount do
            if inventory:CanGiveSlot(i, targetInventory) then
                inventory:GiveSlot(i, targetInventory)
            end
        end
    end
end

function OnOwnerChanged(inventory)
    if Object.IsValid(inventory.owner) then
        -- Hide the inventory
        inventory.serverUserData.trigger.isInteractable = false
        inventory.visibility = Visibility.FORCE_OFF
    else
        -- Show the inventory
        inventory.serverUserData.trigger.isInteractable = true
        inventory.visibility = Visibility.INHERIT
    end
end

function OnPlayerJoined(player)
    -- Spawn inventory object
    local inventory = World.SpawnAsset(INVENTORY_TEMPLATE)
    -- Find the trigger
    local trigger = inventory:FindDescendantByType("Trigger")
    inventory.serverUserData.trigger = trigger
    -- Connect events
    player.diedEvent:Connect(OnPlayerDied)
    inventory.ownerChangedEvent:Connect(OnOwnerChanged)
    trigger.interactedEvent:Connect(OnInteracted)
    -- Assign to player
    player.serverUserData.inventory = inventory
    inventory:Assign(player)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

See also: [CoreObject.FindDescendantByType](coreobject.md) | [Player.diedEvent](player.md) | [Trigger.interactedEvent](trigger.md) | [World.SpawnAsset](world.md) | [Game.playerJoinedEvent](game.md)

---

Example using:

### `slotCount`

### `GetItems`

### `Resize`

### `AddItem`

This example demonstrates how to save and load an inventory from storage.

```lua
local INVENTORY_TEMPLATE = script:GetCustomProperty("Inventory")

function SaveInventory(player, inventory)
    -- Serialize
    local inventoryData = {}
    for i,item in pairs(inventory:GetItems()) do
        inventoryData[item.itemAssetId] = item.count
    end
    -- Save to storage
    local data = Storage.GetPlayerData(player)
    data.inventory = inventoryData
    data.inventorySize = inventory.slotCount
    Storage.SetPlayerData(player, data)
end

function LoadInventory(player)
    local inventory = World.SpawnAsset(INVENTORY_TEMPLATE)
    -- Load from storage
    local data = Storage.GetPlayerData(player)
    -- Parse
    if data.inventorySize and data.inventory then
        inventory:Resize(data.inventorySize)
        for assetId,itemCount in pairs(data.inventory) do
            inventory:AddItem(assetId, {count = itemCount})
        end
    end
    return inventory
end

function OnPlayerJoined(player)
    local inventory = LoadInventory(player)
    player.serverUserData.inventory = inventory

    inventory:Assign(player)
end

function OnPlayerLeft(player)
    local inventory = player.serverUserData.inventory
    SaveInventory(player, inventory)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
Game.playerLeftEvent:Connect(OnPlayerLeft)
```

See also: [InventoryItem.itemAssetId](inventoryitem.md) | [Storage.GetPlayerData](storage.md) | [Player.serverUserData](player.md) | [World.SpawnAsset](world.md) | [Game.playerLeftEvent](game.md)

---
