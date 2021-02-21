---
id: uitext
name: UIText
title: UIText
tags:
    - API
---

# UIText

A UIControl which displays a basic text label.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `text` | `string` | The actual text string to show. | Read-Write |
| `fontSize` | `Number` | The font size of the UIText control. | Read-Write |
| `justification` | `TextJustify` | Determines the alignment of `text`. Possible values are: TextJustify.LEFT, TextJustify.RIGHT, and TextJustify.CENTER. | Read-Write |
| `shouldWrapText` | `bool` | Whether or not text should be wrapped within the bounds of this control. | Read-Write |
| `shouldClipText` | `bool` | Whether or not text should be clipped when exceeding the bounds of this control. | Read-Write |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetColor()` | [`Color`](color.md) | The color of the Text. | None |
| `SetColor(Color)` | `None` | The color of the Text. | None |
| `ComputeApproximateSize()` | [`Vector2`](vector2.md) | Attempts to determine the size of the rendered block of text. This may return `nil` if the size cannot be determined, for example because the underlying widget has not been fully initialized yet. | None |

## Tutorials

[UI in Core](../tutorials/ui_reference.md)
