---
id: box
name: Box
title: Box
tags:
    - API
---

# Box

A 3D box aligned to some coordinate system.

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetCenter()` | [`Vector3`](vector3.md) | Returns the coordinates of the center of the box. | None |
| `GetExtent()` | [`Vector3`](vector3.md) | Returns a Vector3 representing half the size of the box along its local axes. | None |
| `GetTransform()` | [`Transform`](transform.md) | Returns a Transform which, when applied to a unit cube, produces a result matching the position, size, and rotation of this box. | None |
