---
id: pointlight
name: PointLight
title: PointLight
tags:
    - API
---

# PointLight

PointLight is a placeable light source that is a CoreObject.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `hasNaturalFalloff` | `boolean` | The attenuation method of the light. When enabled, `attenuationRadius` is used. When disabled, `falloffExponent` is used. Also changes the interpretation of the intensity property, see intensity for details. | Read-Write |
| `falloffExponent` | `number` | Controls the radial falloff of the light when `hasNaturalFalloff` is false. 2.0 is almost linear and very unrealistic and around 8.0 it looks reasonable. With large exponents, the light has contribution to only a small area of its influence radius but still costs the same as low exponents. | Read-Write |
| `sourceRadius` | `number` | Radius of light source shape. | Read-Write |
| `sourceLength` | `number` | Length of light source shape. | Read-Write |

## Examples

Example using:

### `falloffExponent`

In this example, a Point Light's "falloff exponent" property animates over time, between a minimum and maximum value range. Note that it only works if "Natural Falloff" is enabled on the light.

```lua
local POINT_LIGHT = script.parent
local MIN_EXPONENT = 1
local MAX_EXPONENT = 20

function Tick()
    -- This makes `t` oscillate between 0 and 1
    local t = math.sin(time()) / 2 + 0.5
    POINT_LIGHT.falloffExponent = CoreMath.Lerp(MIN_EXPONENT, MAX_EXPONENT, t)
end
```

See also: [CoreObject.parent](coreobject.md) | [CoreMath.Lerp](coremath.md) | [Task.Wait](task.md)

---

Example using:

### `hasNaturalFalloff`

In this example, a Point Light's "natural falloff" property is toggled on/off over time.

```lua
local POINT_LIGHT = script.parent

function Tick()
    Task.Wait(1)
    POINT_LIGHT.hasNaturalFalloff = true
    
    Task.Wait(1)
    POINT_LIGHT.hasNaturalFalloff = false
end
```

See also: [CoreObject.parent](coreobject.md) | [Task.Wait](task.md)

---

Example using:

### `sourceLength`

In this example, a Point Light's "source length" property animates over time, between a minimum and maximum value range.

```lua
local POINT_LIGHT = script.parent
local MIN_LENGTH = 0
local MAX_LENGTH = 1000

function Tick()
    -- This makes `t` oscillate between 0 and 1
    local t = math.sin(time()) / 2 + 0.5
    POINT_LIGHT.sourceLength = CoreMath.Lerp(MIN_LENGTH, MAX_LENGTH, t)
end
```

See also: [CoreObject.parent](coreobject.md) | [CoreMath.Lerp](coremath.md) | [Task.Wait](task.md)

---

Example using:

### `sourceRadius`

In this example, a Point Light's "source radius" property animates over time, between a minimum and maximum value range.

```lua
local POINT_LIGHT = script.parent
local MIN_RADIUS = 0
local MAX_RADIUS = 500

function Tick()
    -- This makes `t` oscillate between 0 and 1
    local t = math.sin(time()) / 2 + 0.5
    POINT_LIGHT.sourceRadius = CoreMath.Lerp(MIN_RADIUS, MAX_RADIUS, t)
end
```

See also: [CoreObject.parent](coreobject.md) | [CoreMath.Lerp](coremath.md) | [Task.Wait](task.md)

---
