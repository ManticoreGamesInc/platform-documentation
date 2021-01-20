---
id: spotlight
name: SpotLight
title: SpotLight
tags:
    - API
---

# API: SpotLight

## Description

SpotLight is a Light that shines in a specific direction from the location at which it is placed.

## API

### Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `hasNaturalFalloff` | `bool` | The attenuation method of the light. When enabled, `attenuationRadius` is used. When disabled, `falloffExponent` is used. Also changes the interpretation of the intensity property, see intensity for details. | Read-Write |
| `falloffExponent` | `Number` | Controls the radial falloff of the light when `hasNaturalFalloff` is false. 2.0 is almost linear and very unrealistic and around 8.0 it looks reasonable. With large exponents, the light has contribution to only a small area of its influence radius but still costs the same as low exponents. | Read-Write |
| `sourceRadius` | `Number` | Radius of light source shape. | Read-Write |
| `sourceLength` | `Number` | Length of light source shape. | Read-Write |
| `innerConeAngle` | `Number` | The angle (in degrees) of the cone within which the projected light achieves full brightness. | Read-Write |
| `outerConeAngle` | `Number` | The outer angle (in degrees) of the cone of light emitted by this SpotLight. | Read-Write |
