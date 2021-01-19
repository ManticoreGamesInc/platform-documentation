---
id: abilityphasesettings
name: AbilityPhaseSettings
title: AbilityPhaseSettings
tags:
    - API
---

# AbilityPhaseSettings

## Description

Each phase of an Ability can be configured differently, allowing complex and different Abilities. AbilityPhaseSettings is an Object.

## API

### Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `duration` | `Number` | Length in seconds of the phase. After this time the Ability moves to the next phase. Can be zero. Default values per phase: 0.15, 0, 0.5 and 3. | Read-Only |
| `canMove` | `bool` | Is the Player allowed to move during this phase. True by default. | Read-Only |
| `canJump` | `bool` | Is the Player allowed to jump during this phase. False by default in Cast & Execute, default True in Recovery & Cooldown. | Read-Only |
| `canRotate` | `bool` | Is the Player allowed to rotate during this phase. True by default. | Read-Only |
| `preventsOtherAbilities` | `bool` | When true this phase prevents the Player from casting another Ability, unless that other Ability has canBePrevented set to False. True by default in Cast & Execute, false in Recovery & Cooldown. | Read-Only |
| `isTargetDataUpdated` | `bool` | If `true`, there will be updated target information at the start of the phase. Otherwise, target information may be out of date. | Read-Only |
| `facingMode` | `AbilityFacingMode` | How and if this Ability rotates the Player during execution. Cast and Execute default to "Aim", other phases default to "None". Options are: AbilityFacingMode.NONE, AbilityFacingMode.MOVEMENT, AbilityFacingMode.AIM | Read-Only |
