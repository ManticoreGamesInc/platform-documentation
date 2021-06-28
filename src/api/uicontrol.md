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
| `width` | `integer` | Horizontal size of the control. | Read-Write |
| `height` | `integer` | Vertical size of the control. | Read-Write |
| `rotationAngle` | `number` | rotation angle of the control. | Read-Write |

## Examples

Example using:

### `x`

### `y`

### `rotationAngle`

Being able to control the position and rotation of UI elements is an extremely valuable skill when developing games in Core. This example will show you how you can change the position of a UI element by using the `x` and `y` properties of that element. Also, this example will demonstrate how to set the rotatation a UI element by using the `rotationAngle` property of that UI element.

This example will move a UI object in a circlular path while also rotating that UI object.

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

[UI in Core](../tutorials/ui_reference.md)
