# Lua Scripting API

## Overview

CORE has integrated version 5.3.4 of the Lua library.  For detailed technical information, see their [reference manual](https://www.lua.org/manual/5.3/). At a high level, CORE Lua types can be divided into two groups: data structures and [CoreObjects](/core_api/classes/coreobject).  Data structures are owned by Lua, while [CoreObjects](/core_api/classes/coreobject) are owned by the engine and could be destroyed while still referenced by Lua.

Properties, functions, and events inherited by [CoreObject](/core_api/classes/coreobject) types are listed below.
Both properties and events are accessed with `.propertyName` and `.eventName`, while functions are accessed with `:functionName()`.

## CORE Lua Types

At a high level, CORE Lua types can be divided into two groups: data structures and Objects.  Data structures are owned by Lua, while Objects are owned by the engine and could be destroyed while still referenced by Lua.  Objects all inherit from a single base type: Object.  Data structures have no common parent.  However, all data structures and Objects share a common `type` property, which is a String indicating its type.  The value of the `type` property will match the section headings below, for example: "Ability", "Vector2", "CoreObject", etc.  All CORE types also share an `IsA()` function.  The `IsA()` function can be passed a type name, and will return `true` if the value is that type or one of its subtypes, or will return `false` if it is not.  For example, `myObject:IsA("StaticMesh")`.

A lowercase type denotates a basic Lua type, such as `string` and `boolean`. You can learn more about Lua types from the official manual [here](https://www.lua.org/manual/2.2/section3_3.html). An uppercase type is a Core Type, such as `Player` and `CoreObject`.


### [Ability](/core_api/classes/ability/abilityOverview)

Abilities are Objects created at runtime and attached to Players. Spawn an ability with `game:SpawnAbility()`. Abilities can be activated by association with an Action Binding. They flow internally through the phases: Ready, Cast, Execute, Recovery and Cooldown.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`isEnabled` | bool | Turns an ability on/off. It stays on the player but is interrupted if isEnabled is set to False during an active Ability.  True by default. | Read-Write
`canActivateWhileDead` | bool | Indicates if the Ability can be used while the owning Player is dead. False by default. | Read-Only
`name ` | string | The name of the ability. | Read-Only
`actionBinding` | string | Which action binding will cause the Ability to activate. Possible values are listed under ability binding list. | Read-Only
`owner` | Player | Assigning an owner applies the Ability to that Player. | Read-Write
`castPhaseSettings` | AbilityPhaseSettings | Config data for the Cast phase (see below). | Read-Only
`executePhaseSettings` | AbilityPhaseSettings | Config data for the Execute phase. | Read-Only
`recoveryPhaseSettings` | AbilityPhaseSettings | Config data for the Recovery phase. | Read-Only
`cooldownPhaseSettings` | AbilityPhaseSettings | Config data for the Cooldown phase. | Read-Only
`animation` | string | Name of the animation the Player will play when the ability is activated. Possible values: See Ability Animation Section for strings and other info | Read-Only
`canBePrevented` | bool | Used in conjunction with the phase property preventsOtherAbilities so multiple abilities on the same Player can block each other during specific phases. True by default. | Read-Only
`readyEvent` | Event\<Ability> | Event called when the Ability becomes ready. In this phase it is possible to activate it again. | Read-Only
`castEvent` | Event\<Ability> | Called when the Ability enters the Cast phase. | Read-Only
`executeEvent` | Event\<Ability> | Called when the Ability enters Execute phase. | Read-Only
`recoveryEvent` | Event\<Ability> | Called when the Ability enters Recovery. | Read-Only
`cooldownEvent` | Event\<Ability> | Called when the Ability enters Cooldown. | Read-Only
`interruptedEvent` | Event\<Ability> | Called when the Ability is interrupted. | Read-Only
`tickEvent` | Event\<Ability> | Called every tick while the Ability is active (isEnabled = true and phase is not ready). | Read-Write

Function | Return Value | Description | Tags
--- | --- | --- | ---
`Activate()` | None | Client-context only. Activates an ability as if the button had been pressed. | None
`Interrupt()` | None | Changes an Ability from Cast phase to Ready phase. If the Ability is in either Execute or Recovery phases it instead goes to Cooldown phase. | None
`GetCurrentPhase()` | AbilityPhase | The current ability phase for this ability. These are returned as an AbilityPhaseEnum type which can be accessed as: AbilityPhase.READY, AbilityPhase.CAST, AbilityPhase.EXECUTE, AbilityPhase.RECOVERY, andAbilityPhase.COOLDOWN | None
`GetPhaseTimeRemaining` | Number | Seconds left in the current phase. | None
`GetTargetData()` | AbilityTarget | Returns information about what the player has targeted this phase. | None
`SetTargetData (AbilityTarget)` | None | Updates information about what the player has targeted this phase.  This can affect the execution of the ability. | None


### [AbilityPhaseSettings](/core_api/classes/abilityphasesettings/abilityphasesettingsOverview)

Each phase of an Ability can be configured differently, allowing complex and different Abilities.  AbilityPhaseSettings is an Object.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`duration` | Number | Length in seconds of the phase. After this time the Ability moves to the next phase. Can be zero. Default values per phase: 0.15, 0, 0.5 and 3. | Read-Only
`canMove` | bool | Is the Player allowed to move during this phase. True by default. | Read-Only
`canJump` | bool | Is the Player allowed to jump during this phase. Default False in Cast & Execute, default True in Recovery & Cooldown. | Read-Only
`canRotate` | bool | Is the Player allowed to rotate during this phase. Default True. | Read-Only
`preventsOtherAbilities` | bool | When True this phase prevents the player from casting another Ability, unless that other Ability has can_be_prevented set to False. Default True in Cast & Execute, default False in Recovery & Cooldown. | Read-Only
`isTargetDataUpdated` | bool | If true, there will be updated target information at the start of the phase. Otherwise, target information may be out of date. | Read-Only
`facingMode` | AbilityFacingMode enum, | How and if this ability rotates the player during execution. Cast and Execute default to "Aim", other phases default to "None". Options are:  AbilityFacingMode.NONE, AbilityFacingMode.MOVEMENT, AbilityFacingMode.AIM | Read-Only

### [AbilityTarget](/core_api/classes/abilitytarget/abilitytargetOverview)

A data type containing information about what the player has targeted during a phase of an ability.

Constructor | Return Value | Description | Tags
--- | --- | --- | ---
`AbilityTarget.New()` | AbilityTarget | Constructs a new Ability Target data. | None

Property | Return Value | Description | Tags
--- | --- | --- | ---
`hitObject` | Object | Object under the reticle, or center of the screen if no reticle is displayed. Can be a Player, Static Mesh, etc. | Read-Only
`hitPlayer` | Player | Convenience property that is the same as hitObject, but only if hitObject is a Player. | Read-Only
`spreadHalfAngle` | Number | Half-angle of cone of possible target space, in degrees. | Read-Only
`spreadRandomSeed` | Integer | Seed that can be used with RandomStream for deterministic RNG. | Read-Only

Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetOwnerMovementRotation()` | Rotation | Gets the direction the player is moving. | None
`SetOwnerMovementRotation(Rotation)` | None | Sets the direction the player face, if the phase settings’ playerFacing property is set to AbilitySetFacing.Movement. | None
`GetCameraPosition()` | Vector3 | Returns the world space position of the camera. | None
`SetCameraPosition(Vector3)` | None | The world space location of the camera.  Setting this currently has no effect on the player’s camera. | None
`GetCameraForwardVector()` | Vector3 | Returns the direction the camera is facing. | None
`SetCameraForwardVector(Vector3)` | None | Sets the direction the camera is facing. | None
`GetHitPosition()` | Vector3 | Returns the world space position of the object under the player’s reticle. If there is no object, a position under the reticle in the distance. If the player doesn’t have a reticle displayed, uses the center of the screen as if there was a reticle there. | None
`SetHitPosition(Vector3)` | None | Sets the hit position property.  This may affect weapon behavior. | None
`GetHitResult()` | HitResult | Returns physics information about the point being targeted | None
`SetHitResult(HitResult)` | None | Sets the hit result property.  Setting this value has no affect on the ability. | None

### [Audio](/core_api/classes/audio/audioOverview)

Audio objects are CoreObjects that wrap sound files. Most properties are exposed in the UI and can be set when placed in the editor, but some functionality (such as playback with fade in/out) requires Lua scripting.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`isPlaying` | bool | Returns if the sound is currently playing. | Read-Only
`length` | Number | Returns the length (in seconds) of the sound. | Read-Only
`currentPlaybackTime` | Number | Returns the playback position (in seconds) of the sound. | Read-Only
`isSpatializationEnabled` | bool | Default true. Set to false to play sound without 3D positioning. | Read-Write, Dynamic
`isAutoPlayEnabled` | bool | Default false. If set to true when placed in the editor (or included in a template), the sound will be automatically played when loaded. | Read-Only
`isTransient` | bool | Default false. If set to true, the sound will automatically destroy itself after it finishes playing. | Read-Write
`isAutoRepeatEnabled` | bool | Loops when playback has finished. Some sounds are designed to automatically loop, this flag will force others that don't (can be useful for looping music.) | Read-Write
`pitch` | Number | Default 1. Multiplies the playback pitch of a sound. Note that some sounds have clamped pitch ranges (so 0.2-1 will work, above 1 might not.) | Read-Write
`volume` | Number | Default 1. Multiplies the playback volume of a sound. Note that values above 1 can distort sound, so if you're trying to balance sounds, experiment to see if scaling down works better than scaling up. | Read-Write
`radius` | Number | Default 0 (off.) If non-zero, will override default 3D spatial parameters of the sound. Radius is the distance away from the sound position that will be played at 100% volume. | Read-Write
`falloff` | Number | Default 0 (off). If non-zero, will override default 3D spatial parameters of the sound. Falloff is the distance outside the radius over which the sound volume will gradually fall to zero. | Read-Write

Function | Return Value | Description | Tags
--- | --- | --- | ---
`Play()` | None | Begins sound playback. | None
`Stop()` | None | Stops sound playback. | None
`FadeIn(Number time)` | None | Starts playing and fades in the sound over the given time. | None
`FadeOut(Number time)` | None | Fades the sound out and stops over time seconds. | None

### [ButtonUIControl](/core_api/classes/buttonuicontrol/buttonuicontrolOverview)

A UIControl for a button, should be inside client context.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`text` | string | Returns the button label text. | None
`fontSize` | string | Returns the Font size for label text. | None
`isInteractable` | bool | Returns whether button can interact with cursor (click, hover, etc). | None

Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetButtonColor()` | Color | Get button default color. | None
`SetButtonColor(Color)` | None | Set button default color. | None
`GetHoveredColor()` | Color | Get button color when hovered. | None
`SetHoveredColor(Color)` | None | Set button color when hovered. | None
`GetPressedColor()` | Color | Get button color when pressed. | None
`SetPressedColor(Color)` | None | Set button color when pressed. | None
`GetDisabledColor()` | Color | Get button color when it’s not intereactable. | None
`SetDisabledColor(Color)` | None | Set button color when it’s not interactable. | None
`GetFontColor()` | Color | Get font color. | None
`SetFontColor(Color)` | None | Set font color. | None
`SetImage(brushMuidString)` | None | Set image. | None

Event | Return Value | Description | Tags
--- | --- | --- | ---
`clickedEvent` | Event\<ButtonUIControl> | Called when button is clicked. This triggers on mouse-button up, if both button-down and button-up events happen inside the button hitbox. | Read-Only
`pressedEvent` | Event\<ButtonUIControl> | Called when button is pressed (mouse button down). | Read-Only
`releasedEvent` | Event\<ButtonUIControl> | Called when button is released (mouse button up). | Read-Only
`hoveredEvent` | Event\<ButtonUIControl> | Called when button is hovered. | Read-Only
`unhoveredEvent` | Event\<ButtonUIControl> | Called when button is unhovered. | Read-Only

### [Camera](/core_api/classes/camera/cameraOverview)

Camera is a CoreObject which is used both to configure player camera settings as well as to represent the position and rotation of the camera in the world. Cameras can be configured to follow a specific player’s view as well. Each player (on their client) can have a default camera and an override camera. If they have neither, camera behavior (currently) falls back to old and now deprecated behavior. Override cameras generally will be temporary things, like a view when the player is sitting in a mounted turret, while default cameras should be used for main gameplay behavior.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`lerpTime` | Number | The time over which camera property changes take effect. Clamped to be non-negative. | None
`hasFreeControl` | bool | Whether the player can freely control their rotation (with mouse or thumbstick). This has no effect if the camera is following a player. | None
`isDistanceAdjustable` | bool | Whether the player can control their camera distance (with the mouse wheel by default). Creators can still access distance through currentDistance below, even if this value is false. | None
`minDistance` | Number | The minimum distance the player can zoom in to. | None
`maxDistance` | Number | The maximum distance the player can zoom out to. | None
`isIsometric` | Number | Whether the camera uses an isometric (orthographic) view or perspective. | None
`fieldOfView` | Number | The field of view when using perspective view. Clamped between 1.0 and 170.0. | None
`viewWidth` | Number | The width of the view with an isometric view. Has a minimum value of 1.0. | None
`followPlayer` | Player | Which player’s view the camera should follow. Set to the local player for a first or third person camera. Set to nil to detach. | None
`currentDistance` | Number | The distance controlled by the player with scroll wheel (by default). Client-only | Client Context

Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetPositionOffset()` | Vector3 | An offset added to the camera or follow target’s eye position to the player’s view. | None
`SetPositionOffset(Vector3)` | None | An offset added to the camera or follow target’s eye position to the player’s view. | None
`GetRotationOffset()` | Rotation | A rotation added to the camera or follow target’s eye position. | None
`SetRotationOffset(Rotation)` | None | A rotation added to the camera or follow target’s eye position. | None

### [CanvasUIControl](/core_api/classes/canvasuicontrol/canvasuicontrolOverview)

A UIControl which indicates that child UI elements should be rendered. Does not have a position or size (it always is the size of the entire screen).

### [Color](/core_api/classes/color/colorOverview)

An RGBA representation of a color. Color components have an effective range of [0.0, 1.0], but values greater than 1 may be used.

Constructor | Return Value | Description | Tags
--- | --- | --- | ---
`Color.New(Number r, Number g, Number b, [Number a])` | Color | Construct with the given values. Alpha defaults to 1.0 if no fourth parameter is provided. | None
`Color.New(Vector3 v)` | Color | Construct using the vector’s XYZ components as the color’s RGB components. Alpha defaults to 1.0. | None
`Color.New(Vector4 v)` | Color | Construct using the vector’s XYZW components as the color’s RGBA components. | None
`Color.New(Color c)` | Color | Makes a copy of the given color. | None

Property | Return Value | Description | Tags
--- | --- | --- | ---
`r` | Number | The R component of the color. | Read-Write
`g` | Number | The G component of the color. | Read-Write
`b` | Number | The B component of the color. | Read-Write
`a` | Number | The A component of the color. | Read-Write

Class Function | Return Value | Description | Tags
--- | --- | --- | ---
`Lerp(Color from, Color to, Number progress)` | Color | Linearly interpolates between two colors in HSV space by the specified progress amount and returns the resultant Color. | None
`Random()` | Color | Returns a color with a random hue (H) of HSV form (H, 0, 1). | None

Member Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetDesaturated(Number desaturation)` | Color | Returns the desaturated version of the color. 0 represents no desaturation and 1 represents full desaturation. | None

Operator | Return Value | Description | Tags
--- | --- | --- | ---
`Color + Color` | Color | Component-wise addition. | None
`Color - Color` | Color | Component-wise subtraction | None
`Color * Color` | Color | Component-wise multiplication. | None
`Color * Number` | Color | Multiplies each component of the color by the right-side Number. | None
`Color / Color` | Color | Component-wise division. | None
`Color / Number` | Color | Divides each component of the color by the right-side Number. | None

!!! note
    Predefined Colors include Color.WHITE ,Color.GRAY ,Color.BLACK, Color.TRANSPARENT, Color.RED, Color.GREEN, Color.BLUE, Color.CYAN, Color.MAGENTA, Color.YELLOW, Color.ORANGE, Color.PURPLE, Color.BROWN, Color.PINK, Color.TAN, Color.RUBY, Color.EMERALD, Color.SAPPHIRE, Color.SILVER, Color.SMOKE.

### [CoreObject](/core_api/classes/coreobject/coreobjectOverview)

CoreObject is an Object placed in the scene hierarchy during edit mode.  Usually they’ll be a more specific type of CoreObject, but all CoreObjects have these

Property | Return Value | Description | Tags
--- | --- | --- | ---
`name` | string | Hello, my name is… | Read-Write, Dynamic
`id` | string | The object’s MUID. | Read-Only
`parent` | CoreObject | The object’s parent object, may be nil. | Read-Write, Dynamic
`isVisible` | bool | Turn on/off the rendering of an object and its children | Read-Write, Dynamic
`isCollidable` | bool | Turn on/off the collision of an object and its children | Read-Write, Dynamic
`isEnabled` | bool | Turn on/off an object and its children completely | Read-Write, Dynamic
`isStatic` | bool | If true, dynamic properties may not be written to, and dynamic functions may not be called. | Read-Only, Static, Dynamic
`isClientOnly` | bool | If true, this object was spawned on the client and is not replicated from the server. | Read-Only
`isServerOnly` | bool | If true, this object was spawned on the server and is not replicated to clients. | Read-Only
`isNetworked` | bool | If true, this object replicates from the server to clients. | Read-Only
`lifeSpan` | Number | Duration after which the object is destroyed. | Read-Write, Dynamic
`sourceTemplateId` | string | The ID of the Template from which this Core Object was instantiated. NIL if the object did not come from a Template. | Read-Only
`childAddedEvent` | Event\<CoreObject parent, CoreObject new_child> | An event fired when a child is added to this object. | Read-Only
`childRemovedEvent` | Event\<CoreObject parent, CoreObject removed_child> | An event fired when a child is removed from this object. | Read-Only
`descendantAddedEvent` | Event\<CoreObject ancestor, CoreObject new_child> | An event fired when a child is added to this object or any of its descendants. | Read-Only
`descendantRemovedEvent` | Event\<CoreObject ancestor, CoreObject removed_child> | An event fired when a child is removed from this object or any of its descendants. | Read-Only
`destroyEvent` | Event\<CoreObject> | An event fired when this object is about to be destroyed. | Read-Only
`networkedPropertyChangedEvent` | Event\<CoreObject owner, string propertyName> | An event that is fired whenever any of the networked custom properties on this object receive an update. The event is fired on the server and the client. Event payload is the owning object and the name of the property that just changed. | Read-Only

Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetTransform()` | Transform | The transform relative to this object’s parent. | None
`SetTransform(Transform)` | None | The transform relative to this object’s parent. | Dynamic
`GetPosition()` | Vector3 | The position of this object relative to its parent. | None
`SetPosition(Vector3)` | None | The position of this object relative to its parent. | Dynamic
`GetRotation()` | Rotation | The rotation relative to its parent. | None
`SetRotation(Rotation)` | None | The rotation relative to its parent. | Dynamic
`GetScale()` | Vector3 | The scale relative to its parent. | None
`SetScale(Vector3)` | None | The scale relative to its parent. | Dynamic
`GetWorldTransform()` | Transform | The absolute transform of this object. | None
`SetWorldTransform()` | None | The absolute transform of this object. | Dynamic
`GetWorldPosition()` | Vector3 | The absolute position. | None
`SetWorldPosition (Vector3)` | None | The absolute position. | Dynamic
`GetWorldRotation()` | Rotation | The absolute rotation. | None
`SetWorldRotation(Rotation)` | None | The absolute rotation. | Dynamic
`GetWorldScale()` | Vector3 | The absolute scale. | None
`SetWorldScale(Vector3)` | None | The absolute scale. | Dynamic
`GetVelocity()` | Vector3 | The object’s velocity in world space. | None
`SetVelocity(Vector3)` | None | The object’s velocity in world space. Only true for physics objects. | Dynamic
`GetAngularVelocity()` | Vector3 | The object’s angular velocity in degrees per second. | None
`SetAngularVelocity(Vector3)` | None | Set the object’s angular velocity in degrees per second in world space. Physics networked Objects only. | Dynamic
`SetLocalAngularVelocity(Vector3)` | None | Set the object’s angular velocity in degrees per second in local space. Physics networked Objects only. | Dynamic
`GetReference()` | CoreObjectReference | Returns a CoreObjectReference pointing at this object. | None
`GetChildren()` | array\<CoreObject> | Returns a table containing the object’s children, may be empty. | None
`FindAncestorByName(string name)` | CoreObject | Returns the first parent or ancestor whose name matches the provided name.  If none match, returns nil. | None
`FindChildByName(string name)` | CoreObject | Returns the first immediate child whose name matches the provided name.  If none match, returns nil. | None
`FindDescendantByName(string name)` | CoreObject | Returns the first child or descendant whose name matches the provided name.  If none match, returns nil. | None
`FindDescendantsByName(string name)` | array\<CoreObject> | Returns the descendants whose name matches the provided name.  If none match, returns an empty table. | None
`FindAncestorByType(string type_name)` | CoreObject | Returns the first parent or ancestor whose type is or extends the specified type.  For example, calling FindAncestorByType('CoreObject') will return the first ancestor that is any type of CoreObject, while FindAncestorByType(‘StaticMesh’) will only return the first static mesh. If no ancestors match, returns nil. | Static
`FindChildByType(string type_name)` | CoreObject | Returns the first immediate child whose type is or extends the specified type.  If none match, returns nil. | None
`FindDescendantByType(string type_name)` | CoreObject | Returns the first child or descendant whose type is or extends the specified type.  If none match, returns nil. | None
`FindDescendantsByType(string type_name)` | array\<CoreObject> | Returns the descendants whose type is or extends the specified type.  If none match, returns an empty table. | None
`FindTemplateRoot()` | CoreObject | If the object is part of a template, returns the root object of the template (which may be itself). If not part of a template, returns nil. | None
`IsAncestorOf(CoreObject)` | bool | Returns true if this core object is a parent somewhere in the hierarchy above the given parameter object. False otherwise. | None
`GetCustomProperty(string property_name)` | value, bool | Gets data which has been added to an object using the custom property system.  Returns the value, which can be an Integer, Number, bool, string, Vector3, Rotator, Color, a MUID string, or nil if not found.  Second return value is a bool, true if found and false if not. | None
`SetNetworkedCustomProperty(string PropertyName, Object)` | None | Sets the named custom property if it is marked as replicated and the object it belongs to is non-static, and server-side networked or in a client/server context. | Client Context, Static
`AttachToPlayer(Player, String SocketName)` | None | Attaches a CoreObject to a Player at a specified socket. The CoreObject will be un-parented from its current hierarchy and its ‘parent’ property will be nil. Socket names are: root, pelvis, spine, right_hip, right_knee, right_ankle, left_hip, left_knee, left_ankle, right_shoulder, right_elbow, right_prop, left_shoulder, left_elbow, left_prop, topper, camera. | Dynamic
`AttachToLocalView()` | None | Attaches a CoreObject to the local player’s camera. This should be called inside a Client Context. Reminder to turn off the object’s collision otherwise it will cause camera to jitter. | Client Context, Dynamic.
`Detach()` | None | Detaches a CoreObject from any player it has been attached to, or from its parent object. | Dynamic
`GetAttachedToSocketName()` | string | Returns the name of the socket this object is attached to. | None
`MoveTo(Vector3, Number, bool)` | None | Smoothly moves the object to the target location over a given amount of time (seconds). Third parameter specifies if this should be done in local space (true) or world space (false). | Dynamic
`RotateTo(Rotation/Quaternion, Number, bool=false)` | None | Smoothly rotates the object to the target orientation over a given amount of time. Third parameter specifies if this should be done in local space (true) or world space (false). | Dynamic
`ScaleTo(Vector3, Number, bool)` | None | Smoothly scales the object to the target scale over a given amount of time. Third parameter specifies if this should be done in local space (true) or world space (false). | Dynamic
`MoveContinuous(Vector3, bool)` | None | Smoothly moves the object over time by the given velocity vector. Second parameter specifies if this should be done in local space (true) or world space (false). | Dynamic
`RotateContinuous(Rotation/Quaternion, Number, bool)` | None | Smoothly rotates the object over time by the given angular velocity. Because the limit is 179°, the second param is an optional multiplier, for very fast rotations. Third parameter specifies if this should be done in local space (true) or world space (false (default)). | Dynamic
`ScaleContinuous(Vector3, bool)` | None | Smoothly scales the object over time by the given scale vector per second. Second parameter specifies if this should be done in local space (true) or world space (false). | Dynamic
`StopMove()` | None | Interrupts further movement from MoveTo(), MoveContinuous(), or Follow(). | Dynamic
`StopRotate()` | None | Interrupts further rotation from RotateTo() or RotateContinuous() and LookAt() or LookAtContinuous(). | Dynamic
`StopScale()` | None | Interrupts further movement from ScaleTo() or ScaleContinuous(). | Dynamic
`Follow(CoreObject, Number, Number)` | None | Follows a dynamic object at a certain speed. If the speed is not supplied it will follow as fast as possible. The third parameter specifies a distance to keep away from the target. | Dynamic
`LookAt(Vector3 position)` | None | Instantly rotates the object to look at the given position. | Dynamic
`LookAtContinuous(CoreObject, bool, Number)` | None | Smoothly rotates a CoreObject to look at another given CoreObject. Second parameter is optional and locks the pitch.  (Default is unlocked.)  Third parameter is how fast it tracks the target. If speed is not supplied it tracks as fast as possible. | Dynamic
`LookAtLocalView(bool)` | None | Continuously looks at the local camera. The bool parameter is optional and locks the pitch. (Client-only) | Client Context, Dynamic
`Destroy()` | None | Destroys the object and all descendants. You can check whether an object has been destroyed by calling `Object.IsValid(object)`, which will return true if object is still a valid object, or false if it has been destroyed. | Dynamic

### [CoreObjectReference](/core_api/classes/coreobjectreference/coreobjectreferenceOverview)

A reference to a CoreObject which may or may not exist.  This type is returned by CoreObject:GetCustomProperty() for Core Object Reference properties, and may be used to find the actual object if it exists.  (For networked objects, it is possible to get a CoreObjectReference pointing to a CoreObject that hasn’t been received on the client yet.)

Property | Return Value | Description | Tags
--- | --- | --- | ---
`id` | string | The MUID of the referred object. | Read-Only
`isAssigned` | bool | Returns true if this reference has been assigned a valid ID. (This does not necessarily mean the object currently exists.) | Read-Only

Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetObject()` | CoreObject | Returns the CoreObject with a matching ID, if it exists.  Will otherwise return nil. | None
`WaitForObject([Number])` | CoreObject | Returns the CoreObject with a matching ID, if it exists.  If it does not, yields the current task until the object is spawned.  Optional timeout parameter will cause the task to resume with a return value of false and an error message if the object has not been spawned within that many seconds. | None

### [Damage](/core_api/classes/damage/damageOverview)

To damage a Player, you can simply write e.g.: `whichPlayer:ApplyDamage(Damage.New(10))`. Alternatively, create a Damage object and populate it with all the following properties to get full use out of the system:

Property | Return Value | Description | Tags
--- | --- | --- | ---
`amount` | Number | The numeric amount of damage to inflict. | Read-Write
`reason` | Damage/Reason | What is the context for this Damage? DamageReason.UNKNOWN (default value), DamageReason.COMBAT, DamageReason.FRIENDLY_FIRE, DamageReason.MAP, DamageReason.NPC | Read-Write
`sourceAbility` | Ability | Reference to the Ability which caused the Damage. Setting this automatically sets sourceAbilityName. | Read-Write
`sourcePlayer` | Player | Reference to the Player who caused the Damage. Setting this automatically sets sourcePlayerName. | Read-Write

Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetHitResult()` | HitResult | Get the HitResult information if this damage was caused by a Projectile impact. | None
`SetHitResult(HitResult)` | None | Forward the HitResult information if this damage was caused by a Projectile impact. | None

### [Equipment](/core_api/classes/equipment/equipmentOverview)

Equipment is a CoreObject representing an equippable item for players.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`socket` | string | Determines which point on the avatar’s body this equipment will be attached. | Read-Write, Dynamic
`owner` | Player | Which Player the Equipment is attached to. | Read-Only, Dynamic
`equippedEvent` | Event\<Equipment, Player> | An event fired when this equipment is equipped onto a player. | Read-Only
`unequippedEvent` | Event\<Equipment, Player> | An event fired when this object is unequipped from a player. | Read-Only

Function | Return Value | Description | Tags
--- | --- | --- | ---
`Equip(Player)` | None | Attaches the Equipment to a Player. They gain any abilities assigned to the Equipment. If the Equipment is already attached to another Player it will first unequip from that other Player before equipping unto the new one. | None
`Unequip()` | None | Detaches the Equipment from any Player it may currently be attached to. The player loses any abilities granted by the Equipment. | None
`AddAbility(Ability)` | None | Adds an Ability to the list of abilities on this Equipment. | None
`GetAbilities()` | array\<Ability> | A table of Abilities that are assigned to this Equipment. Players who equip it will get these Abilities. | None

### [Event](/core_api/classes/event/eventOverview)

When objects have events that can be fired, they’re accessed using the Event type.  

Function | Return Value | Description | Tags
--- | --- | --- | ---
`Connect(function eventListener)` | EventListener | Registers the given function which will be called every time the event is fired.  Returns an EventListener which can be used to disconnect from the event or check if the event is still connected. | None

### [EventListener](/core_api/classes/eventlistener/eventlistenerOverview)

EventListeners are returned by Events when you connect a listener function to them.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`isConnected` | bool | true if this listener is still connected to its event. false if the event owner was destroyed or if Disconnect was called. | Read-Only

Function | Return Value | Description | Tags
--- | --- | --- | ---
`Disconnect()` | None | Disconnects this listener from its event, so it will no longer be called when the event is fired. | None

### [Folder](/core_api/classes/folder/folderOverview)

Folder is a CoreObject representing a folder containing other objects.  It currently has no properties or functions of its own, but inherits everything from CoreObject.

### [HitResult](/core_api/classes/hitresult/hitresultOverview)

Contains data pertaining to an impact or raycast.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`other` | CoreObject or Player | Reference to a CoreObject or Player impacted. | None
`socketName` | string | If the hit was on a player, socketName tells you which spot on the body was hit. | Read-Only

Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetImpactPosition()` | Vector3 | The world position where the impact occurred. | None
`GetImpactNormal()` | Vector3 | Normal direction of the surface which was impacted. | None
`GetTransform()` | Transform | Returns a Transform composed of the position of the impact in world space, the rotation of the normal, and a uniform scale of 1. | None

### [ImageUIControl](/core_api/classes/imageuicontrol/imageuicontrolOverview)

A UIControl for displaying an image.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`isTeamColorUsed` | bool | If true, the image will be tinted blue if its team matches the player, or red if not | None
`team` | Integer | the team of the image, used for isTeamColorUsed | None

Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetColor()` | Color | The tint to apply to the image | None
`SetColor(Color)` | None | The tint to apply to the image | None
`SetImage(imageId)` | None | Set image. You can get this muid from an asset reference. | None
`GetImage()` | string | Returns the imageId assigned to this Image control. | None
`SetImage(Player)` | None | Downloads and sets a Player’s profile picture as the texture for this Image control. | None

### [Light](/core_api/classes/light/lightOverview)

Light is a light source that is a CoreObject.  Generally a Light will be an instance of some subtype, such as PointLight or SpotLight.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`intensity` | Number | The intensity of the light. For PointLights and SpotLights, this has two interpretations, depending on the value of the hasNaturalFallOff property. If true: the light's Intensity is in units of lumens, where 1700 lumens is a 100W lightbulb. If false: the light's Intensity is a brightness scale. | Read-Write, Dynamic
`attenuationRadius` | Number | Bounds the light's visible influence. This clamping of the light's influence is not physically correct but very important for performance, larger lights cost more. | Read-Write, Dynamic
`isShadowCaster` | bool | Does this light cast shadows? | Read-Write, Dynamic
`hasTemperature` | Number | true: use temperature value as illuminant. false: use white (D65) as illuminant. | Read-Write, Dynamic
`temperatur` | Number | Color temperature in Kelvin of the blackbody illuminant. White (D65) is 6500K. | Read-Write, Dynamic
`team` | Integer | Assigns the light to a team. Value range from 0 to 4. 0 is neutral team | Read-Write, Dynamic
`isTeamColorUsed` | bool | If true, and the light has been assigned to a valid team, players on that team will see a blue light, while other players will see red. | Read-Write, Dynamic

Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetColor()` | Color | The color of the light. | None
`SetColor(Color)` | None | The color of the light. | Dynamic

### [MovementSettings](/core_api/classes/movementsettings/movementsettingsOverview)

Function | Return Value | Description | Tags
--- | --- | --- | ---
`ApplyToPlayer(Player)` | None | Apply settings from this settings object to player. Should be called on server. | None

### [NetworkContext](/core_api/classes/networkcontext/networkcontextOverview)

NetworkContext is a CoreObject representing a special folder containing client-only, server-only, or static objects.  It currently has no properties or functions of its own, but inherits everything from CoreObject.

### [Object](/core_api/classes/object/objectOverview)

At a high level, CORE Lua types can be divided into two groups: data structures and Objects.  Data structures are owned by Lua, while Objects are owned by the engine and could be destroyed while still referenced by Lua.  Any such object will inherit from this type.  These include Ability, CoreObject, Player, and Projectile.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`serverUserData` | table | Table in which users can store any data they want on the server. | Read-Only
`clientUserData` | table | Table in which users can store any data they want on the client. | Read-Only

Static Functions | Return Value | Description | Tags
--- | --- | --- | ---
`IsValid(Object object)` | bool | Returns true if object is still a valid Object, or false if it has been destroyed.  Also returns false if passed a nil value or something that’s not an Object, such as a Vector3 or a string. | None

### [PanelUIControl](/core_api/classes/paneluicontrol/paneluicontrolOverview)

A UIControl which can be used for containing and laying out other UI controls.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`shouldClipChildren(bool)` | bool | If True, children of this panel will not draw outside of its bounds. | None

### [PerPlayerReplicator](/core_api/classes/perplayerreplicator/perplayerreplicatorOverview)

Per-player replicator is a CoreObject used to replicate data for specific players. They are similar to normal replicators in that you add custom properties for the values you want to replicate, but are accessed quite differently. At runtime, request a player’s personal replicator and use the standard Replicator API to retrieve and set data. Note that clients can access other client’s replicators.

Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetPlayerReplicator(Player)` | Replicator | Returns the replicator for the specified player. Can be nil if the replicator hasn’t spawned on the client yet. | None

### [Player](/core_api/classes/player/playerOverview)

Player is an Object representation of the state of a player connected to the game, as well as their avatar in the world.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`name` | string | The player’s name. | Read-Only
`id` | string | The unique id of the player. Consistent across sessions. | Read-Only
`team` | Number | The number of the team to which the player is assigned. By default, this value is 255 in FFA mode. | Read-Write
`animationStance` | string | Which set of animations to use for this player. Example values can be “unarmed_stance”, “1hand_melee_stance”, “1hand_pistol_stance”, “2hand_sword_stance” or “2hand_rifle_stance”. See  Animation Stance Information | Read-Write
`currentFacingMode` | FacingMode | Current mode applied to player, including possible overrides. Possible values are FacingMode.STRAFE and FacingMode.LOOSE. See desiredFacingMode for details. | None
`desiredFacingMode` | FacingMode | Which controls mode to use for this player. May be overridden by certain movement modes like MovementMode.SWIMMING or when mounted. Possible values are FacingMode.STRAFE and FacingMode.LOOSE. | Read-Write
`hitPoints` | Number | Current amount of hitpoints. | Read-Write
`maxHitPoints` | Number | Maximum amount of hitpoints. | Read-Write
`stepHeight` | Number | Maximum height in centimeters the player can step up. Range is 0-100, default is 45. | Read-Write
`walkSpeed` | Number | Walk speed as a fraction of default.  Range is 0-10, default is 1. | Read-Write
`swimSpeed` | Number | Swim speed as a fraction of default.  Range is 0-10, default is 1. | Read-Write
`maxAcceleration` | Number | Max Acceleration (rate of change of velocity). Default = 1200 | Read-Write
`brakingDecelerationFalling` | Number | Deceleration when falling and not applying acceleration. Default = 0 | Read-Write
`brakingDecelerationWalking` | Number | Deceleration when walking and movement input has stopped. Default = 512.0 | Read-Write
`groundFriction` | Number | Friction when walking on ground. Default = 8.0 | Read-Write
`brakingFrictionFactor` | Number | Multiplier for friction when braking. Default = 0.6 | Read-Write
`walkableFloorAngle` | Number | Max walkable floor angle, in degrees. Default = 44.765. There seem to be hard coded limit in unreal, so there is some upper limit it can go around 55 degrees (needs to verify) | Read-Write
`maxJumpCount` | Number | Max number of jumps, to enable multiple jumps. Set to 0 to disable jump | Read-Write
`jumpVelocity` | Number | Vertical speed applied to Player when they jump. | Read-Write
`gravityScale` | Number | Multiplier on gravity applied. Default = 1.9 | Read-Write
`maxSwimSpeed` | Number | Base swim speed (recommend use swimSpeed multiplier instead of this one). Default = 400 | Read-Write
`touchForceFactor` | Number | Force applied to physics objects when contacted with player. Default = 1 | Read-Write
`isCrouchEnabled` | bool | Turns crouching on/off for a player. | Read-Write
`mass` | Number | Gets the mass of the player. | Read-Only
`isAccelerating` | bool | True if the player is accelerating, such as from input to move. | Read-Only
`isCrouching` | bool | True if the player is crouching. | Read-Only
`isFlying` | bool | True if the player is flying. | Read-Only
`isGrounded` | bool | True if the player is on the ground with no upward velocity, otherwise false | Read-Only
`isJumping` | bool | True if the player is jumping. | Read-Only
`isMounted` | bool | True if the player is mounted on another object. | Read-Only
`isSwimming` | bool | True if the player is swimming in water. | Read-Only
`isWalking` | bool | True if the player is in walking mode. | Read-Only
`isDead` | bool | True if the player is dead, otherwise false. Can be set as well. | Read-Write
`isSliding` | bool | True if the player is currently in sliding mode. | Read-Only
`movementControlMode` | MovementControlMode | Possible values are MovementControlMode.NONE, MovementControlMode.LOOK_RELATIVE, MovementControlMode.VIEW_RELATIVE, MovementControlMode.FIXED_AXES. | Read-Write
`lookControlMode` | LookControlMode | Possible values are LookControlMode.NONE, LookControlMode.RELATIVE. | Read-Write
`lookSensitivity` | Number | multiplier on player look rotation speed relative to cursor movement. Default is 1.0. This is independent from player preference, both will be applied as multipliers together. | Read-Write
`spreadModifier` | Number | Added to the player’s targeting spread | Read-Write
`buoyancy` | Number | in water, buoyancy 1.0 is neutral (won’t sink or float naturally). Less than 1 to sink, greater than 1 to float. | Read-Write
`canMount` | bool | whether the player can manually toggle on/off the mount | Read-Write
`shouldDismountWhenDamaged` | bool | If true, and the player is mounted they will dismount if they take damage. | Read-Write
`isVisibleToSelf` | bool | Set whether to hide player model on player’s own client, for sniper scope, etc. Client-only. | Client Context, Read-Write
`damagedEvent` | Event\<Player, Damage> | Event fired when the Player takes damage. Server only. | Server Context, Read-Only
`diedEvent` | Event\<Player, Damage> | Event fired when the Player dies.  Server only. | Server Context, Read-Only
`respawnedEvent` | Event\<Player> | Event fired when the Player respawns.  Server only. | Server Context, Read-Only
`bindingPressedEvent` | Event\<Player, String> | Event fired when an action binding is pressed. Second parameter tells you which binding. Possible values of the bindings are listed under ability binding list | Read-Only
`bindingReleasedEvent` | Event\<Player, String> | Event fired when an action binding is released. Second parameter tells you which binding. | Read-Only
`resourceChangedEvent` | Event\<Player> | Event fired when a resource changed | Read-Only
`movementModeChangedEvent` | Event\<Player, MovementMode, MovementMode> | Event fired when a player’s movement mode changes. The first parameter is the player being changed. The second parameter is the “new” movement mode. The third parameter is the “previous” movement mode. Values for MovementMode enum are: NONE, WALKING, FALLING, SWIMMING, FLYING and SLIDING. Server only. | Server Context, Read-Only
`animationEvent` | Event\<Player>,EventName | Event fired during certain animations played on a player. Client only. | Client Context

Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetTransform()` | Transform | The transform relative to this object’s parent. | None
`SetTransform (Transform)` | None | The transform relative to this object’s parent. | None
`GetPosition()` | Vector3 | The position of this object relative to its parent. | None
`SetPosition (Vector3)` | None | The position of this object relative to its parent. | None
`GetRotation()` | Rotation | The rotation relative to its parent. | None
`SetRotation (Rotation)` | None | The rotation relative to its parent. | None
`GetScale()` | Vector3 | The scale relative to its parent. | None
`SetScale (Vector3)` | None | The scale relative to its parent. | None
`GetWorldTransform()` | Transform | The absolute transform of this object. | None
`SetWorldTransform (Transform)` | None | The absolute transform of this object. | None
`GetWorldPosition()` | Vector3 | The absolute position. | None
`SetWorldPosition (Vector3)` | None | The absolute position. | None
`GetWorldRotation()` | Rotation | The absolute rotation. | None
`SetWorldRotation (Rotation)` | None | The absolute rotation | None
`GetWorldScale()` | Vector3 | The absolute scale. | None
`SetWorldScale (Vector3)` | None | The absolute scale. | None
`AddImpulse (Vector3)` | Vector3 | Adds an impulse force to the player. | None
`GetVelocity()` | Vector3 | Gets current velocity of player | None
`ResetVelocity()` | None | Resets the player’s velocity to zero. | None
`GetRotationRate()` | Rotation | Maximum speed (in degrees) that the player can rotate per second. Set to -1 for immediate rotation. Currently only supports rotation around the Z-axis. | None
`SetRotationRate (Rotation)` | None | Maximum speed (in degrees) that the player can rotate per second. Set to -1 for immediate rotation. Currently only supports rotation around the Z-axis. | None
`GetAbilities()` | array<Ability> | Array of all Abilities assigned to this Player. | None
`GetEquipment()` | array<Equipment> | Array of all Equipment assigned to this Player. | None
`ApplyDamage(Damage)` | None | Damages a Player. If their hitpoints go below 0 they die. | None
`Die([Damage])` | None | Kills the Player. They will ragdoll and ignore further Damage. The optional Damage parameter is a way to communicate cause of death. | None
`DisableRagdoll()` | None | Disables all ragdolls that have been set on the player. | None
`SetVisibility(bool, bool)` | None | Shows or hides the player. The second parameter is optional, defaults to true, and determines if attachments to the player are hidden as well as the player. | None
`EnableRagdoll(string SocketName, Number Weight, bool CameraFollows)` | None | Enables ragdoll for the player, starting on “SocketName” weighted by “Weight” (between 0.0 and 1.0). This can cause the player capsule to detach from the mesh. Setting CameraFollows to true will force the player capsule to stay with the mesh. All parameters are optional; SocketName defaults to the root, Weight defaults to 1.0, CameraFollows defaults to true. Multiple bones can have ragdoll enabled simultaneously. | None
`Respawn([Vector, Rotation])` | None | Resurrects a dead Player based on respawn settings in the game (default in-place). Optional position and rotation parameters can be used to specify a location. | None
`GetViewWorldPosition()` | Vector3 | Get position of player’s camera view. Only works for local player. | None
`GetViewWorldRotation()` | Rotation | Get rotation of player’s camera view. Only works for local player. | None
`ClearResources()` | None | Removes all resources from a player. | None
`GetResource(String name)` | string | Returns the amount of a resource owned by a player. Returns 0 by default. | None
`SetResource(String name, Integer amount)` | None | Sets a specific amount of a resource on a player. | None
`AddResource(String name, Integer amount)` | None | Adds an amount of a resource to a player. | None
`RemoveResource(String name, Integer amount)` | None | Subtracts an amount of a resource from a player. Does not go below 0. | None
`GetResourceNames()` | array<String> | return array containing resource names | None
`GetResourceNamesStartingWith(String prefix)` | array<String> | return array containing resource names starting with given prefix | None
`TransferToGame(String)` | None |  Only works in play off web portal. Transfers player to the game specified by the passed-in game ID (the string from the web portal link). | None
`GetAttachedObjects()` | Table<CoreObjects> | return table containing core objects attached to this player. | None
`SetMounted(Bool)` | None | Forces a player in or out of mounted state. | None
`GetDefaultCamera()` | Camera | Returns the default camera object the player is currently using. This can only be called on the client. | None
`SetDefaultCamera(Camera, LerpTime = 2.0)` | None | Sets the default camera object for the player. This can only be called on the client. | None
`GetOverrideCamera()` | Camera | Returns the override camera object the player is currently using. This can only be called on the client. | None
`SetOverrideCamera(Camera, LerpTime = 2.0)` | None | Sets the override camera object for the player. This can only be called on the client. | None
`ClearOverrideCamera(LerpTime = 2.0)` | None | Clears the override camera object for the player (to revert back to the default camera). This can only be called on the client. | None
`ActivateFlying()` | None | Activates the player flying mode. | None
`ActivateWalking()` | None | Activate the player walking mode | None

### [PlayerStart](/core_api/classes/playerstart/playerstartOverview)

PlayerStart is a CoreObject representing a spawn point for players.  

Property | Return Value | Description | Tags
--- | --- | --- | ---
`team` | string | A tag controlling which players can spawn at this start point. | Read-Write, Dynamic

### [PointLight](/core_api/classes/pointlight/pointlightOverview)

PointLight is a placeable light source that is a CoreObject.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`hasNaturalFalloff` | bool | The attenuation method of the light. When enabled, attenuationRadius is used. When disabled, falloffExponent is used. Also changes the interpretation of the intensity property, see intensity for details. | Read-Write, Dynamic
`falloffExponent` | Number | Controls the radial falloff of the light when hasNaturalFalloff is false. 2.0 is almost linear and very unrealistic and around 8.0 it looks reasonable. With large exponents, the light has contribution to only a small area of its influence radius but still costs the same as low exponents. | Read-Write, Dynamic
`sourceRadius` | Number | Radius of light source shape. | Read-Write, Dynamic
`sourceLength` | Number | Length of light source shape. | Read-Write, Dynamic

### [ProgressBarUIControl](/core_api/classes/progressbaruicontrol/progressbaruicontrolOverview)

A UIControl that displays a filled rectangle which can be used for things such as a health indicator.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`progress` | Number | From 0 to 1, how full the bar should be. | None

Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetFillColor()` | Color | The color of the fill. | None
`SetFillColor(Color)` | None | The color of the fill. | None


### [Projectile](/core_api/classes/projectile/projectileOverview)

Projectile is a specialized Object which moves through the air in a parabolic shape and impacts other objects. To spawn a projectile see `game:SpawnProjectile()`.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`owner` | Player | The player who fired this projectile. Setting this property ensures the Projectile does not impact the owner or their allies. This will also change the color of the projectile if teams are being used in the game. | Read-Write
`sourceAbility` | Ability | Reference to the ability from which the projectile was created. | Read-Write
`speed` | Number | Centimeters per second movement. Default 5000. | Read-Write
`maxSpeed` | Number | Max cm/s. Default 0. Zero means no limit. | Read-Write
`gravityScale` | Number | How much drop. Default 1. 1 means normal gravity. Zero can be used to make a Projectile go in a straight line. | Read-Write
`drag` | Number | Deceleration. Important for homing Projectiles (try a value around 5). Negative drag will cause the Projectile to accelerate. Default 0. | Read-Write
`bouncesRemaining` | Integer | Number of bounces remaining before it dies. Default 0. | Read-Write
`bounciness` | Number | Velocity % maintained after a bounce. Default 0.6. | Read-Write
`lifeSpan` | Number | Max seconds the projectile will exist. Default 10. | Read-Write
`shouldBounceOnPlayers` | bool | Determines if the projectile should bounce off players or be destroyed, when bouncesRemaining is used. Default false. | Read-Write
`piercesRemaining` | Integer | Number of objects that will be pierced before it dies. A piercing Projectile loses no velocity when going through objects, but still fires the impactEvent event. If combined with bounces, all piercesRemaining are spent before bouncesRemaining are counted. Default 0. | Read-Write
`capsuleRadius` | Number | Shape of the projectile’s collision. Default 22. | Read-Write
`capsuleLength` | Number | Shape of the projectile’s collision. A value of zero will make it shaped like a Sphere. Default 44. | Read-Write
`homingTarget` | Player | The projectile accelerates towards its target. | Read-Write
`homingAcceleration` | Number | Magnitude of acceleration towards the target. Default 10,000. | Read-Write
`shouldDieOnImpact` | bool | If true the projectile is automatically destroyed when it hits something, unless it has bounces remaining. Default true. | Read-Write
`impactEvent` | Event<Projectile, other Object, HitResult> | An event fired when the Projectile collides with something. Impacted object parameter will be either of type CoreObject or Player, but can also be nil. The HitResult describes the point of contact between the Projectile and the impacted object. | Read-Only
`lifeSpanEndedEvent` | Event<Projectile> | An event fired when the Projectile reaches the end of its lifespan. Called before it is destroyed. | Read-Only
`homingFailedEvent` | Event<Projectile> | The target is no longer valid, for example the player disconnected from the game or the object was destroyed somehow. | Read-Only

Function | Return Value | Description | Tags
--- | --- | --- | ---
`destroy()` | Object | Immediately destroys the object. | None
`GetWorldTransform()` | Transform | Transform data for the Projectile in world space. | None
`GetWorldPosition()` | Vector3 | Position of the Projectile in world space. | None
`SetWorldPosition(Vector3)` | None | Position of the Projectile in world space. | None
`GetVelocity()` | Vector3 | Current direction and speed vector of the Projectile. | None
`SetVelocity(Vector3)` | None | Current direction and speed vector of the Projectile. | None

Static Function | Return Value | Description | Tags
--- | --- | --- | ---
`Spawn(string child_template_id, Vector3 start_position, Vector3 direction)` | Projectile | Spawns a Projectile with a child that is an instance of a template. | None

### [Quaternion](/core_api/classes/quaternion/quaternionOverview)

A quaternion-based representation of a rotation.

Constructor | Return Value | Description | Tags
--- | --- | --- | ---
`Quaternion.New(Number x, Number y, Number z, Number w)` | Quaternion | Construct with the given values. | None
`Quaternion.New(Rotation r)` | Quaternion | Construct with the given Rotation. | None
`Quaternion.New(Vector3 axis, Number angle)` | Quaternion | Construct a quaternion representing a rotation of angle radians around the axis Vector3. | None
`Quaternion.New(Vector3 from, Vector3 to)` | Quaternion | Construct a rotation between the from and to vectors. | None
`Quaternion.New(Quaternion q)` | Quaternion | Copies the given Quaternion. | None
`Quaternion.IDENTITY` | Quaternion | Predefined quaternion with no rotation. | None

Property | Return Value | Description | Tags
--- | --- | --- | ---
`x` | Number | The X component of the quaternion. | Read-Write
`y` | Number | The Y component of the quaternion. | Read-Write
`z` | Number | The Z component of the quaternion. | Read-Write
`w` | Number | The W component of the quaternion. | Read-Write

Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetRotation()` | Rotation | Get the Rotation representation of the quaternion. | None
`GetForwardVector()` | Vector3 | Forward unit vector rotated by the quaternion. | None
`GetRightVector()` | Vector3 | Right unit vector rotated by the quaternion. | None
`GetUpVector()` | Vector3 | Up unit vector rotated by the quaternion. | None

Class Function | Return Value | Description | Tags
--- | --- | --- | ---
`Slerp(Quaternion from, Quaternion to, Number progress)` | Quaternion | Spherical interpolation between two quaternions by the specified progress amount and returns the resultant, normalized Quaternion. | None

Operator | Return Value | Description | Tags
--- | --- | --- | ---
`Quaternion + Quaternion` | Quaternion | Component-wise addition. | None
`Quaternion - Quaternion` | Quaternion | Component-wise subtraction. | None
`Quaternion * Quaternion` | Quaternion | Compose two quaternions, with the result applying the right rotation first, then the left rotation second. | None
`Quaternion * Number` | Quaternion | Multiplies each component by the right-side Number. | None
`Quaternion * Vector3` | Quaternion | Rotates the right-side vector and returns the result. | None
`Quaternion / Number` | Quaternion | Divides each component by the right-side Number. | None
`-Quaternion` | Quaternion | Returns the inverse rotation. | None

### [RandomStream](/core_api/classes/randomstream/randomstreamOverview)

Seed-based random stream of numbers. Useful for deterministic RNG problems, for instance, inside a Client Context so all players get the same outcome without the need to replicate lots of data from the server. Bad quality in the lower bits (avoid combining with modulus operations).

Constructor | Return Value | Description | Tags
--- | --- | --- | ---
`RandomStream.New()` | RandomStream | Constructor with seed 0. | None
`RandomStream.New(Integer)` | RandomStream | Constructor with specified seed. | None

Property | Return Value | Description | Tags
--- | --- | --- | ---
`seed` | Number | The current seed used for RNG. | Read-Write

Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetInitialSeed()` | Integer | The seed that was used to initialize this stream. | None
`Reset()` | None | Function that sets the seed back to the initial seed. | None
`Mutate()` | None | Moves the seed forward to the next seed. | None
`GetNumber(Number Min, Number Max)` | Number | Returns a floating point number between Min and Max (inclusive).  Call with no arguments to get a number between 0 and 1 (exclusive). | None
`GetInteger(Integer Min, Integer Max)` | Number | Returns an integer number between Min and Max (inclusive). | None
`GetVector3()` | Vector3 | Returns a random unit vector. | None
`GetVector3FromCone(Vector3 Direction, Number HalfAngle)` | Vector3 | Returns a random unit vector, uniformly distributed, from inside a cone defined by Direction and HalfAngle (in radians). | None
`GetVector3FromCone(Vector3 Direction, Number HorizontalAngle, Number VerticalAngle)` | Vector3 | Returns a random unit vector, uniformly distributed, from inside a cone defined by Direction, HorizontalAngle and VerticalAngle (in radians). | None


### [Replicator](/core_api/classes/replicator/replicatorOverview)

Replicators are CoreObjects are used to broadcast data from the server to clients. To use them, add custom properties to a replicator and assign them default values. These properties will be readable on all clients, and read/write on the server.

Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetValue(string)` | Object, bool | Returns the named custom property and whether or not the property was found. | None
`SetValue(string, Object)` | bool | Sets the named custom property and returns whether or not it was set successfully. Reasons for failure are not being able to find the property or the Object property being the wrong type. | None

Event | Return Value | Description | Tags
--- | --- | --- | ---
`valueChangedEvent` | Event<Replicator, string propertyName> | An event that is fired whenever any of the properties managed by the replicator receives an update. The event is fired on the server and the client. Event payload is the Replicator object and the name of the property that just changed. | Read-Only

### [Rotation](/core_api/classes/rotation/rotationOverview)

An immutable euler-based rotation around X, Y, and Z axes.

Constructor | Return Value | Description | Tags
--- | --- | --- | ---
`Rotation.New()` | Rotation | Creates a non-rotation (0, 0, 0). | None
`Rotation.New(Number x, Number y, Number z)` | Rotation | Construct with the given values. | None
`Rotation.New(Quaternion q)` | Rotation | Construct a rotation using the given Quaternion. | None
`Rotation.New(Vector3 forward, Vector3 up)` | Rotation | Construct a rotation that will rotate Vector3.FORWARD to point in the direction of the given forward vector, with the up vector as a reference.  Returns (0, 0, 0) if forward and up point in the exact same (or opposite) direction, or if one of them is of length 0. | None
`Rotation.New(Rotation r)` | Rotation | Copies the given Rotation. | None
`Rotation.ZERO` | Rotation | Constant rotation of (0, 0, 0) | None

Property | Return Value | Description | Tags
--- | --- | --- | ---
`x` | Number | The X component of the rotation. | Read-Write
`y` | Number | The Y component of the rotation. | Read-Write
`z` | Number | The Z component of the rotation. | Read-Write

Operator | Return Value | Description | Tags
--- | --- | --- | ---
`Rotation + Rotation` | Rotation | Add two rotations together. | None
`Rotation - Rotation` | Rotation | Subtract a rotation. | None
`Rotation * Number` | Rotation | Returns the scaled rotation. | None
`-Rotation` | Rotation | Returns the inverse rotation. | None

### [Script](/core_api/classes/script/scriptOverview)

Script is a CoreObject representing a script.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`context` | table | Returns the table containing any non-local variables and functions created by the script.  This can be used to call (or overwrite!) functions on another script. | Read-Only

!!! Note
    While not technically a property, a script can access itself using the `script` variable.

### [SpotLight](/core_api/classes/spotlight/spotlightOverview)

SpotLight is a Light that shines in a specific direction from the location at which it is placed.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`hasNaturalFalloff` | bool | The attenuation method of the light. When enabled, attenuationRadius is used. When disabled, falloffExponent is used. Also changes the interpretation of the intensity property, see intensity for details. | Read-Write, Dynamic
`falloffExponent` | Number | Controls the radial falloff of the light when hasNaturalFalloff is false. 2.0 is almost linear and very unrealistic and around 8.0 it looks reasonable. With large exponents, the light has contribution to only a small area of its influence radius but still costs the same as low exponents. | Read-Write, Dynamic
`sourceRadius` | Number | Radius of light source shape. | Read-Write, Dynamic
`sourceLength` | Number | Length of light source shape. | Read-Write, Dynamic
`innerConeAngle` | Number | The angle (in degrees) of the cone within which the projected light achieves full brightness. | Read-Write, Dynamic
`outerConeAngle` | Number | The outer angle (in degrees) of the cone of light emitted by this SpotLight. | Read-Write, Dynamic

### [SmartAudio](/core_api/classes/smartaudio/smartaudioOverview)

SmartAudio objects are SmartObjects that wrap sound files. Similar to Audio objects, they have many of the same properties and functions.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`isPlaying` | bool | Returns if the sound is currently playing. | Read-Only
`isSpatializationEnabled` | bool | Default true. Set to false to play sound without 3D positioning. | Read-Write, Dynamic
`isAutoPlayEnabled` | bool | Default false. If set to true when placed in the editor (or included in a template), the sound will be automatically played when loaded. | Read-Only
`isTransient` | bool | Default false. If set to true, the sound will automatically destroy itself after it finishes playing. | Read-Write
`isAutoRepeatEnabled` | bool | Loops when playback has finished. Some sounds are designed to automatically loop, this flag will force others that don't (can be useful for looping music.) | Read-Write
`pitch` | Number | Default 1. Multiplies the playback pitch of a sound. Note that some sounds have clamped pitch ranges (so 0.2-1 will work, above 1 might not.) | Read-Write
`volume` | Number | Default 1. Multiplies the playback volume of a sound. Note that values above 1 can distort sound, so if you're trying to balance sounds, experiment to see if scaling down works better than scaling up. | Read-Write
`radius` | Number | Default 0 (off.) If non-zero, will override default 3D spatial parameters of the sound. Radius is the distance away from the sound position that will be played at 100% volume. | Read-Write
`falloff` | Number | Default 0 (off). If non-zero, will override default 3D spatial parameters of the sound. Falloff is the distance outside the radius over which the sound volume will gradually fall to zero. | Read-Write

Function | Return Value | Description | Tags
--- | --- | --- | ---
`Play()` | None | Begins sound playback. | None
`Stop()` | None | Stops sound playback. | None


### [SmartObject](/core_api/classes/smartobject/smartobjectOverview)

SmartObject is the top-level container of a blueprint “smart object” that has been placed in the game.  It inherits everything from CoreObject.  Note that some properties, such as `isCollidable` or `isVisible`, may not be respected by the contents of the blueprint.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`GetSmartProperty(string property_name)` | value, bool | Gets the current value of an exposed blueprint variable.  Returns the value, which can be an Integer, Number, bool, string, Vector3, Rotator, Color, or nil if not found.  Second return value is a bool, true if found and false if not. | None
`SetSmartProperty(string property_name, value)` | bool | Sets the value of an exposed blueprint variable.  Value, which can be a Number, bool, string, Vector3, Rotation, or Color, but must match the type of the property on the blueprint.  Returns true if set successfully and false if not. | None

### [StaticMesh](/core_api/classes/staticmesh/staticmeshOverview)

StaticMesh is a CoreObject representing a static mesh.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`isSimulatingPhysics` | bool | If true, physics will be enabled for the mesh. | Read-Write, Dynamic
`team` | Integer | Assigns the mesh to a team. Value range from 0 to 4. 0 is neutral team | Read-Write, Dynamic
`isTeamColorUsed` | Color | If true, and the mesh has been assigned to a valid team, players on that team will see a blue mesh, while other players will see red. (Requires a material that supports the color property.) | Read-Write, Dynamic
`isTeamCollisionEnabled` | bool | If false, and the mesh has been assigned to a valid team, players on that team will not collide with the mesh. | Read-Write, Dynamic
`isEnemyCollisionEnabled` | bool | If false, and the mesh has been assigned to a valid team, players on other teams will not collide with the mesh. | Read-Write, Dynamic
`isCameraCollisionEnabled` | bool | If false, the mesh will not push against the camera. Useful for things like railings or transparent walls. | Read-Write, Dynamic

Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetColor()` | Color | Overrides the color of all materials on the mesh, and replicates the new colors. | None
`SetColor(Color)` | None | Overrides the color of all materials on the mesh, and replicates the new colors. | Dynamic
`GetMaterialProperty(Integer slot, string property_name)` | value, bool | Gets the current value of a property on a material in a given slot.  Returns the value, which can be a Number, bool, Vector3, Color, or nil if not found.  Second return value is a bool, true if found and false if not. | None
`SetMaterialProperty(Integer slot, string property_name, value)` | bool | Sets the value of a property on a material in a given slot.  Value, which can be a Number, bool, Vector3, or Color, but must match the type of the property on the material.  Returns true if set successfully and false if not. | None
`ResetColor()` | Color | Turns off the color override, if there is one. | None

### [Task](/core_api/classes/task/taskOverview)

Task is a representation of a Lua thread.  It could be a Script initialization, a repeating tick() function from a Script, an EventListener invocation, or a Task spawned directly by a call to `Task.Spawn()`.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`id` | Number | A unique identifier for the task. | Read-Only
`repeatCount` | Number | If set to a non-negative number, the Task will execute that many times.  A negative number indicates the Task should repeat indefinitely (until otherwise canceled).  With the default of 0, the Task will execute once.  With a value of 1, the script will repeat once, meaning it will execute twice. | Read-Write
`repeatInterval` | Number | For repeating Tasks, the number of seconds to wait after the Task completes before running it again.  If set to 0, the Task will wait until the next frame. | Read-Write

Function | Return Value | Description | Tags
--- | --- | --- | ---
`Cancel()` | None | Cancels the Task immediately.  It will no longer be executed, regardless of the state it was in.  If called on the currently executing Task, that Task will halt execution. | None
`GetStatus()` | TaskStatus | Returns the status of the Task. Possible values include: TaskStatus.UNINITIALIZED, TaskStatus.SCHEDULED, TaskStatus.RUNNING, TaskStatus.COMPLETED, TaskStatus.YIELDED, TaskStatus.FAILED, TaskStatus.CANCELED. | None

Class functions | Return Value | Description | Tags
--- | --- | --- | ---
`Spawn(function taskFunction, [Number delay])` | Task | Creates a new Task which will call taskFunction without blocking the current task.  The optional delay parameter specifies how many seconds before the task scheduler should run the Task.  By default, the scheduler will run the Task at the end of the current frame. | None
`GetCurrent()` | Task | Returns the currently running Task. | None
`Wait([Number delay])` | Number | Yields the current Task, resuming in delay seconds, or during the next frame if delay is not specified. | None

### [Terrain](/core_api/classes/terrain/terrainOverview)

Terrain is a CoreObject representing terrain placed in the world.

### [Text](/core_api/classes/text/textOverview)

Text is an in-world text CoreObject.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`text` | string | The text being displayed by this object. | Read-Write, Dynamic
`horizontalScale` | Number | The horizontal size of the text. | Read-Write, Dynamic
`verticalScale` | Number | The vertical size of the text. | Read-Write, Dynamic

Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetColor()` | Color | The color of the text. | None
`SetColor(Color)` | None | The color of the text. | Dynamic

### [TextUIControl](/core_api/classes/textuicontrol/textuicontrolOverview)

A UIControl which displays a basic text label.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`text` | string | The actual text string to show. | None
`fontSize` | Number | Font size | None
`justification` | TextJustify | Enum that determines alignment of text.  Possible values are: TextJustify.LEFT, TextJustify.Right, and TextJustify.CENTER. | None
`shouldWrapText` | bool | Whether or not text should be wrapped within the bounds of this control. | None
`shouldClipText` | bool | Whether or not text should be clipped when exceeding the bounds of this control. | None

Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetColor()` | Color | The color of the text. | None
`SetColor(Color)` | None | The color of the text. | None

### [TextUIControl](/core_api/classes/textuicontrol/textuicontrolOverview)

Transforms represent the position, rotation, and scale of objects in the game.  They are immutable, but new Transforms can be created when you want to change an object’s transform.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`text` | string | The actual text string to show. | None
`fontSize` | Number | Font size | None
`justification` | TextJustify | Enum that determines alignment of text.  Possible values are: TextJustify.LEFT, TextJustify.Right, and TextJustify.CENTER. | None
`shouldWrapText` | bool | Whether or not text should be wrapped within the bounds of this control. | None
`shouldClipText` | bool | Whether or not text should be clipped when exceeding the bounds of this control. | None

Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetColor()` | Color | The color of the text. | None
`SetColor(Color)` | None | The color of the text. | None

### [Transform](/core_api/classes/transform/transformOverview)

Transforms represent the position, rotation, and scale of objects in the game.  They are immutable, but new Transforms can be created when you want to change an object’s transform.

Constructor | Return Value | Description | Tags
--- | --- | --- | ---
`Transform.New()` | Transform | Creates an identity transform. | None
`Transform.New(Quaternion rotation, Vector3 position, Vector3 scale)` | Transform | Construct with quaternion. | None
`Transform.New(Rotation rotation, Vector3 position, Vector3 scale)` | Transform | Construct with rotation. | None
`Transform.New(Vector3 x_axis, Vector3 y_axis, Vector3 z_axis, Vector3 translation)` | Transform | Construct from matrix. | None
`Transform.New(Transform transform)` | Transform | Copies the given Transform. | None
`Transform.IDENTITY` | Transform | Constant identity transform. | None

Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetPosition()` | Vector3 | Returns a copy of the position component of the transform. | None
`SetPosition (Vector3)` | None | Sets the position component of the transform. | None
`GetRotation()` | Rotation | Returns a copy of the rotation component of the transform. | None
`SetRotation(Rotation)` | None | Sets the rotation component of the transform. | None
`GetQuaternion()` | Quaternion | Returns a quaternion-based representation of the rotation. | None
`SetQuaternion(Quaternion)` | None | Sets the quaternion-based representation of the rotation. | None
`GetScale()` | Vector3 | Returns a copy of the scale component of the transform. | None
`SetScale(Vector3)` | None | Sets the scale component of the transform. | None
`GetForwardVector()` | Vector3 | Forward vector of the transform. | None
`GetRightVector()` | Vector3 | Right vector of the transform. | None
`GetUpVector()` | Vector3 | Up vector of the transform. | None
`GetInverse()` | Transform | Inverse of the transform. | None
`TransformPosition(Vector3 position)` | Vector3 | Applies the transform to the given position in 3D space. | None
`TransformDirection(Vector3 direction)` | Vector3 | Applies the transform to the given directional Vector3.  This will rotate and scale the Vector3, but does not apply the transform’s position. | None

Operator | Return Value | Description | Tags
--- | --- | --- | ---
`Transform * Transform` | Transform | Returns a new transform composing the left and right transforms. | None
`Transform * Quaternion` | Quaternion | Returns a new transform composing the left transform then the right side rotation. | None

### [Trigger](/core_api/classes/trigger/triggerOverview)

A trigger is an invisible and non-colliding CoreObject which fires events when it interacts with another object (e.g. A player walks into it):

Property | Return Value | Description | Tags
--- | --- | --- | ---
`isInteractable` | bool | Is the trigger interactable? | Read-Write, Dynamic
`interactionLabel` | string | The text players will see in their HUD when they come into range of interacting with this trigger. | Read-Write, Dynamic
`team` | Integer | Assigns the trigger to a team. Value range from 0 to 4. 0 is neutral team ( friendly to all other teams ) | Read-Write, Dynamic
`isTeamCollisionEnabled` | bool | If false, and the trigger has been assigned to a valid team, players on that team will not overlap or interact with the trigger. | Read-Write, Dynamic
`isEnemyCollisionEnabled` | bool | If false, and the trigger has been assigned to a valid team, players on enemy teams will not overlap or interact with the trigger. | Read-Write, Dynamic

Property | Return Value | Description | Tags
--- | --- | --- | ---
`IsOverlapping(CoreObject)` | bool | Returns true if given core object overlaps with the trigger. | None
`IsOverlapping(Player)` | bool | Returns true if given player overlaps with the trigger. | None
`GetOverlappingObjects()` | array\<Objects> | Returns a list of all objects that are currently overlapping with the trigger. | None

Event | Return Value | Description | Tags
--- | --- | --- | ---
`beginOverlapEvent` | Event\<CoreObject trigger, object other> | An event fired when an object enters the trigger volume.  The first parameter is the trigger itself.  The second is the object overlapping the trigger, which may be a CoreObject, a Player, or some other type.  Call other:IsA() to check the type.  Eg, other:IsA(‘Player’), other:IsA(‘StaticMesh’), etc. | Read-Only
`endOverlapEvent` | Event\<CoreObject trigger, object other> | An event fired when an object exits the trigger volume.  Parameters the same as beginOverlapEvent. | Read-Only
`interactedEvent` | Event\<CoreObject trigger, Player> | An event fired when a player uses the interaction on a trigger volume (By default “F” key). The first parameter is the trigger itself and the second parameter is a Player. | Read-Only

### [UIControl](/core_api/classes/uicontrol/uicontrolOverview)

UIControl is a CoreObject which serves as a base class for other UI Control Proxies.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`x` | Number | Screen-space offset from the anchor. | None
`y` | Number | Screen-space offset from the anchor. | None
`width` | Number | Horizontal size of the control. | None
`height` | Number | Vertical size of the control. | None
`rotationAngle` | Number | rotation angle of the control. | None

### [Vector2](/core_api/classes/vector2/vector2Overview)

A two-component vector.

Constructor | Return Value | Description | Tags
--- | --- | --- | ---
`Vector2.New()` | Vector2 | Creates the vector (0, 0). | None
`Vector2.New(Number x, Number y)` | Vector2 | Construct with the given x, y values. | None
`Vector2.New(Number v)` | Vector2 | Construct with x, y values both set to the given value. | None
`Vector2.New(Vector3 v)` | Vector3 | Construct with x, y values from the given Vector3. | None
`Vector2.ZERO` | Vector2 | (0, 0, 0) | None
`Vector2.ONE` | Vector2 | (1, 1, 1) | None

Property | Return Value | Description | Tags
--- | --- | --- | ---
`x` | Number | The X component of the vector. | Read-Write
`y` | Number | The Y component of the vector. | Read-Write
`size` | Number | The magnitude of the vector. | Read-Only
`sizeSquared` | Number | The squared magnitude of the vector. | Read-Only

Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetNormalized()` | Vector2 | Returns a new Vector2 with size 1, but still pointing in the same direction.  Returns (0, 0) if the vector is too small to be normalized. | None

Class Function | Return Value | Description | Tags
--- | --- | --- | ---
`Lerp(Vector2 from, Vector2 to, Number progress)` | Vector2 | Linearly interpolates between two vectors by the specified progress amount and returns the resultant Vector2. | None
`Vector2 + Vector2` | Vector2 | Component-wise addition. | None
`Vector2 + Number` | Vector2 | Adds the right-side number to each of the components in the left side and returns the resulting Vector2. | None
`Vector2 - Vector2` | Vector2 | Component-wise subtraction. | None
`Vector2 - Number` | Vector2 | Subtracts the right-side number from each of the components in the left side and returns the resulting Vector2. | None
`Vector2 * Vector2` | Vector2 | Component-wise multiplication. | None
`Vector2 * Number` | Vector2 | Multiplies each component of the Vector2 by the right-side number. | None
`Number * Vector2` | Vector2 | Multiplies each component of the Vector2 by the left-side number. | None
`Vector2 / Vector2` | Vector2 | Component-wise division. | None
`Vector2 / Number` | Vector2 | Divides each component of the Vector2 by the right-side number. | None
`-Vector2` | Vector2 | Returns the negation of the Vector2. | None
`Vector2 .. Vector2` | Vector2 | Returns the dot product of the Vector2s. | None
`Vector2 ^ Vector2` | Vector2 | Returns the cross product of the Vector2s. | None

### [Vector3](/core_api/classes/vector3/vector3Overview)

A three-component vector.

Constructor | Return Value | Description | Tags
--- | --- | --- | ---
`Vector3.New()` | Vector3 | Creates the vector (0, 0, 0). | None
`Vector3.New(Number x, Number y, Number z)` | Vector3 | Construct with the given x, y, z values. | None
`Vector3.New(Number v)` | Vector3 | Construct with x, y, z values all set to the given value. | None
`Vector3.New(Vector2 xy, Number z)` | Vector3 | Construct with x, y values from the given Vector2 and the given z value. | None
`Vector3.New(Vector4 v)` | Vector4 | Construct with x, y, z values from the given Vector4. | None
`Vector3.ZERO` | Vector3 | (0, 0, 0) | None
`Vector3.ONE` | Vector3 | (1, 1, 1) | None
`Vector3.FORWARD` | Vector3 | (1, 0, 0) | None
`Vector3.UP` | Vector3 | (0, 0, 1) | None
`Vector3.RIGHT` | Vector3 | (0, 1, 0) | None

Property | Return Value | Description | Tags
--- | --- | --- | ---
`x` | Number | The X component of the vector. | Read-Write
`y` | Number | The Y component of the vector. | Read-Write
`z` | Number | The Z component of the vector. | Read-Write
`size` | Number | The magnitude of the vector. | Read-Only
`sizeSquared` | Number | The squared magnitude of the vector. | Read-Only

Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetNormalized()` | Vector3 | Returns a new Vector3 with size 1, but still pointing in the same direction.  Returns (0, 0, 0) if the vector is too small to be normalized. | None

Class Function | Return Value | Description | Tags
--- | --- | --- | ---
`Lerp(Vector3 from, Vector3 to, Number progress)` | Vector3 | Linearly interpolates between two vectors by the specified progress amount and returns the resultant Vector3. | None
`Vector3 + Vector3` | Vector3 | Component-wise addition. | None
`Vector3 + Number` | Vector3 | Adds the right-side number to each of the components in the left side and returns the resulting Vector3. | None
`Vector3 - Vector3` | Vector3 | Component-wise subtraction. | None
`Vector3 - Number` | Vector3 | Subtracts the right-side number from each of the components in the left side and returns the resulting Vector3. | None
`Vector3 * Vector3` | Vector3 | Component-wise multiplication. | None
`Vector3 * Number` | Vector3 | Multiplies each component of the Vector3 by the right-side number. | None
`Number * Vector3` | Vector3 | Multiplies each component of the Vector3 by the left-side number. | None
`Vector3 / Vector3` | Vector3 | Component-wise division. | None
`Vector3 / Number` | Vector3 | Divides each component of the Vector3 by the right-side number. | None
`-Vector3` | Vector3 | Returns the negation of the Vector3. | None
`Vector3 .. Vector3` | Vector3 | Returns the dot product of the Vector3s. | None
`Vector3 ^ Vector3` | Vector3 | Returns the cross product of the Vector3s. | None

### [Vector4](/core_api/classes/vector4/vector4Overview)

A four-component vector.

Constructor | Return Value | Description | Tags
--- | --- | --- | ---
`Vector4.New()` | Vector4 | Creates the vector (0, 0, 0, 0). | None
`Vector4.New(Number x, Number y, Number z, Number w)` | Vector4 | Construct with the given x, y, z, w values. | None
`Vector4.New(Number v)` | Vector4 | Construct with x, y, z, w values all set to the given value. | None
`Vector4.New(Vector3 xyz, Number w)` | Vector4 | Construct with x, y, z values from the given Vector3 and the given w value. | None
`Vector4.New(Vector4 v)` | Vector4 | Construct with x, y, z, w values from the given Vector4. | None
`Vector4.New(Vector2 xy, Vector2 zw)` | Vector4 | Construct with x, y values from the first Vector2 and z, w values from the second Vector2. | None
`Vector4.New(Color v)` | Color | Construct with x, y, z, w values mapped from the given Color’s r, g, b, a values. | None
`Vector3.ZERO` | Vector3 | (0, 0, 0, 0) | None
`Vector3.ONE` | Vector3 | (1, 1, 1, 1) | None

Property | Return Value | Description | Tags
--- | --- | --- | ---
`x` | Number | The X component of the vector. | Read-Write
`y` | Number | The Y component of the vector. | Read-Write
`z` | Number | The Z component of the vector. | Read-Write
`w` | Number | The W component of the vector. | Read-Write
`size` | Number | The magnitude of the vector. | Read-Only
`sizeSquared` | Number | The squared magnitude of the vector. | Read-Only

Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetNormalized()` | Vector4 | Returns a new Vector4 with size 1, but still pointing in the same direction.  Returns (0, 0, 0, 0) if the vector is too small to be normalized. | None

Class Function | Return Value | Description | Tags
--- | --- | --- | ---
`Lerp(Vector4 from, Vector4 to, Number progress)` | Vector4 | Linearly interpolates between two vectors by the specified progress amount and returns the resultant Vector4. | None
`Vector4 + Vector4` | Vector4 | Component-wise addition. | None
`Vector4 + Number` | Vector4 | Adds the right-side number to each of the components in the left side and returns the resulting Vector4. | None
`Vector4 - Vector4` | Vector4 | Component-wise subtraction. | None
`Vector4 - Number` | Vector4 | Subtracts the right-side number from each of the components in the left side and returns the resulting Vector4. | None
`Vector4 * Vector4` | Vector4 | Component-wise multiplication. | None
`Vector4 * Number` | Vector4 | Multiplies each component of the Vector4 by the right-side number. | None
`Number * Vector4` | Vector4 | Multiplies each component of the Vector4 by the left-side number. | None
`Vector4 / Vector4` | Vector4 | Component-wise division. | None
`Vector4 / Number` | Vector4 | Divides each component of the Vector4 by the right-side number. | None
`-Vector4` | Vector4 | Returns the negation of the Vector4. | None
`Vector4 .. Vector4` | Vector4 | Returns the dot product of the Vector4s. | None
`Vector4 ^ Vector4` | Vector4 | Returns the cross product of the Vector4s. | None

### [Vfx](/core_api/classes/vfx/vfxOverview)

Vfx is a specialized type of SmartObject for visual effects.  It inherits everything from SmartObject.

Function | Return Value | Description | Tags
--- | --- | --- | ---
`team` | Integer | Assigns the vfx to a team. Value range from 0 to 4. 0 is neutral team | Read-Write, Dynamic
`isTeamColorUsed` | bool | If true, and the vfx has been assigned to a valid team, players on that team will see a blue vfx, while other players will see red. (Requires a material that supports the color property.) | Read-Write, Dynamic

Function | Return Value | Description | Tags
--- | --- | --- | ---
`Play()` | None | Starts playing the effect. | None
`Stop()` | None | Stops playing the effect. | None

### [Weapon](/core_api/classes/weapon/weaponOverview)

A Weapon is an Equipment that comes with built-in Abilities and fires Projectiles.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`isReticleEnabled` | bool | If True, the reticle will appear when this Weapon is equipped. | Read-Write
`animationStance` | string | When the weapon is equipped this animation stance is applied to the Player. | Read-Only
`attackCooldownDuration` | Number | Interval between separate burst sequences. | Read-Only
`multiShotCount` | Integer | Number of projectiles/hitscans that will fire simultaneously inside the spread area each time the Weapon attacks. Does not affect the amount of ammo consumed per attack. | Read-Only
`burstCount` | Integer | Number of automatic activations of the weapon that generally occur in quick succession. | Read-Only
`shotsPerSecond` | Number | Used in conjunction with burst_count to determine the interval between automatic weapon activations. | Read-Write
`shouldBurstStopOnRelease` | bool | If True, a burst sequence can be interrupted by the player by releasing the action button. If False, the burst continues firing automatically until it completes or the weapon runs out of ammo. | Read-Only
`isHitscan` | bool | If False, the weapon will produce simulated projectiles. If true, it will instead use instantaneous line traces to simulate shots. | Read-Only
`range` | Number | Max travel distance of the projectile (is_hitscan = False) or range of the line trace (is_hitscan = True). | Read-Write
`projectileTemplateId` | string | Asset reference for the visual body of the projectile, for non-hitscan weapons. | Read-Only
`muzzleFlashTemplateId` | string | Asset reference for a VFX to be attached to the muzzle point each time the weapon attacks. | Read-Only
`trailTemplateId` | string | Asset reference for a trail VFX to follow the trajectory of the shot. | Read-Only
`beamTemplateId` | string | Asset reference for a beam VFX to be placed along the trajectory of the shot. Useful for hitscan weapons or very fast projectiles. | Read-Only
`impactSurfaceTemplateId` | string | Asset reference of a VFX to be attached to the surface of any Core Objects hit by the attack. | Read-Only
`impactProjectileTemplateId` | string | Asset reference of a VFX to be spawned at the interaction point. It will be aligned with the trajectory. If the impacted object is a Core Object, then the VFX will attach to it as a child. | Read-Only
`impactPlayerTemplateId` | string | Asset reference of a VFX to be spawned at the interaction point, if the impacted object is a player. | Read-Only
`projectileSpeed` | Number | Travel speed (cm/s) of projectiles spawned by this weapon. | Read-Only
`projectileLifeSpan` | Number | Duration of projectiles. After which they are destroyed. | Read-Only
`projectileGravity` | Number | Gravity scale applied to spawned projectiles. | Read-Only
`projectileLength` | Number | Length of the projectile’s capsule collision. | Read-Only
`projectileRadius` | Number | Radius of the projectile’s capsule collision | Read-Only
`projectileDrag` | Number | Drag on the projectile. | Read-Only
`projectileBounceCount` | Integer | Number of times the projectile will bounce before it’s destroyed. Each bounce generates an interaction event. | Read-Only
`projectilePierceCount` | Integer | Number of objects that will be pierced by the projectile before it’s destroyed. Each pierce generates an interaction event. | Read-Only
`maxAmmo` | Integer | How much ammo the Weapon starts with and its max capacity. If set to -1 then the Weapon has infinite capacity and doesn’t need to reload. | Read-Only
`currentAmmo` | Integer | Current amount of ammo stored in this Weapon. | Read-Write
`ammoType` | string | A unique identifier for the ammunition type. | Read-Only
`isAmmoFinite` | bool | Determines where the ammo comes from. If True, then ammo will be drawn from the Player’s Resource inventory and reload will not be possible until the Player acquires more ammo somehow. If False, then the Weapon simply reloads to full and inventory Resources are ignored. | Read-Only
`outOfAmmoSoundId` | string | Asset reference for a sound effect to be played when the weapon tries to activate, but is out of ammo. | Read-Only
`reloadSoundId` | string | Asset reference for a sound effect to be played when the weapon reloads ammo. | Read-Only
`spreadMin` | Number | Smallest size in degrees for the Weapon’s cone of probability space to fire projectiles in. | Read-Only
`spreadMax` | Number | Largest size in degrees for the Weapon’s cone of probability space to fire projectiles in. | Read-Only
`spreadAperture` | Number | The surface size from which shots spawn. An aperture of zero means shots originate from a single point. | Read-Only
`spreadDecreaseSpeed` | Number | Speed at which the Spread contracts back from its current value to the minimum cone size. | Read-Only
`spreadIncreasePerShot` | Number | Amount the Spread increases each time the Weapon attacks. | Read-Only
`spreadPenaltyPerShot` | Number | Cumulative penalty to the Spread size for successive attacks. Penalty cools off based on spreadDecreaseSpeed. | Read-Only

Function | Return Value | Description | Tags
--- | --- | --- | ---
`HasAmmo()` | bool | Informs whether the Weapon is able to attack or not. | None
`Attack(target)` | None | Triggers the main ability of the weapon. Optional target parameter can be a Vector3 world position, a Player, or a CoreObject. | None

Event | Return Value | Description | Tags
--- | --- | --- | ---
`targetInteractionEvent` | Event<WeaponInteraction> | An event fired when a Weapon interacts with something. E.g. a shot hits a wall. The WeaponInteraction parameter contains information such as which object was hit, who owns the weapon, which ability was involved in the interaction, etc. Server only. | Server Context, Read-Only
`projectileSpawnedEvent` | Event<WeaponInteraction> | An event fired when a Weapon spawns a projectile. | Read-Only

### [WeaponInteraction](/core_api/classes/weaponinteraction/weaponinteractionOverview)

A data structure containing all information about a specific weapon interaction, such as collision with a character.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`targetObject` | Object | Reference to the object/player hit by the weapon. | Read-Only
`projectile` | Projectile | Reference to a Projectile, if one was produced as part of this interaction. | Read-Only
`sourceAbility` | Ability | Reference to the Ability which initiated the interaction. | Read-Only
`weapon` | Weapon | Reference to the Weapon that is interacting. | Read-Only
`weaponOwner` | Player | Reference to the Player who had the Weapon equipped at the time it was activated, ultimately leading to this interaction. | Read-Only
`travelDistance` | Number | The distance in cm between where the weapon attack started until it impacted something. | Read-Only
`isHeadshot` | bool | True if the weapon hit another player in the head. | Read-Only

Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetHitResult()` | HitResult | Physics information about the impact between the weapon and the other object. | None
`GetHitResults()` | array<HitResult> | Table with multiple HitResults that hit the same object, in the case of Weapons with multi-shot (e.g. Shotguns). If a single attack hits multiple targets you receive a separate interaction event for each object hit. | None

### [WorldText](/core_api/classes/worldtext/worldtextOverview)

WorldText is an in-world text CoreObject.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`text` | string | The text being displayed by this object. | Read-Write, Dynamic

Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetColor()` | Color | The color of the text. | None
`SetColor(Color)` | None | The color of the text. | Dynamic

## Core Lua Namespaces

Some sets of related functionality are grouped within namespaces, which are similar to the types above, but cannot be instantiated.  They are only ever accessed by calling functions within these namespaces.

### [CoreDebug](/core_api/classes/coredebug/coredebugOverview)

The CoreDebug API contains functions that may be useful for debugging.

Function | Return Value | Description | Tags
--- | --- | --- | ---
`CoreDebug.DrawLine(Vector3 start, Vector3 end, [table optionalParameters])` | Vector3 | draw debug line. optionalParameters is table containing one of the following keys: duration (number) - if <= 0, draw for single frame, thickness (number), color (Color) | None
`CoreDebug.DrawBox(Vector3 center, Vector3 dimensions, [table optionalParameters])` | Vector3 | draw debug box, with dimension specified as a vector. optionalParameters has same options as DrawLine, with addition of: rotation (Rotation) - rotation of the box | None
`CoreDebug.DrawSphere(Vector3 center, radius, [table optionalParameters])` | Vector3 | draw debug sphere | None

??? "CoreDebug Code Example"
    ```
    -- draw red line for 3 seconds
    CoreDebug.DrawLine(Vector3.New(0, 0, 0), Vector3.New(0, 0, 1000), {color = Color.RED, duration = 3.0})

    -- draw box with dimension (100x200x300) for 10 seconds, rotated 45 degrees along Z axis
    CoreDebug.DrawBox(Vector3.New(1000, 0, 0), Vector3.New(100, 200, 300), {color = Color.BLUE, duration = 10.0, rotation = Rotation.New(0, 0, 45)})

    -- draw cyan sphere with radius 50 for single frame
    CoreDebug.DrawSphere(Vector3.New(0, 0, 100), 50, {color = Color.CYAN })
    ```

### [CoreMath](/core_api/classes/coremath/coremathOverview)

The CoreMath API contains a group of static math functions.

Static Function | Return Value | Description | Tags
--- | --- | --- | ---
`CoreMath.Clamp(Number value, Number lower, Number upper)` | None | Clamps value between lower and upper, inclusive. If lower and upper are not specified, defaults to 0 and 1. | None
`CoreMath.Lerp(Number from, Number to, Number t)` | None | Linear interpolation between from and to.  t should be a floating point number from 0 to 1, with 0 returning from and 1 returning to. | None
`CoreMath.Round(Number value, Number decimals)` | None | Rounds value to an integer, or to an optional number of decimal places, and returns the rounded value. | None

### [Events](/core_api/classes/events/eventsOverview)

User defined events can be specified using the Events namespace. The Events namespace uses the following static functions (called using a `.`):

Function | Return Value | Description | Tags
--- | --- | --- | ---
`Connect(string eventName, function eventListener)` | EventListener | Registers the given function to the event name which will be called every time the event is fired using Broadcast.  Returns an EventListener which can be used to disconnect from the event or check if the event is still connected. | None
`ConnectForPlayer(string eventName, function eventListener) (Server Only)` | EventListener |  Registers the given function to the event name which will be called every time the event is fired using BroadcastToServer. The first parameter the function receives will be the player that fired the event. Returns an EventListener which can be used to disconnect from the event or check if the event is still connected. | Server Context
`Broadcast(string eventName, args...)` | string | Broadcasts the given event and fires all listeners attached to the given event name if any exists. Parameters after event name specifies the arguments passed to the listener. Any number of arguments can be passed to the listener function. The events are not networked and can fire events defined in the same context. | None
`BroadcastToAllPlayers(string eventName, args...)` | \<resultcode, errorMessage> |  Broadcasts the given event to all clients over the network and fires all listeners attached to the given event name if any exists. Parameters after event name specify the arguments passed to the listener on the client. The function returns a result code and a message. Possible result codes can be found below. This is a networked event. The maximum size a networked event can send is 128bytes and all networked events are subjected to a rate limit of 10 events per second. Server-only. | Server Context
`BroadcastToPlayer(Player player, string eventName,args...)` | \<resultcode, errorMessage> | Broadcasts the given event to a specific client over the network and fires all listeners attached to the given event name if any exists on that client. The first parameter specifies the player to which the event will be sent. The parameters after event name specify the arguments passed to the listener on the client. The function returns a result code and a message. Possible result codes can be found below. This is a networked event. The maximum size a networked event can send is 128bytes and all networked events are subjected to a rate limit of 10 events per second. Server-only. | Server Context
`BroadcastToServer(string eventName,args...)` | \<resultcode, errorMessage> | Broadcasts the given event to the server over the network and fires all listeners attached to the given event name if any exists on the server. The parameters after event name specify the arguments passed to the listener on the server. The function returns a result code and a message. Possible result codes can be found below. This is a networked event. The maximum size a networked event can send is 128bytes and all networked events are subjected to a rate limit of 10 events per second. Client-only. | Client Context

??? "Broadcast Event Result Codes"
    * BroadcastEventResultCode.SUCCESS
    * BroadcastEventResultCode.FAILURE
    * BroadcastEventResultCode.EXCEEDED_SIZE_LIMIT
    * BroadcastEventResultCode.EXCEEDED_RATE_LIMIT

??? "Networked Events Supported Types"
    * Bool
    * Int32
    * Float
    * String
    * Color
    * Rotator
    * Vector2
    * Vector3
    * Vector4
    * Player
    * Table

### [Game](/core_api/classes/game/gameOverview)

Game is a collection of functions and events related to players in the game, rounds of a game, and team scoring.

Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetLocalPlayer()` | Player | Returns the local player (Client-only). | Client Context
`GetPlayers([table Parameters])` | array<Player> | Returns a table containing the players currently in the game. An optional table may be provided containing parameters to filter the list of players returned: | None
`ignoreDead(boolean)` | None | If true, don’t return any dead players. | None
`ignoreLiving(boolean)` | None | If true, don’t return any living players. | None
`ignoreTeams(Integer or Array<Integer>)` | None | Don’t return any players belonging to the team or teams listed. | None
`includeTeams(Integer or Array<Integer>)` | None | Return only players belonging to the team or teams listed. | None
`ignorePlayers(Player or Array<Player>)` | None | Don’t return any of the listed Players. For example: Game.GetPlayers( {ignoreDead = true, ignorePlayers=Game.GetLocalPlayer()} ) | None
`FindNearestPlayer(Vector3 position, [table Parameters])` | Player | Returns the Player that is nearest to the given position.  An optional table may be provided containing parameters to filter the list of players considered.  This supports the same list of parameters as GetPlayers(). | None
`FindPlayersInCylinder(Vector3 position, Number radius, [table Parameters]` | array<Player> | Returns a table with all Players that are in the given area. Position’s Z is ignored with the cylindrical area always upright.  An optional table may be provided containing parameters to filter the list of players considered.  This supports the same list of parameters as GetPlayers(). | None
`FindPlayersInSphere(Vector3 position, Number radius, [table Parameters]` | array<Player> | Returns a table with all Players that are in the given spherical area.  An optional table may be provided containing parameters to filter the list of players considered.  This supports the same list of parameters as GetPlayers(). | None
`StartRound()` | None | Fire all events attached to roundStartEvent | Server Context
`EndRound()` | None | Fire all events attached to roundEndEvent | Server Context
`GetTeamScore(team)` | Integer | Returns the current score for the specified team. Only teams 0 - 4 are valid. | None
`SetTeamScore(team, score)` | None | Sets one team’s score. | Server Context
`IncreaseTeamScore(team, scoreChange)` | None | Increases one team’s score. | Server Context
`DecreaseTeamScore(team, scoreChange)` | None | Decreases one team’s score. | Server Context
`ResetTeamScores()` | None | Sets all teams’ scores to 0. | Server Context

Event | Return Value | Description | Tags
--- | --- | --- | ---
`playerJoinedEvent` | Event<Player> | Event fired when a player has joined the game and their character is ready. | Read-Only
`playerLeftEvent` | Event<Player> | Event fired when a player has disconnected from the game or their character has been destroyed. | Read-Only
`abilitySpawnedEvent` | Event<Ability> | Event fired when an ability is spawned. Useful for client contexts to hook up to ability events. | Client Context, Read-Only
`roundStartEvent` | Event | Event fired when StartRound is called on game. | Read-Only
`roundEndEvent` | Event | Event fired when EndRound is called on game. | Read-Only
`teamScoreChangedEvent` | Event<int(team)> | Event fired whenever any team’s score changes. This is fired once per team who’s score changes. | Read-Only

### [Teams](/core_api/classes/teams/teamsOverview)

The Teams API contains a group of static functions for dealing with teams and team settings.

Function | Return Value | Description | Tags
--- | --- | --- | ---
`Teams.AreTeamsEnemies(Integer team1, Integer team2)` | bool | Returns true if teams are considered enemies under the current TeamMode. If either team is TEAM_NEUTRAL=0, returns false. | None
`Teams.AreTeamsFriendly(Integer team1, Integer team2)` | bool | Returns true if teams are considered friendly under the current TeamMode. If either team is TEAM_NEUTRAL=0, returns true. | None

### [UI](/core_api/classes/ui/uiOverview)

The UI API contains a group of static functions allowing you to push information to the HUD. All functions take a player as an argument to select which player’s UI to modify. In addition, there are a number of UI widgets that will replicate and appear on player screens the same way CoreObjects appear in the world. They must be under a Canvas to be displayed. If Canvases exist only on a client, outside of a NetworkContext, they will always display on top of all other UI valid elements.

Function | Return Value | Description | Tags
--- | --- | --- | ---
`UI.ShowFlyUpText(string message, Vector3, [table])` | Vector3 | (Client only) Shows a quick text on screen that tracks its position relative to a world position. The last parameter is an optional table containing additional parameters: duration (Number) - How long the text should remain on the screen. Default duration is 0.5 seconds; color (Color) - The color of the text.  Default is white; isBig (boolean) - When true, larger text is used. | Client Context
`UI.ShowDamageDirection(Vector3 world point)` | Vector3 | (Client only) Local player sees an arrow pointing towards some damage source. Lasts for 5 seconds. | Client Context
`UI.ShowDamageDirection(CoreObject)` | None | Local player sees an arrow pointing towards some Core Object. Multiple calls with the same CoreObject reuse the same UI indicator, but refreshes its duration. | Client Context
`UI.ShowDamageDirection(Player source)` | None | Local player sees an arrow pointing towards some other Player. Multiple calls with the same Player reuse the same UI indicator, but refreshes its duration. The arrow points to where the source was at the moment ShowDamageDirection is called and does not track the source Player’s movements. | Client Context
`UI.GetCursorPosition()` | Vector2 | Returns a Vector2 with the x, y coordinates of the mouse cursor on the screen. Only gives results from a client context. May return nil if the cursor position cannot be determined. | Client Context
`UI.GetScreenPosition(Vector3 world_position)` | Vector2 | Calculates the location that world_position appears on the screen. Returns a Vector2 with the x, y coordinates, or nil if world_position is behind the camera. Only gives results from a client context. | Client Context
`UI.GetScreenSize()` | Vector2 | Returns a Vector2 with the size of the player’s screen in the x, y coordinates. Only gives results from a client context. May return nil if the screen size cannot be determined. | Client Context
`UI.PrintToScreen(string, Color)` | None | Draws a message on the corner of the screen.  Second optional Color parameter can change the color from the default white. | None
`UI.IsCursorVisible()` | bool | Whether cursor is visible. | None
`UI.SetCursorVisible(bool isVisible)` | None | Whether cursor is visible. | None
`UI.IsCursorLockedToViewport()` | bool | Whether to lock cursor in viewport. | None
`UI.SetCursorLockedToViewport(bool isLocked)` | None | Whether to lock cursor in viewport. | None
`UI.CanCursorInteractWithUI()` | bool | Whether cursor can interact with UI elements like buttons. | None
`UI.SetCanCursorInteractWithUI(bool)` | None | Whether cursor can interact with UI elements like buttons. | None
`UI.SetReticleVisible(bool Show)` | None | Shows or hides the reticle for the player. | None
`UI.IsReticleVisible()` | bool | Check if reticle is visible | None
`UI.GetCursorHitResult()` | HitResult | Return hit result from local client’s view in direction of the projected cursor position. Meant for client-side use only, for ability cast, please use ability:GetTargetData():GetHitPosition(), which would contain cursor hit position at time of cast, when in topdown camera mode | None
`UI.GetCursorPlaneIntersection(Vector3 pointOnPlane, Vector3 planeNormal [optional default to up vector])` | Vector | return intersection from local client’s camera direction to given plane, specified by point on plane and optionally its normal. Meant for client-side use only. Example usage: local hitPos = UI.GetCursorPlaneIntersection(Vector3.New(0, 0, 0)). | None

### [World](/core_api/classes/world/worldOverview)

World is a collection of functions for finding objects in the world.

Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetRootObject()` | CoreObject | Returns the root of the CoreObject hierarchy. | None
`FindObjectsByName(string name)` | array<CoreObject> | Returns a table containing all the objects in the hierarchy with a matching name.  If none match, an empty table is returned. | None
`FindObjectsByType(string type_name)` | array<CoreObject> | Returns a table containing all the objects in the hierarchy whose type is or extends the specified type.  If none match, an empty table is returned. | None
`FindObjectByName(string type_name)` | CoreObject | Returns the first object found with a matching name. In none match, nil is returned. | None
`FindObjectById(string muid_string)` | CoreObject | Returns the object with a given MUID.  Returns nil if no object has this ID. | None
`SpawnAsset(string asset_id, [table Parameters])` | CoreObject | Spawns an instance of an asset into the world. (More on Templates)  Optional parameters can specify a parent for the spawned object or the object’s transform.  Supported parameters include: parent (CoreObject)- If provided, the spawned asset will be a child of this parent, and any transform parameters are relative to the parent’s transform; transform (Transform)- The transform of the spawned object.  If provided, it is an error to specify position, rotation, or scale; position (Vector3)- Position of the spawned object; rotation (Rotation or Quaternion)- Rotation of the spawned object; scale (Vector3)- Scale of the spawned object. For example: World.SpawnAsset(myAssetId, {parent = script.parent, position = Vector3.New(0, 0, 100)} ) | None
`Raycast(Vector3 rayStart, Vector3 rayEnd, [table Parameters])` | HitResult | Traces a ray from rayStart to rayEnd, returning a HitResult with data about the impact point and object. Returns nil if no intersection is found. Optional parameters can be provided to control the results of the raycast: ignoreTeams (Integer or Array<Integer>)- Don’t return any players belonging to the team or teams listed; ignorePlayers (Player, Array<Player>, or boolean)- Ignore any of the players listed.  If true, ignore all players. Example: Raycast(myPlayer.GetWorldPosition(), Vector3.ZERO, { ignorePlayers=myPlayer }) | None

### [Core Lua Functions](/core_api/classes/CORELuaFunctions/CORELuaFunctionsOverview)

Function | Return Value | Description | Tags
--- | --- | --- | ---
`Tick(Number deltaTime)` | Number | Tick event, used for things you need to check continuously (e.g. main game loop), but be careful of putting too much logic here or you will cause performance issues. DeltaTime is the time difference (in ms) between this and the last tick. | None
`time()` | Number | Returns the time in seconds (floating point) since the game started on the server. | None
`print(string)` | string | Print a message to the event log. Press \` to view messages. | None
`warn(string)` | string | Similar to print(), but includes the script name and line number. | None


### Built-In Lua Functions

For security reasons, various built-in Lua functions have been restricted or removed entirely.  The available functions are listed below. Note that lua’s built-in trigonometric functions use radians, while other functions in Core uses degrees. See the [reference manual](https://www.lua.org/manual/5.3/manual.html#6) for more information on what they do.

??? "Built-In Lua Functions"
    * assert  
    * collectgarbage†  
    * error  
    * getmetatable†  
    * ipairs  
    * next  
    * pairs  
    * pcall  
    * print†  
    * rawequal  
    * rawget†  
    * rawset†  
    * require†  
    * select  
    * setmetatable†  
    * tonumber  
    * tostring  
    * type  
    * \_G†  
    * \_VERSION  
    * xpcall  
    * coroutine.create  
    * coroutine.isyieldable  
    * coroutine.resume  
    * coroutine.running  
    * coroutine.status  
    * coroutine.wrap  
    * coroutine.yield  
    * math.abs   
    * math.acos    
    * math.asin    
    * math.atan    
    * math.ceil    
    * math.cos    
    * math.deg   
    * math.exp  
    * math.floor  
    * math.fmod  
    * math.huge  
    * math.log  
    * math.max  
    * math.maxinteger  
    * math.min  
    * math.mininteger  
    * math.modf  
    * math.pi  
    * math.rad  
    * math.random  
    * math.randomseed  
    * math.sin  
    * math.sqrt  
    * math.tan  
    * math.tointeger  
    * math.type  
    * math.ult  
    * os.clock  
    * os.date  
    * os.difftime  
    * os.time  
    * string.byte  
    * string.char  
    * string.find  
    * string.format  
    * string.gmatch  
    * string.gsub  
    * string.len  
    * string.lower  
    * string.match  
    * string.pack  
    * string.packsize  
    * string.rep  
    * string.reverse  
    * string.sub  
    * string.unpack  
    * string.upper  
    * table.concat  
    * table.insert  
    * table.move  
    * table.pack  
    * table.remove  
    * table.sort  
    * table.unpack  
    * utf8.char  
    * utf8.charpattern  
    * utf8.codes  
    * utf8.codepoint  
    * utf8.len  
    * utf8.offset  

### MUIDs

MUIDs are internal identifiers for objects and assets within your game. They are guaranteed to be unique within the game and likely to be unique globally.  You can copy a MUID to the clipboard automatically by right-clicking assets in the Asset Manifest or placed objects in the Hierarchy.  The MUID will look something like this:

8D4B561900000092:Rabbit

The important part is the 16 digits at the start.  The colon and everything after it are optional and are there to make it easier to read.  Some Lua functions use MUIDs, for example FindObjectById and SpawnTemplate.  When used in a script, it needs to be surrounded by single quotes to make it a string.  For example:  

```
local spawnTrans = script.parent:GetWorldTransform()
local anchor = game:FindObjectById('8D4B5619000000ED:Anchor')
game:SpawnTemplate('8D4B561900000092:Rabbit', spawnTrans, anchor)
```

### Animation

General Ability Animation Information

All ability animations are valid on any of the available body types.
Each of the ability animations timing and/or translation values should behave identically across the body types.
All ability animations have a long “tail” that gracefully transitions the character back to idle pose.  This animation tail is intended to only be seen if the player does not execute any other ability or movement.  In nearly all practical use cases, the ability animation tails will be interrupted to do other game mechanics.

!!! Note
    If the intent is to have an ability “execute” as quickly as possible after the button press, it is still generally a good idea to have a very small cast phase value (0.1 second or so).  This will help with minor server/client latency issues and will also help to ensure smoother playback of character animations.

#### 1hand_melee Strings

`1hand_melee_slash_left` - A horizontal melee swing to the left.
-   This animation supports a variable cast phase time.
-   This animation supports a time stretched execute phase time

`1hand_melee_slash_right` - A horizontal melee swing to the right.
-   This animation supports a variable cast phase time.
-   This animation supports a time stretched execute phase time

`1hand_melee_slash_vertical` - A downward melee swing.
-   This animation supports a variable cast phase time.
-   This animation supports a time stretched execute phase time

`1hand_melee_thrust` - A melee forward lunge attack..
-   This animation supports a variable cast phase time.
-   This animation supports a time stretched execute phase time

`1hand_melee_rm_combo_opener_vertical_slash` - A horizontal melee swing to the left.
-   currently does NOT support a variable cast phase time.
-   currently does NOT support a time stretched execute phase time
-   has root motion
-   can be used in any context, despite its original intention as a combo opener.

`1hand_melee_rm_combo_middle_diagonal_slash` - A diagonal melee swing to the right.
-   currently does NOT support a variable cast phase time.
-   currently does NOT support a time stretched execute phase time
-   has root motion
-   can be used in any context, despite its original intention as the middle attack in a 3 hit combo.

`1hand_melee_rm_combo_closer_uppercut` - an uppercut.
-   currently does NOT support a variable cast phase time.
-   currently does NOT support a time stretched execute phase time
-   has root motion
-   can be used in any context, despite its original intention as a combo closer.

`1hand_melee_unsheathe` - Pulls the one-handed melee weapon from a belt sheath.
-   works best with a cast phase duration of  0.31 or less
-   currently does NOT support a variable cast phase time.
-   currently does NOT support a time stretched execute phase time

#### 2hand_sword Strings

`2hand_sword_slash_left` - A horizontal melee swing to the left.
-   This animation supports a variable cast phase time.
-   This animation supports a time stretched execute phase time

`2hand_sword_slash_right` - A horizontal melee swing to the right.
-   This animation supports a variable cast phase time.
-   This animation supports a time stretched execute phase time

`2hand_sword_slash_vertical` - A downward melee swing.
-   This animation supports a variable cast phase time.
-   This animation supports a time stretched execute phase time

`2hand_sword_thrust` - A forward sword thrust melee attack.

`2hand_sword_rm_combo_opener_cone` - A horizontal melee swing to the left.
-   currently does NOT support a variable cast phase time.
-   currently does NOT support a time stretched execute phase time
-   has root motion
-   can be used in any context, despite its original intention as a combo opener.

`2hand_sword_rm_combo_middle_spin` - A spin.
-   currently does NOT support a variable cast phase time.
-   currently does NOT support a time stretched execute phase time
-   has root motion
-   can be used in any context, despite its original intention as the middle attack in a 3 hit combo.

`2hand_sword_rm_combo_closer_spin` - a jumping spin.
-   currently does NOT support a variable cast phase time.
-   currently does NOT support a time stretched execute phase time
-   has root motion
-   can be used in any context, despite its original intention as a combo closer.

`2hand_sword_unsheathe` - Pulls the one-handed melee weapon from a belt sheath.
-   This animation works best with a cast phase duration of  0.31 or less

#### 2hand_staff Strings

`2hand_staff_magic_bolt` - Magic casting animation which appears to launch a projectile forward from the staff.
-   This animation supports a variable cast time.

`2hand_staff_magic_up` - Magic casting animation which raises the staff on cast.  This animation is not direction specific.
-   This animation supports a variable cast time.

#### 1hand_pistol Strings

`1hand_pistol_shoot` - A pistol shoot animation.
-   This animation supports a variable cast time.

`1hand_pistol_unsheathe` - Pulls the pistol from an invisible belt holster.
-   This animation works best with a cast phase duration of  0.21 or less

`1hand_pistol_reload_magazine` - Reloads a bottom-loading pistol clip.
-   This animation supports a variable cast time.

#### 2hand_rifle Strings

`2hand_rifle_shoot` - A rifle shoot animation.
-   This animation supports a variable cast time.

`2hand_rifle_reload_magazine` - Reloads an automatic rifle magazine.
-   This animation supports a variable cast time.

`2hand_rifle_unsheathe` - Pulls the rifle from a back scabbard.
-   This animation works best with a cast phase duration of  0.22 or less

#### Unarmed Strings

`unarmed_kick_ball` - A kick motion that moves the character forward as well.
-   This animation works best with a cast phase duration of  0.18 or less
-   This animation has root motion, and is designed to play full body.  Controller/mouse rotation can affect the course of the kick by default, but this behavior can be changed in the ability script.

`unarmed_dance` - Stand in place and dance.   
-   currently does NOT support a variable cast phase time.
-   currently does NOT support a time stretched execute phase time

`unarmed_dance_spooky` - Stand in place and dance.  
-   currently does NOT support a variable cast phase time.
-   currently does NOT support a time stretched execute phase time

`unarmed_flex` - Body builder style flexing animation.  
-   currently does NOT support a variable cast phase time.
-   currently does NOT support a time stretched execute phase time

`unarmed_thumbs_up` - thumbs up.  
-   currently does NOT support a variable cast phase time.
-   currently does NOT support a time stretched execute phase time

`unarmed_thumbs_up` - thumbs down.  
-   currently does NOT support a variable cast phase time.
-   currently does NOT support a time stretched execute phase time

`unarmed_rochambeau_rock` - rock, paper, scissors game.  This chooses rock as the end result.  
-   currently does NOT support a variable cast phase time.
-   currently does NOT support a time stretched execute phase time

`unarmed_rochambeau_paper` - rock, paper, scissors game.  This chooses paper as the end result.  
-   currently does NOT support a variable cast phase time.
-   currently does NOT support a time stretched execute phase time

`unarmed_rochambeau_scissors` - rock, paper, scissors game.  This chooses scissors as the end result.  
-   currently does NOT support a variable cast phase time.
-   currently does NOT support a time stretched execute phase time

`unarmed_magic_bolt` - Magic casting animation which appears to launch a projectile forward from the hands.
-   This animation supports a variable cast time.

`unarmed_punch_left` - A left punch animation.
-   This animation supports a variable cast time.

`unarmed_punch_right` - A right punch animation.
-   This animation supports a variable cast time.

`unarmed_roll` - A roll animation that moves the character forward.  
-   This animation has root motion, and is designed to play full body.  Controller/mouse rotation can affect the course of the roll by default, but this behavior can be changed in the ability script.
-   The root motion on this animation leaves the ground and travels upward.  In order for gravity not to affect this animated upward motion, a creator would ideally set the "flying_mode" to true for at least .45 seconds (longer is ok too).  For more information on flying_mode, see the AbilityPhase section above.

`unarmed_throw` - An over-the-shoulder right-handed throw animation.
-   This animation supports a variable cast time.

`unarmed_wave` - Stand in place and wave.  
-   This animation works best with a cast phase duration of 0.266 or less.

`unarmed_pickup` - Stand in place and pick up items from the ground.  
-   This animation works best with a cast phase duration of 0.266 or less.

### General Animation Stance Information

- All animation stances are valid on either of the available body types.
- Each animation stance should behave identically across the body types (with regard to timing).  
- All animation stances are (or end in) looping animations that can be played indefinitely
- No animation stances have root motion
- Each animation stance has custom blending behavior for what happens while moving (specified below)

### Animation Stance Strings

Animation Stance Strings

`unarmed_stance` - This will cause the player to walk or stand with nothing being held in their hands.

`1hand_melee_stance` - This will cause the player to walk or stand with the right hand posed to hold a  one handed weapon, and the left arm is assumed to possibly have a shield.  

`1hand_pistol_stance` - This will cause the player to walk or stand with the right hand posed to hold a pistol.  

`2hand_sword_stance` - This will cause the player to walk or stand with the left and right hand posed to hold a two handed sword.

`2hand_staff_stance` - This will cause the player to walk or stand with the left and right hand posed to hold a two handed staff.

`2hand_rifle_stance` - This will cause the player to walk or stand with the left and right hand posed to hold a two handed rifle.

`2hand_rifle_aim_shoulder` - A simple aiming pose in 2hand_rifle set.  Has the shoulder stock up to the shoulder.
When running/jumping etc, the entire upper body will retain the aiming pose.

`2hand_rifle_aim_hip` - A simple aiming pose in 2hand_rifle set.  Has the stock at the hip.
When running/jumping etc, the entire upper body will retain the aiming pose.

`1hand_pistol_aim` - A simple aiming pose for pistol.
When running/jumping etc, the entire upper body will retain the aiming pose.

`2hand_sword_ready` - A simple ready pose 2hand_sword set.  Has the sword held with both hands in front of the body.
When running/jumping etc, the entire upper body will retain the ready pose.

`2hand_sword_block_high` - A simple ready pose 2hand_sword set.  Has the sword held with both hands in front of the body.
When running/jumping etc, the entire upper body will retain the ready pose.

`unarmed_carry_object_high` - A one (right) handed carry animation with the arm raised to roughly eye level.  Ideal for holding a torch up to see better, etc
When running/jumping, the right arm will retain the lifted arm pose.  The left arm will inherit the animation underneath.  This works best if the animation set is unarmed.
This animation assumes the prop is attached to the right_prop socket.

`unarmed_carry_object_low` - A one (right) handed carry animation with the arm at waist height.  Ideal for holding a mug, potion, etc
When running/jumping, the right arm will retain the lifted arm pose.  The left arm will inherit the animation underneath.  This works best if the animation set is unarmed.
This animation assumes the prop is attached to the right_prop socket.

`unarmed_carry_object_heavy` - A two handed carry animation with the arms in front of the body. When running/jumping etc, the entire upper body will retain the aiming pose.

`unarmed_carry_score_card` - A two handed carry animation with the arms all the way extended above the head.  Ideal for holding text signs, etc. When running/jumping etc, the entire upper body will retain the aiming pose. The attachment point for the card is the right prop, and it registers to the center of the bottom edge of the card/sign.  It also assumes x forward.

`unarmed_sit_car_low` - A full body animation that is sitting at ground level with arms up on a wheel.  Ideal for driving a go-kart style vehicle
When running/jumping etc, the entire body will retain the sitting pose.
Currently cannot mix the lower body of this pose with other animation stances (holding a torch, etc).  Ability animations, however, can be used.

`unarmed_death` - A full body animation that is falling to the floor, face-up.  The hips will end roughly on the spot where the game thinks the character is. Suggested to turn on ragdoll.

`unarmed_death_spin` - A full body animation that spins 360 and then  falls to the floor, face-up.  The hips will end roughly on the spot where the game thinks the character is.

??? note "How to Turn on Ragdoll"
	```
    ability.owner.active_pose = "unarmed_death"
    Task.Wait(0.9)
    ability.owner:EnableRagdoll("spine", .4, true)
    ability.owner:EnableRagdoll("right_shoulder", .2, true)
    ability.owner:EnableRagdoll("left_shoulder", .6, true)
    ability.owner:EnableRagdoll("right_hip", .6, true)
    ability.owner:EnableRagdoll("left_hip", .6, true)
    ```

### One Shot Animation Information

One Shot Animations will:
work regardless of which animation skeleton (gender) or outfit you are wearing.
be interrupted (or fail to start) if you are moving, jumping, or falling.
be interrupted if you execute an ability with a defined ability animation.
be interrupted (or fail to start) if you execute an active pose animation.

??? note "One Shot Animation Strings"
    * base_unarmed_ball_kick
    * base_unarmed_magic_bolt
    * base_unarmed_left_punch
    * base_unarmed_right_punch
    * base_unarmed_roll
    * base_unarmed_throw
    * base_unarmed_dance
    * base_unarmed_fetal
    * base_unarmed_carry_object_heavy
    * base_unarmed_carry_object_high
    * base_unarmed_carry_object_low
    * base_unarmed_score_card
    * base_unarmed_sit_car_low
    * base_unarmed_idle
    * base_unarmed_idle_relaxed
    * base_unarmed_idle_to_idle_relaxed
    * base_unarmed_jump_begin
    * base_unarmed_jump_cycle
    * base_unarmed_jump_end
    * base_unarmed_run_backward
    * base_unarmed_run_backward_left
    * base_unarmed_run_backward_right
    * base_unarmed_run_forward
    * base_unarmed_run_forward_left
    * base_unarmed_run_forward_right
    * base_unarmed_run_forward_stop
    * base_unarmed_run_left
    * base_unarmed_run_right
    * base_unarmed_walk_backward
    * base_unarmed_walk_backward_left
    * base_unarmed_walk_backward_right
    * base_unarmed_walk_forward
    * base_unarmed_walk_forward_left
    * base_unarmed_walk_forward_right
    * base_unarmed_walk_left
    * base_unarmed_walk_right
    * base_1h_left_sweep
    * base_1h_right_sweep
    * base_1h_idle
    * base_1h_idle_relaxed
    * base_1h_idle_to_idle_relaxed
    * base_1h_jump_begin
    * base_1h_jump_cycle
    * base_1h_jump_end
    * base_1h_run_backward
    * base_1h_run_backward_left
    * base_1h_run_backward_right
    * base_1h_run_forward
    * base_1h_run_forward_left
    * base_1h_run_forward_right
    * base_1h_run_forward_stop
    * base_1h_run_left
    * base_1h_run_right
    * base_1h_walk_backward
    * base_1h_walk_backward_left
    * base_1h_walk_backward_right
    * base_1h_walk_forward
    * base_1h_walk_forward_left
    * base_1h_walk_forward_right
    * base_1h_walk_left
    * base_1h_walk_right
    * base_crossbow_magazine_reload
    * base_crossbow_shoot
    * base_crossbow_idle
    * base_crossbow_idle_relaxed
    * base_crossbow_idle_to_idle_relaxed
    * base_crossbow_jump_begin
    * base_crossbow_jump_cycle
    * base_crossbow_jump_end
    * base_crossbow_run_backward
    * base_crossbow_run_backward_left
    * base_crossbow_run_backward_right
    * base_crossbow_run_forward
    * base_crossbow_run_forward_left
    * base_crossbow_run_forward_right
    * base_crossbow_run_forward_stop
    * base_crossbow_run_left
    * base_crossbow_run_right
    * base_crossbow_walk_backward
    * base_crossbow_walk_backward_left
    * base_crossbow_walk_backward_right
    * base_crossbow_walk_forward
    * base_crossbow_walk_forward_left
    * base_crossbow_walk_forward_right
    * base_crossbow_walk_left
    * base_crossbow_walk_right

### Ability Binding list

??? note "Ability Binding List"
    * Mouse 1 = ability_primary
    * Mouse 2 = ability_secondary
    * Q and Gamepad Left face button = ability_1 (to be deprecated)
    * E = ability_2 (to be deprecated)
    * R = ability_ult (to be deprecated)
    * Left Shift and Gamepad left shoulder = ability_feet
    * 0 = ability_extra_0
    * 1 = ability_extra_1
    * 2 = ability_extra_2
    * 3 = ability_extra_3
    * 4 = ability_extra_4
    * 5 = ability_extra_5
    * 6 = ability_extra_6
    * 7 = ability_extra_7
    * 8 = ability_extra_8
    * 9 = ability_extra_9
    * Left Ctrl = ability_extra_10
    * Right Ctrl = ability_extra_11
    * Left Shift = ability_extra_12
    * Right Shift = ability_extra_13
    * Left Alt = ability_extra_14
    * Right Alt = ability_extra_15
    * Return = ability_extra_16
    * Spacebar = ability_extra_17
    * Capslock = ability_extra_18
    * Tab = ability_extra_19
    * Q = ability_extra_20
    * W = ability_extra_21
    * E = ability_extra_22
    * R = ability_extra_23
    * T = ability_extra_24
    * Y = ability_extra_25
    * U = ability_extra_26
    * I = ability_extra_27
    * O = ability_extra_28
    * P = ability_extra_29
    * A = ability_extra_30
    * S = ability_extra_31
    * D = ability_extra_32
    * F = ability_extra_33
    * G = ability_extra_34
    * H = ability_extra_35
    * J = ability_extra_36
    * K = ability_extra_37
    * L = ability_extra_38
    * Z = ability_extra_39
    * X = ability_extra_40
    * C = ability_extra_41
    * V = ability_extra_42
    * B = ability_extra_43
    * N = ability_extra_44
    * M = ability_extra_45
    * Up Arrow = ability_extra_46
    * Down Arrow =ability_extra_47
    * Left Arrow = ability_extra_48
    * Right Arrow = ability_extra_49
    * F1 = ability_extra_50
    * F2 = ability_extra_51
    * F3 = ability_extra_52
    * F4 =  ability_extra_53
    * F5 = ability_extra_54
    * F6 = ability_extra_55
    * F7 = ability_extra_56
    * F8 = ability_extra_57
    * F9 = ability_extra_58
    * F10 = ability_extra_59
    * F11 = ability_extra_60
    * F12 = ability_extra_61
    * Insert = ability_extra_62
    * Home = ability_extra_63
    * Page Up = ability_extra_64
    * Page Down = ability_extra_65
    * Delete = ability_extra_66
    * End = ability_extra_67
