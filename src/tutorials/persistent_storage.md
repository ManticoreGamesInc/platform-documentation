---
id: persistent_storage
name: Persistent Data Storage
title: Persistent Data Storage
tags:
    - Reference
---

# Persistent Storage

> Persistent Storage allows you to save player data between play sessions.

## Introduction

To save player's equipment, resources, level, or any other value that you associate with players, you can use **Persistent Storage**. This is a table of data organized by player, that will allow you access data for currently connected players.

To save and use data for all players who have ever accessed the game, regardless of whether or not they are currently connected, use a [**Global Leaderboard**](https://docs.coregames.com/core_api/#leaderboards).

For a complete tutorial on using Persistent Storage to save player resources and equipment, see the [Persistent Storage Tutorial](persistent_storage_tutorial.md)

## Using Persistent Storage

### Enable Storage

Storage is not enabled by default, and must be turned on for any project that will use shared data tables.

1. Select the **Game Settings** object in the **Hierarchy** and open the **Properties** window.
2. In the **General** section, check the box next to **Enable Player Storage**

![Enable Player Storage](../img/Storage/EnablePlayerStorage.png)

### Update Player Data

After enabling Player Storage, updating a value in the data table is a three step process. To learn more about working with Storage, see the [Core API](https://docs.coregames.com/core_api/#storage)

1. Create a variable and assignt it to the player's data table using  ``Storage.GetPlayerData()``
2. Change a value on the table like any other table. See the [Lua Fundamentals](scripting_intro.md) reference for more information about how to do this.
3. Replace the player's old table with the modified one using ``Storage.SetPlayerData()``

For examples of using **Persistent Storage**, see the [Persistent Storage Examples]([persistent_storage_tutorial.md](https://docs.coregames.com/api/examples/#sharedstorage)

<!-- TODO: Add more tasks
- Clear Data -->

---

## Learn More

[Persistent Storage Examples](https://docs.coregames.com/api/examples/#storage) | [Persistent Storage Tutorial](persistent_storage_tutorial.md) | [Shared Storage](shared_storage.md)
