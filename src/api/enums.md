---
id: enums
name: Enums
title: Enums
tags:
    - API
---

<style>
    .md-typeset table:not([class]) tr td:first-child {
        width: auto;
    }

    table > thead > tr > th:nth-child(3),
    .md-typeset table:not([class]) tr td:nth-child(2) {
        width: 25%;
    }
</style>

# Enums

## AbilityFacingMode

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `AbilityFacingMode.NONE` | `0` | Coming Soon |
| `AbilityFacingMode.MOVEMENT` | `1` | Coming Soon |
| `AbilityFacingMode.AIM` | `2` | Coming Soon |

## AbilityPhase

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `AbilityPhase.READY` | `0` | Coming Soon |
| `AbilityPhase.CAST` | `1` | Coming Soon |
| `AbilityPhase.EXECUTE` | `2` | Coming Soon |
| `AbilityPhase.RECOVERY` | `3` | Coming Soon |
| `AbilityPhase.COOLDOWN` | `4` | Coming Soon |

## BroadcastEventResultCode

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `BroadcastEventResultCode.SUCCESS` | `0` | Coming Soon |
| `BroadcastEventResultCode.FAILURE` | `1` | Coming Soon |
| `BroadcastEventResultCode.EXCEEDED_SIZE_LIMIT` | `2` | Coming Soon |
| `BroadcastEventResultCode.EXCEEDED_RATE_WARNING_LIMIT` | `3` | Coming Soon |
| `BroadcastEventResultCode.EXCEEDED_RATE_LIMIT` | `4` | Coming Soon |

## BroadcastMessageResultCode

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `BroadcastMessageResultCode.SUCCESS` | `0` | Coming Soon |
| `BroadcastMessageResultCode.FAILURE` | `1` | Coming Soon |
| `BroadcastMessageResultCode.EXCEEDED_SIZE_LIMIT` | `2` | Coming Soon |
| `BroadcastMessageResultCode.EXCEEDED_RATE_WARNING_LIMIT` | `3` | Coming Soon |
| `BroadcastMessageResultCode.EXCEEDED_RATE_LIMIT` | `4` | Coming Soon |

## Collision

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `Collision.INHERIT` | `0` | Coming Soon |
| `Collision.FORCE_ON` | `1` | Coming Soon |
| `Collision.FORCE_OFF` | `2` | Coming Soon |

## CoreModalType

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `CoreModalType.PAUSE_MENU` | `1` | Coming Soon |
| `CoreModalType.CHARACTER_PICKER` | `2` | Coming Soon |
| `CoreModalType.MOUNT_PICKER` | `3` | Coming Soon |
| `CoreModalType.EMOTE_PICKER` | `4` | Coming Soon |

## DamageReason

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `DamageReason.UNKNOWN` | `0` | Coming Soon |
| `DamageReason.COMBAT` | `1` | Coming Soon |
| `DamageReason.FRIENDLY_FIRE` | `2` | Coming Soon |
| `DamageReason.MAP` | `3` | Coming Soon |
| `DamageReason.NPC` | `4` | Coming Soon |

## FacingMode

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `FacingMode.FACE_AIM_WHEN_ACTIVE` | `0` | Coming Soon |
| `FacingMode.FACE_AIM_ALWAYS` | `1` | Coming Soon |
| `FacingMode.FACE_MOVEMENT` | `2` | Coming Soon |

## LeaderboardType

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `LeaderboardType.GLOBAL` | `0` | Coming Soon |
| `LeaderboardType.DAILY` | `1` | Coming Soon |
| `LeaderboardType.WEEKLY` | `2` | Coming Soon |
| `LeaderboardType.MONTHLY` | `3` | Coming Soon |

## LookControlMode

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `LookControlMode.NONE` | `0` | Look input is ignored. |
| `LookControlMode.RELATIVE` | `1` | Look input controls the current look direction. |
| `LookControlMode.LOOK_AT_CURSOR` | `2` | Look input is ignored. The player's look direction is determined by drawing a line from the player to the cursor on the Cursor Plane. |

## MovementControlMode

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `MovementControlMode.NONE` | `0` | Movement input is ignored. |
| `MovementControlMode.LOOK_RELATIVE` | `1` | Forward movement follows the current player's look direction. |
| `MovementControlMode.VIEW_RELATIVE` | `2` | Forward movement follows the current view's look direction. |
| `MovementControlMode.FACING_RELATIVE` | `3` | Forward movement follows the current player's facing direction. |
| `MovementControlMode.FIXED_AXES` | `4` | Movement axis are fixed. |

## MovementMode

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `MovementMode.NONE` | `0` | Coming Soon |
| `MovementMode.WALKING` | `1` | Coming Soon |
| `MovementMode.FALLING` | `3` | Coming Soon |
| `MovementMode.SWIMMING` | `4` | Coming Soon |
| `MovementMode.FLYING` | `5` | Coming Soon |
| `MovementMode.SLIDING` | `6` | Coming Soon |

## NetReferenceType

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `NetReferenceType.LEADERBOARD` | `1` | Coming Soon |
| `NetReferenceType.SHARED_STORAGE` | `2` | Coming Soon |
| `NetReferenceType.CREATOR_PERK` | `3` | Coming Soon |
| `NetReferenceType.UNKNOWN` | `0` | Coming Soon |

## RotationMode

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `RotationMode.CAMERA` | `0` | Coming Soon |
| `RotationMode.NONE` | `1` | Coming Soon |
| `RotationMode.LOOK_ANGLE` | `2` | Coming Soon |

## StorageResultCode

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `StorageResultCode.SUCCESS` | `0` | Coming Soon |
| `StorageResultCode.FAILURE` | `2` | Coming Soon |
| `StorageResultCode.STORAGE_DISABLED` | `1` | Coming Soon |
| `StorageResultCode.EXCEEDED_SIZE_LIMIT` | `3` | Coming Soon |

## TaskStatus

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `TaskStatus.UNINITIALIZED` | `0` | Coming Soon |
| `TaskStatus.SCHEDULED` | `1` | Coming Soon |
| `TaskStatus.RUNNING` | `2` | Coming Soon |
| `TaskStatus.COMPLETED` | `3` | Coming Soon |
| `TaskStatus.YIELDED` | `4` | Coming Soon |
| `TaskStatus.FAILED` | `5` | Coming Soon |
| `TaskStatus.CANCELED` | `6` | Coming Soon |
| `TaskStatus.BLOCKED` | `7` | Coming Soon |

## TextJustify

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `TextJustify.LEFT` | `0` | Coming Soon |
| `TextJustify.CENTER` | `1` | Coming Soon |
| `TextJustify.RIGHT` | `2` | Coming Soon |

## UIPivot

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `UIPivot.TOP_LEFT` | `0` | Coming Soon |
| `UIPivot.TOP_CENTER` | `1` | Coming Soon |
| `UIPivot.TOP_RIGHT` | `2` | Coming Soon |
| `UIPivot.MIDDLE_LEFT` | `3` | Coming Soon |
| `UIPivot.MIDDLE_CENTER` | `4` | Coming Soon |
| `UIPivot.MIDDLE_RIGHT` | `5` | Coming Soon |
| `UIPivot.BOTTOM_LEFT` | `6` | Coming Soon |
| `UIPivot.BOTTOM_CENTER` | `7` | Coming Soon |
| `UIPivot.BOTTOM_RIGHT` | `8` | Coming Soon |
| `UIPivot.CUSTOM` | `9` | Coming Soon |

## Visibility

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `Visibility.INHERIT` | `0` | Coming Soon |
| `Visibility.FORCE_ON` | `1` | Coming Soon |
| `Visibility.FORCE_OFF` | `2` | Coming Soon |
