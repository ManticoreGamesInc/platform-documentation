---
id: placeables
name: Placeables
title: Placeables
---

# Placeables

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
| `PlaceablePlaced` | `Event<instance>` | Sent when a Placeable object is placed into a Replicator. | Client |
| `PlaceableRemoved` | `Event<objectId, placeableId>` | Sent when a Placeable object is removed from a Replicator. | Client |
| `PrepareLinkedBuffs` | `Event<targetId>` | Sent prior to APIBuffs.Events.HandleBuffs and before all Buffs are linked. | Client |
| `ProducerCollected` | `Event<objectId, placeableId, producerId>` | Sent when a Producer is collected. | Client |
| `ProducerExpired` | `Event<objectId, placeableId, oldProducerId>` | Sent when a Producer expires. | Client |
| `ProducerPlaced` | `Event<objectId, placeableId, producerId>` | Sent when a Producer is placed into a Producer Base. | Client |
| `ProducerReadyForCollect` | `Event<objectId, placeableId, producerId>` | Sent when a Producer has finished building and is ready to be collected. | Client |
| `ProducerRemoved` | `Event<objectId, placeableId, oldProducerId>` | Sent when a Producer is removed from a Producer Base. | Client |
| `ProducerStartedBuilding` | `Event<objectId, placeableId, producerId>` | Sent when a Producer starts building or rebuilding. | Client |
| `TargetRegistered` | `Event<targetId>` | Sent when a Buff target is registered with the system. | Client |
| `TargetUnregistered` | `Event<targetId>` | Sent when a Buff target is unregistered from the system. | Client |

## Functions

| Class Function Name | Return Type | Description | Tags |
| ------------------- | ----------- | ----------- | ---- |
| `FindPlaceableIdByAncestors(CoreObject)` | `string` | Finds a Placeable Id by searching upward through the hierarchy. | None |
| `GetPlaceableState(string)` | `PlaceableState` | Returns the current state for a Placeable. | None |
| `GetPlacementLimitInfo()` | `None` | None | None |
| `HandlePlaceableDrops(table, Vector3, Player)` | `boolean` | Returns true if drops are successful. | None |
| `IsPlaceableRegistered(string)` | `boolean` | Returns true if the placeable id has been registered. | None |
| `RegisterPlaceable(string, table)` | `None` | Registers a Placeable so that interactions on it can occur. | None |
| `UnregisterPlaceable(string)` | `None` | Unregisters a Placeable and stops any further interactions from being allowed. This should be called when the Placeable is destroyed. | None |
