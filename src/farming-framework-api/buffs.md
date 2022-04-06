---
id: buffs
name: Buffs
title: Buffs
---

# Buffs

The Producers system allows you to build objects that take an input, change over time and generate an output. They were designed with farming / crops in mind, but can be used for a multitude of other cases. Some ideas:

1. A corn plant that grows over time and produces some corn. If not harvested in time it withers and dies.
2. A gas engine that can be filled, runs until it's empty and then stops.
3. A building that takes time to become fully constructed. Once constructed it generates currency periodically.

When mixed with the Buffs system these examples can become even more interesting:

1. A corn plant that needs a "watered" buff to grow.
2. A gas engine that, when running, emits a "power" buff that allows other Producers to progress.
3. A building that requires the "power" buff to generate currency. While generating currency it emits a "happiness" buff that affects other gameplay.

Like Gatherables, Producers make use of the Replicator functionality. This means they use 0 networked objects and run fairly efficiently at scale. Gatherables are more efficient when you wants many objects in your scene, so it becomes a choice between the two systems that depends on how much functionality you need vs. efficiency.

Producers also introduce a new system called Placeables. Placeables are objects that can be placed by the Player during game play. In most cases you will also want to use Player Lots to allow placed Producers to be saved to the Players Storage.

## Events

| Event Name | Return Type | Description | Tags |
| ---------- | ----------- | ----------- | ---- |
| `BuffAdded` | `Event<targetId, buffId>` | Sent when a Buff is added to a target. This will be sent even if the Buff is immediately removed. | Client |
| `BuffChanged` | `Event<targetId, buffId>` | Sent when a Buff changes. This will be sent periodically, usually when other state changes. | Client |
| `BuffFinished` | `Event<targetId, buffId>` | Sent when a timed Buff finishes. | Client |
| `BuffRelinked` | `Event<targetId, buffId>` | Sent when a Buff is linked to another object. | Client |
| `BuffRemoved` | `Event<targetId, buffId>` | Sent when a Buff is removed. | Client |
| `PrepareLinkedBuffs` | `Event<targetId>` | Sent prior to APIBuffs.Events.HandleBuffs and before all Buffs are linked. | Client |
| `TargetRegistered` | `Event<targetId>` | Sent when a Buff target is registered with the system. | Client |
| `TargetUnregistered` | `Event<targetId>` | Sent when a Buff target is unregistered from the system. | Client |

## Functions

| Class Function Name | Return Type | Description | Tags |
| ------------------- | ----------- | ----------- | ---- |
| `AddBuff(string, string, fun():number, number, BuffParams)` | `None` | Adds a buff. | None |
| `AddBuffsInRadius(string, number, string, fun():number, number, BuffParams)` | `None` | Adds a buff to targets in a radius from the source target Id. | None |
| `AddTargetRecieveBuff()` | `None` | None | None |
| `ClearTargetRecieveBuffs()` | `None` | None | None |
| `FindBuffId(number)` | `string` | Given a unique storage number, find the buffId. | None |
| `FindTargetByAncestors(CoreObject)` | `string, nil` | Finds a buff target by looking through the ancestors of a core object. | None |
| `GetAllTargets()` | `Array<string>` | Get all the buff targets currently registered. | None |
| `GetBuffDuration(any, any)` | `any` | Returns the duration of a buff. Will return 0 if the buff is permanent. Buffs can be stacked, so this is the duration of a single buff. | None |
| `GetBuffRemainingAmount(string, string, any)` | `number` | Find the remaining value (between 1 and 0, or 2 and 0 if theirs stacks etc). | None |
| `GetBuffRemainingTime(string, string, any)` | `number` | For a timed buff, how much remaining time (seconds) there is. | None |
| `GetBuffSetting(string, string)` | `any` | Finds a buff setting from the database. | None |
| `GetBuffs(string)` | `Array<string>` | Get all the current buffs on a target. | None |
| `GetTargetEvents()` | `None` | None | None |
| `GetTargetPosition(string)` | `Vector3` | Every buff target has a position in the world, this function finds that position. | None |
| `GetTargetsWithBuff(string)` | `Array<string>` | Get all the targets that have a certain buff on them. | None |
| `HandleFinishedTimedBuffs(string, number)` | `None` | Updates the buffs by removing any buffs that have expired. | None |
| `HasBuff(string, string)` | `boolean` | Check if a target has a buff on them. | None |
| `IsBuffLinked(string, string)` | `boolean` | If this returns true, it means the buff is 'linked' and wont time out. | None |
| `IsBuffPermanent(string, string)` | `boolean` | Determines if a buff is permanent and therefore wont have a duration. | None |
| `IsBuffTarget(string)` | `boolean` | Check if a targetId is a buff target. | None |
| `IsValidBuff(any)` | `boolean` | Check if a buffId is in the database. | None |
| `ReadBuffsFromTable(string, table, any, any)` | `None` | Reads all the current buffs from a table to a target. | None |
| `RegisterTarget(string, BuffTargetFunctionTable)` | `None` | Registers a target to the buff system so it can receive buffs. | None |
| `RemoveBuff(string, string)` | `None` | Remove a buff. | None |
| `RemoveTargetRecieveBuff()` | `None` | None | None |
| `RequestLinkedBuffsUpdate()` | `None` | None | None |
| `SetBuffDuration(any, any, any, any)` | `None` | Changes the duration of a buff. Note that the duration isn't networked so if you change it on the server you will want to change it on the client too. | None |
| `SetBuffRate(any, any, number, any)` | `None` | Sets the rate of a timed buff. by default its -1. | None |
| `SetBuffTimeFunction()` | `None` | None | None |
| `UnregisterTarget(string)` | `None` | Removes a target from the buff system. | None |
| `UpdateLinkedBuffs()` | `None` | Forces all the linked buffs to be relinked. Expensive to call. | None |
| `WriteBuffsToTable(string, number)` | `table` | Writes all the current buffs on a target to a table. | None |
