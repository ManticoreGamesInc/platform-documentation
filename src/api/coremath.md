---
id: coremath
name: CoreMath
title: CoreMath
tags:
    - API
---

# CoreMath

## Description

The CoreMath namespace contains a set of math functions.

## API

### Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `CoreMath.Clamp(Number value, [Number lower, Number upper])` | `Number` | Clamps value between lower and upper, inclusive. If lower and upper are not specified, defaults to 0 and 1. | None |
| `CoreMath.Lerp(Number from, Number to, Number t)` | `Number` | Linear interpolation between from and to. t should be a floating point number from 0 to 1, with 0 returning from and 1 returning to. | None |
| `CoreMath.Round(Number value, [Number decimals])` | `Number` | Rounds value to an integer, or to an optional number of decimal places, and returns the rounded value. | None |
