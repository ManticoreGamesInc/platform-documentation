---
id: ikanchor
name: IKAnchor
title: IKAnchor
tags:
    - API
---

# IKAnchor

IKAnchors are objects that can be used to control player animations. They can be used to specify the position of a specific hand, foot, or the hips of a player, and can be controlled from script to create complex animations.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `target` | [`Player`](player.md) | Which Player the IKAnchor is activated on. | Read-Only |
| `anchorType` | [`IKAnchorType`](enums.md#ikanchortype) | Which socket this IKAnchor applies to. | Read-Only |
| `blendInTime` | `number` | The duration over which this IKAnchor is blended when it is activated. | Read-Write |
| `blendOutTime` | `number` | The duration over which this IKAnchor is blended when it is deactivated. | Read-Write |
| `weight` | `number` | The amount this IKAnchor blends with the underlying animation. A value of 0 means the animation is player unchanged, and a value of 1 means the animation is ignored and the IKAnchor is used. | Read-Write |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Activate(Player)` | `None` | Activates the IKAnchor on the given player. | None |
| `Deactivate()` | `None` | Deactivates the IKAnchor from whatever player it is active on. | None |
| `GetAimOffset(Ability)` | [`Vector3`](vector3.md) | Returns the aim offset property. | None |
| `SetAimOffset(Vector3)` | `None` | Sets the aim offset of this IKAnchor. | None |

## Events

| Event Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `activatedEvent` | `Event<`[`IKAnchor`](ikanchor.md), [`Player`](player.md)`>` | Fired when this IKAnchor is activated on a player. | None |
| `deactivatedEvent` | `Event<`[`IKAnchor`](ikanchor.md), [`Player`](player.md)`>` | Fired when this IKAnchor is deactivated from a player. | None |
