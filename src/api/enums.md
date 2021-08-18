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
| `AbilityFacingMode.NONE` | `0` | Player is not rotated when the ability changes phases. |
| `AbilityFacingMode.MOVEMENT` | `1` | Player is rotated to face the direction in which they are moving. |
| `AbilityFacingMode.AIM` | `2` | Player is rotated to face the direction in which they are aiming. |

## AbilityPhase

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `AbilityPhase.READY` | `0` | The ability is ready to be used but is not currently in use. |
| `AbilityPhase.CAST` | `1` | The ability is preparing to execute. |
| `AbilityPhase.EXECUTE` | `2` | The ability is executing. |
| `AbilityPhase.RECOVERY` | `3` | The ability has finished executing, but has not yet entered cooldown. |
| `AbilityPhase.COOLDOWN` | `4` | The ability is not currently ready to use. |

## BroadcastEventResultCode

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `BroadcastEventResultCode.SUCCESS` | `0` | The event was successfully broadcast. |
| `BroadcastEventResultCode.FAILURE` | `1` | Some error prevented the event from being broadcast. |
| `BroadcastEventResultCode.EXCEEDED_SIZE_LIMIT` | `2` | The event was not broadcast because the parameter data provided was too large. |
| `BroadcastEventResultCode.EXCEEDED_RATE_WARNING_LIMIT` | `3` | The event was successfully broadcast, but the current rate of events is approaching the allowed limit. |
| `BroadcastEventResultCode.EXCEEDED_RATE_LIMIT` | `4` | The event was not broadcast because too many events have been broadcast too quickly. |

## BroadcastMessageResultCode

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `BroadcastMessageResultCode.SUCCESS` | `0` | The message was successfully sent. |
| `BroadcastMessageResultCode.FAILURE` | `1` | Some error prevented the message from being sent. |
| `BroadcastMessageResultCode.EXCEEDED_SIZE_LIMIT` | `2` | The message was too long. It was still sent, but may have been truncated. |
| `BroadcastMessageResultCode.EXCEEDED_RATE_WARNING_LIMIT` | `3` | The message was sent, but the current rate of chat messages is approaching the allowed limit. |
| `BroadcastMessageResultCode.EXCEEDED_RATE_LIMIT` | `4` | The message was not sent because too many messages have been sent too quickly. |

## CameraCaptureResolution

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `CameraCaptureResolution.VERY_SMALL` | `0` | 64x64 |
| `CameraCaptureResolution.SMALL` | `1` | 128x128 |
| `CameraCaptureResolution.MEDIUM` | `2` | 256x256 |
| `CameraCaptureResolution.LARGE` | `3` | 512x512 |
| `CameraCaptureResolution.VERY_LARGE` | `4` | 1024x1024 |

## Collision

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `Collision.INHERIT` | `0` | Object collision is enabled if its parent has collision, or if it has no parent. |
| `Collision.FORCE_ON` | `1` | Object collision is enabled, regardless of parent state. |
| `Collision.FORCE_OFF` | `2` | Object collision is disabled, regardless of parent state. |

## CoreModalType

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `CoreModalType.PAUSE_MENU` | `1` | The pause menu opened by pressing the Escape key. This value may also be used for some other minor modal dialogs. |
| `CoreModalType.CHARACTER_PICKER` | `2` | The modal popup in which the player selects one of their characters. |
| `CoreModalType.MOUNT_PICKER` | `3` | The modal dialog in which the player selects which of their mounts to use. |
| `CoreModalType.EMOTE_PICKER` | `4` | The modal dialog in which the player selects an emote to play. |
| `CoreModalType.SOCIAL_MENU` | `6` | The dialog opened when inspecting another player. |

## CurveExtrapolation

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `CurveExtrapolation.CYCLE` | `0` | Repeats the curve in a cycle. |
| `CurveExtrapolation.CYCLE_WITH_OFFSET` | `1` | Repeats the curve in a cycle with an offset relative to the first or last key's value. |
| `CurveExtrapolation.OSCILLATE` | `2` | Extrapolates a sinusoidal curve. |
| `CurveExtrapolation.LINEAR` | `3` | Curves follow a linearly increasing or decreasing value before and after the ends of the curve. |
| `CurveExtrapolation.CONSTANT` | `4` | Values remain constant, using the first key value before the beginning of the curve and the last key value after the end of the curve. |

## CurveInterpolation

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `CurveInterpolation.LINEAR` | `0` | Uses linear interpolation, with the value moving in a straight line from one key to the next. |
| `CurveInterpolation.CONSTANT` | `1` | Uses a constant value, resulting in stepped changes from one key to the next. |
| `CurveInterpolation.CUBIC` | `2` | Uses cubic interpolation to generate a smooth curve. |

## DamageReason

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `DamageReason.UNKNOWN` | `0` | Unknown damage type. |
| `DamageReason.COMBAT` | `1` | Player is taking damage from an enemy player. |
| `DamageReason.FRIENDLY_FIRE` | `2` | Player is taking damage from an ally player. |
| `DamageReason.MAP` | `3` | Player is taking damage from the environment. |
| `DamageReason.NPC` | `4` | Player is taking damage from a non-player character. |

## FacingMode

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `FacingMode.FACE_AIM_WHEN_ACTIVE` | `0` | Player will face the direction of their aim while moving. |
| `FacingMode.FACE_AIM_ALWAYS` | `1` | Player always faces the direction of their aim. |
| `FacingMode.FACE_MOVEMENT` | `2` | Player faces the direction of their movement. |

## IKAnchorType

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `IKAnchorType.LEFT_HAND` | `0` | The left hand. |
| `IKAnchorType.RIGHT_HAND` | `1` | The right hand. |
| `IKAnchorType.PELVIS` | `2` | The pelvis. |
| `IKAnchorType.LEFT_FOOT` | `3` | The left foot. |
| `IKAnchorType.RIGHT_FOOT` | `4` | The right foot. |

## ImageTileType

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `ImageTileType.NONE` | `0` | The texture is stretched to the size of the container. |
| `ImageTileType.HORIZONTAL` | `1` | The texture is tiled horizontally and stretched vertically. |
| `ImageTileType.VERTICAL` | `2` | The texture is tiled vertically and stretched horizontally. |
| `ImageTileType.BOTH` | `3` | The texture is tiled along both axes. |

## LeaderboardType

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `LeaderboardType.GLOBAL` | `0` | Global all-time leaderboard. |
| `LeaderboardType.DAILY` | `1` | Daily leaderboard that resets every 24 hours. |
| `LeaderboardType.WEEKLY` | `2` | Weekly leaderboard that resets every 7 days. |
| `LeaderboardType.MONTHLY` | `3` | Weekly leaderboard that resets at the beginning of each month. |

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
| `MovementMode.NONE` | `0` | Movement is disabled. |
| `MovementMode.WALKING` | `1` | Player is standing or walking. |
| `MovementMode.FALLING` | `3` | Player is jumping or falling. |
| `MovementMode.SWIMMING` | `4` | Player is swimming. |
| `MovementMode.FLYING` | `5` | Player is flying. |
| `MovementMode.SLIDING` | `6` | Coming Soon |

## NetReferenceType

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `NetReferenceType.LEADERBOARD` | `1` | Leaderboard key. |
| `NetReferenceType.SHARED_STORAGE` | `2` | Player shared storage key. |
| `NetReferenceType.CREATOR_PERK` | `3` | Creator perk. |
| `NetReferenceType.UNKNOWN` | `0` | Unknown `NetReference`. |

## Orientation

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `Orientation.HORIZONTAL` | `0` | Scrolls horizontally. |
| `Orientation.VERTICAL` | `1` | Scrolls vertically. |

## PlayerTransferReason

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `PlayerTransferReason.UNKNOWN` | `0` | Player left or joined for an unknown reason, or has opted out of sharing this information. |
| `PlayerTransferReason.CHARACTER` | `1` | Player left to manage their character avatar. |
| `PlayerTransferReason.CREATE` | `2` | Player left to create games. |
| `PlayerTransferReason.SHOP` | `3` | Player left to browse the shop. |
| `PlayerTransferReason.BROWSE` | `4` | Player browsed to a game in the main menu or via the website. |
| `PlayerTransferReason.SOCIAL` | `5` | Player joined a friend in a game via the social panel. |
| `PlayerTransferReason.PORTAL` | `6` | Player used a portal from one game to another (or otherwise made use of the `TransferToGame()` function.) |
| `PlayerTransferReason.AFK` | `7` | Player was disconnected for being AFK. |
| `PlayerTransferReason.EXIT` | `8` | Player exited Core. Core was sad. |
| `PlayerTransferReason.PORTAL_SCENE` | `9` | Player used a portal from one scene to another (or otherwise made use of the `TransferToScene()` function.) |

## PrivateNetworkedDataResultCode

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `PrivateNetworkedDataResultCode.SUCCESS` | `0` | The operation succeeded. |
| `PrivateNetworkedDataResultCode.FAILURE` | `1` | An error occurred. |
| `PrivateNetworkedDataResultCode.EXCEEDED_SIZE_LIMIT` | `2` | The value is too large and was not stored. |

## ProgressBarFillType

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `ProgressBarFillType.LEFT_TO_RIGHT` | `0` | Progress bar fills from left to right. |
| `ProgressBarFillType.RIGHT_TO_LEFT` | `1` | Progress bar fills from right to left. |
| `ProgressBarFillType.TOP_TO_BOTTOM` | `3` | Progress bar fills from top to bottom. |
| `ProgressBarFillType.BOTTOM_TO_TOP` | `4` | Progress bar fills from bottom to top. |
| `ProgressBarFillType.FROM_CENTER` | `2` | Progress bar fills from the center outward. |

## RespawnMode

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `RespawnMode.NONE` | `0` | Player does not respawn automatically. |
| `RespawnMode.IN_PLACE` | `1` | Respawns the player at the same location and rotation as when they died. |
| `RespawnMode.ROUND_ROBIN` | `2` | Selects start points in a repeating sequential pattern. |
| `RespawnMode.AT_CLOSEST_SPAWN_POINT` | `3` | Respawns the player at the start point closest to the location the player died. |
| `RespawnMode.FARTHEST_FROM_OTHER_PLAYERS` | `4` | Respawns the player at the start point farthest from any other player. |
| `RespawnMode.FARTHEST_FROM_ENEMY` | `5` | Respawns the player at the start point farthest from an enemy player. |
| `RespawnMode.RANDOM` | `6` | Respawns the player at a random start point. |

## RewardsDialogTab

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `RewardsDialogTab.QUESTS` | `1` | The quests tab. |
| `RewardsDialogTab.GAMES` | `2` | The games tab. |

## RotationMode

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `RotationMode.CAMERA` | `0` | Default, uses the rotation of the active `Camera` object. |
| `RotationMode.NONE` | `1` | Camera does not rotate. |
| `RotationMode.LOOK_ANGLE` | `2` | Camera rotates based on player's look direction. |

## SpawnMode

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `SpawnMode.RANDOM` | `0` | Spawns the player at a random start point. |
| `SpawnMode.ROUND_ROBIN` | `1` | Selects start points in a repeating sequential pattern. |
| `SpawnMode.FARTHEST_FROM_OTHER_PLAYERS` | `2` | Spawns the player at the start point farthest from any other player. |
| `SpawnMode.FARTHEST_FROM_ENEMY` | `3` | Spawns the player at the start point farthest from an enemy player. |

## StorageResultCode

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `StorageResultCode.SUCCESS` | `0` | Data was successfully saved. |
| `StorageResultCode.FAILURE` | `2` | An error occurred saving the player's data. |
| `StorageResultCode.STORAGE_DISABLED` | `1` | Player Storage is disabled in the game's settings. |
| `StorageResultCode.EXCEEDED_SIZE_LIMIT` | `3` | The provided data is too large and could not be saved. |

## TaskStatus

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `TaskStatus.UNINITIALIZED` | `0` | Indicates the `Task` reference is invalid or the task has been destroyed. |
| `TaskStatus.SCHEDULED` | `1` | The task is scheduled to run at some point in the future. |
| `TaskStatus.RUNNING` | `2` | The task is in the process of executing. Note that multiple tasks may be in this state, for example if an executing task triggers an event with connected listeners, that task will still be considered "running" while the event listeners execute. |
| `TaskStatus.COMPLETED` | `3` | The task has successfully finished executing. |
| `TaskStatus.YIELDED` | `4` | The task has yielded through an explicit call to `coroutine.yield()`. Tasks in this state are no longer managed by Core's Script Runtime and must be resumed manually. |
| `TaskStatus.FAILED` | `5` | An error occurred while executing the task. |
| `TaskStatus.CANCELED` | `6` | The task was canceled, either by a call to `Task.Cancel()` or because its script was destroyed. |
| `TaskStatus.BLOCKED` | `7` | The task is waiting for an operation to complete before resuming execution. Examples include a call to `CoreObjectReference:WaitForObject()`, `CorePlatform.GetGameInfo()`, etc. |

## TextJustify

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `TextJustify.LEFT` | `0` | Left-aligned. |
| `TextJustify.CENTER` | `1` | Centered. |
| `TextJustify.RIGHT` | `2` | Right-aligned. |

## UIPivot

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `UIPivot.TOP_LEFT` | `0` | Pivots from the top-left corner. |
| `UIPivot.TOP_CENTER` | `1` | Pivots from the center of the top edge. |
| `UIPivot.TOP_RIGHT` | `2` | Pivots from the top-right corner. |
| `UIPivot.MIDDLE_LEFT` | `3` | Pivots from the center of the left edge. |
| `UIPivot.MIDDLE_CENTER` | `4` | Pivots from the center of the object. |
| `UIPivot.MIDDLE_RIGHT` | `5` | Pivots from the center of the right edge. |
| `UIPivot.BOTTOM_LEFT` | `6` | Pivots from the bottom-left corner. |
| `UIPivot.BOTTOM_CENTER` | `7` | Pivots from the center of the bottom edge. |
| `UIPivot.BOTTOM_RIGHT` | `8` | Pivots from the bottom-right corner. |
| `UIPivot.CUSTOM` | `9` | Currently unused. |

## Visibility

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `Visibility.INHERIT` | `0` | Object is visible if its parent is visible, or if it has no parent. |
| `Visibility.FORCE_ON` | `1` | Object is visible, regardless of parent state. |
| `Visibility.FORCE_OFF` | `2` | Object is not visible, regardless of parent state. |

## VoiceChatMode

| Enum Name | Value | Description |
| --------- | ----------- | ----------- |
| `VoiceChatMode.NONE` | `0` | Voice chat is disabled. |
| `VoiceChatMode.TEAM` | `1` | Voice chat is enabled for team members. |
| `VoiceChatMode.ALL` | `2` | Voice chat is enabled for all players in the game instance. |
