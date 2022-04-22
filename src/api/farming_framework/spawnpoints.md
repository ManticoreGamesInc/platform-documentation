---
id: spawn points
name: Spawn Points
title: Spawn Points
---

# Spawn Points

## Functions

| Class Function Name | Return Type | Description | Tags |
| ------------------- | ----------- | ----------- | ---- |
| `GetSpawnPointState(string)` | `SpawnPointState` | Gets a table of information about a Spawn Point. | None |
| `GetSpawnPointTargetPosition(string)` | `Vector3` | Find the target position of a specific Spawn Point. | None |
| `GetSpawnPointTargetRotation(string)` | `Rotation` | Find the target rotation of a specific Spawn Point. | None |
| `GetSpawnPoints(string, string|nil)` | `Array<string>` | Finds all the Spawn Points for an id, with an optional key for further filtering. | None |
| `RegisterSpawnPoint(string, table)` | `None` | Registers a spawn point to the system. | None |
| `UnregisterSpawnPoint(string)` | `None` | Removes a Spawn Point. | None |
