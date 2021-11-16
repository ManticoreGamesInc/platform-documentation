---
id: networkcontext
name: NetworkContext
title: NetworkContext
tags:
    - API
---

# NetworkContext

NetworkContext is a CoreObject representing a special folder containing client-only, server-only, or static objects.

They have no properties or functions of their own, but inherit everything from CoreObject.

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `SpawnSharedAsset(string assetId, [table parameters])` | [`CoreObject`](coreobject.md) | Spawns an instance of an asset into the world as a child of a networked Static Context, also spawning copies of the asset on clients without the overhead of additional networked objects. Any object spawned this way cannot be modified, as with other objects within a Static Context, but they may be destroyed by calling `DestroySharedAsset()` on the same `NetworkContext` instance. Raises an error if called on a non-networked Static Context or a Static Context which is a descendant of a Client Context or Server Context. Optional parameters can specify a transform for the spawned object. <br/>Supported parameters include: <br/>`position (Vector3)`: Position of the spawned object, relative to the parent NetworkContext. <br/>`rotation (Rotation or Quaternion)`: Local rotation of the spawned object. <br/>`scale (Vector3 or number)`: Scale of the spawned object, may be specified as a `Vector3` or as a `number` for uniform scale. <br/>`transform (Transform)`: The full transform of the spawned object. If `transform` is specified, it is an error to also specify `position`, `rotation`, or `scale`. | Server-Only |
| `DestroySharedAsset(CoreObject coreObject)` | `None` | Destroys an object that was spawned using `SpawnSharedAsset()`. Raises an error if `coreObject` was not created by this `NetworkContext`. | Server-Only |
