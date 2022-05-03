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
