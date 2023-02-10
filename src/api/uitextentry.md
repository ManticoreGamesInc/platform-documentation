---
id: uitextentry
name: UITextEntry
title: UITextEntry
tags:
    - API
    - UI
---

# UITextEntry

A UIControl which provides an editable text input field. Inherits from [UIControl](uicontrol.md).

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `text` | `string` | The actual text string to show. | Read-Write, Client-Only |
| `promptText` | `string` | Text to be displayed in the input box when `text` is empty. | Read-Write |
| `isInteractable` | `boolean` | Returns whether the control can interact with the cursor (click, hover, etc). | Read-Write |
| `fontSize` | `integer` | The font size of the control. | Read-Write |
| `justification` | [`TextJustify`](enums.md#textjustify) | Determines the horizontal alignment of `text`. Possible values are: TextJustify.LEFT, TextJustify.RIGHT, and TextJustify.CENTER. | Read-Write |
| `verticalJustification` | [`TextVerticalJustify`](enums.md#textverticaljustify) | Determines the vertical alignment of `text`. Possible values are: TextVerticalJustify.TOP, TextVerticalJustify.BOTTOM, TextVerticalJustify.CENTER and TextVerticalJustify.BASELINE. | Read-Write |
| `isHittable` | `boolean` | When set to `true`, this control can receive input from the cursor and blocks input to controls behind it. When set to `false`, the cursor ignores this control and can interact with controls behind it. | Read-Write |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetFontColor()` | [`Color`](color.md) | Returns the color of the Text. | None |
| `SetFontColor(Color)` | `None` | Sets the color of the Text. | None |
| `GetBackgroundColor()` | [`Color`](color.md) | Returns the color of the text's background image. | None |
| `SetBackgroundColor(Color)` | `None` | Sets the color of the text's background image. | None |
| `GetHoveredColor()` | [`Color`](color.md) | Returns the color of the text's background image when hovering over it. | None |
| `SetHoveredColor(Color)` | `None` | Sets the color of the text's background image when hovering over it. | None |
| `GetFocusedColor()` | [`Color`](color.md) | Returns the color of the text's background image when the text has focus. | None |
| `SetFocusedColor(Color)` | `None` | Sets the color of the text's background image when the text has focus. | None |
| `GetDisabledColor()` | [`Color`](color.md) | Returns the color of the text's background image when the control is disabled. | None |
| `SetDisabledColor(Color)` | `None` | Sets the color of the text's background image when the control is disabled. | None |
| `GetFontSelectionColor()` | [`Color`](color.md) | Returns the highlight color used when selecting text in the control. | None |
| `SetFontSelectionColor(Color)` | `None` | Sets the highlight color used when selecting text in the control. | None |
| `SetFont(string fontId)` | `None` | Sets the text to use the specified font asset. | None |
| `SetImage(string imageId)` | `None` | Sets the image used as the background for the control. | None |
| `Focus()` | `None` | Gives keyboard focus to the control. | None |
| `GetCurrentTouchIndex()` | `integer` | Returns the touch index currently interacting with this control. Returns `nil` if the control is not currently being interacted with. | Client-Only |

## Events

| Event Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `textCommittedEvent` | [`Event`](event.md)<[`UITextEntry`](uitextentry.md), `string` text> | Fired when the control loses focus and text in the control is committed. | Client-Only |
| `textChangedEvent` | [`Event`](event.md)<[`UITextEntry`](uitextentry.md), `string` text> | Fired when text in the control is changed. | Client-Only |
| `touchStartedEvent` | [`Event`](event.md)<[`UITextEntry`](uitextentry.md), [`Vector2`](vector2.md) location, `integer` touchIndex> | Fired when the player starts touching the control on a touch input device. Parameters are the screen location of the touch and a touch index used to distinguish between separate touches on a multitouch device. | Client-Only |
| `touchStoppedEvent` | [`Event`](event.md)<[`UITextEntry`](uitextentry.md), [`Vector2`](vector2.md) location, `integer` touchIndex> | Fired when the player stops touching the control on a touch input device. Parameters are the screen location from which the touch was released and a touch index used to distinguish between separate touches on a multitouch device. | Client-Only |
| `tappedEvent` | [`Event`](event.md)<[`UITextEntry`](uitextentry.md), [`Vector2`](vector2.md) location, `integer` touchIndex> | Fired when the player taps the control on a touch input device. Parameters are the screen location of the tap and the touch index with which the tap was performed. | Client-Only |
| `flickedEvent` | [`Event`](event.md)<[`UITextEntry`](uitextentry.md), `number` angle> | Fired when the player performs a quick flicking gesture on the control on a touch input device. The `angle` parameter indicates the direction of the flick. 0 indicates a flick to the right. Values increase in degrees counter-clockwise, so 90 indicates a flick straight up, 180 indicates a flick to the left, etc. | Client-Only |
| `pinchStartedEvent` | [`Event`](event.md)<[`UITextEntry`](uitextentry.md)> | Fired when the player begins a pinching gesture on the control on a touch input device. `Input.GetPinchValue()` may be polled during the pinch gesture to determine how far the player has pinched. | Client-Only |
| `pinchStoppedEvent` | [`Event`](event.md)<[`UITextEntry`](uitextentry.md)> | Fired when the player ends a pinching gesture on a touch input device. | Client-Only |
| `rotateStartedEvent` | [`Event`](event.md)<[`UITextEntry`](uitextentry.md)> | Fired when the player begins a rotating gesture on the control on a touch input device. `Input.GetRotateValue()` may be polled during the rotate gesture to determine how far the player has rotated. | Client-Only |
| `rotateStoppedEvent` | [`Event`](event.md)<[`UITextEntry`](uitextentry.md)> | Fired when the player ends a rotating gesture on a touch input device. | Client-Only |

## Examples

Example using:

### `textChangedEvent`

### `textCommittedEvent`

In this example, a text box entry has a maximum limit for the amount of characters that can be entered by the player. When that limit is reached, no more characters can be entered. This is a good way to restrict the length of a string that can be entered by the player. For example, limiting the length of a pet name so it doesn't exceed space in user intefaces or storage limits.

```lua
-- Client script

-- References to the Text Entry Box and Text counter.
local TEXT_ENTRY_BOX = script:GetCustomProperty("TextEntryBox"):WaitForObject()
local COUNTER = script:GetCustomProperty("Counter"):WaitForObject()

-- Max length allowed for this text entry box.
local maxLength = 20

-- Enable cursor interaction and make visible
UI.SetCanCursorInteractWithUI(true)
UI.SetCursorVisible(true)

-- Update the counter text counter
local function UpdateChars()
    COUNTER.text = string.format("%s/%s", string.len(TEXT_ENTRY_BOX.text), maxLength)
end

-- Check the length of the text when the text entry box is updated.
local function CheckLength(obj, text)
    local len = string.len(text)

    if len > maxLength then
        TEXT_ENTRY_BOX.text = string.sub(text, 1, maxLength)
    end

    UpdateChars()
end

-- Connect text entry events
TEXT_ENTRY_BOX.textChangedEvent:Connect(CheckLength)
TEXT_ENTRY_BOX.textCommittedEvent:Connect(CheckLength)
```

See also: [CoreObject.GetCustomProperty](coreobject.md) | [CoreLua.print](coreluafunctions.md) | [UI.SetCursorVisible](ui.md) | [UIText.text](uitext.md) | [UITextEntry.text](uitextentry.md)

---

## Tutorials

[UI in Core](../references/ui.md)
