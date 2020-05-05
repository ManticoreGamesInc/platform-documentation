---
id: other_platforms
name: Coming to Core from Other Platforms
title: Coming to Core from Other Platforms
tags:
    - Reference
---

# Coming to Core from Other Platforms

## Overview

The purpose of this page is to let experienced game developers get started using the unique features of the Core platform.

- For a general introduction to creating with Core, see [Intro to the Core Editor](editor_intro.md)
- For a complete technical overview, see the [Core API Documentation](core_api.md).

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

Players can move with the <kbd>W</kbd>, <kbd>A</kbd>, <kbd>S</kbd>, and <kbd>D</kbd> keys, and change facing direction with the mouse. They can also crouch with <kbd>C</kbd>, jump with <kbd>W</kbd>, and ride a mount with <kbd>G</kbd>.

### Multiplayer

Multiplayer networking is also included in all Core projects, as well as a **Multiplayer Preview Mode** which generates up to four clients locally which can each be individually controlled for instant project testing.

Core players have persistent avatars that are used across Core games with customizable outfits, emotes, and mount choices that can be overwritten for individual game artistic choices.

### Networking

Core allows straight-forward networking through the Hierarchy with **Server Context** and **Client Context** folders, and one-click networking of objects through the interface.

It also includes free server hosting and analytics, automatically creating more server instances for player overflow.

### Exporting Games

Core is a complete platform that includes a Launcher to see and play Core-created games. There is no executable file download or exporting, but games can be [published](publishing.md) through the editor and shared with a URL. Core games can be found within the Core launcher, and outstanding work will be promoted.

### Scripting

Core scripting is written in the [Lua](lua_reference.md) language, which does not specify data types, and is not inherently object-oriented. This allows for considerable flexibility in designing and organizing code.

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

In general, scripts are created without parents, and have to be added into the project **Hierarchy**, equivalent ot the Explorer in Roblox. They can still be made children of objects to reference them, and it is also possible to define **Custom Property** variables that can be changed through the script's **Properties** window, rather than editing the script itself.

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
|               | Model           | 3D Object          |
|               | Package         | Template           |
|               | Explorer        | Hierarchy          |
|               | Scene           | Main Viewport      |
|               | Test            | Multiplayer Preview Mode |
|               | Market Place    | Community Content  |
|               | Terrain Editor  | Terrain Generator and Terrain Properties |
|               | Spawn Location  | Spawn Point        |
| **Scripting** | Output          | Event Log          |
|               | Server Script Service | Server Context|
|               | Lua (Roblox API)| Lua (Core API)     |

## World of Warcraft

Ref: <https://www.townlong-yak.com/framexml/live/>

Instead of 5.1 as in WoW, Core uses Lua 5.3.4. There have not been that many changes in the language itself but do note that many of the additions Blizzard made will be missing here.

- Trigonometry functions: As with Blizzard's versions, Core's work with degrees. Lua's standard math library works with radians.
- Events: The most obvious change when coming from WoW, is the event system in Core. Instead of hooking your events up to your frames, you register functions onto the events of objects.

As an example:

```lua
groupFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
groupFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
groupFrame:SetScript("OnEvent", function(self, event)
  GroupRosterUpdate()
end)
```

Would look something like this in Core:

```lua
groupFrame.GROUP_ROSTER_UPDATE:Connect(GroupRosterUpdate)
groupFrame.PLAYER_ENTERING_WORLD:Connect(GroupRosterUpdate)
```

Every object has a specific set of events available, but there are also custom events that you can fire via `Broadcast()` and register on the `Event` namespace:

```lua
local function Foo(arg_1, arg_2)
 -- do something
end

Events.Connect("MyEvent", Foo)
```

You can find more examples for events in our [Examples and Snippets](examples.md) section.

- The often (miss)used `OnUpdate` event equivalent is the global `Tick()` function. It is totally fine to overwrite it with your own.
- Instead of frames, you will mostly work with objects in Core. Those can be destroyed completely instead of just be hidden like frames in WoW.
- Core does have `print` but it prints to the Event Log instead of the chat frame. There is no `dump` for tables.
- Core does not include the `bitlib` library but since it is Lua 5.3 it has native support for [bitwise operators](http://lua-users.org/wiki/BitwiseOperators).

<!--
## Garry's Mod

Ref: <http://wiki.garrysmod.com/page/Beginner_Tutorial_Intro>

## Factorio

Ref: <https://www.factorio.com/modding>

## Roblox

Ref: <https://developer.roblox.com/api-reference>

## Dota2

Ref: <https://developer.valvesoftware.com/wiki/Dota_2_Workshop_Tools>

## Starbound

Ref: <https://starbounder.org/Modding:Lua> -->
