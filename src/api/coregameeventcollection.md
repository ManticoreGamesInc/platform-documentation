---
id: coregameeventcollection
name: CoreGameEventCollection
title: CoreGameEventCollection
tags:
    - API
---

# CoreGameEventCollection

Contains a set of results from [CorePlatform.GetGameEventCollection()](coreplatform.md) and related functions. Depending on how many events are available, results may be separated into multiple pages. The `.hasMoreResults` property may be checked to determine whether more events are available. Those results may be retrieved using the `:GetMoreResults()` function.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `hasMoreResults` | `boolean` | Returns `true` if there are more events available to be requested. | Read-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetResults()` | `Array`<[`CoreGameEvent`](coregameevent.md)> | Returns the list of events contained in this set of results. This may return an empty table. | None |
| `GetMoreResults()` | [`CoreGameEventCollection`](coregameeventcollection.md) | Requests the next set of results for this list of events and returns a new collection containing those results. Returns `nil` if the `hasMoreResults` property is `false`. This function may yield until a result is available, and may raise an error if an error occurs retrieving the information. | None |

## Learn More

[CorePlatform.GetGameEventCollection()](coreplatform.md)
