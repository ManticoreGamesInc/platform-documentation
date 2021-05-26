---
id: uipanel
name: UIPanel
title: UIPanel
tags:
    - API
---

# UIPanel

A UIControl which can be used for containing and laying out other UI controls.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `shouldClipChildren` | `boolean` | If `true`, children of this UIPanel will not draw outside of its bounds. | Read-Write |
| `opacity` | `number` | Controls the opacity of the panel's contents by multiplying the alpha component of descendants' colors. Note that other UIPanels and UIContainers in the hierarchy may also contribute their own opacity values. A resulting alpha value of 1 or greater is fully opaque, 0 is fully transparent. | Read-Write |

## Tutorials

[UI in Core](../tutorials/ui_reference.md)
