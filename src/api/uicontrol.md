---
id: uicontrol
name: UIControl
title: UIControl
tags:
    - API
    - UI
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
| `width` | `integer` | Horizontal size of the control. | Read-Write |
| `height` | `integer` | Vertical size of the control. | Read-Write |
| `rotationAngle` | `number` | rotation angle of the control. | Read-Write |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetAbsolutePosition()` | [`Vector2`](vector2.md) | Returns the absolute screen position of the pivot for this control. | Client-Only |
| `SetAbsolutePosition(Vector2)` | `None` | Sets the absolute screen position of the pivot for this control. | Client-Only |
| `GetAbsoluteRotation()` | `number` | Returns the absolute rotation in degrees (clockwise) for this control. | Client-Only |
| `SetAbsoluteRotation(number)` | `None` | Sets the absolute rotation in degrees (clockwise) for this control. | Client-Only |

## Examples

Example using:

### `anchor`

### `dock`

In this example, a client script controls the anchoring of a `UI Image`. The image is positioned on screen to reflect the player's movement input. If the player is not moving, then the image is at the center of the screen. If the player moves horizontally, the image is placed on the left/right side of the screen and on the top/bottom of the screen if the player is moving forward/backwards, respectively.

```lua
local UI_IMAGE = script.parent

function Tick()
    local movement = Input.GetActionValue(Game.GetLocalPlayer(), "Move")

    local x = movement.x
    local y = movement.y
    local pivot = UIPivot.MIDDLE_CENTER

    if y > 0 then
        if x > 0 then
            pivot = UIPivot.TOP_RIGHT
        elseif x < 0 then
            pivot = UIPivot.TOP_LEFT
        else
            pivot = UIPivot.TOP_CENTER
        end
    elseif y < 0 then
        if x > 0 then
            pivot = UIPivot.BOTTOM_RIGHT
        elseif x < 0 then
            pivot = UIPivot.BOTTOM_LEFT
        else
            pivot = UIPivot.BOTTOM_CENTER
        end
    else
        if x > 0 then
            pivot = UIPivot.MIDDLE_RIGHT
        elseif x < 0 then
            pivot = UIPivot.MIDDLE_LEFT
        end
    end

    UI_IMAGE.anchor = pivot
    UI_IMAGE.dock = pivot
end
```

See also: [Input.GetActionValue](input.md) | [Game.GetLocalPlayer](game.md) | [Vector2.x](vector2.md)

---

Example using:

### `width`

### `height`

Most of the UI components inherit from `UI Control` and have all if its properties. This client script demonstrates how to animate the size of a `UI Panel`. By calling `Grow()` or `Shrink()` the panel's size animates smoothly over time.

```lua
local UI_PANEL = script:GetCustomProperty("UIPanel"):WaitForObject()
local LERP_SPEED = 12

local defaultWidth = UI_PANEL.width
local defaultHeight = UI_PANEL.height
local targetScale = 1
local fWidth = defaultWidth
local fHeight = defaultHeight

function Grow()
    targetScale = 1
end

function Shrink()
    targetScale = 0
end

function Tick(deltaTime)
    local t = CoreMath.Clamp(deltaTime * LERP_SPEED)

    fWidth = CoreMath.Lerp(fWidth, defaultWidth * targetScale, t)
    fHeight = CoreMath.Lerp(fHeight, defaultHeight * targetScale, t)

    UI_PANEL.width = CoreMath.Round(fWidth)
    UI_PANEL.height = CoreMath.Round(fHeight)
end
```

See also: [CoreMath.Lerp](coremath.md) | [CoreObject.GetCustomProperty](coreobject.md) | [CoreObjectReference.WaitForObject](coreobjectreference.md)

---

Example using:

### `x`

### `y`

This client script demonstrates how to animate a `UI Panel` to make it enter and exit the screen smoothly. By calling either `Show()` or `Hide()` we set the panel's desired position. In the Tick function we use `Lerp()` to update the value, which gives the animation an "ease out" behavior.

```lua
local UI_PANEL = script:GetCustomProperty("UIPanel"):WaitForObject()
local LERP_SPEED = 12

local START_POS = Vector2.New(UI_PANEL.x, UI_PANEL.y)
local destination = START_POS

function Show()
    destination = START_POS
end

function Hide()
    destination.y = START_POS.y + 800
end

function Tick(deltaTime)
    local t = CoreMath.Clamp(deltaTime * LERP_SPEED)
    local pos = Vector2.New(UI_PANEL.x, UI_PANEL.y)
    pos = Vector2.Lerp(pos, destination, t)
    UI_PANEL.x = pos.x
    UI_PANEL.y = pos.y
end
```

See also: [Vector2.Lerp](vector2.md) | [CoreObject.GetCustomProperty](coreobject.md) | [CoreObjectReference.WaitForObject](coreobjectreference.md)

---

Example using:

### `x`

### `y`

### `rotationAngle`

Being able to control the position and rotation of UI elements is an extremely valuable skill when developing games in Core. This example will show you how you can change the position of a UI element by using the `x` and `y` properties of that element. Also, this example will demonstrate how to set the rotation a UI element by using the `rotationAngle` property of that UI element.

This example will move a UI object in a circular path while also rotating that UI object.

```lua
-- Get the UI object
local propUIObject = script:GetCustomProperty("UIObject"):WaitForObject()

-- Keep track of the number of seconds that have passed since the script began running
local timePassed = 0

function Tick(deltaTime)
    -- Update the "timePassed" to keep track of the number of seconds that have passed
    timePassed = timePassed + deltaTime

    -- Calculate the position of the UI Object
    local x_position = math.sin(timePassed) * 100

    -- Calculate the y position of the UI Object
    local y_position = math.cos(timePassed) * 100

    -- Update the x position of the UI object
    propUIObject.x = x_position

    -- Update the y position of the UI object
    propUIObject.y = y_position

    -- Update the rotation of the UI Object
    propUIObject.rotationAngle = timePassed * 360
end
```

See also: [CoreObject.GetCustomProperty](coreobject.md)

---

## Tutorials

[UI in Core](../references/ui.md)
