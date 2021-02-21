---
id: uicontrol
name: UIControl
title: UIControl
tags:
    - API
---

# UIControl

UIControl is a CoreObject which serves as a base class for other UI controls.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `anchor` | [`UIPivot`](enums.md#uipivot) | The pivot point on this control that attaches to its parent. Can be one of `UIPivot.TOP_LEFT`, `UIPivot.TOP_CENTER`, `UIPivot.TOP_RIGHT`, `UIPivot.MIDDLE_LEFT`, `UIPivot.MIDDLE_CENTER`, `UIPivot.MIDDLE_RIGHT`, `UIPivot.BOTTOM_LEFT`, `UIPivot.BOTTOM_CENTER`, `UIPivot.BOTTOM_RIGHT`, or `UIPivot.CUSTOM`. | Read-Write |
| `dock` | [`UIPivot`](enums.md#uipivot) | The pivot point on this control to which children attach. Can be one of `UIPivot.TOP_LEFT`, `UIPivot.TOP_CENTER`, `UIPivot.TOP_RIGHT`, `UIPivot.MIDDLE_LEFT`, `UIPivot.MIDDLE_CENTER`, `UIPivot.MIDDLE_RIGHT`, `UIPivot.BOTTOM_LEFT`, `UIPivot.BOTTOM_CENTER`, `UIPivot.BOTTOM_RIGHT`, or `UIPivot.CUSTOM`. | Read-Write |
| `x` | `number` | Screen-space offset from the anchor. | Read-Write |
| `y` | `number` | Screen-space offset from the anchor. | Read-Write |
| `width` | `number` | Horizontal size of the control. | Read-Write |
| `height` | `number` | Vertical size of the control. | Read-Write |
| `rotationAngle` | `number` | rotation angle of the control. | Read-Write |

## Tutorials

[UI in Core](../tutorials/ui_reference.md)
