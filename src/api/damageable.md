---
id: damageable
name: Damageable
title: Damageable
tags:
    - API
---

# Damageable

Damageable is an interface which defines properties, events, and functions for objects which can take damage and die.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `hitPoints` | `number` | Current amount of hit points. | Read-Write |
| `maxHitPoints` | `number` | Maximum amount of hit points. | Read-Write |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `ApplyDamage(Damage)` | `None` | Damages a Damageable, unless it is invulnerable. If its hit points reach 0 and it is not immortal, it dies. | Server-Only |
| `Die([Damage])` | `None` | Kills the Damageable, unless it is immortal. The optional Damage parameter is a way to communicate cause of death. | Server-Only |

## Events

| Event Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `damagedEvent` | [`Event`](event.md)<`Damageable` damageable, [`Damage`](damage.md) damage> | Fired when the Damageable takes damage. | Server-Only |
| `diedEvent` | [`Event`](event.md)<`Damageable` damageable, [`Damage`](damage.md) damage> | Fired when the Damageable dies. | Server-Only |

## Hooks

| Hook Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `damageHook` | [`Hook`](hook.md)<`Damageable` damageable, [`Damage`](damage.md) damage> | Hook called when applying damage from a call to `ApplyDamage()`. The incoming damage may be modified or prevented by modifying properties on the `damage` parameter. | Server-Only |
