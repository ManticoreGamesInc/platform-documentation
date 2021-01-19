---
id: unity
name: Coming to Core from Unity
title: Coming to Core from Unity
tags:
    - Reference
---

# Coming to Core from Unity

## Overview

The purpose of this page is to let experienced game developers get started using the unique features of the Core platform.

- For a general introduction to creating with Core, see [Intro to the Core Editor](editor_intro.md)
- For a complete technical overview, see the [Core API Documentation](../api/index.md).

## Unity

> Imagine starting a project with built-in multiplayer networking and a massive library of open source assets in a complete creation, publishing, and gameplay platform.

### Assets and Content

Everything used to create games in Core is made up of Core Content. While outside assets cannot be imported into Core, they can instead be built from a massive library of primitives, models, and materials.

#### Core Content

Core Content includes everything from basic shape objects to game components like health bars and spawn points, all customizable. Objects are all downloaded with Core on install, which makes for virtually instantaneous loading of Core games and assets.

#### Community Content

Original props and scenes are made by modifying Core objects, and grouping them to be treated like a single object. Packages of these groups can be shared as open-source **Templates**, similar to Unity prefabs.

### Player Controller

Core includes a player controller and third-person camera out of the box. Project previewing can be done "in person" with a moving player in the scene right away.

Players can move with the ++W++, ++A++, ++S++, and ++D++ keys, and change facing direction with the mouse. They can also crouch with ++C++, jump with ++Space++, and ride a mount with ++G++.

### Multiplayer

Multiplayer networking is also included in all Core projects, as well as a **Multiplayer Preview Mode** which generates up to four clients locally which can each be individually controlled for instant project testing.

Core players have persistent avatars that are used across Core games with customizable outfits, emotes, and mount choices that can be overwritten for individual game artistic choices.

### Networking

Core allows straight-forward networking through the Hierarchy with **Server Context** and **Client Context** folders, and one-click networking of objects through the interface.

It also includes free server hosting and analytics, automatically creating more server instances for player overflow.

### Exporting Games

Core is a complete platform that includes a Launcher to see and play Core-created games. There is no executable file download or exporting, but games can be [published](publishing.md) through the editor and shared with a URL. Core games can be found within the Core launcher, and outstanding work will be promoted.

### Scripting

Core scripting is written in the [Lua](scripting_intro.md) language, which does not specify data types, and is not inherently object-oriented. This allows for considerable flexibility in designing and organizing code.

Scripts can be added as children of objects, but they do not necessarily have to be associated any object, only networked and added to the project **Hierarchy**.

### Terminology

| **Category**  | **Unity**       | **Core**           |
| ------------- | --------------- | ------------------ |
| **Gameplay**  | GameObject      | CoreObject         |
|               | Prefabs         | Templates          |
| **Editor**    | Hierarchy Panel | Hierarchy          |
|               | Scene View      | Main Viewport      |
|               | Game View       | Preview Mode       |
|               | Project Browser | Project Content    |
|               | Asset Store     | Community Content (Open Source)|
|               | Generate Terrain| Terrain  Generator |
|               |                 |                    |
|               | Console         | Event Log          |
|               | Inspector       | Properties         |
| **Scripting** | C#              | Lua                |
