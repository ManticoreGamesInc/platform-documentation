---
id: arealight
name: AreaLight
title: AreaLight
tags:
    - API
---

# AreaLight

AreaLight is a Light that emits light from a rectangular plane. It also has properties for configuring a set of "doors" attached to the plane which affect the lit area in front of the plane.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `sourceWidth` | `number` | The width of the plane from which light is emitted. Must be greater than 0. | Read-Write |
| `sourceHeight` | `number` | The height of the plane from which light is emitted. Must be greater than 0. | Read-Write |
| `barnDoorAngle` | `number` | The angle of the barn doors, in degrees. Valid values are in the range from 0 to 90. Has no effect if `barnDoorLength` is 0. | Read-Write |
| `barnDoorLength` | `number` | The length of the barn doors. Must be non-negative. | Read-Write |

## Examples

Example using:

### `sourceWidth`

### `sourceHeight`

### `barnDoorAngle`

### `barnDoorLength`

In this example, a client script animates the width and angle of a "barn door" light. This effect could be used in sync with a door opening from a highly-lit area onto a poorly lit one, generating a cinematic or emotional moment. In this case, the time `t` is driven by the sine of `time()`, but it could be driven by the the door's rotation instead.

```lua
local AREA_LIGHT = script:GetCustomProperty("AreaLight"):WaitForObject()

if AREA_LIGHT.sourceHeight < 10 then
    warn("Height of the area light may be too small for this effect.")
end

if AREA_LIGHT.barnDoorLength < 1 then
    error("Length of area light is too small.")
end

function Tick()
    local t = math.sin(time()) / 2 + 0.5
    AREA_LIGHT.sourceWidth = CoreMath.Lerp(0, 100, t)
    AREA_LIGHT.barnDoorAngle = CoreMath.Lerp(0, 90, t)
end
```

See also: [CoreMath.Lerp](coremath.md) | [CoreObject.GetCustomProperty](coreobject.md) | [CoreObjectReference.WaitForObject](coreobjectreference.md)

---
