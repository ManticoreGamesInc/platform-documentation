---
id: selecting_a_storage_type
name: Selecting a Storage Type
title: Selecting a Storage Type
tags:
  - Reference
  - Tutorial
---

# Selecting a Storage Type

**Core** has different storage types that can be used to save data for players, or for your game. Selecting a storage type for your game is an important design decision, but it is not always clear on the best storage type to use. To help creators pick a suitable storage type the sections below will go over various ways they can be used.

## Player Storage

[Player Storage](../references/persistent_storage.md) is used to persistently save data for a specific player between sessions. For example, if a player can earn some form of currency in your game (that is, Coins from pickups), then this data can be saved to the player's storage so the next time they join your game, they will start with the amount of coins that they previously had in an earlier session.

Player Storage is also a good way to save player settings for a specific game. For example, if you allow the player to adjust the music volume in your game, then saving this for the player will allow you to apply that music volume the next time they join so they don't have to adjust it every time.

Another use case for Player Storage, is saving a player's inventory. If your game allows players to pickup items in the world, purchase weapons from a vendor, then saving this to player storage would be great for the player. This will allow them to return to your game and continue where they left off and have all the items they collected or purchased in the previous session.

Other use cases for using Player Storage:

- Trophies / Achievements.
- Player level / experience.
- Player high score.
- Player resources (for example, rocks, logs).

## Player Shared Storage

[Player Shared Storage](../references/shared_storage.md) is similar to **Player Storage**, the difference being that the key created can be used in your other games. Meaning that the data you save in one game can be loaded in a completely different game owned by you.

Player Shared Storage can be used in a way that can allow your games to be more connected. For example, having a currency (that is Coins) that is shared across all your games. Players could earn coins from any of yours games, and with it being stored in a shared key, they could use that currency to purchase items (for example, Cosmetics) from different games.

Another idea of a using Player Shared Storage is a player loyalty system. When a player has played any of your other games, they could be rewarded loyalty points that can be spent on unique items that can only be purchased with loyalty points.

## Concurrent Player Storage

[Concurrent Player Storage](../references/concurrent_storage.md) is similar to [Player Storage](../references/persistent_storage.md), the difference being that data can be saved and read from that player's storage when they are on a different server of the game, and when offline.

This type of storage allows you to create interesting features, for example, if a player has a farm and wants to play with their friend, they could give permission for that friend to edit the farm. This would allow for the player's friends to edit the farm when on a different server or when the farm owner is offline, creating a co-operative experience.

Another use of Concurrent Player Storage is gifting items to friends that are on a different server or offline. Core has a [Social API](../api/coresocial.md) that supports getting a player's friends list. This can be used to display the friends in game for that player to pick from who would receive the gift. That friend would receive a gift notification if they are in game, on a different server, or when they next join the game, because the data can be stored even when the friend is offline.

## Concurrent Shared Player Storage

[Concurrent Shared Player Storage](../references/concurrent_storage.md) allows you to save player data between different games, servers and play sessions. It is the same as **Concurrent Player Storage** except that the player data can be used in multiple games.

With the storage being shared, it means it can be used across different games. This could be used for a system to allow cross game trading between players. Imagine having an inventory that is shared between your games, players would be able to trade items from their inventory to other players even if they were playing a different game or offline.

Another use case for this storage type could be a system that allows players to leave behind messages for their friends. When a friend joins a server, any messages their friends has would be loaded and displayed to that player. This could be a good way for friends to help each other by giving them little tips on solving a puzzle in a game.

## Concurrent Creator Storage

[Concurrent Creator Storage](../references/concurrent_storage.md) allows you to save global data between multiple games and servers, making it possible to make games that share the same persistent data regardless of players activity.

This type of storage really opens up your games for some fun ideas for your players. For example, imagine players on different servers that are hunting down a special enemy that only spawns under certain conditions, and maybe drops a special item. When one player finds the enemy, all players across all the servers would receive information that the enemy was found, and that would also spawn on all other servers.

Another use case for this type of storage, is having community goals. For example, maybe players need to chop down 50,000 trees. Once the goal is reached, all players would receive a special reward for reaching that goal.

With games having player chat just for that server instance, a global chat would be possible so that players on different servers would receive the chat messages from other players. This is a good way make a single player game feel a little more connected, allowing players to chat and maybe exchange tips and tricks.

## Learn More

[Player Storage Reference](../references/persistent_storage.md) | [Player Storage Tutorial](../tutorials/persistent_storage_tutorial.md) | [Player API](../api/player.md) | [Shared Storage Reference](../references/shared_storage.md) | [Concurrent Storage Reference](../references/concurrent_storage.md) | [Concurrent Storage Tutorial](../tutorials/concurrent_storage_tutorial.md) | [Storage API](../api/storage.md)
