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
| `AbilityFacingMode.NONE` | `0` | Description |
| `AbilityFacingMode.MOVEMENT` | `1` | Description |
| `AbilityFacingMode.AIM` | `2` | Description |

## AbilityPhase

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `AbilityPhase.READY` | `0` | Description |
| `AbilityPhase.CAST` | `1` | Description |
| `AbilityPhase.EXECUTE` | `2` | Description |
| `AbilityPhase.RECOVERY` | `3` | Description |
| `AbilityPhase.COOLDOWN` | `4` | Description |

## Color

| HEX Value | Enum Name | HEX Value | Enum Name |
| --------- | --------- | --------- | --------- |
| :fontawesome-solid-square:{: .Color_WHITE } `#ffffffff`       | Color.WHITE       | :fontawesome-solid-square:{: .Color_ORANGE } `#cc4c00ff`   | Color.ORANGE |
| :fontawesome-solid-square:{: .Color_GRAY } `#7f7f7fff`        | Color.GRAY        | :fontawesome-solid-square:{: .Color_PURPLE } `#4c0099ff`   | Color.PURPLE |
| :fontawesome-solid-square:{: .Color_BLACK } `#000000ff`       | Color.BLACK       | :fontawesome-solid-square:{: .Color_BROWN } `#721400ff`    | Color.BROWN |
| :fontawesome-solid-square:{: .Color_TRANSPARENT } `#ffffff00` | Color.TRANSPARENT | :fontawesome-solid-square:{: .Color_PINK } `#ff6666ff`     | Color.PINK |
| :fontawesome-solid-square:{: .Color_RED } `#ff0000ff`         | Color.RED         | :fontawesome-solid-square:{: .Color_TAN } `#e5bf4cff`      | Color.TAN |
| :fontawesome-solid-square:{: .Color_GREEN } `#00ff00ff`       | Color.GREEN       | :fontawesome-solid-square:{: .Color_RUBY } `#660101ff`     | Color.RUBY |
| :fontawesome-solid-square:{: .Color_BLUE } `#0000ffff`        | Color.BLUE        | :fontawesome-solid-square:{: .Color_EMERALD } `#0c660cff`  | Color.EMERALD |
| :fontawesome-solid-square:{: .Color_CYAN } `#00ffffff`        | Color.CYAN        | :fontawesome-solid-square:{: .Color_SAPPHIRE } `#02024cff` | Color.SAPPHIRE |
| :fontawesome-solid-square:{: .Color_MAGENTA} `#ff00ffff`      | Color.MAGENTA     | :fontawesome-solid-square:{: .Color_SILVER } `#b2b2b2ff`   | Color.SILVER |
| :fontawesome-solid-square:{: .Color_YELLOW } `#ffff00ff`      | Color.YELLOW      | :fontawesome-solid-square:{: .Color_SMOKE } `#191919ff`    | Color.SMOKE |

## BroadcastEventResultCode

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `BroadcastEventResultCode.SUCCESS` | `0` | Description |
| `BroadcastEventResultCode.FAILURE` | `1` | Description |
| `BroadcastEventResultCode.EXCEEDED_SIZE_LIMIT` | `2` | Description |
| `BroadcastEventResultCode.EXCEEDED_RATE_WARNING_LIMIT` | `3` | Description |
| `BroadcastEventResultCode.EXCEEDED_RATE_LIMIT` | `4` | Description |

## Collision

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `Collision.INHERIT` | `0` | Description |
| `Collision.FORCE_ON` | `1` | Description |
| `Collision.FORCE_OFF` | `2` | Description |

## DamageReason

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `DamageReason.UNKNOWN` | `0` | Description |
| `DamageReason.COMBAT` | `1` | Description |
| `DamageReason.FRIENDLY_FIRE` | `2` | Description |
| `DamageReason.MAP` | `3` | Description |
| `DamageReason.NPC` | `4` | Description |

## FacingMode

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `FacingMode.FACE_AIM_WHEN_ACTIVE` | `0` | Description |
| `FacingMode.FACE_AIM_ALWAYS` | `1` | Description |
| `FacingMode.FACE_MOVEMENT` | `2` | Description |

## LeaderboardType

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `LeaderboardType.GLOBAL` | `0` | Description |
| `LeaderboardType.DAILY` | `1` | Description |
| `LeaderboardType.WEEKLY` | `2` | Description |
| `LeaderboardType.MONTHLY` | `3` | Description |

## LookControlMode

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `LookControlMode.NONE` | `0` | Description |
| `LookControlMode.RELATIVE` | `1` | Description |
| `LookControlMode.LOOK_AT_CURSOR` | `2` | Description |

## MovementControlMode

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `MovementControlMode.NONE` | `0` | Description |
| `MovementControlMode.LOOK_RELATIVE` | `1` | Description |
| `MovementControlMode.VIEW_RELATIVE` | `2` | Description |
| `MovementControlMode.FACING_RELATIVE` | `3` | Description |
| `MovementControlMode.FIXED_AXES` | `4` | Description |

## MovementMode

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `MovementMode.NONE` | `0` | Description |
| `MovementMode.WALKING` | `1` | Description |
| `MovementMode.FALLING` | `3` | Description |
| `MovementMode.SWIMMING` | `4` | Description |
| `MovementMode.FLYING` | `5` | Description |
| `MovementMode.SLIDING` | `6` | Description |

## NetReferenceType

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `NetReferenceType.LEADERBOARD` | `1` | Description |
| `NetReferenceType.SHARED_STORAGE` | `2` | Description |
| `NetReferenceType.CREATOR_PERK` | `3` | Description |
| `NetReferenceType.UNKNOWN` | `0` | Description |

## RotationMode

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `RotationMode.CAMERA` | `0` | Description |
| `RotationMode.NONE` | `1` | Description |
| `RotationMode.LOOK_ANGLE` | `2` | Description |

## StorageResultCode

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `StorageResultCode.SUCCESS` | `0` | Description |
| `StorageResultCode.FAILURE` | `2` | Description |
| `StorageResultCode.STORAGE_DISABLED` | `1` | Description |
| `StorageResultCode.EXCEEDED_SIZE_LIMIT` | `3` | Description |

## TaskStatus

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `TaskStatus.UNINITIALIZED` | `0` | Description |
| `TaskStatus.SCHEDULED` | `1` | Description |
| `TaskStatus.RUNNING` | `2` | Description |
| `TaskStatus.COMPLETED` | `3` | Description |
| `TaskStatus.YIELDED` | `4` | Description |
| `TaskStatus.FAILED` | `5` | Description |
| `TaskStatus.CANCELED` | `6` | Description |
| `TaskStatus.BLOCKED` | `7` | Description |

## TextJustify

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `TextJustify.LEFT` | `0` | Description |
| `TextJustify.CENTER` | `1` | Description |
| `TextJustify.RIGHT` | `2` | Description |

## UIPivot

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `UIPivot.TOP_LEFT` | `0` | Description |
| `UIPivot.TOP_CENTER` | `1` | Description |
| `UIPivot.TOP_RIGHT` | `2` | Description |
| `UIPivot.MIDDLE_LEFT` | `3` | Description |
| `UIPivot.MIDDLE_CENTER` | `4` | Description |
| `UIPivot.MIDDLE_RIGHT` | `5` | Description |
| `UIPivot.BOTTOM_LEFT` | `6` | Description |
| `UIPivot.BOTTOM_CENTER` | `7` | Description |
| `UIPivot.BOTTOM_RIGHT` | `8` | Description |
| `UIPivot.CUSTOM` | `9` | Description |

## Visibility

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `Visibility.INHERIT` | `0` | Description |
| `Visibility.FORCE_ON` | `1` | Description |
| `Visibility.FORCE_OFF` | `2` | Description |
