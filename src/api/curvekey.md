---
id: curvekey
name: CurveKey
title: CurveKey
tags:
    - API
---

# CurveKey

A `CurveKey` represents a key point on a `SimpleCurve`, providing a value for a specific point in time on that curve. Additional properties may be used to control the shape of that curve.

## Constructors

| Constructor Name | Return Type | Description | Tags |
| ----------- | ----------- | ----------- | ---- |
| `CurveKey.New()` | [`CurveKey`](curvekey.md) | Constructs a new CurveKey. | None |
| `CurveKey.New(number time, number value, [table optionalParameters])` | [`CurveKey`](curvekey.md) | Constructs a CurveKey with the given time and value. An optional table may be provided to override the following parameters:<br>`interpolation (CurveInterpolation)`: Sets the `interpolation` property of the curve key. Defaults to `CurveInterpolation.LINEAR`.<br>`arriveTangent (number)`: Sets the `arriveTangent` property of the curve key. Defaults to 0.<br>`leaveTangent (number)`: Sets the `leaveTangent` property of the curve key. Defaults to 0.<br>`tangent (number)`: Sets both the `arriveTangent` and `leaveTangent` properties of the curve key. It is an error to specify `arriveTangent` or `leaveTangent` if `tangent` is provided. | None |
| `CurveKey.New(CurveKey other)` | [`CurveKey`](curvekey.md) | Makes a copy of the given CurveKey. | None |

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `interpolation` | [`CurveInterpolation`](enums.md#curveinterpolation) | The interpolation mode between this curve key and the next. | Read-Write |
| `time` | `number` | The time at this curve key. | Read-Write |
| `value` | `number` | The value at this curve key. | Read-Write |
| `arriveTangent` | `number` | The arriving tangent at this key when using cubic interpolation. | Read-Write |
| `leaveTangent` | `number` | The leaving tangent at this key when using cubic interpolation. | Read-Write |

## Examples

Example using:

### `New`

### `interpolation`

### `time`

### `value`

In this example, we track the position of the player and draw a line to represent their movement path. Although we only save the player's position every 0.3 seconds, we are able to draw a much smoother path thanks to the `SimpleCurve` data type. At runtime we construct three `SimpleCurves`, one for each of player's dimensions of movement: X, Y and Z. The curves are built with a small set of points, but can estimate the in-between values with the `GetValue()` function.

```lua
local PLAYER = Game.GetLocalPlayer()
local MAX_POINTS = 30
local TIME_PERIOD = 0.3
local DRAW_RESOLUTION = 0.02

local lastPosition = PLAYER:GetWorldPosition()

local positions = {}
local curveX, curveY, curveZ

function Tick()
    Task.Wait(TIME_PERIOD)
    
    local pos = PLAYER:GetWorldPosition()
    if lastPosition ~= pos then 
        lastPosition = pos
        
        table.insert(positions, pos)
        
        if #positions > MAX_POINTS then
            table.remove(positions, 1)
        end
        
        RebuildCurves()
    end
    DrawDebug()
end

function RebuildCurves()
    local keysX = {}
    local keysY = {}
    local keysZ = {}
    
    local t = 0
    local key
    for i,pos in ipairs(positions) do
        key = CurveKey.New()
        key.interpolation = CurveInterpolation.CUBIC
        key.time = t
        key.value = pos.x
        table.insert(keysX, key)
        
        key = CurveKey.New()
        key.interpolation = CurveInterpolation.CUBIC
        key.time = t
        key.value = pos.y
        table.insert(keysY, key)
        
        key = CurveKey.New()
        key.interpolation = CurveInterpolation.CUBIC
        key.time = t
        key.value = pos.z
        table.insert(keysZ, key)
        
        t = t + TIME_PERIOD
    end

    curveX = SimpleCurve.New(keysX)
    curveY = SimpleCurve.New(keysY)
    curveZ = SimpleCurve.New(keysZ)
end

function DrawDebug()
    local drawParams = {duration = TIME_PERIOD+0.1, thickness = 3}
    local prevPoint = nil
    
    local t = curveX.minTime
    while t <= curveX.maxTime do
        local point = Vector3.New(
            curveX:GetValue(t),
            curveY:GetValue(t),
            curveZ:GetValue(t)
        )
        if prevPoint ~= nil then
            CoreDebug.DrawLine(prevPoint, point, drawParams)
        end
        prevPoint = point
        
        t = t + DRAW_RESOLUTION
    end
end
```

See also: [SimpleCurve.New](simplecurve.md) | [CoreDebug.DrawLine](coredebug.md) | [Game.GetLocalPlayer](game.md) | [Player.GetWorldPosition](player.md) | [Task.Wait](task.md)

---
