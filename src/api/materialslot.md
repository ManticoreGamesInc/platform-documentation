---
id: materialslot
name: MaterialSlot
title: MaterialSlot
tags:
    - API
---

# MaterialSlot

Contains data about a material slot on a static or animated mesh.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `slotName` | `string` | Reference to a CoreObject or Player impacted. | Read-Only |
| `mesh` | [`CoreMesh`](coremesh.md) | The mesh this MaterialSlot is on. | Read-Only |
| `materialAssetId` | `FString` | The material asset in this slot. | Read-Write |
| `isSmartMaterial` | `boolean` | True if we are using this as a smart material. | Read-Write |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `SetUVTiling(number u, number v)` | `None` | Set the U and V tiling values. | None |
| `SetUVTiling(Vector2 uv)` | `None` | Set the U and V tiling values. | None |
| `GetUVTiling()` | [`Vector2`](vector2.md) | Returns a Vector2 of the U and V tiling values. | None |
| `SetColor(Color)` | `None` | Set the color for this slot. | None |
| `GetColor()` | [`Color`](color.md) | Returns the color of this slot. | None |
