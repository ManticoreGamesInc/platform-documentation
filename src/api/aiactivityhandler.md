---
id: aiactivityhandler
name: AIActivityHandler
title: AIActivityHandler
tags:
    - API
---

# AIActivityHandler

AIActivityHandle is a CoreObject which can manage one or more `AIActivity`. Each tick, the handler calls a function on each of its registered activities to give them a chance to reevaluate their priorities. It then ticks the highest priority activity again, allowing it to perform additional work.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `isSelectedInDebugger` | `boolean` | True if this activity handler is currently selected in the AI Debugger. | Read-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `AddActivity(string name, [table functions])` | [`AIActivity`](aiactivity.md) | Creates a new AIActivity registered to the handler with the given unique name and optional functions. Raises an error if the provided name is already in use by another activity in the same handler. `functions` may contain the following:<br>`tick - function(number deltaTime)`: Called for each activity on each tick by the handler, expected to adjust the priority of the activity.<br>`tickHighestPriority - function(number deltaTime)`: Called after `tick` for whichever activity has the highest priority within the handler.<br>`start - function()`: Called between `tick` and `tickHighestPriority` when an activity has become the new highest priority activity within the handler.<br>`stop - function()`: Called when the current highest priority activity has been removed from the handler or is otherwise no longer the highest priority activity. | None |
| `RemoveActivity(string name)` | `None` | Removes the activity with the given name from the handler. Logs a warning if no activity is found with that name. If the named activity is currently the highest priority activity in the handler, its `stop` function will be called. | None |
| `ClearActivities()` | `None` | Removes all activities from the handler. Calls the `stop` function for the highest priority activity. | None |
| `GetActivities()` | `Array<`[`AIActivity`](aiactivity.md)`>` | Returns an array of all of the handler's activities. | None |
| `FindActivity(string name)` | [`AIActivity`](aiactivity.md) | Returns the activity with the given name, or `nil` if that name is not found in the handler. | None |
