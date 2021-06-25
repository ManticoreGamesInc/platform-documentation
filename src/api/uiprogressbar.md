---
id: uiprogressbar
name: UIProgressBar
title: UIProgressBar
tags:
    - API
---

# UIProgressBar

A UIControl that displays a filled rectangle which can be used for things such as a health indicator.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `progress` | `number` | From 0 to 1, how full the bar should be. | Read-Write |
| `fillType` | [`ProgressBarFillType`](enums.md#progressbarfilltype) | Controls the direction in which the progress bar fills. | Read-Write |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetFillColor()` | [`Color`](color.md) | Returns the color of the fill. | None |
| `SetFillColor(Color)` | `None` | Sets the color of the fill. | None |
| `GetFillImage()` | `string` | Returns the asset ID of the image used for the progress bar fill. | None |
| `SetFillImage(string assetId)` | `None` | Sets the progress bar fill to use the image specified by the given asset ID. | None |
| `GetBackgroundColor()` | [`Color`](color.md) | Returns the color of the background. | None |
| `SetBackgroundColor(Color)` | `None` | Sets the color of the background. | None |
| `GetBackgroundImage()` | `string` | Returns the asset ID of the image used for the progress bar background. | None |
| `SetBackgroundImage(string assetId)` | `None` | Sets the progress bar background to use the image specified by the given asset ID. | None |

## Tutorials

[UI in Core](../tutorials/ui_reference.md)
