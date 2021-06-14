---
id: uiscrollpanel
name: UIScrollPanel
title: UIScrollPanel
tags:
    - API
---

# UIScrollPanel

A UIControl that supports scrolling a child UIControl that is larger than itself.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `orientation` | [`Orientation`](enums.md#orientation) | Determines whether the panel scrolls horizontally or vertically. Default is `Orientation.VERTICAL`. | Read-Write |
| `scrollPosition` | `number` | The position in UI space of the scroll panel content. Defaults to 0, which is scrolled to the top or left, depending on orientation. Set to the value of `contentLength` to scroll to the end. | Read-Write |
| `contentLength` | `number` | Returns the height or width of the scroll panel content, depending on orientation. This is the maximum value of `scrollPosition`. | Read-Only |

## Learn More

[UI in Core](../tutorials/ui_reference.md)
