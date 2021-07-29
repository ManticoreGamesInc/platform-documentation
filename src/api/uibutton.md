---
id: uibutton
name: UIButton
title: UIButton
tags:
    - API
---

# UIButton

A UIControl for a button, should be inside client context.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `text` | `string` | Returns the button's label text. | Read-Write |
| `fontSize` | `integer` | Returns the font size of the label text. | Read-Write |
| `isInteractable` | `boolean` | Returns whether the Button can interact with the cursor (click, hover, etc). | Read-Write |
| `shouldClipToSize` | `boolean` | Whether or not the button and its shadow should be clipped when exceeding the bounds of this control. | Read-Write |
| `shouldScaleToFit` | `boolean` | Whether or not the button's label should scale down to fit within the bounds of this control. | Read-Write |

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

## Events

| Event Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `clickedEvent` | `Event<`[`UIButton`](uibutton.md)`>` | Fired when button is clicked. This triggers on mouse-button up, if both button-down and button-up events happen inside the button hitbox. | None |
| `pressedEvent` | `Event<`[`UIButton`](uibutton.md)`>` | Fired when button is pressed. (mouse button down) | None |
| `releasedEvent` | `Event<`[`UIButton`](uibutton.md)`>` | Fired when button is released. (mouse button up) | None |
| `hoveredEvent` | `Event<`[`UIButton`](uibutton.md)`>` | Fired when button is hovered. | None |
| `unhoveredEvent` | `Event<`[`UIButton`](uibutton.md)`>` | Fired when button is unhovered. | None |

## Examples

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

### `SetButtonColor`

### `unhoveredEvent`

This example will will show you how to change the color of a button by using the `SetButtonColor` method. It's important to remember that colors in Core use red, gree, and blue values between 0 and 1 as opposed to values between 0 and 255.

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

## Tutorials

[UI in Core](../references/ui.md)
