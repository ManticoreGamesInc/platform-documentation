---
id: vector4
name: Vector4
title: Vector4
tags:
    - API
---

# API: Vector4

## Description

A four-component vector.

## API

### Constructors

| Constructor Name | Return Type | Description | Tags |
| ----------- | ----------- | ----------- | ---- |
| `Vector4.New([Number x, Number y, Number z, Number w])` | `Vector4` | Constructs a Vector4 with the given `x`, `y`, `z`, `w` values, defaults to (0, 0, 0, 0). | None |
| `Vector4.New(Number v)` | `Vector4` | Constructs a Vector4 with `x`, `y`, `z`, `w` values all set to the given value. | None |
| `Vector4.New(Vector3 xyz, Number w)` | `Vector4` | Constructs a Vector4 with `x`, `y`, `z` values from the given Vector3 and the given `w` value. | None |
| `Vector4.New(Vector4 v)` | `Vector4` | Constructs a Vector4 with `x`, `y`, `z`, `w` values from the given Vector4. | None |
| `Vector4.New(Vector2 xy, Vector2 zw)` | `Vector4` | Constructs a Vector4 with `x`, `y` values from the first Vector2 and `z`, `w` values from the second Vector2. | None |
| `Vector4.New(Color v)` | `Vector4` | Constructs a Vector4 with `x`, `y`, `z`, `w` values mapped from the given Color's `r`, `g`, `b`, `a` values. | None |
| `Vector4.ZERO -- (0, 0, 0, 0)` | `Vector4` | Vector4.ONE -- (1, 1, 1, 1) | Vector4 |

### Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `x` | `Number` | The `x` component of the Vector4. | Read-Write |
| `y` | `Number` | The `y` component of the Vector4. | Read-Write |
| `z` | `Number` | The `z` component of the Vector4. | Read-Write |
| `w` | `Number` | The `w` component of the Vector4. | Read-Write |
| `size` | `Number` | The magnitude of the Vector4. | Read-Only |
| `sizeSquared` | `Number` | The squared magnitude of the Vector4. | Read-Only |

### Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetNormalized()` | `Vector4` | Returns a new Vector4 with size 1, but still pointing in the same direction. Returns (0, 0, 0, 0) if the vector is too small to be normalized. | None |

### Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `Vector4.Lerp(Vector4 from, Vector4 to, Number progress)` | `Vector4` | Linearly interpolates between two vectors by the specified progress amount and returns the resultant Vector4. | None |

### Operators

| Operator Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Vector4 + Vector4` | `Vector4` | Component-wise addition. | None |
| `Vector4 + Number` | `Vector4` | Adds the right-side Number to each of the components in the left side and returns the resulting Vector4. | None |
| `Vector4 - Vector4` | `Vector4` | Component-wise subtraction. | None |
| `Vector4 - Number` | `Vector4` | Subtracts the right-side Number from each of the components in the left side and returns the resulting Vector4. | None |
| `Vector4 * Vector4` | `Vector4` | Component-wise multiplication. | None |
| `Vector4 * Number` | `Vector4` | Multiplies each component of the Vector4 by the right-side Number. | None |
| `Number * Vector4` | `Vector4` | Multiplies each component of the Vector4 by the left-side Number. | None |
| `Vector4 / Vector4` | `Vector4` | Component-wise division. | None |
| `Vector4 / Number` | `Vector4` | Divides each component of the Vector4 by the right-side Number. | None |
| `-Vector4` | `Vector4` | Returns the negation of the Vector4. | None |
| `Vector4 .. Vector4` | `Number` | Returns the dot product of the Vector4s. | None |
| `Vector4 ^ Vector4` | `Vector4` | Returns the cross product of the Vector4s. | None |
