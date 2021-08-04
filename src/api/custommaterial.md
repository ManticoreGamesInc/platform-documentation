---
id: custommaterial
name: CustomMaterial
title: CustomMaterial
tags:
    - API
---

# CustomMaterial

CustomMaterial objects represent a custom material made in core. They can have their properties changed from script.

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `SetProperty(string propertyName, value)` | `None` | Sets the given property of the material. | Client-Only |
| `GetProperty(string propertyName)` | `value` | Gets the value of a given property. | Client-Only |
| `GetPropertyNames()` | `Array<string>` | Returns an array of all property names on this CustomMaterial. | Client-Only |
| `GetBaseMaterialId()` | `string` | Returns the asset id of the material this CustomMaterial was based on. | Client-Only |

## Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `CustomMaterial.Find(string assetId)` | [`CustomMaterial`](custommaterial.md) | Returns a CustomMaterial with the given assetId. This function may yield while loading data. | Client-Only |

## Examples

Example using:

### `GetPropertyNames`

This example will print all modifiable properties belonging to the custom material in the first material slot of a cube. For this example to work, a custom material must be in the first material slot of the cube.

```lua
local CUBE = script.parent

-- Get the first material slot of the "CUBE"
local FirstMaterialSlot = CUBE:GetMaterialSlots()[1]

-- Get the Custom Material applied to this material slot
local CustomMaterial = FirstMaterialSlot:GetCustomMaterial()

-- Print the names of all modifiable properties belonging to the "CustomMaterial"
for key, value in ipairs(CustomMaterial:GetPropertyNames()) do
    print(value)
end
```

See also: [MaterialSlot.GetCustomMaterial](materialslot.md) | [StaticMesh.GetMaterialSlots](staticmesh.md)

---

Example using:

### `SetProperty`

This example will continually rotate a custom material at a rate of 180 degrees per second.

```lua
local CUBE = script.parent

-- The amount of time in seconds that has passed
local timePassed = 0

-- Get the first material slot of the "CUBE"
local FirstMaterialSlot = CUBE:GetMaterialSlots()[1]

-- Get the Custom Material applied to this material slot
local CustomMaterial = FirstMaterialSlot:GetCustomMaterial()

-- How many degrees the material will rotate every second
local ROTATION_SPEED = 180

function Tick(deltaTime)
    -- Update the "timePassed" with the "deltaTime" to accurately reflect how many seconds have passed
    -- since this script has started running
    timePassed = timePassed + deltaTime

    -- Determine the current rotation based on how many seconds have passed
    local rotationAngle = timePassed * ROTATION_SPEED

    -- Update the rotation of the custom material with the value from "rotationAngle"
    CustomMaterial:SetProperty("rotate_material", rotationAngle)
end
```

See also: [MaterialSlot.GetCustomMaterial](materialslot.md) | [StaticMesh.GetMaterialSlots](staticmesh.md)

---
