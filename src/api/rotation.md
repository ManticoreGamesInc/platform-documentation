---
id: rotation
name: Rotation
title: Rotation
tags:
    - API
---

# API: Rotation

## Description

An euler-based rotation around `x`, `y`, and `z` axes.

## API

### Constructors

| Constructor Name | Return Type | Description | Tags |
| ----------- | ----------- | ----------- | ---- |
| `Rotation.New([Number x, Number y, Number z])` | `Rotation` | Construct a rotation with the given values, defaults to (0, 0, 0). | None |
| `Rotation.New(Quaternion q)` | `Rotation` | Construct a rotation using the given Quaternion. | None |
| `Rotation.New(Vector3 forward, Vector3 up)` | `Rotation` | Construct a rotation that will rotate Vector3.FORWARD to point in the direction of the given forward vector, with the up vector as a reference. Returns (0, 0, 0) if forward and up point in the exact same (or opposite) direction, or if one of them is of length 0. | None |
| `Rotation.New(Rotation r)` | `Rotation` | Copies the given Rotation. | None |

### Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `x` | `Number` | The `x` component of the Rotation. | Read-Write |
| `y` | `Number` | The `y` component of the Rotation. | Read-Write |
| `z` | `Number` | The `z` component of the Rotation. | Read-Write |

### Operators

| Operator Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Rotation + Rotation` | `Rotation` | Add two rotations together. Note that this adds the individual components together, and may not provide the same result as if the two rotations were applied in sequence. | None |
| `Rotation - Rotation` | `Rotation` | Subtract a rotation. | None |
| `Rotation * Rotation` | `Rotation` | Combines two rotations, with the result applying the right rotation first, then the left rotation second. | None |
| `Rotation * Number` | `Rotation` | Returns the scaled rotation. | None |
| `-Rotation` | `Rotation` | Returns the inverse rotation. | None |
| `Rotation * Vector3` | `Vector3` | Rotates the right-side vector and returns the result. | None |

## Examples

### `New`

### `ZERO`

There are several different ways to create new Rotations.

```lua
-- Calling the constructor without arguments generates a zero rotation.
-- (Rotates by zero degrees, so no change.)
local zeroRotation = Rotation.New()

-- You can also describe a rotation by providing Euler angles:
-- This rotation will rotate something 90 degrees around the Z axis.
local rotation90z = Rotation.New(0, 0, 90)

-- Quaternions can be transformed into Rotations using constructors.
-- This will produce a 90 degree rotation. (From a 90 degree Quaternion)
local quatRotation = Rotation.New(Quaternion.New(Vector3.UP, 90))

-- You can also use the Rotation constructor to generate a rotation that would
-- transform Vector3.FORWARD (0, 1, 0) to point in the given direction.
-- (You also have to provide it with an up vector, to use as a reference.)
local vec1 = Vector3.New(3, 4, 5)
local vecRotation = Rotation.New(vec1, Vector3.UP)
local vec2 = vecRotation * Vector3.FORWARD
-- vec2 now points in the same direction as vec1.

-- The constructor can also be used to copy rotations:
local rotationCopy = Rotation.New(rotation90z)

-- Rotation.ZERO can be used to quickly generate a rotation of zero
-- degrees. (So it won't change anything.)
local newVec1 = Rotation.ZERO * vec1
-- newVec1 is still the same as vec1, because it hasn't rotated.
```

### `Rotation+Rotation`

### `Rotation-Rotation`

### `Rotation*Number`

### `-Rotation`

### `Rotation*Vector3`

You can add and subtract rotations from each other, scale them, and apply them to vectors via arithmetic operators.

```lua
local rotate90x = Rotation.New(90, 0, 0)
local rotate90y = Rotation.New(0, 90, 0)
local rotate90z = Rotation.New(0, 0, 90)

-- Add two rotations together to get their sum:
local rotate90xy = rotate90x + rotate90y
-- This is now (90, 90, 0)

-- Subtract a rotation from another to find the difference:
local new_rotate90x = rotate90xy - rotate90y
-- This is now (90, 0, 0)

-- You can scale a rotation by multiplying it by a number.
local rotate180x = rotate90x * 2
-- This is now (180, 0, 0)

-- Multiplying a rotation by a vector applies the rotation to the vector and returns
-- the rotated vector as a result.
local forwardVec = Vector3.New(10, 0, 0)
local rightVec = rotate90z * forwardVec
-- rightVec is now (0, 10, 0)

-- You can invert a rotation via the minus sign:
local rotate90x_negative = -rotate90x
-- This is now (-90, 0, 0)
```

### `x`

### `y`

### `z`

The x, y, and z components of a rotation can be accessed directly. These numbers represent the number of degrees to rotate around their respective axis.

```lua
local newRotation = Rotation.New()
newRotation.x = 90
newRotation.y = 45
newRotation.z = 180
-- This creates a rotation of 90 degrees about the x axis, 45 degrees about the y axis, and
-- 180 degrees about the z axis.
```
