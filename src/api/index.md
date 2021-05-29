---
id: api
name: Core API
title: Core API
hide:
    - toc
tags:
    - API
    - Reference
---

<style>
  .md-nav--primary .md-nav__link[for=__toc] ~ .md-nav {
    display: none;
  }
</style>

# Lua Scripting API

## Overview

Core scripts are written in Lua, using version 5.3.6 of the [Lua library](https://www.lua.org/manual/5.3/). Scripts are objects created and added to the hierarchy and/or templates, similar to other object types. Scripts added to the hierarchy will execute as soon as the game loads, while scripts inside templates execute with each newly spawned instance of the template.

Properties, functions, and events inherited by [CoreObject](coreobject.md) types are listed below. Both properties and events are accessed with `.propertyName` and `.eventName`, while functions are accessed with `:FunctionName()`. Some types have class functions, which are accessed with `.FunctionName()`.

## Core Lua Types

At a high level, Core Lua types can be divided into two groups: Data structures and Objects. Data structures are owned by Lua, while Objects are owned by the engine and could be destroyed while still referenced by Lua. Objects all inherit from a single base type: Object. Data structures have no common parent. However, all data structures and Objects share a common `type` property, which is a string indicating its type. The value of the `type` property will match the section headings below, for example: `Ability`, `Vector2`, `CoreObject`, etc. All Core types also share an `IsA()` function. The `IsA()` function can be passed a type name, and will return `true` if the value is that type or one of its subtypes, or will return `false` if it is not. For example, `myObject:IsA("StaticMesh")`.

A lowercase type denotes a basic Lua type, such as `string` and `boolean`. You can learn more about Lua types from the official manual [here](https://www.lua.org/manual/5.3/manual.html#2.1 "Lua Manual"). An uppercase type is a Core Type, such as `Player` and `CoreObject`.

|   |   |   |   |
|:-:|:-:|:-:|:-:|
| [AIActivity](../api/aiactivity.md) | [AIActivityHandler](../api/aiactivityhandler.md) | [Ability](../api/ability.md) | [AbilityPhaseSettings](../api/abilityphasesettings.md) |
| [AbilityTarget](../api/abilitytarget.md) | [AnimatedMesh](../api/animatedmesh.md) | [AreaLight](../api/arealight.md) | [Audio](../api/audio.md) |
| [Camera](../api/camera.md) | [Color](../api/color.md) | [CoreFriendCollection](../api/corefriendcollection.md) | [CoreFriendCollectionEntry](../api/corefriendcollectionentry.md) |
| [CoreGameCollectionEntry](../api/coregamecollectionentry.md) | [CoreGameInfo](../api/coregameinfo.md) | [CoreMesh](../api/coremesh.md) | [CoreObject](../api/coreobject.md) |
| [CoreObjectReference](../api/coreobjectreference.md) | [CorePlayerProfile](../api/coreplayerprofile.md) | [Damage](../api/damage.md) | [Decal](../api/decal.md) |
| [Equipment](../api/equipment.md) | [Event](../api/event.md) | [EventListener](../api/eventlistener.md) | [Folder](../api/folder.md) |
| [FourWheeledVehicle](../api/fourwheeledvehicle.md) | [HitResult](../api/hitresult.md) | [Hook](../api/hook.md) | [HookListener](../api/hooklistener.md) |
| [ImpactData](../api/impactdata.md) | [LeaderboardEntry](../api/leaderboardentry.md) | [Light](../api/light.md) | [MergedModel](../api/mergedmodel.md) |
| [NetReference](../api/netreference.md) | [NetworkContext](../api/networkcontext.md) | [Object](../api/object.md) | [Player](../api/player.md) |
| [PlayerSettings](../api/playersettings.md) | [PlayerStart](../api/playerstart.md) | [PlayerTransferData](../api/playertransferdata.md) | [PointLight](../api/pointlight.md) |
| [Projectile](../api/projectile.md) | [Quaternion](../api/quaternion.md) | [RandomStream](../api/randomstream.md) | [Rotation](../api/rotation.md) |
| [Script](../api/script.md) | [ScriptAsset](../api/scriptasset.md) | [SmartAudio](../api/smartaudio.md) | [SmartObject](../api/smartobject.md) |
| [SpotLight](../api/spotlight.md) | [StaticMesh](../api/staticmesh.md) | [Task](../api/task.md) | [Terrain](../api/terrain.md) |
| [Transform](../api/transform.md) | [TreadedVehicle](../api/treadedvehicle.md) | [Trigger](../api/trigger.md) | [UIButton](../api/uibutton.md) |
| [UIContainer](../api/uicontainer.md) | [UIControl](../api/uicontrol.md) | [UIImage](../api/uiimage.md) | [UIPanel](../api/uipanel.md) |
| [UIPerkPurchaseButton](../api/uiperkpurchasebutton.md) | [UIProgressBar](../api/uiprogressbar.md) | [UIScrollPanel](../api/uiscrollpanel.md) | [UIText](../api/uitext.md) |
| [Vector2](../api/vector2.md) | [Vector3](../api/vector3.md) | [Vector4](../api/vector4.md) | [Vehicle](../api/vehicle.md) |
| [Vfx](../api/vfx.md) | [Weapon](../api/weapon.md) | [WorldText](../api/worldtext.md) | |

## Core Lua Namespaces

Some sets of related functionality are grouped within namespaces, which are similar to the types above, but cannot be instantiated. They are only ever accessed by calling functions within these namespaces.

|   |   |   |   |
|:-:|:-:|:-:|:-:|
| [Chat](../api/chat.md) | [CoreDebug](../api/coredebug.md) | [CoreMath](../api/coremath.md) | [CorePlatform](../api/coreplatform.md) |
| [CoreSocial](../api/coresocial.md) | [CoreString](../api/corestring.md) | [Environment](../api/environment.md) | [Events](../api/events.md) |
| [Game](../api/game.md) | [Leaderboards](../api/leaderboards.md) | [Storage](../api/storage.md) | [Teams](../api/teams.md) |
| [UI](../api/ui.md) | [World](../api/world.md) | | |

## Built-In Lua Functions

For security reasons, various built-in Lua functions have been restricted or removed entirely. The available functions are listed below. Note that Lua's built-in trigonometric functions use radians, while other functions in Core uses degrees. See the [reference manual](https://www.lua.org/manual/5.3/manual.html#6) for more information on what they do.

??? note "Built-In Lua Functions"
    - `assert`
    - `collectgarbage` (modified to only accept a `count` parameter to get current Lua memory usage)
    - `error`
    - `getmetatable` (modified)
    - `ipairs`
    - `next`
    - `pairs`
    - `pcall`
    - `print` (modified so it goes to Unreal logs and the Event log)
    - `rawequal`
    - `rawget` (modified)
    - `rawset` (modified)
    - `require` (modified)
    - `select`
    - `setmetatable` (modified)
    - `tonumber`
    - `tostring`
    - `type`
    - `_G` (modified so it is separate from `_ENV`)
    - `_VERSION`
    - `xpcall`
    - `coroutine.create`
    - `coroutine.isyieldable`
    - `coroutine.resume`
    - `coroutine.running`
    - `coroutine.status`
    - `coroutine.wrap`
    - `coroutine.yield`
    - `math.abs`
    - `math.acos`
    - `math.asin`
    - `math.atan`
    - `math.ceil`
    - `math.cos`
    - `math.deg`
    - `math.exp`
    - `math.floor`
    - `math.fmod`
    - `math.huge`
    - `math.log`
    - `math.max`
    - `math.maxinteger`
    - `math.min`
    - `math.mininteger`
    - `math.modf`
    - `math.pi`
    - `math.rad`
    - `math.random`
    - `math.randomseed`
    - `math.sin`
    - `math.sqrt`
    - `math.tan`
    - `math.tointeger`
    - `math.type`
    - `math.ult`
    - `os.clock`
    - `os.date`
    - `os.difftime`
    - `os.time`
    - `string.byte`
    - `string.char`
    - `string.find`
    - `string.format`
    - `string.gmatch`
    - `string.gsub`
    - `string.len`
    - `string.lower`
    - `string.match`
    - `string.pack`
    - `string.packsize`
    - `string.rep`
    - `string.reverse`
    - `string.sub`
    - `string.unpack`
    - `string.upper`
    - `table.concat`
    - `table.insert`
    - `table.move`
    - `table.pack`
    - `table.remove`
    - `table.sort`
    - `table.unpack`
    - `utf8.char`
    - `utf8.charpattern`
    - `utf8.codes`
    - `utf8.codepoint`
    - `utf8.len`
    - `utf8.offset`

## MUIDs

MUIDs are internal identifiers for objects and assets within your game. They are guaranteed to be unique within the game and likely to be unique globally. You can copy a MUID to the clipboard automatically by right-clicking assets in Project Content or placed objects in the Hierarchy. The MUID will look something like this:

`8D4B561900000092:Rabbit`

The important part is the 16 digits at the start. The colon and everything after it are optional and are there to make it easier to read. Some Lua functions use MUIDs, for example `FindObjectById` and `SpawnAsset`. When used in a script, it needs to be surrounded by quotes to make it a string. For example:

```lua
local spawnTrans = script.parent:GetWorldTransform()
local anchor = World.FindObjectById('8D4B5619000000ED:Anchor')
World.SpawnAsset('8D4B561900000092:Rabbit', spawnTrans, anchor)
```
