---
id: uiscrollpanel
name: UIScrollPanel
title: UIScrollPanel
tags:
    - API
---

# UIScrollPanel

A UIControl that supports scrolling a child UIControl that is larger than itself. Inherits from [UIControl](uicontrol.md).

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `orientation` | [`Orientation`](enums.md#orientation) | Determines whether the panel scrolls horizontally or vertically. Default is `Orientation.VERTICAL`. | Read-Write |
| `scrollPosition` | `number` | The position in UI space of the scroll panel content. Defaults to 0, which is scrolled to the top or left, depending on orientation. Set to the value of `contentLength` to scroll to the end. | Read-Write |
| `contentLength` | `number` | Returns the height or width of the scroll panel content, depending on orientation. This is the maximum value of `scrollPosition`. | Read-Only |
| `isInteractable` | `boolean` | When `true`, panel scrolling is enabled. When `false`, scrolling is disabled. Defaults to `true`. | Read-Write |

## Examples

Example using:

### `contentLength`

### `isInteractable`

### `scrollPosition`

In this example, a scroll panel has two functions that can be called to animate the scroll position to the top or botton: `ScrollToTop()` and `ScrollToBottom()`. The panel's `isInteractable` property is temporarily set to false during an auto-scroll, to prevent the user's manual scrolling from interfering with the animation. Such bad interaction between manual and auto scrolling is more likely at lower `Lerp` speeds.

```lua
local UISCROLL_PANEL = script:GetCustomProperty("UIScrollPanel"):WaitForObject()
local LERP_SPEED = 6

UI.SetCursorVisible(true)
UI.SetCanCursorInteractWithUI(true)

local scrollTarget = nil

function ScrollToTop()
    scrollTarget = 0
    UISCROLL_PANEL.isInteractable = false
end

function ScrollToBottom()
    scrollTarget = UISCROLL_PANEL.contentLength
    UISCROLL_PANEL.isInteractable = false
end

function Tick(deltaTime)
    if scrollTarget then
        local t = CoreMath.Clamp(deltaTime * LERP_SPEED)
        local newScrollPosition = CoreMath.Lerp(UISCROLL_PANEL.scrollPosition, scrollTarget, t)
        
        if math.abs(newScrollPosition - scrollTarget) < 1 then
            newScrollPosition = scrollTarget
            scrollTarget = nil
            UISCROLL_PANEL.isInteractable = true
        end
        UISCROLL_PANEL.scrollPosition = newScrollPosition
    end
end
```

See also: [UI.SetCursorVisible](ui.md) | [CoreMath.Lerp](coremath.md) | [CoreObject.GetCustomProperty](coreobject.md)

---

## Learn More

[UI in Core](../references/ui.md)
