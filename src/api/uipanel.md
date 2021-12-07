---
id: uipanel
name: UIPanel
title: UIPanel
tags:
    - API
---

# UIPanel

A UIControl which can be used for containing and laying out other UI controls. Inherits from [UIControl](uicontrol.md).

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `shouldClipChildren` | `boolean` | If `true`, children of this UIPanel will not draw outside of its bounds. | Read-Write |
| `opacity` | `number` | Controls the opacity of the panel's contents by multiplying the alpha component of descendants' colors. Note that other UIPanels and UIContainers in the hierarchy may also contribute their own opacity values. A resulting alpha value of 1 or greater is fully opaque, 0 is fully transparent. | Read-Write |

## Examples

Example using:

### `opacity`

This example shows how to fade in/out a UI Panel based on calls to `Show()` and `Hide()` functions.

```lua
local UI_PANEL = script:GetCustomProperty("UIPanel"):WaitForObject()
local LERP_SPEED = 14

local isShowing = false

UI_PANEL.opacity = 0

function Show()
    isShowing = true
end

function Hide()
    isShowing = false
end

function Tick(deltaTime)
    -- Select desired opacity based on state
    targetOpacity = 0
    if isShowing then
        targetOpacity = 1
    end
    -- Keep the time delta between 0 and 1
    local t = CoreMath.Clamp(deltaTime * LERP_SPEED)
    -- Interpolate the opacity value towards the desired value
    UI_PANEL.opacity = CoreMath.Lerp(UI_PANEL.opacity, targetOpacity, t)
end
```

See also: [CoreMath.Lerp](coremath.md) | [CoreObject.GetCustomProperty](coreobject.md)

---

## Tutorials

[UI in Core](../references/ui.md)
