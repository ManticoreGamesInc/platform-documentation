---
id: pointlight
name: PointLight
title: PointLight
tags:
    - API
---

# PointLight

## Description

PointLight is a placeable light source that is a CoreObject.

## API

### Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `hasNaturalFalloff` | `bool` | The attenuation method of the light. When enabled, `attenuationRadius` is used. When disabled, `falloffExponent` is used. Also changes the interpretation of the intensity property, see intensity for details. | Read-Write |
| `falloffExponent` | `Number` | Controls the radial falloff of the light when `hasNaturalFalloff` is false. 2.0 is almost linear and very unrealistic and around 8.0 it looks reasonable. With large exponents, the light has contribution to only a small area of its influence radius but still costs the same as low exponents. | Read-Write |
| `sourceRadius` | `Number` | Radius of light source shape. | Read-Write |
| `sourceLength` | `Number` | Length of light source shape. | Read-Write |
