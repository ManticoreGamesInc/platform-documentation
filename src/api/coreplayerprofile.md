---
id: coreplayerprofile
name: CorePlayerProfile
title: CorePlayerProfile
tags:
    - API
---

# CorePlayerProfile

Public account profile for a player on the Core platform.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `id` | `string` | The ID of the player. | Read-Only |
| `name` | `string` | The name of the player. This field does not reflect changes that may have been made to the `name` property of a `Player` currently in the game. | Read-Only |
| `description` | `string` | A description of the player, provided by the player in the About section of their profile. | Read-Only |

## Learn More

[CorePlatform.GetPlayerProfile()](coreplatform.md)
