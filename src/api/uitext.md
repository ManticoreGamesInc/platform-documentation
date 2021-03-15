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
| `fontSize` | `number` | The font size of the UIText control. | Read-Write |
| `justification` | [`TextJustify`](enums.md#textjustify) | Determines the alignment of `text`. Possible values are: TextJustify.LEFT, TextJustify.RIGHT, and TextJustify.CENTER. | Read-Write |
| `shouldWrapText` | `boolean` | Whether or not text should be wrapped within the bounds of this control. | Read-Write |
| `shouldClipText` | `boolean` | Whether or not text should be clipped when exceeding the bounds of this control. | Read-Write |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetColor()` | [`Color`](color.md) | The color of the Text. | None |
| `SetColor(Color)` | `None` | The color of the Text. | None |
| `ComputeApproximateSize()` | [`Vector2`](vector2.md) | Attempts to determine the size of the rendered block of text. This may return `nil` if the size cannot be determined, for example because the underlying widget has not been fully initialized yet. | None |
| `SetFont(string fontId)` | `None` | Sets the text to use the specified font asset. | None |

## Tutorials

[UI in Core](../tutorials/ui_reference.md)
