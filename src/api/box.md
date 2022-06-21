---
id: box
name: Box
title: Box
tags:
    - API
---

# Box

A 3D box aligned to some coordinate system.

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetCenter()` | [`Vector3`](vector3.md) | Returns the coordinates of the center of the box. | None |
| `GetExtent()` | [`Vector3`](vector3.md) | Returns a Vector3 representing half the size of the box along its local axes. | None |
| `GetTransform()` | [`Transform`](transform.md) | Returns a Transform which, when applied to a unit cube, produces a result matching the position, size, and rotation of this box. | None |

## Examples

Example using:

### `GetTransform`

### `GetCenter`

In this example, we get the bounding box of a static mesh that can be used to check what objects it is overlapping with. This can be useful when building placement systems where the player can move objects around in the world, but you need to prevent them from overlapping other objects. This example will turn the object being moved around red when it overlaps another object.

```lua
-- Client Script

-- The static mesh object (for example, a Cube) to move around at the pointer position.
local OBJECT = script:GetCustomProperty("Object"):WaitForObject()

-- Ground/Floor that will be ignored.
local DEFAULT_FLOOR = script:GetCustomProperty("DefaultFloor"):WaitForObject()

UI.SetCursorVisible(true)

function Tick()
    local hit = UI.GetHitResult(Input.GetPointerPosition())

    if hit ~= nil then
        local position = hit:GetImpactPosition()

        -- Get the bounding box of the object (Static Mesh)
        local box = OBJECT:GetBoundingBox()
        local transform = box:GetTransform()
        local rotation = transform:GetRotation()
        local scale = transform:GetScale()

        -- Find what objects are overlapping with the OBJECT. Using the Box we can set these perfectly.
        local overlappingObjects = World.FindObjectsOverlappingBox(box:GetCenter(), scale * 100, {

            ignoreObjects = { DEFAULT_FLOOR },
            ignorePlayers = true,
            shapeRotation = rotation

        })

        -- Draw the box so we can see if it does match the correct size of the mesh.
        CoreDebug.DrawBox(box:GetCenter(), scale * 100, {

            thickness = 1.5, duration = .1, color = Color.YELLOW, rotation = rotation

        })

        -- If the number of overlapping objects is greater than 0, then set the OBJECT color to red.
        if #overlappingObjects > 0 then
            OBJECT:SetColor(Color.RED)
        else
            OBJECT:ResetColor()
        end

        -- Update the position of the object based on the hit impact position.
        OBJECT:SetWorldPosition(position)
    end
end
```

See also: [Transform.GetScale](transform.md) | [CoreLua.Tick](coreluafunctions.md) | [UI.SetCursorVisible](ui.md) | [CoreObjectReference.WaitForObject](coreobjectreference.md) | [CoreObject.GetCustomProperty](coreobject.md) | [World.FindObjectsOverlappingBox](world.md) | [CoreDebug.DrawBox](coredebug.md) | [CoreMesh.SetColor](coremesh.md)

---
