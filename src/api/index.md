---
id: api
name: Core API
title: Core API
tags:
    - Reference
---

# Lua Scripting API

## Overview

Core scripts are written in Lua, using version 5.3.4 of the [Lua library](.md)(<https://www.lua.org/manual/5.3/>). Scripts are objects created and added to the hierarchy and/or templates, similar to other object types. Scripts added to the hierarchy will execute as soon as the game loads, while scripts inside templates execute with each newly spawned instance of the template.

Properties, functions, and events inherited by [CoreObject](.md)(#coreobject) types are listed below. Both properties and events are accessed with `.propertyName` and `.eventName`, while functions are accessed with `:FunctionName()`. Some types have class functions, which are accessed with `.FunctionName()`.

## Core Lua Types

At a high level, Core Lua types can be divided into two groups: Data structures and Objects. Data structures are owned by Lua, while Objects are owned by the engine and could be destroyed while still referenced by Lua. Objects all inherit from a single base type: Object. Data structures have no common parent. However, all data structures and Objects share a common `type` property, which is a string indicating its type. The value of the `type` property will match the section headings below, for example: "Ability", "Vector2", "CoreObject", etc. All Core types also share an `IsA()` function. The `IsA()` function can be passed a type name, and will return `true` if the value is that type or one of its subtypes, or will return `false` if it is not. For example, `myObject:IsA("StaticMesh")`.

A lowercase type denotes a basic Lua type, such as `string` and `boolean`. You can learn more about Lua types from the official manual [here](.md)(<https://www.lua.org/manual/5.3/manual.html#2.1>). An uppercase type is a Core Type, such as `Player` and `CoreObject`.

### [Ability](ability.md)

Abilities are CoreObjects that can be added to Players and guide the Player's animation in sync with the Ability's state machine. Spawn an Ability with `World.SpawnAsset()` or add an Ability as a child of an Equipment/Weapon to have it be assigned to the Player automatically when that item is equipped.

Abilities can be activated by association with an Action Binding. Their internal state machine flows through the phases: Ready, Cast, Execute, Recovery and Cooldown. An Ability begins in the Ready state and transitions to Cast when its Binding (e.g. Left mouse click) is activated by the owning player. It then automatically flows from Cast to Execute, then Recovery and finally Cooldown. At each of these state transitions it fires a corresponding event.

Only one ability can be active at a time. By default, activating an ability will interrupt the currently active ability. The canBePrevented and preventsOtherAbilities properties can be used to customize interruption rules for competing abilities.

If an ability is interrupted during the Cast phase, it will immediately reset to the Ready state. If an ability is interrupted during the Execute or Recovery phase, the ability will immediately transition to the Cooldown phase.

### [AbilityPhaseSettings](abilityphasesettings.md)

Each phase of an Ability can be configured differently, allowing complex and different Abilities. AbilityPhaseSettings is an Object.

### [AbilityTarget](abilitytarget.md)

A data type containing information about what the Player has targeted during a phase of an Ability.

### [AnimatedMesh](animatedmesh.md)

AnimatedMesh objects are skeletal CoreMeshes with parameterized animations baked into them. They also have sockets exposed to which any CoreObject can be attached.

### [AreaLight](arealight.md)

AreaLight is a Light that emits light from a rectangular plane. It also has properties for configuring a set of "doors" attached to the plane which affect the lit area in front of the plane.

### [Audio](audio.md)

Audio is a CoreObject that wrap sound files. Most properties are exposed in the UI and can be set when placed in the editor, but some functionality (such as playback with fade in/out) requires Lua scripting.

### [Camera](camera.md)

Camera is a CoreObject which is used both to configure Player Camera settings as well as to represent the position and rotation of the Camera in the world. Cameras can be configured in various ways, usually following a specific Player's view, but can also have a fixed orientation and/or position.

Each Player (on their client) can have a default Camera and an override Camera. If they have neither, camera behavior falls back to a basic third-person behavior. Default Cameras should be used for main gameplay while override Cameras are generally employed as a temporary view, such as a when the Player is sitting in a mounted turret.

### [Color](color.md)

An RGBA representation of a color. Color components have an effective range of `[0.0, 1.0](.md)`, but values greater than 1 may be used.

### [CoreMesh](coremesh.md)

CoreMesh is a CoreObject representing a mesh that can be placed in the scene. It is the parent type for both AnimatedMesh and StaticMesh.

### [CoreObject](coreobject.md)

CoreObject is an Object placed in the scene hierarchy during edit mode or is part of a template. Usually they'll be a more specific type of CoreObject, but all CoreObjects have these properties and functions:

### [CoreObjectReference](coreobjectreference.md)

A reference to a CoreObject which may or may not exist. This type is returned by CoreObject:GetCustomProperty() for CoreObject Reference properties, and may be used to find the actual object if it exists.

In the case of networked objects it's possible to get a CoreObjectReference pointing to a CoreObject that hasn't been received on the client yet.

### [Damage](damage.md)

To damage a Player, you can simply write e.g.: `whichPlayer:ApplyDamage(Damage.New(10))`. Alternatively, create a Damage object and populate it with all the following properties to get full use out of the system:

### [Equipment](equipment.md)

Equipment is a CoreObject representing an equippable item for players. They generally have a visual component that attaches to the Player, but a visual component is not a requirement. Any Ability objects added as children of the Equipment are added/removed from the Player automatically as it becomes equipped/unequipped.

### [Event](event.md)

Events appear as properties on several objects. The goal is to register a function that will be fired whenever that event happens. E.g. `playerA.damagedEvent:Connect(OnPlayerDamaged)` chooses the function `OnPlayerDamaged` to be fired whenever `playerA` takes damage.

### [EventListener](eventlistener.md)

EventListeners are returned by Events when you connect a listener function to them.

### [Folder](folder.md)

Folder is a CoreObject representing a folder containing other objects.

They have no properties or functions of their own, but inherit everything from CoreObject.

### [HitResult](hitresult.md)

Contains data pertaining to an impact or raycast.

### [ImpactData](impactdata.md)

A data structure containing all information about a specific Weapon interaction, such as collision with a character.

### [LeaderboardEntry](leaderboardentry.md)

A data structure containing a player's entry on a leaderboard. See the `Leaderboards` API for information on how to retrieve or update a `LeaderboardEntry`.

### [Light](light.md)

Light is a light source that is a CoreObject. Generally a Light will be an instance of some subtype, such as PointLight or SpotLight.

### [MergedModel](mergedmodel.md)

MergedModel is a special Folder that combines CoreMesh descendants into a single mesh. Note that MergedModel is still a beta feature, and as such could change in the future.

### [NetReference](netreference.md)

A reference to a network resource, such as a player leaderboard. NetReferences are not created directly, but may be returned by `CoreObject:GetCustomProperty()`.

### [NetworkContext](networkcontext.md)

NetworkContext is a CoreObject representing a special folder containing client-only, server-only, or static objects.

They have no properties or functions of their own, but inherit everything from CoreObject.

### [Object](object.md)

At a high level, Core Lua types can be divided into two groups: data structures and Objects. Data structures are owned by Lua, while Objects are owned by the engine and could be destroyed while still referenced by Lua. Any such object will inherit from this type. These include CoreObject, Player and Projectile.

### [Other](other.md)

Other

### [Player](player.md)

Player is an Object representation of the state of a Player connected to the game, as well as their avatar in the world.

### [PlayerSettings](playersettings.md)

Settings that can be applied to a Player.

### [PlayerStart](playerstart.md)

PlayerStart is a CoreObject representing a spawn point for players.

### [PointLight](pointlight.md)

PointLight is a placeable light source that is a CoreObject.

### [Projectile](projectile.md)

Projectile is a specialized Object which moves through the air in a parabolic shape and impacts other objects. To spawn a Projectile, use `Projectile.Spawn()`.

### [Quaternion](quaternion.md)

A quaternion-based representation of a rotation.

### [RandomStream](randomstream.md)

Seed-based random stream of numbers. Useful for deterministic RNG problems, for instance, inside a Client Context so all players get the same outcome without the need to replicate lots of data from the server. Bad quality in the lower bits (avoid combining with modulus operations).

### [Rotation](rotation.md)

An euler-based rotation around `x`, `y`, and `z` axes.

### [Script](script.md)

### [ScriptAsset](scriptasset.md)

ScriptAsset is an Object representing a script asset in Project Content. When a script is executed from a call to `require()`, it can access the script asset using the `script` variable. This can be used to read custom properties from the script asset.

### [SmartAudio](smartaudio.md)

SmartAudio objects are SmartObjects that wrap sound files. Similar to Audio objects, they have many of the same properties and functions.

### [SmartObject](smartobject.md)

SmartObject is a top-level container for some complex objects and inherits everything from CoreObject. Note that some properties, such as `collision` or `visibility`, may not be respected by a SmartObject.

### [SpotLight](spotlight.md)

SpotLight is a Light that shines in a specific direction from the location at which it is placed.

### [StaticMesh](staticmesh.md)

StaticMesh is a static CoreMesh. StaticMeshes can be placed in the scene and (if networked or client-only) moved at runtime, but the mesh itself cannot be animated. See AnimatedMesh for meshes with animations.

### [Task](task.md)

Task is a representation of a Lua thread. It could be a Script initialization, a repeating `Tick()` function from a Script, an EventListener invocation, or a Task spawned directly by a call to `Task.Spawn()`.

### [Terrain](terrain.md)

Terrain is a CoreObject representing terrain placed in the world.

### [Transform](transform.md)

Transforms represent the position, rotation, and scale of objects in the game. They are immutable, but new Transforms can be created when you want to change an object's Transform.

### [Trigger](trigger.md)

A trigger is an invisible and non-colliding CoreObject which fires events when it interacts with another object (e.g. A Player walks into it):

### [UIButton](uibutton.md)

A UIControl for a button, should be inside client context.

### [UIContainer](uicontainer.md)

A UIContainer is a type of UIControl. All other UI elements must be a descendant of a UIContainer to be visible. It does not have a position or size. It is always the size of the entire screen.

It has no properties or functions of its own, but inherits everything from CoreObject.

### [UIControl](uicontrol.md)

UIControl is a CoreObject which serves as a base class for other UI controls.

### [UIImage](uiimage.md)

A UIControl for displaying an image.

### [UIPanel](uipanel.md)

### [UIPerkPurchaseButton](uiperkpurchasebutton.md)

A UIControl for a button which allows players to purchase perks within a game. Similar to `UIButton`, but designed to present a consistent purchasing experience for players across all games.

### [UIProgressBar](uiprogressbar.md)

A UIControl that displays a filled rectangle which can be used for things such as a health indicator.

### [UIScrollPanel](uiscrollpanel.md)

A UIControl that supports scrolling a child UIControl that is larger than itself.

They have no properties or functions of their own, but inherit everything from CoreObject and UIControl.

### [UIText](uitext.md)

A UIControl which displays a basic text label.

### [Vector2](vector2.md)

A two-component vector that can represent a position or direction.

### [Vector3](vector3.md)

A three-component vector that can represent a position or direction.

### [Vector4](vector4.md)

A four-component vector.

### [Vfx](vfx.md)

Vfx is a specialized type of SmartObject for visual effects. It inherits everything from SmartObject.

### [Weapon](weapon.md)

A Weapon is an Equipment that comes with built-in Abilities and fires Projectiles.

### [WorldText](worldtext.md)

WorldText is an in-world text CoreObject.

## Core Lua Namespaces

Some sets of related functionality are grouped within namespaces, which are similar to the types above, but cannot be instantiated. They are only ever accessed by calling functions within these namespaces.

### [CoreDebug](coredebug.md)

The CoreDebug namespace contains functions that may be useful for debugging.

### [CoreLuaFunctions](CoreLuaFunctions.md)

A few base functions provided by the platform.

### [CoreMath](coremath.md)

The CoreMath namespace contains a set of math functions.

### [CoreString](corestring.md)

The CoreString namespace contains a set of string utility functions.

### [Environment](environment.md)

The Environment namespace contains a set of functions for determining where a script is running. Some of these functions are paired together. For example, a script will return `true` for one of `Environment.IsServer()` or `Environment.IsClient()`, but never for both. Similarly, either `Environment.IsLocalGame()` or `Environment.IsHostedGame()` will return `true`, but not both.

### [Events](events.md)

User defined events can be specified using the Events namespace. The Events namespace uses the following class functions:

### [Game](game.md)

Game is a collection of functions and events related to players in the game, rounds of a game, and team scoring.

### [Leaderboards](leaderboards.md)

The Leaderboards namespace contains a set of functions for retrieving and updating player leaderboard data. Use the Global Leaderboards tab in the Core Editor to configure leaderboards for your game. Then drag a leaderboard from the Global Leaderboards tab to a `NetReference` custom property for use with the Leaderboards API.

### [Storage](storage.md)

The Storage namespace contains a set of functions for handling persistent storage of data. To use the Storage API, you must place a Game Settings object in your game and check the Enable Player Storage property on it.

Core storage allows a maximum of 16Kb (16384 bytes) of encoded data to be stored. Any data exceeding this limit is not guaranteed to be stored and can potentially cause loss of stored data. Exceeding the limit will cause a warning to be displayed in the event log when in preview mode. `Storage.SizeOfData()` can be used to check the size of data (in bytes) before assigning to storage. If size limit has been exceeded consider replacing strings with numbers or using advanced techniques such as bit packing to reduce the size of data stored.

### [Teams](teams.md)

The Teams namespace contains a set of class functions for dealing with teams and team settings.

### [UI](ui.md)

The UI namespace contains a set of class functions allowing you to get information about a Player's display and push information to their HUD. Most functions require the script to be inside a ClientContext and execute for the local Player.

### [World](world.md)

World is a collection of functions for finding objects in the world.

### Built-In Lua Functions

For security reasons, various built-in Lua functions have been restricted or removed entirely. The available functions are listed below. Note that Lua's built-in trigonometric functions use radians, while other functions in Core uses degrees. See the [reference manual](.md)(<https://www.lua.org/manual/5.3/manual.html#6>) for more information on what they do.

??? "Built-In Lua Functions"
    - `assert`
    - `collectgarbage (modified)`
    - `error`
    - `getmetatable (modified)`
    - `ipairs`
    - `next`
    - `pairs`
    - `pcall`
    - `print (modified)`
    - `rawequal`
    - `rawget (modified)`
    - `rawset (modified)`
    - `require (modified)`
    - `select`
    - `setmetatable (modified)`
    - `tonumber`
    - `tostring`
    - `type`
    - `_G (modified)`
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

### MUIDs

MUIDs are internal identifiers for objects and assets within your game. They are guaranteed to be unique within the game and likely to be unique globally. You can copy a MUID to the clipboard automatically by right-clicking assets in Project Content or placed objects in the Hierarchy. The MUID will look something like this:

8D4B561900000092:Rabbit

The important part is the 16 digits at the start. The colon and everything after it are optional and are there to make it easier to read. Some Lua functions use MUIDs, for example `FindObjectById` and `SpawnAsset`. When used in a script, it needs to be surrounded by quotes to make it a string. For example:

```lua
local spawnTrans = script.parent:GetWorldTransform()
local anchor = World.FindObjectById('8D4B5619000000ED:Anchor')
World.SpawnAsset('8D4B561900000092:Rabbit', spawnTrans, anchor)
```
