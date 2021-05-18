---
id: offline_storage
name: Offline Storage
title: Offline Storage
tags:
    - Reference
---

# Offline Storage

## Overview

Creators can access stored player data, both in normal [Persistant Storage](persistent_storage.md) tables and [Shared Data Keys](shared_storage.md) when players are offline using **Offline Storage**. This data can searched and loaded for players by ID, but not changed unless the player is online.

## Accessing Player Data

### Persistent Storage

The [``Storage.GetOfflinePlayerData``](https://docs.coregames.com/api/storage/) function allows you to access stored player data tables the same way you would for online players. You will not be able to modify this data, however, until players are connected to the game again with ``Storage.SetPlayerData``.

### Shared Keys

The [``Storage.GetSharedOfflinePlayerData``](https://docs.coregames.com/api/storage/) allows you to access data on Shared Data Tables between games for offline players. To access this you will need a reference to the data table key and the player id.

## Finding Player ID's

Finding player ID's is not as direct when they are offline, and cannot be found through the [``Game.GetPlayers``]()

### Using a Leaderboard

[Leaderboards](https://docs.coregames.com/api/leaderboards/) players' names, id's and a score, and can be used as a way to keep track of players whose data will be needed later for a specific scenario. See the [Leaderboard Reference](leaderboards.md) for more information about using them.

---

## Learn More

[Persistent Storage Reference](persistent_storage.md) | [Shared Storage Reference](shared_storage.md) | [Storage in the Core Lua API](https://docs.coregames.com/api/storage/) | [Leaderboards in the Core Lua API](https://docs.coregames.com/api/leaderboards/) | [Persistent Storage Tutorial](persistent_storage_tutorial.md)
