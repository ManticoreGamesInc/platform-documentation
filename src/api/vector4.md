---
id: vector4
name: Vector4
title: Vector4
tags:
    - API
---

# Vector4

A four-component vector.

## Constructors

| Constructor Name | Return Type | Description | Tags |
| ----------- | ----------- | ----------- | ---- |
| `Vector4.New([number x, number y, number z, number w])` | [`Vector4`](vector4.md) | Constructs a Vector4 with the given `x`, `y`, `z`, `w` values, defaults to (0, 0, 0, 0). | None |
| `Vector4.New(number v)` | [`Vector4`](vector4.md) | Constructs a Vector4 with `x`, `y`, `z`, `w` values all set to the given value. | None |
| `Vector4.New(Vector3 xyz, number w)` | [`Vector4`](vector4.md) | Constructs a Vector4 with `x`, `y`, `z` values from the given Vector3 and the given `w` value. | None |
| `Vector4.New(Vector4 v)` | [`Vector4`](vector4.md) | Constructs a Vector4 with `x`, `y`, `z`, `w` values from the given Vector4. | None |
| `Vector4.New(Vector2 xy, Vector2 zw)` | [`Vector4`](vector4.md) | Constructs a Vector4 with `x`, `y` values from the first Vector2 and `z`, `w` values from the second Vector2. | None |
| `Vector4.New(Color v)` | [`Vector4`](vector4.md) | Constructs a Vector4 with `x`, `y`, `z`, `w` values mapped from the given Color's `r`, `g`, `b`, `a` values. | None |

## Constants

| Constant Name | Return Type | Description | Tags |
| ----------- | ----------- | ----------- | ---- |
| `Vector4.ZERO` | [`Vector4`](vector4.md) | (0, 0, 0, 0) | None |
| `Vector4.ONE` | [`Vector4`](vector4.md) | (1, 1, 1, 1) | None |

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `x` | `number` | The `x` component of the Vector4. | Read-Write |
| `y` | `number` | The `y` component of the Vector4. | Read-Write |
| `z` | `number` | The `z` component of the Vector4. | Read-Write |
| `w` | `number` | The `w` component of the Vector4. | Read-Write |
| `size` | `number` | The magnitude of the Vector4. | Read-Only |
| `sizeSquared` | `number` | The squared magnitude of the Vector4. | Read-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetNormalized()` | [`Vector4`](vector4.md) | Returns a new Vector4 with size 1, but still pointing in the same direction. Returns (0, 0, 0, 0) if the vector is too small to be normalized. | None |

## Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `Vector4.Lerp(Vector4 from, Vector4 to, number progress)` | [`Vector4`](vector4.md) | Linearly interpolates between two vectors by the specified progress amount and returns the resultant Vector4. | None |

## Operators

| Operator Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Vector4 + Vector4` | [`Vector4`](vector4.md) | Component-wise addition. | None |
| `Vector4 + number` | [`Vector4`](vector4.md) | Adds the right-side number to each of the components in the left side and returns the resulting Vector4. | None |
| `Vector4 - Vector4` | [`Vector4`](vector4.md) | Component-wise subtraction. | None |
| `Vector4 - number` | [`Vector4`](vector4.md) | Subtracts the right-side number from each of the components in the left side and returns the resulting Vector4. | None |
| `Vector4 * Vector4` | [`Vector4`](vector4.md) | Component-wise multiplication. | None |
| `Vector4 * number` | [`Vector4`](vector4.md) | Multiplies each component of the Vector4 by the right-side number. | None |
| `number * Vector4` | [`Vector4`](vector4.md) | Multiplies each component of the Vector4 by the left-side number. | None |
| `Vector4 / Vector4` | [`Vector4`](vector4.md) | Component-wise division. | None |
| `Vector4 / number` | [`Vector4`](vector4.md) | Divides each component of the Vector4 by the right-side number. | None |
| `-Vector4` | [`Vector4`](vector4.md) | Returns the negation of the Vector4. | None |
| `Vector4 .. Vector4` | `number` | Returns the dot product of the Vector4s. | None |
| `Vector4 ^ Vector4` | [`Vector4`](vector4.md) | Returns the cross product of the Vector4s. | None |
