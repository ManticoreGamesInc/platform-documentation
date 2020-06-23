---
id: api
name: Core API
title: Core API
---

# Lua Scripting API

## Overview

Core scripts are written in Lua, using version 5.3.4 of the [Lua library](https://www.lua.org/manual/5.3/). Scripts are objects created and added to the hierarchy and/or templates, similar to other object types. Scripts added to the hierarchy will execute as soon as the game loads, while scripts inside templates execute with each newly spawned instance of the template.

Properties, functions, and events inherited by [CoreObject](#coreobject) types are listed below. Both properties and events are accessed with `.propertyName` and `.eventName`, while functions are accessed with `:FunctionName()`. Some types have class functions, which are accessed with `.FunctionName()`.

## Core Lua Types

At a high level, Core Lua types can be divided into two groups: Data structures and Objects. Data structures are owned by Lua, while Objects are owned by the engine and could be destroyed while still referenced by Lua. Objects all inherit from a single base type: Object. Data structures have no common parent. However, all data structures and Objects share a common `type` property, which is a string indicating its type. The value of the `type` property will match the section headings below, for example: "Ability", "Vector2", "CoreObject", etc. All Core types also share an `IsA()` function. The `IsA()` function can be passed a type name, and will return `true` if the value is that type or one of its subtypes, or will return `false` if it is not. For example, `myObject:IsA("StaticMesh")`.

A lowercase type denotes a basic Lua type, such as `string` and `boolean`. You can learn more about Lua types from the official manual [here](https://www.lua.org/manual/2.2/section3_3.html). An uppercase type is a Core Type, such as `Player` and `CoreObject`.

### Ability

Abilities are CoreObjects that can be added to Players and guide the Player's animation in sync with the Ability's state machine. Spawn an Ability with `World.SpawnAsset()` or add an Ability as a child of an Equipment/Weapon to have it be assigned to the Player automatically when that item is equipped.

Abilities can be activated by association with an Action Binding. Their internal state machine flows through the phases: Ready, Cast, Execute, Recovery and Cooldown. An Ability begins in the Ready state and transitions to Cast when its Binding (e.g. Left mouse click) is activated by the owning player. It then automatically flows from Cast to Execute, then Recovery and finally Cooldown. At each of these state transitions it fires a corresponding event.

Only one ability can be active at a time. By default, activating an ability will interrupt the currently active ability. The canBePrevented and preventsOtherAbilities properties can be used to customize interruption rules for competing abilities.

If an ability is interrupted during the Cast phase, it will immediately reset to the Ready state. If an ability is interrupted during the Execute or Recovery phase, the ability will immediately transition to the Cooldown phase.

| Event | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `readyEvent` | Event&lt;Ability&gt; | Fired when the Ability becomes ready. In this phase it is possible to activate it again. [:fontawesome-solid-info-circle:](../api/examples/#abilityreadyevent "Ability: readyEvent Example") | None |
| `castEvent` | Event&lt;Ability&gt; | Fired when the Ability enters the Cast phase. [:fontawesome-solid-info-circle:](../api/examples/#abilitycastevent "Ability: castEvent Example") | None |
| `executeEvent` | Event&lt;Ability&gt; | Fired when the Ability enters Execute phase. [:fontawesome-solid-info-circle:](../api/examples/#abilityexecuteevent "Ability: executeEvent Example") | None |
| `recoveryEvent` | Event&lt;Ability&gt; | Fired when the Ability enters Recovery. [:fontawesome-solid-info-circle:](../api/examples/#abilityrecoveryevent "Ability: recoveryEvent Example") | None |
| `cooldownEvent` | Event&lt;Ability&gt; | Fired when the Ability enters Cooldown. [:fontawesome-solid-info-circle:](../api/examples/#abilitycooldownevent "Ability: cooldownEvent Example") | None |
| `interruptedEvent` | Event&lt;Ability&gt; | Fired when the Ability is interrupted. [:fontawesome-solid-info-circle:](../api/examples/#abilityinterruptedevent "Ability: interruptedEvent Example") | None |
| `tickEvent` | Event&lt;Ability, Number deltaTime&gt; | Fired every tick while the Ability is active (isEnabled = true and phase is not ready). [:fontawesome-solid-info-circle:](../api/examples/#abilitytickevent "Ability: tickEvent Example") | None |

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Activate()` | None | Activates an Ability as if the button had been pressed. [:fontawesome-solid-info-circle:](../api/examples/#abilityactivate "Ability: Activate Example") | Client-Only |
| `Interrupt()` | None | Changes an Ability from Cast phase to Ready phase. If the Ability is in either Execute or Recovery phases it instead goes to Cooldown phase. [:fontawesome-solid-info-circle:](../api/examples/#abilityinterrupt "Ability: Interrupt Example") | None |
| `GetCurrentPhase()` | AbilityPhase | The current AbilityPhase for this Ability. These are returned as one of: AbilityPhase.READY, AbilityPhase.CAST, AbilityPhase.EXECUTE, AbilityPhase.RECOVERY and AbilityPhase.COOLDOWN. [:fontawesome-solid-info-circle:](../api/examples/#abilitygetcurrentphase "Ability: GetCurrentPhase Example") | None |
| `GetPhaseTimeRemaining()` | Number | Seconds left in the current phase. [:fontawesome-solid-info-circle:](../api/examples/#abilitygetphasetimeremaining "Ability: GetPhaseTimeRemaining Example") | None |
| `GetTargetData()` | AbilityTarget | Returns information about what the Player has targeted this phase. [:fontawesome-solid-info-circle:](../api/examples/#abilitygettargetdata "Ability: GetTargetData Example") | None |
| `SetTargetData(AbilityTarget)` | None | Updates information about what the Player has targeted this phase. This can affect the execution of the Ability. [:fontawesome-solid-info-circle:](../api/examples/#abilitysettargetdata "Ability: SetTargetData Example") | None |

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `isEnabled` | bool | Turns an Ability on/off. It stays on the Player but is interrupted if `isEnabled` is set to `false` during an active Ability. True by default. [:fontawesome-solid-info-circle:](../api/examples/#abilityisenabled "Ability: isEnabled Example") | Read-Write |
| `canActivateWhileDead` | bool | Indicates if the Ability can be used while the owning Player is dead. False by default. [:fontawesome-solid-info-circle:](../api/examples/#abilitycanactivatewhiledead "Ability: canActivateWhileDead Example") | Read-Only |
| `name` | string | The name of the Ability. [:fontawesome-solid-info-circle:](../api/examples/#abilityname "Ability: name Example") | Read-Only |
| `actionBinding` | string | Which action binding will cause the Ability to activate. Possible values of the bindings are listed on the [Ability binding](api/ability_bindings.md) page. [:fontawesome-solid-info-circle:](../api/examples/#abilityactionbinding "Ability: actionBinding Example") | Read-Only |
| `owner` | Player | Assigning an owner applies the Ability to that Player. [:fontawesome-solid-info-circle:](../api/examples/#abilityowner "Ability: owner Example") | Read-Write |
| `castPhaseSettings` | AbilityPhaseSettings | Config data for the Cast phase (see below). [:fontawesome-solid-info-circle:](../api/examples/#abilitycastphasesettings "Ability: castPhaseSettings Example") | Read-Only |
| `executePhaseSettings` | AbilityPhaseSettings | Config data for the Execute phase. [:fontawesome-solid-info-circle:](../api/examples/#abilityexecutephasesettings "Ability: executePhaseSettings Example") | Read-Only |
| `recoveryPhaseSettings` | AbilityPhaseSettings | Config data for the Recovery phase. [:fontawesome-solid-info-circle:](../api/examples/#abilityrecoveryphasesettings "Ability: recoveryPhaseSettings Example") | Read-Only |
| `cooldownPhaseSettings` | AbilityPhaseSettings | Config data for the Cooldown phase. [:fontawesome-solid-info-circle:](../api/examples/#abilitycooldownphasesettings "Ability: cooldownPhaseSettings Example") | Read-Only |
| `animation` | string | Name of the animation the Player will play when the Ability is activated. Possible values: See [Ability Animation](api/animations.md) for strings and other info. [:fontawesome-solid-info-circle:](../api/examples/#abilityanimation "Ability: animation Example") | Read-Only |
| `canBePrevented` | bool | Used in conjunction with the phase property `preventsOtherAbilities` so multiple abilities on the same Player can block each other during specific phases. True by default. [:fontawesome-solid-info-circle:](../api/examples/#abilitycanbeprevented "Ability: canBePrevented Example") | Read-Only |

### AbilityPhaseSettings

Each phase of an Ability can be configured differently, allowing complex and different Abilities. AbilityPhaseSettings is an Object.

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `duration` | Number | Length in seconds of the phase. After this time the Ability moves to the next phase. Can be zero. Default values per phase: 0.15, 0, 0.5 and 3. | Read-Only |
| `canMove` | bool | Is the Player allowed to move during this phase. True by default. | Read-Only |
| `canJump` | bool | Is the Player allowed to jump during this phase. False by default in Cast & Execute, default True in Recovery & Cooldown. | Read-Only |
| `canRotate` | bool | Is the Player allowed to rotate during this phase. True by default. | Read-Only |
| `preventsOtherAbilities` | bool | When true this phase prevents the Player from casting another Ability, unless that other Ability has canBePrevented set to False. True by default in Cast & Execute, false in Recovery & Cooldown. | Read-Only |
| `isTargetDataUpdated` | bool | If `true`, there will be updated target information at the start of the phase. Otherwise, target information may be out of date. | Read-Only |
| `facingMode` | AbilityFacingMode | How and if this Ability rotates the Player during execution. Cast and Execute default to "Aim", other phases default to "None". Options are: AbilityFacingMode.NONE, AbilityFacingMode.MOVEMENT, AbilityFacingMode.AIM | Read-Only |

### AbilityTarget

A data type containing information about what the Player has targeted during a phase of an Ability.

| Constructor | Return Type | Description | Tags |
| ----------- | ----------- | ----------- | ---- |
| `AbilityTarget.New()` | AbilityTarget | Constructs a new Ability Target data object. [:fontawesome-solid-info-circle:](../api/examples/#abilitytargetnew "Abilitytarget: New Example") | None |

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetOwnerMovementRotation()` | Rotation | Gets the direction the Player is moving. | None |
| `SetOwnerMovementRotation(Rotation)` | None | Sets the direction the Player faces, if `Ability.facingMode` is set to `AbilityFacingMode.MOVEMENT`. | None |
| `GetAimPosition()` | Vector3 | Returns the world space position of the camera. [:fontawesome-solid-info-circle:](../api/examples/#abilitytargetgetaimposition "Abilitytarget: GetAimPosition Example") | None |
| `SetAimPosition(Vector3)` | None | The world space location of the camera. Setting this currently has no effect on the Player's camera. | None |
| `GetAimDirection()` | Vector3 | Returns the direction the camera is facing. [:fontawesome-solid-info-circle:](../api/examples/#abilitytargetgetaimdirection "Abilitytarget: GetAimDirection Example") | None |
| `SetAimDirection(Vector3)` | None | Sets the direction the camera is facing. | None |
| `GetHitPosition()` | Vector3 | Returns the world space position of the object under the Player's reticle. If there is no object, a position under the reticle in the distance. If the Player doesn't have a reticle displayed, uses the center of the screen as if there was a reticle there. [:fontawesome-solid-info-circle:](../api/examples/#abilitytargetgethitposition "Abilitytarget: GetHitPosition Example") | None |
| `SetHitPosition(Vector3)` | None | Sets the hit position property. This may affect weapon behavior. [:fontawesome-solid-info-circle:](../api/examples/#abilitytargetsethitposition "Abilitytarget: SetHitPosition Example") | None |
| `GetHitResult()` | HitResult | Returns physics information about the point being targeted [:fontawesome-solid-info-circle:](../api/examples/#abilitytargetgethitresult "Abilitytarget: GetHitResult Example") | None |
| `SetHitResult(HitResult)` | None | Sets the hit result property. Setting this value has no affect on the Ability. | None |

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `hitObject` | Object | Object under the reticle, or center of the screen if no reticle is displayed. Can be a Player, StaticMesh, etc. [:fontawesome-solid-info-circle:](../api/examples/#abilitytargethitobject "Abilitytarget: hitObject Example") | Read-Write |
| `hitPlayer` | Player | Convenience property that is the same as hitObject, but only if hitObject is a Player. [:fontawesome-solid-info-circle:](../api/examples/#abilitytargethitplayer "Abilitytarget: hitPlayer Example") | Read-Write |
| `spreadHalfAngle` | Number | Half-angle of cone of possible target space, in degrees. | Read-Write |
| `spreadRandomSeed` | Integer | Seed that can be used with RandomStream for deterministic RNG. | Read-Write |

### AnimatedMesh

AnimatedMesh objects are skeletal CoreMeshes with parameterized animations baked into them. They also have sockets exposed to which any CoreObject can be attached.

| Event | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `animationEvent` | Event&lt;AnimatedMesh, string&gt; | Some animations have events specified at important points of the animation (e.g. the impact point in a punch animation). This event is fired with the animated mesh that triggered it and the name of the event at those points. [:fontawesome-solid-info-circle:](../api/examples/#animatedmeshanimationevent "Animatedmesh: animationEvent Example") | Client-Only |

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetAnimationNames()` | Array&lt;string&gt; | Returns an array of all available animations on this object. [:fontawesome-solid-info-circle:](../api/examples/#animatedmeshgetanimationnames "Animatedmesh: GetAnimationNames Example") | None |
| `GetAnimationStanceNames()` | Array&lt;string&gt; | Returns an array of all available animation stances on this object. [:fontawesome-solid-info-circle:](../api/examples/#animatedmeshgetanimationstancenames "Animatedmesh: GetAnimationStanceNames Example") | None |
| `GetSocketNames()` | Array&lt;string&gt; | Returns an array of all available sockets on this object. [:fontawesome-solid-info-circle:](../api/examples/#animatedmeshgetsocketnames "Animatedmesh: GetSocketNames Example") | None |
| `GetAnimationEventNames(string animationName)` | Array&lt;string&gt; | Returns an array of available animation event names for the specified animation. Raises an error if `animationName` is not a valid animation on this mesh. [:fontawesome-solid-info-circle:](../api/examples/#animatedmeshgetanimationeventnames "Animatedmesh: GetAnimationEventNames Example") | None |
| `AttachCoreObject(CoreObject objectToAttach, string socketName)` | None | Attaches the specified object to the specified socket on the mesh if they exist. [:fontawesome-solid-info-circle:](../api/examples/#animatedmeshattachcoreobject "Animatedmesh: AttachCoreObject Example") | Client-Only |
| `PlayAnimation(string animationName, [table parameters])` | None | Plays an animation on the animated mesh.<br /> Optional parameters can be provided to control the animation playback: `playbackRate (Number)`: Controls how fast the animation plays; `shouldLoop (bool)`: If `true`, the animation will keep playing in a loop. If `false` the animation will stop playing once completed. [:fontawesome-solid-info-circle:](../api/examples/#animatedmeshplayanimation "Animatedmesh: PlayAnimation Example") | Client-Only |
| `StopAnimations()` | None | Stops all in-progress animations played via `PlayAnimation` on this object. [:fontawesome-solid-info-circle:](../api/examples/#animatedmeshstopanimations "Animatedmesh: StopAnimations Example") | Client-Only |
| `GetAnimationDuration(string animationName)` | Number | Returns the duration of the animation in seconds. Raises an error if `animationName` is not a valid animation on this mesh. [:fontawesome-solid-info-circle:](../api/examples/#animatedmeshgetanimationduration "Animatedmesh: GetAnimationDuration Example") | None |

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `animationStance` | string | The stance the animated mesh plays. [:fontawesome-solid-info-circle:](../api/examples/#animatedmeshanimationstance "Animatedmesh: animationStance Example") | Client-Only, Read-Write |
| `animationStancePlaybackRate` | Number | The playback rate for the animation stance being played. Negative values will play the animation in reverse. [:fontawesome-solid-info-circle:](../api/examples/#animatedmeshanimationstanceplaybackrate "Animatedmesh: animationStancePlaybackRate Example") | Client-Only, Read-Write |
| `animationStanceShouldLoop` | bool | If `true`, the animation stance will keep playing in a loop. If `false` the animation will stop playing once completed. [:fontawesome-solid-info-circle:](../api/examples/#animatedmeshanimationstanceshouldloop "Animatedmesh: animationStanceShouldLoop Example") | Client-Only, Read-Write |
| `playbackRateMultiplier` | Number | Rate multiplier for all animations played on the animated mesh. Setting this to `0` will stop all animations on the mesh. [:fontawesome-solid-info-circle:](../api/examples/#animatedmeshplaybackratemultiplier "Animatedmesh: playbackRateMultiplier Example") | Client-Only, Read-Write |

### AreaLight

AreaLight is a Light that emits light from a rectangular plane. It also has properties for configuring a set of "doors" attached to the plane which affect the lit area in front of the plane.

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `sourceWidth` | Number | The width of the plane from which light is emitted. Must be greater than 0. | Read-Write, Dynamic |
| `sourceHeight` | Number | The height of the plane from which light is emitted. Must be greater than 0. | Read-Write, Dynamic |
| `barnDoorAngle` | Number | The angle of the barn doors, in degrees. Valid values are in the range from 0 to 90. Has no effect if barnDoorLength is 0. | Read-Write, Dynamic |
| `barnDoorLength` | Number | The length of the barn doors. Must be non-negative. | Read-Write, Dynamic |

### Audio

Audio is a CoreObject that wrap sound files. Most properties are exposed in the UI and can be set when placed in the editor, but some functionality (such as playback with fade in/out) requires Lua scripting.

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Play()` | None | Begins sound playback. | Dynamic |
| `Stop()` | None | Stops sound playback. | Dynamic |
| `FadeIn(Number time)` | None | Starts playing and fades in the sound over the given time. | Dynamic |
| `FadeOut(Number time)` | None | Fades the sound out and stops over time seconds. | Dynamic |

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `isPlaying` | bool | Returns if the sound is currently playing. | Read-Only |
| `length` | Number | Returns the length (in seconds) of the Sound. | Read-Only |
| `currentPlaybackTime` | Number | Returns the playback position (in seconds) of the sound. | Read-Only |
| `isSpatializationEnabled` | bool | Default true. Set to false to play sound without 3D positioning. | Read-Write, Dynamic |
| `isAttenuationEnabled` | bool | Default true, meaning sounds will fade with distance. | Read-Write, Dynamic |
| `isOcclusionEnabled` | bool | Default true. Changes attenuation if there is geometry between the player and the audio source. | Read-Write, Dynamic |
| `isAutoPlayEnabled` | bool | Default false. If set to true when placed in the editor (or included in a template), the sound will be automatically played when loaded. | Read-Only |
| `isTransient` | bool | Default false. If set to true, the sound will automatically destroy itself after it finishes playing. | Read-Write, Dynamic |
| `isAutoRepeatEnabled` | bool | Loops when playback has finished. Some sounds are designed to automatically loop, this flag will force others that don't. Useful for looping music. | Read-Write, Dynamic |
| `pitch` | Number | Default 1. Multiplies the playback pitch of a sound. Note that some sounds have clamped pitch ranges (0.2 to 1). | Read-Write, Dynamic |
| `volume` | Number | Default 1. Multiplies the playback volume of a sound. Note that values above 1 can distort sound, so if you're trying to balance sounds, experiment to see if scaling down works better than scaling up. | Read-Write, Dynamic |
| `radius` | Number | Default 0. If non-zero, will override default 3D spatial parameters of the sound. Radius is the distance away from the sound position that will be played at 100% volume. | Read-Write, Dynamic |
| `falloff` | Number | Default 0. If non-zero, will override default 3D spatial parameters of the sound. Falloff is the distance outside the radius over which the sound volume will gradually fall to zero. | Read-Write, Dynamic |
| `fadeInTime` | Number | Sets the fade in time for the audio.  When the audio is played, it will start at zero volume, and fade in over this many seconds. | Read-Write, Dynamic |
| `fadeOutTime` | Number | Sets the fadeout time of the audio.  When the audio is stopped, it will keep playing for this many seconds, as it fades out. | Read-Write, Dynamic |
| `startTime` | Number | The start time of the audio track. Default is 0. Setting this to anything else means that the audio will skip ahead that many seconds when played. | Read-Write, Dynamic |

### Camera

Camera is a CoreObject which is used both to configure Player Camera settings as well as to represent the position and rotation of the Camera in the world. Cameras can be configured in various ways, usually following a specific Player's view, but can also have a fixed orientation and/or position.

Each Player (on their client) can have a default Camera and an override Camera. If they have neither, camera behavior falls back to a basic third-person behavior. Default Cameras should be used for main gameplay while override Cameras are generally employed as a temporary view, such as a when the Player is sitting in a mounted turret.

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetPositionOffset()` | Vector3 | An offset added to the camera or follow target's eye position to the Player's view. [:fontawesome-solid-info-circle:](../api/examples/#cameragetpositionoffset "Camera: GetPositionOffset Example") | None |
| `SetPositionOffset(Vector3)` | None | An offset added to the camera or follow target's eye position to the Player's view. [:fontawesome-solid-info-circle:](../api/examples/#camerasetpositionoffset "Camera: SetPositionOffset Example") | Dynamic |
| `GetRotationOffset()` | Rotation | A rotation added to the camera or follow target's eye position. [:fontawesome-solid-info-circle:](../api/examples/#cameragetrotationoffset "Camera: GetRotationOffset Example") | None |
| `SetRotationOffset(Rotation)` | None | A rotation added to the camera or follow target's eye position. [:fontawesome-solid-info-circle:](../api/examples/#camerasetrotationoffset "Camera: SetRotationOffset Example") | Dynamic |

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `followPlayer` | Player | Which Player's view the camera should follow. Set to the local Player for a first or third person camera. Set to nil to detach. [:fontawesome-solid-info-circle:](../api/examples/#camerafollowplayer "Camera: followPlayer Example") | Read-Write, Dynamic |
| `isOrthographic` | bool | Whether the camera uses an isometric (orthographic) view or perspective. [:fontawesome-solid-info-circle:](../api/examples/#cameraisorthographic "Camera: isOrthographic Example") | Read-Write, Dynamic |
| `fieldOfView` | Number | The field of view when using perspective view. Clamped between 1.0 and 170.0. [:fontawesome-solid-info-circle:](../api/examples/#camerafieldofview "Camera: fieldOfView Example") | Read-Write, Dynamic |
| `viewWidth` | Number | The width of the view with an isometric view. Has a minimum value of 1.0. [:fontawesome-solid-info-circle:](../api/examples/#cameraviewwidth "Camera: viewWidth Example") | Read-Write, Dynamic |
| `useCameraSocket` | bool | If you have a followPlayer, then use their camera socket. This is often preferable for first-person cameras, and gives a bit of view bob. [:fontawesome-solid-info-circle:](../api/examples/#camerausecamerasocket "Camera: useCameraSocket Example") | Read-Write, Dynamic |
| `currentDistance` | Number | The distance controlled by the Player with scroll wheel (by default). [:fontawesome-solid-info-circle:](../api/examples/#cameracurrentdistance "Camera: currentDistance Example") | Client-Only, Read-Write, Dynamic |
| `isDistanceAdjustable` | bool | Whether the Player can control their camera distance (with the mouse wheel by default). Creators can still access distance through currentDistance below, even if this value is false. [:fontawesome-solid-info-circle:](../api/examples/#cameraisdistanceadjustable "Camera: isDistanceAdjustable Example") | Read-Write, Dynamic |
| `minDistance` | Number | The minimum distance the Player can zoom in to. [:fontawesome-solid-info-circle:](../api/examples/#cameramindistance "Camera: minDistance Example") | Read-Write, Dynamic |
| `maxDistance` | Number | The maximum distance the Player can zoom out to. [:fontawesome-solid-info-circle:](../api/examples/#cameramaxdistance "Camera: maxDistance Example") | Read-Write, Dynamic |
| `rotationMode` | enum | Which base rotation to use. Values: `RotationMode.CAMERA`, `RotationMode.NONE`, `RotationMode.LOOK_ANGLE`. [:fontawesome-solid-info-circle:](../api/examples/#camerarotationmode "Camera: rotationMode Example") | Read-Write, Dynamic |
| `hasFreeControl` | bool | Whether the Player can freely control their rotation (with mouse or thumbstick). Requires movement mode `RotationMode.CAMERA`. This has no effect if the camera is following a player. [:fontawesome-solid-info-circle:](../api/examples/#camerahasfreecontrol "Camera: hasFreeControl Example") | Read-Write, Dynamic |
| `currentPitch` | Number | The current pitch of the Player's free control. [:fontawesome-solid-info-circle:](../api/examples/#cameracurrentpitch "Camera: currentPitch Example") | Client-Only, Read-Write, Dynamic |
| `minPitch` | Number | The minimum pitch for free control. [:fontawesome-solid-info-circle:](../api/examples/#cameraminpitch "Camera: minPitch Example") | Read-Write, Dynamic |
| `maxPitch` | Number | The maximum pitch for free control. [:fontawesome-solid-info-circle:](../api/examples/#cameramaxpitch "Camera: maxPitch Example") | Read-Write, Dynamic |
| `isYawLimited` | bool | Whether the Player's yaw has limits. If so, `maxYaw` must be at least `minYaw`, and should be outside the range `[0, 360]` if needed. [:fontawesome-solid-info-circle:](../api/examples/#cameraisyawlimited "Camera: isYawLimited Example") | Read-Write, Dynamic |
| `currentYaw` | Number | The current yaw of the Player's free control. [:fontawesome-solid-info-circle:](../api/examples/#cameracurrentyaw "Camera: currentYaw Example") | Client-Only, Read-Write, Dynamic |
| `minYaw` | Number | The minimum yaw for free control. [:fontawesome-solid-info-circle:](../api/examples/#cameraminyaw "Camera: minYaw Example") | Read-Write, Dynamic |
| `maxYaw` | Number | The maximum yaw for free control. [:fontawesome-solid-info-circle:](../api/examples/#cameramaxyaw "Camera: maxYaw Example") | Read-Write, Dynamic |

### Color

An RGBA representation of a color. Color components have an effective range of `[0.0, 1.0]`, but values greater than 1 may be used.

| Class Function | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `Color.Lerp(Color from, Color to, Number progress)` | Color | Linearly interpolates between two colors in HSV space by the specified progress amount and returns the resultant Color. [:fontawesome-solid-info-circle:](../api/examples/#colorlerp "Color: Lerp Example") | None |
| `Color.Random()` | Color | Returns a new color with random RGB values and Alpha of 1.0. | None |

| Constructor | Return Type | Description | Tags |
| ----------- | ----------- | ----------- | ---- |
| `Color.New(Number r, Number g, Number b, [Number a])` | Color | Constructs a Color with the given values, alpha defaults to 1.0. | None |
| `Color.New(Vector3 v)` | Color | Constructs a Color using the vector's XYZ components as the color's RGB components, alpha defaults to 1.0. | None |
| `Color.New(Vector4 v)` | Color | Constructs a Color using the vector's XYZW components as the color's RGBA components. | None |
| `Color.New(Color c)` | Color | Makes a copy of the given color. | None |

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetDesaturated(Number desaturation)` | Color | Returns the desaturated version of the Color. 0 represents no desaturation and 1 represents full desaturation. | None |

| Operator | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Color + Color` | Color | Component-wise addition. | None |
| `Color - Color` | Color | Component-wise subtraction | None |
| `Color * Color` | Color | Component-wise multiplication. | None |
| `Color * Number` | Color | Multiplies each component of the Color by the right-side Number. | None |
| `Color / Color` | Color | Component-wise division. | None |
| `Color / Number` | Color | Divides each component of the Color by the right-side Number. | None |

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `r` | Number | The Red component of the Color. | Read-Write |
| `g` | Number | The Green component of the Color. | Read-Write |
| `b` | Number | The Blue component of the Color. | Read-Write |
| `a` | Number | The Alpha (transparency) component of the Color. | Read-Write |

#### Predefined Colors

| HEX Value | Enum Name | HEX Value | Enum Name |
| --------- | --------- | --------- | --------- |
| :fontawesome-solid-square:{: .Color_WHITE } `#ffffffff`       | Color.WHITE       | :fontawesome-solid-square:{: .Color_ORANGE } `#cc4c00ff`   | Color.ORANGE |
| :fontawesome-solid-square:{: .Color_GRAY } `#7f7f7fff`        | Color.GRAY        | :fontawesome-solid-square:{: .Color_PURPLE } `#4c0099ff`   | Color.PURPLE |
| :fontawesome-solid-square:{: .Color_BLACK } `#000000ff`       | Color.BLACK       | :fontawesome-solid-square:{: .Color_BROWN } `#721400ff`    | Color.BROWN |
| :fontawesome-solid-square:{: .Color_TRANSPARENT } `#ffffff00` | Color.TRANSPARENT | :fontawesome-solid-square:{: .Color_PINK } `#ff6666ff`     | Color.PINK |
| :fontawesome-solid-square:{: .Color_RED } `#ff0000ff`         | Color.RED         | :fontawesome-solid-square:{: .Color_TAN } `#e5bf4cff`      | Color.TAN |
| :fontawesome-solid-square:{: .Color_GREEN } `#00ff00ff`       | Color.GREEN       | :fontawesome-solid-square:{: .Color_RUBY } `#660101ff`     | Color.RUBY |
| :fontawesome-solid-square:{: .Color_BLUE } `#0000ffff`        | Color.BLUE        | :fontawesome-solid-square:{: .Color_EMERALD } `#0c660cff`  | Color.EMERALD |
| :fontawesome-solid-square:{: .Color_CYAN } `#00ffffff`        | Color.CYAN        | :fontawesome-solid-square:{: .Color_SAPPHIRE } `#02024cff` | Color.SAPPHIRE |
| :fontawesome-solid-square:{: .Color_MAGENTA} `#ff00ffff`      | Color.MAGENTA     | :fontawesome-solid-square:{: .Color_SILVER } `#b2b2b2ff`   | Color.SILVER |
| :fontawesome-solid-square:{: .Color_YELLOW } `#ffff00ff`      | Color.YELLOW      | :fontawesome-solid-square:{: .Color_SMOKE } `#191919ff`    | Color.SMOKE |

### CoreMesh

CoreMesh is a CoreObject representing a mesh that can be placed in the scene. It is the parent type for both AnimatedMesh and StaticMesh.

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetColor()` | Color | Returns the color override previously set from script, or `0, 0, 0, 0` if no such color has been set. [:fontawesome-solid-info-circle:](../api/examples/#coremeshgetcolor "Coremesh: GetColor Example") | None |
| `SetColor(Color)` | None | Overrides the color of all materials on the mesh, and replicates the new colors. [:fontawesome-solid-info-circle:](../api/examples/#coremeshsetcolor "Coremesh: SetColor Example") | Dynamic |
| `ResetColor()` | None | Turns off the color override, if there is one. [:fontawesome-solid-info-circle:](../api/examples/#coremeshresetcolor "Coremesh: ResetColor Example") | Dynamic |

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `team` | Integer | Assigns the mesh to a team. Value range from `0` to `4`. `0` is neutral team. [:fontawesome-solid-info-circle:](../api/examples/#coremeshteam "Coremesh: team Example") | Read-Write, Dynamic |
| `isTeamColorUsed` | bool | If `true`, and the mesh has been assigned to a valid team, players on that team will see a blue mesh, while other players will see red. Requires a material that supports the color property. [:fontawesome-solid-info-circle:](../api/examples/#coremeshisteamcolorused "Coremesh: isTeamColorUsed Example") | Read-Write, Dynamic |
| `isTeamCollisionEnabled` | bool | If `false`, and the mesh has been assigned to a valid team, players on that team will not collide with the mesh. [:fontawesome-solid-info-circle:](../api/examples/#coremeshisteamcollisionenabled "Coremesh: isTeamCollisionEnabled Example") | Read-Write, Dynamic |
| `isEnemyCollisionEnabled` | bool | If `false`, and the mesh has been assigned to a valid team, players on other teams will not collide with the mesh. [:fontawesome-solid-info-circle:](../api/examples/#coremeshisenemycollisionenabled "Coremesh: isEnemyCollisionEnabled Example") | Read-Write, Dynamic |
| `isCameraCollisionEnabled` | bool | If `false`, the mesh will not push against the camera. Useful for things like railings or transparent walls. [:fontawesome-solid-info-circle:](../api/examples/#coremeshiscameracollisionenabled "Coremesh: isCameraCollisionEnabled Example") | Read-Write, Dynamic |
| `meshAssetId` | string | The ID of the mesh asset used by this mesh. [:fontawesome-solid-info-circle:](../api/examples/#coremeshmeshassetid "Coremesh: meshAssetId Example") | Read-Only |

### CoreObject

CoreObject is an Object placed in the scene hierarchy during edit mode or is part of a template. Usually they'll be a more specific type of CoreObject, but all CoreObjects have these properties and functions:

| Event | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `childAddedEvent` | Event&lt;CoreObject parent, CoreObject newChild&gt; | Fired when a child is added to this object. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectchildaddedevent "Coreobject: childAddedEvent Example") | None |
| `childRemovedEvent` | Event&lt;CoreObject parent, CoreObject removedChild&gt; | Fired when a child is removed from this object. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectchildremovedevent "Coreobject: childRemovedEvent Example") | None |
| `descendantAddedEvent` | Event&lt;CoreObject ancestor, CoreObject newChild&gt; | Fired when a child is added to this object or any of its descendants. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectdescendantaddedevent "Coreobject: descendantAddedEvent Example") | None |
| `descendantRemovedEvent` | Event&lt;CoreObject ancestor, CoreObject removedChild&gt; | Fired when a child is removed from this object or any of its descendants. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectdescendantremovedevent "Coreobject: descendantRemovedEvent Example") | None |
| `destroyEvent` | Event&lt;CoreObject&gt; | Fired when this object is about to be destroyed. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectdestroyevent "Coreobject: destroyEvent Example") | None |
| `networkedPropertyChangedEvent` | Event&lt;CoreObject owner, string propertyName&gt; | Fired whenever any of the networked custom properties on this object receive an update. The event is fired on the server and the client. Event payload is the owning object and the name of the property that just changed. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectnetworkedpropertychangedevent "Coreobject: networkedPropertyChangedEvent Example") | None |

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetTransform()` | Transform | The Transform relative to this object's parent. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectgettransform "Coreobject: GetTransform Example") | None |
| `SetTransform(Transform)` | None | The Transform relative to this object's parent. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectsettransform "Coreobject: SetTransform Example") | Dynamic |
| `GetPosition()` | Vector3 | The position of this object relative to its parent. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectgetposition "Coreobject: GetPosition Example") | None |
| `SetPosition(Vector3)` | None | The position of this object relative to its parent. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectsetposition "Coreobject: SetPosition Example") | Dynamic |
| `GetRotation()` | Rotation | The rotation relative to its parent. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectgetrotation "Coreobject: GetRotation Example") | None |
| `SetRotation(Rotation)` | None | The rotation relative to its parent. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectsetrotation "Coreobject: SetRotation Example") | Dynamic |
| `GetScale()` | Vector3 | The scale relative to its parent. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectgetscale "Coreobject: GetScale Example") | None |
| `SetScale(Vector3)` | None | The scale relative to its parent. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectsetscale "Coreobject: SetScale Example") | Dynamic |
| `GetWorldTransform()` | Transform | The absolute Transform of this object. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectgetworldtransform "Coreobject: GetWorldTransform Example") | None |
| `SetWorldTransform(Transform)` | None | The absolute Transform of this object. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectsetworldtransform "Coreobject: SetWorldTransform Example") | Dynamic |
| `GetWorldPosition()` | Vector3 | The absolute position. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectgetworldposition "Coreobject: GetWorldPosition Example") | None |
| `SetWorldPosition(Vector3)` | None | The absolute position. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectsetworldposition "Coreobject: SetWorldPosition Example") | Dynamic |
| `GetWorldRotation()` | Rotation | The absolute rotation. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectgetworldrotation "Coreobject: GetWorldRotation Example") | None |
| `SetWorldRotation(Rotation)` | None | The absolute rotation. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectsetworldrotation "Coreobject: SetWorldRotation Example") | Dynamic |
| `GetWorldScale()` | Vector3 | The absolute scale. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectgetworldscale "Coreobject: GetWorldScale Example") | None |
| `SetWorldScale(Vector3)` | None | The absolute scale. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectsetworldscale "Coreobject: SetWorldScale Example") | Dynamic |
| `GetVelocity()` | Vector3 | The object's velocity in world space. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectgetvelocity "Coreobject: GetVelocity Example") | None |
| `SetVelocity(Vector3)` | None | Set the object's velocity in world space. Only works for physics objects. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectsetvelocity "Coreobject: SetVelocity Example") | Dynamic |
| `GetAngularVelocity()` | Vector3 | The object's angular velocity in degrees per second. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectgetangularvelocity "Coreobject: GetAngularVelocity Example") | None |
| `SetAngularVelocity(Vector3)` | None | Set the object's angular velocity in degrees per second in world space. Only works for physics objects. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectsetangularvelocity "Coreobject: SetAngularVelocity Example") | Dynamic |
| `SetLocalAngularVelocity(Vector3)` | None | Set the object's angular velocity in degrees per second in local space. Only works for physics objects. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectsetlocalangularvelocity "Coreobject: SetLocalAngularVelocity Example") | Dynamic |
| `GetReference()` | CoreObjectReference | Returns a CoreObjectReference pointing at this object. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectgetreference "Coreobject: GetReference Example") | None |
| `GetChildren()` | Array&lt;CoreObject&gt; | Returns a table containing the object's children, may be empty. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectgetchildren "Coreobject: GetChildren Example") | None |
| `IsVisibleInHierarchy()` | bool | Returns true if this object and all of its ancestors are visible. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectisvisibleinhierarchy "Coreobject: IsVisibleInHierarchy Example") | None |
| `IsCollidableInHierarchy()` | bool | Returns true if this object and all of its ancestors are collidable. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectiscollidableinhierarchy "Coreobject: IsCollidableInHierarchy Example") | None |
| `IsEnabledInHierarchy()` | bool | Returns true if this object and all of its ancestors are enabled. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectisenabledinhierarchy "Coreobject: IsEnabledInHierarchy Example") | None |
| `FindAncestorByName(string name)` | CoreObject | Returns the first parent or ancestor whose name matches the provided name. If none match, returns nil. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectfindancestorbyname "Coreobject: FindAncestorByName Example") | None |
| `FindChildByName(string name)` | CoreObject | Returns the first immediate child whose name matches the provided name. If none match, returns nil. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectfindchildbyname "Coreobject: FindChildByName Example") | None |
| `FindDescendantByName(string name)` | CoreObject | Returns the first child or descendant whose name matches the provided name. If none match, returns nil. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectfinddescendantbyname "Coreobject: FindDescendantByName Example") | None |
| `FindDescendantsByName(string name)` | Array&lt;CoreObject&gt; | Returns the descendants whose name matches the provided name. If none match, returns an empty table. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectfinddescendantsbyname "Coreobject: FindDescendantsByName Example") | None |
| `FindAncestorByType(string typeName)` | CoreObject | Returns the first parent or ancestor whose type is or extends the specified type. For example, calling FindAncestorByType('CoreObject') will return the first ancestor that is any type of CoreObject, while FindAncestorByType('StaticMesh') will only return the first mesh. If no ancestors match, returns nil. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectfindancestorbytype "Coreobject: FindAncestorByType Example") | None |
| `FindChildByType(string typeName)` | CoreObject | Returns the first immediate child whose type is or extends the specified type. If none match, returns nil. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectfindchildbytype "Coreobject: FindChildByType Example") | None |
| `FindDescendantByType(string typeName)` | CoreObject | Returns the first child or descendant whose type is or extends the specified type. If none match, returns nil. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectfinddescendantbytype "Coreobject: FindDescendantByType Example") | None |
| `FindDescendantsByType(string typeName)` | Array&lt;CoreObject&gt; | Returns the descendants whose type is or extends the specified type. If none match, returns an empty table. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectfinddescendantsbytype "Coreobject: FindDescendantsByType Example") | None |
| `FindTemplateRoot()` | CoreObject | If the object is part of a template, returns the root object of the template (which may be itself). If not part of a template, returns nil. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectfindtemplateroot "Coreobject: FindTemplateRoot Example") | None |
| `IsAncestorOf(CoreObject)` | bool | Returns true if this CoreObject is a parent somewhere in the hierarchy above the given parameter object. False otherwise. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectisancestorof "Coreobject: IsAncestorOf Example") | None |
| `GetCustomProperties()` | table | Returns a table containing the names and values of all custom properties on a CoreObject. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectgetcustomproperties "Coreobject: GetCustomProperties Example") | None |
| `GetCustomProperty(string propertyName)` | value, bool | Gets data which has been added to an object using the custom property system. Returns the value, which can be an Integer, Number, bool, string, Vector3, Rotator, Color, a MUID string, or nil if not found. Second return value is a bool, true if found and false if not. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectgetcustomproperty "Coreobject: GetCustomProperty Example") | None |
| `SetNetworkedCustomProperty(string propertyName, value)` | bool | Sets the named custom property if it is marked as replicated and the object it belongs to is server-side networked or in a client/server context. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectsetnetworkedcustomproperty "Coreobject: SetNetworkedCustomProperty Example") | Server-Only |
| `AttachToPlayer(Player, string socketName)` | None | Attaches a CoreObject to a Player at a specified socket. The CoreObject will be un-parented from its current hierarchy and its `parent` property will be nil. See [Socket Names](api/animations.md#socket-names) for the list of possible values. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectattachtoplayer "Coreobject: AttachToPlayer Example") | Dynamic |
| `AttachToLocalView()` | None | Attaches a CoreObject to the local player's camera. Reminder to turn off the object's collision otherwise it will cause camera to jitter. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectattachtolocalview "Coreobject: AttachToLocalView Example") | Client-Only, Dynamic |
| `Detach()` | None | Detaches a CoreObject from any player it has been attached to, or from its parent object. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectdetach "Coreobject: Detach Example") | Dynamic |
| `GetAttachedToSocketName()` | string | Returns the name of the socket this object is attached to. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectgetattachedtosocketname "Coreobject: GetAttachedToSocketName Example") | None |
| `MoveTo(Vector3, Number, [bool])` | None | Smoothly moves the object to the target location over a given amount of time (seconds). Third parameter specifies if the given destination is in local space (true) or world space (false). [:fontawesome-solid-info-circle:](../api/examples/#coreobjectmoveto "Coreobject: MoveTo Example") | Dynamic |
| `RotateTo(Rotation/Quaternion, Number, [bool])` | None | Smoothly rotates the object to the target orientation over a given amount of time. Third parameter specifies if given rotation is in local space (true) or world space (false). [:fontawesome-solid-info-circle:](../api/examples/#coreobjectrotateto "Coreobject: RotateTo Example") | Dynamic |
| `ScaleTo(Vector3, Number, [bool])` | None | Smoothly scales the object to the target scale over a given amount of time. Third parameter specifies if the given scale is in local space (true) or world space (false). [:fontawesome-solid-info-circle:](../api/examples/#coreobjectscaleto "Coreobject: ScaleTo Example") | Dynamic |
| `MoveContinuous(Vector3, [bool])` | None | Smoothly moves the object over time by the given velocity vector. Second parameter specifies if the given velocity is in local space (true) or world space (false). [:fontawesome-solid-info-circle:](../api/examples/#coreobjectmovecontinuous "Coreobject: MoveContinuous Example") | Dynamic |
| `RotateContinuous(Rotation/Quaternion/Vector3, [Number, [bool]])` | None | Smoothly rotates the object over time by the given angular velocity. The second parameter is an optional multiplier, for very fast rotations. Third parameter specifies if the given rotation or quaternion is in local space (true) or world space (false (default)). [:fontawesome-solid-info-circle:](../api/examples/#coreobjectrotatecontinuous "Coreobject: RotateContinuous Example") | Dynamic |
| `ScaleContinuous(Vector3, [bool])` | None | Smoothly scales the object over time by the given scale vector per second. Second parameter specifies if the given scale rate is in local space (true) or world space (false). [:fontawesome-solid-info-circle:](../api/examples/#coreobjectscalecontinuous "Coreobject: ScaleContinuous Example") | Dynamic |
| `StopMove()` | None | Interrupts further movement from MoveTo(), MoveContinuous(), or Follow(). [:fontawesome-solid-info-circle:](../api/examples/#coreobjectstopmove "Coreobject: StopMove Example") | Dynamic |
| `StopRotate()` | None | Interrupts further rotation from RotateTo(), RotateContinuous(), LookAtContinuous(), or LookAtLocalView(). [:fontawesome-solid-info-circle:](../api/examples/#coreobjectstoprotate "Coreobject: StopRotate Example") | Dynamic |
| `StopScale()` | None | Interrupts further movement from ScaleTo() or ScaleContinuous(). [:fontawesome-solid-info-circle:](../api/examples/#coreobjectstopscale "Coreobject: StopScale Example") | Dynamic |
| `Follow(Object, [Number, [Number]])` | None | Follows a CoreObject or Player at a certain speed. If the speed is not supplied it will follow as fast as possible. The third parameter specifies a distance to keep away from the target. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectfollow "Coreobject: Follow Example") | Dynamic |
| `LookAt(Vector3 position)` | None | Instantly rotates the object to look at the given position. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectlookat "Coreobject: LookAt Example") | Dynamic |
| `LookAtContinuous(Object, [bool], [Number])` | None | Smoothly rotates a CoreObject to look at another given CoreObject or Player. Second parameter is optional and locks the pitch, default is unlocked. Third parameter is optional and sets how fast it tracks the target (in radians/second). If speed is not supplied it tracks as fast as possible. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectlookatcontinuous "Coreobject: LookAtContinuous Example") | Dynamic |
| `LookAtLocalView([bool])` | None | Continuously looks at the local camera. The bool parameter is optional and locks the pitch. (Client-only) [:fontawesome-solid-info-circle:](../api/examples/#coreobjectlookatlocalview "Coreobject: LookAtLocalView Example") | Client-Only, Dynamic |
| `Destroy()` | None | Destroys the object and all descendants. You can check whether an object has been destroyed by calling `Object.IsValid(object)`, which will return true if object is still a valid object, or false if it has been destroyed. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectdestroy "Coreobject: Destroy Example") | Dynamic |

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `name` | string | The object's name as seen in the Hierarchy. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectname "Coreobject: name Example") | Read-Write, Dynamic |
| `id` | string | The object's MUID. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectid "Coreobject: id Example") | Read-Only |
| `parent` | CoreObject | The object's parent object, may be nil. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectparent "Coreobject: parent Example") | Read-Write, Dynamic |
| `visibility` | enum | Turn on/off the rendering of an object and its children. Values: `Visibility.FORCE_ON`, `Visibility.FORCE_OFF`, `Visibility.INHERIT`. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectvisibility "Coreobject: visibility Example") | Read-Write, Dynamic |
| `collision` | enum | Turn on/off the collision of an object and its children. Values: `Collision.FORCE_ON`, `Collision.FORCE_OFF`, `Collision.INHERIT`. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectcollision "Coreobject: collision Example") | Read-Write, Dynamic |
| `isEnabled` | bool | Turn on/off an object and its children completely. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectisenabled "Coreobject: isEnabled Example") | Read-Write, Dynamic |
| `isStatic` | bool | If `true`, dynamic properties may not be written to, and dynamic functions may not be called. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectisstatic "Coreobject: isStatic Example") | Read-Only, Dynamic |
| `isClientOnly` | bool | If `true`, this object was spawned on the client and is not replicated from the server. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectisclientonly "Coreobject: isClientOnly Example") | Read-Only |
| `isServerOnly` | bool | If `true`, this object was spawned on the server and is not replicated to clients. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectisserveronly "Coreobject: isServerOnly Example") | Read-Only |
| `isNetworked` | bool | If `true`, this object replicates from the server to clients. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectisnetworked "Coreobject: isNetworked Example") | Read-Only |
| `lifeSpan` | Number | Duration after which the object is destroyed. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectlifespan "Coreobject: lifeSpan Example") | Read-Write, Dynamic |
| `sourceTemplateId` | string | The ID of the Template from which this CoreObject was instantiated. `nil` if the object did not come from a Template. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectsourcetemplateid "Coreobject: sourceTemplateId Example") | Read-Only |

### CoreObjectReference

A reference to a CoreObject which may or may not exist. This type is returned by CoreObject:GetCustomProperty() for CoreObject Reference properties, and may be used to find the actual object if it exists.

In the case of networked objects it's possible to get a CoreObjectReference pointing to a CoreObject that hasn't been received on the client yet.

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetObject()` | CoreObject | Returns the CoreObject with a matching ID, if it exists. Will otherwise return nil. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectreferencegetobject "Coreobjectreference: GetObject Example") | None |
| `WaitForObject([Number])` | CoreObject | Returns the CoreObject with a matching ID, if it exists. If it does not, yields the current task until the object is spawned. Optional timeout parameter will cause the task to resume with a return value of false and an error message if the object has not been spawned within that many seconds. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectreferencewaitforobject "Coreobjectreference: WaitForObject Example") | None |

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `id` | string | The MUID of the referred object. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectreferenceid "Coreobjectreference: id Example") | Read-Only |
| `isAssigned` | bool | Returns true if this reference has been assigned a valid ID. This does not necessarily mean the object currently exists. [:fontawesome-solid-info-circle:](../api/examples/#coreobjectreferenceisassigned "Coreobjectreference: isAssigned Example") | Read-Only |

### Damage

To damage a Player, you can simply write e.g.: `whichPlayer:ApplyDamage(Damage.New(10))`. Alternatively, create a Damage object and populate it with all the following properties to get full use out of the system:

| Constructor | Return Type | Description | Tags |
| ----------- | ----------- | ----------- | ---- |
| `Damage.New([Number amount])` | Damage | Constructs a damage object with the given number, defaults to 0. [:fontawesome-solid-info-circle:](../api/examples/#damagenew "Damage: New Example") | None |

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetHitResult()` | HitResult | Get the HitResult information if this damage was caused by a Projectile impact. [:fontawesome-solid-info-circle:](../api/examples/#damagegethitresult "Damage: GetHitResult Example") | None |
| `SetHitResult(HitResult)` | None | Forward the HitResult information if this damage was caused by a Projectile impact. [:fontawesome-solid-info-circle:](../api/examples/#damagesethitresult "Damage: SetHitResult Example") | None |

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `amount` | Number | The numeric amount of damage to inflict. [:fontawesome-solid-info-circle:](../api/examples/#damageamount "Damage: amount Example") | Read-Write |
| `reason` | DamageReason | What is the context for this Damage? DamageReason.UNKNOWN (default value), DamageReason.COMBAT, DamageReason.FRIENDLY_FIRE, DamageReason.MAP, DamageReason.NPC. [:fontawesome-solid-info-circle:](../api/examples/#damagereason "Damage: reason Example") | Read-Write |
| `sourceAbility` | Ability | Reference to the Ability which caused the Damage. Setting this allows other systems to react to the damage event, e.g. a kill feed can show what killed a Player. [:fontawesome-solid-info-circle:](../api/examples/#damagesourceability "Damage: sourceAbility Example") | Read-Write |
| `sourcePlayer` | Player | Reference to the Player who caused the Damage. Setting this allows other systems to react to the damage event, e.g. a kill feed can show who killed a Player. [:fontawesome-solid-info-circle:](../api/examples/#damagesourceplayer "Damage: sourcePlayer Example") | Read-Write |

### Equipment

Equipment is a CoreObject representing an equippable item for players. They generally have a visual component that attaches to the Player, but a visual component is not a requirement. Any Ability objects added as children of the Equipment are added/removed from the Player automatically as it becomes equipped/unequipped.

| Event | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `equippedEvent` | Event&lt;Equipment, Player&gt; | Fired when this equipment is equipped onto a player. [:fontawesome-solid-info-circle:](../api/examples/#equipmentequippedevent "Equipment: equippedEvent Example") | None |
| `unequippedEvent` | Event&lt;Equipment, Player&gt; | Fired when this object is unequipped from a player. [:fontawesome-solid-info-circle:](../api/examples/#equipmentunequippedevent "Equipment: unequippedEvent Example") | None |

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Equip(Player)` | None | Attaches the Equipment to a Player. They gain any abilities assigned to the Equipment. If the Equipment is already attached to another Player it will first unequip from that other Player before equipping unto the new one. [:fontawesome-solid-info-circle:](../api/examples/#equipmentequip "Equipment: Equip Example") | None |
| `Unequip()` | None | Detaches the Equipment from any Player it may currently be attached to. The Player loses any abilities granted by the Equipment. [:fontawesome-solid-info-circle:](../api/examples/#equipmentunequip "Equipment: Unequip Example") | None |
| `AddAbility(Ability)` | None | Adds an Ability to the list of abilities on this Equipment. [:fontawesome-solid-info-circle:](../api/examples/#equipmentaddability "Equipment: AddAbility Example") | None |
| `GetAbilities()` | Array&lt;Ability&gt; | A table of Abilities that are assigned to this Equipment. Players who equip it will get these Abilities. [:fontawesome-solid-info-circle:](../api/examples/#equipmentgetabilities "Equipment: GetAbilities Example") | None |

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `socket` | string | Determines which point on the avatar's body this equipment will be attached. See [Socket Names](api/animations.md#socket-names) for the list of possible values. [:fontawesome-solid-info-circle:](../api/examples/#equipmentsocket "Equipment: socket Example") | Read-Write, Dynamic |
| `owner` | Player | Which Player the Equipment is attached to. [:fontawesome-solid-info-circle:](../api/examples/#equipmentowner "Equipment: owner Example") | Read-Only, Dynamic |

### Event

Events appear as properties on several objects. The goal is to register a function that will be fired whenever that event happens. E.g. `playerA.damagedEvent:Connect(OnPlayerDamaged)` chooses the function `OnPlayerDamaged` to be fired whenever `playerA` takes damage.

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Connect(function eventListener, [...])` | EventListener | Registers the given function which will be called every time the event is fired. Returns an EventListener which can be used to disconnect from the event or check if the event is still connected. Accepts any number of additional arguments after the listener function, those arguments will be provided after the event's own parameters. | None |

### EventListener

EventListeners are returned by Events when you connect a listener function to them.

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Disconnect()` | None | Disconnects this listener from its event, so it will no longer be called when the event is fired. [:fontawesome-solid-info-circle:](../api/examples/#eventlistenerdisconnect "Eventlistener: Disconnect Example") | None |

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `isConnected` | bool | Returns true if this listener is still connected to its event. false if the event owner was destroyed or if Disconnect was called. [:fontawesome-solid-info-circle:](../api/examples/#eventlistenerisconnected "Eventlistener: isConnected Example") | Read-Only |

### Folder

Folder is a CoreObject representing a folder containing other objects.

They have no properties or functions of their own, but inherit everything from CoreObject.

### HitResult

Contains data pertaining to an impact or raycast.

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetImpactPosition()` | Vector3 | The world position where the impact occurred. [:fontawesome-solid-info-circle:](../api/examples/#hitresultgetimpactposition "Hitresult: GetImpactPosition Example") | None |
| `GetImpactNormal()` | Vector3 | Normal direction of the surface which was impacted. [:fontawesome-solid-info-circle:](../api/examples/#hitresultgetimpactnormal "Hitresult: GetImpactNormal Example") | None |
| `GetTransform()` | Transform | Returns a Transform composed of the position of the impact in world space, the rotation of the normal, and a uniform scale of 1. [:fontawesome-solid-info-circle:](../api/examples/#hitresultgettransform "Hitresult: GetTransform Example") | None |

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `other` | CoreObject or Player | Reference to a CoreObject or Player impacted. [:fontawesome-solid-info-circle:](../api/examples/#hitresultother "Hitresult: other Example") | Read-Only |
| `socketName` | string | If the hit was on a Player, `socketName` tells you which spot on the body was hit. [:fontawesome-solid-info-circle:](../api/examples/#hitresultsocketname "Hitresult: socketName Example") | Read-Only |

### ImpactData

A data structure containing all information about a specific Weapon interaction, such as collision with a character.

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetHitResult()` | HitResult | Physics information about the impact between the Weapon and the other object. [:fontawesome-solid-info-circle:](../api/examples/#impactdatagethitresult "Impactdata: GetHitResult Example") | None |
| `GetHitResults()` | Array&lt;HitResult&gt; | Table with multiple HitResults that hit the same object, in the case of Weapons with multi-shot (e.g. Shotguns). If a single attack hits multiple targets you receive a separate interaction event for each object hit. [:fontawesome-solid-info-circle:](../api/examples/#impactdatagethitresults "Impactdata: GetHitResults Example") | None |

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `targetObject` | Object | Reference to the CoreObject/Player hit by the Weapon. [:fontawesome-solid-info-circle:](../api/examples/#impactdatatargetobject "Impactdata: targetObject Example") | Read-Only |
| `projectile` | Projectile | Reference to a Projectile, if one was produced as part of this interaction. [:fontawesome-solid-info-circle:](../api/examples/#impactdataprojectile "Impactdata: projectile Example") | Read-Only |
| `sourceAbility` | Ability | Reference to the Ability which initiated the interaction. [:fontawesome-solid-info-circle:](../api/examples/#impactdatasourceability "Impactdata: sourceAbility Example") | Read-Only |
| `weapon` | Weapon | Reference to the Weapon that is interacting. [:fontawesome-solid-info-circle:](../api/examples/#impactdataweapon "Impactdata: weapon Example") | Read-Only |
| `weaponOwner` | Player | Reference to the Player who had the Weapon equipped at the time it was activated, ultimately leading to this interaction. [:fontawesome-solid-info-circle:](../api/examples/#impactdataweaponowner "Impactdata: weaponOwner Example") | Read-Only |
| `travelDistance` | Number | The distance in cm between where the Weapon attack started until it impacted something. [:fontawesome-solid-info-circle:](../api/examples/#impactdatatraveldistance "Impactdata: travelDistance Example") | Read-Only |
| `isHeadshot` | bool | True if the Weapon hit another player in the head. [:fontawesome-solid-info-circle:](../api/examples/#impactdataisheadshot "Impactdata: isHeadshot Example") | Read-Only |

### Light

Light is a light source that is a CoreObject. Generally a Light will be an instance of some subtype, such as PointLight or SpotLight.

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetColor()` | Color | The color of the light. | None |
| `SetColor(Color)` | None | The color of the light. | Dynamic |

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `intensity` | Number | The intensity of the light. For PointLights and SpotLights, this has two interpretations, depending on the value of the `hasNaturalFallOff` property. If `true`, the light's Intensity is in units of lumens, where 1700 lumens is a 100W lightbulb. If `false`, the light's Intensity is a brightness scale. | Read-Write, Dynamic |
| `attenuationRadius` | Number | Bounds the light's visible influence. This clamping of the light's influence is not physically correct but very important for performance, larger lights cost more. | Read-Write, Dynamic |
| `isShadowCaster` | bool | Does this light cast shadows? | Read-Write, Dynamic |
| `hasTemperature` | bool | true: use temperature value as illuminant. false: use white (D65) as illuminant. | Read-Write, Dynamic |
| `temperature` | Number | Color temperature in Kelvin of the blackbody illuminant. White (D65) is 6500K. | Read-Write, Dynamic |
| `team` | Integer | Assigns the light to a team. Value range from 0 to 4. 0 is a neutral team. | Read-Write, Dynamic |
| `isTeamColorUsed` | bool | If `true`, and the light has been assigned to a valid team, players on that team will see a blue light, while other players will see red. | Read-Write, Dynamic |

### NetworkContext

NetworkContext is a CoreObject representing a special folder containing client-only, server-only, or static objects.

They have no properties or functions of their own, but inherit everything from CoreObject.

### Object

At a high level, Core Lua types can be divided into two groups: data structures and Objects. Data structures are owned by Lua, while Objects are owned by the engine and could be destroyed while still referenced by Lua. Any such object will inherit from this type. These include CoreObject, Player and Projectile.

| Class Function | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `Object.IsValid(Object object)` | bool | Returns true if object is still a valid Object, or false if it has been destroyed. Also returns false if passed a nil value or something that's not an Object, such as a Vector3 or a string. [:fontawesome-solid-info-circle:](../api/examples/#objectisvalid "Object: IsValid Example") | None |

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `serverUserData` | table | Table in which users can store any data they want on the server. [:fontawesome-solid-info-circle:](../api/examples/#objectserveruserdata "Object: serverUserData Example") | Server-Only, Read-Write |
| `clientUserData` | table | Table in which users can store any data they want on the client. [:fontawesome-solid-info-circle:](../api/examples/#objectclientuserdata "Object: clientUserData Example") | Client-Only, Read-Write |

### Other

Other

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `IsA()` | bool | Expects a string parameter representing an object type. E.g. `myObject:IsA("Equipment")`. Returns `true` if the object is of the given type or one of its subtypes, returns `false` otherwise. | None |

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `type` | string | All data structures and Objects share the common `type` property. | Read-Only |

### Player

Player is an Object representation of the state of a Player connected to the game, as well as their avatar in the world.

| Event | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `damagedEvent` | Event&lt;Player, Damage&gt; | Fired when the Player takes damage. [:fontawesome-solid-info-circle:](../api/examples/#playerdamagedevent "Player: damagedEvent Example") | Server-Only |
| `diedEvent` | Event&lt;Player, Damage&gt; | Fired when the Player dies. [:fontawesome-solid-info-circle:](../api/examples/#playerdiedevent "Player: diedEvent Example") | Server-Only |
| `respawnedEvent` | Event&lt;Player&gt; | Fired when the Player respawns. [:fontawesome-solid-info-circle:](../api/examples/#playerrespawnedevent "Player: respawnedEvent Example") | Server-Only |
| `bindingPressedEvent` | Event&lt;Player, string&gt; | Fired when an action binding is pressed. Second parameter tells you which binding. Possible values of the bindings are listed on the [Ability binding](api/ability_bindings.md) page. [:fontawesome-solid-info-circle:](../api/examples/#playerbindingpressedevent "Player: bindingPressedEvent Example") | None |
| `bindingReleasedEvent` | Event&lt;Player, string&gt; | Fired when an action binding is released. Second parameter tells you which binding. [:fontawesome-solid-info-circle:](../api/examples/#playerbindingreleasedevent "Player: bindingReleasedEvent Example") | None |
| `resourceChangedEvent` | Event&lt;Player, string, Integer&gt; | Fired when a resource changed, indicating the type of the resource and its new amount. [:fontawesome-solid-info-circle:](../api/examples/#playerresourcechangedevent "Player: resourceChangedEvent Example") | None |
| `movementModeChangedEvent` | Event&lt;Player, MovementMode, MovementMode&gt; | Fired when a Player's movement mode changes. The first parameter is the Player being changed. The second parameter is the "new" movement mode. The third parameter is the "previous" movement mode. Possible values for MovementMode are: MovementMode.NONE, MovementMode.WALKING, MovementMode.FALLING, MovementMode.SWIMMING, MovementMode.FLYING. [:fontawesome-solid-info-circle:](../api/examples/#playermovementmodechangedevent "Player: movementModeChangedEvent Example") | None |

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetWorldTransform()` | Transform | The absolute Transform of this player. [:fontawesome-solid-info-circle:](../api/examples/#playergetworldtransform "Player: GetWorldTransform Example") | None |
| `SetWorldTransform(Transform)` | None | The absolute Transform of this player. [:fontawesome-solid-info-circle:](../api/examples/#playersetworldtransform "Player: SetWorldTransform Example") | Server-Only |
| `GetWorldPosition()` | Vector3 | The absolute position of this player. [:fontawesome-solid-info-circle:](../api/examples/#playergetworldposition "Player: GetWorldPosition Example") | None |
| `SetWorldPosition(Vector3)` | None | The absolute position of this player. [:fontawesome-solid-info-circle:](../api/examples/#playersetworldposition "Player: SetWorldPosition Example") | Server-Only |
| `GetWorldRotation()` | Rotation | The absolute rotation of this player. [:fontawesome-solid-info-circle:](../api/examples/#playergetworldrotation "Player: GetWorldRotation Example") | None |
| `SetWorldRotation(Rotation)` | None | The absolute rotation of this player. [:fontawesome-solid-info-circle:](../api/examples/#playersetworldrotation "Player: SetWorldRotation Example") | Server-Only |
| `GetWorldScale()` | Vector3 | The absolute scale of this player. [:fontawesome-solid-info-circle:](../api/examples/#playergetworldscale "Player: GetWorldScale Example") | None |
| `SetWorldScale(Vector3)` | None | The absolute scale of this player (must be uniform). [:fontawesome-solid-info-circle:](../api/examples/#playersetworldscale "Player: SetWorldScale Example") | Server-Only |
| `AddImpulse(Vector3)` | None | Adds an impulse force to the Player. [:fontawesome-solid-info-circle:](../api/examples/#playeraddimpulse "Player: AddImpulse Example") | Server-Only |
| `GetVelocity()` | Vector3 | Gets the current velocity of the Player. [:fontawesome-solid-info-circle:](../api/examples/#playergetvelocity "Player: GetVelocity Example") | None |
| `SetVelocity(Vector3)` | None | Sets the Player's velocity to the given amount. [:fontawesome-solid-info-circle:](../api/examples/#playersetvelocity "Player: SetVelocity Example") | Server-Only |
| `ResetVelocity()` | None | Resets the Player's velocity to zero. [:fontawesome-solid-info-circle:](../api/examples/#playerresetvelocity "Player: ResetVelocity Example") | Server-Only |
| `GetAbilities()` | Array&lt;Ability&gt; | Array of all Abilities assigned to this Player. [:fontawesome-solid-info-circle:](../api/examples/#playergetabilities "Player: GetAbilities Example") | None |
| `GetEquipment()` | Array&lt;Equipment&gt; | Array of all Equipment assigned to this Player. [:fontawesome-solid-info-circle:](../api/examples/#playergetequipment "Player: GetEquipment Example") | None |
| `ApplyDamage(Damage)` | None | Damages a Player. If their hit points go below 0 they die. [:fontawesome-solid-info-circle:](../api/examples/#playerapplydamage "Player: ApplyDamage Example") | Server-Only |
| `Die([Damage])` | None | Kills the Player. They will ragdoll and ignore further Damage. The optional Damage parameter is a way to communicate cause of death. [:fontawesome-solid-info-circle:](../api/examples/#playerdie "Player: Die Example") | Server-Only |
| `DisableRagdoll()` | None | Disables all ragdolls that have been set on the Player. [:fontawesome-solid-info-circle:](../api/examples/#playerdisableragdoll "Player: DisableRagdoll Example") | Server-Only |
| `SetVisibility(bool, [bool])` | None | Shows or hides the Player. The second parameter is optional, defaults to true, and determines if attachments to the Player are hidden as well as the Player. [:fontawesome-solid-info-circle:](../api/examples/#playersetvisibility "Player: SetVisibility Example") | Server-Only |
| `GetVisibility()` | bool | Returns whether or not the Player is hidden. [:fontawesome-solid-info-circle:](../api/examples/#playergetvisibility "Player: GetVisibility Example") | None |
| `EnableRagdoll([string socketName, Number weight])` | None | Enables ragdoll for the Player, starting on `socketName` weighted by `weight` (between 0.0 and 1.0). This can cause the Player capsule to detach from the mesh. All parameters are optional; `socketName` defaults to the root and `weight` defaults to 1.0. Multiple bones can have ragdoll enabled simultaneously. See [Socket Names](api/animations.md#socket-names) for the list of possible values. [:fontawesome-solid-info-circle:](../api/examples/#playerenableragdoll "Player: EnableRagdoll Example") | Server-Only |
| `Respawn([Vector, Rotation])` | None | Resurrects a dead Player based on respawn settings in the game (default in-place). Optional position and rotation parameters can be used to specify a location. [:fontawesome-solid-info-circle:](../api/examples/#playerrespawn "Player: Respawn Example") | Server-Only |
| `GetViewWorldPosition()` | Vector3 | Get position of the Player's camera view. [:fontawesome-solid-info-circle:](../api/examples/#playergetviewworldposition "Player: GetViewWorldPosition Example") | None |
| `GetViewWorldRotation()` | Rotation | Get rotation of the Player's camera view. [:fontawesome-solid-info-circle:](../api/examples/#playergetviewworldrotation "Player: GetViewWorldRotation Example") | None |
| `GetLookWorldRotation()` | Rotation | Get the rotation for the direction the Player is facing. [:fontawesome-solid-info-circle:](../api/examples/#playergetlookworldrotation "Player: GetLookWorldRotation Example") | None |
| `SetLookWorldRotation(Rotation)` | None | Set the rotation for the direction the Player is facing. [:fontawesome-solid-info-circle:](../api/examples/#playersetlookworldrotation "Player: SetLookWorldRotation Example") | Client-Only |
| `ClearResources()` | None | Removes all resources from a player. [:fontawesome-solid-info-circle:](../api/examples/#playerclearresources "Player: ClearResources Example") | Server-Only |
| `GetResources()` | Table&lt;string, Integer&gt; | Returns a table containing the names and amounts of the player's resources. [:fontawesome-solid-info-circle:](../api/examples/#playergetresources "Player: GetResources Example") | None |
| `GetResource(string name)` | Integer | Returns the amount of a resource owned by a player. Returns 0 by default. [:fontawesome-solid-info-circle:](../api/examples/#playergetresource "Player: GetResource Example") | None |
| `SetResource(string name, Integer amount)` | None | Sets a specific amount of a resource on a player. [:fontawesome-solid-info-circle:](../api/examples/#playersetresource "Player: SetResource Example") | Server-Only |
| `AddResource(string name, Integer amount)` | None | Adds an amount of a resource to a player. [:fontawesome-solid-info-circle:](../api/examples/#playeraddresource "Player: AddResource Example") | Server-Only |
| `RemoveResource(string name, Integer amount)` | None | Subtracts an amount of a resource from a player. Does not go below 0. [:fontawesome-solid-info-circle:](../api/examples/#playerremoveresource "Player: RemoveResource Example") | Server-Only |
| `TransferToGame(string)` | None | Does not work in preview mode or in games played locally. Transfers player to the game specified by the passed-in game ID. Example: The game ID for the URL `https://www.coregames.com/games/577d80/core-royale` is `577d80/core-royale`. [:fontawesome-solid-info-circle:](../api/examples/#playertransfertogame "Player: TransferToGame Example") | Server-Only |
| `GetAttachedObjects()` | Array&lt;CoreObject&gt; | Returns a table containing CoreObjects attached to this player. [:fontawesome-solid-info-circle:](../api/examples/#playergetattachedobjects "Player: GetAttachedObjects Example") | None |
| `SetMounted(bool)` | None | Forces a player in or out of mounted state. [:fontawesome-solid-info-circle:](../api/examples/#playersetmounted "Player: SetMounted Example") | Server-Only |
| `GetActiveCamera()` | Camera | Returns whichever camera is currently active for the Player. [:fontawesome-solid-info-circle:](../api/examples/#playergetactivecamera "Player: GetActiveCamera Example") | Client-Only |
| `GetDefaultCamera()` | Camera | Returns the default Camera object the Player is currently using. [:fontawesome-solid-info-circle:](../api/examples/#playergetdefaultcamera "Player: GetDefaultCamera Example") | Client-Only |
| `SetDefaultCamera(Camera, [Number lerpTime = 0.0])` | None | Sets the default Camera object for the Player. | Client-Only |
| `GetOverrideCamera()` | Camera | Returns the override Camera object the Player is currently using. [:fontawesome-solid-info-circle:](../api/examples/#playergetoverridecamera "Player: GetOverrideCamera Example") | Client-Only |
| `SetOverrideCamera(Camera, [Number lerpTime = 0.0])` | None | Sets the override Camera object for the Player. | Client-Only |
| `ClearOverrideCamera([Number lerpTime = 0.0])` | None | Clears the override Camera object for the Player (to revert back to the default camera). | Client-Only |
| `ActivateFlying()` | None | Activates the Player flying mode. [:fontawesome-solid-info-circle:](../api/examples/#playeractivateflying "Player: ActivateFlying Example") | Server-Only |
| `ActivateWalking()` | None | Activate the Player walking mode. [:fontawesome-solid-info-circle:](../api/examples/#playeractivatewalking "Player: ActivateWalking Example") | Server-Only |

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `name` | string | The Player's name. [:fontawesome-solid-info-circle:](../api/examples/#playername "Player: name Example") | Read-Write |
| `id` | string | The unique id of the Player. Consistent across sessions. [:fontawesome-solid-info-circle:](../api/examples/#playerid "Player: id Example") | Read-Only |
| `team` | Integer | The number of the team to which the Player is assigned. By default, this value is 255 in FFA mode. [:fontawesome-solid-info-circle:](../api/examples/#playerteam "Player: team Example") | Read-Write |
| `animationStance` | string | Which set of animations to use for this Player. See [Animation Stance Strings](api/animations.md#animation-stance-strings) for possible values. [:fontawesome-solid-info-circle:](../api/examples/#playeranimationstance "Player: animationStance Example") | Read-Write |
| `currentFacingMode` | FacingMode | Current mode applied to player, including possible overrides. Possible values are FacingMode.FACE_AIM_WHEN_ACTIVE, FacingMode.FACE_AIM_ALWAYS, and FacingMode.FACE_MOVEMENT. See desiredFacingMode for details. [:fontawesome-solid-info-circle:](../api/examples/#playercurrentfacingmode "Player: currentFacingMode Example") | Read-Only |
| `desiredFacingMode` | FacingMode | Which controls mode to use for this Player. May be overridden by certain movement modes like MovementMode.SWIMMING or when mounted. Possible values are FacingMode.FACE_AIM_WHEN_ACTIVE, FacingMode.FACE_AIM_ALWAYS, and FacingMode.FACE_MOVEMENT. [:fontawesome-solid-info-circle:](../api/examples/#playerdesiredfacingmode "Player: desiredFacingMode Example") | Server-Only, Read-Write |
| `defaultRotationRate` | Number | Determines how quickly the Player turns to match the camera's look. Set to -1 for immediate rotation. Currently only supports rotation around the Z-axis. [:fontawesome-solid-info-circle:](../api/examples/#playerdefaultrotationrate "Player: defaultRotationRate Example") | Server-Only, Read-Write |
| `currentRotationRate` | Number | Reports the real rotation rate that results from any active mechanics/movement overrides. [:fontawesome-solid-info-circle:](../api/examples/#playercurrentrotationrate "Player: currentRotationRate Example") | Read-Only |
| `hitPoints` | Number | Current amount of hitpoints. [:fontawesome-solid-info-circle:](../api/examples/#playerhitpoints "Player: hitPoints Example") | Read-Write |
| `maxHitPoints` | Number | Maximum amount of hitpoints. [:fontawesome-solid-info-circle:](../api/examples/#playermaxhitpoints "Player: maxHitPoints Example") | Read-Write |
| `kills` | Integer | The number of times the player has killed another player. [:fontawesome-solid-info-circle:](../api/examples/#playerkills "Player: kills Example") | Read-Write |
| `deaths` | Integer | The number of times the player has died. [:fontawesome-solid-info-circle:](../api/examples/#playerdeaths "Player: deaths Example") | Read-Write |
| `stepHeight` | Number | Maximum height in centimeters the Player can step up. Range is 0-100. Default = 45. [:fontawesome-solid-info-circle:](../api/examples/#playerstepheight "Player: stepHeight Example") | Read-Write |
| `maxWalkSpeed` | Number | Maximum speed while the player is on the ground. Clients can only read. Default = 640. [:fontawesome-solid-info-circle:](../api/examples/#playermaxwalkspeed "Player: maxWalkSpeed Example") | Read-Write |
| `maxAcceleration` | Number | Max Acceleration (rate of change of velocity). Clients can only read. Default = 1800. [:fontawesome-solid-info-circle:](../api/examples/#playermaxacceleration "Player: maxAcceleration Example") | Read-Write |
| `brakingDecelerationFalling` | Number | Deceleration when falling and not applying acceleration. Default = 0. [:fontawesome-solid-info-circle:](../api/examples/#playerbrakingdecelerationfalling "Player: brakingDecelerationFalling Example") | Read-Write |
| `brakingDecelerationWalking` | Number | Deceleration when walking and movement input has stopped. Default = 1000. [:fontawesome-solid-info-circle:](../api/examples/#playerbrakingdecelerationwalking "Player: brakingDecelerationWalking Example") | Read-Write |
| `groundFriction` | Number | Friction when walking on ground. Default = 8.0 [:fontawesome-solid-info-circle:](../api/examples/#playergroundfriction "Player: groundFriction Example") | Read-Write |
| `brakingFrictionFactor` | Number | Multiplier for friction when braking. Default = 0.6. [:fontawesome-solid-info-circle:](../api/examples/#playerbrakingfrictionfactor "Player: brakingFrictionFactor Example") | Read-Write |
| `walkableFloorAngle` | Number | Max walkable floor angle, in degrees. Clients can only read. Default = 44. [:fontawesome-solid-info-circle:](../api/examples/#playerwalkablefloorangle "Player: walkableFloorAngle Example") | Read-Write |
| `maxJumpCount` | Integer | Max number of jumps, to enable multiple jumps. Set to 0 to disable jumping. [:fontawesome-solid-info-circle:](../api/examples/#playermaxjumpcount "Player: maxJumpCount Example") | Read-Write |
| `jumpVelocity` | Number | Vertical speed applied to Player when they jump. Default = 900. [:fontawesome-solid-info-circle:](../api/examples/#playerjumpvelocity "Player: jumpVelocity Example") | Read-Write |
| `gravityScale` | Number | Multiplier on gravity applied. Default = 1.9. [:fontawesome-solid-info-circle:](../api/examples/#playergravityscale "Player: gravityScale Example") | Read-Write |
| `maxSwimSpeed` | Number | Maximum speed while the player is swimming. Default = 420. [:fontawesome-solid-info-circle:](../api/examples/#playermaxswimspeed "Player: maxSwimSpeed Example") | Read-Write |
| `touchForceFactor` | Number | Force applied to physics objects when contacted with a Player. Default = 1. [:fontawesome-solid-info-circle:](../api/examples/#playertouchforcefactor "Player: touchForceFactor Example") | Read-Write |
| `isCrouchEnabled` | bool | Turns crouching on/off for a Player. [:fontawesome-solid-info-circle:](../api/examples/#playeriscrouchenabled "Player: isCrouchEnabled Example") | Read-Write |
| `mass` | Number | Gets the mass of the Player. [:fontawesome-solid-info-circle:](../api/examples/#playermass "Player: mass Example") | Read-Only |
| `isAccelerating` | bool | True if the Player is accelerating, such as from input to move. [:fontawesome-solid-info-circle:](../api/examples/#playerisaccelerating "Player: isAccelerating Example") | Read-Only |
| `isCrouching` | bool | True if the Player is crouching. [:fontawesome-solid-info-circle:](../api/examples/#playeriscrouching "Player: isCrouching Example") | Read-Only |
| `isFlying` | bool | True if the Player is flying. [:fontawesome-solid-info-circle:](../api/examples/#playerisflying "Player: isFlying Example") | Read-Only |
| `isGrounded` | bool | True if the Player is on the ground with no upward velocity, otherwise false. [:fontawesome-solid-info-circle:](../api/examples/#playerisgrounded "Player: isGrounded Example") | Read-Only |
| `isJumping` | bool | True if the Player is jumping. [:fontawesome-solid-info-circle:](../api/examples/#playerisjumping "Player: isJumping Example") | Read-Only |
| `isMounted` | bool | True if the Player is mounted on another object. [:fontawesome-solid-info-circle:](../api/examples/#playerismounted "Player: isMounted Example") | Read-Only |
| `isSwimming` | bool | True if the Player is swimming in water. [:fontawesome-solid-info-circle:](../api/examples/#playerisswimming "Player: isSwimming Example") | Read-Only |
| `isWalking` | bool | True if the Player is in walking mode. [:fontawesome-solid-info-circle:](../api/examples/#playeriswalking "Player: isWalking Example") | Read-Only |
| `isDead` | bool | True if the Player is dead, otherwise false. [:fontawesome-solid-info-circle:](../api/examples/#playerisdead "Player: isDead Example") | Read-Only |
| `movementControlMode` | MovementControlMode | Specify how players control their movement. Clients can only read. Default: MovementControlMode.LOOK_RELATIVE. MovementControlMode.NONE: Movement input is ignored. MovementControlMode.LOOK_RELATIVE: Forward movement follows the current player's look direction. MovementControlMode.VIEW_RELATIVE: Forward movement follows the current view's look direction. MovementControlMode.FACING_RELATIVE: Forward movement follows the current player's facing direction. MovementControlMode.FIXED_AXES: Movement axis are fixed. [:fontawesome-solid-info-circle:](../api/examples/#playermovementcontrolmode "Player: movementControlMode Example") | Read-Write |
| `lookControlMode` | LookControlMode | Specify how players control their look direction. Default: LookControlMode.RELATIVE. LookControlMode.NONE: Look input is ignored. LookControlMode.RELATIVE: Look input controls the current look direction. LookControlMode.LOOK_AT_CURSOR: Look input is ignored. The player's look direction is determined by drawing a line from the player to the cursor on the Cursor Plane. [:fontawesome-solid-info-circle:](../api/examples/#playerlookcontrolmode "Player: lookControlMode Example") | Read-Write |
| `lookSensitivity` | Number | Multiplier on the Player look rotation speed relative to cursor movement. This is independent from user's preferences, both will be applied as multipliers together. Default = 1.0. [:fontawesome-solid-info-circle:](../api/examples/#playerlooksensitivity "Player: lookSensitivity Example") | Client-Only, Read-Write |
| `spreadModifier` | Number | Modifier added to the Player's targeting spread. [:fontawesome-solid-info-circle:](../api/examples/#playerspreadmodifier "Player: spreadModifier Example") | Read-Write |
| `currentSpread` | Number | Gets the Player's current targeting spread. [:fontawesome-solid-info-circle:](../api/examples/#playercurrentspread "Player: currentSpread Example") | Client-Only, Read-Only |
| `buoyancy` | Number | In water, buoyancy 1.0 is neutral (won't sink or float naturally). Less than 1 to sink, greater than 1 to float. [:fontawesome-solid-info-circle:](../api/examples/#playerbuoyancy "Player: buoyancy Example") | Read-Write |
| `canMount` | bool | Returns whether the Player can manually toggle on/off the mount. [:fontawesome-solid-info-circle:](../api/examples/#playercanmount "Player: canMount Example") | Server-Only, Read-Write |
| `shouldDismountWhenDamaged` | bool | If `true`, and the Player is mounted they will dismount if they take damage. [:fontawesome-solid-info-circle:](../api/examples/#playershoulddismountwhendamaged "Player: shouldDismountWhenDamaged Example") | Server-Only, Read-Write |
| `isVisibleToSelf` | bool | Set whether to hide the Player model on Player's own client, for sniper scope, etc. [:fontawesome-solid-info-circle:](../api/examples/#playerisvisibletoself "Player: isVisibleToSelf Example") | Client-Only, Read-Write |

### PlayerSettings

Settings that can be applied to a Player.

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `ApplyToPlayer(Player)` | None | Apply settings from this settings object to Player. | Server-Only |

### PlayerStart

PlayerStart is a CoreObject representing a spawn point for players.

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `team` | Integer | Determines which players are eligible to spawn/respawn at this point. | Server-Only, Read-Write, Dynamic |

### PointLight

PointLight is a placeable light source that is a CoreObject.

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `hasNaturalFalloff` | bool | The attenuation method of the light. When enabled, `attenuationRadius` is used. When disabled, `falloffExponent` is used. Also changes the interpretation of the intensity property, see intensity for details. | Read-Write, Dynamic |
| `falloffExponent` | Number | Controls the radial falloff of the light when `hasNaturalFalloff` is false. 2.0 is almost linear and very unrealistic and around 8.0 it looks reasonable. With large exponents, the light has contribution to only a small area of its influence radius but still costs the same as low exponents. | Read-Write, Dynamic |
| `sourceRadius` | Number | Radius of light source shape. | Read-Write, Dynamic |
| `sourceLength` | Number | Length of light source shape. | Read-Write, Dynamic |

### Projectile

Projectile is a specialized Object which moves through the air in a parabolic shape and impacts other objects. To spawn a Projectile, use `Projectile.Spawn()`.

| Class Function | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `Projectile.Spawn(string childTemplateId, Vector3 startPosition, Vector3 direction)` | Projectile | Spawns a Projectile with a child that is an instance of a template. [:fontawesome-solid-info-circle:](../api/examples/#projectilespawn "Projectile: Spawn Example") | None |

| Event | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `impactEvent` | Event&lt;Projectile, Object other, HitResult&gt; | Fired when the Projectile collides with something. Impacted object parameter will be either of type `CoreObject` or `Player`, but can also be `nil`. The HitResult describes the point of contact between the Projectile and the impacted object. [:fontawesome-solid-info-circle:](../api/examples/#projectileimpactevent "Projectile: impactEvent Example") | None |
| `lifeSpanEndedEvent` | Event&lt;Projectile&gt; | Fired when the Projectile reaches the end of its lifespan. Fired before it is destroyed. [:fontawesome-solid-info-circle:](../api/examples/#projectilelifespanendedevent "Projectile: lifeSpanEndedEvent Example") | None |
| `homingFailedEvent` | Event&lt;Projectile&gt; | Fired when the target is no longer valid, for example the Player disconnected from the game or the object was destroyed somehow. [:fontawesome-solid-info-circle:](../api/examples/#projectilehomingfailedevent "Projectile: homingFailedEvent Example") | None |

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Destroy()` | Object | Immediately destroys the object. [:fontawesome-solid-info-circle:](../api/examples/#projectiledestroy "Projectile: Destroy Example") | None |
| `GetWorldTransform()` | Transform | Transform data for the Projectile in world space. [:fontawesome-solid-info-circle:](../api/examples/#projectilegetworldtransform "Projectile: GetWorldTransform Example") | None |
| `GetWorldPosition()` | Vector3 | Position of the Projectile in world space. [:fontawesome-solid-info-circle:](../api/examples/#projectilegetworldposition "Projectile: GetWorldPosition Example") | None |
| `SetWorldPosition(Vector3)` | None | Position of the Projectile in world space. | None |
| `GetVelocity()` | Vector3 | Current direction and speed vector of the Projectile. [:fontawesome-solid-info-circle:](../api/examples/#projectilegetvelocity "Projectile: GetVelocity Example") | None |
| `SetVelocity(Vector3)` | None | Current direction and speed vector of the Projectile. [:fontawesome-solid-info-circle:](../api/examples/#projectilesetvelocity "Projectile: SetVelocity Example") | None |

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `owner` | Player | The Player who fired this Projectile. Setting this property ensures the Projectile does not impact the owner or their allies. This will also change the color of the Projectile if teams are being used in the game. [:fontawesome-solid-info-circle:](../api/examples/#projectileowner "Projectile: owner Example") | Read-Write |
| `sourceAbility` | Ability | Reference to the Ability from which the Projectile was created. [:fontawesome-solid-info-circle:](../api/examples/#projectilesourceability "Projectile: sourceAbility Example") | Read-Write |
| `speed` | Number | Centimeters per second movement. Default 5000. [:fontawesome-solid-info-circle:](../api/examples/#projectilespeed "Projectile: speed Example") | Read-Write |
| `maxSpeed` | Number | Max cm/s. Default 0. Zero means no limit. [:fontawesome-solid-info-circle:](../api/examples/#projectilemaxspeed "Projectile: maxSpeed Example") | Read-Write |
| `gravityScale` | Number | How much drop. Default 1. 1 means normal gravity. Zero can be used to make a Projectile go in a straight line. [:fontawesome-solid-info-circle:](../api/examples/#projectilegravityscale "Projectile: gravityScale Example") | Read-Write |
| `drag` | Number | Deceleration. Important for homing Projectiles (try a value around 5). Negative drag will cause the Projectile to accelerate. Default 0. [:fontawesome-solid-info-circle:](../api/examples/#projectiledrag "Projectile: drag Example") | Read-Write |
| `bouncesRemaining` | Integer | Number of bounces remaining before it dies. Default 0. [:fontawesome-solid-info-circle:](../api/examples/#projectilebouncesremaining "Projectile: bouncesRemaining Example") | Read-Write |
| `bounciness` | Number | Velocity % maintained after a bounce. Default 0.6. [:fontawesome-solid-info-circle:](../api/examples/#projectilebounciness "Projectile: bounciness Example") | Read-Write |
| `lifeSpan` | Number | Max seconds the Projectile will exist. Default 10. [:fontawesome-solid-info-circle:](../api/examples/#projectilelifespan "Projectile: lifeSpan Example") | Read-Write |
| `shouldBounceOnPlayers` | bool | Determines if the Projectile should bounce off players or be destroyed, when bouncesRemaining is used. Default false. [:fontawesome-solid-info-circle:](../api/examples/#projectileshouldbounceonplayers "Projectile: shouldBounceOnPlayers Example") | Read-Write |
| `piercesRemaining` | Integer | Number of objects that will be pierced before it dies. A piercing Projectile loses no velocity when going through objects, but still fires the impactEvent event. If combined with bounces, all piercesRemaining are spent before bouncesRemaining are counted. Default 0. [:fontawesome-solid-info-circle:](../api/examples/#projectilepiercesremaining "Projectile: piercesRemaining Example") | Read-Write |
| `capsuleRadius` | Number | Shape of the Projectile's collision. Default 22. [:fontawesome-solid-info-circle:](../api/examples/#projectilecapsuleradius "Projectile: capsuleRadius Example") | Read-Write |
| `capsuleLength` | Number | Shape of the Projectile's collision. A value of zero will make it shaped like a Sphere. Default 44. [:fontawesome-solid-info-circle:](../api/examples/#projectilecapsulelength "Projectile: capsuleLength Example") | Read-Write |
| `homingTarget` | CoreObject | The projectile accelerates towards its target. Homing targets are meant to be used with spawned projectiles and will not work with weapons. [:fontawesome-solid-info-circle:](../api/examples/#projectilehomingtarget "Projectile: homingTarget Example") | Read-Write |
| `homingAcceleration` | Number | Magnitude of acceleration towards the target. Default 10,000. [:fontawesome-solid-info-circle:](../api/examples/#projectilehomingacceleration "Projectile: homingAcceleration Example") | Read-Write |
| `shouldDieOnImpact` | bool | If `true`, the Projectile is automatically destroyed when it hits something, unless it has bounces remaining. Default true. [:fontawesome-solid-info-circle:](../api/examples/#projectileshoulddieonimpact "Projectile: shouldDieOnImpact Example") | Read-Write |

### Quaternion

A quaternion-based representation of a rotation.

| Class Function | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `Quaternion.Slerp(Quaternion from, Quaternion to, Number progress)` | Quaternion | Spherical interpolation between two quaternions by the specified progress amount and returns the resultant, normalized Quaternion. [:fontawesome-solid-info-circle:](../api/examples/#quaternionslerp "Quaternion: Slerp Example") | None |

| Constructor | Return Type | Description | Tags |
| ----------- | ----------- | ----------- | ---- |
| `Quaternion.New([Number x, Number y, Number z, Number w])` | Quaternion | Constructs a Quaternion with the given values.  Defaults to 0, 0, 0, 1. [:fontawesome-solid-info-circle:](../api/examples/#quaternionnew "Quaternion: New Example") | None |
| `Quaternion.New(Rotation r)` | Quaternion | Constructs a Quaternion with the given Rotation. [:fontawesome-solid-info-circle:](../api/examples/#quaternionnew "Quaternion: New Example") | None |
| `Quaternion.New(Vector3 axis, Number angle)` | Quaternion | Constructs a Quaternion representing a rotation of angle degrees around the axis of the Vector3. [:fontawesome-solid-info-circle:](../api/examples/#quaternionnew "Quaternion: New Example") | None |
| `Quaternion.New(Vector3 from, Vector3 to)` | Quaternion | Constructs a Quaternion between the `from` and `to` of the Vector3s. [:fontawesome-solid-info-circle:](../api/examples/#quaternionnew "Quaternion: New Example") | None |
| `Quaternion.New(Quaternion q)` | Quaternion | Copies the given Quaternion. [:fontawesome-solid-info-circle:](../api/examples/#quaternionnew "Quaternion: New Example") | None |
| `Quaternion.IDENTITY` | Quaternion | Predefined Quaternion with no rotation. [:fontawesome-solid-info-circle:](../api/examples/#quaternionidentity "Quaternion: IDENTITY Example") | None |

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetRotation()` | Rotation | Get the Rotation representation of the Quaternion. [:fontawesome-solid-info-circle:](../api/examples/#quaterniongetrotation "Quaternion: GetRotation Example") | None |
| `GetForwardVector()` | Vector3 | Forward unit vector rotated by the quaternion. [:fontawesome-solid-info-circle:](../api/examples/#quaterniongetforwardvector "Quaternion: GetForwardVector Example") | None |
| `GetRightVector()` | Vector3 | Right unit vector rotated by the quaternion. [:fontawesome-solid-info-circle:](../api/examples/#quaterniongetrightvector "Quaternion: GetRightVector Example") | None |
| `GetUpVector()` | Vector3 | Up unit vector rotated by the quaternion. [:fontawesome-solid-info-circle:](../api/examples/#quaterniongetupvector "Quaternion: GetUpVector Example") | None |

| Operator | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Quaternion + Quaternion` | Quaternion | Component-wise addition. | None |
| `Quaternion - Quaternion` | Quaternion | Component-wise subtraction. | None |
| `Quaternion * Quaternion` | Quaternion | Compose two quaternions, with the result applying the right rotation first, then the left rotation second. [:fontawesome-solid-info-circle:](../api/examples/#quaternionquaternion*quaternion "Quaternion: Quaternion*Quaternion Example") | None |
| `Quaternion * Number` | Quaternion | Multiplies each component by the right-side Number. | None |
| `Quaternion * Vector3` | Vector3 | Rotates the right-side vector and returns the result. [:fontawesome-solid-info-circle:](../api/examples/#quaternionquaternion*vector3 "Quaternion: Quaternion*Vector3 Example") | None |
| `Quaternion / Number` | Quaternion | Divides each component by the right-side Number. | None |
| `-Quaternion` | Quaternion | Returns the inverse rotation. [:fontawesome-solid-info-circle:](../api/examples/#quaternion-quaternion "Quaternion: -Quaternion Example") | None |

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `x` | Number | The `x` component of the Quaternion. [:fontawesome-solid-info-circle:](../api/examples/#quaternionx "Quaternion: x Example") | Read-Write |
| `y` | Number | The `y` component of the Quaternion. [:fontawesome-solid-info-circle:](../api/examples/#quaterniony "Quaternion: y Example") | Read-Write |
| `z` | Number | The `z` component of the Quaternion. [:fontawesome-solid-info-circle:](../api/examples/#quaternionz "Quaternion: z Example") | Read-Write |
| `w` | Number | The `w` component of the Quaternion. [:fontawesome-solid-info-circle:](../api/examples/#quaternionw "Quaternion: w Example") | Read-Write |

### RandomStream

Seed-based random stream of numbers. Useful for deterministic RNG problems, for instance, inside a Client Context so all players get the same outcome without the need to replicate lots of data from the server. Bad quality in the lower bits (avoid combining with modulus operations).

| Constructor | Return Type | Description | Tags |
| ----------- | ----------- | ----------- | ---- |
| `RandomStream.New([Integer seed])` | RandomStream | Constructor with specified seed, defaults to a random value. | None |

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetInitialSeed()` | Integer | The seed that was used to initialize this stream. | None |
| `Reset()` | None | Function that sets the seed back to the initial seed. | None |
| `Mutate()` | None | Moves the seed forward to the next seed. | None |
| `GetNumber([Number min, Number max])` | Number | Returns a floating point number between `min` and `max` (inclusive), defaults to `0` and `1` (exclusive). | None |
| `GetInteger(Integer min, Integer max)` | Number | Returns an integer number between `min` and `max` (inclusive). | None |
| `GetVector3()` | Vector3 | Returns a random unit vector. | None |
| `GetVector3FromCone(Vector3 direction, Number halfAngle)` | Vector3 | Returns a random unit vector, uniformly distributed, from inside a cone defined by `direction` and `halfAngle` (in degrees). | None |
| `GetVector3FromCone(Vector3 direction, Number horizontalHalfAngle, Number verticalHalfAngle)` | Vector3 | Returns a random unit vector, uniformly distributed, from inside a cone defined by `direction`, `horizontalHalfAngle` and `verticalHalfAngle` (in degrees). | None |

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `seed` | Integer | The current seed used for RNG. | Read-Write |

### Rotation

An euler-based rotation around `x`, `y`, and `z` axes.

| Constructor | Return Type | Description | Tags |
| ----------- | ----------- | ----------- | ---- |
| `Rotation.New([Number x, Number y, Number z])` | Rotation | Construct a rotation with the given values, defaults to (0, 0, 0). [:fontawesome-solid-info-circle:](../api/examples/#rotationnew "Rotation: New Example") | None |
| `Rotation.New(Quaternion q)` | Rotation | Construct a rotation using the given Quaternion. [:fontawesome-solid-info-circle:](../api/examples/#rotationnew "Rotation: New Example") | None |
| `Rotation.New(Vector3 forward, Vector3 up)` | Rotation | Construct a rotation that will rotate Vector3.FORWARD to point in the direction of the given forward vector, with the up vector as a reference. Returns (0, 0, 0) if forward and up point in the exact same (or opposite) direction, or if one of them is of length 0. [:fontawesome-solid-info-circle:](../api/examples/#rotationnew "Rotation: New Example") | None |
| `Rotation.New(Rotation r)` | Rotation | Copies the given Rotation. [:fontawesome-solid-info-circle:](../api/examples/#rotationnew "Rotation: New Example") | None |
| `Rotation.ZERO` | Rotation | Constant Rotation of (0, 0, 0). [:fontawesome-solid-info-circle:](../api/examples/#rotationzero "Rotation: ZERO Example") | None |

| Operator | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Rotation + Rotation` | Rotation | Add two rotations together. [:fontawesome-solid-info-circle:](../api/examples/#rotationrotation+rotation "Rotation: Rotation+Rotation Example") | None |
| `Rotation - Rotation` | Rotation | Subtract a rotation. [:fontawesome-solid-info-circle:](../api/examples/#rotationrotation-rotation "Rotation: Rotation-Rotation Example") | None |
| `Rotation * Number` | Rotation | Returns the scaled rotation. [:fontawesome-solid-info-circle:](../api/examples/#rotationrotation*number "Rotation: Rotation*Number Example") | None |
| `-Rotation` | Rotation | Returns the inverse rotation. [:fontawesome-solid-info-circle:](../api/examples/#rotation-rotation "Rotation: -Rotation Example") | None |
| `Rotation * Vector3` | Vector3 | Rotates the right-side vector and returns the result. [:fontawesome-solid-info-circle:](../api/examples/#rotationrotation*vector3 "Rotation: Rotation*Vector3 Example") | None |

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `x` | Number | The `x` component of the Rotation. [:fontawesome-solid-info-circle:](../api/examples/#rotationx "Rotation: x Example") | Read-Write |
| `y` | Number | The `y` component of the Rotation. [:fontawesome-solid-info-circle:](../api/examples/#rotationy "Rotation: y Example") | Read-Write |
| `z` | Number | The `z` component of the Rotation. [:fontawesome-solid-info-circle:](../api/examples/#rotationz "Rotation: z Example") | Read-Write |

### Script

Script is a CoreObject representing a script in the hierarchy. While not technically a property, a script can access itself using the `script` variable.

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `context` | table | Returns the table containing any non-local variables and functions created by the script. This can be used to call (or overwrite!) functions on another script. [:fontawesome-solid-info-circle:](../api/examples/#scriptcontext "Script: context Example") | Read-Only |

### ScriptAsset

ScriptAsset is an Object representing a script asset in Project Content. When a script is executed from a call to `require()`, it can access the script asset using the `script` variable. This can be used to read custom properties from the script asset.

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetCustomProperties()` | table | Returns a table containing the names and values of all custom properties on the script asset. | None |
| `GetCustomProperty(string propertyName)` | value, bool | Gets an individual custom property from the script asset. Returns the value, which can be an Integer, Number, bool, string, Vector3, Rotator, Color, a MUID string, or nil if not found. Second return value is a bool, true if found and false if not. | None |

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `name` | string | The name of the script in Project Content. | Read-Only |
| `id` | string | The script asset's MUID. | Read-Only |

### SmartAudio

SmartAudio objects are SmartObjects that wrap sound files. Similar to Audio objects, they have many of the same properties and functions.

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Play()` | None | Begins sound playback. | Dynamic |
| `Stop()` | None | Stops sound playback. | Dynamic |
| `FadeIn(Number time)` | None | Starts playing and fades in the sound over the given time. | Dynamic |
| `FadeOut(Number time)` | None | Fades the sound out and stops over time seconds. | Dynamic |

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `isPlaying` | bool | Returns if the sound is currently playing. | Read-Only |
| `isSpatializationEnabled` | bool | Default true. Set to false to play sound without 3D positioning. | Read-Write, Dynamic |
| `isAttenuationEnabled` | bool | Default true, meaning sounds will fade with distance. | Read-Write, Dynamic |
| `isOcclusionEnabled` | bool | Default true. Changes attenuation if there is geometry between the player and the audio source. | Read-Write, Dynamic |
| `isAutoPlayEnabled` | bool | Default false. If set to true when placed in the editor (or included in a template), the sound will be automatically played when loaded. | Read-Only |
| `isTransient` | bool | Default false. If set to true, the sound will automatically destroy itself after it finishes playing. | Read-Write, Dynamic |
| `isAutoRepeatEnabled` | bool | Loops when playback has finished. Some sounds are designed to automatically loop, this flag will force others that don't. Useful for looping music. | Read-Write, Dynamic |
| `pitch` | Number | Default 1. Multiplies the playback pitch of a sound. Note that some sounds have clamped pitch ranges (0.2 to 1). | Read-Write, Dynamic |
| `volume` | Number | Default 1. Multiplies the playback volume of a sound. Note that values above 1 can distort sound, so if you're trying to balance sounds, experiment to see if scaling down works better than scaling up. | Read-Write, Dynamic |
| `radius` | Number | Default 0. If non-zero, will override default 3D spatial parameters of the sound. Radius is the distance away from the sound position that will be played at 100% volume. | Read-Write, Dynamic |
| `falloff` | Number | Default 0. If non-zero, will override default 3D spatial parameters of the sound. Falloff is the distance outside the radius over which the sound volume will gradually fall to zero. | Read-Write, Dynamic |
| `fadeInTime` | Number | Sets the fade in time for the audio.  When the audio is played, it will start at zero volume, and fade in over this many seconds. | Read-Write, Dynamic |
| `fadeOutTime` | Number | Sets the fadeout time of the audio.  When the audio is stopped, it will keep playing for this many seconds, as it fades out. | Read-Write, Dynamic |
| `startTime` | Number | The start time of the audio track. Default is 0. Setting this to anything else means that the audio will skip ahead that many seconds when played. | Read-Write, Dynamic |

### SmartObject

SmartObject is a top-level container for some complex objects and inherits everything from CoreObject. Note that some properties, such as `collision` or `visibility`, may not be respected by a SmartObject.

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetSmartProperties()` | table | Returns a table containing the names and values of all smart properties on a SmartObject. | None |
| `GetSmartProperty(string)` | value, bool | Given a property name, returns the current value of that property on a SmartObject. Returns the value, which can be an Integer, Number, bool, string, Vector3, Rotator, Color, or nil if not found. Second return value is a bool, true if the property was found and false if not. | None |
| `SetSmartProperty(string, value)` | bool | Sets the value of an exposed property. Value can be of type Number, bool, string, Vector3, Rotation or Color, but must match the type of the property. Returns true if the property was set successfully and false if not. | Dynamic |

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `team` | Integer | Assigns the SmartObject to a team. Value range from 0 to 4. 0 is neutral team. | Read-Write, Dynamic |
| `isTeamColorUsed` | bool | If `true`, and the SmartObject has been assigned to a valid team, players on that team will see one color, while other players will see another color. Requires a SmartObject that supports team colors. | Read-Write, Dynamic |

### SpotLight

SpotLight is a Light that shines in a specific direction from the location at which it is placed.

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `hasNaturalFalloff` | bool | The attenuation method of the light. When enabled, `attenuationRadius` is used. When disabled, `falloffExponent` is used. Also changes the interpretation of the intensity property, see intensity for details. | Read-Write, Dynamic |
| `falloffExponent` | Number | Controls the radial falloff of the light when `hasNaturalFalloff` is false. 2.0 is almost linear and very unrealistic and around 8.0 it looks reasonable. With large exponents, the light has contribution to only a small area of its influence radius but still costs the same as low exponents. | Read-Write, Dynamic |
| `sourceRadius` | Number | Radius of light source shape. | Read-Write, Dynamic |
| `sourceLength` | Number | Length of light source shape. | Read-Write, Dynamic |
| `innerConeAngle` | Number | The angle (in degrees) of the cone within which the projected light achieves full brightness. | Read-Write, Dynamic |
| `outerConeAngle` | Number | The outer angle (in degrees) of the cone of light emitted by this SpotLight. | Read-Write, Dynamic |

### StaticMesh

StaticMesh is a static CoreMesh. StaticMeshes can be placed in the scene and (if networked or client-only) moved at runtime, but the mesh itself cannot be animated. See AnimatedMesh for meshes with animations.

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `isSimulatingDebrisPhysics` | bool | If `true`, physics will be enabled for the mesh. [:fontawesome-solid-info-circle:](../api/examples/#staticmeshissimulatingdebrisphysics "Staticmesh: isSimulatingDebrisPhysics Example") | Client-Only, Read-Write, Dynamic |

### Task

Task is a representation of a Lua thread. It could be a Script initialization, a repeating `Tick()` function from a Script, an EventListener invocation, or a Task spawned directly by a call to `Task.Spawn()`.

| Class Function | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `Task.Spawn(function taskFunction, [Number delay])` | Task | Creates a new Task which will call taskFunction without blocking the current task. The optional delay parameter specifies how many seconds before the task scheduler should run the Task. By default, the scheduler will run the Task at the end of the current frame. [:fontawesome-solid-info-circle:](../api/examples/#taskspawn "Task: Spawn Example") | None |
| `Task.GetCurrent()` | Task | Returns the currently running Task. [:fontawesome-solid-info-circle:](../api/examples/#taskgetcurrent "Task: GetCurrent Example") | None |
| `Task.Wait([Number delay])` | Number, Number | Yields the current Task, resuming in delay seconds, or during the next frame if delay is not specified. Returns the amount of time that was actually waited, as well as how long a wait was requested. [:fontawesome-solid-info-circle:](../api/examples/#taskwait "Task: Wait Example") | None |

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Cancel()` | None | Cancels the Task immediately. It will no longer be executed, regardless of the state it was in. If called on the currently executing Task, that Task will halt execution. [:fontawesome-solid-info-circle:](../api/examples/#taskcancel "Task: Cancel Example") | None |
| `GetStatus()` | TaskStatus | Returns the status of the Task. Possible values include: TaskStatus.UNINITIALIZED, TaskStatus.SCHEDULED, TaskStatus.RUNNING, TaskStatus.COMPLETED, TaskStatus.YIELDED, TaskStatus.FAILED, TaskStatus.CANCELED. [:fontawesome-solid-info-circle:](../api/examples/#taskgetstatus "Task: GetStatus Example") | None |

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `id` | Number | A unique identifier for the task. [:fontawesome-solid-info-circle:](../api/examples/#taskid "Task: id Example") | Read-Only |
| `repeatCount` | Number | If set to a non-negative number, the Task will execute that many times. A negative number indicates the Task should repeat indefinitely (until otherwise canceled). With the default of 0, the Task will execute once. With a value of 1, the script will repeat once, meaning it will execute twice. [:fontawesome-solid-info-circle:](../api/examples/#taskrepeatcount "Task: repeatCount Example") | Read-Write |
| `repeatInterval` | Number | For repeating Tasks, the number of seconds to wait after the Task completes before running it again. If set to 0, the Task will wait until the next frame. [:fontawesome-solid-info-circle:](../api/examples/#taskrepeatinterval "Task: repeatInterval Example") | Read-Write |

### Terrain

Terrain is a CoreObject representing terrain placed in the world.

### Transform

Transforms represent the position, rotation, and scale of objects in the game. They are immutable, but new Transforms can be created when you want to change an object's Transform.

| Constructor | Return Type | Description | Tags |
| ----------- | ----------- | ----------- | ---- |
| `Transform.New()` | Transform | Constructs a new identity Transform. | None |
| `Transform.New(Quaternion rotation, Vector3 position, Vector3 scale)` | Transform | Constructs a new Transform with a Quaternion. | None |
| `Transform.New(Rotation rotation, Vector3 position, Vector3 scale)` | Transform | Constructs a new Transform with a Rotation. | None |
| `Transform.New(Vector3 x_axis, Vector3 y_axis, Vector3 z_axis, Vector3 translation)` | Transform | Constructs a new Transform from a Matrix. | None |
| `Transform.New(Transform transform)` | Transform | Copies the given Transform. | None |
| `Transform.IDENTITY` | Transform | Constant identity Transform. | None |

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetPosition()` | Vector3 | Returns a copy of the position component of the Transform. | None |
| `SetPosition(Vector3)` | None | Sets the position component of the Transform. | None |
| `GetRotation()` | Rotation | Returns a copy of the Rotation component of the Transform. | None |
| `SetRotation(Rotation)` | None | Sets the rotation component of the Transform. | None |
| `GetQuaternion()` | Quaternion | Returns a quaternion-based representation of the Rotation. | None |
| `SetQuaternion(Quaternion)` | None | Sets the quaternion-based representation of the Rotation. | None |
| `GetScale()` | Vector3 | Returns a copy of the scale component of the Transform. | None |
| `SetScale(Vector3)` | None | Sets the scale component of the Transform. | None |
| `GetForwardVector()` | Vector3 | Forward vector of the Transform. | None |
| `GetRightVector()` | Vector3 | Right vector of the Transform. | None |
| `GetUpVector()` | Vector3 | Up vector of the Transform. | None |
| `GetInverse()` | Transform | Inverse of the Transform. | None |
| `TransformPosition(Vector3 position)` | Vector3 | Applies the Transform to the given position in 3D space. | None |
| `TransformDirection(Vector3 direction)` | Vector3 | Applies the Transform to the given directional Vector3. This will rotate and scale the Vector3, but does not apply the Transform's position. | None |

| Operator | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Transform * Transform` | Transform | Returns a new Transform composing the left and right Transforms. | None |
| `Transform * Quaternion` | Transform | Returns a new Transform composing the left Transform then the right side rotation. | None |

### Trigger

A trigger is an invisible and non-colliding CoreObject which fires events when it interacts with another object (e.g. A Player walks into it):

| Event | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `beginOverlapEvent` | Event&lt;Trigger trigger, Object other&gt; | Fired when an object enters the Trigger volume. The first parameter is the Trigger itself. The second is the object overlapping the Trigger, which may be a CoreObject, a Player, or some other type. Call `other:IsA()` to check the type. [:fontawesome-solid-info-circle:](../api/examples/#triggerbeginoverlapevent "Trigger: beginOverlapEvent Example") | None |
| `endOverlapEvent` | Event&lt;Trigger trigger, Object other&gt; | Fired when an object exits the Trigger volume. Parameters the same as `beginOverlapEvent.` [:fontawesome-solid-info-circle:](../api/examples/#triggerendoverlapevent "Trigger: endOverlapEvent Example") | None |
| `interactedEvent` | Event&lt;Trigger trigger, Player&gt; | Fired when a player uses the interaction on a trigger volume (<kbd>F</kbd> key). The first parameter is the Trigger itself and the second parameter is a Player. [:fontawesome-solid-info-circle:](../api/examples/#triggerinteractedevent "Trigger: interactedEvent Example") | None |

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `IsOverlapping(CoreObject)` | bool | Returns true if given CoreObject overlaps with the Trigger. [:fontawesome-solid-info-circle:](../api/examples/#triggerisoverlapping "Trigger: IsOverlapping Example") | None |
| `IsOverlapping(Player)` | bool | Returns true if given player overlaps with the Trigger. [:fontawesome-solid-info-circle:](../api/examples/#triggerisoverlapping "Trigger: IsOverlapping Example") | None |
| `GetOverlappingObjects()` | Array&lt;Object&gt; | Returns a list of all objects that are currently overlapping with the Trigger. [:fontawesome-solid-info-circle:](../api/examples/#triggergetoverlappingobjects "Trigger: GetOverlappingObjects Example") | None |

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `isInteractable` | bool | Interactable Triggers expect Players to walk up and press the <kbd>F</kbd> key to activate them. [:fontawesome-solid-info-circle:](../api/examples/#triggerisinteractable "Trigger: isInteractable Example") | Read-Write, Dynamic |
| `interactionLabel` | string | The text players will see in their HUD when they come into range of interacting with this trigger. [:fontawesome-solid-info-circle:](../api/examples/#triggerinteractionlabel "Trigger: interactionLabel Example") | Read-Write, Dynamic |
| `team` | Integer | Assigns the trigger to a team. Value range from 0 to 4. 0 is neutral team. [:fontawesome-solid-info-circle:](../api/examples/#triggerteam "Trigger: team Example") | Read-Write, Dynamic |
| `isTeamCollisionEnabled` | bool | If `false`, and the Trigger has been assigned to a valid team, players on that team will not overlap or interact with the Trigger. [:fontawesome-solid-info-circle:](../api/examples/#triggeristeamcollisionenabled "Trigger: isTeamCollisionEnabled Example") | Read-Write, Dynamic |
| `isEnemyCollisionEnabled` | bool | If `false`, and the Trigger has been assigned to a valid team, players on enemy teams will not overlap or interact with the Trigger. [:fontawesome-solid-info-circle:](../api/examples/#triggerisenemycollisionenabled "Trigger: isEnemyCollisionEnabled Example") | Read-Write, Dynamic |

### UIButton

A UIControl for a button, should be inside client context.

| Event | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `clickedEvent` | Event&lt;UIButton&gt; | Fired when button is clicked. This triggers on mouse-button up, if both button-down and button-up events happen inside the button hitbox. | None |
| `pressedEvent` | Event&lt;UIButton&gt; | Fired when button is pressed. (mouse button down) | None |
| `releasedEvent` | Event&lt;UIButton&gt; | Fired when button is released. (mouse button up) | None |
| `hoveredEvent` | Event&lt;UIButton&gt; | Fired when button is hovered. | None |
| `unhoveredEvent` | Event&lt;UIButton&gt; | Fired when button is unhovered. | None |

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetButtonColor()` | Color | Gets the button's default color. | None |
| `SetButtonColor(Color)` | None | Sets the button's default color. | Dynamic |
| `GetHoveredColor()` | Color | Gets the button's color when hovered. | None |
| `SetHoveredColor(Color)` | None | Sets the button's color when hovered. | Dynamic |
| `GetPressedColor()` | Color | Gets the button's color when pressed. | None |
| `SetPressedColor(Color)` | None | Sets the button's color when pressed. | Dynamic |
| `GetDisabledColor()` | Color | Gets the button's color when it's not interactable. | None |
| `SetDisabledColor(Color)` | None | Sets the button's color when it's not interactable. | Dynamic |
| `GetFontColor()` | Color | Gets the font's color. | None |
| `SetFontColor(Color)` | None | Sets the font's color. | Dynamic |
| `SetImage(string brushMUID)` | None | Sets the image to a new MUID. You can get this MUID from an Asset Reference. | Dynamic |

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `text` | string | Returns the button's label text. | Read-Write, Dynamic |
| `fontSize` | Integer | Returns the font size of the label text. | Read-Write, Dynamic |
| `isInteractable` | bool | Returns whether the Button can interact with the cursor (click, hover, etc). | Read-Write, Dynamic |

### UIContainer

A UIControl indicates which child UI elements should be rendered. Does not have a position or size (it always is the size of the entire screen).

They have no properties or functions of their own, but inherit everything from CoreObject.

### UIControl

UIControl is a CoreObject which serves as a base class for other UI controls.

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `x` | Number | Screen-space offset from the anchor. | Read-Write, Dynamic |
| `y` | Number | Screen-space offset from the anchor. | Read-Write, Dynamic |
| `width` | Number | Horizontal size of the control. | Read-Write, Dynamic |
| `height` | Number | Vertical size of the control. | Read-Write, Dynamic |
| `rotationAngle` | Number | rotation angle of the control. | Read-Write, Dynamic |

### UIImage

A UIControl for displaying an image.

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetColor()` | Color | Returns the current color of the UIImage. | None |
| `SetColor(Color)` | None | Sets the UIImage to a color. | Dynamic |
| `GetImage()` | string | Returns the imageId assigned to this UIImage control. | None |
| `SetImage(MUID imageId)` | None | Sets the UIImage to a new MUID. You can get this MUID from an Asset Reference. | Dynamic |
| `SetImage(Player)` | None | Downloads and sets a Player's profile picture as the texture for this UIImage control. | Dynamic |

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `isTeamColorUsed` | bool | If `true`, the image will be tinted blue if its team matches the Player, or red if not. | Read-Write, Dynamic |
| `team` | Integer | the team of the image, used for `isTeamColorUsed`. | Read-Write, Dynamic |

### UIPanel

A UIControl which can be used for containing and laying out other UI controls.

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `shouldClipChildren` | bool | If `true`, children of this UIPanel will not draw outside of its bounds. | Read-Write, Dynamic |

### UIProgressBar

A UIControl that displays a filled rectangle which can be used for things such as a health indicator.

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetFillColor()` | Color | Returns the color of the fill. | None |
| `SetFillColor(Color)` | None | Sets the color of the fill. | Dynamic |
| `GetBackgroundColor()` | Color | Returns the color of the background. | None |
| `SetBackgroundColor(Color)` | None | Sets the color of the background. | Dynamic |

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `progress` | Number | From 0 to 1, how full the bar should be. | Read-Write, Dynamic |

### UIScrollPanel

A UIControl that supports scrolling a child UIControl that is larger than itself.

They have no properties or functions of their own, but inherit everything from CoreObject and UIControl.

### UIText

A UIControl which displays a basic text label.

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetColor()` | Color | The color of the Text. | None |
| `SetColor(Color)` | None | The color of the Text. | Dynamic |

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `text` | string | The actual text string to show. | Read-Write, Dynamic |
| `fontSize` | Number | The font size of the UIText control. | Read-Write, Dynamic |
| `justification` | TextJustify | Determines the alignment of `text`. Possible values are: TextJustify.LEFT, TextJustify.RIGHT, and TextJustify.CENTER. | Read-Write, Dynamic |
| `shouldWrapText` | bool | Whether or not text should be wrapped within the bounds of this control. | Read-Write, Dynamic |
| `shouldClipText` | bool | Whether or not text should be clipped when exceeding the bounds of this control. | Read-Write, Dynamic |

### Vector2

A two-component vector that can represent a position or direction.

| Class Function | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `Vector2.Lerp(Vector2 from, Vector2 to, Number progress)` | Vector2 | Linearly interpolates between two vectors by the specified progress amount and returns the resultant Vector2. | None |

| Constructor | Return Type | Description | Tags |
| ----------- | ----------- | ----------- | ---- |
| `Vector2.New([Number x, Number y])` | Vector2 | Constructs a Vector2 with the given `x`, `y` values, defaults to (0, 0). | None |
| `Vector2.New(Number)` | Vector2 | Constructs a Vector2 with `x`, `y` values both set to the given value. | None |
| `Vector2.New(Vector3 v)` | Vector3 | Constructs a Vector2 with `x`, `y` values from the given Vector3. | None |
| `Vector2.New(Vector2 v)` | Vector2 | Constructs a Vector2 with `x`, `y` values from the given Vector2. | None |
| `Vector2.ZERO` | Vector2 | (0, 0) | None |
| `Vector2.ONE` | Vector2 | (1, 1) | None |

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetNormalized()` | Vector2 | Returns a new Vector2 with size 1, but still pointing in the same direction. Returns (0, 0) if the vector is too small to be normalized. | None |

| Operator | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Vector2 + Vector2` | Vector2 | Component-wise addition. | None |
| `Vector2 + Number` | Vector2 | Adds the right-side Number to each of the components in the left side and returns the resulting Vector2. | None |
| `Vector2 - Vector2` | Vector2 | Component-wise subtraction. | None |
| `Vector2 - Number` | Vector2 | Subtracts the right-side Number from each of the components in the left side and returns the resulting Vector2. | None |
| `Vector2 * Vector2` | Vector2 | Component-wise multiplication. | None |
| `Vector2 * Number` | Vector2 | Multiplies each component of the Vector2 by the right-side Number. | None |
| `Number * Vector2` | Vector2 | Multiplies each component of the Vector2 by the left-side Number. | None |
| `Vector2 / Vector2` | Vector2 | Component-wise division. | None |
| `Vector2 / Number` | Vector2 | Divides each component of the Vector2 by the right-side Number. | None |
| `-Vector2` | Vector2 | Returns the negation of the Vector2. | None |
| `Vector2 .. Vector2` | Number | Returns the dot product of the Vector2s. | None |
| `Vector2 ^ Vector2` | Vector2 | Returns the cross product of the Vector2s. | None |

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `x` | Number | The `x` component of the Vector2. | Read-Write |
| `y` | Number | The `y` component of the Vector2. | Read-Write |
| `size` | Number | The magnitude of the Vector2. | Read-Only |
| `sizeSquared` | Number | The squared magnitude of the Vector2. | Read-Only |

### Vector3

A three-component vector that can represent a position or direction.

| Class Function | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `Vector3.Lerp(Vector3 from, Vector3 to, Number progress)` | Vector3 | Linearly interpolates between two vectors by the specified progress amount and returns the resultant Vector3. [:fontawesome-solid-info-circle:](../api/examples/#vector3lerp "Vector3: Lerp Example") | None |

| Constructor | Return Type | Description | Tags |
| ----------- | ----------- | ----------- | ---- |
| `Vector3.New([Number x, Number y, Number z])` | Vector3 | Constructs a Vector3 with the given `x`, `y`, `z` values, defaults to (0, 0, 0). [:fontawesome-solid-info-circle:](../api/examples/#vector3new "Vector3: New Example") | None |
| `Vector3.New(Number v)` | Vector3 | Constructs a Vector3 with `x`, `y`, `z` values all set to the given value. [:fontawesome-solid-info-circle:](../api/examples/#vector3new "Vector3: New Example") | None |
| `Vector3.New(Vector2 xy, Number z)` | Vector3 | Constructs a Vector3 with `x`, `y` values from the given Vector2 and the given `z` value. [:fontawesome-solid-info-circle:](../api/examples/#vector3new "Vector3: New Example") | None |
| `Vector3.New(Vector3 v)` | Vector3 | Constructs a Vector3 with `x`, `y`, `z` values from the given Vector3. [:fontawesome-solid-info-circle:](../api/examples/#vector3new "Vector3: New Example") | None |
| `Vector3.New(Vector4 v)` | Vector4 | Constructs a Vector3 with `x`, `y`, `z` values from the given Vector4. [:fontawesome-solid-info-circle:](../api/examples/#vector3new "Vector3: New Example") | None |
| `Vector3.ZERO` | Vector3 | (0, 0, 0) [:fontawesome-solid-info-circle:](../api/examples/#vector3zero "Vector3: ZERO Example") | None |
| `Vector3.ONE` | Vector3 | (1, 1, 1) [:fontawesome-solid-info-circle:](../api/examples/#vector3one "Vector3: ONE Example") | None |
| `Vector3.FORWARD` | Vector3 | (1, 0, 0) [:fontawesome-solid-info-circle:](../api/examples/#vector3forward "Vector3: FORWARD Example") | None |
| `Vector3.UP` | Vector3 | (0, 0, 1) [:fontawesome-solid-info-circle:](../api/examples/#vector3up "Vector3: UP Example") | None |
| `Vector3.RIGHT` | Vector3 | (0, 1, 0) [:fontawesome-solid-info-circle:](../api/examples/#vector3right "Vector3: RIGHT Example") | None |

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetNormalized()` | Vector3 | Returns a new Vector3 with size 1, but still pointing in the same direction. Returns (0, 0, 0) if the vector is too small to be normalized. | None |

| Operator | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Vector3 + Vector3` | Vector3 | Component-wise addition. [:fontawesome-solid-info-circle:](../api/examples/#vector3vector3+vector3 "Vector3: Vector3+Vector3 Example") | None |
| `Vector3 + Number` | Vector3 | Adds the right-side Number to each of the components in the left side and returns the resulting Vector3. [:fontawesome-solid-info-circle:](../api/examples/#vector3vector3+number "Vector3: Vector3+Number Example") | None |
| `Vector3 - Vector3` | Vector3 | Component-wise subtraction. [:fontawesome-solid-info-circle:](../api/examples/#vector3vector3-vector3 "Vector3: Vector3-Vector3 Example") | None |
| `Vector3 - Number` | Vector3 | Subtracts the right-side Number from each of the components in the left side and returns the resulting Vector3. [:fontawesome-solid-info-circle:](../api/examples/#vector3vector3-number "Vector3: Vector3-Number Example") | None |
| `Vector3 * Vector3` | Vector3 | Component-wise multiplication. [:fontawesome-solid-info-circle:](../api/examples/#vector3vector3*vector3 "Vector3: Vector3*Vector3 Example") | None |
| `Vector3 * Number` | Vector3 | Multiplies each component of the Vector3 by the right-side Number. [:fontawesome-solid-info-circle:](../api/examples/#vector3vector3*number "Vector3: Vector3*Number Example") | None |
| `Number * Vector3` | Vector3 | Multiplies each component of the Vector3 by the left-side Number. [:fontawesome-solid-info-circle:](../api/examples/#vector3number*vector3 "Vector3: Number*Vector3 Example") | None |
| `Vector3 / Vector3` | Vector3 | Component-wise division. [:fontawesome-solid-info-circle:](../api/examples/#vector3vector3/vector3 "Vector3: Vector3/Vector3 Example") | None |
| `Vector3 / Number` | Vector3 | Divides each component of the Vector3 by the right-side Number. [:fontawesome-solid-info-circle:](../api/examples/#vector3vector3/number "Vector3: Vector3/Number Example") | None |
| `-Vector3` | Vector3 | Returns the negation of the Vector3. [:fontawesome-solid-info-circle:](../api/examples/#vector3-vector3 "Vector3: -Vector3 Example") | None |
| `Vector3 .. Vector3` | Number | Returns the dot product of the Vector3s. | None |
| `Vector3 ^ Vector3` | Vector3 | Returns the cross product of the Vector3s. [:fontawesome-solid-info-circle:](../api/examples/#vector3vector3^vector3 "Vector3: Vector3^Vector3 Example") | None |

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `x` | Number | The `x` component of the Vector3. [:fontawesome-solid-info-circle:](../api/examples/#vector3x "Vector3: x Example") | Read-Write |
| `y` | Number | The `y` component of the Vector3. [:fontawesome-solid-info-circle:](../api/examples/#vector3y "Vector3: y Example") | Read-Write |
| `z` | Number | The `z` component of the Vector3. [:fontawesome-solid-info-circle:](../api/examples/#vector3z "Vector3: z Example") | Read-Write |
| `size` | Number | The magnitude of the Vector3. [:fontawesome-solid-info-circle:](../api/examples/#vector3size "Vector3: size Example") | Read-Only |
| `sizeSquared` | Number | The squared magnitude of the Vector3. [:fontawesome-solid-info-circle:](../api/examples/#vector3sizesquared "Vector3: sizeSquared Example") | Read-Only |

### Vector4

A four-component vector.

| Class Function | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `Vector4.Lerp(Vector4 from, Vector4 to, Number progress)` | Vector4 | Linearly interpolates between two vectors by the specified progress amount and returns the resultant Vector4. | None |

| Constructor | Return Type | Description | Tags |
| ----------- | ----------- | ----------- | ---- |
| `Vector4.New([Number x, Number y, Number z, Number w])` | Vector4 | Constructs a Vector4 with the given `x`, `y`, `z`, `w` values, defaults to (0, 0, 0, 0). | None |
| `Vector4.New(Number v)` | Vector4 | Constructs a Vector4 with `x`, `y`, `z`, `w` values all set to the given value. | None |
| `Vector4.New(Vector3 xyz, Number w)` | Vector4 | Constructs a Vector4 with `x`, `y`, `z` values from the given Vector3 and the given `w` value. | None |
| `Vector4.New(Vector4 v)` | Vector4 | Constructs a Vector4 with `x`, `y`, `z`, `w` values from the given Vector4. | None |
| `Vector4.New(Vector2 xy, Vector2 zw)` | Vector4 | Constructs a Vector4 with `x`, `y` values from the first Vector2 and `z`, `w` values from the second Vector2. | None |
| `Vector4.New(Color v)` | Color | Constructs a Vector4 with `x`, `y`, `z`, `w` values mapped from the given Color's `r`, `g`, `b`, `a` values. | None |
| `Vector4.ZERO` | Vector4 | (0, 0, 0, 0) | None |
| `Vector4.ONE` | Vector4 | (1, 1, 1, 1) | None |

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetNormalized()` | Vector4 | Returns a new Vector4 with size 1, but still pointing in the same direction. Returns (0, 0, 0, 0) if the vector is too small to be normalized. | None |

| Operator | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Vector4 + Vector4` | Vector4 | Component-wise addition. | None |
| `Vector4 + Number` | Vector4 | Adds the right-side Number to each of the components in the left side and returns the resulting Vector4. | None |
| `Vector4 - Vector4` | Vector4 | Component-wise subtraction. | None |
| `Vector4 - Number` | Vector4 | Subtracts the right-side Number from each of the components in the left side and returns the resulting Vector4. | None |
| `Vector4 * Vector4` | Vector4 | Component-wise multiplication. | None |
| `Vector4 * Number` | Vector4 | Multiplies each component of the Vector4 by the right-side Number. | None |
| `Number * Vector4` | Vector4 | Multiplies each component of the Vector4 by the left-side Number. | None |
| `Vector4 / Vector4` | Vector4 | Component-wise division. | None |
| `Vector4 / Number` | Vector4 | Divides each component of the Vector4 by the right-side Number. | None |
| `-Vector4` | Vector4 | Returns the negation of the Vector4. | None |
| `Vector4 .. Vector4` | Number | Returns the dot product of the Vector4s. | None |
| `Vector4 ^ Vector4` | Vector4 | Returns the cross product of the Vector4s. | None |

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `x` | Number | The `x` component of the Vector4. | Read-Write |
| `y` | Number | The `y` component of the Vector4. | Read-Write |
| `z` | Number | The `z` component of the Vector4. | Read-Write |
| `w` | Number | The `w` component of the Vector4. | Read-Write |
| `size` | Number | The magnitude of the Vector4. | Read-Only |
| `sizeSquared` | Number | The squared magnitude of the Vector4. | Read-Only |

### Vfx

Vfx is a specialized type of SmartObject for visual effects. It inherits everything from SmartObject.

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Play()` | None | Starts playing the effect. [:fontawesome-solid-info-circle:](../api/examples/#vfxplay "Vfx: Play Example") | Dynamic |
| `Stop()` | None | Stops playing the effect. [:fontawesome-solid-info-circle:](../api/examples/#vfxstop "Vfx: Stop Example") | Dynamic |

### Weapon

A Weapon is an Equipment that comes with built-in Abilities and fires Projectiles.

| Event | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `targetImpactedEvent` | Event&lt;Weapon, ImpactData&gt; | Fired when a Weapon interacts with something. E.g. a shot hits a wall. The `ImpactData` parameter contains information such as which object was hit, who owns the Weapon, which ability was involved in the interaction, etc. [:fontawesome-solid-info-circle:](../api/examples/#weapontargetimpactedevent "Weapon: targetImpactedEvent Example") | Server-Only |
| `projectileSpawnedEvent` | Event&lt;Weapon, Projectile&gt; | Fired when a Weapon spawns a projectile. [:fontawesome-solid-info-circle:](../api/examples/#weaponprojectilespawnedevent "Weapon: projectileSpawnedEvent Example") | None |

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `HasAmmo()` | bool | Informs whether the Weapon is able to attack or not. [:fontawesome-solid-info-circle:](../api/examples/#weaponhasammo "Weapon: HasAmmo Example") | None |
| `Attack(target)` | None | Triggers the main ability of the Weapon. Optional target parameter can be a Vector3 world position, a Player, or a CoreObject. [:fontawesome-solid-info-circle:](../api/examples/#weaponattack "Weapon: Attack Example") | None |

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `animationStance` | string | When the Weapon is equipped this animation stance is applied to the Player. [:fontawesome-solid-info-circle:](../api/examples/#weaponanimationstance "Weapon: animationStance Example") | Read-Only |
| `attackCooldownDuration` | Number | Interval between separate burst sequences. The value is set by the Shoot ability's Cooldown duration. [:fontawesome-solid-info-circle:](../api/examples/#weaponattackcooldownduration "Weapon: attackCooldownDuration Example") | Read-Only |
| `multiShotCount` | Integer | Number of Projectiles/Hitscans that will fire simultaneously inside the spread area each time the Weapon attacks. Does not affect the amount of ammo consumed per attack. [:fontawesome-solid-info-circle:](../api/examples/#weaponmultishotcount "Weapon: multiShotCount Example") | Read-Only |
| `burstCount` | Integer | Number of automatic activations of the Weapon that generally occur in quick succession. [:fontawesome-solid-info-circle:](../api/examples/#weaponburstcount "Weapon: burstCount Example") | Read-Only |
| `shotsPerSecond` | Number | Used in conjunction with burstCount to determine the interval between automatic weapon activations. [:fontawesome-solid-info-circle:](../api/examples/#weaponshotspersecond "Weapon: shotsPerSecond Example") | Read-Write |
| `shouldBurstStopOnRelease` | bool | If `true`, a burst sequence can be interrupted by the Player by releasing the action button. If `false`, the burst continues firing automatically until it completes or the Weapon runs out of ammo. [:fontawesome-solid-info-circle:](../api/examples/#weaponshouldburststoponrelease "Weapon: shouldBurstStopOnRelease Example") | Read-Only |
| `isHitscan` | bool | If `false`, the Weapon will produce simulated Projectiles. If `true`, it will instead use instantaneous line traces to simulate shots. [:fontawesome-solid-info-circle:](../api/examples/#weaponishitscan "Weapon: isHitscan Example") | Read-Only |
| `range` | Number | Max travel distance of the Projectile (isHitscan = False) or range of the line trace (isHitscan = True). [:fontawesome-solid-info-circle:](../api/examples/#weaponrange "Weapon: range Example") | Read-Only |
| `damage` | Number | Damage applied to a Player when the weapon attack hits a player target. If set to zero, no damage is applied. [:fontawesome-solid-info-circle:](../api/examples/#weapondamage "Weapon: damage Example") | Read-Only |
| `projectileTemplateId` | string | Asset reference for the visual body of the Projectile, for non-hitscan Weapons. [:fontawesome-solid-info-circle:](../api/examples/#weaponprojectiletemplateid "Weapon: projectileTemplateId Example") | Read-Only |
| `muzzleFlashTemplateId` | string | Asset reference for a Vfx to be attached to the muzzle point each time the Weapon attacks. [:fontawesome-solid-info-circle:](../api/examples/#weaponmuzzleflashtemplateid "Weapon: muzzleFlashTemplateId Example") | Read-Only |
| `trailTemplateId` | string | Asset reference for a trail Vfx to follow the trajectory of the shot. [:fontawesome-solid-info-circle:](../api/examples/#weapontrailtemplateid "Weapon: trailTemplateId Example") | Read-Only |
| `beamTemplateId` | string | Asset reference for a beam Vfx to be placed along the trajectory of the shot. Useful for hitscan Weapons or very fast Projectiles. | Read-Only |
| `impactSurfaceTemplateId` | string | Asset reference of a Vfx to be attached to the surface of any CoreObjects hit by the attack. [:fontawesome-solid-info-circle:](../api/examples/#weaponimpactsurfacetemplateid "Weapon: impactSurfaceTemplateId Example") | Read-Only |
| `impactProjectileTemplateId` | string | Asset reference of a Vfx to be spawned at the interaction point. It will be aligned with the trajectory. If the impacted object is a CoreObject, then the Vfx will attach to it as a child. [:fontawesome-solid-info-circle:](../api/examples/#weaponimpactprojectiletemplateid "Weapon: impactProjectileTemplateId Example") | Read-Only |
| `impactPlayerTemplateId` | string | Asset reference of a Vfx to be spawned at the interaction point, if the impacted object is a player. [:fontawesome-solid-info-circle:](../api/examples/#weaponimpactplayertemplateid "Weapon: impactPlayerTemplateId Example") | Read-Only |
| `projectileSpeed` | Number | Travel speed (cm/s) of Projectiles spawned by this weapon. [:fontawesome-solid-info-circle:](../api/examples/#weaponprojectilespeed "Weapon: projectileSpeed Example") | Read-Only |
| `projectileLifeSpan` | Number | Duration after which Projectiles are destroyed. [:fontawesome-solid-info-circle:](../api/examples/#weaponprojectilelifespan "Weapon: projectileLifeSpan Example") | Read-Only |
| `projectileGravity` | Number | Gravity scale applied to spawned Projectiles. [:fontawesome-solid-info-circle:](../api/examples/#weaponprojectilegravity "Weapon: projectileGravity Example") | Read-Only |
| `projectileLength` | Number | Length of the Projectile's capsule collision. [:fontawesome-solid-info-circle:](../api/examples/#weaponprojectilelength "Weapon: projectileLength Example") | Read-Only |
| `projectileRadius` | Number | Radius of the Projectile's capsule collision [:fontawesome-solid-info-circle:](../api/examples/#weaponprojectileradius "Weapon: projectileRadius Example") | Read-Only |
| `projectileDrag` | Number | Drag on the Projectile. [:fontawesome-solid-info-circle:](../api/examples/#weaponprojectiledrag "Weapon: projectileDrag Example") | Read-Only |
| `projectileBounceCount` | Integer | Number of times the Projectile will bounce before it's destroyed. Each bounce generates an interaction event. [:fontawesome-solid-info-circle:](../api/examples/#weaponprojectilebouncecount "Weapon: projectileBounceCount Example") | Read-Only |
| `projectilePierceCount` | Integer | Number of objects that will be pierced by the Projectile before it's destroyed. Each pierce generates an interaction event. [:fontawesome-solid-info-circle:](../api/examples/#weaponprojectilepiercecount "Weapon: projectilePierceCount Example") | Read-Only |
| `maxAmmo` | Integer | How much ammo the Weapon starts with and its max capacity. If set to -1 then the Weapon has infinite capacity and doesn't need to reload. [:fontawesome-solid-info-circle:](../api/examples/#weaponmaxammo "Weapon: maxAmmo Example") | Read-Only |
| `currentAmmo` | Integer | Current amount of ammo stored in this Weapon. [:fontawesome-solid-info-circle:](../api/examples/#weaponcurrentammo "Weapon: currentAmmo Example") | Read-Write, Dynamic |
| `ammoType` | string | A unique identifier for the ammunition type. [:fontawesome-solid-info-circle:](../api/examples/#weaponammotype "Weapon: ammoType Example") | Read-Only |
| `isAmmoFinite` | bool | Determines where the ammo comes from. If `true`, then ammo will be drawn from the Player's Resource inventory and reload will not be possible until the Player acquires more ammo somehow. If `false`, then the Weapon simply reloads to full and inventory Resources are ignored. [:fontawesome-solid-info-circle:](../api/examples/#weaponisammofinite "Weapon: isAmmoFinite Example") | Read-Only |
| `outOfAmmoSoundId` | string | Asset reference for a sound effect to be played when the Weapon tries to activate, but is out of ammo. [:fontawesome-solid-info-circle:](../api/examples/#weaponoutofammosoundid "Weapon: outOfAmmoSoundId Example") | Read-Only |
| `reloadSoundId` | string | Asset reference for a sound effect to be played when the Weapon reloads ammo. [:fontawesome-solid-info-circle:](../api/examples/#weaponreloadsoundid "Weapon: reloadSoundId Example") | Read-Only |
| `spreadMin` | Number | Smallest size in degrees for the Weapon's cone of probability space to fire Projectiles in. [:fontawesome-solid-info-circle:](../api/examples/#weaponspreadmin "Weapon: spreadMin Example") | Read-Only |
| `spreadMax` | Number | Largest size in degrees for the Weapon's cone of probability space to fire Projectiles in. [:fontawesome-solid-info-circle:](../api/examples/#weaponspreadmax "Weapon: spreadMax Example") | Read-Only |
| `spreadAperture` | Number | The surface size from which shots spawn. An aperture of zero means shots originate from a single point. [:fontawesome-solid-info-circle:](../api/examples/#weaponspreadaperture "Weapon: spreadAperture Example") | Read-Only |
| `spreadDecreaseSpeed` | Number | Speed at which the spread contracts back from its current value to the minimum cone size. [:fontawesome-solid-info-circle:](../api/examples/#weaponspreaddecreasespeed "Weapon: spreadDecreaseSpeed Example") | Read-Only |
| `spreadIncreasePerShot` | Number | Amount the spread increases each time the Weapon attacks. [:fontawesome-solid-info-circle:](../api/examples/#weaponspreadincreasepershot "Weapon: spreadIncreasePerShot Example") | Read-Only |
| `spreadPenaltyPerShot` | Number | Cumulative penalty to the spread size for successive attacks. Penalty cools off based on `spreadDecreaseSpeed`. [:fontawesome-solid-info-circle:](../api/examples/#weaponspreadpenaltypershot "Weapon: spreadPenaltyPerShot Example") | Read-Only |

### WorldText

WorldText is an in-world text CoreObject.

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetColor()` | Color | The color of the Text. [:fontawesome-solid-info-circle:](../api/examples/#worldtextgetcolor "Worldtext: GetColor Example") | None |
| `SetColor(Color)` | None | The color of the Text. [:fontawesome-solid-info-circle:](../api/examples/#worldtextsetcolor "Worldtext: SetColor Example") | Dynamic |

| Property | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `text` | string | The text being displayed by this object. [:fontawesome-solid-info-circle:](../api/examples/#worldtexttext "Worldtext: text Example") | Read-Write, Dynamic |

## Core Lua Namespaces

Some sets of related functionality are grouped within namespaces, which are similar to the types above, but cannot be instantiated. They are only ever accessed by calling functions within these namespaces.

### CoreDebug

The CoreDebug namespace contains functions that may be useful for debugging.

| Class Function | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `CoreDebug.DrawLine(Vector3 start, Vector3 end, [table optionalParameters])` | None | Draws a debug line. `optionalParameters: duration (Number), thickness (Number), color (Color)`. 0 or negative duration results in a single frame. [:fontawesome-solid-info-circle:](../api/examples/#coredebugdrawline "Coredebug: DrawLine Example") | None |
| `CoreDebug.DrawBox(Vector3 center, Vector3 dimensions, [table optionalParameters])` | None | Draws a debug box, with dimension specified as a vector. `optionalParameters` has same options as `DrawLine()`, with addition of: `rotation (Rotation)` - rotation of the box. [:fontawesome-solid-info-circle:](../api/examples/#coredebugdrawbox "Coredebug: DrawBox Example") | None |
| `CoreDebug.DrawSphere(Vector3 center, radius, [table optionalParameters])` | None | Draws a debug sphere. `optionalParameters` has the same options as `DrawLine()`. [:fontawesome-solid-info-circle:](../api/examples/#coredebugdrawsphere "Coredebug: DrawSphere Example") | None |
| `CoreDebug.GetTaskStackTrace([Task task])` | string | Returns a stack trace listing the Lua method calls currently in progress by the given Task. Defaults to the current Task if `task` is not specified. [:fontawesome-solid-info-circle:](../api/examples/#coredebuggettaskstacktrace "Coredebug: GetTaskStackTrace Example") | None |
| `CoreDebug.GetStackTrace()` | string | Returns a stack trace listing all actively executing Lua tasks and their method calls. Usually there is only one task actively executing at a time, with others in a yielded state and excluded from this trace. Multiple tasks can be included in the trace is one task triggers an event that has listeners registered, or if a task calls `require()` to load a new script. [:fontawesome-solid-info-circle:](../api/examples/#coredebuggetstacktrace "Coredebug: GetStackTrace Example") | None |

### CoreLuaFunctions

A few base functions provided by the platform.

| Function | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Tick(Number deltaTime)` | Number | Tick event, used for things you need to check continuously (e.g. main game loop), but be careful of putting too much logic here or you will cause performance issues. DeltaTime is the time difference (in seconds) between this and the last tick. | None |
| `time()` | Number | Returns the time in seconds (floating point) since the game started on the server. | None |
| `print(string)` | string | Print a message to the event log. Access the Event Log from the "View" menu. | None |
| `warn(string)` | string | Similar to `print()`, but includes the script name and line number. | None |
| `require(string)` | table | `require()` in Core differs slightly from vanilla Lua; Instead of giving it a script or file name, you give it a script ID. The script ID is usually assigned as a custom property (of type Asset Reference) that points to the script you want to `require()`. | None |

### CoreMath

The CoreMath namespace contains a set of math functions.

| Class Function | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `CoreMath.Clamp(Number value, [Number lower, Number upper])` | Number | Clamps value between lower and upper, inclusive. If lower and upper are not specified, defaults to 0 and 1. | None |
| `CoreMath.Lerp(Number from, Number to, Number t)` | Number | Linear interpolation between from and to. t should be a floating point number from 0 to 1, with 0 returning from and 1 returning to. | None |
| `CoreMath.Round(Number value, [Number decimals])` | Number | Rounds value to an integer, or to an optional number of decimal places, and returns the rounded value. | None |

### CoreString

The CoreString namespace contains a set of string utility functions.

| Class Function | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `CoreString.Join(string delimiter, [...])` | string | Concatenates the given values together, separated by `delimiter`.  If a given value is not a string, it is converted to one using `tostring()`. | None |
| `CoreString.Split(string s, [string delimiter], [table parameters])` | ... | Splits the string `s` into substrings separated by `delimiter`.<br/>Optional parameters in the `parameters` table include:<br/>`removeEmptyResults (bool)`: If `true`, empty strings will be removed from the results. Defaults to `false`.<br/>`maxResults (integer)`: Limits the number of strings that will be returned. The last result will be any remaining unsplit portion of `s`.<br/>`delimiters (string or Array<string>)`:Allows splitting on multiple delimiters. If both this and the `delimiter` parameter are specified, the combined list is used. If neither is specified, default is to split on any whitespace characters.<br/>Note that this function does not return a table, it returns multiple strings. For example: `local myHello, myCore = CoreString.Split("Hello Core!")` If a table is desired, wrap the call to `Split()` in curly braces, eg: `local myTable = {CoreString.Split("Hello Core!")}` | None |
| `CoreString.Trim(string s, [...])` | string | Trims whitespace from the start and end of `s`, returning the result.  An optional list of strings may be provided to trim those strings from `s` instead of the default whitespace. For example, `CoreString.Trim("(==((Hello!))==)", "(==(", ")==)")` returns "(Hello!)". | None |

### Events

User defined events can be specified using the Events namespace. The Events namespace uses the following class functions:

| Class Function | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `Events.Connect(string eventName, function eventListener, [...])` | EventListener | Registers the given function to the event name which will be called every time the event is fired using Broadcast. Returns an EventListener which can be used to disconnect from the event or check if the event is still connected. Accepts any number of additional arguments after the listener function, those arguments will be provided after the event's own parameters. | None |
| `Events.ConnectForPlayer(string eventName, function eventListener, [...])` | EventListener | Registers the given function to the event name which will be called every time the event is fired using BroadcastToServer. The first parameter the function receives will be the Player that fired the event. Returns an EventListener which can be used to disconnect from the event or check if the event is still connected. Accepts any number of additional arguments after the listener function, those arguments will be provided after the event's own parameters. | Server-Only |
| `Events.Broadcast(string eventName, [...])` | string | Broadcasts the given event and fires all listeners attached to the given event name if any exists. Parameters after event name specifies the arguments passed to the listener. Any number of arguments can be passed to the listener function. The events are not networked and can fire events defined in the same context. | None |
| `Events.BroadcastToAllPlayers(string eventName, [...])` | &lt;BroadcastEventResultCode, string errorMessage&gt; | Broadcasts the given event to all clients over the network and fires all listeners attached to the given event name if any exists. Parameters after event name specify the arguments passed to the listener on the client. The function returns a result code and a message. Possible result codes can be found below. This is a networked event. The maximum size a networked event can send is 128bytes and all networked events are subjected to a rate limit of 10 events per second. | Server-Only |
| `Events.BroadcastToPlayer(Player player, string eventName, [...])` | &lt;BroadcastEventResultCode, string errorMessage&gt; | Broadcasts the given event to a specific client over the network and fires all listeners attached to the given event name if any exists on that client. The first parameter specifies the Player to which the event will be sent. The parameters after event name specify the arguments passed to the listener on the client. The function returns a result code and a message. Possible result codes can be found below. This is a networked event. The maximum size a networked event can send is 128bytes and all networked events are subjected to a rate limit of 10 events per second. | Server-Only |
| `Events.BroadcastToServer(string eventName, [...])` | &lt;BroadcastEventResultCode, string errorMessage&gt; | Broadcasts the given event to the server over the network and fires all listeners attached to the given event name if any exists on the server. The parameters after event name specify the arguments passed to the listener on the server. The function returns a result code and a message. Possible result codes can be found below. This is a networked event. The maximum size a networked event can send is 128bytes and all networked events are subjected to a rate limit of 10 events per second. | Client-Only |

??? "Broadcast Event Result Codes"
    - BroadcastEventResultCode.SUCCESS
    - BroadcastEventResultCode.FAILURE
    - BroadcastEventResultCode.EXCEEDED_SIZE_LIMIT
    - BroadcastEventResultCode.EXCEEDED_RATE_WARNING_LIMIT
    - BroadcastEventResultCode.EXCEEDED_RATE_LIMIT

??? "Networked Events Supported Types"
    - Bool
    - Int32
    - Float
    - String
    - Color
    - Rotator
    - Vector2
    - Vector3
    - Vector4
    - Player
    - Table

### Game

Game is a collection of functions and events related to players in the game, rounds of a game, and team scoring.

| Class Function | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `Game.GetLocalPlayer()` | Player | Returns the local player. [:fontawesome-solid-info-circle:](../api/examples/#gamegetlocalplayer "Game: GetLocalPlayer Example") | Client-Only |
| `Game.GetPlayers([table parameters])` | Array&lt;Player&gt; | Returns a table containing the players currently in the game. An optional table may be provided containing parameters to filter the list of players returned: ignoreDead(boolean), ignoreLiving(boolean), ignoreTeams(Integer or table of Integer), includeTeams(Integer or table of Integer), ignorePlayers(Player or table of Player), E.g.: `Game.GetPlayers({ignoreDead = true, ignorePlayers = Game.GetLocalPlayer()})`. [:fontawesome-solid-info-circle:](../api/examples/#gamegetplayers "Game: GetPlayers Example") | None |
| `Game.FindNearestPlayer(Vector3 position, [table parameters])` | Player | Returns the Player that is nearest to the given position. An optional table may be provided containing parameters to filter the list of players considered. This supports the same list of parameters as GetPlayers(). [:fontawesome-solid-info-circle:](../api/examples/#gamefindnearestplayer "Game: FindNearestPlayer Example") | None |
| `Game.FindPlayersInCylinder(Vector3 position, Number radius, [table parameters])` | Array&lt;Player&gt; | Returns a table with all Players that are in the given area. Position's `z` is ignored with the cylindrical area always upright. An optional table may be provided containing parameters to filter the list of players considered. This supports the same list of parameters as GetPlayers(). [:fontawesome-solid-info-circle:](../api/examples/#gamefindplayersincylinder "Game: FindPlayersInCylinder Example") | None |
| `Game.FindPlayersInSphere(Vector3 position, Number radius, [table parameters])` | Array&lt;Player&gt; | Returns a table with all Players that are in the given spherical area. An optional table may be provided containing parameters to filter the list of players considered. This supports the same list of parameters as GetPlayers(). [:fontawesome-solid-info-circle:](../api/examples/#gamefindplayersinsphere "Game: FindPlayersInSphere Example") | None |
| `Game.StartRound()` | None | Fire all events attached to roundStartEvent. [:fontawesome-solid-info-circle:](../api/examples/#gamestartround "Game: StartRound Example") | Server-Only |
| `Game.EndRound()` | None | Fire all events attached to roundEndEvent. [:fontawesome-solid-info-circle:](../api/examples/#gameendround "Game: EndRound Example") | Server-Only |
| `Game.GetTeamScore(Integer team)` | Integer | Returns the current score for the specified team. Only teams 0 - 4 are valid. [:fontawesome-solid-info-circle:](../api/examples/#gamegetteamscore "Game: GetTeamScore Example") | None |
| `Game.SetTeamScore(Integer team, Integer score)` | None | Sets one team's score. [:fontawesome-solid-info-circle:](../api/examples/#gamesetteamscore "Game: SetTeamScore Example") | Server-Only |
| `Game.IncreaseTeamScore(Integer team, Integer scoreChange)` | None | Increases one team's score. [:fontawesome-solid-info-circle:](../api/examples/#gameincreaseteamscore "Game: IncreaseTeamScore Example") | Server-Only |
| `Game.DecreaseTeamScore(Integer team, Integer scoreChange)` | None | Decreases one team's score. [:fontawesome-solid-info-circle:](../api/examples/#gamedecreaseteamscore "Game: DecreaseTeamScore Example") | Server-Only |
| `Game.ResetTeamScores()` | None | Sets all teams' scores to 0. [:fontawesome-solid-info-circle:](../api/examples/#gameresetteamscores "Game: ResetTeamScores Example") | Server-Only |

| Event | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `Game.playerJoinedEvent` | Event&lt;Player&gt; | Fired when a player has joined the game and their character is ready. [:fontawesome-solid-info-circle:](../api/examples/#gameplayerjoinedevent "Game: playerJoinedEvent Example") | None |
| `Game.playerLeftEvent` | Event&lt;Player&gt; | Fired when a player has disconnected from the game or their character has been destroyed. [:fontawesome-solid-info-circle:](../api/examples/#gameplayerleftevent "Game: playerLeftEvent Example") | None |
| `Game.roundStartEvent` | Event | Fired when StartRound is called on game. [:fontawesome-solid-info-circle:](../api/examples/#gameroundstartevent "Game: roundStartEvent Example") | None |
| `Game.roundEndEvent` | Event | Fired when EndRound is called on game. [:fontawesome-solid-info-circle:](../api/examples/#gameroundendevent "Game: roundEndEvent Example") | None |
| `Game.teamScoreChangedEvent` | Event&lt;Integer team&gt; | Fired whenever any team's score changes. This is fired once per team who's score changes. [:fontawesome-solid-info-circle:](../api/examples/#gameteamscorechangedevent "Game: teamScoreChangedEvent Example") | None |

### Storage

The Storage namespace contains a set of functions for handling persistent storage of data. To use the Storage API, you must place a Game Settings object in your game and check the Enable Player Storage property on it.

| Class Function | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `Storage.GetPlayerData(Player player)` | table | Returns the player data associated with `player`. This returns a copy of the data that has already been retrieved for the player, so calling this function does not incur any additional network cost. Changes to the data in the returned table will not be persisted without calling `Storage.SetPlayerData()`. [:fontawesome-solid-info-circle:](../api/examples/#storagegetplayerdata "Storage: GetPlayerData Example") | Server-Only |
| `Storage.SetPlayerData(Player player, table data)` | StorageResultCode, string | Updates the data associated with `player`. Returns a result code and an error message. See below for possible result codes and supported data types. Player data is limited to 16KB per player.<br/>Possible result codes:<br/>`StorageResultCode.SUCCESS`<br/>`StorageResultCode.FAILURE`<br/>`StorageResultCode.STORAGE_DISABLED`<br/>`StorageResultCode.EXCEEDED_SIZE_LIMIT`. [:fontawesome-solid-info-circle:](../api/examples/#storagesetplayerdata "Storage: SetPlayerData Example") | Server-Only |

??? "Storage Supported Types"
    - Bool
    - Int32
    - Float
    - String
    - Color
    - Rotator
    - Vector2
    - Vector3
    - Vector4
    - Player
    - Table

### Teams

The Teams namespace contains a set of class functions for dealing with teams and team settings.

| Class Function | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `Teams.AreTeamsEnemies(Integer team1, Integer team2)` | bool | Returns true if teams are considered enemies under the current TeamMode. If either team is TEAM_NEUTRAL=0, returns false. | None |
| `Teams.AreTeamsFriendly(Integer team1, Integer team2)` | bool | Returns true if teams are considered friendly under the current TeamMode. If either team is TEAM_NEUTRAL=0, returns true. | None |

### UI

The UI namespace contains a set of class functions allowing you to get information about a Player's display and push information to their HUD. Most functions require the script to be inside a ClientContext and execute for the local Player.

| Class Function | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `UI.ShowFlyUpText(string message, Vector3 worldPosition, [table parameters])` | None | Shows a quick text on screen that tracks its position relative to a world position. The last parameter is an optional table containing additional parameters: duration (Number) - How long the text should remain on the screen. Default duration is 0.5 seconds; color (Color) - The color of the Text. Default is white; isBig (boolean) - When true, larger text is used. | Client-Only |
| `UI.ShowDamageDirection(Vector3 worldPosition)` | None | Local player sees an arrow pointing towards some damage source. Lasts for 5 seconds. | Client-Only |
| `UI.ShowDamageDirection(CoreObject source)` | None | Local player sees an arrow pointing towards some CoreObject. Multiple calls with the same CoreObject reuse the same UI indicator, but refreshes its duration. | Client-Only |
| `UI.ShowDamageDirection(Player source)` | None | Local player sees an arrow pointing towards some other Player. Multiple calls with the same Player reuse the same UI indicator, but refreshes its duration. The arrow points to where the source was at the moment `ShowDamageDirection` is called and does not track the source Player's movements. | Client-Only |
| `UI.GetCursorPosition()` | Vector2 | Returns a Vector2 with the `x`, `y` coordinates of the mouse cursor on the screen. Only gives results from a client context. May return nil if the cursor position cannot be determined. | Client-Only |
| `UI.GetScreenPosition(Vector3 worldPosition)` | Vector2 | Calculates the location that worldPosition appears on the screen. Returns a Vector2 with the `x`, `y` coordinates, or nil if worldPosition is behind the camera. Only gives results from a client context. | Client-Only |
| `UI.GetScreenSize()` | Vector2 | Returns a Vector2 with the size of the Player's screen in the `x`, `y` coordinates. Only gives results from a client context. May return nil if the screen size cannot be determined. | Client-Only |
| `UI.PrintToScreen(string message, [Color])` | None | Draws a message on the corner of the screen. Second optional Color parameter can change the color from the default white. | Client-Only |
| `UI.IsCursorVisible()` | bool | Returns whether the cursor is visible. | Client-Only |
| `UI.SetCursorVisible(bool isVisible)` | None | Sets whether the cursor is visible. | Client-Only |
| `UI.IsCursorLockedToViewport()` | bool | Returns whether to lock cursor in viewport. | Client-Only |
| `UI.SetCursorLockedToViewport(bool isLocked)` | None | Sets whether to lock cursor in viewport. | Client-Only |
| `UI.CanCursorInteractWithUI()` | bool | Returns whether the cursor can interact with UI elements like buttons. | Client-Only |
| `UI.SetCanCursorInteractWithUI(bool)` | None | Sets whether the cursor can interact with UI elements like buttons. | Client-Only |
| `UI.IsReticleVisible()` | bool | Check if reticle is visible. | Client-Only |
| `UI.SetReticleVisible(bool show)` | None | Shows or hides the reticle for the Player. | Client-Only |
| `UI.GetCursorHitResult()` | HitResult | Return hit result from local client's view in direction of the Projected cursor position. Meant for client-side use only, for Ability cast, please use ability:GetTargetData():GetHitPosition(), which would contain cursor hit position at time of cast, when in top-down camera mode. | Client-Only |
| `UI.GetCursorPlaneIntersection(Vector3 pointOnPlane, [Vector3 planeNormal])` | Vector3 | Return intersection from local client's camera direction to given plane, specified by point on plane and optionally its normal. Meant for client-side use only. Example usage: `local hitPos = UI.GetCursorPlaneIntersection(Vector3.New(0, 0, 0))`. | Client-Only |

### World

World is a collection of functions for finding objects in the world.

| Class Function | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `World.GetRootObject()` | CoreObject | Returns the root of the CoreObject hierarchy. [:fontawesome-solid-info-circle:](../api/examples/#worldgetrootobject "World: GetRootObject Example") | None |
| `World.FindObjectsByName(string name)` | Array&lt;CoreObject&gt; | Returns a table containing all the objects in the hierarchy with a matching name. If none match, an empty table is returned. [:fontawesome-solid-info-circle:](../api/examples/#worldfindobjectsbyname "World: FindObjectsByName Example") | None |
| `World.FindObjectsByType(string typeName)` | Array&lt;CoreObject&gt; | Returns a table containing all the objects in the hierarchy whose type is or extends the specified type. If none match, an empty table is returned. [:fontawesome-solid-info-circle:](../api/examples/#worldfindobjectsbytype "World: FindObjectsByType Example") | None |
| `World.FindObjectByName(string typeName)` | CoreObject | Returns the first object found with a matching name. In none match, nil is returned. [:fontawesome-solid-info-circle:](../api/examples/#worldfindobjectbyname "World: FindObjectByName Example") | None |
| `World.FindObjectById(string muid)` | CoreObject | Returns the object with a given MUID. Returns nil if no object has this ID. [:fontawesome-solid-info-circle:](../api/examples/#worldfindobjectbyid "World: FindObjectById Example") | None |
| `World.SpawnAsset(string assetId, [table parameters])` | CoreObject | Spawns an instance of an asset into the world. Optional parameters can specify a parent for the spawned object. Supported parameters include: parent (CoreObject) <br /> If provided, the spawned asset will be a child of this parent, and any Transform parameters are relative to the parent's Transform; `position (Vector3)`: Position of the spawned object; `rotation (Rotation or Quaternion)`: Rotation of the spawned object; `scale (Vector3)`: Scale of the spawned object. [:fontawesome-solid-info-circle:](../api/examples/#worldspawnasset "World: SpawnAsset Example") | None |
| `World.Raycast(Vector3 rayStart, Vector3 rayEnd, [table parameters])` | HitResult | Traces a ray from `rayStart` to `rayEnd`, returning a `HitResult` with data about the impact point and object. Returns `nil` if no intersection is found. <br /> Optional parameters can be provided to control the results of the Raycast: `ignoreTeams (Integer or Array<Integer>)`: Don't return any players belonging to the team or teams listed; `ignorePlayers (Player, Array<Player>, or boolean)`: Ignore any of the players listed. If `true`, ignore all players. [:fontawesome-solid-info-circle:](../api/examples/#worldraycast "World: Raycast Example") | None |

### Built-In Lua Functions

For security reasons, various built-in Lua functions have been restricted or removed entirely. The available functions are listed below. Note that Lua's built-in trigonometric functions use radians, while other functions in Core uses degrees. See the [reference manual](https://www.lua.org/manual/5.3/manual.html#6) for more information on what they do.

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

MUIDs are internal identifiers for objects and assets within your game. They are guaranteed to be unique within the game and likely to be unique globally. You can copy a MUID to the clipboard automatically by right-clicking assets in the Asset Manifest or placed objects in the Hierarchy. The MUID will look something like this:

8D4B561900000092:Rabbit

The important part is the 16 digits at the start. The colon and everything after it are optional and are there to make it easier to read. Some Lua functions use MUIDs, for example `FindObjectById` and `SpawnAsset`. When used in a script, it needs to be surrounded by quotes to make it a string. For example:

```lua
local spawnTrans = script.parent:GetWorldTransform()
local anchor = World.FindObjectById('8D4B5619000000ED:Anchor')
World.SpawnAsset('8D4B561900000092:Rabbit', spawnTrans, anchor)
```
