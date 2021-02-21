---
id: coremath
name: CoreMath
title: CoreMath
tags:
    - API
---

# CoreMath

The CoreMath namespace contains a set of math functions.

## Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `CoreMath.Clamp(number value, [number lower, number upper])` | `number` | Clamps value between lower and upper, inclusive. If lower and upper are not specified, defaults to 0 and 1. | None |
| `CoreMath.Lerp(number from, number to, number t)` | `number` | Linear interpolation between from and to. t should be a floating point number from 0 to 1, with 0 returning from and 1 returning to. | None |
| `CoreMath.Round(number value, [number decimals])` | `number` | Rounds value to an integer, or to an optional number of decimal places, and returns the rounded value. | None |
