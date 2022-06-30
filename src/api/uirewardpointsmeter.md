---
id: uirewardpointsmeter
name: UIRewardPointsMeter
title: UIRewardPointsMeter
tags:
    - API
    - UI
---

# UIRewardPointsMeter

A UIControl that displays the a players progress towards the daily Reward Points cap. Inherits from [UIControl](uicontrol.md).

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `isHittable` | `boolean` | When set to `true`, this control can receive input from the cursor and blocks input to controls behind it. When set to `false`, the cursor ignores this control and can interact with controls behind it. | Read-Write |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetCurrentTouchIndex()` | `integer` | Returns the touch index currently interacting with this control. Returns `nil` if the control is not currently being interacted with. | Client-Only |

## Events

| Event Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `touchStartedEvent` | [`Event`](event.md)<[`UIRewardPointsMeter`](uirewardpointsmeter.md), [`Vector2`](vector2.md) location, `integer` touchIndex> | Fired when the player starts touching the control on a touch input device. Parameters are the screen location of the touch and a touch index used to distinguish between separate touches on a multitouch device. | Client-Only |
| `touchStoppedEvent` | [`Event`](event.md)<[`UIRewardPointsMeter`](uirewardpointsmeter.md), [`Vector2`](vector2.md) location, `integer` touchIndex> | Fired when the player stops touching the control on a touch input device. Parameters are the screen location from which the touch was released and a touch index used to distinguish between separate touches on a multitouch device. | Client-Only |
| `tappedEvent` | [`Event`](event.md)<[`UIRewardPointsMeter`](uirewardpointsmeter.md), [`Vector2`](vector2.md) location, `integer` touchIndex> | Fired when the player taps the control on a touch input device. Parameters are the screen location of the tap and the touch index with which the tap was performed. | Client-Only |
| `flickedEvent` | [`Event`](event.md)<[`UIRewardPointsMeter`](uirewardpointsmeter.md), `number` angle> | Fired when the player performs a quick flicking gesture on the control on a touch input device. The `angle` parameter indicates the direction of the flick. 0 indicates a flick to the right. Values increase in degrees counter-clockwise, so 90 indicates a flick straight up, 180 indicates a flick to the left, etc. | Client-Only |
| `pinchStartedEvent` | [`Event`](event.md)<[`UIRewardPointsMeter`](uirewardpointsmeter.md)> | Fired when the player begins a pinching gesture on the control on a touch input device. `Input.GetPinchValue()` may be polled during the pinch gesture to determine how far the player has pinched. | Client-Only |
| `pinchStoppedEvent` | [`Event`](event.md)<[`UIRewardPointsMeter`](uirewardpointsmeter.md)> | Fired when the player ends a pinching gesture on a touch input device. | Client-Only |
| `rotateStartedEvent` | [`Event`](event.md)<[`UIRewardPointsMeter`](uirewardpointsmeter.md)> | Fired when the player begins a rotating gesture on the control on a touch input device. `Input.GetRotateValue()` may be polled during the rotate gesture to determine how far the player has rotated. | Client-Only |
| `rotateStoppedEvent` | [`Event`](event.md)<[`UIRewardPointsMeter`](uirewardpointsmeter.md)> | Fired when the player ends a rotating gesture on a touch input device. | Client-Only |

## Examples

Example using:

### `GetTouchPosition`

### `GetPinchValue`

### `GetRotateValue`

### `pinchStartedEvent`

### `pinchStoppedEvent`

### `rotateStartedEvent`

### `rotateStoppedEvent`

In this example we manipulate a UI object with a multi-touch pinching gesture. The pinch gesture is used to move, scale and rotate a the UI Text on screen.

```lua
-- Client Script as a child of the UI object.
local UI_OBJECT = script.parent

-- Make the UI Control hittable
UI_OBJECT.isHittable = true

local isPinching = false
local isRotating = false
local startingWidth
local startingHeight
local startingAngle

function Tick()
    -- Position
    local touch1 = Input.GetTouchPosition(1)
    local touch2 = Input.GetTouchPosition(2)

    if touch1 ~= nil and touch2 ~= nil then
        local position = (touch1 + touch2) / 2

        UI_OBJECT:SetAbsolutePosition(position)
    end

    -- Scale
    if isPinching then
        local pinchPercent = Input.GetPinchValue()

        UI_OBJECT.width = CoreMath.Round(startingWidth * pinchPercent)
        UI_OBJECT.height = CoreMath.Round(startingHeight * pinchPercent)
    end

    -- Rotate
    if isRotating then
        local angle = Input.GetRotateValue()

        UI_OBJECT.rotationAngle = startingAngle + angle
    end
end

local function OnPinchStarted()
    isPinching = true
    startingWidth = UI_OBJECT.width
    startingHeight = UI_OBJECT.height
end

local function OnPinchStopped()
    isPinching = false
end

-- Detect pinch gesture start/end
UI_OBJECT.pinchStartedEvent:Connect(OnPinchStarted)
UI_OBJECT.pinchStoppedEvent:Connect(OnPinchStopped)

local function OnRotateStarted()
    isRotating = true
    startingAngle = UI_OBJECT.rotationAngle
end

local function OnRotateStopped()
    isRotating = false
end

-- Detect rotation gesture start/end
UI_OBJECT.rotateStartedEvent:Connect(OnRotateStarted)
UI_OBJECT.rotateStoppedEvent:Connect(OnRotateStopped)
```

See also: [UIControl.SetAbsolutePosition](uicontrol.md) | [UIRewardPointsMeter.isHittable](uirewardpointsmeter.md) | [CoreObject.parent](coreobject.md) | [CoreMath.Round](coremath.md)

---

Example using:

### `tappedEvent`

### `flickedEvent`

In this example we listen for the tapped and flicked touch gestures on the UI object. When one of those events is triggered, the pertinent information is printed to the screen.

```lua
-- Client Script as a child of the UI object.
local UI_OBJECT = script.parent

-- Make the UI Control hittable
UI_OBJECT.isHittable = true

function OnTappedEvent(control, location, touchIndex)
    UI.PrintToScreen("Tap ".. touchIndex ..": ".. tostring(location))
end

function OnFlickedEvent(control, angle)
    UI.PrintToScreen("Flick: " .. angle)
end

UI_OBJECT.tappedEvent:Connect(OnTappedEvent)
UI_OBJECT.flickedEvent:Connect(OnFlickedEvent)
```

See also: [UI.PrintToScreen](ui.md) | [Event.Connect](event.md) | [UIRewardPointsMeter.isHittable](uirewardpointsmeter.md)

---

Example using:

### `touchStartedEvent`

### `touchStoppedEvent`

In this example, the touch inputs on the UI object are tracked in two different ways, with a counter and with a table. Each time the amount of touches change a summary of the touch information is printed to screen.

```lua
-- Client Script as a child of the UI object.
local UI_OBJECT = script.parent

-- Make the UI Control hittable
UI_OBJECT.isHittable = true

local touchCount = 0
local activeTouches = {}

function PrintTouchInfo()
    local str = touchCount .. ": ["
    local addComma = false

    for id,_ in pairs(activeTouches) do
        if addComma then
            str = str .. ", "
        end

        addComma = true
        str = str .. id
    end

    str = str .. "]"

    UI.PrintToScreen(str)
end

local function OnTouchStarted(control, location, touchId)
    touchCount = touchCount + 1
    activeTouches[touchId] = true

    PrintTouchInfo()
end

local function OnTouchStopped(control, location, touchId)
    touchCount = touchCount - 1
    activeTouches[touchId] = nil

    PrintTouchInfo()
end

UI_OBJECT.touchStartedEvent:Connect(OnTouchStarted)
UI_OBJECT.touchStoppedEvent:Connect(OnTouchStopped)
```

See also: [UI.PrintToScreen](ui.md) | [Event.Connect](event.md) | [UIRewardPointsMeter.isHittable](uirewardpointsmeter.md)

---
