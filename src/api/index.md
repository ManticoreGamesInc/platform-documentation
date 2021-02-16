---
id: api
name: Core API
title: Core API
tags:
    - API
    - Reference
---

# Lua Scripting API

## Overview

Core scripts are written in Lua, using version 5.3.6 of the [Lua library](https://www.lua.org/manual/5.3/). Scripts are objects created and added to the hierarchy and/or templates, similar to other object types. Scripts added to the hierarchy will execute as soon as the game loads, while scripts inside templates execute with each newly spawned instance of the template.

Properties, functions, and events inherited by [CoreObject](coreobject.md) types are listed below. Both properties and events are accessed with `.propertyName` and `.eventName`, while functions are accessed with `:FunctionName()`. Some types have class functions, which are accessed with `.FunctionName()`.

## Core Lua Types

At a high level, Core Lua types can be divided into two groups: Data structures and Objects. Data structures are owned by Lua, while Objects are owned by the engine and could be destroyed while still referenced by Lua. Objects all inherit from a single base type: Object. Data structures have no common parent. However, all data structures and Objects share a common `type` property, which is a string indicating its type. The value of the `type` property will match the section headings below, for example: `Ability`, `Vector2`, `CoreObject`, etc. All Core types also share an `IsA()` function. The `IsA()` function can be passed a type name, and will return `true` if the value is that type or one of its subtypes, or will return `false` if it is not. For example, `myObject:IsA("StaticMesh")`.

A lowercase type denotes a basic Lua type, such as `string` and `boolean`. You can learn more about Lua types from the official manual [here](https://www.lua.org/manual/5.3/manual.html#2.1). An uppercase type is a Core Type, such as `Player` and `CoreObject`.

|   |   |   |   |
|:-:|:-:|:-:|:-:|
| [Ability](ability.md) | [AbilityPhaseSettings](abilityphasesettings.md) | [AbilityTarget](abilitytarget.md) | [AnimatedMesh](animatedmesh.md) |
| [AreaLight](arealight.md) | [Audio](audio.md) | [Camera](camera.md) | [Color](color.md) |
| [CoreMesh](coremesh.md) | [CoreObject](coreobject.md) | [CoreObjectReference](coreobjectreference.md) | [Damage](damage.md) |
| [Decal](decal.md) | [Equipment](equipment.md) | [Event](event.md) | [EventListener](eventlistener.md) |
| [Folder](folder.md) | [HitResult](hitresult.md) | [Hook](hook.md) | [HookListener](hooklistener.md) |
| [ImpactData](impactdata.md) | [LeaderboardEntry](leaderboardentry.md) | [Light](light.md) | [MergedModel](mergedmodel.md) |
| [NetReference](netreference.md) | [NetworkContext](networkcontext.md) | [Object](object.md) | [Player](player.md) |
| [PlayerSettings](playersettings.md) | [PlayerStart](playerstart.md) | [PointLight](pointlight.md) | [Projectile](projectile.md) |
| [Quaternion](quaternion.md) | [RandomStream](randomstream.md) | [Rotation](rotation.md) | [Script](script.md) |
| [ScriptAsset](scriptasset.md) | [SmartAudio](smartaudio.md) | [SmartObject](smartobject.md) | [SpotLight](spotlight.md) |
| [StaticMesh](staticmesh.md) | [Task](task.md) | [Terrain](terrain.md) | [Transform](transform.md) |
| [Trigger](trigger.md) | [UIButton](uibutton.md) | [UIContainer](uicontainer.md) | [UIControl](uicontrol.md) |
| [UIImage](uiimage.md) | [UIPanel](uipanel.md) | [UIPerkPurchaseButton](uiperkpurchasebutton.md) | [UIProgressBar](uiprogressbar.md) |
| [UIScrollPanel](uiscrollpanel.md) | [UIText](uitext.md) | [Vector2](vector2.md) | [Vector3](vector3.md) |
| [Vector4](vector4.md) | [Vfx](vfx.md) | [Weapon](weapon.md) | [WorldText](worldtext.md) |

## Core Lua Namespaces

Some sets of related functionality are grouped within namespaces, which are similar to the types above, but cannot be instantiated. They are only ever accessed by calling functions within these namespaces.

|   |   |   |   |
|:-:|:-:|:-:|:-:|
| [CoreDebug](coredebug.md) | [CoreMath](coremath.md) | [CoreString](corestring.md) | [Environment](environment.md) |
| [Events](events.md) | [Game](game.md) | [Leaderboards](leaderboards.md) | [Storage](storage.md) |
| [Teams](teams.md) | [UI](ui.md) | [World](world.md) | |

## Built-In Lua Functions

For security reasons, various built-in Lua functions have been restricted or removed entirely. The available functions are listed below. Note that Lua's built-in trigonometric functions use radians, while other functions in Core uses degrees. See the [reference manual](https://www.lua.org/manual/5.3/manual.html#6) for more information on what they do.

!!! note "Built-In Lua Functions"
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
