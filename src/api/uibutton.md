---
id: uibutton
name: UIButton
title: UIButton
tags:
    - API
---

# UIButton

## Description

A UIControl for a button, should be inside client context.

## API

### Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `text` | `string` | Returns the button's label text. | Read-Write |
| `fontSize` | `Integer` | Returns the font size of the label text. | Read-Write |
| `isInteractable` | `bool` | Returns whether the Button can interact with the cursor (click, hover, etc). | Read-Write |

### Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetButtonColor()` | `Color` | Gets the button's default color. | None |
| `SetButtonColor(Color)` | `None` | Sets the button's default color. | None |
| `GetHoveredColor()` | `Color` | Gets the button's color when hovered. | None |
| `SetHoveredColor(Color)` | `None` | Sets the button's color when hovered. | None |
| `GetPressedColor()` | `Color` | Gets the button's color when pressed. | None |
| `SetPressedColor(Color)` | `None` | Sets the button's color when pressed. | None |
| `GetDisabledColor()` | `Color` | Gets the button's color when it's not interactable. | None |
| `SetDisabledColor(Color)` | `None` | Sets the button's color when it's not interactable. | None |
| `GetFontColor()` | `Color` | Gets the font's color. | None |
| `SetFontColor(Color)` | `None` | Sets the font's color. | None |
| `SetImage(string brushMUID)` | `None` | Sets the image to a new MUID. You can get this MUID from an Asset Reference. | None |

### Events

| Event Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `clickedEvent` | `Event<UIButton>` | Fired when button is clicked. This triggers on mouse-button up, if both button-down and button-up events happen inside the button hitbox. | None |
| `pressedEvent` | `Event<UIButton>` | Fired when button is pressed. (mouse button down) | None |
| `releasedEvent` | `Event<UIButton>` | Fired when button is released. (mouse button up) | None |
| `hoveredEvent` | `Event<UIButton>` | Fired when button is hovered. | None |
| `unhoveredEvent` | `Event<UIButton>` | Fired when button is unhovered. | None |

## Tutorials

[UI in Core](../tutorials/ui_reference.md)
