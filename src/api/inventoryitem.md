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
| `SetCustomProperty(string propertyName, value)` | `boolean` | Sets the value of a custom property. The value must match the existing type of the property. Returns `true` if the property was successfully set. If the property could not be set, returns `false` or raises an error depending on the cause of the failure. | None |
