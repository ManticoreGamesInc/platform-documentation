---
id: corefriendcollection
name: CoreFriendCollection
title: CoreFriendCollection
tags:
    - API
---

# CoreFriendCollection

Contains a set of results from [CoreSocial.GetFriends()](coresocial.md). Depending on how many friends a player has, results may be separated into multiple pages. The `.hasMoreResults` property may be checked to determine whether more friends are available. Those results may be retrieved using the `:GetMoreResults()` function.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `hasMoreResults` | `boolean` | Returns `true` if there are more friends available to be requested. | Read-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetResults()` | `Array<`[`CoreFriendCollectionEntry`](corefriendcollectionentry.md)`>` | Returns the list of friends contained in this set of results. This may return an empty table for players who have no friends. | None |
| `GetMoreResults()` | [`CoreFriendCollection`](corefriendcollection.md) | Requests the next set of results for this list of friends and returns a new collection containing those results. Returns `nil` if the `hasMoreResults` property is `false`. This function may yield until a result is available, and may raise an error if an error occurs retrieving the information. | None |

## Learn More

[CoreSocial.GetFriends()](coresocial.md)
