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
| `ResetColor()` | `None` | Resets the color of this slot to the original value. | None |
| `ResetUVTiling()` | `None` | Resets the U and V tiling to their original values. | None |
| `ResetIsSmartMaterial()` | `None` | Resets whether or not this is used as a smart material. | None |
| `ResetMaterialAssetId()` | `None` | Resets this to the original material asset. | None |

## Examples

Example using:

### `isSmartMaterial`

### `materialAssetId`

### `GetColor`

### `SetColor`

### `GetUVTiling`

### `SetUVTiling`

In this example, the materials from one object are copied onto another object. Different object types may have different material slot names, in which case it won't copy.

```lua
local STATIC_MESH_A = script:GetCustomProperty("StaticMeshA"):WaitForObject()
local STATIC_MESH_B = script:GetCustomProperty("StaticMeshB"):WaitForObject()

function CopyMaterialSlot(slotA, slotB)
    slotB.isSmartMaterial = slotA.isSmartMaterial
    slotB.materialAssetId = slotA.materialAssetId
    slotB:SetColor(slotA:GetColor())
    slotB:SetUVTiling(slotA:GetUVTiling())
end

function CopyMaterials(meshA, meshB)
    for _,slotA in ipairs(meshA:GetMaterialSlots()) do
        local slotB = meshB:GetMaterialSlot(slotA.slotName)
        if slotB then
            CopyMaterialSlot(slotA, slotB)
        end
    end
end

CopyMaterials(STATIC_MESH_A, STATIC_MESH_B)
```

See also: [CoreObject.GetMaterialSlot](coreobject.md) | [CoreObjectReference.WaitForObject](coreobjectreference.md)

---
