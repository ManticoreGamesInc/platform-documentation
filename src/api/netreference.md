---
id: netreference
name: NetReference
title: NetReference
tags:
    - API
---

# NetReference

A reference to a network resource, such as a player leaderboard. NetReferences are not created directly, but may be returned by `CoreObject:GetCustomProperty()`.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `isAssigned` | `boolean` | Returns true if this reference has been assigned a value. This does not necessarily mean the reference is valid, but does mean it is at least not empty. | Read-Only |
| `referenceType` | [`NetReferenceType`](enums.md#netreferencetype) | Returns one of `NetReferenceType.LEADERBOARD`, `NetReferenceType.SHARED_STORAGE`, or `NetReferenceType.UNKNOWN` to indicate which type of NetReference this is. | Read-Only |

## Tutorials

[Networking in Core](../tutorials/networking.md)
