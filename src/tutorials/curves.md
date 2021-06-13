---
id: curves_reference
name: Curves Reference
title: Curves Reference
tags:
    - Reference
---

# Curves

## Summary

TODO!

## Curve Editor

### Opening the Curve Editor

TODO!

### Curve Graph

TODO!

### In / Out

**In / Out** is a behaviour of the curve before or after the range of time

There are five different behaviours:

| Name                  | Description |
| --------------------- | ----------- |
| **Cycle**             | Repeat the curve |
| **Cycle with Offset** | Repeat the curve but start the next value where the last left value off |
| **Oscillate**         | Repeat the curve but flip the time values |
| **Linear**            | Takes the tangency from the first two (in) or last two (out) keys and extrapolates it forever before/after respectively |
| **Constant**          | Takes the value of the first (in) or last (out) key and sets a constant value before/after respectively |

### Keyframes

A keyframe is a physical representations of a point on the curve.

| Name                   | Description |
| ---------------------- | ----------- |
| **Time**               | Point in time relative to the beginning (`0`) of the curve<br/>![Time](../img/Curves/Time.png) |
| **Value**              | The position that the curve should be in at the corresponding point in time<br/>![Value](../img/Curves/Value.png) |
| **Interpolation Type** | How the curve will transition to the next keyframe<br/>![Interpolation Type](../img/Curves/InterpolationType.png) |
| **Tangent Type**       | How the tangents will be determined for the previous and next keyframe<br/>![Tangent Type](../img/Curves/TangentType.png) |
| **Tangent Values**     | The value for the previous / next tangent if **Tangent Type** is `user-set`<br/>![Tangent Values](../img/Curves/TangentValues.png) |

#### Interpolation Type

There are three interpolation types:

| Name                       | Description |
| -------------------------- | ----------- |
| **Constant Interpolation** | The value will remain constant until it reach the next keyframe to which it will snap to the next value<br/>![Constant Interpolation](../img/Curves/ConstantInterpolation.png) |
| **Linear Interpolation**   | The value will lerp linearly to the next keyframe<br/>![Linear Interpolation](../img/Curves/LinearInterpolation.png) |
| **Cubic Interpolation**    | The value will use a cubic algorithm to transition to the next keyframe<br/>![Cubic Interpolation](../img/Curves/CubicInterpolation.png) |

#### Tangent Type and Values

There are three tangent types:

| Name                      | Description |
| ------------------------- | ----------- |
| **Automatic Computation** | Core will take into account the position in time, the value, and surrounding keyframes to automatically set a tangent<br/>![Automatic Computation Tangent](../img/Curves/AutomaticTangent.png) |
| **User-Set Aligned**      | The tangent can be set by the creator and the previous/next tangent will retain the same values<br/>![User-Set Aligned Tangent](../img/Curves/UserSetAlignedTangent.png) |
| **User-Set Independent**  | The tangent can be set by the creator but the previous and next values can be set without changing the other<br/>![User-Set Independent Tangent](../img/Curves/UserSetIndependentTangent.png) |

### Viewport Settings

### Curve Presets

## Sample Scripts

### Curve Mover

TODO!

### Curve Rotator

TODO!

### Curve Scaler

TODO!
