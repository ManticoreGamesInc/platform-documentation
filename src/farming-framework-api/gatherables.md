---
id: gatherables
name: Gatherables
title: Gatherables
---

# Gatherables

Gatherables are a quick way to get large amounts of destroyable objects with multiple states into a scene with zero code and no additional networked objects.

Gatherables are groups of interactable objects that players can destroy to receive resources. Each gatherable object can have multiple states, drop resources, respawn over time and more.

All you need to do is drop a Gatherables template into your scene, swap out and create art and configure some values to make them look and act the way you want.

## Events

| Event Name | Return Type | Description | Tags |
| ---------- | ----------- | ----------- | ---- |
| `GATHERABLE_DESTROYED` | `Event<Player, entry>` | This event is sent when a Gatherable exits its last state. "entry" is a table with all of the Gatherable | Server |
| `GATHERABLE_GATHERED` | `Event<Player, entry>` | This event is sent every time a successful gather interaction takes place. "entry" is a table with all of the | Server |
| `GATHERABLE_RESPAWNED` | `Event<entry>` | This event is sent when a Gatherable object respawns. "entry" is a table with all of the Gatherable Object | Server |
| `RESET_GATHERABLE_GROUP` | `Event<Integer>` |  | None |

## Functions

| Class Function Name | Return Type | Description | Tags |
| ------------------- | ----------- | ----------- | ---- |
| `DestroyGatherableAtIndex()` | `None` | None | None |
| `FindGatherableGroupId()` | `None` | None | None |
| `FindGatherableIndex()` | `None` | None | None |
| `FindGatherablesInReplicator()` | `None` | None | None |
| `GetGatherableAtIndex()` | `None` | None | None |
| `GetGatherableGroupState()` | `None` | None | None |
| `IsGatherable()` | `None` | None | None |
| `RegisterGatherableGroup()` | `None` | None | None |
| `UnregisterGatherableGroup()` | `None` | None | None |
