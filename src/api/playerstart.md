---
id: playerstart
name: PlayerStart
title: PlayerStart
tags:
    - API
---

# PlayerStart

PlayerStart is a CoreObject representing a spawn point for players.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `team` | `integer` | Determines which players are eligible to spawn/respawn at this point. | Read-Write |
| `playerScaleMultiplier` | `number` | The scale applied to a player that is spawned at this start point. | Read-Write |
| `spawnTemplateId` | `string` | The asset ID of a template spawned on clients when a player spawns at this start point. May be nil. | Read-Only |
