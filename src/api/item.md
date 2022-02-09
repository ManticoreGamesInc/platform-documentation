---
id: item
name: Item
title: Item
tags:
    - API
---

# Item

Item is an interface which defines properties and functions for items in an Inventory or spawned in the world.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `itemAssetId` | `string` | Asset ID defining this Item's properties. | Read-Only |
| `itemTemplateId` | `string` | Asset reference that is spawned as a child of an ItemObject when spawned in the world. May be `nil`. | Read-Only |
| `maximumStackCount` | `integer` | The maximum number of items in one stack of this item. Zero or negative numbers indicate no limit. | Read-Only |
| `count` | `integer` | The number of items this object represents. | Read-Write |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetCustomProperties()` | `table` | Returns a table containing the names and values of all custom properties on an Item. | None |
| `GetCustomProperty(string propertyName)` | `value`, `boolean` | Returns the value of a specific custom property or `nil` if the Item does not possess the custom property. The second return value is `true` if the property is found or `false` if it is not. | None |
| `SetCustomProperty(string propertyName, value)` | `boolean` | Sets the value of a custom property. The value must match the existing type of the property. Returns `true` if the property was successfully set. If the property could not be set, returns `false` or raises an error depending on the cause of the failure. | None |
