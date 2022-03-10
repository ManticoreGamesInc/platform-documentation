---
id: inventoryitem
name: InventoryItem
title: InventoryItem
tags:
    - API
---

# InventoryItem

InventoryItem is an Object which implements the [Item](item.md) interface. It represents an Item stored in an Inventory and has no 3D representation in the world.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `itemAssetId` | `string` | Asset ID defining this Item's properties. | Read-Only |
| `itemTemplateId` | `string` | Asset reference that is spawned as a child of an ItemObject when spawned in the world. May be `nil`. | Read-Only |
| `maximumStackCount` | `integer` | The maximum number of items in one stack of this item. Zero or negative numbers indicate no limit. | Read-Only |
| `count` | `integer` | The number of items this object represents. | Read-Write |
| `inventory` | [`Inventory`](inventory.md) | The Inventory which owns this item. | Read-Only |
| `slot` | `integer` | The slot number to which this item has been assigned within its owning Inventory. | Read-Only |
| `name` | `string` | The name of this item, inherited from the Item asset. | Read-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetCustomProperties()` | `table` | Returns a table containing the names and values of all custom properties on this item. Initial values are inherited from the Item asset defining this item. | None |
| `GetCustomProperty(string propertyName)` | `value`, `boolean` | Returns the value of a specific custom property or `nil` if the Item does not possess the custom property. The second return value is `true` if the property is found or `false` if it is not. Initial values are inherited from the Item asset defining this item. | None |
| `IsCustomPropertyDynamic(string propertyName)` | `boolean` | Returns `true` if the named custom property exists and is marked as dynamic. Otherwise, returns `false`. | None |
| `SetCustomProperty(string propertyName, value)` | `boolean` | Sets the value of a custom property. The value must match the existing type of the property. Returns `true` if the property was successfully set. If the property could not be set, returns `false` or raises an error depending on the cause of the failure. | None |

## Examples

Example using:

### `GetCustomProperty`

### `SetCustomProperty`

In this example, a pair of server/client scripts are placed under an Inventory. If any of the inventory items has a dynamic custom property called "Freshness", then that item becomes less fresh over time, until the "Freshness" property reaches zero. The server script is responsible for changing the freshness, while the client script listens for the changes and prints them to the Event Log.

```lua
-- SERVER SCRIPT:
local INVENTORY = script:FindAncestorByType("Inventory")
local DECAY_PERIOD = 5

function Tick()
    Task.Wait(DECAY_PERIOD)
    
    for _,item in ipairs(INVENTORY:GetItems()) do
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

See also: [Inventory.itemPropertyChangedEvent](inventory.md) | [CoreObject.FindAncestorByType](coreobject.md) | [Task.Wait](task.md)

---

Example using:

### `itemAssetId`

### `itemTemplateId`

### `maximumStackCount`

### `count`

### `inventory`

### `slot`

### `name`

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

See also: [Inventory.GetItem](inventory.md) | [Player.GetInventories](player.md) | [Task.Wait](task.md) | [Game.GetLocalPlayer](game.md)

---
