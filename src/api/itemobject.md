---
id: itemobject
name: ItemObject
title: ItemObject
tags:
    - API
---

# ItemObject

ItemObject is a CoreObject which implements the [Item](item.md) interface. It represents an Item that has been spawned in the world.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `itemAssetId` | `string` | Asset ID defining this ItemObject's properties. | Read-Only |
| `itemTemplateId` | `string` | Asset reference that is spawned as a child of the ItemObject when spawned in the world. This is inherited from the item asset's Item Template property. May be `nil`. | Read-Only |
| `maximumStackCount` | `integer` | The maximum number of items in one stack of this item. This is inherited from the item asset's Maximum Stack Count property. Zero or negative numbers indicate no limit. | Read-Only |
| `count` | `integer` | The number of items this object represents. | Read-Write |

## Events

| Event Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `changedEvent` | [`Event`](event.md)<[`ItemObject`](itemobject.md)> | Fired when the count or a custom property value of an ItemObject has changed. | None |
