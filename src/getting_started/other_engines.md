---
id: other_engines
name: Coming to Core from Other Platforms
title: Coming to Core from Other Platforms
tags:
    - Reference
---

# Coming to Core from Other Platforms

## Overview

The purpose of this page is to get experienced game developers
To get a full overview of our API, read our [API Documentation](core_api.md) instead.

## Unity

> Imagine you have all Unity Asset Store assets for free in one place with built-in multiplayer networking.

### Assets and Content

In general, everything used to create games in Core comes originally from Core Content. You cannot import outside assets into Core, and instead build them from the objects that are part of Core.

#### Core Content

Core Content includes sounds, basic shape objects, visual props, objects with functionality (like weapons), materials that combine textures and shaders, and game components like health bars and spawn points, all customizable. Objects are all downloaded with the Core install, which makes editing and playing Core-created games very fast.

#### Community Content

Original props and scenes are made by modifying Core objects, and grouping them to be treated like a single object. Packages of these groups can be shared as **Templates**, allowing other Core Creators to use and customize them.

### Player Controller and Multiplayer

Core includes complete multiplayer functionality out of the box, included a player controller, camera, and networking.

#### Player

Project previewing can be done "in person" with a moving player in the scene right away.

Players can move with the <kbd>W</kbd>, <kbd>A</kbd>, <kbd>S</kbd>, and <kbd>D</kbd> keys, and change facing direction with the mouse. They can also crouch with <kbd>C</kbd>, jump with <kbd>W</kbd>, and ride a mount with <kbd>G</kbd>.

#### Multiplayer

Multiplayer networking is also included in all Core projects, as well as a **Multiplayer Preview Mode** which generates a specified number of instances of the game which can each be individually controlled.

<!-- ### Networking -->

### Exporting Games

Core is a complete platform that includes a Launcher to see and play Core-created games. There is no executable file download or exporting, but games can be published through the editor and shared with a URL. Core showcases published games and comes with a built-in audience.

### Scripting

Core scripting is done in the [Lua](lua_reference.md) language, which is does not specify data types, and is not object-oriented. This allows for considerable flexibility in designing and organizing code.

Scripts are objects themselves, not attached to objects. They have to be added to the project **Hierarchy** and networked, and all Lua scripts run when the project runs.

### Terminology

| **Category**  | **Unity**       | **Core**           |
| ------------- | --------------- | ------------------ |
| **Gameplay**  | GameObject      | CoreObject         |
|               | Prefabs         | Templates          |
| **Editor**    | Hierarchy Panel | Hierarchy          |
|               | Scene View      | Main Viewport      |
|               | Project Browser | Project Content    |
|               | Asset Store     | Shared Marketplace |
|               | Terrain Editor  | Terrain            |
|               | Console         | Event Log          |
|               | Inspector       | Properties         |
| **Scripting** | C#              | Lua                |

<!-- ## World of Warcraft

Ref: <https://www.townlong-yak.com/framexml/live/>

Instead of 5.1 as in WoW, Core uses Lua 5.3.4. There have not been that many changes in the language itself but do note that many of the additions Blizzard made will be missing here.

* Trigonometry functions: As with Blizzard's versions, Core's work with degrees. Lua's standard math library works with radians.
* Events:
  The most obvious change when coming from WoW, is the event system in Core. Instead of hooking your events up to your frames, you register functions onto the events of objects.

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
function Foo( arg_1, arg_2)
 -- do something
end

Events.Connect(“MyEvent”, Foo)
```

more details over in the [API Docs](core_api.md).

* The often (miss)used `OnUpdate` event equivalent is the global `Tick()` function. It is totally fine to overwrite it with your own.
* Instead of frames, you will mostly work with objects in Core. Those can be destroyed completely instead of just be hidden like frames in WoW.
* Core does have `print` but it prints to the Event Log instead of the chat frame. There is no `dump` for tables.
* Core does not include the `bitlib` library.

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
