---
id: simplecurve
name: SimpleCurve
title: SimpleCurve
tags:
    - API
---

# SimpleCurve

A two-dimensional curve made up of some number of `CurveKey` instances specifying the value of the curve at various points in time. Values between those key points are interpolated based on properties of the curve and the curve keys.

## Constructors

| Constructor Name | Return Type | Description | Tags |
| ----------- | ----------- | ----------- | ---- |
| `SimpleCurve.New(Array<CurveKey> keys, [table optionalParameters])` | [`SimpleCurve`](simplecurve.md) | Constructs a SimpleCurve with a set of curve keys. An optional table may be provided to override the following parameters:<br>`preExtrapolation (CurveExtrapolation)`: Sets the `preExtrapolation` property of the curve. Defaults to `CurveExtrapolation.CYCLE`.<br>`postExtrapolation (CurveExtrapolation)`: Sets the `postExtrapolation` property of the curve. Defaults to `CurveExtrapolation.CYCLE`.<br>`defaultValue (number)`: Sets the `defaultValue` property of the curve. Defaults to 0. | None |
| `SimpleCurve.New(SimpleCurve other)` | [`SimpleCurve`](simplecurve.md) | Makes a copy of the given SimpleCurve. | None |

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `preExtrapolation` | [`CurveExtrapolation`](enums.md#curveextrapolation) | The extrapolation mode for values before the first curve key. | Read-Write |
| `postExtrapolation` | [`CurveExtrapolation`](enums.md#curveextrapolation) | The extrapolation mode for values after the last curve key. | Read-Write |
| `defaultValue` | `number` | The default value for this curve if no keys are available. | Read-Write |
| `minTime` | `number` | Returns the smallest time from the curve's key points. Returns 0 if the curve contains no keys. | Read-Only |
| `maxTime` | `number` | Returns the largest time from the curve's key points. Returns 0 if the curve contains no keys. | Read-Only |
| `minValue` | `number` | Returns the smallest value from the curve's key points. Returns 0 if the curve contains no keys. | Read-Only |
| `maxValue` | `number` | Returns the largest value from the curve's key points. Returns 0 if the curve contains no keys. | Read-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetValue(number time)` | `number` | Returns the value of the curve at the specified time. | None |
| `GetSlope(number time)` | `number` | Returns the slope (derivative) of the curve at the specified time. This may return nil in certain cases where the curve values are not continuous. | None |

## Examples

Example using:

### `GetValue`

This example implements a state machine with 4 states, for the purpose of animating a UI element, such as a popup dialog that is center-aligned on screen. Two `Simple Curve` properties are added to the script to control the animation of the UI as it enters or exits the screen. Given the time elapsed during the enter and exit states, the curves give us a value (between 0 and 1) that we use for the UI's y-axis.

```lua
local UI_ELEMENT = script:GetCustomProperty("UIElement"):WaitForObject()
local ENTER_CURVE = script:GetCustomProperty("Enter")
local EXIT_CURVE = script:GetCustomProperty("Exit")

local ANIM_DURATION = 0.3
local DISABLED_POSITION = 600

local STATE_IDLE = 1
local STATE_ENTER = 2
local STATE_EXIT = 3
local STATE_DISABLED = 4

local currentState
local stateElapsedTime = 0

function SetState(newState)
    if newState == STATE_IDLE then
        -- Force the UI to the middle of screen
        SetUIPosition(1)
        
    elseif newState == STATE_ENTER then
        -- Enable the UI, to begin the 'enter' animation
        UI_ELEMENT.visibility = Visibility.INHERIT
        
    elseif newState == STATE_DISABLED then
        -- Force the UI to be off-screen
        SetUIPosition(0)
        UI_ELEMENT.visibility = Visibility.FORCE_OFF
    end
    
    currentState = newState
    stateElapsedTime = 0
end

function Tick(deltaTime)
    stateElapsedTime = stateElapsedTime + deltaTime
    
    if currentState == STATE_ENTER then
        if stateElapsedTime >= ANIM_DURATION then
            -- The 'enter' animation has ended, go to Idle
            SetState(STATE_IDLE)
        else
            -- 'Enter' animation
            local percent = stateElapsedTime / ANIM_DURATION
            percent = ENTER_CURVE:GetValue(percent)
            SetUIPosition(percent)
        end
        
    elseif currentState == STATE_EXIT then
        if stateElapsedTime >= ANIM_DURATION then
            -- The 'exit' animation has ended, go to Disabled
            SetState(STATE_DISABLED)
        else
            -- 'Exit' animation
            local percent = stateElapsedTime / ANIM_DURATION
            percent = EXIT_CURVE:GetValue(percent)
            SetUIPosition(percent)
        end
    end
end

function SetUIPosition(percent)
    -- Set the y position of the UI. Invert the percent here because the
    -- semantics of the popup are such that 1 means the popup is visible,
    -- in the middle of screen while a value of 0 means the popup is
    -- outside the screen, with a positive Y.
    UI_ELEMENT.y = (1 - percent) * DISABLED_POSITION
end

-- These events could be called from elsewhere in the game
Events.Connect("ShowUI", function()
    SetState(STATE_ENTER)
end)
Events.Connect("HideUI", function()
    SetState(STATE_EXIT)
end)

-- Set the initial state of the UI to 'disabled'
SetState(STATE_DISABLED)
```

See also: [CoreObject.visibility](coreobject.md) | [Events.Connect](events.md) | [UIControl.y](uicontrol.md)

---
