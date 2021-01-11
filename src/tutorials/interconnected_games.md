---
id: interconnected_games
name: Interconnected Games
title: Interconnected Games
tags:
    - Reference
---

# Interconnected Games

## Introduction

Core makes it easy for players to move between games, and for creators to link multiple games together into a massive, interconnected game world. Creators can offer portals to any other creator's game, but they can also save data between their own projects, and create parent-child game relationships that put players in one main game while they move through others.

## Jumping Between Games

You can direct players to another game through both a **Game Portal** Core Object and through a simple line of code. The only thing required is the **Game ID**, which is part of the game page's URL on [**coregames.com**](https://www.coregames.com/).

### Find a Game ID

1. Navigate to your game page. You can do this by following the shareable link from the create menu, or by searching for the game title at [**coregames.com**](https://www.coregames.com/).
2. In the URL in the top, you should see something that beings with **coregames.com/games/**. Copy everything that comes ***after*** that part of the URL. This is the **Game ID**

![Find a Game ID](../img/InterconnectedGames/InterconnectedGames_FindID.png){: .center loading="lazy" }

### The Game Portal Object

![A Default Game Portal](../img/InterconnectedGames/InterconnectedGames_GamePortal.png){: .center loading="lazy" }

The **Game Portal** allows a no-scripting solution to creating portals between games. It includes visual effects and all the logic needed to make a gate between worlds.

To use the Game Portal:

1. In **Core Content**, search for ``Game Portal``, or open the **Game Components** and **Map** sections to find it in the **General** subcategory.
2. Click and drag the **Game Portal** into either the **Main Viewport** or the **Hierarchy** to add it to your project.
3. Select the **Game Portal** in the **Hierarchy** and open the **Properties** window.
4. In the **Custom** section find the **DestinationGame** property, and paste the **Game ID** into this field.

![Paste Game ID in Game Portal Properties](../img/InterconnectedGames/InterconnectedGames_PasteGameID.png){: .center loading="lazy" }

### The Player TransferToGame(gameId) method

Only one line of code is required to move players to different games. Once you have a reference to a specific player, you can call ``TransferToGame``, with the **Game ID** as an argument. See the [Player section of the API reference](https://docs.coregames.com/core_api/#player) or [an example use with a trigger](https://docs.coregames.com/api/examples/#playertransfertogame).

## Creating Private Sub-Games

Creators can build networks of interconnected games where only one is actually public, and the rest are accessible from the main game. This main game would be a **parent**, and has the advantage of showing players as active in the parent game when they are in any of the child games.

### Publish a Parent Game

You will need a publicly published game before you can publish any children of a game. This is the same workflow as any normal publish, and you can find more specific instructions in the [Publishing Reference](../getting_started/publishing.md).

### Create a Child Game

Once you have a public game to use as a parent, any other game you publish can be marked as a child of that game.

![Select Child When Publishing](../img/InterconnectedGames/InterconnectedGames_ChildGame.png){: .center loading="lazy" }

1. In the upper right corner, click the **Publish** button.
2. In the drop-down menu next to the **Publish** button, select **Child**.
3. In the drop-down menu next to**Redirect to Parent** , select your parent game.
4. Leave the **Redirect to Parent** box checked if you want players who attempt to connect directly to this game to be sent to the parent game instead.
5. Click **Publish**.

!!! note
    This method establishes a relationship between your games, but does not automatically connect them. You can do that using the techniques in the **Jumping Between Games** section of this document.

## Shared Storage

To keep cohesion in the player's experience, you can use **Shared Storage Tables** to pass data between your published games. See the [Shared Storage](shared_storage.md) reference for more information.

---

## Learn More

[Player in Core API Reference](https://docs.coregames.com/core_api/#player) | [Player.TransferToGame Example](https://docs.coregames.com/api/examples/#playertransfertogame) | [Publishing Reference](../getting_started/publishing.md) | [Shared Storage](shared_storage.md)
