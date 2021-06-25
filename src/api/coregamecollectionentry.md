---
id: coregamecollectionentry
name: CoreGameCollectionEntry
title: CoreGameCollectionEntry
tags:
    - API
---

# CoreGameCollectionEntry

Metadata about a published game in a collection on the Core platform. Additional metadata is available via [CorePlatform.GetGameInfo()](coreplatform.md).

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `id` | `string` | The ID of the game. | Read-Only |
| `parentGameId` | `string` | The ID of this game's parent game if there is one, or else `nil`. | Read-Only |
| `name` | `string` | The name of the game. | Read-Only |
| `ownerId` | `string` | The player ID of the creator who published the game. | Read-Only |
| `ownerName` | `string` | The player name of the creator who published the game. | Read-Only |

## Learn More

[CorePlatform.GetGameCollection()](coreplatform.md)
