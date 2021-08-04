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
| `slotName` | `string` | The name of this slot. | Read-Only |
| `mesh` | [`CoreMesh`](coremesh.md) | The mesh this MaterialSlot is on. | Read-Only |
| `materialAssetName` | `string` | The name of the material asset in this slot. | Read-Only |
| `materialAssetId` | `string` | The material asset in this slot. | Read-Write |
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
| `GetCustomMaterial()` | [`CustomMaterial`](custommaterial.md) | Get the custom material in this material slot. This errors if the slot does not have a custom material. | Client-Only |

## Examples

Example using:

### `GetCustomMaterial`

### `GetMaterialSlots`

In this example, the texture of a cube will scroll horizontally. For this example to work, a custom material must be assigned to the first material slot of the cube

```lua
local CUBE = script.parent

-- The amount of time in seconds that has passed
local timePassed = 0

-- Get the first material slot of the "CUBE"
local FirstMaterialSlot = CUBE:GetMaterialSlots()[1]

-- Get the Custom Material applied to this material slot
local CustomMaterial = FirstMaterialSlot:GetCustomMaterial()

function Tick(deltaTime)
    -- Update the "timePassed" with the "deltaTime" to accurately reflect how many seconds have passed
    -- since this script has started running
    timePassed = timePassed + deltaTime

    -- If more than 1 second has passed, reset "timePassed" to 0.
    -- This is done because range of the "u_offset" property is between 0 and 1
    if timePassed > 1 then
        timePassed = 0
    end

    -- Update the UV tiling property for the material slot
    CustomMaterial:SetProperty("u_offset", timePassed)  
end
```

See also: [CustomMaterial.SetProperty](custommaterial.md)

---

Example using:

### `ResetMaterialAssetId`

In this example, the material of a static mesh will repeatedly switch between the original static mesh material and a material assigned to the "CustomMaterial" property of this script.

```lua
-- Asset reference referring to a custom material
local MATERIAL = script:GetCustomProperty("CustomMaterial")

local STATIC_MESH = script.parent

-- Get the first material slot for the static mesh
local FirstMaterialSlot = STATIC_MESH:GetMaterialSlots()[1]

function SwitchMaterials()
    FirstMaterialSlot.materialAssetId = MATERIAL
    Task.Wait(0.5)
    FirstMaterialSlot:ResetMaterialAssetId()
    Task.Wait(0.5)
end

-- Create a task that will switch the material of the "STATIC_MESH"
local switchMaterialTask = Task.Spawn(SwitchMaterials)

-- Force the "switchMaterialTask" task to repeat every 0.5 seconds
switchMaterialTask.repeatInterval = 0.5
-- Force the "switchMaterialTask" task to repeat indefinitely
switchMaterialTask.repeatCount = -1
```

See also: [Task.Spawn](task.md)

---

Example using:

### `SetColor`

In this example, a cube will flash multiple colors.

```lua
local CUBE = script.parent

-- The amount of time in seconds that has passed
local timePassed = 0

-- How quickly the "CUBE" will change color
local CHANGE_SPEED = 5

-- Get the first material slot of the "CUBE"
local FirstMaterialSlot = CUBE:GetMaterialSlots()[1]

function Tick(deltaTime)
    -- Update the "timePassed" with the "deltaTIme" to accurately reflect how many seconds have passed
    -- since this script has started running
    timePassed = timePassed + deltaTime

    -- Calculate the strength of the red, green, and blue channels using three sine waves that are 60 degrees
    -- out of phase with each other
    local redChannel = math.sin((timePassed) * CHANGE_SPEED)
    local greenChannel = math.sin((timePassed + math.pi * 1/3) * CHANGE_SPEED)
    local blueChannel = math.sin((timePassed + math.pi * 2/3) * CHANGE_SPEED)

    -- Create a new color using the red, green, and blue channels
    local newColor = Color.New(redChannel, greenChannel, blueChannel)

    -- Update the color of the first material slot
    FirstMaterialSlot:SetColor(NewColor)    
end
```

See also: [StaticMesh.GetMaterialSlots](staticmesh.md) | [Color.New](color.md)

---

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

Example using:

### `materialAssetId`

In this example the material of a static mesh will change during runtime by using the `materialAssetId` property of a material slot. This script must have an asset reference custom property named "CustomMaterial" that refers to a custom material you created.

```lua
-- Asset reference referring to a material
local MATERIAL = script:GetCustomProperty("CustomMaterial")

local STATIC_MESH = script.parent

-- Get the first material slot of the "STATIC_MESH"
local FirstMaterialSlot = STATIC_MESH:GetMaterialSlots()[1]

-- Set the material of the "FirstMaterialSlot" to the material referenced in the "CustomMaterial" custom property
FirstMaterialSlot.materialAssetId = MATERIAL
```

See also: [StaticMesh.GetMaterialSlots](staticmesh.md)

---
