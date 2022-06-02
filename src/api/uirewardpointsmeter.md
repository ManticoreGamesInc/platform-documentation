---
id: uirewardpointsmeter
name: UIRewardPointsMeter
title: UIRewardPointsMeter
tags:
    - API
---

# UIRewardPointsMeter

A UIControl that displays the a players progress towards the daily Reward Points cap. Inherits from [UIControl](uicontrol.md).

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `isHittable` | `boolean` | When set to `true`, this control can receive input from the cursor and blocks input to controls behind it. When set to `false`, the cursor ignores this control and can interact with controls behind it. | Read-Write |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetCurrentTouchIndex()` | `integer` | Returns the touch index currently interacting with this control. Returns `nil` if the control is not currently being interacted with. | Client-Only |

## Events

| Event Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `touchStartedEvent` | [`Event`](event.md)<[`UIRewardPointsMeter`](uirewardpointsmeter.md), [`Vector2`](vector2.md) location, `integer` touchIndex> | Fired when the player starts touching the control on a touch input device. Parameters are the screen location of the touch and a touch index used to distinguish between separate touches on a multitouch device. | Client-Only |
| `touchStoppedEvent` | [`Event`](event.md)<[`UIRewardPointsMeter`](uirewardpointsmeter.md), [`Vector2`](vector2.md) location, `integer` touchIndex> | Fired when the player stops touching the control on a touch input device. Parameters are the screen location from which the touch was released and a touch index used to distinguish between separate touches on a multitouch device. | Client-Only |
| `tappedEvent` | [`Event`](event.md)<[`UIRewardPointsMeter`](uirewardpointsmeter.md), [`Vector2`](vector2.md) location, `integer` touchIndex> | Fired when the player taps the control on a touch input device. Parameters are the screen location of the tap and the touch index with which the tap was performed. | Client-Only |
| `flickedEvent` | [`Event`](event.md)<[`UIRewardPointsMeter`](uirewardpointsmeter.md), `number` angle> | Fired when the player performs a quick flicking gesture on the control on a touch input device. The `angle` parameter indicates the direction of the flick. 0 indicates a flick to the right. Values increase in degrees counter-clockwise, so 90 indicates a flick straight up, 180 indicates a flick to the left, etc. | Client-Only |
| `pinchStartedEvent` | [`Event`](event.md)<[`UIRewardPointsMeter`](uirewardpointsmeter.md)> | Fired when the player begins a pinching gesture on the control on a touch input device. `Input.GetPinchValue()` may be polled during the pinch gesture to determine how far the player has pinched. | Client-Only |
| `pinchStoppedEvent` | [`Event`](event.md)<[`UIRewardPointsMeter`](uirewardpointsmeter.md)> | Fired when the player ends a pinching gesture on a touch input device. | Client-Only |
| `rotateStartedEvent` | [`Event`](event.md)<[`UIRewardPointsMeter`](uirewardpointsmeter.md)> | Fired when the player begins a rotating gesture on the control on a touch input device. `Input.GetRotateValue()` may be polled during the rotate gesture to determine how far the player has rotated. | Client-Only |
| `rotateStoppedEvent` | [`Event`](event.md)<[`UIRewardPointsMeter`](uirewardpointsmeter.md)> | Fired when the player ends a rotating gesture on a touch input device. | Client-Only |
