---
id: transform
name: Transform
title: Transform
tags:
    - API
---

# Transform

Transforms represent the position, rotation, and scale of objects in the game. They are immutable, but new Transforms can be created when you want to change an object's Transform.

## Constructors

| Constructor Name | Return Type | Description | Tags |
| ----------- | ----------- | ----------- | ---- |
| `Transform.New()` | [`Transform`](transform.md) | Constructs a new identity Transform. | None |
| `Transform.New(Quaternion rotation, Vector3 position, Vector3 scale)` | [`Transform`](transform.md) | Constructs a new Transform with a Quaternion. | None |
| `Transform.New(Rotation rotation, Vector3 position, Vector3 scale)` | [`Transform`](transform.md) | Constructs a new Transform with a Rotation. | None |
| `Transform.New(Vector3 x_axis, Vector3 y_axis, Vector3 z_axis, Vector3 translation)` | [`Transform`](transform.md) | Constructs a new Transform from a Matrix. | None |
| `Transform.New(Transform transform)` | [`Transform`](transform.md) | Copies the given Transform. | None |

## Constants

| Constant Name | Return Type | Description | Tags |
| ----------- | ----------- | ----------- | ---- |
| `Transform.IDENTITY` | [`Transform`](transform.md) | Constant identity Transform. | None |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetPosition()` | [`Vector3`](vector3.md) | Returns a copy of the position component of the Transform. | None |
| `SetPosition(Vector3)` | `None` | Sets the position component of the Transform. | None |
| `GetRotation()` | [`Rotation`](rotation.md) | Returns a copy of the Rotation component of the Transform. | None |
| `SetRotation(Rotation)` | `None` | Sets the rotation component of the Transform. | None |
| `GetQuaternion()` | [`Quaternion`](quaternion.md) | Returns a quaternion-based representation of the Rotation. | None |
| `SetQuaternion(Quaternion)` | `None` | Sets the quaternion-based representation of the Rotation. | None |
| `GetScale()` | [`Vector3`](vector3.md) | Returns a copy of the scale component of the Transform. | None |
| `SetScale(Vector3)` | `None` | Sets the scale component of the Transform. | None |
| `GetForwardVector()` | [`Vector3`](vector3.md) | Forward vector of the Transform. | None |
| `GetRightVector()` | [`Vector3`](vector3.md) | Right vector of the Transform. | None |
| `GetUpVector()` | [`Vector3`](vector3.md) | Up vector of the Transform. | None |
| `GetInverse()` | [`Transform`](transform.md) | Inverse of the Transform. | None |
| `TransformPosition(Vector3 position)` | [`Vector3`](vector3.md) | Applies the Transform to the given position in 3D space. | None |
| `TransformDirection(Vector3 direction)` | [`Vector3`](vector3.md) | Applies the Transform to the given directional Vector3. This will rotate and scale the Vector3, but does not apply the Transform's position. | None |

## Operators

| Operator Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Transform * Transform` | [`Transform`](transform.md) | Returns a new Transform composing the left and right Transforms. | None |
| `Transform * Quaternion` | [`Transform`](transform.md) | Returns a new Transform composing the left Transform then the right side rotation. | None |

## Examples

Example using:

### `New`

In this example we show that getting an object's rotation, position, and scale individually is the same as getting the object's entire transform.

```lua
local OBJ = script.parent

local rot = OBJ:GetRotation()
local pos = OBJ:GetPosition()
local sca = OBJ:GetScale()
local newTransform = Transform.New(rot, pos, sca)

if newTransform == OBJ:GetTransform() then
    print("Equal")
else
    print("Not equal")
end
```

See also: [CoreObject.GetTransform](coreobject.md)

---

Example using:

### `GetPosition`

### `SetPosition`

In this example, we move an object up by 2 meters by modifying its transform. The script is placed as a child of the object and networking is enabled on the object. The same can be done for rotation and scale. Notice that, when manipulating Core Objects directly, their "world" position is most often changed. Whereas changes to a transform's properties are always in local space.

```lua
local OBJ = script.parent

-- Grab a copy of the transform
local t = OBJ:GetTransform()

-- Change its position up by 2 meters
local pos = t:GetPosition()
pos = pos + Vector3.New(0, 0, 200)
t:SetPosition(pos)

-- Apply the transform back to the object
OBJ:SetTransform(t)
```

See also: [CoreObject.SetTransform](coreobject.md) | [Vector3.New](vector3.md)

---

Example using:

### `Transform*Transform`

### `Transform*Quaternion`

While many operations can be achieved by changing an object's position or rotation directly, some algorithms are best achieved with `Transforms` (matrices). In this example, we build an elaborate 3D spiral structure by spawning a series of cubes. This takes advantage of the composable nature of transforms, which can accumulate an indefinite series of position/rotation/scale, all while being highly efficient on the CPU.

```lua
-- Template of bottom-aligned cube that will be spawned
local TEMPLATE = script:GetCustomProperty("CubeBottomAligned")

-- Build the math structures only once
local T_OFFSET = Transform.New(Quaternion.IDENTITY, Vector3.UP * 100, Vector3.ONE)
local T_ARC = Transform.New(Rotation.New(5, 7, 0), Vector3.ZERO, Vector3.ONE)
local Q_TIGHTEN = Quaternion.New(Rotation.New(0.03, 0.06, -0.01))

-- Initial transform composition that will be applied to itself, over and over
local composition = T_ARC * T_OFFSET

t = script:GetTransform()

function SpawnOne()
    -- Slight rotation to tighten the spiral
    composition = composition * Q_TIGHTEN
    -- Iterate the composition
    t = composition * t
    -- Spawn the cube with the given transform
    local obj = World.SpawnAsset(TEMPLATE, {transform = t})
end

-- Loop over time. Spawn a cube every 30ms
function Tick()
    Task.Wait(0.03)
    SpawnOne()
end
```

See also: [CoreObject.GetTransform](coreobject.md) | [World.SpawnAsset](world.md) | [Rotation.New](rotation.md) | [Vector3.UP](vector3.md) | [Quaternion.IDENTITY](quaternion.md) | [Task.Wait](task.md)

---
