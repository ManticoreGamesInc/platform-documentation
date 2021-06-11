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

## Tutorials

[UI in Core](../tutorials/ui_reference.md)
