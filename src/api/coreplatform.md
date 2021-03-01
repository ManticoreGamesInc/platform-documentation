---
id: coreplatform
name: CorePlatform
title: CorePlatform
tags:
    - API
---

# CorePlatform

The CorePlatform namespace contains functions for retrieving game metadata from the Core platform.

## Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `CorePlatform.GetGameInfo(string gameId)` | [`CoreGameInfo`](coregameinfo.md) | Requests metadata for a game with the given ID. Accepts full game IDs (eg "67442ee5c0654855b51c4f5fc96ab0fd") as well as the shorter slug version ("67442e/farmers-market"). This function may yield until a result is available, and may raise an error if the game ID is invalid or if an error occurs retrieving the information. Results may be cached for later calls. | None |
| `CorePlatform.GetGameCollection(string collectionId)` | [`CoreGameCollectionEntry`](coregamecollectionentry.md) | Requests a list of games belonging to a given collection. This function may yield until a result is available, and may raise an error if the collection ID is invalid or if an error occurs retrieving the information. Results may be cached for later calls. Supported collection IDs include: "new", "popular", "hot_games", "active", "featured", "highest_rated", "most_played", and "tournament". | None |
