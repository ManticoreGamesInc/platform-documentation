---
id: physicsobject
name: PhysicsObject
title: PhysicsObject
tags:
    - API
---

# PhysicsObject

A CoreObject with simulated physics that can interact with players and other objects. PhysicsObject also implements the [Damageable](damageable.md) interface.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `team` | `integer` | Assigns the physics object to a team. Value range from `0` to `4`. `0` is neutral team. | Read-Write |
| `isTeamCollisionEnabled` | `boolean` | If `false`, and the physics object has been assigned to a valid team, players on that team will not collide with the object. | Read-Write |
| `isEnemyCollisionEnabled` | `boolean` | If `false`, and the physics object has been assigned to a valid team, players on other teams will not collide with the object. | Read-Write |
| `hitPoints` | `number` | Current amount of hit points. | Read-Write |
| `maxHitPoints` | `number` | Maximum amount of hit points. | Read-Write |
| `isDead` | `boolean` | True if the object is dead, otherwise false. Death occurs when damage is applied which reduces hit points to 0, or when the `Die()` function is called. | Read-Only |
| `isImmortal` | `boolean` | When set to `true`, this object cannot die. | Read-Write |
| `isInvulnerable` | `boolean` | When set to `true`, this object does not take damage. | Read-Write |
| `destroyOnDeath` | `boolean` | When set to `true`, this object will automatically be destroyed when it dies. | Read-Only |
| `destroyOnDeathDelay` | `number` | Delay in seconds after death before this object is destroyed, if `destroyOnDeath` is set to `true`. Defaults to 0. | Read-Only |
| `destroyOnDeathClientTemplateId` | `string` | Optional asset ID of a template to be spawned on clients when this object is automatically destroyed on death. | Read-Only |
| `destroyOnDeathNetworkedTemplateId` | `string` | Optional asset ID of a networked template to be spawned on the server when this object is automatically destroyed on death. | Read-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `ApplyDamage(Damage)` | `None` | Damages the object, unless it is invulnerable. If its hit points reach 0 and it is not immortal, it dies. | Server-Only |
| `Die([Damage])` | `None` | Kills the object, unless it is immortal. The optional Damage parameter is a way to communicate cause of death. | Server-Only |

## Events

| Event Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `damagedEvent` | `Event<`[`PhysicsObject`](physicsobject.md) object, Damage damage`>` | Fired when the object takes damage. | Server-Only |
| `diedEvent` | `Event<`[`PhysicsObject`](physicsobject.md) object, Damage damage`>` | Fired when the object dies. | Server-Only |
