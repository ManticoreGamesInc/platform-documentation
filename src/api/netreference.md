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
| `referenceType` | [`NetReferenceType`](enums.md#netreferencetype) | Returns one of the following to indicate the type of NetReference: `NetReferenceType.LEADERBOARD`, `NetReferenceType.SHARED_STORAGE`, `NetReferenceType.SHARED_PLAYER_STORAGE`, `NetReferenceType.CONCURRENT_SHARED_PLAYER_STORAGE`, `NetReferenceType.CONCURRENT_CREATOR_STORAGE`, `NetReferenceType.CREATOR_PERK` or `NetReferenceType.UNKNOWN`. | Read-Only |

## Examples

Example using:

### `isAssigned`

### `referenceType`

In this example we make the script more robust by making sure the Net Reference is setup correctly, before proceeding with the algorithm. If something is wrong errors are printed that can help quickly fix the issue.

```lua
local NET_REF = script:GetCustomProperty("NetReference")

if not NET_REF.isAssigned then
    error("Net Reference for concurrent storage is not assigned.")
    return
end

if NET_REF.referenceType ~= NetReferenceType.CONCURRENT_CREATOR_STORAGE then
    error("Net Reference for concurrent storage is the wrong type.")
    return
end

-- Concurrent storage implementation
-- ...
```

See also: [Storage.GetConcurrentCreatorData](storage.md)

---

## Tutorials

[Networking in Core](../references/networking.md)
