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

### Assets and Content

> Imagine you have all Unity Asset Store assets for free in one place and you can use all of it to make multiplayer games!

#### Core Content

- You cannot import assets
- Core Content includes sounds, basic shape objects, developed props, complete game objects with functionality (like weapons), materials (textures), and they are all customizable
- Having objects that are pulled from [I do not know where] significantly decreases load time, so editing and playing Core-created games is lightning fast.

#### Community Content

- Scenes and props are made by "kitbashing"
- Templates: You can share things you make, and modify the creations of others

### Player Controller and Multiplayer

#### Player

- Full WASD movement
- Camera and Mouse control
- Jump, Crouch, Mount

#### Multiplayer

- Built-in
- Architecture for teams

### Networking

### Exporting Games

- Core is also the sharing platform
- No downloadable executables
- Rapid access for Core users, built-in audience

### Scripting

- Scripts are objects, not attached to objects. Must be added to the Heirarchy.
- Lua is dynamically typed and not object-oriented.

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

## Projects and Files

There is no way to import assets; everything is included in the asset manifest.

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
