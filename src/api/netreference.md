---
id: netreference
name: NetReference
title: NetReference
tags:
    - API
---

# API: NetReference

## Description

A reference to a network resource, such as a player leaderboard. NetReferences are not created directly, but may be returned by `CoreObject:GetCustomProperty()`.

## API

### Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `isAssigned` | `bool` | Returns true if this reference has been assigned a value. This does not necessarily mean the reference is valid, but does mean it is at least not empty. | Read-Only |
| `referenceType` | `NetReferenceType` | Returns one of `NetReferenceType.LEADERBOARD`, `NetReferenceType.SHARED_STORAGE`, or `NetReferenceType.UNKNOWN` to indicate which type of NetReference this is. | Read-Only |

## Tutorials

[Networking in Core](../tutorials/networking.md)
