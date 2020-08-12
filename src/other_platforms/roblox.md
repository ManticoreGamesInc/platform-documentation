---
id: roblox
name: Coming to Core from Roblox
title: Coming to Core from Roblox
tags:
    - Reference
---

# Coming to Core from Roblox

## Overview

The purpose of this page is to let experienced game developers get started using the unique features of the Core platform.

- For a general introduction to creating with Core, see [Intro to the Core Editor](editor_intro.md)
- For a complete technical overview, see the [Core API Documentation](core_api.md).

## Roblox

> Harness the beauty and power of Unreal engine to build the games that you want to play on a platform that elevates quality content and community collaboration.

### Multiplayer Out of the Box

Like Roblox, Core includes multiplayer networking built in, hosted by Manticore servers, and players have persistent avatars that they can customize and use across games. Players have similar controls out of the box, including emotes, which can be customized in the game.

### Navigating the Editor

Editor controls are very similar to Roblox, and most keyboard shortcuts are the same between the platforms. One difference, however, is that objects are generally added by clicking and dragging into the **Main Viewport**, the equivalent of the Project Workspace or Scene.

### Collaboration

Game files are stored locally on your machine, usually under ``Documents/My Games/Core/Saved/Maps``. This means that you can use conventional version control, like git, and Core files are small enough to also be shared through cloud drives.

Published Core games can also be marked as editable, allowing others to customize and modify them, and many successful Core Games are available to use as starting points.

A culture of collaboration is part of the Core Community, and is a powerful tool for creators who want to produce quality, professional games quickly.

### Scripting

Core also uses the Lua scripting language, which is extremely flexible, and connects to a similar event system. However, the Core API is distinct from the Roblox API, and so similar functions have different names, and will work differently. You can check out the [Core API](core_api.md) for more details and example code.

In general, scripts are created without parents, and have to be added into the project **Hierarchy**, equivalent of the Explorer in Roblox. They can still be made children of objects to reference them, and it is also possible to define **Custom Property** variables that can be changed through the script's **Properties** window, rather than editing the script itself. Unlike Roblox, when you duplicate a script in Core, it does not create a copy of the script asset, instead it creates a new instance that still points to the original script.

#### Server and Client

Core has a similar distinction between server and client scripts, and they have similar jobs. In Core these are called **Contexts**, and any object can be moved into a different context through the **Hierarchy**.

### Meshes and Models

Models in Core are not stored on servers, but are actually part of the local installation of the Core Launcher and Editor. What this means is that all the game assets, models, and audio, are built out of the pieces that come with Core by kitbashing, and you cannot import them from outside sources.

Assets made by kitbashing can be packaged, with or without scripted functionality, as **templates**. These can be published privately to easily pass between your own projects, or publicly to allow other developers to use them.

These shared templates are available in **Community Content**, and showcase creators pushing the boundaries of what is possible in Core.

### Materials

Core includes a wide variety of materials for different situations, which can be customized in many different ways, from the direction they are applied to tiling in each direction, color tint, and various other parameters specific to each material.

They also have **Smart Materials** which applies a material uniformly based on the position on the map, allowing you to create seamless transitions between different pieces.

### Core is in Alpha

Core is still in Open Alpha, which means there are a number of features that are yet to come, like monetization and cross-platform support. As an Open Alpha Creator, you are in a position to build some of the first ground-breaking games in Core and to influence its direction through feedback and creation.

### Terminology

| **Category**  | **Roblox**      | **Core**           |
| ------------- | --------------- | ------------------ |
| **Editor**    |                 |                    |
|               | Part            | Basic Shape        |
|               | Model           | Group              |
|               | Package         | Template           |
|               | Explorer        | Hierarchy          |
|               | Scene           | Main Viewport      |
|               | Test            | Multiplayer Preview Mode |
|               | Toolbox         | Community Content |
|               | ReplicatedStorage/ServerStorage | Project Content  | 
|               | Terrain Editor  | Terrain Generator and Terrain Properties |
|               | Spawn Location  | Spawn Point        |
|               | Output          | Event Log          |
| **Scripting** |                 |                    |
|               | ServerScriptService | Server Context |
|               | StarterPlayer   | Client Context |
|               | Roblox Lua      | Core Lua           |
|               | `Instance.new()` | `World.SpawnAsset()` |
