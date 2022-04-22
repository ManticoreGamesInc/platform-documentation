---
id: rectangle
name: Rectangle
title: Rectangle
tags:
    - API
---

# Rectangle

A rectangle defined by upper-left and lower-right corners. Generally assumed to be used within screen space, so the Y axis points down. This means the bottom of the rectangle is expected to be a higher value than the top.

## Constructors

| Constructor Name | Return Type | Description | Tags |
| ----------- | ----------- | ----------- | ---- |
| `Rectangle.New([number left, number top, number right, number bottom])` | [`Rectangle`](rectangle.md) | Constructs a Rectangle with the given `left`, `top`, `right`, `bottom` values, defaults to (0, 0, 0, 0). | None |
| `Rectangle.New(Rectangle r)` | [`Rectangle`](rectangle.md) | Constructs a Rectangle with values from the given Rectangle. | None |
| `Rectangle.New(Vector4 v)` | [`Rectangle`](rectangle.md) | Constructs a Rectangle with `left`, `top`, `right`, and `bottom` values taken from the given Vector4's `x`, `y`, `z`, and `w` properties, respectively. | None |

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `left` | `number` | The position of the left edge of the rectangle. | Read-Write |
| `top` | `number` | The position of the top edge of the rectangle. | Read-Write |
| `right` | `number` | The position of the right edge of the rectangle. | Read-Write |
| `bottom` | `number` | The position of the bottom edge of the rectangle. | Read-Write |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetSize()` | [`Vector2`](vector2.md) | Returns a Vector2 indicating the width and height of the rectangle. | None |
| `GetCenter()` | [`Vector2`](vector2.md) | Returns a Vector2 indicating the coordinates of the center of the rectangle. | None |

## Examples

Example using:

### `New`

### `left`

### `right`

### `top`

### `bottom`

### `GetSize`

### `GetCenter`

In this example, we search through all `Static Mesh` objects to figure out the effective play area of the game. The `Rectangle` type is used for storing the results, throughout the search, plus contains some helpful functions for calculating the size and center.

```lua
-- These variables will contain the results of the search
local bounds = Rectangle.New()
local minXObject = nil
local maxXObject = nil
local minYObject = nil
local maxYObject = nil

-- Grab the list of all Static mesh objects
local allObjects = World.FindObjectsByType("StaticMesh")

-- Search
for _, obj in ipairs(allObjects) do
    local position = obj:GetWorldPosition()
    
    if bounds.left > position.y or minYObject == nil then
        bounds.left = position.y
        minYObject = obj
    end
    if bounds.right < position.y or maxYObject == nil then
        bounds.right = position.y
        maxYObject = obj
    end
    if bounds.top > position.x or minXObject == nil then
        bounds.top = position.x
        minXObject = obj
    end
    if bounds.bottom < position.x or maxXObject == nil then
        bounds.bottom = position.x
        maxXObject = obj
    end
end

-- Output results
print("Bounds = " .. tostring(bounds))
print()
print("Left-most object: ", minYObject.name, tostring(minYObject))
print("Right-most object: ", maxYObject.name, tostring(maxYObject))
print("Back-most object: ", minXObject.name, tostring(minXObject))
print("Front-most object: ", maxXObject.name, tostring(maxXObject))
print()

local playArea = bounds:GetSize()
local center = bounds:GetCenter()
print("Total play area: " .. tostring(playArea))
print("Center of map: " .. tostring(center))
```

See also: [World.FindObjectsByType](world.md) | [CoreObject.GetWorldPosition](coreobject.md) | [Vector3.x](vector3.md)

---
