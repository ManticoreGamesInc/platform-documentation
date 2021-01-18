# Quaternion

## Description

A quaternion-based representation of a rotation.

## API

### Constructors

| Constructor Name | Return Type | Description | Tags |
| ----------- | ----------- | ----------- | ---- |
| `Quaternion.New([Number x, Number y, Number z, Number w])` | `Quaternion` | Constructs a Quaternion with the given values.  Defaults to 0, 0, 0, 1. | None |
| `Quaternion.New(Rotation r)` | `Quaternion` | Constructs a Quaternion with the given Rotation. | None |
| `Quaternion.New(Vector3 axis, Number angle)` | `Quaternion` | Constructs a Quaternion representing a rotation of angle degrees around the axis of the Vector3. | None |
| `Quaternion.New(Vector3 from, Vector3 to)` | `Quaternion` | Constructs a Quaternion between the `from` and `to` of the Vector3s. | None |
| `Quaternion.New(Quaternion q)` | `Quaternion` | Copies the given Quaternion. | None |

### Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `x` | `Number` | The `x` component of the Quaternion. | Read-Write |
| `y` | `Number` | The `y` component of the Quaternion. | Read-Write |
| `z` | `Number` | The `z` component of the Quaternion. | Read-Write |
| `w` | `Number` | The `w` component of the Quaternion. | Read-Write |

### Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetRotation()` | `Rotation` | Get the Rotation representation of the Quaternion. | None |
| `GetForwardVector()` | `Vector3` | Forward unit vector rotated by the quaternion. | None |
| `GetRightVector()` | `Vector3` | Right unit vector rotated by the quaternion. | None |
| `GetUpVector()` | `Vector3` | Up unit vector rotated by the quaternion. | None |

### Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `Quaternion.Slerp(Quaternion from, Quaternion to, Number progress)` | `Quaternion` | Spherical interpolation between two quaternions by the specified progress amount and returns the resultant, normalized Quaternion. | None |

### Operators

| Operator Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Quaternion + Quaternion` | `Quaternion` | Component-wise addition. | None |
| `Quaternion - Quaternion` | `Quaternion` | Component-wise subtraction. | None |
| `Quaternion * Quaternion` | `Quaternion` | Compose two quaternions, with the result applying the right rotation first, then the left rotation second. | None |
| `Quaternion * Number` | `Quaternion` | Multiplies each component by the right-side Number. | None |
| `Quaternion * Vector3` | `Vector3` | Rotates the right-side vector and returns the result. | None |
| `Quaternion / Number` | `Quaternion` | Divides each component by the right-side Number. | None |
| `-Quaternion` | `Quaternion` | Returns the inverse rotation. | None |

## Examples

### Quaternion.Slerp

### Quaternion.GetRotation

### Quaternion.GetRightVector

### Quaternion.GetUpVector

### Quaternion.GetForwardVector

`Quaternion.Slerp` is a function for finding a quaternion that is part way between two other quaternions. Since quaternions represent rotations, this means a rotation that is part way between two other rotations. When combined with a tick function or loop, we can use it to smoothly animate something rotating.

`Quaternion.GetRotation` is useful if you need to convert a quaternion into a rotation variable. (For passing to functions like `CoreObject:SetWorldRotation()` for example.)

We can also access various unit vectors, as transformed by the quaternion, via `Quaternion:GetForwardVector`, `Quaternion:GetRightVector`, and`Quaternion:GetUpVector`.

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")
local myObject = World.SpawnAsset(propCubeTemplate,
    { position = Vector3.New(500, 0, 500)})

local startQuat = Quaternion.IDENTITY
local endQuat = Quaternion.New(Vector3.UP, 120)

local steps = 300
steps = 30 -- UT_STRIP
local objectPos = myObject:GetWorldPosition()
for i = 1, steps do
    -- Rotate this quaternion over time
    local currentQuat = Quaternion.Slerp(startQuat, endQuat, i/steps)
    myObject:SetWorldRotation(currentQuat:GetRotation())
    -- need to figure out how to test this better. UT_STRIP

    CoreDebug.DrawLine(objectPos, objectPos + currentQuat:GetForwardVector() * 1000,
        { thickness = 5, color = Color.RED })
    CoreDebug.DrawLine(objectPos, objectPos + currentQuat:GetRightVector() * 1000,
        { thickness = 5, color = Color.GREEN })
    CoreDebug.DrawLine(objectPos, objectPos + currentQuat:GetUpVector() * 1000,
        { thickness = 5, color = Color.BLUE })

    Task.Wait()
end

ut.EXPECT_QUAT_EQUAL(Quaternion.Slerp(startQuat, endQuat, 0), startQuat, "SLERP start")
ut.EXPECT_QUAT_EQUAL(Quaternion.Slerp(startQuat, endQuat, 1.0), endQuat, "SLERP end")

print("Tah dah!")
```

### Quaternion.New

### Quaternion.IDENTITY

There are several different ways to create new Quaternions.

```lua
local sqrt2over2 = math.sqrt(2) / 2

-- Makes an identity Quaternion. (Rotates by 0 degrees.)
local identityQuat = Quaternion.New()
ut.EXPECT_QUAT_EQUAL(identityQuat, Quaternion.IDENTITY, "default constructor")

-- You can also access the identity quaternion via the static property:
local otherIdentityQuat = Quaternion.IDENTITY
ut.EXPECT_QUAT_EQUAL(identityQuat, Quaternion.IDENTITY, "default constructor")

-- Creates a quaternion from a rotation.
local rotationQuaternion = Quaternion.New(Rotation.New(Vector3.RIGHT, Vector3.UP))
ut.EXPECT_QUAT_EQUAL(rotationQuaternion, Quaternion.New(0, 0, sqrt2over2, sqrt2over2), "constructor - rotation")

-- Creates a quaternion from an axis and an angle.
local axisQuaternion = Quaternion.New(Vector3.UP, 90)
ut.EXPECT_QUAT_EQUAL(axisQuaternion, rotationQuaternion, "constructor - angle/rotation")

-- Creates a quaternion that rotates from one vector to another.
local fromToQuaternion = Quaternion.New(Vector3.FORWARD, Vector3.RIGHT)
ut.EXPECT_QUAT_EQUAL(fromToQuaternion, rotationQuaternion, "constructor - from/to vector")

-- Creates a quaternion that is a copy of an existing quaternion.
local copyQuaternion = Quaternion.New(rotationQuaternion)
ut.EXPECT_QUAT_EQUAL(copyQuaternion, rotationQuaternion, "copy constructor")

-- You can also create a quaternion by directly assigning x, y, z, w values,
-- but this is not recommended unless you are VERY sure you understand
-- how quaternions represent rotations.
-- This rotation is identical to rotationQuaternion, above - 90 degrees around the z axis.
local directQuaternion = Quaternion.New(0, 0, sqrt2over2, sqrt2over2)
ut.EXPECT_QUAT_EQUAL(directQuaternion, rotationQuaternion, "constructor - direct")
```

### Quaternion*Quaternion

### Quaternion*Vector3

### -Quaternion

Multiplying a vector (or another quaternion!) by a quaternion applies the quaternion to the vector/quaternion.

```lua
-- Multiplying two components will produce a quaternion that is the composite result.
local rotate90Degrees = Quaternion.New(Vector3.UP, 90)
local rotate180Degrees = rotate90Degrees * rotate90Degrees
local rotate360Degrees =  rotate180Degrees * rotate90Degrees * rotate90Degrees
ut.EXPECT_QUAT_EQUAL(rotate360Degrees, Quaternion.New(0, 0, 0, -1), "multiplication")

-- Multiplying a vector by a quaternion will produce a vector that has been rotated by the quaternion.
local rotatedVector = rotate90Degrees * Vector3.FORWARD
-- rotatedVector is now equal to Vector3.RIGHT, because it has been rotated 90 degrees
ut.EXPECT_VEC_EQUAL(rotatedVector, Vector3.RIGHT, "quaternion * vector")

-- You can also invert a quaternian using the minus-sign. Note that this is NOT the same
-- as inverting the components. This produces a reversed rotation instead.
-- This example rotates a vector by 90 degrees, and then back, leaving it unchanged.
local forwardVector = rotate90Degrees * -rotate90Degrees * Vector3.FORWARD
ut.EXPECT_VEC_EQUAL(forwardVector, Vector3.FORWARD, "quaternion inverse")
```

### Quaternion.x

### Quaternion.y

### Quaternion.z

### Quaternion.w

You can read or set the components of a quaternion directly, although this is not recommended unless you are extremely familiar with quaternions.

```lua
local myQuaternion = Quaternion.New()
myQuaternion.x = 0
myQuaternion.y = 0
myQuaternion.z = math.sqrt(2)/2
myQuaternion.w = math.sqrt(2)/2
-- myQuaternion is now a 90 degree rotation about the Z axis!
ut.EXPECT_QUAT_EQUAL(myQuaternion, Quaternion.New(Rotation.New(Vector3.RIGHT, Vector3.UP)), "direct setting")
```
