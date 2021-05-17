---
id: aiactivity
name: AIActivity
title: AIActivity
tags:
    - API
---

# AIActivity

AIActivity is an Object registered with an `AIActivityHandler`, representing one possible activity that the handler may execute each time it ticks.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `name` | `string` | This activity's name. | Read-Only |
| `owner` | [`AIActivityHandler`](aiactivityhandler.md) | The AIActivityHandler that owns this activity. May be `nil` if this activity has been removed from its owner. | Read-Only |
| `priority` | `number` | The current priority of this activity. Expected to be greater than 0, and expected to be adjusted by the `tick` function provided when adding the activity to its handler, though this can be set at any time. | Read-Write |
| `isHighestPriority` | `boolean` | True if this activity is the activity with the highest priority among its owner's list of activities. Note that this value does not update immediately when setting an activity's priority, but will be updated by the handler each tick when the handler evaluates its list of activities. | Read-Only |
| `elapsedTime` | `number` | If this activity is the highest priority for its handler, returns the length of time for which it has been highest priority. Otherwise returns the length of time since it was last highest priority, or since it was added to the handler. | Read-Only |
| `isDebugModeEnabled` | `boolean` | True if this activity has debugging enabled in the AI Debugger. Useful for deciding whether to log additional information about specific activities. | Read-Only |
