---
id: physicsobject
name: PhysicsObject
title: PhysicsObject
tags:
    - API
---

# PhysicsObject

A CoreObject with simulated physics that can interact with players and other objects.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `team` | `integer` | Assigns the physics object to a team. Value range from `0` to `4`. `0` is neutral team. | Read-Write |
| `isTeamCollisionEnabled` | `boolean` | If `false`, and the physics object has been assigned to a valid team, players on that team will not collide with the object. | Read-Write |
| `isEnemyCollisionEnabled` | `boolean` | If `false`, and the physics object has been assigned to a valid team, players on other teams will not collide with the object. | Read-Write |
