---
id: light
name: Light
title: Light
tags:
    - API
---

# Light

Light is a light source that is a CoreObject. Generally a Light will be an instance of some subtype, such as PointLight or SpotLight.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `intensity` | `Number` | The intensity of the light. For PointLights and SpotLights, this has two interpretations, depending on the value of the `hasNaturalFallOff` property. If `true`, the light's Intensity is in units of lumens, where 1700 lumens is a 100W lightbulb. If `false`, the light's Intensity is a brightness scale. | Read-Write |
| `attenuationRadius` | `Number` | Bounds the light's visible influence. This clamping of the light's influence is not physically correct but very important for performance, larger lights cost more. | Read-Write |
| `isShadowCaster` | `bool` | Does this light cast shadows? | Read-Write |
| `hasTemperature` | `bool` | true: use temperature value as illuminant. false: use white (D65) as illuminant. | Read-Write |
| `temperature` | `Number` | Color temperature in Kelvin of the blackbody illuminant. White (D65) is 6500K. | Read-Write |
| `team` | `Integer` | Assigns the light to a team. Value range from 0 to 4. 0 is a neutral team. | Read-Write |
| `isTeamColorUsed` | `bool` | If `true`, and the light has been assigned to a valid team, players on that team will see a blue light, while other players will see red. | Read-Write |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetColor()` | [`Color`](color.md) | The color of the light. | None |
| `SetColor(Color)` | `None` | The color of the light. | None |
