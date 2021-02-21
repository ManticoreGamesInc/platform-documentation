---
id: vector2
name: Vector2
title: Vector2
tags:
    - API
---

# Vector2

A two-component vector that can represent a position or direction.

## Constructors

| Constructor Name | Return Type | Description | Tags |
| ----------- | ----------- | ----------- | ---- |
| `Vector2.New([number x, number y])` | [`Vector2`](vector2.md) | Constructs a Vector2 with the given `x`, `y` values, defaults to (0, 0). | None |
| `Vector2.New(number)` | [`Vector2`](vector2.md) | Constructs a Vector2 with `x`, `y` values both set to the given value. | None |
| `Vector2.New(Vector3 v)` | [`Vector2`](vector2.md) | Constructs a Vector2 with `x`, `y` values from the given Vector3. | None |
| `Vector2.New(Vector2 v)` | [`Vector2`](vector2.md) | Constructs a Vector2 with `x`, `y` values from the given Vector2. | None |

## Constants

| Constant Name | Return Type | Description | Tags |
| ----------- | ----------- | ----------- | ---- |
| `Vector2.ZERO` | [`Vector2`](vector2.md) | (0, 0) | None |
| `Vector2.ONE` | [`Vector2`](vector2.md) | (1, 1) | None |

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `x` | `number` | The `x` component of the Vector2. | Read-Write |
| `y` | `number` | The `y` component of the Vector2. | Read-Write |
| `size` | `number` | The magnitude of the Vector2. | Read-Only |
| `sizeSquared` | `number` | The squared magnitude of the Vector2. | Read-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetNormalized()` | [`Vector2`](vector2.md) | Returns a new Vector2 with size 1, but still pointing in the same direction. Returns (0, 0) if the vector is too small to be normalized. | None |

## Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `Vector2.Lerp(Vector2 from, Vector2 to, number progress)` | [`Vector2`](vector2.md) | Linearly interpolates between two vectors by the specified progress amount and returns the resultant Vector2. | None |

## Operators

| Operator Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Vector2 + Vector2` | [`Vector2`](vector2.md) | Component-wise addition. | None |
| `Vector2 + number` | [`Vector2`](vector2.md) | Adds the right-side number to each of the components in the left side and returns the resulting Vector2. | None |
| `Vector2 - Vector2` | [`Vector2`](vector2.md) | Component-wise subtraction. | None |
| `Vector2 - number` | [`Vector2`](vector2.md) | Subtracts the right-side number from each of the components in the left side and returns the resulting Vector2. | None |
| `Vector2 * Vector2` | [`Vector2`](vector2.md) | Component-wise multiplication. | None |
| `Vector2 * number` | [`Vector2`](vector2.md) | Multiplies each component of the Vector2 by the right-side number. | None |
| `number * Vector2` | [`Vector2`](vector2.md) | Multiplies each component of the Vector2 by the left-side number. | None |
| `Vector2 / Vector2` | [`Vector2`](vector2.md) | Component-wise division. | None |
| `Vector2 / number` | [`Vector2`](vector2.md) | Divides each component of the Vector2 by the right-side number. | None |
| `-Vector2` | [`Vector2`](vector2.md) | Returns the negation of the Vector2. | None |
| `Vector2 .. Vector2` | `number` | Returns the dot product of the Vector2s. | None |
| `Vector2 ^ Vector2` | `number` | Returns the cross product of the Vector2s. | None |
