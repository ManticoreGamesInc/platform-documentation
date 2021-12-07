---
id: coremath
name: CoreMath
title: CoreMath
tags:
    - API
---

# CoreMath

The CoreMath namespace contains a set of math functions.

## Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `CoreMath.Clamp(number value, [number lower, number upper])` | `number` | Clamps value between lower and upper, inclusive. If lower and upper are not specified, defaults to 0 and 1. | None |
| `CoreMath.Lerp(number from, number to, number t)` | `number` | Linear interpolation between from and to. t should be a floating point number from 0 to 1, with 0 returning from and 1 returning to. | None |
| `CoreMath.Round(number value, [number decimals])` | `number` | Rounds value to an integer, or to an optional number of decimal places, and returns the rounded value. | None |

## Examples

Example using:

### `Clamp`

### `Lerp`

### `Round`

In this example, a UI panel is moved in/out of screen by calling the `Show()` and `Hide()` functions. CoreMath's `Lerp()`, `Clamp()` and `Round()` are used for controlling the UI's movement, animating it over time and constraining its limits.

```lua
local UI_PANEL = script:GetCustomProperty("UIPanel"):WaitForObject()
local OFF_SCREEN_Y = 800
local LERP_SPEED = 14

local isShowing = false

UI_PANEL.visibility = Visibility.FORCE_OFF
UI_PANEL.y = OFF_SCREEN_Y

function Show()
    isShowing = true
end

function Hide()
    isShowing = false
end

function Tick(deltaTime)
    -- Keep the time delta between 0 and 1
    local t = CoreMath.Clamp(deltaTime * LERP_SPEED)
    if isShowing then
        -- Move the UI towards the center of the screen
        UI_PANEL.y = CoreMath.Lerp(UI_PANEL.y, 0, t)
        -- Check if it has arrived
        if CoreMath.Round(UI_PANEL.y) == 0 then
            UI_PANEL.y = 0
        end
        UI_PANEL.visibility = Visibility.INHERIT
    else
        -- Move the UI off screen
        UI_PANEL.y = CoreMath.Lerp(UI_PANEL.y, OFF_SCREEN_Y, t)
        -- Check if it has arrived
        if CoreMath.Round(UI_PANEL.y) == OFF_SCREEN_Y then
            UI_PANEL.y = OFF_SCREEN_Y
            UI_PANEL.visibility = Visibility.FORCE_OFF
        end
    end
end
```

See also: [UIControl.y](uicontrol.md) | [CoreObject.visibility](coreobject.md) | [CoreObjectReference.WaitForObject](coreobjectreference.md)

---
