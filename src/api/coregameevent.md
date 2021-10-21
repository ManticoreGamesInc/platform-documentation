---
id: coregameevent
name: CoreGameEvent
title: CoreGameEvent
tags:
    - API
---

# CoreGameEvent

Metadata about a creator-defined event for a game on the Core platform.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `id` | `string` | The ID of the event. | Read-Only |
| `gameId` | `string` | The ID of the game this event belongs to. | Read-Only |
| `name` | `string` | The display name of the event. | Read-Only |
| `referenceName` | `string` | The reference name of the event. | Read-Only |
| `description` | `string` | The description of the event. | Read-Only |
| `state` | [`CoreGameEventState`](enums.md#coregameeventstate) | The current state of the event (active, scheduled, etc). | Read-Only |
| `registeredPlayerCount` | `integer` | The number of players currently registered for this event. | Read-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetTags()` | `Array`<`string`> | Returns a list of the tags selected when this event was published. | None |
| `GetStartDateTime()` | `CoreDateTime` | Returns the start date and time of the event. | None |
| `GetEndDateTime()` | `CoreDateTime` | Returns the end date and time of the event. | None |

## Learn More

[CorePlatform.GetGameEventsForGame()](coreplatform.md)
