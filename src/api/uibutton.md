---
id: uibutton
name: UIButton
title: UIButton
tags:
    - API
    - UI
---

# UIButton

A UIControl for a button, should be inside client context. Inherits from [UIControl](uicontrol.md).

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `text` | `string` | Returns the button's label text. | Read-Write |
| `fontSize` | `integer` | Returns the font size of the label text. | Read-Write |
| `isInteractable` | `boolean` | Returns whether the Button can interact with the cursor (click, hover, etc). | Read-Write |
| `shouldClipToSize` | `boolean` | Whether or not the button and its shadow should be clipped when exceeding the bounds of this control. | Read-Write |
| `shouldScaleToFit` | `boolean` | Whether or not the button's label should scale down to fit within the bounds of this control. | Read-Write |
| `boundAction` | `string` | Returns the name of the action binding that is toggled when the button is pressed or released, or `nil` if no binding has been set. | Read-Write |
| `isHittable` | `boolean` | When set to `true`, this control can receive input from the cursor and blocks input to controls behind it. When set to `false`, the cursor ignores this control and can interact with controls behind it. | Read-Write |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetButtonColor()` | [`Color`](color.md) | Gets the button's default color. | None |
| `SetButtonColor(Color)` | `None` | Sets the button's default color. | None |
| `GetHoveredColor()` | [`Color`](color.md) | Gets the button's color when hovered. | None |
| `SetHoveredColor(Color)` | `None` | Sets the button's color when hovered. | None |
| `GetPressedColor()` | [`Color`](color.md) | Gets the button's color when pressed. | None |
| `SetPressedColor(Color)` | `None` | Sets the button's color when pressed. | None |
| `GetDisabledColor()` | [`Color`](color.md) | Gets the button's color when it's not interactable. | None |
| `SetDisabledColor(Color)` | `None` | Sets the button's color when it's not interactable. | None |
| `GetFontColor()` | [`Color`](color.md) | Gets the font's color. | None |
| `SetFontColor(Color)` | `None` | Sets the font's color. | None |
| `SetImage(string brushMUID)` | `None` | Sets the image to a new MUID. You can get this MUID from an Asset Reference. | None |
| `SetFont(string fontId)` | `None` | Sets the button's text to use the specified font asset. | None |
| `GetShadowColor()` | [`Color`](color.md) | Returns the color of the button's drop shadow. | None |
| `SetShadowColor(Color)` | `None` | Sets the color of the button's drop shadow. | None |
| `GetShadowOffset()` | [`Vector2`](vector2.md) | Returns the offset of the button's drop shadow in UI space. | None |
| `SetShadowOffset(Vector2)` | `None` | Sets the offset of the button's drop shadow in UI space. | None |
| `GetCurrentTouchIndex()` | `integer` | Returns the touch index currently interacting with this button. Returns `nil` if the button is not currently being interacted with. | Client-Only |

## Events

| Event Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `clickedEvent` | [`Event`](event.md)<[`UIButton`](uibutton.md)> | Fired when button is clicked. This triggers on mouse-button up, if both button-down and button-up events happen inside the button hitbox. | None |
| `pressedEvent` | [`Event`](event.md)<[`UIButton`](uibutton.md)> | Fired when button is pressed. (mouse button down) | None |
| `releasedEvent` | [`Event`](event.md)<[`UIButton`](uibutton.md)> | Fired when button is released. (mouse button up) | None |
| `hoveredEvent` | [`Event`](event.md)<[`UIButton`](uibutton.md)> | Fired when button is hovered. | None |
| `unhoveredEvent` | [`Event`](event.md)<[`UIButton`](uibutton.md)> | Fired when button is unhovered. | None |
| `touchStartedEvent` | [`Event`](event.md)<[`UIButton`](uibutton.md), [`Vector2`](vector2.md) location, `integer` touchIndex> | Fired when the player starts touching the control on a touch input device. Parameters are the screen location of the touch and a touch index used to distinguish between separate touches on a multitouch device. | Client-Only |
| `touchStoppedEvent` | [`Event`](event.md)<[`UIButton`](uibutton.md), [`Vector2`](vector2.md) location, `integer` touchIndex> | Fired when the player stops touching the control on a touch input device. Parameters are the screen location from which the touch was released and a touch index used to distinguish between separate touches on a multitouch device. | Client-Only |
| `tappedEvent` | [`Event`](event.md)<[`UIButton`](uibutton.md), [`Vector2`](vector2.md) location, `integer` touchIndex> | Fired when the player taps the control on a touch input device. Parameters are the screen location of the tap and the touch index with which the tap was performed. | Client-Only |
| `flickedEvent` | [`Event`](event.md)<[`UIButton`](uibutton.md), `number` angle> | Fired when the player performs a quick flicking gesture on the control on a touch input device. The `angle` parameter indicates the direction of the flick. 0 indicates a flick to the right. Values increase in degrees counter-clockwise, so 90 indicates a flick straight up, 180 indicates a flick to the left, etc. | Client-Only |
| `pinchStartedEvent` | [`Event`](event.md)<[`UIButton`](uibutton.md)> | Fired when the player begins a pinching gesture on the control on a touch input device. `Input.GetPinchValue()` may be polled during the pinch gesture to determine how far the player has pinched. | Client-Only |
| `pinchStoppedEvent` | [`Event`](event.md)<[`UIButton`](uibutton.md)> | Fired when the player ends a pinching gesture on a touch input device. | Client-Only |
| `rotateStartedEvent` | [`Event`](event.md)<[`UIButton`](uibutton.md)> | Fired when the player begins a rotating gesture on the control on a touch input device. `Input.GetRotateValue()` may be polled during the rotate gesture to determine how far the player has rotated. | Client-Only |
| `rotateStoppedEvent` | [`Event`](event.md)<[`UIButton`](uibutton.md)> | Fired when the player ends a rotating gesture on a touch input device. | Client-Only |

## Examples

Example using:

### `GetTouchPosition`

### `GetPinchValue`

### `GetRotateValue`

### `pinchStartedEvent`

### `pinchStoppedEvent`

### `rotateStartedEvent`

### `rotateStoppedEvent`

In this example we manipulate a UI Button object with a multi-touch pinching gesture. The pinch gesture is used to move, scale and rotate a the UI Text on screen.

```lua
-- Client Script as a child of the UI Text.
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

-- Detect pinch gesture start/end
UI_OBJECT.pinchStartedEvent:Connect(function()
    isPinching = true
    startingWidth = UI_OBJECT.width
    startingHeight = UI_OBJECT.height
end)

UI_OBJECT.pinchStoppedEvent:Connect(function()
    isPinching = false
end)

-- Detect rotation gesture start/end
UI_OBJECT.rotateStartedEvent:Connect(function()
    isRotating = true
    startingAngle = UI_OBJECT.rotationAngle
end)

UI_OBJECT.rotateStoppedEvent:Connect(function()
    isRotating = false
end)
```

See also: [UIControl.SetAbsolutePosition](uicontrol.md) | [UIButton.isHittable](uibutton.md) | [CoreObject.parent](coreobject.md) | [CoreMath.Round](coremath.md)

---

Example using:

### `clickedEvent`

### `pressedEvent`

### `releasedEvent`

### `hoveredEvent`

### `unhoveredEvent`

### `text`

This example will demonstrate how you can listen for the various events of a UI button object. This example will also show you how to change the text in a UI Button by using the `text` property of the UI Button.

```lua
-- Make the cursor visible
UI.SetCursorVisible(true)

--Allow the cursor to interact with UI
UI.SetCanCursorInteractWithUI(true)

-- Get the UI button object so that its events can be listened to
local propUIButton = script:GetCustomProperty("UIButton"):WaitForObject()

-- This function will be called whenever the button is click
function OnClick(button)
    print("The button has been pressed")
end

-- This function will be called whenever the player presses down on the button
function OnPress(button)
    -- Change the text displayed by the button
    button.text = "Button is being held"
end

-- This function will be called whenever the player releases their mouse after having
-- held it down over the button
function OnRelease(button)
    -- Change the text displayed by the button
    button.text = "Button was released"
end

-- This function will be called whenever the mouse passes over the button
function OnHover(button)
    -- Change the text displayed by the button
    button.text = "Mouse is over button"
end

-- This function will be called whenever your mouse passes off of the button
function OnUnhover(button)
    -- Change the text displayed by the button
    button.text = "Mouse off of button"
end

-- Bind the "OnClick" function to the "clickedEvent" of the button so that clicking on the
-- button fires the "OnClick" function
propUIButton.clickedEvent:Connect(OnClick)

-- Bind the "OnPress" function to the "pressedEvent" of the button so that the "OnPress" function
-- is fired immediately after the mouse is held down and on top of the button
propUIButton.pressedEvent:Connect(OnPress)

-- Bind the "OnRelease" function to the "releasedEvent" of the button. This will cause the "OnRelease" function
-- to be fired whenever the left mouse button is released while the mouse is above the button
propUIButton.releasedEvent:Connect(OnRelease)

-- Bind the "OnHover" function to the "hoverEvent" of the button. This will cause the "OnHover" function to be
-- fired whenever the mouse passes over the button.
propUIButton.hoveredEvent:Connect(OnHover)

-- Bind the "OnUnhover" function to the "unhoveredEvent" of the button. THis will cause the "OnUnhover" function to
-- be fired whenever the mouse leaves the button.
propUIButton.unhoveredEvent:Connect(OnUnhover)
```

See also: [CoreObject.GetCustomProperty](coreobject.md) | [UI.SetCursorVisible](ui.md)

---

Example using:

### `tappedEvent`

### `flickedEvent`

In this example we listen for the tapped and flicked touch gestures on the UI object. When one of those events is triggered, the pertinent information is printed to the screen.

```lua
-- Client Script as a child of the UI Button.
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

See also: [UI.PrintToScreen](ui.md) | [Event.Connect](event.md) | [UIButton.isHittable](uibutton.md)

---

Example using:

### `touchStartedEvent`

### `touchStoppedEvent`

In this example, the touch inputs on the UI object are tracked in two different ways, with a counter and with a table. Each time the amount of touches change a summary of the touch information is printed to screen.

```lua
-- Client Script as a child of the UI Button.
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

See also: [UI.PrintToScreen](ui.md) | [Event.Connect](event.md) | [UIButton.isHittable](uibutton.md)

---

Example using:

### `SetButtonColor`

### `unhoveredEvent`

This example will show you how to change the color of a button by using the `SetButtonColor` method. It's important to remember that colors in Core use red, gree, and blue values between 0 and 1 as opposed to values between 0 and 255.

```lua
-- Make the cursor visible
UI.SetCursorVisible(true)

--Allow the cursor to interact with UI
UI.SetCanCursorInteractWithUI(true)

-- Get the UI Button object
local propUIButton = script:GetCustomProperty("UIButton"):WaitForObject()

-- The button will switch to this color when the mouse leaves the button
local MouseOffColor = Color.New(0.5, 0.2, 0.4)

-- This function will be called whenever the mouse leaves the button and set
-- the color of the button to the color of "MouseOffColor"
function OnUnhover(button)
    button:SetButtonColor(MouseOffColor)
end

-- Bind the "OnUnhover" function to the "unhoveredEvent" of the button. THis will cause the "OnUnhover" function to
-- be fired whenever the mouse leaves the button
propUIButton.unhoveredEvent:Connect(OnUnhover)
```

See also: [Color.New](color.md) | [CoreObject.GetCustomProperty](coreobject.md) | [UI.SetCursorVisible](ui.md)

---

Example using:

### `boundAction`

### `pressedEvent`

UI Buttons can be used as direct input to control the gameplay. This is especially useful for touch-screen devices, where UI Buttons can be setup as virtual controls. In this example, a UI Button has a value set for its `boundAction` property. When the button is pressed, the button's `pressedEvent` will callback. If the `boundAction` property has been set to a valid input action (for example "Jump") then the Input `actionPressedEvent` will also callback.

```lua
local UIBUTTON = script:GetCustomProperty("UIButton"):WaitForObject()

UI.SetCursorVisible(true)
UI.SetCanCursorInteractWithUI(true)

UIBUTTON.pressedEvent:Connect(function()
    print("Button: " .. UIBUTTON.boundAction)
end)

Input.actionPressedEvent:Connect(function(player, action, value)
    print("Action: " .. action .. ", value: " .. tostring(value))
end)
```

See also: [Input.actionPressedEvent](input.md) | [CoreObject.GetCustomProperty](coreobject.md) | [UI.SetCanCursorInteractWithUI](ui.md)

---

## Tutorials

[UI in Core](../references/ui.md)
