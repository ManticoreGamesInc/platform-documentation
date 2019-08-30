# Lua Scripting API

## Overview

CORE has integrated version 5.3.4 of the Lua library.  For detailed technical information, see their [reference manual](https://www.lua.org/manual/5.3/). At a high level, CORE Lua types can be divided into two groups: data structures and [CoreObjects](/core_api/classes/coreobject).  Data structures are owned by Lua, while [CoreObjects](/core_api/classes/coreobject) are owned by the engine and could be destroyed while still referenced by Lua.  

Properties, functions, and events inherited by [CoreObject](/core_api/classes/coreobject) types are listed below.
Both properties and events are accessed with `.propertyName` and `.eventName`, while functions are accessed with `:functionName()`.


---

### [Audio](/core_api/classes/audio/AudioOverview)

Audio objects are [CoreObjects](/core_api/classes/coreobject) that wrap sound files. Most properties are exposed in the editor, but some functionality requires Lua scripting.

#### Properties

Property | Return Value | Description | Tags
--- | --- | --- | ---
`isPlaying` | bool | Returns if the sound is currently playing | Read-Only, Client Only
`length` | number | Returns the length (in seconds) of the sound | Read-Only
`currentPlaybackTime` | number | Returns the playback position (in seconds) of the sound. | Read-Only
`isSpatializationDisabled` | bool | Default false. Set true to play sound without 3D positioning. | Read/Write, Dynamic
`isAutoPlayEnabled` | bool | Default false. If set to true when placed in the editor (or included in a template), the sound will be automatically played when loaded. | Read-Only
`isTransient` | bool | Default false. If set to true, the sound will automatically destroy itself after it finishes playing. | Read/Write
`isAutoRepeatEnabled` | bool | Loops when playback has finished. Some sounds are designed to automatically loop, this flag will force others that don't (can be useful for looping music.) | Read/Write
`pitch` | number | Default 1. Multiplies the playback pitch of a sound. Note that some sounds have clamped pitch ranges (so 0.2-1 will work, above 1 might not.) | Read/Write
`volume` | number | Default 1. Multiplies the playback volume of a sound. Note that values above 1 can distort sound, so if you're trying to balance sounds, experiment to see if scaling down works better than scaling up. | Read/Write
`radius` | number | Default 0 (off.) If non-zero, will override default 3D spatial parameters of the sound. Radius is the distance away from the sound position that will be played at 100% volume. | Read/Write
`falloff` | number | Default 0 (off). If non-zero, will override default 3D spatial parameters of the sound. Falloff is the distance outside the radius over which the sound volume will gradually fall to zero. | Read/Write


#### Functions

Function | Return Value | Description | Tags
--- | --- | --- | ---
`Play()` | None | Returns if the sound is currently playing | Read-Only, Client Only
`Stop()` | None | Returns the length (in seconds) of the sound | None
`FadeIn(number)` | None | Returns the length (in seconds) of the sound | Dynamic
`FadeOut(number)` | None | Returns the length (in seconds) of the sound | None

??? example "Audio Example"
    ```lua
    -- audioExample.lua --
    -- drag the audio "Ambience Suburbs Night Crickets 01 SFX" into the hierarchy --

    local cricketsSFX = game:FindObjectByName("Ambience Suburbs Night Crickets 01 SFX")
    cricketsSFX:Play()
    print_to_screen("Are Crickets Playing?" .. tostring(cricketsSFX.isPlaying))
    print_to_screen("Crickets will play sound for " .. tostring(cricketsSFX.length) .. " seconds.")
    print_to_screen("Currently, the crickets have been playing for " .. tostring(currentPlaybackTime) .. " seconds.")
    Task.Wait(5)
    cricketsSFX:Stop()
    ```
    [CORE Audio Example](https://dev.manticoreplatform.com/games/AudioExampleHere)

---


### [Replicators](/core_api/classes/replicators/ReplicatorsOverview)

Replicators are [CoreObjects](/core_api/classes/coreobject) used to broadcast data from the server to clients. To use them, add custom parameters to a replicator and assign them default values. These parameters will be readable on all clients, and read/write on the server. In short, replicator values are accessible in any context but can only be written over on the server.

Replicators can be used directly to manage variables for a networked state machine, with a controller script on the server setting variable values - and a listener script on every client that responds and controls local client behavior. Also see [PerPlayerReplicator](/core_api/classes/PerPlayerReplicator) (accessed very differently).

#### Functions

Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetValue(string)` | Object, bool |  Returns the named custom property and whether or not the property was found. | Client Read-Only, Server Read/Write
`SetValue(string, Object)` | bool | Sets the named custom property and returns whether or not it was set successfully. | Client Read-Only, Server Read/Write

#### Events

Event | Return Value | Description | Tags
--- | --- | --- | ---
`valueChangedEvent` | Event (Replicator, string propertyName) | An event that is fired whenever any of the properties managed by the replicator receives an update. The event is fired on the server and the client. Event payload is the Replicator object and the name of the property that just changed. | Read-Only

??? example "Replicator Example"
    ```lua
    -- Example client usage:

    local function OnChanged(rep, key)
    	local value = rep:GetValue(key)
    	print_to_screen("K:" .. key .. " V:" .. tostring(value))
    end

    local replicator = script:GetCustomProperty(“MyReplicator”):WaitForObject()
    replicator.valueChangedEvent:Connect(OnChanged)


    -- Example server usage:

    local replicator = script:GetCustomProperty(“MyReplicator”):WaitForObject()
    replicator:SetValue("Key", value)

    Note: This example uses a custom property CoreObjectReference to point to the replicator. Another valid way of doing this is via the hierarchy (script.parent), or by using the Tick function.
    ```
    [CORE Replicator Example](https://dev.manticoreplatform.com/games/ReplicatorExampleHere)



### [ButtonUIControl](/core_api/classes/buttonUIControl/buttonUIControlOverview)

A [UIControl](/core_api/classes/PerPlayerReplicator) for a button, should be inside client context.

#### Properties

Property | Return Value | Description
--- | --- | ---
`text` | string | label text
`fontSize` | number | font size for label text
`isInteractable` | bool |  whether button can interact with cursor (click, hover, etc)

#### Events

Event | Return Value | Description | Tags
--- | --- | --- | ---
`clickedEvent` | Event<ButtonUIControl> | Called when button is released, triggered on mouse-button up but only if both button-down and button-up events happen inside the button widget. | Read-Only
`pressedEvent` | Event<ButtonUIControl> | Called when button is pressed | Read-Only
`releasedEvent` | Event<ButtonUIControl> | Called when button is released | Read-Only
`hoveredEvent` | Event<ButtonUIControl> | Called when button is hovered | Read-Only
`unhoveredEvent` | Event<ButtonUIControl> | Called when button is unhovered | Read-Only

#### Functions

Function | Return Value | Description | Tags
--- | --- | --- | ---
`GetButtonColor()` | Color | Get button default color | None
`SetButtonColor(Color)` | None | Get button default color | None
`GetHoveredColor ` | None | Get button color when hovered | None
`SetHoveredColor(Color)` | None | Set button color when hovered | None
`GetPressedColor()` | Color | Get button color when pressed | None
`SetPressedColor()` | None | Set button color when pressed | None
`GetDisabledColor()` | Color | Get button color when it’s not intereactable | None
`SetDisabledColor(Color)` | Color | Set button color when it’s not interactable | None
`GetFontColor()` | Color | Get font color | None
`SetFontColor(Color)` | Color | Set font color | None
`SetImage(String)` | None | Set image with the brush's MUID string. | None



### [CameraSettings](/core_api/classes/camerasettings/cameraSettingsOverview)

CameraSettings is a [CoreObject](/core_api/classes/coreobject) which can be used to configure camera settings for a Player.

#### Functions

Function | Return Value | Description | Tags
--- | --- | --- | ---
`ApplyToPlayer(Player)` | None | Apply settings from this settings object to player. | Server-Only


### Color

An RGBA representation of a color. Color components have an effective range of [0.0, 1.0], but values greater than 1 may be used.

#### Function

Function | Return Value | Description | Tags
--- | --- | --- | ---
`Color.New (Number r, Number g, Number b)` | RV | Construct with the given values. Alpha defaults to 1.0. | None
`Color.New (Number r, Number g, Number b, Number a)` | RV | Construct with the given values. | None
`Color.New (Vector3 v)` | RV | Construct using the vector’s XYZ components as the color’s RGB components. Alpha defaults to 1.0. | None
`Color.New (Vector4 v)` | RV | Construct using the vector’s XYZW components as the color’s RGBA components. | None
`Color.New (Color c)` | RV | Makes a copy of the given color. | None



## The following is in progress.

Class Function | Return Value | Description | Tags
--- | --- | --- | ---
`(Color) Lerp(Color from, Color to, Number progress)` | RV | Linearly interpolates between two colors in HSV space by the specified progress amount and returns the resultant Color. | None
`(Color) Random()` | RV | Returns a color with a random hue (H) of HSV form (H, 0, 1). | None

Constructor | Return Value | Description | Tags
--- | --- | --- | ---
`Color.New (Number r, Number g, Number b)` | RV | Construct with the given values. Alpha defaults to 1.0. | None
`Color.New (Number r, Number g, Number b, Number a)` | RV | Construct with the given values. | None
`Color.New (Vector3 v)` | RV | Construct using the vector’s XYZ components as the color’s RGB components. Alpha defaults to 1.0. | None
`Color.New (Vector4 v)` | RV | Construct using the vector’s XYZW components as the color’s RGBA components. | None
`Color.New (Color c)` | RV | Makes a copy of the given color. | None

Member Function | Return Value | Description | Tags
--- | --- | --- | ---
`(Color) GetDesaturated(Number desaturation)` | RV | Returns the desaturated version of the color. 0 represents no desaturation and 1 represents full desaturation. | None

Operator | Return Value | Description | Tags
--- | --- | --- | ---
`Color + Color` | RV | Component-wise addition. | None
`Color = Color` | RV | Component-wise subtraction | None
`Color * Color` | RV | Component-wise multiplication. | None
`Color * Number` | RV | Multiplies each component of the color by the right-side Number. | None
`Color / Color` | RV | Component-wise division. | None
`Color / Number` | RV | Divides each component of the color by the right-side Number. | None

Property | Return Value | Description | Tags
--- | --- | --- | ---
`r (Number, read-write)` | RV | The R component of the color. | None
`g (Number, read-write)` | RV | The G component of the color. | None
`b (Number, read-write)` | RV | The B component of the color. | None
`a (Number, read-write)` | RV | The A component of the color. | None

Function | Return Value | Description | Tags
--- | --- | --- | ---
`CoreDebug.DrawLine (Vector3 start, Vector3 end, [table optionalParameters])` | RV | draw debug line | None
`optionalParameters is table containing one of the following keys: duration (number)` | RV | if <= 0, draw for single frame, thickness (number), color (Color) | None
`CoreDebug.DrawBox(Vector3 center, Vector3 dimensions, [table optionalParameters])` | RV | draw debug box, with dimension specified as a vector. optionalParameters has same options as DrawLine, with addition of: rotation (Rotation) - rotation of the box | None
`CoreDebug.DrawSphere(Vector3 center, radius, [table optionalParameters])` | RV | draw debug sphere | None

Function | Return Value | Description | Tags
--- | --- | --- | ---
`Tick(Number deltaTime)-Tick event, used for things you need to check continuously (e.g. main game loop), but be careful of putting too much logic here or you will cause performance issues. DeltaTime is the time difference (in ms) between this and the last tick.` | RV |  | None
`(Number) time()` | RV | Returns the time in seconds (floating point) since the game started on the server. | None
`print (string)` | RV | Print a message to the event log. Press ` to view messages. | None
`warn (string)` | RV | Similar to print(), but includes the script name and line number. | None

Function | Return Value | Description | Tags
--- | --- | --- | ---
`(Number) CoreMath.Clamp (Number value, Number lower, Number upper)` | RV | Clamps value between lower and upper, inclusive. If lower and upper are not specified, defaults to 0 and 1. | None
`(Number) CoreMath.Lerp (Number from, Number to, Number t)` | RV | Linear interpolation between from and to.  t should be a floating point number from 0 to 1, with 0 returning from and 1 returning to. | None
`(Number) CoreMath.Round (Number value, Number decimals)` | RV | Rounds value to an integer, or to an optional number of decimal places, and returns the rounded value. | None

Function | Return Value | Description | Tags
--- | --- | --- | ---
`(CoreObject) GetObject()` | RV | Returns the CoreObject with a matching ID, if it exists.  Will otherwise return nil. | None
`(CoreObject) WaitForObject([float])` | RV | Returns the CoreObject with a matching ID, if it exists.  If it does not, yields the current task until the object is spawned.  Optional timeout parameter will cause the task to resume with a return value of false and an error message if the object has not been spawned within that many seconds. | None

Property | Return Value | Description | Tags
--- | --- | --- | ---
`id (String, read-only)` | RV | The MUID of the referred object. | Read-Only

Function | Return Value | Description | Tags
--- | --- | --- | ---
`(Transform) GetTransform()` | RV | The transform relative to this object’s parent. | None
`SetTransform (Transform)(dynamic)` | RV | The transform relative to this object’s parent. | Dynamic
`(Vector3) GetPosition()` | RV | The position of this object relative to its parent. | None
`SetPosition (Vector3)(dynamic)` | RV | The position of this object relative to its parent. | Dynamic
`(Rotation) GetRotation()` | RV | The rotation relative to its parent. | None
`SetRotation (Rotation)(dynamic)` | RV | The rotation relative to its parent. | Dynamic
` (Vector3) GetScale()` | RV | The scale relative to its parent. | None
`SetScale (Vector3)(dynamic)` | RV | The scale relative to its parent. | Dynamic
`(Transform) GetWorldTransform()` | RV | The absolute transform of this object. | None
`SetWorldTransform (Transform)(dynamic)` | RV | The absolute transform of this object. | Dynamic
`(Vector3) GetWorldPosition()` | RV | The absolute position. | None
`SetWorldPosition (Vector3)(dynamic)` | RV | The absolute position. | Dynamic
`(Rotation) GetWorldRotation()` | RV | The absolute rotation. | None
`SetWorldRotation (Rotation)(dynamic)` | RV | The absolute rotation. | Dynamic
`(Vector3) GetWorldScale()` | RV | The absolute scale. | None
`SetWorldScale (Vector3)(dynamic)` | RV | The absolute scale. | Dynamic
`(Vector3) GetVelocity()` | RV | The object’s velocity in world space. | None
`SetVelocity (Vector3)(dynamic)` | RV | The object’s velocity in world space. | Dynamic
`(Vector3) GetAngularVelocity()` | RV | The object’s angular velocity in degrees per second. | None
`SetAngularVelocity (Vector3)(dynamic)` | RV | The object’s angular velocity in degrees per second. | Dynamic
`(CoreObjectReference) GetReference()` | RV | Returns a CoreObjectReference pointing at this object. | None
`(array<CoreObject>) GetChildren()` | RV | Returns a table containing the object’s children, may be empty (1 indexed). | None
`(CoreObject) FindAncestorByName(string name)` | RV | Returns the first parent or ancestor whose name matches the provided name.  If none match, returns nil. | None
`(CoreObject) FindChildByName(string name)` | RV | Returns the first immediate child whose name matches the provided name.  If none match, returns nil. | None
`(CoreObject) FindDescendantByName(string name)` | RV | Returns the first child or descendant whose name matches the provided name.  If none match, returns nil. | None
`(array<CoreObject>) FindDescendantsByName(string name)` | RV | Returns the descendants whose name matches the provided name.  If none match, returns an empty table. | None
`(CoreObject) FindAncestorByType(string type_name)` | RV | Returns the first parent or ancestor whose type is or extends the specified type.  For example, calling FindAncestorByType(‘CoreObject’) will return the first ancestor that is any type of CoreObject, while FindAncestorByType(‘StaticMesh’) will only return the first static mesh. If no ancestors match, returns nil. | None
`(CoreObject) FindChildByType(string type_name)` | RV | Returns the first immediate child whose type is or extends the specified type.  If none match, returns nil. | None
`(CoreObject) FindDescendantByType(string type_name)` | RV | Returns the first child or descendant whose type is or extends the specified type.  If none match, returns nil. | None
`(array<CoreObject>) FindDescendantsByType(string type_name)` | RV | Returns the descendants whose type is or extends the specified type.  If none match, returns an empty table. | None
`CoreObject) FindTemplateRoot()` | RV | If the object is part of a template, returns the root object of the template (which may be itself). If not part of a template, returns nil. | None
`(bool) IsAncestorOf(CoreObject)` | RV | Returns true if this core object is a parent somewhere in the hierarchy above the given parameter object. False otherwise. | None
`(value, bool) GetCustomProperty(string property_name)` | RV | Gets data which has been added to an object using the custom property system.  Returns the value, which can be an Integer, Number, bool, string, Vector3, Rotator, Color, a MUID string, or nil if not found.  Second return value is a bool, true if found and false if not. | None
`AttachToPlayerCamera(Player) (dynamic, client only)` | RV | Attaches a CoreObject to given player’s camera. This should be called inside a Client Context. Reminder to turn off the object’s collision otherwise it will cause camera to jitter. | Dynamic
`Detach()(dynamic)` | RV | Detaches a CoreObject from any player it has been attached to, or from its parent object. | Dynamic
`GetAttachedToSocketName()` | RV | return name of the socket this object is attached to. | None
`MoveTo(Vector3, Number, bool)(dynamic)` | RV | Smoothly moves the object to the target location over a given amount of time. Third parameter specifies if this should be done in local space (true) or world space (false). | Dynamic
`RotateTo(Rotation/Quaternion, Number, bool)(dynamic)` | RV | Smoothly rotates the object to the target orientation over a given amount of time. Third parameter specifies if this should be done in local space (true) or world space (false). | Dynamic
`ScaleTo(Vector3, Number, bool)(dynamic)` | RV | Smoothly scales the object to the target scale over a given amount of time. Third parameter specifies if this should be done in local space (true) or world space (false). | Dynamic
`MoveContinuous(Vector3, bool)(dynamic)` | RV | Smoothly moves the object over time by the given velocity vector. Second parameter specifies if this should be done in local space (true) or world space (false). | Dynamic
`RotateContinuous(Rotation/Quaternion, Number, bool)(dynamic)` | RV | Smoothly rotates the object over time by the given angular velocity. Because the limit is 179°, the second param is an optional multiplier, for very fast rotations. Third parameter specifies if this should be done in local space (true) or world space (false (default)). | Dynamic
`ScaleContinuous(Vector3, bool)(dynamic)` | RV | Smoothly scales the object over time by the given scale vector per second. Second parameter specifies if this should be done in local space (true) or world space (false). | Dynamic
`StopMove()(dynamic)` | RV | Interrupts further movement from MoveTo(), MoveContinuous(), or Follow(). | Dynamic
`StopRotate()(dynamic)` | RV | Interrupts further rotation from RotateTo() or RotateContinuous() and LookAt() or LookAtContinuous(). | Dynamic
`StopScale()(dynamic)` | RV | Interrupts further movement from ScaleTo() or ScaleContinuous(). | Dynamic
`Follow(CoreObject, Number, Number)(dynamic)` | RV | Follows a dynamic object at a certain speed. If the speed is not supplied it will follow as fast as possible. The third parameter specifies a distance to keep away from the target. | Dynamic
`LookAt(Vector3 position)(dynamic)` | RV | Instantly rotates the object to look at the given position. | Dynamic
`LookAtContinuous(CoreObject, bool, Number)(dynamic)` | RV | Smoothly rotates a CoreObject to look at another given CoreObject. Second parameter is optional and locks the pitch.  (Default is unlocked.)  Third parameter is how fast it tracks the target. If speed is not supplied it tracks as fast as possible. | Dynamic
`LookAtCamera(bool)(dynamic)` | RV | Continuously looks at the local camera. The bool parameter is optional and locks the pitch. | Dynamic
`Destroy()(dynamic)` | RV | Destroys the object.  You can check whether an object has been destroyed by calling is_valid(object), which will return true if object is still a valid object, or false if it has been destroyed. | Dynamic

Property | Return Value | Description | Tags
--- | --- | --- | ---
`name (string, read/write, dynamic)` | RV | Hello, my name is… | Dynamic
`id (string, read-only)` | RV | The object’s MUID. | Read-Only
`parent (CoreObject, read/write, dynamic)` | RV | The object’s parent object, may be nil. | Dynamic
`isVisible (bool, read/write, dynamic)` | RV | Turn on/off the rendering of an object and its children | Dynamic
`isCollidable (bool, read/write, dynamic)` | RV | Turn on/off the collision of an object and its children | Dynamic
`isEnabled (bool, read/write, dynamic)` | RV | Turn on/off an object and its children completely | Dynamic
`isStatic (bool, read-only)` | RV | If true, dynamic properties may not be written to, and dynamic functions may not be called. | Read-Only
`isClientOnly (bool, read-only)` | RV | If true, this object was spawned on the client and is not replicated from the server. | Read-Only
`isServerOnly (bool, read-only)` | RV | If true, this object was spawned on the server and is not replicated to clients. | Read-Only
`isNetworked (bool, read-only)` | RV | If true, this object replicates from the server to clients. | Read-Only
`lifeSpan (Number, read/write, dynamic)` | RV | Duration after which the object is destroyed. | Dynamic
`sourceTemplateId (string, read-only)` | RV | The ID of the Template from which this Core Object was instantiated. NIL if the object did not come from a Template. | Read-Only
`childAddedEvent (Event<CoreObject parent, CoreObject new_child>, read-only)` | RV | An event fired when a child is added to this object. | Read-Only
`childRemovedEvent (Event<CoreObject parent, CoreObject removed_child>, read-only)` | RV | An event fired when a child is removed from this object. | Read-Only
`descendantAddedEvent (Event<CoreObject ancestor, CoreObject new_child>, read-only)` | RV | An event fired when a child is added to this object or any of its descendants. | Read-Only
`descendantRemovedEvent (Event<CoreObject ancestor, CoreObject removed_child>, read-only)` | RV | An event fired when a child is removed from this object or any of its descendants. | Read-Only
`destroyEvent (Event<CoreObject>, read-only)` | RV | An event fired when this object is about to be destroyed. | Read-Only

Function | Return Value | Description | Tags
--- | --- | --- | ---
`(HitResult) GetHitResult()` | RV | Get the HitResult information if this damage was caused by a Projectile impact. | None
`SetHitResult (HitResult)` | RV | Forward the HitResult information if this damage was caused by a Projectile impact. | None

Property | Return Value | Description | Tags
--- | --- | --- | ---
`amount (Number, read/write)` | RV | The numeric amount of damage to inflict. | None
`reason (DamageReason, read/write)` | RV | What is the context for this Damage? | None
`sourceAbility (Ability, read/write)` | RV | Reference to the Ability which caused the Damage. Setting this automatically sets sourceAbilityName. | None
`sourceAbilityName (String, read/write)` | RV | Name of the ability which caused the Damage. | None
`sourcePlayer (Player, read/write)` | RV | Reference to the Player who caused the Damage. Setting this automatically sets sourcePlayerName. | None
`sourcePlayerName (String, read/write)` | RV | Name of the player who caused the Damage. | None

Function | Return Value | Description | Tags
--- | --- | --- | ---
`Equip(Player)` | RV | Attaches the Equipment to a Player. They gain any abilities assigned to the Equipment. If the Equipment is already attached to another Player it will first unequip from that other Player before equipping unto the new one. | None
`Unequip()` | RV | Detaches the Equipment from any Player it may currently be attached to. The player loses any abilities granted by the Equipment. | None
`AddAbility(Ability)` | RV | Adds an Ability to the list of abilities on this Equipment. | None
`(array<Ability>) GetAbilities()` | RV | A table of Abilities that are assigned to this Equipment. Players who equip it will get these Abilities. | None

Property | Return Value | Description | Tags
--- | --- | --- | ---
`socket (string, read/write)(dynamic)` | RV | Determines which point on the avatar’s body this equipment will be attached. | Dynamic
`owner (Player, read-only)(dynamic)` | RV | Which Player the Equipment is attached to. | Read-Only
`equippedEvent (Event<Equipment, Player>, read-only)` | RV | An event fired when this equipment is equipped onto a player. | Read-Only
`unequippedEvent (Event<Equipment, Player>, read-only)` | RV | An event fired when this object is unequipped from a player. | Read-Only

Function | Return Value | Description | Tags
--- | --- | --- | ---
`(EventListener) Connect(function eventListener)` | RV | Registers the given function which will be called every time the event is fired.  Returns an EventListener which can be used to disconnect from the event or check if the event is still connected. | None

Property | Return Value | Description | Tags
--- | --- | --- | ---
`isConnected (bool, read-only)` | RV | true if this listener is still connected to its event. false if the event owner was destroyed or if Disconnect was called. | Read-Only

#### Static Functions

Static Functions | Return Value | Description | Tags
--- | --- | --- | ---
`(EventListener) Connect(string eventName, function eventListener)` | RV | Registers the given function to the event name which will be called every time the event is fired using Broadcast.  Returns an EventListener which can be used to disconnect from the event or check if the event is still connected. The events are not replicated and can only be fired within the given context. | None
`Broadcast(string eventName, parameters)` | RV | Broadcasts the given event and fires all listeners attached to the given event name if any exists. Parameters specify the arguments passed to the listener. Any number of arguments can be passed to the listener function. The events are not replicated and can fire events defined in the same context. | None

Function | Return Value | Description | Tags
--- | --- | --- | ---
`(array<CoreObject>) FindObjectsByName(string name)` | RV | Returns a table containing all the objects in the hierarchy with a matching name.  If none match, an empty table is returned. | None
`(array<CoreObject>) FindObjectsByType(string type_name)` | RV | Returns a table containing all the objects in the hierarchy whose type is or extends the specified type.  If none match, an empty table is returned.  See below for valid type names. | None
`(CoreObject) FindObjectByName(string type_name)` | RV | Returns the first object found with a matching name. In none match, nil is returned. | None
`(CoreObject) FindObjectById(string muid_string)` | RV | Returns the object with a given MUID.  Returns nil if no object has this ID. | None
`(array<Player>) GetPlayers()` | RV | Returns a table containing the players currently in the game. The last player that joined is the last player in the table, and the first player is the first element in the table (assuming they haven’t left). | None
`(array<Player>) GetAlivePlayers()` | RV | Returns a table containing the players currently in the game who are not dead. | None
`(Player) GetLocalPlayer()` | RV | Returns the local player (or nil on the server). | None
`(Player) FindNearestPlayer(Vector3 position)` | RV | Returns the Player that is nearest to the given position. | None
`(Player) FindNearestAlly(Vector3 position, Integer team, Player ignore)` | RV | Returns the Player that is nearest to the given position but is on the given team. The last parameter is optional, allowing one Player to be ignored from the search. | None
`(Player) FindNearestEnemy(Vector3 position, Integer team)` | RV | Returns the Player that is nearest to the given position but is not on the given team. | None
`(array<Player>) FindPlayersInCylinder(Vector3 position, Number radius)` | RV | Returns a table with all Players that are in the given area. Position’s Z is ignored with the cylindrical area always upright. | None
`(array<Player>) FindAlliesInCylinder(Vector3 position, Number radius, Integer team)` | RV | Returns a table with all Players that are in the given cylindrical area and who belong to the given team. | None
`(array<Player>) FindEnemiesInCylinder(Vector3 position, Number radius, Integer team)` | RV | Returns a table with all Players that are in the given cylindrical area and who do not belong to the given team. | None
`(array<Player>) FindPlayersInSphere(Vector3 position, Number radius)` | RV | Returns a table with all Players that are in the given spherical area. | None
`(array<Player>) FindAlliesInSphere(Vector3 position, Number radius, Integer team)` | RV | Returns a table with all Players that are in the given spherical area and who belong to the given team. | None
`(array<Player>) FindEnemiesInSphere(Vector3 position, Number radius, Integer team)` | RV | Returns a table with all Players that are in the given spherical area and who do not belong to the given team. | None
`(CoreObject) SpawnTemplate(string template_id, [Location])` | RV | Spawns an instance of a template.  Location can be a Vector3 or a full Transform and is in world space. | None
`(CoreObject) SpawnTemplate(string template_id, Transform transform, CoreObject parent)` | RV | Spawns an instance of a template as a child of a given parent.  Location can be a Vector3 or a full Transform and is in the parent’s local space. More on Templates. | None
`(Projectile) SpawnProjectile(string child_template_id, Vector3 start_position, Vector3 direction)` | RV | Spawns a Projectile with a child that is an instance of a template. More on Projectiles. | None
`(Ability) SpawnAbility()` | RV | Spawns an ability object. | None
`(CoreObject) SpawnAsset(string asset_id, Vector3/Transform location, [CoreObject parent])` | RV | Spawns an instance of the specified asset.  The asset_id needs to be referenced through Asset Reference custom property to work. Interface is same as SpawnTemplate() | None
`(HitResult) Raycast(Vector3 rayStart, Vector3 rayEnd, Player playerToIgnore(optional), String teamToIgnore (optional))` | RV | Traces a ray from rayStart to rayEnd, returning a HitResult with data about the impact point and object. Can be set to ignore a specific player or an entire team. | None
`(HitResult) RaycastIgnoreAllPlayers(Vector3 rayStart, Vector3 rayEnd)` | RV | similar to raycast(), but ignores all players. | None
`(HitResult) GetCursorHit()` | RV | return hit result from local client’s view in direction of the projected cursor position. Meant for client-side use only, for ability cast, please use ability:GetTargetData():GetHitPosition(), which would contain cursor hit position at time of cast, when in topdown camera mode | None
`(Vector, bool) GetCursorPlaneIntersection(Vector3 pointOnPlane, Vector3 planeNormal[optional default to up vector])` | RV | return intersection from local client’s camera direction to given plane, specified by point on plane and optionally its normal. Meant for client-side use only. | None
`(bool) AreTeamsEnemies(Integer team1, Integer team2)` | RV | Returns true if teams are considered enemies under the current TeamMode. If either team is TEAM_NEUTRAL=0, returns false. | None
`(bool) AreTeamsFriendly(Integer team1, Integer team2)` | RV | Returns true if teams are considered friendly under the current TeamMode. If either team is TEAM_NEUTRAL=0, returns false. | None
`StartRound() server-only` | RV | Fire all events attached to roundStartEvent | Server-Only
`EndRound() server-only` | RV | Fire all events attached to roundEndEvent | Server-Only

Property | Return Value | Description | Tags
--- | --- | --- | ---
`root (CoreObject, read-only)` | RV | The root of the scene object hierarchy. | Read-Only
`playerJoinedEvent (Event<Player>, read-only)` | RV | Event fired when a player has joined the game and their character is ready. | Read-Only
`playerLeftEvent (Event<Player>, read-only)` | RV | Event fired when a player has disconnected from the game or their character has been destroyed. | Read-Only
`abilitySpawnedEvent (Event<Ability>, read-only)` | RV | Event fired when an ability is spawned. Useful for client contexts to hook up to ability events. | Read-Only
`roundStartEvent (read-only)` | RV | Event fired when StartRound is called on game. | Read-Only
`roundEndEvent (read-only)` | RV | Event fired when EndRound is called on game. | Read-Only

Function | Return Value | Description | Tags
--- | --- | --- | ---
`(Vector3) GetImpactPosition()` | RV | The world position where the impact occurred. | None
`(Vector3) GetImpactNormal()` | RV | Normal direction of the surface which was impacted. | None
`(Transform) GetTransform()` | RV | Returns a Transform composed of the position of the impact in world space, the rotation of the normal, and a uniform scale of 1. | None

Property | Return Value | Description | Tags
--- | --- | --- | ---
`other (CoreObject or Player)` | RV | Reference to a CoreObject or Player impacted. | None
`isHeadshot (Bool, read-only)` | RV | True if the weapon hit another player in the head. | Read-Only
`boneName (String, read-only)` | RV | If the hit was on a player boneName tells you which spot on the body was hit. | Read-Only

Function | Return Value | Description | Tags
--- | --- | --- | ---
`(Color) GetColor()` | RV | The tint to apply to the image | None
`SetColor(Color)` | RV | The tint to apply to the image | None
`SetImage(brushMuidString)` | RV | set image | None

Property | Return Value | Description | Tags
--- | --- | --- | ---
`isTeamColorUsed (bool)` | RV | If true, the image will be tinted blue if its team matches the player, or red if not | None
`team (Integer)` | RV | the team of the image, used for isTeamColorUsed | None

Property | Return Value | Description | Tags
--- | --- | --- | ---
`userData (table, read/only)` | RV | Table in which users can store any data they want. | None

#### Static Functions

Static Functions | Return Value | Description | Tags
--- | --- | --- | ---
`(bool) IsValid (Object object)` | RV | Returns true if object is still a valid Object, or false if it has been destroyed.  Also returns false if passed a nil value or something that’s not an Object, such as a Vector3 or a string. | None

Function | Return Value | Description | Tags
--- | --- | --- | ---
`(Replicator) GetPlayerReplicator(Player)` | RV | Returns the replicator for the specified player. Can be nil if the replicator hasn’t spawned on the client yet. | None

Property | Return Value | Description | Tags
--- | --- | --- | ---
`team (string, read-write)(dynamic)` | RV | A tag controlling which players can spawn at this start point. | Dynamic

Function | Return Value | Description | Tags
--- | --- | --- | ---
`(Transform) GetTransform()` | RV | The transform relative to this object’s parent. | None
`SetTransform (Transform)` | RV | The transform relative to this object’s parent. | None
`(Vector3) GetPosition()` | RV | The position of this object relative to its parent. | None
`SetPosition (Vector3)` | RV | The position of this object relative to its parent. | None
`(Rotation) GetRotation()` | RV | The rotation relative to its parent. | None
`SetRotation (Rotation)` | RV | The rotation relative to its parent. | None
`(Vector3) GetScale()` | RV | The scale relative to its parent. | None
`SetScale (Vector3)` | RV | The scale relative to its parent. | None
`(Transform) GetWorldTransform()` | RV | The absolute transform of this object. | None
`SetWorldTransform (Transform)` | RV | The absolute transform of this object. | None
`(Vector3) GetWorldPosition()` | RV | The absolute position. | None
`SetWorldPosition (Vector3)` | RV | The absolute position. | None
`(Rotation) GetWorldRotation()` | RV | The absolute rotation. | None
`SetWorldRotation (Rotation)` | RV | The absolute rotation | None
`(Vector3) GetWorldScale()` | RV | The absolute scale. | None
`SetWorldScale (Vector3)` | RV | The absolute scale. | None
`AddImpulse (Vector3)` | RV | Adds an impulse force to the player. | None
`(Vector3) GetVelocity()` | RV | Gets current velocity of player | None
`ResetVelocity()` | RV | Resets the player’s velocity to zero. | None
`(Rotation) GetRotationRate()` | RV | ? | None
`SetRotationRate (Rotation)` | RV | no ? | None
`(array<Ability>) GetAbilities()` | RV | Array of all Abilities assigned to this Player. | None
`(array<Equipment>) GetEquipment()` | RV | Array of all Equipment assigned to this Player. | None
`ApplyDamage(Damage)` | RV | Damages a Player. If their hitpoints go below 0 they die. | None
`Die([Damage])` | RV | Kills the Player. They will ragdoll and ignore further Damage. The optional Damage parameter is a way to communicate cause of death. | None
`DisableRagdoll()` | RV | Disables all ragdolls that have been set on the player. | None
`SetVisibility(bool, bool)` | RV | Shows or hides the player. The second parameter is optional, defaults to true, and determines if attachments to the player are hidden as well as the player. | None
`SetReticleVisible(bool Show)` | RV | Shows or hides the reticle for the player. | None
`SetNameVisible(bool)` | RV | Set player name visibility | None
`EnableRagdoll(string SocketName, Number Weight, bool CameraFollows)` | RV | Enables ragdoll for the player, starting on “SocketName” weighted by “Weight” (between 0.0 and 1.0). This can cause the player capsule to detach from the mesh. Setting CameraFollows to true will force the player capsule to stay with the mesh. All parameters are optional; SocketName defaults to the root, Weight defaults to 1.0, CameraFollows defaults to true. Multiple bones can have ragdoll enabled simultaneously. | None
`ForceHideModelOnOwnerClient(bool)` | RV | Set whether to hide player model on player’s own client, for sniper scope, etc. Client-only. | Client-Only
`SetClientIgnoreMoveInput(bool)` | RV | Set whether to ignore move input on client. Client-only | Client-Only
`GetClientIgnoreMoveInput()` | RV | whether player ignores move input, Client-only | Client-Only
`LockCamera(bool Enable)` | RV | If Enable is true (or no parameters are given), locks the camera at the current rotation. If Enable is false, the camera is unlocked if it was previously locked. | None
`LockCamera(Vector3 Direction)` | RV | Locks the camera looking at the player in the Direction supplied. Roll is never applied to the camera. If Direction is directly up, down, or otherwise unable to be normalized, the function does nothing. | None
`LockCamera(Rotation NewRotation)` | RV | Locks the camera to the rotation supplied. | None
`AttachCameraTo(coreObject, optionalBlendTime)` | RV | have camera follow position and orientation of the given object. If blend time is <= 0, transition is instant. Default blend time is 2 seconds | None
`ResetCameraAttachment(optionalBlendTime)` | RV | set camera to attach back to its owner | None
`Respawn([Vector, Rotation])` | RV | Resurrects a dead Player at one of the Start Points. Optional position and rotation parameters can be used to specify a location. | None
`SetCameraDistance(Number Distance, bool Transition)` | RV | Sets the Distance the camera floats from the player. Using a negative Distance will reset it to default. | None
`SetCameraOffset(Vector3 Offset, bool Transition)` | RV | Adjusts the focus point for the camera (what the camera looks at and rotates around). Defaults to just off the shoulder. The Offset is calculated from the middle of the player. | None
`SetCameraLerpSpeed(float)` | RV | set camera distance and offset lerp speed, default is 10 | None
`ResetCamera(bool Transition)` | RV | Sets the camera back to default, 3rd person behind character. If Transition is set to True (default behavior) the change will be smooth. | None
`SetCameraOverTheShoulder(bool Transition)` | RV | Sets the camera to 3rd person over the shoulder. Ideal for firing weapons. If Transition is set to True (default behavior) the change will be smooth. | None
`SetupCameraTopdownFollow(Number PitchAngle, Number YawAngle, Number InitialDist, [Number MinDist, Number MaxDist])` | RV | set camera in topdown mode, with given rotation and distance. Always follow player with player in center of view by default | None
`SetupCameraFps(optionalCameraOffset)` | RV | set camera in first person mode (experimental) | None
`SetupCameraWithSettings(CameraSettings Settings)` | RV | setup camera with given camera settings object (obsolete, please use CameraSettings:apply(player) instead) | None
`SetCameraFov(Number FoV)` | RV | Sets the camera’s field of view for the player. | None
`(Vector3) GetCameraPosition()` | RV | Get position of player’s camera view. Only works for local player. | None
`(Vector3) GetCameraForward()` | RV | Get forward vector of player’s camera view. Only works for local player. | None
`ShowHitFeedback([Color])` | RV | Shows diagonal crosshair feedback. Useful, e.g. when a shot connects with a target. Optional Color defaults to red. | None
`PlayAnimation(String animationName, bool isLooping, Number duration)` | RV | Plays a specific animation.  See below for valid strings. | None
`ClearResources()` | RV | Removes all resources from a player. | None
`GetResource(String name)` | RV | Returns the amount of a resource owned by a player. | None
`SetResource(String name, Integer amount)` | RV | Sets a specific amount of a resource on a player. | None
`AddResource(String name, Integer amount)` | RV | Adds an amount of a resource to a player. | None
`RemoveResource(String name, Integer amount)` | RV | Subtracts an amount of a resource from a player. Does not go below 0. | None
`(array<String>) GetResourceNames()` | RV | return array containing resource names | None
`(array<String>) GetResourceNamesStartingWith(String prefix)` | RV | return array containing resource names starting with given prefix | None
`TransferToGame(String)` | RV |  Only works in play off web portal. Transfers player to the game specified by the passed-in game ID (the string from the web portal link). | None
`GetAttachedObjects()` | RV | return table containing core objects attached to this player. | None
`SendKeyValuePairToServer(String key, value)` | RV | send a key-value pair to server, value restricted to string, number, and vector at the moment. See also keyValuePairReceivedEvent. | None

Property | Return Value | Description | Tags
--- | --- | --- | ---
`name (String, read-only)` | RV | The player’s name. | Read-Only
`id (String, read-only)` | RV | The unique id of the player. Consistent across sessions. | Read-Only
`team (Number, read/write)` | RV | The number of the team to which the player is assigned. By default, this value is 255 in FFA mode. | None
`animationSet (String, read/write)` | RV | Which set of animations to use for this player. Values can be “unarmed”, “1hand_melee”, “1hand_pistol”, “2hand_sword” or “2hand_rifle”. (Deprecated values were “one_handed”, “pistol”, and “crossbow”) | None
`activePose (String, read/write)` | RV | Determines an animation pose to hold during idle. Default value is “none”. Other values can be "2hand_rifle_aim_shoulder", "2hand_rifle_aim_hip", "1hand_pistol_aim", "2hand_pistol_aim", "unarmed_carry_object_high", "unarmed_carry_object_low", "unarmed_carry_object_heavy", "unarmed_carry_score_card", "unarmed_sit_car_low".  See Active Pose Information | None
`facingMode (String, read/write)` | RV | Which controls mode to use for this player. Values can be “strafe” or “loose”. | None
`hitPoints (Number, read/write)` | RV | Current amount of hitpoints. | None
`maxHitPoints (Number, read/write)` | RV | Maximum amount of hitpoints. | None
`stepHeight (Number, read/write)` | RV | Maximum height in centimeters the player can step up. Range is 0-100, default is 45. | None
`walkSpeed (Number, read/write)` | RV | Walk speed as a fraction of default.  Range is 0-10, default is 1. | None
`swimSpeed (Number, read/write)` | RV | Swim speed as a fraction of default.  Range is 0-10, default is 1. | None
`maxAcceleration (Number, read/write)` | RV | Max Acceleration (rate of change of velocity). Default = 1200 | None
`brakingDecelerationFalling (Number, read/write)` | RV | deceleration when falling and not applying acceleration. Default = 0 | None
`brakingDecelerationWalking (Number, read/write)` | RV | deceleration when walking and movement input has stopped. Default = 512.0 | None
`groundFriction (Number, read/write)` | RV | friction when walking on ground. Default = 8.0 | None
`brakingFrictionFactor (Number, read/write)` | RV | multiplier for friction when braking. Default = 0.6 | None
`walkableFloorAngle (Number, read/write)` | RV | max walkable floor angle, in degrees. Default = 44.765. There seem to be hard coded limit in unreal, so there is some upper limit it can go around 55 degrees (needs to verify) | None
`maxJumpCount (Integer, read/write)` | RV | max number of jumps, to enable multiple jumps. Set to 0 to disable jump | None
`jumpVelocity (Number, read/write)` | RV | vertical speed applied to Player when they jump. | None
`gravityScale (Number, read/write)` | RV | multiplier on gravity applied. Default = 1.9 | None
`maxSwimSpeed (Number, read/write)` | RV | base swim speed (recommend use swimSpeed multiplier instead of this one). Default = 400 | None
`touchForceFactor (Number, read/write)` | RV | force applied to physics objects when contacted with player. Default = 1 | None
`isCrouchEnabled (Bool, read/write)` | RV | Turns crouching on/off for a player. | None
`mass (Number, read-only)` | RV | Gets the mass of the player. | Read-Only
`isAccelerating (Bool, read-only)` | RV | True if the player is accelerating, such as from input to move. | Read-Only
`isClimbing (Bool, read-only)` | RV | True if the player is climbing. | Read-Only
`isCrouching (Bool, read-only)` | RV | True if the player is crouching. | Read-Only
`isFlying (Bool, read-only)` | RV | True if the player is flying. | Read-Only
`isGrounded (Bool, read-only)` | RV | True if the player is on the ground with no upward velocity, otherwise false | Read-Only
`isJumping (Bool, read-only)` | RV | True if the player is jumping. | Read-Only
`isMounted (Bool, read-only)` | RV | True if the player is mounted on another object. | Read-Only
`isSwimming (Bool, read-only)` | RV | True if the player is swimming in water. | Read-Only
`isWalking (Bool, read-only)` | RV | True if the player is in walking mode. | Read-Only
`isDead (Bool, read/write)` | RV | True if the player is dead, otherwise false. Can be set as well. | None
`cameraSensitivity (Number, read/write)` | RV | multiplier on camera rotation speed relative to cursor movement. Default is 1.0. This is independent from player preference, both will be applied as multipliers together. | None
`cursorMoveInputMode (CursorMoveInput enum, read/write)` | RV | enables move towards cursor when a button is held, values for CursorMoveInput enum are: NONE, LEFT_MOUSE, RIGHT_MOUSE, LEFT_OR_RIGHT_MOUSE. Example usage: player.cursorMoveInputMode = CursorMoveInput.LEFT_MOUSE | None
`canTopdownCameraRotate (Bool, read/write)` | RV | if true, can rotate in topdown mode | None
`showBodyForFpsCamera(Bool, read/write)` | RV | (for trying out showing body in FPS camera, will likely change/be removed) show body mesh in FPS camera mode | None
`shouldRotationFollowCursor (Bool, read/write)` | RV | if true, character will rotate to face cursor (intended for topdown mode) | None
`scrollZoomSpeed (Number, read/write)` | RV | multiplier to mouse wheel scroll speed for zoom | None
`spreadModifier (Number, read/write)` | RV | Added to the player’s targeting spread | None
`buoyancy(Number, read/write)` | RV | in water, buoyancy 1.0 is neutral (won’t sink or float naturally). Less than 1 to sink, greater than 1 to float. | None
`isCursorVisible (Bool, read/write)` | RV | whether cursor is visible. Will be set automatically by camera mode by default, but can be overriden afterwards | None
`isCursorLocked (Bool, read/write)` | RV | whether to lock cursor in viewport. Will be set automatically by camera mode by default, but can be overriden afterwards | None
`isCursorInteractableWithUI (Bool, read/write)` | RV | whether cursor can interact with UI elements like buttons. Will be set automatically by camera mode by default, but can be overriden afterwards | None
`damagedEvent (Event<Player, Damage>, read-only)` | RV | Event fired when the Player takes damage. | Read-Only
`diedEvent (Event<Player, Damage>, read-only)` | RV | Event fired when the Player dies. | Read-Only
`respawnedEvent (Event<Player>, read-only)` | RV | Event fired when the Player respawns. | Read-Only
`bindingPressedEvent (Event<Player, String>, read-only)` | RV | Event fired when an action binding is pressed. Second parameter tells you which binding. | Read-Only
`bindingReleasedEvent (Event<Player, String>, read-only)` | RV | Event fired when an action binding is released. Second parameter tells you which binding. | Read-Only
`resourceChangedEvent(Event<Player>, read-only)` | RV | Event fired when a resource changed | Read-Only
`keyValuePairReceivedEvent(Event<Player, String, value>, read-only)` | RV | Event fired when a key-value pair is received. See also SendKeyValuePairToServer(). | Read-Only

Function | Return Value | Description | Tags
--- | --- | --- | ---
`(Color) GetColor()` | RV | The color of the light. | None
`SetColor(Color)(dynamic)` | RV | The color of the light | Dynamic

Property | Return Value | Description | Tags
--- | --- | --- | ---
`intensity (Number, read-write)(dynamic)` | RV | The intensity of the light. This has two interpretations, depending on use_attenuation_radius. If true, the light's Intensity is in units of lumens, where 1700 lumens is a 100W lightbulb. If false: the light's Intensity is a brightness scale. | Dynamic
`hasAttenuationRadius(bool, read-write)(dynamic)` | RV | The attenuation method of the light. When enabled, attenuation_radius is used. When disabled, fall_off_exponent is used. Also changes the interpretation of the intensity property, see intensity for details. | Dynamic
`attenuationRadius(Number, read-write)(dynamic)` | RV | Bounds the light's visible influence. This clamping of the light's influence is not physically correct but very important for performance, larger lights cost more. | Dynamic
`fallOffExponent(Number, read-write)(dynamic)` | RV | Controls the radial falloff of the light when use_attenuation_radius is disabled. 2.0 is almost linear and very unrealistic and around 8.0 it looks reasonable. With large exponents, the light has contribution to only a small area of its influence radius but still costs the same as low exponents. | Dynamic
`sourceRadius(Number, read-write)(dynamic)` | RV | Radius of light source shape. | Dynamic
`sourceLength(Number, read-write)(dynamic)` | RV | Length of light source shape. | Dynamic
`isShadowCaster(bool, read-write)(dynamic)` | RV | Does this light cast shadows? | Dynamic
`hasTemperature(Number, read-write)(dynamic)` | RV | true: use temperature value as illuminant. false: use white (D65) as illuminant. | Dynamic
`temperature(Number, read-write)(dynamic)` | RV | Color temperature in Kelvin of the blackbody illuminant. White (D65) is 6500K. | Dynamic

Function | Return Value | Description | Tags
--- | --- | --- | ---
`(Color) GetFillColor()` | RV | The color of the fill. | None
`SetFillColor(Color)` | RV | The color of the fill. | None

Property | Return Value | Description | Tags
--- | --- | --- | ---
`progress (Number)` | RV | From 0 to 1, how full the bar should be. | None

Function | Return Value | Description | Tags
--- | --- | --- | ---
`(Object) destroy()` | RV | Immediately destroys the object. | None
`(Transform) GetTransform()` | RV | Transform data for the Projectile in world space. | None
`(Vector3) GetWorldPosition()` | RV | Position of the Projectile in world space. | None
`SetWorldPosition(Vector3)` | RV | Position of the Projectile in world space. | None
`(Vector3) GetVelocity()` | RV | Current direction and speed vector of the Projectile. | None
`SetVelocity(Vector3)` | RV | Current direction and speed vector of the Projectile. | None

Property | Return Value | Description | Tags
--- | --- | --- | ---
`owner (Player, read/write)` | RV | The player who fired this projectile. Setting this property ensures the Projectile does not impact the owner or their allies. This will also change the color of the projectile if teams are being used in the game. | None
`sourceAbility (Ability, read/write)` | RV | ? | None
`speed (Number, read/write, default 5000)` | RV | Centimeters per second movement. | None
`maxSpeed (Number, read/write, default 0)` | RV | Max cm/s. Zero means no limit. | None
`gravityScale (Number, read/write, default 1.0)` | RV | How much drop. 1 means normal gravity. Zero can be used to make a Projectile go in a straight line. | None
`drag (Number, read/write, default 0)` | RV | Deceleration. Important for homing Projectiles (try a value around 5). Negative drag will cause the Projectile to accelerate. | None
`bouncesRemaining (Integer, read/write, default 0)` | RV | Number of bounces remaining before it dies. | None
`bounciness (Number, read/write, default 0.6)` | RV | Velocity % maintained after a bounce. | None
`lifeSpan (Number, read/write, default 10)` | RV | Max seconds the projectile will exist. | None
`shouldBounceOnPlayers (bool, read/write, default False)` | RV | Determines if the projectile should bounce off players or be destroyed, when bouncesRemaining is used. | None
`piercesRemaining (Integer, read/write, default 0)` | RV | Number of objects that will be pierced before it dies. A piercing Projectile loses no velocity when going through objects, but still fires the impactEvent event. If combined with bounces, all piercesRemaining are spent before bouncesRemaining are counted. | None
`capsuleRadius (Number, read/write, default 22)` | RV | Shape of the projectile’s collision. | None
`capsuleLength (Number, read/write, default 44)` | RV | Shape of the projectile’s collision. A value of zero will make it shaped like a Sphere. | None
`homingTarget (Player, read/write)` | RV | The projectile accelerates towards its target. | None
`homingAcceleration (Number, read/write, default 10,000)` | RV | Magnitude of acceleration towards the target. | None
`shouldDieOnImpact (bool, read/write, default True)` | RV | If true the projectile is automatically destroyed when it hits something, unless it has bounces remaining. | None
`impactEvent (Event<Projectile, other Object, HitResult>, read-only)` | RV | An event fired when the Projectile collides with something. Impacted object parameter will be either of type CoreObject or Player, but can also be nil. The HitResult describes the point of contact between the Projectile and the impacted object. | Read-Only
`lifeSpanEndedEvent (Event<Projectile>, read-only)` | RV | An event fired when the Projectile reaches the end of its lifespan. Called before it is destroyed. | Read-Only
`homingFailedEvent (Event<Projectile>, read-only)` | RV | The target is no longer valid, for example the player disconnected from the game or the object was destroyed somehow. | Read-Only

Class Function | Return Value | Description | Tags
--- | --- | --- | ---
`(Quaternion) Slerp(Quaternion from, Quaternion to, Number progress)` | RV | Spherical interpolation between two quaternions by the specified progress amount and returns the resultant, normalized Quaternion. | None

Constructor | Return Value | Description | Tags
--- | --- | --- | ---
`Quaternion.New (Number x, Number y, Number z, Number w)` | RV | Construct with the given values. | None
`Quaternion.New (Rotation r)` | RV | Construct with the given Rotation. | None
`Quaternion.New (Vector3 axis, Number angle)` | RV | Construct a quaternion representing a rotation of angle radians around the axis Vector3. | None
`Quaternion.New (Vector3 from, Vector3 to)` | RV | Construct a rotation between the from and to vectors. | None
`Quaternion.New (Quaternion q)` | RV | Copies the given Quaternion. | None
`Quaternion.IDENTITY` | RV | Predefined quaternion with no rotation. | None

Function | Return Value | Description | Tags
--- | --- | --- | ---
`(Rotation) GetRotation()` | RV | Get the Rotation representation of the quaternion. | None
`(Vector3) GetForwardVector()` | RV | Forward unit vector rotated by the quaternion. | None
`(Vector3) GetRightVector()` | RV | Right unit vector rotated by the quaternion. | None
`(Vector3) GetUpVector()` | RV | Up unit vector rotated by the quaternion. | None

Operator | Return Value | Description | Tags
--- | --- | --- | ---
`Quaternion + Quaternion` | RV | Component-wise addition. | None
`Quaternion` | RV | Quaternion - Component-wise subtraction. | None
`Quaternion * Quaternion` | RV | Compose two quaternions, with the result applying the right rotation first, then the left rotation second. | None
`Quaternion * Number` | RV | Multiplies each component by the right-side Number. | None
`Quaternion * Vector3` | RV | Rotates the right-side vector and returns the result. | None
`Quaternion / Number` | RV | Divides each component by the right-side Number. | None
`-Quaternion` | RV | Returns the inverse rotation. | None

Property | Return Value | Description | Tags
--- | --- | --- | ---
`x (Number, read-write)` | RV | The X component of the quaternion. | None
`y (Number, read-write)` | RV | The Y component of the quaternion. | None
`z (Number, read-write)` | RV | The Z component of the quaternion. | None
`w (Number, read-write)` | RV | The W component of the quaternion. | None

Constructor | Return Value | Description | Tags
--- | --- | --- | ---
`RandomStream.New()` | RV | Constructor with seed 0. | None
`RandomStream.New(Integer)` | RV | Constructor with specified seed. | None

Function | Return Value | Description | Tags
--- | --- | --- | ---
`(Integer) GetInitialSeed()` | RV | The seed that was used to initialize this stream. | None
`Reset()` | RV | Function that sets the seed back to the initial seed. | None
`Mutate()` | RV | Moves the seed forward to the next seed. | None
`(Number) GetNumber(Number Min, Number Max)` | RV | Returns a floating point number between Min and Max (inclusive).  Call with no arguments to get a number between 0 and 1 (exclusive). | None
`(Integer) GetInteger(Integer Min, Integer Max)` | RV | Returns an integer number between Min and Max (inclusive). | None
`(Vector3) GetVector3()` | RV | Returns a random unit vector. | None
`(Vector3) GetVector3FromCone(Vector3 Direction, Number HalfAngle)` | RV | Returns a random unit vector, uniformly distributed, from inside a cone defined by Direction and HalfAngle (in radians). | None
`(Vector3) GetVector3FromCone(Vector3 Direction, Number HorizontalAngle, Number VerticalAngle)` | RV | Returns a random unit vector, uniformly distributed, from inside a cone defined by Direction, HorizontalAngle and VerticalAngle (in radians). | None

Property | Return Value | Description | Tags
--- | --- | --- | ---
`seed (Integer, read/write)` | RV | The current seed used for RNG. | None

Event | Return Value | Description | Tags
--- | --- | --- | ---
`valueChangedEvent (Event<Replicator, string propertyName>, read-only)` | RV | An event that is fired whenever any of the properties managed by the replicator receives an update. The event is fired on the server and the client. Event payload is the Replicator object and the name of the property that just changed. | Read-Only

Function | Return Value | Description | Tags
--- | --- | --- | ---
`(Object, bool) GetValue(string)` | RV | Returns the named custom property and whether or not the property was found. | None
`(bool) SetValue(string, Object)` | RV | Sets the named custom property and returns whether or not it was set successfully. Reasons for failure are not being able to find the property or the Object property being the wrong type. | None

Constructor | Return Value | Description | Tags
--- | --- | --- | ---
`Rotation.New ()` | RV | Creates a non-rotation (0, 0, 0). | None
`Rotation.New (Number x, Number y, Number z)` | RV | Construct with the given values. | None
`Rotation.New (Quaternion q)` | RV | Construct a rotation using the given Quaternion. | None
`Rotation.New (Vector3 forward, Vector3 up)` | RV | Construct a rotation that will rotate Vector3.FORWARD to point in the direction of the given forward vector, with the up vector as a reference.  Returns (0, 0, 0) if forward and up point in the exact same (or opposite) direction, or if one of them is of length 0. | None
`Rotation.New (Rotation r)` | RV | Copies the given Rotation. | None
`Rotation.ZERO` | RV | Constant rotation of (0, 0, 0) | None

Operator | Return Value | Description | Tags
--- | --- | --- | ---
`Rotation + Rotation` | RV | Add two rotations together. | None
`Rotation` | RV | Rotation - Subtract a rotation. | None
`Rotation * Number` | RV | Returns the scaled rotation. | None
`-Rotation` | RV | Returns the inverse rotation. | None

Property | Return Value | Description | Tags
--- | --- | --- | ---
`x (Number, read-write)` | RV | The X component of the rotation. | None
`y (Number, read-write)` | RV | The Y component of the rotation. | None
`z (Number, read-write)` | RV | The Z component of the rotation. | None

Property | Return Value | Description | Tags
--- | --- | --- | ---
`context(table, read-only)` | RV | Returns the table containing any non-local variables and functions created by the script.  This can be used to call (or overwrite!) functions on another script. | Read-Only

Property | Return Value | Description | Tags
--- | --- | --- | ---
`(value, bool) GetSmartProperty(string property_name)` | RV | Gets the current value of an exposed blueprint variable.  Returns the value, which can be an Integer, Number, bool, string, Vector3, Rotator, Color, or nil if not found.  Second return value is a bool, true if found and false if not. | None
`(bool) SetSmartProperty(string property_name, value)` | RV | Sets the value of an exposed blueprint variable.  Value, which can be a Number, bool, string, Vector3, Rotation, or Color, but must match the type of the property on the blueprint.  Returns true if set successfully and false if not. | None

Property | Return Value | Description | Tags
--- | --- | --- | ---
`innerConeAngle (Number, read-write)(dynamic)` | RV | ? | Dynamic
`outerConeAngle (Number, read-write)(dynamic)` | RV | ? | Dynamic

Function | Return Value | Description | Tags
--- | --- | --- | ---
`(Color) GetColor()` | RV | Overrides the color of all materials on the mesh, and replicates the new colors. | None
`SetColor(Color)(dynamic)` | RV | Overrides the color of all materials on the mesh, and replicates the new colors. | Dynamic
`(value, bool) GetMaterialProperty(Integer slot, string property_name)` | RV | Gets the current value of a property on a material in a given slot.  Returns the value, which can be an Number, bool, Vector3, Color, or nil if not found. Second return value is a bool, true if found and false if not. | None
`(bool) SetMaterialProperty(Integer slot, string property_name, value)` | RV | Sets the value of a property on a material in a given slot. Value, which can be a Number, bool, Vector3, or Color, but must match the type of the property on the material. Returns true if set successfully and false if not. | None
`ResetColor()` | RV | Turns off the color override, if there is one. | None

Property | Return Value | Description | Tags
--- | --- | --- | ---
`isSimulatingPhysics (bool, read-write)(dynamic)` | RV | If true, physics will be enabled for the mesh. | Dynamic
`team (int, read-write)(dynamic)` | RV | Assigns the mesh to a team. Value range from 0 to 4. 0 is neutral team | Dynamic
`isTeamColorUsed (bool, read-write)(dynamic)` | RV | If true, and the mesh has been assigned to a valid team, players on that team will see a blue mesh, while other players will see red. (Requires a material that supports the color property.) | Dynamic
`isTeamCollisionDisabled (bool, read-write)(dynamic)` | RV | If true, and the mesh has been assigned to a valid team, players on that team will not collide with the mesh. | Dynamic
`isEnemyCollisionDisabled (bool, read-write)(dynamic)` | RV | If true, and the mesh has been assigned to a valid team, players on other teams will not collide with the mesh. | Dynamic
`isCameraCollisionDisabled (bool, read-write)(dynamic)` | RV | If true, and the mesh will not push against the camera. Useful for things like railings or transparent walls. | Dynamic

#### Global Context Methods

Global Context Methods | Return Value | Description | Tags
--- | --- | --- | ---
`(bool success, string) Storage.SaveTable(tableName, table)` | RV | Sets the passed in table as the current table for the given table name. Any previous values are removed. | None
`(bool success, (string or table)) Storage.LoadTable(tableName)` | RV | Loads the table by name. If the table exists, success is true, and the second return value is the table. If the load fails or the table doesn’t exist, success is false and the second return value is a string with the error message. | None
`(bool success, string) Storage.DeleteTable(tableName)` | RV | Deletes the table. If success is true, the table was deleted. If success is false, the second return value is an error message with the reason why (ie table doesn’t exist). | None
`(bool success, (string or table)) Storage.IncrementTable(tableName, table)` | RV | Adds only the key value pairs in the given table to an existing table. If the table doesn’t exist, a new one is created. If success is true, the second return value is a lua table containing only the new values as a result of the increment. Negative values can be used to decrement. If success is false, the second return value is an error message string explaining why. | None

#### Player Context Methods

Player Context Methods | Return Value | Description | Tags
--- | --- | --- | ---
`(bool success, string) Storage.SavePlayerTable(player, tableName, table)` | RV | Sets the passed in table as the current table for the given player and table name. Any previous values are removed. | None
`(bool success, (string or table)) Storage.LoadPlayerTable(player, tableName)` | RV | Loads the table by player and name. If the table exists, success is true, and the second return value is the table. If the load fails or the table doesn’t exist, success is false and the second return value is a string with the error message. | None
`(bool success, string) Storage.DeletePlayerTable(player, tableName)` | RV | Deletes the table for the given player. If success is true, the table was deleted. If success is false, the second return value is an error message with the reason why (ie table doesn’t exist). | None
`(bool success, (string or table)) Storage.IncrementPlayerTable(player, tableName, table)` | RV | Adds only the key value pairs in the given table to an existing table. If the table doesn’t exist, a new one is created. If the key doesn’t exist, it is added. Negative values can be used to decrement. If success is true, the second return value is a lua table containing only the new values as a result of the increment. If success is false, the second return value is an error message string explaining why. | None
`Storage.IncrementPlayerTableAsync(player, tableName, table, callback(bool, (string or table))` | RV | Same as above except execution of the script is not halted. The fourth function parameter is a function with the same inputs as returned by the above function. This function is used as a test alternative to see in what use cases async may be preferable or not. | None

#### Class functions

Class functions | Return Value | Description | Tags
--- | --- | --- | ---
`(Task) Spawn(function taskFunction, [Number delay])` | RV | Creates a new Task which will call taskFunction without blocking the current task.  The optional delay parameter specifies how many seconds before the task scheduler should run the Task.  By default, the scheduler will run the Task at the end of the current frame. | None
`(Task) GetCurrent()` | RV | Returns the currently running Task. | None
`Wait([Number delay])` | RV | Yields the current Task, resuming in delay seconds, or during the next frame if delay is not specified. | None

Function | Return Value | Description | Tags
--- | --- | --- | ---
`Cancel()` | RV | Cancels the Task immediately.  It will no longer be executed, regardless of the state it was in.  If called on the currently executing Task, that Task will halt execution. | None
`(TaskStatus) GetStatus()` | RV | Returns the status of the Task. | None

Property | Return Value | Description | Tags
--- | --- | --- | ---
`id (Integer, read-only)` | RV | A unique identifier for the task. | Read-Only
`repeatCount (Integer, read-write)` | RV | If set to a non-negative number, the Task will execute that many times.  A negative number indicates the Task should repeat indefinitely (until otherwise canceled).  With the default of 0, the Task will execute once.  With a value of 1, the script will repeat once, meaning it will execute twice. | None
`repeatInterval (Number, read-write)` | RV | For repeating Tasks, the number of seconds to wait after the Task completes before running it again.  If set to 0, the Task will wait until the next frame. | None

Function | Return Value | Description | Tags
--- | --- | --- | ---
`(Color) GetColor()` | RV | The color of the text. | None
`SetColor(Color)` | RV | The color of the text. | None

Property | Return Value | Description | Tags
--- | --- | --- | ---
`text (String)` | RV | The actual text string to show. | None
`fontSize (Number)` | RV | Font size | None
`justification (TextJustify)` | RV | Enum that determines alignment of text.  Possible values are: TextJustify.LEFT, TextJustify.Right, and TextJustify.CENTER. | None

Property | Return Value | Description | Tags
--- | --- | --- | ---
`text (string, read-write)(dynamic)` | RV | The text being displayed by this object. | Dynamic
`horizontalScale (Number, read-write)(dynamic)` | RV | The horizontal size of the text. | Dynamic
`verticalScale (Number, read-write)(dynamic)` | RV | The vertical size of the text. | Dynamic

Constructor | Return Value | Description | Tags
--- | --- | --- | ---
`Transform.New ()` | RV | Creates an identity transform. | None
`Transform.New (Quaternion rotation, Vector3 position, Vector3 scale)` | RV | Construct with quaternion. | None
`Transform.New (Rotation rotation, Vector3 position, Vector3 scale)` | RV | Construct with rotation. | None
`Transform.New (Vector3 x_axis, Vector3 y_axis, Vector3 z_axis, Vector3 translation)` | RV | Construct from matrix. | None
`Transform.New (Transform transform)` | RV | Copies the given Transform. | None
`Transform.IDENTITY` | RV | Constant identity transform. | None

Function | Return Value | Description | Tags
--- | --- | --- | ---
`(Vector3) GetPosition()` | RV | Returns a copy of the position component of the transform. | None
`SetPosition (Vector3)` | RV | Sets the position component of the transform. | None
`(Rotation) GetRotation()` | RV | Returns a copy of the rotation component of the transform. | None
`SetRotation (Rotation)` | RV | Sets the rotation component of the transform. | None
`(Quaternion) GetQuaternion()` | RV | Returns a quaternion-based representation of the rotation. | None
`SetQuaternion (Quaternion)` | RV | Sets the quaternion-based representation of the rotation. | None
`(Vector3) GetScale()` | RV | Returns a copy of the scale component of the transform. | None
`SetScale (Vector3)` | RV | Sets the scale component of the transform. | None
`(Vector3) GetForwardVector()` | RV | Forward vector of the transform. | None
`(Vector3) GetRightVector()` | RV | Right vector of the transform. | None
`(Vector3) GetUpVector()` | RV | Up vector of the transform. | None
`(Transform) GetInverse()` | RV | Inverse of the transform. | None
`(Vector3) TransformPosition(Vector3 position)` | RV | Applies the transform to the given position in 3D space. | None
`(Vector3) TransformDirection(Vector3 direction)` | RV | Applies the transform to the given directional Vector3.  This will rotate and scale the Vector3, but does not apply the transform’s position. | None

Operator | Return Value | Description | Tags
--- | --- | --- | ---
`Transform * Transform` | RV | Returns a new transform composing the left and right transforms. | None
`Transform * Quaternion` | RV | Returns a new transform composing the left transform then the right side rotation. | None

Event | Return Value | Description | Tags
--- | --- | --- | ---
`beginOverlapEvent (Event<CoreObject trigger, object other>, read-only)` | RV | An event fired when an object enters the trigger volume.  The first parameter is the trigger itself.  The second is the object overlapping the trigger, which may be a CoreObject, a Player, or some other type.  Call other:IsA() to check the type.  Eg, other:IsA(‘Player’), other:IsA(‘StaticMesh’), etc. | Read-Only
`endOverlapEvent (Event<CoreObject trigger, object other>, read-only)` | RV | An event fired when an object exits the trigger volume.  Parameters the same as beginOverlapEvent. | Read-Only
`interactedEvent (Event<CoreObject trigger, Player>, read-only)` | RV | An event fired when a player uses the interaction on a trigger volume (By default “F” key). The first parameter is the trigger itself and the second parameter is a Player. | Read-Only

Property | Return Value | Description | Tags
--- | --- | --- | ---
`isInteractable (bool, read-write)(dynamic)` | RV | Is the trigger interactable? | Dynamic
`interactionLabel (string, read-write)(dynamic)` | RV | The text players will see in their HUD when they come into range of interacting with this trigger. | Dynamic
`team (int, read-write)(dynamic)` | RV | Assigns the trigger to a team. Value range from 0 to 4. 0 is neutral team | Dynamic
`isTeamCollisionDisabled (bool, read-write)(dynamic)` | RV | If true, and the trigger has been assigned to a valid team, players on that team will not overlap or interact with the trigger. | Dynamic
`isEnemyCollisionDisabled (bool, read-write)(dynamic)` | RV | If true, and the trigger has been assigned to a valid team, players on enemy teams will not overlap or interact with the trigger. | Dynamic

Property | Return Value | Description | Tags
--- | --- | --- | ---
`x (Number)` | RV | Screen-space offset from the anchor. | None
`y (Number)` | RV | Screen-space offset from the anchor. | None
`width (Number)` | RV | Horizontal size of the control. | None
`height (Number)` | RV | Vertical size of the control. | None
`inheritParentWidth(bool)` | RV | inherit parent width | None
`inheritParentHeight(bool)` | RV | inherit parent height | None
`addSelfSizeToInheritedSize(bool)` | RV | add self width and height to inherited size | None
`rotationAngle (Number)` | RV | rotation angle of the control. | None

Function | Return Value | Description | Tags
--- | --- | --- | ---
`UI.ShowFlyUpText(Player target, string message, Color, Vector3, [Number])` | RV | Shows a quick text on screen that tracks its position relative to a world position. The last parameter is an optional duration. Default duration is 0.5 seconds. | None
`UI.ShowBigFlyUpText(Player target, string message, Color, Vector3, [Number])` | RV | Same as ShowFlyUpText, but uses a larger font. | None
`UI.ShowDamageDirection(Player target, Vector3 world point)` | RV | Target player sees an arrow pointing towards some damage source. Lasts for 5 seconds. | None
`UI.ShowDamageDirection(Player target, CoreObject)` | RV | Target player sees an arrow pointing towards some Core Object. Multiple calls with the same Player and Core Object reuse the same UI indicator, but refreshes its duration. | None
`UI.ShowDamageDirection(Player target, Player source)` | RV | Target player sees an arrow pointing towards some other Player. Multiple calls with the same Players reuse the same UI indicator, but refreshes its duration. The arrow points to where the source was at the moment ShowDamageDirection is called and does not track the source Player’s movements. | None
`(Vector2) UI.GetScreenPosition(Vector3 world_position)` | RV | Calculates the location that world_position appears on the screen. Returns a Vector2 with the x, y coordinates. Only gives results from a client context. | None
`(Vector2) UI.GetScreenSize()` | RV | Returns a Vector2 with the size of the player’s screen in the x, y coordinates. Only gives results from a client context. | None
`UI.PrintToScreen (string, Color)` | RV | Draws a message on the corner of the screen.  Second optional Color parameter can change the color from the default white. | None

Class Function | Return Value | Description | Tags
--- | --- | --- | ---
`(Vector2) Lerp(Vector2 from, Vector2 to, Number progress)` | RV | Linearly interpolates between two vectors by the specified progress amount and returns the resultant Vector2. | None
`Vector2 + Vector2` | RV | Component-wise addition. | None
`Vector2 + Number` | RV | Adds the right-side number to each of the components in the left side and returns the resulting Vector2. | None
`Vector2 = Vector2` | RV | Component-wise subtraction. | None
`Vector2 = Number` | RV | Subtracts the right-side number from each of the components in the left side and returns the resulting Vector2. | None
`Vector2 * Vector2` | RV | Component-wise multiplication. | None
`Vector2 * Number` | RV | Multiplies each component of the Vector2 by the right-side number. | None
`Number * Vector2` | RV | Multiplies each component of the Vector2 by the left-side number. | None
`Vector2 / Vector2` | RV | Component-wise division. | None
`Vector2 / Number` | RV | Divides each component of the Vector2 by the right-side number. | None
`=Vector2` | RV | Returns the negation of the Vector2. | None
`Vector2 .. Vector2` | RV | Returns the dot product of the Vector2s. | None
`Vector2 ^ Vector2` | RV | Returns the cross product of the Vector2s. | None

Constructor | Return Value | Description | Tags
--- | --- | --- | ---
`Vector2.New ()` | RV | Creates the vector (0, 0). | None
`Vector2.New (Number x, Number y)` | RV | Construct with the given x, y values. | None
`Vector2.New (Number v)` | RV | Construct with x, y values both set to the given value. | None
`Vector2.New (Vector3 v)` | RV | Construct with x, y values from the given Vector3. | None
`Vector2.ZERO` | RV | (0, 0, 0) | None
`Vector2.ONE` | RV | (1, 1, 1) | None

Function | Return Value | Description | Tags
--- | --- | --- | ---
`(Vector2) GetNormalized()` | RV | Returns a new Vector2 with size 1, but still pointing in the same direction.  Returns (0, 0) if the vector is too small to be normalized. | None

Property | Return Value | Description | Tags
--- | --- | --- | ---
`x (Number, read-write)` | RV | The X component of the vector. | None
`y (Number, read-write)` | RV | The Y component of the vector. | None
`size (Number, read-only)` | RV | The magnitude of the vector. | Read-Only
`sizeSquared (Number, read-only)` | RV | The squared magnitude of the vector. | Read-Only

Class Function | Return Value | Description | Tags
--- | --- | --- | ---
`(Vector3) Lerp(Vector3 from, Vector3 to, Number progress)` | RV | Linearly interpolates between two vectors by the specified progress amount and returns the resultant Vector3. | None
`Vector3 + Vector3` | RV | Component-wise addition. | None
`Vector3 + Number` | RV | Adds the right-side number to each of the components in the left side and returns the resulting Vector3. | None
`Vector3 = Vector3` | RV | Component-wise subtraction. | None
`Vector3 = Number` | RV | Subtracts the right-side number from each of the components in the left side and returns the resulting Vector3. | None
`Vector3 * Vector3` | RV | Component-wise multiplication. | None
`Vector3 * Number` | RV | Multiplies each component of the Vector3 by the right-side number. | None
`Number * Vector3` | RV | Multiplies each component of the Vector3 by the left-side number. | None
`Vector3 / Vector3` | RV | Component-wise division. | None
`Vector3 / Number` | RV | Divides each component of the Vector3 by the right-side number. | None
`=Vector3` | RV | Returns the negation of the Vector3. | None
`Vector3 .. Vector3` | RV | Returns the dot product of the Vector3s. | None
`Vector3 ^ Vector3` | RV | Returns the cross product of the Vector3s. | None

Constructor | Return Value | Description | Tags
--- | --- | --- | ---
`Vector3.New ()` | RV | Creates the vector (0, 0, 0). | None
`Vector3.New (Number x, Number y, Number z)` | RV | Construct with the given x, y, z values. | None
`Vector3.New (Number v)` | RV | Construct with x, y, z values all set to the given value. | None
`Vector3.New (Vector2 xy, Number z)` | RV | Construct with x, y values from the given Vector2 and the given z value. | None
`Vector3.New (Vector4 v)` | RV | Construct with x, y, z values from the given Vector4. | None
`Vector3.ZERO` | RV | (0, 0, 0) | None
`Vector3.ONE` | RV | (1, 1, 1) | None
`Vector3.FORWARD` | RV | (1, 0, 0) | None
`Vector3.UP` | RV | (0, 0, 1) | None
`Vector3.RIGHT` | RV | (0, 1, 0) | None

Function | Return Value | Description | Tags
--- | --- | --- | ---
`(Vector3) GetNormalized()` | RV | Returns a new Vector3 with size 1, but still pointing in the same direction.  Returns (0, 0, 0) if the vector is too small to be normalized. | None

Property | Return Value | Description | Tags
--- | --- | --- | ---
`x (Number, read-write)` | RV | The X component of the vector. | None
`y (Number, read-write)` | RV | The Y component of the vector. | None
`z (Number, read-write)` | RV | The Z component of the vector. | None
`size (Number, read-only)` | RV | The magnitude of the vector. | Read-Only
`sizeSquared (Number, read-only)` | RV | The squared magnitude of the vector. | Read-Only

Class Function | Return Value | Description | Tags
--- | --- | --- | ---
`(Vector4) Lerp(Vector4 from, Vector4 to, Number progress)` | RV | Linearly interpolates between two vectors by the specified progress amount and returns the resultant Vector4. | None
`Vector4 + Vector4` | RV | Component-wise addition. | None
`Vector4 + Number` | RV | Adds the right-side number to each of the components in the left side and returns the resulting Vector4. | None
`Vector4 = Vector4` | RV | Component-wise subtraction. | None
`Vector4 = Number` | RV | Subtracts the right-side number from each of the components in the left side and returns the resulting Vector4. | None
`Vector4 * Vector4` | RV | Component-wise multiplication. | None
`Vector4 * Number` | RV | Multiplies each component of the Vector4 by the right-side number. | None
`Number * Vector4` | RV | Multiplies each component of the Vector4 by the left-side number. | None
`Vector4 / Vector4` | RV | Component-wise division. | None
`Vector4 / Number` | RV | Divides each component of the Vector4 by the right-side number. | None
`=Vector4` | RV | Returns the negation of the Vector4. | None
`Vector4 .. Vector4` | RV | Returns the dot product of the Vector4s. | None
`Vector4 ^ Vector4` | RV | Returns the cross product of the Vector4s. | None

Constructor | Return Value | Description | Tags
--- | --- | --- | ---
`Vector4.New ()` | RV | Creates the vector (0, 0, 0, 0). | None
`Vector4.New (Number x, Number y, Number z, Number w)` | RV | Construct with the given x, y, z, w values. | None
`Vector4.New (Number v)` | RV | Construct with x, y, z, w values all set to the given value. | None
`Vector4.New (Vector3 xyz, Number w)` | RV | Construct with x, y, z values from the given Vector3 and the given w value. | None
`Vector4.New (Vector4 v)` | RV | Construct with x, y, z, w values from the given Vector4. | None
`Vector4.New (Vector2 xy, Vector2 zw)` | RV | Construct with x, y values from the first Vector2 and z, w values from the second Vector2. | None
`Vector4.New (Color v)` | RV | Construct with x, y, z, w values mapped from the given Color’s r, g, b, a values. | None
`Vector3.ZERO` | RV | (0, 0, 0, 0) | None
`Vector3.ONE` | RV | (1, 1, 1, 1) | None

Function | Return Value | Description | Tags
--- | --- | --- | ---
`(Vector4) GetNormalized()` | RV | Returns a new Vector4 with size 1, but still pointing in the same direction.  Returns (0, 0, 0, 0) if the vector is too small to be normalized. | None

Property | Return Value | Description | Tags
--- | --- | --- | ---
`x (Number, read-write)` | RV | The X component of the vector. | None
`y (Number, read-write)` | RV | The Y component of the vector. | None
`z (Number, read-write)` | RV | The Z component of the vector. | None
`w (Number, read-write)` | RV | The W component of the vector. | None
`size (Number, read-only)` | RV | The magnitude of the vector. | Read-Only
`sizeSquared (Number, read-only)` | RV | The squared magnitude of the vector. | Read-Only

Function | Return Value | Description | Tags
--- | --- | --- | ---
`Play()` | RV | Starts playing the effect. | None
`Stop()` | RV | Stops playing the effect. | None

Function | Return Value | Description | Tags
--- | --- | --- | ---
`(HitResult) GetHitResult()` | RV | Physics information about the impact between the weapon and the other object. | None
`(array<HitResult>) GetHitResults()` | RV | Table with multiple HitResults that hit the same object, in the case of Weapons with multi-shot (e.g. Shotguns). If a single attack hits multiple targets you receive a separate interaction event for each object hit. | None

Property | Return Value | Description | Tags
--- | --- | --- | ---
`targetObject (Object, read-only)` | RV | Reference to the object/player hit by the weapon. | Read-Only
`projectile (Projectile, read-only)` | RV | Reference to a Projectile, if one was produced as part of this interaction. | Read-Only
`sourceAbility (Ability, read-only)` | RV | Reference to the Ability which initiated the interaction. | Read-Only
`weapon (Weapon, read-only)` | RV | Reference to the Weapon that is interacting. | Read-Only
`weaponOwner (Player, read-only)` | RV | Reference to the Player who had the Weapon equipped at the time it was activated, ultimately leading to this interaction. | Read-Only
`travelDistance (Number, read-only)` | RV | The distance in cm between where the weapon attack started until it impacted something. | Read-Only

Property | Return Value | Description | Tags
--- | --- | --- | ---
`isReticleEnabled (bool, read/write)` | RV | If True, the reticle will appear when this Weapon is equipped. | None
`attackCooldownDuration (Number, read/write)` | RV | Interval between separate burst sequences. | None
`multiShotCount (Integer, read/write)` | RV | Number of projectiles/hitscans that will fire simultaneously inside the spread area each time the Weapon attacks. Does not affect the amount of ammo consumed per attack. | None
`burstCount (Integer, read/write)` | RV | Number of automatic activations of the weapon that generally occur in quick succession. | None
`shotsPerSecond (Number, read/write)` | RV | Used in conjunction with burst_count to determine the interval between automatic weapon activations. | None
`shouldBurstStopOnRelease (bool, read/write)` | RV | If True, a burst sequence can be interrupted by the player by releasing the action button. If False, the burst continues firing automatically until it completes or the weapon runs out of ammo. | None
`isHitscan (bool, read/write)` | RV | If False, the weapon will produce simulated projectiles. If true, it will instead use instantaneous line traces to simulate shots. | None
`range (Number, read/write)` | RV | Max travel distance of the projectile (is_hitscan = False) or range of the line trace (is_hitscan = True). | None
`projectileTemplateId (String, read/write)` | RV | Asset reference for the visual body of the projectile, for non-hitscan weapons. | None
`muzzleFlashTemplateId (String, read/write)` | RV | Asset reference for a VFX to be attached to the muzzle point each time the weapon attacks. | None
`trailTemplateId (String, read/write)` | RV | Asset reference for a trail VFX to follow the trajectory of the shot. | None
`beamTemplateId (String, read/write)` | RV | Asset reference for a beam VFX to be placed along the trajectory of the shot. Useful for hitscan weapons or very fast projectiles. | None
`impactSurfaceTemplateId (String, read/write)` | RV | Asset reference of a VFX to be attached to the surface of any Core Objects hit by the attack. | None
`impactProjectileTemplateId (String, read/write)` | RV | Asset reference of a VFX to be spawned at the interaction point. It will be aligned with the trajectory. If the impacted object is a Core Object, then the VFX will attach to it as a child. | None
`impactPlayerTemplateId (String, read/write)` | RV | Asset reference of a VFX to be spawned at the interaction point, if the impacted object is a player. | None
`projectileSpeed (Number, read/write)` | RV | Travel speed (cm/s) of projectiles spawned by this weapon. | None
`projectileLifeSpan (Number, read/write)` | RV | Duration of projectiles. After which they are destroyed. | None
`projectileGravity (Number, read/write)` | RV | Gravity scale applied to spawned projectiles. | None
`projectileLength (Number, read/write)` | RV | Length of the projectile’s capsule collision. | None
`projectileRadius (Number, read/write)` | RV | Radius of the projectile’s capsule collision | None
`projectileBounceCount (Integer, read/write)` | RV | Number of times the projectile will bounce before it’s destroyed. Each bounce generates an interaction event. | None
`projectilePierceCount (Integer, read/write)` | RV | Number of objects that will be pierced by the projectile before it’s destroyed. Each pierce generates an interaction event. | None
`maxAmmo (Integer, read/write)` | RV | How much ammo the Weapon starts with and its max capacity. If set to -1 then the Weapon has infinite capacity and doesn’t need to reload. | None
`currentAmmo (Integer, read/write)` | RV | Current amount of ammo stored in this Weapon. | None
`ammoType (String, read/write)` | RV | A unique identifier for the ammunition type. | None
`isAmmoFinite (bool, read/write)` | RV | Determines where the ammo comes from. If True, then ammo will be drawn from the Player’s Resource inventory and reload will not be possible until the Player acquires more ammo somehow. If False, then the Weapon simply reloads to full and inventory Resources are ignored. | None
`outOfAmmoSoundId (String, read/write)` | RV | Asset reference for a sound effect to be played when the weapon tries to activate, but is out of ammo. | None
`reloadSoundId (String, read/write)` | RV | Asset reference for a sound effect to be played when the weapon reloads ammo. | None
`spreadMin (Number, read/write)` | RV | Smallest size in degrees for the Weapon’s cone of probability space to fire projectiles in. | None
`spreadMax (Number, read/write)` | RV | Largest size in degrees for the Weapon’s cone of probability space to fire projectiles in. | None
`spreadAperture (Number, read/write)` | RV | The surface size from which shots spawn. An aperture of zero means shots originate from a single point. | None
`spreadDecreaseSpeed (Number, read/write)` | RV | Speed at which the Spread contracts back from it’s current value to the minimum cone size. | None
`spreadIncreasePerShot (Number, read/write)` | RV | Amount the Spread increases each time the Weapon attacks. | None
`spreadPenaltyPerShot (Number, read/write)` | RV | Cumulative penalty to the Spread size for successive attacks. Penalty cools off based on spreadDecreaseSpeed. | None

Event | Return Value | Description | Tags
--- | --- | --- | ---
`targetInteractionEvent (Event<WeaponInteraction>, read-only)` | RV | An event fired when a Weapon interacts with something. E.g. a shot hits a wall. The WeaponInteraction parameter contains information such as which object was hit, who owns the weapon, which ability was involved in the interaction, etc. | Read-Only
`projectileSpawnedEvent (Event<Weapon, Projectile>, read-only)` | RV | An event fired when a Weapon spawns a projectile. | Read-Only

Function | Return Value | Description | Tags
--- | --- | --- | ---
`(bool) HasAmmo()` | RV | Informs whether the Weapon is able to attack or not. | None
`Attack(target)` | RV | Triggers the main ability of the weapon. Optional target parameter can be a Vector3 world position, a Player, or a CoreObject. | None

Property | Return Value | Description | Tags
--- | --- | --- | ---
`isReticleEnabled (bool, read/write)` | RV | If True, the reticle will appear when this Weapon is equipped. | None
`attackCooldownDuration (Number, read/write)` | RV | Interval between separate burst sequences. | None
`multiShotCount (Integer, read/write)` | RV | Number of projectiles/hitscans that will fire simultaneously inside the spread area each time the Weapon attacks. Does not affect the amount of ammo consumed per attack. | None
`burstCount (Integer, read/write)` | RV | Number of automatic activations of the weapon that generally occur in quick succession. | None
`shotsPerSecond (Number, read/write)` | RV | Used in conjunction with burst_count to determine the interval between automatic weapon activations. | None
`shouldBurstStopOnRelease (bool, read/write)` | RV | If True, a burst sequence can be interrupted by the player by releasing the action button. If False, the burst continues firing automatically until it completes or the weapon runs out of ammo. | None
`isHitscan (bool, read/write)` | RV | If False, the weapon will produce simulated projectiles. If true, it will instead use instantaneous line traces to simulate shots. | None
`range (Number, read/write)` | RV | Max travel distance of the projectile (is_hitscan = False) or range of the line trace (is_hitscan = True). | None
`projectileTemplateId (String, read/write)` | RV | Asset reference for the visual body of the projectile, for non-hitscan weapons. | None
`muzzleFlashTemplateId (String, read/write)` | RV | Asset reference for a VFX to be attached to the muzzle point each time the weapon attacks. | None
`trailTemplateId (String, read/write)` | RV | Asset reference for a trail VFX to follow the trajectory of the shot. | None
`beamTemplateId (String, read/write)` | RV | Asset reference for a beam VFX to be placed along the trajectory of the shot. Useful for hitscan weapons or very fast projectiles. | None
`impactSurfaceTemplateId (String, read/write)` | RV | Asset reference of a VFX to be attached to the surface of any Core Objects hit by the attack. | None
`impactProjectileTemplateId (String, read/write)` | RV | Asset reference of a VFX to be spawned at the interaction point. It will be aligned with the trajectory. If the impacted object is a Core Object, then the VFX will attach to it as a child. | None
`impactPlayerTemplateId (String, read/write)` | RV | Asset reference of a VFX to be spawned at the interaction point, if the impacted object is a player. | None
`projectileSpeed (Number, read/write)` | RV | Travel speed (cm/s) of projectiles spawned by this weapon. | None
`projectileLifeSpan (Number, read/write)` | RV | Duration of projectiles. After which they are destroyed. | None
`projectileGravity (Number, read/write)` | RV | Gravity scale applied to spawned projectiles. | None
`projectileLength (Number, read/write)` | RV | Length of the projectile’s capsule collision. | None
`projectileRadius (Number, read/write)` | RV | Radius of the projectile’s capsule collision | None
`projectileBounceCount (Integer, read/write)` | RV | Number of times the projectile will bounce before it’s destroyed. Each bounce generates an interaction event. | None
`projectilePierceCount (Integer, read/write)` | RV | Number of objects that will be pierced by the projectile before it’s destroyed. Each pierce generates an interaction event. | None
`maxAmmo (Integer, read/write)` | RV | How much ammo the Weapon starts with and its max capacity. If set to -1 then the Weapon has infinite capacity and doesn’t need to reload. | None
`currentAmmo (Integer, read/write)` | RV | Current amount of ammo stored in this Weapon. | None
`ammoType (String, read/write)` | RV | A unique identifier for the ammunition type. | None
`isAmmoFinite (bool, read/write)` | RV | Determines where the ammo comes from. If True, then ammo will be drawn from the Player’s Resource inventory and reload will not be possible until the Player acquires more ammo somehow. If False, then the Weapon simply reloads to full and inventory Resources are ignored. | None
`outOfAmmoSoundId (String, read/write)` | RV | Asset reference for a sound effect to be played when the weapon tries to activate, but is out of ammo. | None
`reloadSoundId (String, read/write)` | RV | Asset reference for a sound effect to be played when the weapon reloads ammo. | None
`spreadMin (Number, read/write)` | RV | Smallest size in degrees for the Weapon’s cone of probability space to fire projectiles in. | None
`spreadMax (Number, read/write)` | RV | Largest size in degrees for the Weapon’s cone of probability space to fire projectiles in. | None
`spreadAperture (Number, read/write)` | RV | The surface size from which shots spawn. An aperture of zero means shots originate from a single point. | None
`spreadDecreaseSpeed (Number, read/write)` | RV | Speed at which the Spread contracts back from it’s current value to the minimum cone size. | None
`spreadIncreasePerShot (Number, read/write)` | RV | Amount the Spread increases each time the Weapon attacks. | None
`spreadPenaltyPerShot (Number, read/write)` | RV | Cumulative penalty to the Spread size for successive attacks. Penalty cools off based on spreadDecreaseSpeed. | None
