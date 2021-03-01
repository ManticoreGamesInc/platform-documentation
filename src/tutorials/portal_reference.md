---
id: portal_reference
name: Portal Reference
title: Portal Reference
tags:
    - Reference
---

# Portals

The design of Core allows for fast travel between any Core game, allowing players to jump through the Metaverse! Portals allow players to connect interconnected games, as well as build hubs for their own game portfolios, or to build a social space that connects to the Core Game queues, like Active and Featured.

## Creating Portals to Other Games

### Add a Portal to the Game

The **Game Portal** template can be added to any game to build a portal to another one.

1. Search for the **Game Portal** template in **Core Content**
2. Click and drag the **Game Portal** template to the project.
3. With the Game Portal selected, open the **Properties** window.
4. Add the Game's ID to the **Game ID** property.

### Find a GameID

Core Game ID's can be found in the URL for the Core Game page.

1. Find the game's page on **CoreGames.com** through search and copy its URL.
   - To get the URL directly from the Core Client, open the game page, and copy the URL via the **Share** button.
2. Delete `https://www.coregames.com/games/` from the URL to leave only the Game ID.

!!! info
    Game ID's are a 6-character string, plus the hyphenated name of the game like **b983bc/core-plaza**.

### Get Info for a Game

With a Game ID, you get more information about a game through a [**CoreGameInfo**](../api/coregameinfo.md) object, like the name of the game, or the creator. See the [**CorePlatform**](../api/coreplatform.md) namespace in the Core Lua API Reference for more information.

<!-- ## Screenshots -->
<!-- TODO: No clear object for screenshots or reference to one in Patch Notes -->

## World Capture

**World Capture** allows creators to take an image from the camera's current position of a game to allow Portals to show a glimpse into the world from other projects. This **World Capture** creates a cube map that can be populated by anyone one creating a portal to the game, including when the game shows up in any of the queues in **Home World**.

!!! hint
    Making sure all your games have cubemaps can set them apart in **Home World** and in any hub that uses Portals.

### Use World Capture to Make a Game Cubemap

1. Position your Editor camera to show your game the way you would want it to appear through a portal.
2. In the upper right corner of the Core Editor, press the button labeled **World Capture**.

### Find Existing Cubemaps

Cubemaps that you take using **World Capture** will appear in your project's **Screenshots** folder, in a subfolder called **Cubemaps**.

1. With the project open in the Core Editor, click **File** in the top menu bar and select **Show Project in Explorer**.
2. In the File Explorer, click the **Screenshots** folder to open it.
3. Click **Cubemaps** to see your Cubemap files.

## Game Categories

Creators have access to the Core Game queues, like **Featured**, **Active**, and **Trending**. They can be accessed through scripts using the [**CorePlatform**](../api/coreplatform.md) namespace, which returns a table of [**CoreGameCollectionEntry**](../api/coregamecollectionentry.md) objects.

---

## Learn More

[**Player** TransferToGame](../api/player.md) | [**CorePlatform** Namespace](../api/coreplatform.md) | [**CoreGameInfo**](../api/coregameinfo.md) | [**CoreGameCollectionEntry**](../api/coregamecollectionentry.md)
