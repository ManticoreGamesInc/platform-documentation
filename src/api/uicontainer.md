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
| `cylinderArcAngle` | `number` | When the container is rendered in 3D space, this adjusts the curvature of the canvas in degrees. Changing this value will force a redraw. | Read-Write |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetCanvasSize()` | [`Vector2`](vector2.md) | Returns the size of the canvas when drawn in 3D space. | None |
| `SetCanvasSize(Vector2)` | `None` | Sets the size of the canvas when drawn in 3D space. | None |

## Examples

Example using:

### `SetCanvasSize`

### `GetCanvasSize`

In this example a 3D UI Container object will grow and shrink through the use of an event based animation system. For this example to work, the UI Container must have its **Is Screen Space** setting disabled.

```lua
-- Get the UI Container
local propUIContainer = script:GetCustomProperty("UIContainer"):WaitForObject()

-- Time required to scale in or scale out
local SCALE_TIME = 2

-- The calculated scale of the UI Container
local scale = 1

-- Get the original size of the canvas before scaling
local startingSize = propUIContainer:GetCanvasSize()

-- Determines whether the UI Container will be sacling in or out
-- A value of 0 means that there will be no change in scale
-- A value of 1 means that the UI Container will scale in
-- A value of -1 means that the UI Container will scale out
local scaleDirection = 0

function ScaleIn()
    scale = 0
    scaleDirection = 1
end

Events.Connect("Scale In UI", ScaleIn)

function ScaleOut()
    scale = 1
    scaleDirection = -1
end

Events.Connect("Scale Out UI", ScaleOut)

function Tick(deltaTime)
    -- If the "scaleDirection" is 0, we can immediately exit this function because no changes
    -- will be made to the scale of the UI Container.
    if scaleDirection == 0 then
        return
    end
    -- Calculate the current scale based on the "scaleDirection" and "deltaTime"
    scale = scale + (scaleDirection * deltaTime/SCALE_TIME)

    -- Clamp the calculate scale between 0 and 1
    local clampedScale = CoreMath.Clamp(scale, 0, 1)

    -- If the "clampedScale" is different from the calculated "scale" the must
    -- scaling animation must finished meaning "scaleDirection" can return to 0
    if scale ~= clampedScale then
        scaleDirection = 0
    end

    -- Update the scale of the UI Container
    propUIContainer:SetCanvasSize(startingSize * clampedScale)
end

-- Scale the UI in and then scale the UI out
Task.Spawn(function ()
    Events.Broadcast("Scale In UI")
    Task.Wait(SCALE_TIME)
    Events.Broadcast("Scale Out UI")
end)
```

See also: [Events.Broadcast](events.md) | [CoreMath.Clamp](coremath.md)

---

Example using:

### `cylinderArcAngle`

In this example a 3D UI Container will continuously look at the player and bend as players get closer. For this example to work, the UI Container must have the **Is Screen Space** setting disabled in the properties window.

```lua
-- Get the UI Container
local propContainer = script:GetCustomProperty("UIContainer"):WaitForObject()

-- Get the local player
local player = Game.GetLocalPlayer()

-- Force the UI Container to constantly look at the player
propContainer:LookAtContinuous(player)

-- The maximum distance at which the player's distance from the UI Container will affect
-- the curvature of the UI container
local MAX_DIST = 5000

function Tick(deltaTime)
    -- Determine the distance between the UI Container and the local player
    local distance = (propContainer:GetWorldPosition() - player:GetWorldPosition()).size

    -- Clamp the calculated distance between the values of 0 and "MAX_DIST"
    distance = CoreMath.Clamp(distance, 0, MAX_DIST)

    -- Calculate the arc angle of the UI container based on the distance from the local player to the
    -- UI Container
    local curvatureAngle = 180 - CoreMath.Lerp(0, 180, distance/MAX_DIST)

    -- Update the arc angle of the UI Container
    propContainer.cylinderArcAngle = curvatureAngle
end
```

See also: [CoreObject.LookAtContinuous](coreobject.md) | [CoreMath.Lerp](coremath.md)

---

Example using:

### `opacity`

This example will fade a UI Container in and out using events.

```lua
-- Get the UI Container
local propUIContainer = script:GetCustomProperty("UIContainer"):WaitForObject()

-- Time required to fade in or fade out
local FADE_TIME = 2

-- The calculated opacity of the UI Container
local opacity = 1

-- Determines whether the UI Container will be fading in or out
-- A value of 0 means that there will be no change in opacity
-- A value of 1 means that the UI Container will fade in
-- A value of -1 means that the UI Container will fade out
local fadeDirection = 0

-- This function will prepare the UI Container to be faded in
function FadeIn()
    opacity = 0
    fadeDirection = 1
end
-- Bind the "FadeIn" function to the "Fade In UI" event
Events.Connect("Fade In UI", FadeIn)

-- This function will prepare the UI Container to be faded out
function FadeOut()
    opacity = 1
    fadeDirection = -1
end
-- Bind the "FadeOut" function to the "Fade Out UI" event
Events.Connect("Fade Out UI", FadeOut)

function Tick(deltaTime)
    -- If the "fadeDirection" is 0, we can immediately exit this function because no changes
    -- will be made to the opacity of the UI Container.
    if(fadeDirection == 0) then
        return
    end
    -- Calculate the current opacity based on the "fadeDirection" and "deltaTime"
    opacity = opacity + (fadeDirection * deltaTime/FADE_TIME)

    -- Clamp the calculate opacity between 0 and 1
    local clampedOpacity = CoreMath.Clamp(opacity, 0, 1)

    -- If the "clampedOpacity" is different from the calculated "opacity" the must
    -- fading animation must finished meaning "fadeDirection" can return to 0
    if(opacity ~= clampedOpacity) then
        fadeDirection = 0
    end

    -- Update the opacity of the UI Container
    propUIContainer.opacity = clampedOpacity
end

-- Fade the UI in and then fade the UI out
Task.Spawn(function ()
    Events.Broadcast("Fade In UI")
    Task.Wait(FADE_TIME)
    Events.Broadcast("Fade Out UI")
end)
```

See also: [Events.Broadcast](events.md) | [CoreMath.Clamp](coremath.md)

---

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

[UI in Core](../references/ui.md)
