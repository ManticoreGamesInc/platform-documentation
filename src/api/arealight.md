---
id: arealight
name: AreaLight
title: AreaLight
tags:
    - API
---

# API: AreaLight

## Description

AreaLight is a Light that emits light from a rectangular plane. It also has properties for configuring a set of "doors" attached to the plane which affect the lit area in front of the plane.

## API

### Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `sourceWidth` | `Number` | The width of the plane from which light is emitted. Must be greater than 0. | Read-Write |
| `sourceHeight` | `Number` | The height of the plane from which light is emitted. Must be greater than 0. | Read-Write |
| `barnDoorAngle` | `Number` | The angle of the barn doors, in degrees. Valid values are in the range from 0 to 90. Has no effect if `barnDoorLength` is 0. | Read-Write |
| `barnDoorLength` | `Number` | The length of the barn doors. Must be non-negative. | Read-Write |
