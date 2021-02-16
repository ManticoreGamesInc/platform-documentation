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
| `Vector2.New([Number x, Number y])` | `Vector2` | Constructs a Vector2 with the given `x`, `y` values, defaults to (0, 0). | None |
| `Vector2.New(Number)` | `Vector2` | Constructs a Vector2 with `x`, `y` values both set to the given value. | None |
| `Vector2.New(Vector3 v)` | `Vector2` | Constructs a Vector2 with `x`, `y` values from the given Vector3. | None |
| `Vector2.New(Vector2 v)` | `Vector2` | Constructs a Vector2 with `x`, `y` values from the given Vector2. | None |

## Constants

| Constant Name | Return Type | Description | Tags |
| ----------- | ----------- | ----------- | ---- |
| `Vector2.ZERO` | `Vector2` | (0, 0) | None |
| `Vector2.ONE` | `Vector2` | (1, 1) | None |

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `x` | `Number` | The `x` component of the Vector2. | Read-Write |
| `y` | `Number` | The `y` component of the Vector2. | Read-Write |
| `size` | `Number` | The magnitude of the Vector2. | Read-Only |
| `sizeSquared` | `Number` | The squared magnitude of the Vector2. | Read-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetNormalized()` | `Vector2` | Returns a new Vector2 with size 1, but still pointing in the same direction. Returns (0, 0) if the vector is too small to be normalized. | None |

## Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `Vector2.Lerp(Vector2 from, Vector2 to, Number progress)` | `Vector2` | Linearly interpolates between two vectors by the specified progress amount and returns the resultant Vector2. | None |

## Operators

| Operator Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Vector2 + Vector2` | `Vector2` | Component-wise addition. | None |
| `Vector2 + Number` | `Vector2` | Adds the right-side Number to each of the components in the left side and returns the resulting Vector2. | None |
| `Vector2 - Vector2` | `Vector2` | Component-wise subtraction. | None |
| `Vector2 - Number` | `Vector2` | Subtracts the right-side Number from each of the components in the left side and returns the resulting Vector2. | None |
| `Vector2 * Vector2` | `Vector2` | Component-wise multiplication. | None |
| `Vector2 * Number` | `Vector2` | Multiplies each component of the Vector2 by the right-side Number. | None |
| `Number * Vector2` | `Vector2` | Multiplies each component of the Vector2 by the left-side Number. | None |
| `Vector2 / Vector2` | `Vector2` | Component-wise division. | None |
| `Vector2 / Number` | `Vector2` | Divides each component of the Vector2 by the right-side Number. | None |
| `-Vector2` | `Vector2` | Returns the negation of the Vector2. | None |
| `Vector2 .. Vector2` | `Number` | Returns the dot product of the Vector2s. | None |
| `Vector2 ^ Vector2` | `Number` | Returns the cross product of the Vector2s. | None |
