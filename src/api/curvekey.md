---
id: curvekey
name: CurveKey
title: CurveKey
tags:
    - API
---

# CurveKey

A `CurveKey` represents a key point on a `SimpleCurve`, providing a value for a specific point in time on that curve. Additional properties may be used to control the shape of that curve.

## Constructors

| Constructor Name | Return Type | Description | Tags |
| ----------- | ----------- | ----------- | ---- |
| `CurveKey.New()` | [`CurveKey`](curvekey.md) | Constructs a new CurveKey. | None |
| `CurveKey.New(number time, number value, [table optionalParameters])` | [`CurveKey`](curvekey.md) | Constructs a CurveKey with the given time and value. An optional table may be provided to override the following parameters:<br>`interpolation (CurveInterpolation)`: Sets the `interpolation` property of the curve key. Defaults to `CurveInterpolation.LINEAR`.<br>`arriveTangent (number)`: Sets the `arriveTangent` property of the curve key. Defaults to 0.<br>`leaveTangent (number)`: Sets the `leaveTangent` property of the curve key. Defaults to 0.<br>`tangent (number)`: Sets both the `arriveTangent` and `leaveTangent` properties of the curve key. It is an error to specify `arriveTangent` or `leaveTangent` if `tangent` is provided. | None |
| `CurveKey.New(CurveKey other)` | [`CurveKey`](curvekey.md) | Makes a copy of the given CurveKey. | None |

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `interpolation` | [`CurveInterpolation`](enums.md#curveinterpolation) | The interpolation mode between this curve key and the next. | Read-Write |
| `time` | `number` | The time at this curve key. | Read-Write |
| `value` | `number` | The value at this curve key. | Read-Write |
| `arriveTangent` | `number` | The arriving tangent at this key when using cubic interpolation. | Read-Write |
| `leaveTangent` | `number` | The leaving tangent at this key when using cubic interpolation. | Read-Write |
