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

## Examples

Example using:

### `opacity`

UI transitions provide a great way for you to show your creativity to players. This example will show you how to create a simple fade in. This script will cause the UI Container and all of the children of the UI Container to fade into view over 4 seconds by using the `opacity` property of the UI Container.

```lua
-- "timePassed" will keep track of the number of seconds that have passed since
-- the script began running
local timePassed = 0

-- Get the UIContainer object
local propUIContainer = script:GetCustomProperty("UIContainer"):WaitForObject()

function Tick(deltaTime)
    -- Update the "timePassed" to keep track of the number of seconds that have passed
    timePassed = timePassed + deltaTime

    -- Pick a value between 0 and 1 based on a percent (timepassed * 0.25)
    -- If the expression (timepassed * 0.25) is less than or equal to 0, the "Lerp" function will output 0
    -- If the expression (timepassed * 0.25) is greater than or equal to 1, the "Lerp" function will output 0
    -- If the expression (timepassed * 0.25) is in between 0 and 1, the "Lerp" function will output a value between 0 and 1
    local newOpacity = CoreMath.Lerp(0, 1, timePassed * 0.25)

    -- Update the opacity of the UIContainer and all of its children
    propUIContainer.opacity = newOpacity
end
```

See also: [CoreMath.Lerp](coremath.md) | [CoreObject.GetCustomProperty](coreobject.md)

---

## Tutorials

[UI in Core](../tutorials/ui_reference.md)
