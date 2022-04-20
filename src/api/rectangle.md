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
