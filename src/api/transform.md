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
