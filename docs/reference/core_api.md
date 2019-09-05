# Lua Scripting API

## Overview

CORE has integrated version 5.3.4 of the Lua library.  For detailed technical information, see their [reference manual](https://www.lua.org/manual/5.3/). At a high level, CORE Lua types can be divided into two groups: data structures and [CoreObjects](/core_api/classes/coreobject).  Data structures are owned by Lua, while [CoreObjects](/core_api/classes/coreobject) are owned by the engine and could be destroyed while still referenced by Lua.  

Properties, functions, and events inherited by [CoreObject](/core_api/classes/coreobject) types are listed below.
Both properties and events are accessed with `.propertyName` and `.eventName`, while functions are accessed with `:functionName()`.

### [Ability](/core_api/classes/ability/abilityOverview)

Abilities are Objects created at runtime and attached to Players. Spawn an ability with `game:SpawnAbility()`. Abilities can be activated by association with an Action Binding. They flow internally through the phases: Ready, Cast, Execute, Recovery and Cooldown.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`isEnabled` | bool | Turns an ability on/off. Ability remains on the player but is interrupted if enabled is set to False during an active Ability. | Read-Write
`canActivateWhileDead` | bool | Indicates if the Ability can be used while the owning Player is dead. Default false.  | Read-Write
`name` | string | The name of the ability. | Read-Write
`binding` | string | Which action binding will cause the Ability to activate. | Read-Write
`owner` | Player | Assigning an owner applies the Ability to that Player. | Read-Write
`castPhaseSettings` | AbilityPhaseSettings | Config data for the Cast phase. | Read-Write
`executePhaseSettings` | AbilityPhaseSettings | Config data for the Execute phase. | Read-Write
`recoveryPhaseSettings` | AbilityPhaseSettings | Config data for the Recovery phase. | Read-Write
`cooldownPhaseSettings` | AbilityPhaseSettings | Config data for the Cooldown phase. | Read-Write
`animation` | string | Name of the animation the Player will play when the ability is activated. Possible values: | Read-Write
`canBePrevented` | bool | Used in conjunction with the phase property preventsOtherAbilities so multiple abilities on the same Player can block each other during specific phases. By default, true.  | Read-Write
`readyEvent` | Event<Ability> | Event called when the Ability becomes ready. In this phase it is possible to activate it again. | Read-Only
`castEvent` | Event<Ability> | Called when the Ability enters the Cast phase. | Read-Only
`executeEvent` | Event<Ability> | Called when the Ability enters Execute phase. | Read-Only
`recoveryEvent` | Event<Ability> | Called when the Ability enters Recovery. | Read-Only
`cooldownEvent` | Event<Ability> | Called when the Ability enters Cooldown. | Read-Only
`interruptedEvent` | Event<Ability> | Called when the Ability is interrupted. | Read-Only
`tickEvent` | Event<Ability> | Called every tick while the Ability is active. | Read-Write

Function | Return Value | Description | Tags
--- | --- | --- | ---
`Activate()` | None | Activates an ability as if the button had been pressed. | Client-Context
`Interrupt()` | None | Changes an Ability from Cast phase to Ready phase. If the Ability is in either Execute or Recovery phases it instead goes to Cooldown phase. | None
`GetCurrentPhase()` | AbilityPhase | The current ability phase for this ability. | None
`GetPhaseTimeRemaining()` | Number | Seconds left in the current phase. | None
`GetTargetData()` | AbilityTarget | Returns information about what the player has targeted this phase. | None
`SetTargetData (AbilityTarget)` | None | Updates information about what the player has targeted this phase.  This can affect execution of the ability. | None


### [AbilityPhaseSettings](/core_api/classes/abilityphasesettings/abilityphasesettingsOverview)

Each phase of an Ability can be configured differently, allowing complex and different Abilities.  AbilityPhaseSettings is an Object.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`duration` | Number | Length in seconds of the phase. After this time the Ability moves to the next phase. Can be zero. By default, values per phase: 0.15, 0, 0.5 and 3. | Read-Write
`canMove` | bool | Whether the Player is allowed to move during this phase. Default true. | Read-Write
`canJump` | bool | Whether the Player allowed to jump during this phase. Default false. In Cast & Execute, default True in Recovery & Cooldown. | Read-Write
`canRotate` | bool | Whether the Player allowed to rotate during this phase. Default true. | Read-Write
`isFlying` | bool | If true, gravity is turned off during this phase and if there is root motion, it is allowed to pick up the Player off the ground. This is primarily intended for use with the “roll” animation, or any other animation with vertical root motion. Default false. | Read-Write
`preventsOtherAbilities` | bool | If true, this phase prevents the player from casting another Ability, unless that other Ability has can_be_prevented set to false. Default true in Cast & Execute, default false in Recovery & Cooldown. | Read-Write
`isTargetDataUpdated` | bool | If true, there will be updated target information at the start of the phase. Otherwise, target information may be out of date. | Read-Write
`playerFacing` | AbilitySetFacingEnum | How this ability rotates the player during execution. Cast and Execute default to “Aim”, other phases default to “None”. Options are: AbilitySetFacing.NONE, AbilitySetFacing.MOVEMENT, AbilitySetFacing.AIM | Read-Write

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
`spreadRandomSeed` | Number | Seed that can be used with RandomStream for deterministic RNG. | Read-Only

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

### [AbilityUIControl](/core_api/classes/abilityuicontrol/abilityuicontrolOverview)

A UIControl for showing the state of an Ability.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`ability` | Ability | Which ability object should be shown by the control. | None

### [Audio](/core_api/classes/audio/audioOverview)

Audio objects are CoreObjects that wrap sound files. Most properties are exposed in the UI and can be set when placed in the editor, but some functionality (such as playback with fade in/out) requires Lua scripting.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`isPlaying` | bool | Returns if the sound is currently playing. | Read-Only
`length` | Number | Returns the length (in seconds) of the sound. | Read-Only
`currentPlaybackTime` | Number | Returns the playback position (in seconds) of the sound. | Read-Only
`isSpatializationDisabled` | bool | Set true to play sound without 3D positioning. Default false. | Dynamic, Read-Write
`isAutoPlayEnabled` | bool | If set to true when placed in the editor (or included in a template), the sound will be automatically played when loaded. Default false.  | Read-Only
`isTransient` | bool | If set to true, the sound will destroy itself after it finishes playing. Default false. | Read-Write
`isAutoRepeatEnabled` | bool | Loops when playback has finished. Some sounds are designed to automatically loop, this flag will force others that don't (can be useful for looping music.) | Read-Write
`pitch` | Number | Default 1. Multiplies the playback pitch of a sound. Note that some sounds have clamped pitch ranges (so 0.2-1 will work, above 1 might not.) | Read-Write
`volume` | Number | Default 1. Multiplies the playback volume of a sound. Note that values above 1 can distort sound, so if you're trying to balance sounds, experiment to see if scaling down works better than scaling up. | Read-Write
`radius` | Number | Default 0 (off). If non-zero, will override default 3D spatial parameters of the sound. Radius is the distance away from the sound position that will be played at 100% volume. | Read-Write
`falloff` | Number | Default 0 (off). If non-zero, will override default 3D spatial parameters of the sound. Falloff is the distance outside the radius over which the sound volume will gradually fall to zero. | Read-Write

Function | Return Value | Description | Tags
--- | --- | --- | ---
`Play()` | None | Begins sound playback. | None
`Stop()` | None | Stops sound playback. | None
`FadeIn(Number time)` | Number | Starts playing and fades the sound in over the given time. | None
`FadeOut(Number time)` | Number | Fades the sound out and stops over time seconds. | None

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
`clickedEvent` | Event<ButtonUIControl> | Called when button is clicked. This triggers on mouse-button up, if both button-down and button-up events happen inside the button hitbox. | Read-Only
`pressedEvent` | Event<ButtonUIControl> | Called when button is pressed (mouse button down). | Read-Only
`releasedEvent` | Event<ButtonUIControl> | Called when button is released (mouse button up). | Read-Only
`hoveredEvent` | Event<ButtonUIControl> | Called when button is hovered. | Read-Only
`unhoveredEvent` | Event<ButtonUIControl> | Called when button is unhovered. | Read-Only

### [CameraSettings](/core_api/classes/camerasettings/camerasettingsOverview)

CameraSettings is a CoreObject which can be used to configure camera settings for a Player.

Function | Return Value | Description | Tags
--- | --- | --- | ---
`ApplyToPlayer(Player)` | None | Apply settings from this settings object to player. | Server Context

### [CanvasControl](/core_api/classes/canvascontrol/canvascontrolOverview)

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

### [CoreObject](/core_api/classes/coreobject/coreobjectOverview)

CoreObject is an Object placed in the scene hierarchy during edit mode.  Usually they’ll be a more specific type of CoreObject, but all CoreObjects have these

Property | Return Value | Description | Tags
--- | --- | --- | ---
`name` | string | The object's name. | Read-Write, Dynamic
`id` | string | The object’s MUID. | Read-Only
`parent` | CoreObject | The object’s parent object, may be nil. | Read-Write, Dynamic
`isVisible` | bool | Turn on/off the rendering of an object and its children. | Read-Write, Dynamic
`isCollidable` | bool | Turn on/off the collision of an object and its children. | Read-Write, Dynamic
`isEnabled` | bool | Turn on/off an object and its children completely. | Read-Write, Dynamic
`isStatic` | bool | If true, dynamic properties may not be written to, and dynamic functions may not be called. | Read-Only, Static, Dynamic
`isClientOnly` | bool | If true, this object was spawned on the client and is not replicated from the server. | Read-Only
`isServerOnly` | bool | If true, this object was spawned on the server and is not replicated to clients. | Read-Only
`isNetworked` | bool | If true, this object replicates from the server to clients. | Read-Only
`lifeSpan` | Number | Duration after which the object is destroyed. | Read-Write, Dynamic
`sourceTemplateId` | string | The ID of the Template from which this Core Object was instantiated. Returns nil if the object did not come from a Template. | Read-Only
`childAddedEvent` | Event<CoreObject parent, CoreObject new_child> | An event fired when a child is added to this object. | Read-Only
`childRemovedEvent` | Event<CoreObject parent, CoreObject removed_child> | An event fired when a child is removed from this object. | Read-Only
`descendantAddedEvent` | Event<CoreObject ancestor, CoreObject new_child> | An event fired when a child is added to this object or any of its descendants. | Read-Only
`descendantRemovedEvent ` | Event<CoreObject ancestor, CoreObject removed_child> | An event fired when a child is removed from this object or any of its descendants. | Read-Only
`destroyEvent` | Event<CoreObject> | An event fired when this object is about to be destroyed. | Read-Only

Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetTransform()` | Transform | The transform relative to this object’s parent. | None
`SetTransform(Transform)` | None | The transform relative to this object’s parent. | Dynamic
`GetPosition()` | Vector3 | The position of this object relative to its parent. | None
`SetPosition (Vector3)` | None | The position of this object relative to its parent. | Dynamic
`GetRotation()` | Rotation | The rotation relative to its parent. | None
`SetRotation (Rotation)` | None | The rotation relative to its parent. | Dynamic
`GetScale()` | Vector3 | The scale relative to its parent. | None
`SetScale()` | None | The scale relative to its parent. | Dynamic
`GetWorldTransform()` | Transform | The absolute transform of this object. | None
`SetWorldTransform(Transform)` | None | The absolute transform of this object. | Dynamic
`GetWorldPosition()` | Vector3 | The absolute position. | None
`SetWorldPosition(Vector3)` | None | The absolute position. | Dynamic
`GetWorldRotation()` | Rotation | The absolute rotation. | None
`SetWorldRotation(Rotation)` | None | The absolute rotation. | Dynamic
`GetWorldScale()` | Vector3 | The absolute scale. | None
`SetWorldScale(Vector3)` | None | The absolute scale. | Dynamic
`GetVelocity()` | Vector3 | The object’s velocity in world space. | None
`SetVelocity(Vector3)` | None | The object’s velocity in world space. | Dynamic
`GetAngularVelocity()` | Vector3 | The object’s angular velocity in degrees per second. | None
`SetAngularVelocity(Vector3)` | None | The object’s angular velocity in degrees per second. | Dynamic
`GetReference()` | CoreObjectReference | Returns a CoreObjectReference pointing at this object. | None
`GetChildren()` | array<CoreObject> | Returns a table containing the object’s children, may be empty (1 indexed). | None
`FindAncestorByName(string name)` | CoreObject | Returns the first parent or ancestor whose name matches the provided name.  If none match, returns nil. | None
`FindChildByName(string name)` | CoreObject | Returns the first immediate child whose name matches the provided name.  If none match, returns nil. | None
`FindDescendantByName(string name)` | CoreObject | Returns the first child or descendant whose name matches the provided name.  If none match, returns nil. | None
`FindDescendantsByName(string name)` | array<CoreObject> | Returns the descendants whose name matches the provided name.  If none match, returns an empty table. | None
`FindAncestorByType(string type_name)` | CoreObject | Returns the first parent or ancestor whose type is or extends the specified type.  For example, calling FindAncestorByType(‘CoreObject’) will return the first ancestor that is any type of CoreObject, while FindAncestorByType(‘StaticMesh’) will only return the first static mesh. If no ancestors match, returns nil. | Static
`FindChildByType(string type_name)` | CoreObject | Returns the first immediate child whose type is or extends the specified type.  If none match, returns nil. | None
`FindDescendantByType(string type_name)` | CoreObject | Returns the first child or descendant whose type is or extends the specified type.  If none match, returns nil. | None
`FindDescendantsByType(string type_name)` | array<CoreObject> | Returns the descendants whose type is or extends the specified type.  If none match, returns an empty table. | None
`FindTemplateRoot()` | CoreObject | If the object is part of a template, returns the root object of the template (which may be itself). If not part of a template, returns nil. | None
`IsAncestorOf(CoreObject)` | bool | Returns true if this core object is a parent somewhere in the hierarchy above the given parameter object. False otherwise. | None
`GetCustomProperty(string property_name)` | value, bool | Gets data which has been added to an object using the custom property system.  Returns the value, which can be an Integer, Number, bool, string, Vector3, Rotator, Color, a MUID string, or nil if not found.  Second return value is a bool, true if found and false if not. | None
`AttachToPlayerCamera(Player)` | None | Attaches a CoreObject to given player’s camera. This should be called inside a Client Context. Reminder to turn off the object’s collision otherwise it will cause camera to jitter. | Client Context, Dynamic
`Detach()` | None | Detaches a CoreObject from any player it has been attached to, or from its parent object. | Dynamic
`GetAttachedToSocketName()` | string | return name of the socket this object is attached to. | None
`MoveTo(Vector3, Number, bool)` | None | Smoothly moves the object to the target location over a given amount of time. Third parameter specifies if this should be done in local space (true) or world space (false). | Dynamic
`RotateTo(Rotation/Quaternion, Number, bool)` | None | Smoothly rotates the object to the target orientation over a given amount of time. Third parameter specifies if this should be done in local space (true) or world space (false). | Dynamic
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
`LookAtCamera(bool)` | None | Continuously looks at the local camera. The bool parameter is optional and locks the pitch. | Dynamic
`Destroy()` | None | Destroys the object.  You can check whether an object has been destroyed by calling is_valid(object), which will return true if object is still a valid object, or false if it has been destroyed. | Dynamic

### [CoreObjectReference](/core_api/classes/coreobjectreference/coreobjectreferenceOverview)

A reference to a CoreObject which may or may not exist.  This type is returned by CoreObject:GetCustomProperty() for Core Object Reference properties, and may be used to find the actual object if it exists.  (For networked objects, it is possible to get a CoreObjectReference pointing to a CoreObject that hasn’t been received on the client yet.)

Property | Return Value | Description | Tags
--- | --- | --- | ---
`id` | string | The MUID of the referred object. | Read-Only

Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetObject()` | CoreObject | Returns the CoreObject with a matching ID, if it exists.  Will otherwise return nil. | None
`WaitForObject([float])` | CoreObject | Returns the CoreObject with a matching ID, if it exists.  If it does not, yields the current task until the object is spawned.  Optional timeout parameter will cause the task to resume with a return value of false and an error message if the object has not been spawned within that many seconds. | None

### [Damage](/core_api/classes/damage/damageOverview)

To damage a Player, you can simply write e.g.: whichPlayer:ApplyDamage(Damage.New(10)). Alternatively, create a Damage object and populate it with all the following properties to get full use out of the system:

Property | Return Value | Description | Tags
--- | --- | --- | ---
`amount` | Number | The numeric amount of damage to inflict. | Read-Write
`reason` | Damage/Reason | What is the context for this Damage? | Read-Write
`sourceAbility` | Ability | Reference to the Ability which caused the Damage. Setting this automatically sets sourceAbilityName. | Read-Write
`sourceAbilityName` | string | Name of the ability which caused the Damage. | Read-Write
`sourcePlayer` | Player | Reference to the Player who caused the Damage. Setting this automatically sets sourcePlayerName. | Read-Write
`sourcePlayerName` | string | Name of the player who caused the Damage. | Read-Write

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
`equippedEvent` | Event<Equipment, Player> | An event fired when this equipment is equipped onto a player. | Read-Only
`unequippedEvent` | Event<Equipment, Player> | An event fired when this object is unequipped from a player. | Read-Only

Function | Return Value | Description | Tags
--- | --- | --- | ---
`Equip(Player)` | None | Attaches the Equipment to a Player. They gain any abilities assigned to the Equipment. If the Equipment is already attached to another Player it will first unequip from that other Player before equipping unto the new one. | None
`Unequip()` | None | Detaches the Equipment from any Player it may currently be attached to. The player loses any abilities granted by the Equipment. | None
`AddAbility(Ability)` | None  | Adds an Ability to the list of abilities on this Equipment. | None
`GetAbilities()` | array<Ability> | A table of Abilities that are assigned to this Equipment. Players who equip it will get these Abilities. | None

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

### [Game](/core_api/classes/game/gameOverview)

Game is a singleton Object type providing access to some useful functions and events.  It is accessed via the global variable game.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`root` | CoreObject | The root of the scene object hierarchy. | Read-Only
`playerJoinedEvent` | Event<Player> | Event fired when a player has joined the game and their character is ready. | Read-Only
`playerLeftEvent` | Event<Player> | Event fired when a player has disconnected from the game or their character has been destroyed. | Read-Only
`abilitySpawnedEvent` | Event<Ability> | Event fired when an ability is spawned. Useful for client contexts to hook up to ability events. | Client Context, Read-Only
`roundStartEvent` | Event | Event fired when StartRound is called on game. | Read-Only
`roundEndEvent` | Event | Event fired when EndRound is called on game. | Read-Only

Function | Return Value | Description | Tags
--- | --- | --- | ---
`FindObjectsByName(string name)` | array<CoreObject> | Returns a table containing all the objects in the hierarchy with a matching name.  If none match, an empty table is returned. | None
`FindObjectsByType(string type_name)` | array<CoreObject> | Returns a table containing all the objects in the hierarchy whose type is or extends the specified type.  If none match, an empty table is returned.  See below for valid type names. | None
`FindObjectByName(string type_name)` | CoreObject | Returns the first object found with a matching name. In none match, nil is returned. | None
`FindObjectById(string muid_string)` | CoreObject | Returns the object with a given MUID.  Returns nil if no object has this ID. | None
`GetPlayers()` | array<Player> | Returns a table containing the players currently in the game. The last player that joined is the last player in the table, and the first player is the first element in the table (assuming they haven’t left). | None
`GetAlivePlayers()` | array<Player> | Returns a table containing the players currently in the game who are not dead. | None
`GetLocalPlayer()` | Player | Returns the local player (or nil on the server). | None
`FindNearestPlayer(Vector3 position)` | Player | Returns the Player that is nearest to the given position. | None
`FindNearestAlly(Vector3 position, Integer team, Player ignore)` | Player | Returns the Player that is nearest to the given position but is on the given team. The last parameter is optional, allowing one Player to be ignored from the search. | None
`FindNearestEnemy(Vector3 position, Integer team)` | Player | Returns the Player that is nearest to the given position but is not on the given team. | None
`FindPlayersInCylinder(Vector3 position, Number radius)` | array<Player> | Returns a table with all Players that are in the given area. Position’s Z is ignored with the cylindrical area always upright. | None
`FindAlliesInCylinder(Vector3 position, Number radius, Integer team)` | array<Player> | Returns a table with all Players that are in the given cylindrical area and who belong to the given team. | None
`FindEnemiesInCylinder(Vector3 position, Number radius, Integer team)` | array<Player> | Returns a table with all Players that are in the given cylindrical area and who do not belong to the given team. | None
`FindPlayersInSphere(Vector3 position, Number radius)` | array<Player> | Returns a table with all Players that are in the given spherical area. | None
`FindAlliesInSphere(Vector3 position, Number radius, Integer team)` | array<Player> | Returns a table with all Players that are in the given spherical area and who belong to the given team. | None
`FindEnemiesInSphere(Vector3 position, Number radius, Integer team)` | array<Player> | Returns a table with all Players that are in the given spherical area and who do not belong to the given team. | None
`SpawnTemplate(string template_id, [Location])` | CoreObject | Spawns an instance of a template.  Location can be a Vector3 or a full Transform and is in world space. | None
`SpawnTemplate(string template_id, Transform transform, CoreObject parent)` | CoreObject | Spawns an instance of a template as a child of a given parent.  Location can be a Vector3 or a full Transform and is in the parent’s local space. More on Templates. | None
`SpawnProjectile(string child_template_id, Vector3 start_position, Vector3 direction)` | Projectile | Spawns a Projectile with a child that is an instance of a template. More on Projectiles. | None
`SpawnAbility()` | Ability | Spawns an ability object. | None
`SpawnAsset(string asset_id, Vector3/Transform location, [CoreObject parent])` | CoreObject | Spawns an instance of the specified asset.  The asset_id needs to be referenced through Asset Reference custom property to work. Interface is same as SpawnTemplate() | None
`Raycast(Vector3 rayStart, Vector3 rayEnd, Player playerToIgnore(optional), String teamToIgnore (optional))` | HitResult | Traces a ray from rayStart to rayEnd, returning a HitResult with data about the impact point and object. Can be set to ignore a specific player or an entire team. | None
`RaycastIgnoreAllPlayers(Vector3 rayStart, Vector3 rayEnd)` | HitResult | similar to raycast(), but ignores all players. | None
`GetCursorHit()` | HitResult | return hit result from local client’s view in direction of the projected cursor position. Meant for client-side use only, for ability cast, please use ability:GetTargetData():GetHitPosition(), which would contain cursor hit position at time of cast, when in topdown camera mode | None
`GetCursorPlaneIntersection(Vector3 pointOnPlane, Vector3 planeNormal[optional default to up vector])` | Vector, bool | return intersection from local client’s camera direction to given plane, specified by point on plane and optionally its normal. Meant for client-side use only. | None
`AreTeamsEnemies(Integer team1, Integer team2)` | bool | Returns true if teams are considered enemies under the current TeamMode. If either team is TEAM_NEUTRAL=0, returns false. | None
`AreTeamsFriendly(Integer team1, Integer team2)` | bool | Returns true if teams are considered friendly under the current TeamMode. If either team is TEAM_NEUTRAL=0, returns false. | None
`StartRound()` | None | Fire all events attached to roundStartEvent | Server Context
`EndRound()` | None | Fire all events attached to roundEndEvent | Server Context

### [HitResult](/core_api/classes/hitresult/hitresultOverview)

Contains data pertaining to an impact or raycast.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`other` | CoreObject or Player | Reference to a CoreObject or Player impacted. | None
`isHeadshot` | bool | True if the weapon hit another player in the head. | Read-Only
`boneName` | string | If the hit was on a player boneName tells you which spot on the body was hit. | Read-Only

Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetImpactPosition()` | Vector3 | The world position where the impact occurred. | None
`GetImpactNormal()` | Vector3 | Normal direction of the surface which was impacted. | None
`GetTransform()` | Transform | Returns a Transform composed of the position of the impact in world space, the rotation of the normal, and a uniform scale of 1. | None

### [ImageUIControl](/core_api/classes/imageuicontrol/imageuicontrolOverview)

A UIControl for displaying an image.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`isTeamColorUsed` | Color | If true, the image will be tinted blue if its team matches the player, or red if not | None
`team` | Number | the team of the image, used for isTeamColorUsed | None

Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetColor()` | Color | The tint to apply to the image | None
`SetColor(Color)` | None | The tint to apply to the image | None
`SetImage(brushMuidString)` | None | set image | None

### [NetworkContext](/core_api/classes/networkcontext/networkcontextOverview)

NetworkContext is a CoreObject representing a special folder containing client-only, server-only, or static objects.  It currently has no properties or functions of its own, but inherits everything from CoreObject.

### [Object](/core_api/classes/object/objectOverview)

At a high level, CORE Lua types can be divided into two groups: data structures and Objects.  Data structures are owned by Lua, while Objects are owned by the engine and could be destroyed while still referenced by Lua.  Any such object will inherit from this type.  These include Ability, CoreObject, Player, and Projectile.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`userData(table)` | table | Table in which users can store any data they want. | None

Static Functions | Return Value | Description | Tags
--- | --- | --- | ---
`IsValid(Object object)` | bool | Returns true if object is still a valid Object, or false if it has been destroyed.  Also returns false if passed a nil value or something that’s not an Object, such as a Vector3 or a string. | None

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
`id)` | string | The unique id of the player. Consistent across sessions. | Read-Only
`team` | Number | The number of the team to which the player is assigned. By default, this value is 255 in FFA mode. | Read-Write
`animationSet` | string | Which set of animations to use for this player. Values can be “unarmed”, “1hand_melee”, “1hand_pistol”, “2hand_sword” or “2hand_rifle”. (Deprecated values were “one_handed”, “pistol”, and “crossbow”) | Read-Write
`activePose` | string | Determines an animation pose to hold during idle. Default value is “none”. Other values can be "2hand_rifle_aim_shoulder", "2hand_rifle_aim_hip", "1hand_pistol_aim", "2hand_pistol_aim", "unarmed_carry_object_high", "unarmed_carry_object_low", "unarmed_carry_object_heavy", "unarmed_carry_score_card", "unarmed_sit_car_low".  See Active Pose Information | Read-Write
`facingMode` | string | Which controls mode to use for this player. Values can be “strafe” or “loose”. | Read-Write
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
`isClimbing` | bool | True if the player is climbing. | Read-Only
`isCrouching` | bool | True if the player is crouching. | Read-Only
`isFlying` | bool | True if the player is flying. | Read-Only
`isGrounded` | bool | True if the player is on the ground with no upward velocity, otherwise false | Read-Only
`isJumping` | bool | True if the player is jumping. | Read-Only
`isMounted` | bool | True if the player is mounted on another object. | Read-Only
`isSwimming` | bool | True if the player is swimming in water. | Read-Only
`isWalking` | bool | True if the player is in walking mode. | Read-Only
`isDead` | bool | True if the player is dead, otherwise false. Can be set as well. | Read-Write
`cameraSensitivity` | Number | Multiplier on camera rotation speed relative to cursor movement. Default is 1.0. This is independent from player preference, both will be applied as multipliers together. | Read-Write
`cursorMoveInputMode` | CursorMoveInput enum | Enables move towards cursor when a button is held, values for CursorMoveInput enum are: NONE, LEFT_MOUSE, RIGHT_MOUSE, LEFT_OR_RIGHT_MOUSE. Example usage: player.cursorMoveInputMode = CursorMoveInput.LEFT_MOUSE | Read-Write
`canTopdownCameraRotate` | bool | If true, can rotate in topdown mode | Read-Write
`showBodyForFpsCamera` | bool | (for trying out showing body in FPS camera, will likely change/be removed) show body mesh in FPS camera mode | Read-Write
`shouldRotationFollowCursor` | bool | If true, character will rotate to face cursor (intended for topdown mode) | Read-Write
`scrollZoomSpeed` | Number | Multiplier to mouse wheel scroll speed for zoom | Read-Write
`spreadModifier` | Number | Added to the player’s targeting spread | Read-Write
`buoyancy` | Number | In water, buoyancy 1.0 is neutral (won’t sink or float naturally). Less than 1 to sink, greater than 1 to float. | Read-Write
`isCursorVisible` | bool | Whether cursor is visible. Will be set automatically by camera mode by default, but can be overriden afterwards | Read-Write
`isCursorLocked` | bool | Whether to lock cursor in viewport. Will be set automatically by camera mode by default, but can be overriden afterwards | Read-Write
`isCursorInteractableWithUI` | bool | Whether cursor can interact with UI elements like buttons. Will be set automatically by camera mode by default, but can be overriden afterwards | Read-Write
`damagedEvent` | Event<Player, Damage> | Event fired when the Player takes damage. | Read-Only
`diedEvent` | Event<Player, Damage> | Event fired when the Player dies. | Read-Only
`respawnedEvent` | Event<Player> | Event fired when the Player respawns. | Read-Only
`bindingPressedEvent` | Event<Player, String> | Event fired when an action binding is pressed. Second parameter tells you which binding. | Read-Only
`bindingReleasedEvent` | Event<Player, String> | Event fired when an action binding is released. Second parameter tells you which binding. | Read-Only
`resourceChangedEvent` | Event<Player> | Event fired when a resource changed | Read-Only
`keyValuePairReceivedEvent` | Event<Player, String, value> | Event fired when a key-value pair is received. See also SendKeyValuePairToServer(). | Read-Only

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
`GetRotationRate()` | Rotation | ? | None
`SetRotationRate (Rotation)` | None | no ? | None
`GetAbilities()` | array<Ability> | Array of all Abilities assigned to this Player. | None
`GetEquipment()` | array<Equipment> | Array of all Equipment assigned to this Player. | None
`ApplyDamage(Damage)` | None | Damages a Player. If their hitpoints go below 0, they die. | None
`Die([Damage])` | None | Kills the Player. They will ragdoll and ignore further Damage. The optional Damage parameter is a way to communicate cause of death. | None
`DisableRagdoll()` | None | Disables all ragdolls that have been set on the player. | None
`SetVisibility(bool, bool)` | None | Shows or hides the player. The second parameter is optional, defaults to true, and determines if attachments to the player are hidden as well as the player. | None
`SetReticleVisible(bool Show)` | None | Shows or hides the reticle for the player. | None
`SetNameVisible(bool)` | None | Set player name visibility | None
`EnableRagdoll(string SocketName, Number Weight, bool CameraFollows)` | Number | Enables ragdoll for the player, starting on “SocketName” weighted by “Weight” (between 0.0 and 1.0). This can cause the player capsule to detach from the mesh. Setting CameraFollows to true will force the player capsule to stay with the mesh. All parameters are optional; SocketName defaults to the root, Weight defaults to 1.0, CameraFollows defaults to true. Multiple bones can have ragdoll enabled simultaneously. | None
`ForceHideModelOnOwnerClient(bool)` | bool | Set whether to hide player model on player’s own client, for sniper scope, etc. Client-only. | Client Context
`SetClientIgnoreMoveInput(bool)` | None | Set whether to ignore move input on client. Client-only | Client Context
`GetClientIgnoreMoveInput()` | None | whether player ignores move input, Client-only | Client Context
`LockCamera(bool Enable)` | bool | If Enable is true (or no parameters are given), locks the camera at the current rotation. If Enable is false, the camera is unlocked if it was previously locked. | None
`LockCamera(Vector3 Direction)` | Vector3 | Locks the camera looking at the player in the Direction supplied. Roll is never applied to the camera. If Direction is directly up, down, or otherwise unable to be normalized, the function does nothing. | None
`LockCamera(Rotation NewRotation)` | Rotation | Locks the camera to the rotation supplied. | None
`AttachCameraTo(CoreObject, [blendTime])` | None | Have camera follow position and orientation of the given object. If blend time is <= 0, transition is instant. Default blend time is 2 seconds | None
`ResetCameraAttachment([blendTime])` | None | Set camera to attach back to its owner | None
`Respawn([Vector, Rotation])` | Rotation | Resurrects a dead Player at one of the Start Points. Optional position and rotation parameters can be used to specify a location. | None
`SetCameraDistance(Number Distance, bool Transition)` | None | Sets the Distance the camera floats from the player. Using a negative Distance will reset it to default. | None
`SetCameraOffset(Vector3 Offset, bool Transition)` | None | Adjusts the focus point for the camera (what the camera looks at and rotates around). Defaults to just off the shoulder. The Offset is calculated from the middle of the player. | None
`SetCameraLerpSpeed(float)` | None | set camera distance and offset lerp speed, default is 10 | None
`ResetCamera(bool Transition)` | bool | Sets the camera back to default, 3rd person behind character. If Transition is set to True (default behavior) the change will be smooth. | None
`SetCameraOverTheShoulder(bool Transition)` | None | Sets the camera to 3rd person over the shoulder. Ideal for firing weapons. If Transition is set to True (default behavior) the change will be smooth. | None
`SetupCameraTopdownFollow(Number PitchAngle, Number YawAngle, Number InitialDist, [Number MinDist, Number MaxDist])` | None | set camera in topdown mode, with given rotation and distance. Always follow player with player in center of view by default | None
`SetupCameraFps(optionalCameraOffset)` | None | set camera in first person mode (experimental) | None
`SetupCameraWithSettings(CameraSettings Settings)` | None | setup camera with given camera settings object (obsolete, please use CameraSettings:apply(player) instead) | None
`SetCameraFov(Number FoV)` | None | Sets the camera’s field of view for the player. | None
`GetCameraPosition()` | Vector3 | Get position of player’s camera view. Only works for local player. | None
`GetCameraForward()` | Vector3 | Get forward vector of player’s camera view. Only works for local player. | None
`ShowHitFeedback([Color])` | Color | Shows diagonal crosshair feedback. Useful, e.g. when a shot connects with a target. Optional Color defaults to red. | None
`PlayAnimation(String animationName, bool isLooping, Number duration)` | Number | Plays a specific animation.  See below for valid strings. | None
`ClearResources()` | None | Removes all resources from a player. | None
`GetResource(String name)` | string | Returns the amount of a resource owned by a player. | None
`SetResource(String name, Integer amount)` | None | Sets a specific amount of a resource on a player. | None
`AddResource(String name, Integer amount)` | Number | Adds an amount of a resource to a player. | None
`RemoveResource(String name, Integer amount)` | Number | Subtracts an amount of a resource from a player. Does not go below 0. | None
`GetResourceNames()` | array<String> | return array containing resource names | None
`GetResourceNamesStartingWith(String prefix)` | array<String> | return array containing resource names starting with given prefix | None
`TransferToGame(String)` | string |  Only works in play off web portal. Transfers player to the game specified by the passed-in game ID (the string from the web portal link). | None
`GetAttachedObjects()` | table | Returns a table containing the CoreObjects attached to this player. | None
`SendKeyValuePairToServer(String key, value)` | string | send a key-value pair to server, value restricted to string, number, and vector at the moment. See also keyValuePairReceivedEvent. | None

### [PlayerStart](/core_api/classes/playerstart/playerstartOverview)

PlayerStart is a CoreObject representing a spawn point for players.  

Property | Return Value | Description | Tags
--- | --- | --- | ---
`team` | string | A tag controlling which players can spawn at this start point. | Read-Write, Dynamic

### [PointLight](/core_api/classes/pointlight/pointlightOverview)

PointLight is a placeable light source that is a CoreObject.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`intensity` | Number | The intensity of the light. This has two interpretations, depending on use_attenuation_radius. If true, the light's Intensity is in units of lumens, where 1700 lumens is a 100W lightbulb. If false: the light's Intensity is a brightness scale. | Read-Write, Dynamic
`hasAttenuationRadius` | bool | The attenuation method of the light. When enabled, attenuation_radius is used. When disabled, fall_off_exponent is used. Also changes the interpretation of the intensity property, see intensity for details. | Read-Write, Dynamic
`attenuationRadius` | Number | Bounds the light's visible influence. This clamping of the light's influence is not physically correct but very important for performance, larger lights cost more. | Read-Write, Dynamic
`fallOffExponent` | Number | Controls the radial falloff of the light when use_attenuation_radius is disabled. 2.0 is almost linear and very unrealistic and around 8.0 it looks reasonable. With large exponents, the light has contribution to only a small area of its influence radius but still costs the same as low exponents. | Read-Write, Dynamic
`sourceRadius` | Number | Radius of light source shape. | Read-Write, Dynamic
`sourceLength` | Number | Length of light source shape. | Read-Write, Dynamic
`isShadowCaster` | bool | Does this light cast shadows? | Read-Write, Dynamic
`hasTemperature` | Number | If true, uses the temperature value as illuminant. If false, uses the white (D65) as illuminant. | Read-Write, Dynamic
`temperature` | Number | Color temperature in Kelvin of the blackbody illuminant. White (D65) is 6500K. | Read-Write, Dynamic

Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetColor()` | Color | The color of the light. | None
`SetColor(Color)(dynamic)` | None | The color of the light | Dynamic

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
`sourceAbility` | Ability | ? | Read-Write
`speed` | Number | Returns cm/s. By default, 5000cm/s.  | Read-Write
`maxSpeed` | Number | Returns max cm/s. By default, zero for no limit. | Read-Write
`gravityScale` | Number | How much drop. Zero can be used to make a Projectile go in a straight line. By default, 1 for normal gravity. | Read-Write
`drag (Number, read/write, default 0)` | Number | Deceleration. Important for homing Projectiles (try a value around 5). Negative drag will cause the Projectile to accelerate. | Read-Write
`bouncesRemaining` | Number | Number of bounces remaining before it dies. By default, zero. | Read-Write
`bounciness` | Number | Velocity % maintained after a bounce. By default, 0.6. | Read-Write
`lifeSpan` | Number | Max seconds the projectile will exist. By default, 10 seconds. | Read-Write
`shouldBounceOnPlayers` | bool | Determines if the projectile should bounce off players or be destroyed, when bouncesRemaining is used. By default, false. | Read-Write
`piercesRemaining` | Number | Number of objects that will be pierced before it dies. A piercing Projectile loses no velocity when going through objects, but still fires the impactEvent event. If combined with bounces, all piercesRemaining are spent before bouncesRemaining are counted. By default, zero pierces. | Read-Write
`capsuleRadius` | Number | Shape of the projectile’s collision. By default, 22.| Read-Write
`capsuleLength` | Number | Shape of the projectile’s collision. A value of zero will make it shaped like a Sphere. By default, 44. | Read-Write
`homingTarget` | Player | The projectile accelerates towards its target. | Read-Write
`homingAcceleration` | Number | Magnitude of acceleration towards the target. By default, 10,000. | Read-Write
`shouldDieOnImpact` | bool | If true, the projectile is automatically destroyed when it hits something, unless it has bounces remaining. By default, true. | Read-Write
`impactEvent` | Event<Projectile, other Object, HitResult> | An event fired when the Projectile collides with something. Impacted object parameter will be either of type CoreObject or Player, but can also be nil. The HitResult describes the point of contact between the Projectile and the impacted object. | Read-Only
`lifeSpanEndedEvent` | Event<Projectile> | An event fired when the Projectile reaches the end of its lifespan. Called before it is destroyed. | Read-Only
`homingFailedEvent` | Event<Projectile> | The target is no longer valid, for example the player disconnected from the game or the object was destroyed somehow. | Read-Only

Function | Return Value | Description | Tags
--- | --- | --- | ---
`destroy()` | Object | Immediately destroys the object. | None
`GetTransform()` | Transform | Transform data for the Projectile in world space. | None
`GetWorldPosition()` | Vector3 | Position of the Projectile in world space. | None
`SetWorldPosition(Vector3)` | None | Position of the Projectile in world space. | None
`GetVelocity()` | Vector3 | Current direction and speed vector of the Projectile. | None
`SetVelocity(Vector3)` | None | Current direction and speed vector of the Projectile. | None

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
`context(table, read-only)` | table | Returns the table containing any non-local variables and functions created by the script.  This can be used to call (or overwrite!) functions on another script. | Read-Only

### [SpotLight](/core_api/classes/spotlight/spotlightOverview)

SpotLight is a PointLight that shines in a specific direction.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`innerConeAngle` | Number | ? | Read-Write, Dynamic
`outerConeAngle` | Number | ? | Read-Write, Dynamic

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
`team` | Number | Assigns the mesh to a team. Value range from 0 to 4. 0 is neutral team | Read-Write, Dynamic
`isTeamColorUsed` | bool | If true, and the mesh has been assigned to a valid team, players on that team will see a blue mesh, while other players will see red. (Requires a material that supports the color property.) | Read-Write, Dynamic
`isTeamCollisionDisabled` | bool | If true, and the mesh has been assigned to a valid team, players on that team will not collide with the mesh. | Read-Write, Dynamic
`isEnemyCollisionDisabled` | bool | If true, and the mesh has been assigned to a valid team, players on other teams will not collide with the mesh. | Read-Write, Dynamic
`isCameraCollisionDisabled` | bool | If true, and the mesh will not push against the camera. Useful for things like railings or transparent walls. | Read-Write, Dynamic

Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetColor()` | Color | Overrides the color of all materials on the mesh, and replicates the new colors. | None
`SetColor(Color)` | None | Overrides the color of all materials on the mesh, and replicates the new colors. | Dynamic
`GetMaterialProperty(Integer slot, string property_name)` | value, bool | Gets the current value of a property on a material in a given slot.  Returns the value, which can be an Number, bool, Vector3, Color, or nil if not found. Second return value is a bool, true if found and false if not. | None
`SetMaterialProperty(Integer slot, string property_name, value)` | bool | Sets the value of a property on a material in a given slot. Value, which can be a Number, bool, Vector3, or Color, but must match the type of the property on the material. Returns true if set successfully and false if not. | None
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
`GetStatus()` | TaskStatus | Returns the status of the Task. | None

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
`SetRotation (Rotation)` | None | Sets the rotation component of the transform. | None
`GetQuaternion()` | Quaternion | Returns a quaternion-based representation of the rotation. | None
`SetQuaternion (Quaternion)` | None | Sets the quaternion-based representation of the rotation. | None
`GetScale()` | Vector3 | Returns a copy of the scale component of the transform. | None
`SetScale (Vector3)` | None | Sets the scale component of the transform. | None
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
`team` | Number | Assigns the trigger to a team. Value range from 0 to 4. 0 is neutral team | Read-Write, Dynamic
`isTeamCollisionDisabled` | bool | If true, and the trigger has been assigned to a valid team, players on that team will not overlap or interact with the trigger. | Read-Write, Dynamic
`isEnemyCollisionDisabled` | bool | If true, and the trigger has been assigned to a valid team, players on enemy teams will not overlap or interact with the trigger. | Read-Write, Dynamic

Event | Return Value | Description | Tags
--- | --- | --- | ---
`beginOverlapEvent` | Event<CoreObject trigger, object other> | An event fired when an object enters the trigger volume.  The first parameter is the trigger itself.  The second is the object overlapping the trigger, which may be a CoreObject, a Player, or some other type.  Call other:IsA() to check the type.  Eg, other:IsA(‘Player’), other:IsA(‘StaticMesh’), etc. | Read-Only, Static
`endOverlapEvent` | Event<CoreObject trigger, object other> | An event fired when an object exits the trigger volume.  Parameters the same as beginOverlapEvent. | Read-Only
`interactedEvent` | Event<CoreObject trigger, Player> | An event fired when a player uses the interaction on a trigger volume (By default “F” key). The first parameter is the trigger itself and the second parameter is a Player. | Read-Only


### [UIControl](/core_api/classes/uicontrol/uicontrolOverview)

UIControl is a CoreObject which serves as a base class for other UI Control Proxies.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`x` | Number | Screen-space offset from the anchor. | None
`y` | Number | Screen-space offset from the anchor. | None
`width` | Number | Horizontal size of the control. | None
`height` | Number | Vertical size of the control. | None
`inheritParentWidth` | bool | inherit parent width | None
`inheritParentHeight` | bool | inherit parent height | None
`addSelfSizeToInheritedSize` | bool | add self width and height to inherited size | None
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
`y)` | Number | The Y component of the vector. | Read-Write
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
`Play()` | None | Starts playing the effect. | None
`Stop()` | None | Stops playing the effect. | None

### [Weapon](/core_api/classes/weapon/weaponOverview)

A Weapon is an Equipment that comes with built-in Abilities and fires Projectiles.

Property | Return Value | Description | Tags
--- | --- | --- | ---
`isReticleEnabled` | bool | If True, the reticle will appear when this Weapon is equipped. | Read-Write
`attackCooldownDuration` | Number | Interval between separate burst sequences. | Read-Write
`multiShotCount` | Number | Number of projectiles/hitscans that will fire simultaneously inside the spread area each time the Weapon attacks. Does not affect the amount of ammo consumed per attack. | Read-Write
`burstCount` | Number | Number of automatic activations of the weapon that generally occur in quick succession. | Read-Write
`shotsPerSecond` | Number | Used in conjunction with burst_count to determine the interval between automatic weapon activations. | Read-Write
`shouldBurstStopOnRelease` | bool | If True, a burst sequence can be interrupted by the player by releasing the action button. If False, the burst continues firing automatically until it completes or the weapon runs out of ammo. | Read-Write
`isHitscan` | bool | If False, the weapon will produce simulated projectiles. If true, it will instead use instantaneous line traces to simulate shots. | Read-Write
`range` | Number | Max travel distance of the projectile (is_hitscan = False) or range of the line trace (is_hitscan = True). | Read-Write
`projectileTemplateId` | string | Asset reference for the visual body of the projectile, for non-hitscan weapons. | Read-Write
`muzzleFlashTemplateId` | string | Asset reference for a VFX to be attached to the muzzle point each time the weapon attacks. | Read-Write
`trailTemplateId` | string | Asset reference for a trail VFX to follow the trajectory of the shot. | Read-Write
`beamTemplateId` | string | Asset reference for a beam VFX to be placed along the trajectory of the shot. Useful for hitscan weapons or very fast projectiles. | Read-Write
`impactSurfaceTemplateId` | string | Asset reference of a VFX to be attached to the surface of any Core Objects hit by the attack. | Read-Write
`impactProjectileTemplateId` | string | Asset reference of a VFX to be spawned at the interaction point. It will be aligned with the trajectory. If the impacted object is a Core Object, then the VFX will attach to it as a child. | Read-Write
`impactPlayerTemplateId` | string | Asset reference of a VFX to be spawned at the interaction point, if the impacted object is a player. | Read-Write
`projectileSpeed` | Number | Travel speed (cm/s) of projectiles spawned by this weapon. | Read-Write
`projectileLifeSpan` | Number | Duration of projectiles. After which they are destroyed. | Read-Write
`projectileGravity` | Number | Gravity scale applied to spawned projectiles. | Read-Write
`projectileLength` | Number | Length of the projectile’s capsule collision. | Read-Write
`projectileRadius` | Number | Radius of the projectile’s capsule collision | Read-Write
`projectileBounceCount` | Number | Number of times the projectile will bounce before it’s destroyed. Each bounce generates an interaction event. | Read-Write
`projectilePierceCount` | Number | Number of objects that will be pierced by the projectile before it’s destroyed. Each pierce generates an interaction event. | Read-Write
`maxAmmo` | Number | How much ammo the Weapon starts with and its max capacity. If set to -1 then the Weapon has infinite capacity and doesn’t need to reload. | Read-Write
`currentAmmo` | Number | Current amount of ammo stored in this Weapon. | Read-Write
`ammoType` | string | A unique identifier for the ammunition type. | Read-Write
`isAmmoFinite` | bool | Determines where the ammo comes from. If True, then ammo will be drawn from the Player’s Resource inventory and reload will not be possible until the Player acquires more ammo somehow. If False, then the Weapon simply reloads to full and inventory Resources are ignored. | Read-Write
`outOfAmmoSoundId` | string | Asset reference for a sound effect to be played when the weapon tries to activate, but is out of ammo. | Read-Write
`reloadSoundId` | string | Asset reference for a sound effect to be played when the weapon reloads ammo. | Read-Write
`spreadMin` | Number | Smallest size in degrees for the Weapon’s cone of probability space to fire projectiles in. | Read-Write
`spreadMax` | Number | Largest size in degrees for the Weapon’s cone of probability space to fire projectiles in. | Read-Write
`spreadAperture` | Number | The surface size from which shots spawn. An aperture of zero means shots originate from a single point. | Read-Write
`spreadDecreaseSpeed` | Number | Speed at which the Spread contracts back from it’s current value to the minimum cone size. | Read-Write
`spreadIncreasePerShot` | Number | Amount the Spread increases each time the Weapon attacks. | Read-Write
`spreadPenaltyPerShot` | Number | Cumulative penalty to the Spread size for successive attacks. Penalty cools off based on spreadDecreaseSpeed. | Read-Write

Function | Return Value | Description | Tags
--- | --- | --- | ---
`HasAmmo()` | bool | Informs whether the Weapon is able to attack or not. | None
`Attack([target])` | None | Triggers the main ability of the weapon. Optional target parameter can be a Vector3 world position, a Player, or a CoreObject. | None

Event | Return Value | Description | Tags
--- | --- | --- | ---
`targetInteractionEvent` | Event<WeaponInteraction> | An event fired when a Weapon interacts with something. E.g. a shot hits a wall. The WeaponInteraction parameter contains information such as which object was hit, who owns the weapon, which ability was involved in the interaction, etc. | Read-Only
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

Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetHitResult()` | HitResult | Physics information about the impact between the weapon and the other object. | None
`GetHitResults()` | array<HitResult> | Table with multiple HitResults that hit the same object, in the case of Weapons with multi-shot (e.g. Shotguns). If a single attack hits multiple targets you receive a separate interaction event for each object hit. | None

## Core Lua Namespaces

Some sets of related functionality are grouped within namespaces, which are similar to the types above, but cannot be instantiated.  They are only ever accessed by calling functions within these namespaces.

### [CoreDebug](/core_api/classes/coredebug/coredebugOverview)

The CoreDebug API contains functions that may be useful for debugging.

Function | Return Value | Description | Tags
--- | --- | --- | ---
`CoreDebug.DrawLine (Vector3 start, Vector3 end, [table optionalParameters])` | Vector3 | draw debug line. optionalParameters is table containing one of the following keys: duration (number) - if <= 0, draw for single frame, thickness (number), color (Color) | None
`CoreDebug.DrawBox(Vector3 center, Vector3 dimensions, [table optionalParameters])` | Vector3 | draw debug box, with dimension specified as a vector. optionalParameters has same options as DrawLine, with addition of: rotation (Rotation) - rotation of the box | None
`CoreDebug.DrawSphere(Vector3 center, radius, [table optionalParameters])` | Vector3 | draw debug sphere | None
