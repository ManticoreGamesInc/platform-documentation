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

For a complete tutorial on using Persistent Storage to save player resources and equipment, see the [Persistent Storage Tutorial](persistent_storage_tutorial.md)

## Using Persistent Storage

### Enable Storage

Storage is not enabled by default, and must be turned on for any project that will use shared data tables.

1. Select the **Game Settings** object in the **Hierarchy** and open the **Properties** window.
2. In the **General** section, check the box next to **Enable Player Storage**

![Enable Player Storage](../img/Storage/EnablePlayerStorage.png)

### Update Player Data

After enabling Player Storage, updating a value in the data table is a three step process. To learn more about working with Storage, see the [Core API](../api/storage.md).

1. Create a variable and assign it to the player's data table using `Storage.GetPlayerData()`.
2. Change a value on the table like any other table. See the [Lua Fundamentals](scripting_intro.md) reference for more information about how to do this.
3. Replace the player's old table with the modified one using `Storage.SetPlayerData()`

For examples of using **Persistent Storage**, see the [Persistent Storage Examples](persistent_storage_tutorial.md)

## Offline Storage

Storage is available in a read-only format for players who are offline as well. See the [Offline Storage Reference](offline_storage.md) for more information.

---

## Learn More

[Persistent Storage Examples](../api/storage.md) | [Persistent Storage Tutorial](persistent_storage_tutorial.md) | [Shared Storage](shared_storage.md)
