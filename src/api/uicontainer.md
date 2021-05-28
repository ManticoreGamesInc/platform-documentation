---
id: uicontainer
name: UIContainer
title: UIContainer
tags:
    - API
---

# UIContainer

A UIContainer is a type of UIControl. All other UI elements must be a descendant of a UIContainer to be visible. It does not have a position or size. It is always the size of the entire screen. It has no properties or functions of its own, but inherits everything from CoreObject.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `opacity` | `number` | Controls the opacity of the container's contents by multiplying the alpha component of descendants' colors. Note that other UIPanels and UIContainers in the hierarchy may also contribute their own opacity values. A resulting alpha value of 1 or greater is fully opaque, 0 is fully transparent. | Read-Write |

## Tutorials

[UI in Core](../tutorials/ui_reference.md)
