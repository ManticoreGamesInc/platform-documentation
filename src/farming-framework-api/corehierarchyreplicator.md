---
id: core hierarchy replicator
name: Core Hierarchy Replicator
title: Core Hierarchy Replicator
---

# Core Hierarchy Replicator

## Functions

| Class Function Name | Return Type | Description | Tags |
| ------------------- | ----------- | ----------- | ---- |
| `ActivateReplicator(string, boolean|nil)` | `None` | On the server, this activates the replicator for all players who want to receive from it. On the client, its will activate the replicator as long as the replicator is active on the server. | None |
| `ActivateReplicatorForPlayer(string, string)` | `None` | On the server, this marks that a player wishes to receive replicated data. | None |
| `AddCoreObjectToSpawner(table, any)` | `None` | Manually adds a core object to an instance, associating it with the spawner. | None |
| `AddInstance(instance)` | `None` | Adds an instance into the replicator, it will be automatically synchronized and core objects will be spawned. | None |
| `ClearCurrentInstance()` | `None` | Called after an instance is spawned to ensure you cant accidentally get a nil instance. | None |
| `CountPendingClientInstancesToSpawn(string)` | `number` | Counts the number of client instances pending to be spawned on the local machine for a specific replicator. | None |
| `CountPendingServerInstancesToSpawn(string)` | `number` | Counts the number of server instances pending to be spawned on the local machine for a specific replicator. | None |
| `CountPendingStaticInstancesToSpawn(string)` | `number` | Counts the number of static instances pending to be spawned on the local machine for a specific replicator. | None |
| `CreateInstance(string)` | `instance` | Creates a new instance table but doesn't register it. See API.AddInstance. | None |
| `DeactivateReplicator(string, boolean|nil)` | `None` | On the server, this will deactivate a replicator and all players will have their instances removed. | None |
| `DeactivateReplicatorForPlayer(string, string)` | `None` | On the server, this marks that a player doesn't wish to receive replicated data. | None |
| `DestroyAllInstances(string, boolean|nil)` | `None` | Destroys all the instances in the replicator. | None |
| `DestroyInstance(instance, boolean|nil)` | `None` | Destroys an instance. | None |
| `FindReplicatorIdByAncestors(CoreObject)` | `string` | Searches through self and parents for a replicator | None |
| `FindReplicatorIdentifier(CoreObject)` | `string` | Gets the id of a core object as would be used by the replicator system. | None |
| `GetBufferString(string, boolean)` | `string @Non human readable bit string` | Gives you a string of all the instances in the buffer. Server only. | None |
| `GetClientCoreObject(instance)` | `CoreObject` | Finds the client spawned core object for an instance. | None |
| `GetCurrentInstance()` | `None` | If called during the spawning of an instance, will return the instance, else nil. | None |
| `GetInitialBufferString(string)` | `string @Non human readable bit string` | Gives you a string of all the instances in the buffer after initialization. Server only. | None |
| `GetInstance(CoreObject)` | `instance` | Finds the instance associated with this core object. | None |
| `GetInstances(string)` | `Array<instance>` | Returns an array of all the instances for this replicator. | None |
| `GetNetworkedCoreObject(instance)` | `CoreObject` | Finds the networked spawned core object for an instance. | None |
| `GetPlayerPrivateNetworkKey(string)` | `string` | Gets the private network key used for a replicator. | None |
| `GetReplicatorSpawnParent(string)` | `CoreObject` | Returns the core object that instances are spawned in. | None |
| `GetReplicators()` | `Array<string>` | Gets a table of all the replicators currently registered. | None |
| `GetServerCoreObject(instance)` | `CoreObject` | Finds the server spawned core object for an instance. | None |
| `GetStaticCoreObject(instance)` | `CoreObject` | Finds the spawned static core object for an instance. | None |
| `GetUserFunctions(string)` | `table` | Returns the User Functions for a Replicator. | None |
| `GetUserSettings(string)` | `table` | Returns a table of per-replicator settings that may have been initialized by the UserFunctions. | None |
| `IsPlayerPrivateNetworkKey(string|nil, string)` | `boolean` | Check if a key is one of the keys used for a replicator when using PlayerPrivateNetworkData. | None |
| `IsReady()` | `boolean` | Returns true if spawners have been registered. | None |
| `IsReplicatorId()` | `None` | Is the id registered | None |
| `IsReplicatorLocked()` | `None` | None | None |
| `LoadFromBuffer(string, string)` | `None` | Clears a replicator and loads all the instances encoded in the string. Server only. | None |
| `LockReplicator()` | `None` | None | None |
| `ModifyInstance(instance)` | `None` | Modifies an instance. It will be re-serialized to ensure client and server match. | None |
| `RegisterReplicator(string, table)` | `None` | Registers a replicator to the API | None |
| `RegisterSpawners(CoreObject)` | `None` | Called by the Spawners. | None |
| `SetCurrentInstance(instance)` | `None` | Spawners call this function before spawning an object so the object can find which instance it is easily. | None |
| `UnlockReplicator()` | `None` | None | None |
| `WaitForInstance(CoreObject, number|nil)` | `instance` | Waits for the instance for a core object. | None |
