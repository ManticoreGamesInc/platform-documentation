---
id: ui_reference
name: UI Reference
title: UI Reference
tags:
    - Reference
---

# User Interfaces in Core

## Overview

UI in Core includes all the 2D elements that can be used to build menus, notifications, dialogue boxes, and head's up display's (HUD's). Creating UI Elements is mostly a drag-and-drop process, where any UI element added to the scene

## Client-Server Communication

## UI Container Types

<!-- TODO: Add examples and explanation -->

## UI Properties

### UI Control Properties

[UIControl](https://docs.coregames.com/api/uicontrol/) is the parent of all UI elements, and these properties apply to almost all UI elements in Core.

| Property | Definition |
| --- | --- |
| **X and Y Offset** | The distance from the anchor origin that the UI widget will display |
| **Width and Height** | Size of this UI element |
| **Rotation Angle** | Rotation angle using the anchor point as the pivot |
| **Inherit Parent Width and Height** | Whether the widget stretches in size to fit the transformations of the parent |
| **Adjust Self Size to Inherited Size** |  When the *Inherit Parent Size* boxes is checked on, adds the dimensions on this UI element to the dimensions of the parent element |
| **Anchor** | Which corner, edge, or center the element is the origin, for positioning and rotation |
| **Dock** | Which corner, edge, or center of the parent the anchor is relative to. |

### UI Text Box Properties

**UI Text Boxes** can have different colors, fonts and display options, depending on the space they need to occupy.

| Property | Definition |
| --- | --- |
| **Text** | The string of text that gets displayed |
| **Color** | The color of the font |
| **Size** | The size of the font |
| **Font** | The typeface used for the text |
| **Justification** | the alignment of the text within the text box |
| **Wrap Text** | Whether or not the text starts on a new line when it exceeds the width of the box |
| **Clip Text** | Whether or not text that exceeds the box size will be hidden. |

### UI Text Fonts

![Sample of Core Fonts]()
