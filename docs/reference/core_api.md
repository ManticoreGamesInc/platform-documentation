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


### Replicators(/core_api/classes/replicators/ReplicatorsOverview)

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


### ButtonUIControl(/core_api/classes/buttonUIControl/buttonUIControlOverview)

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


### CameraSettings(/core_api/classes/camerasettings/cameraSettingsOverview)

CameraSettings is a [CoreObject](/core_api/classes/coreobject) which can be used to configure camera settings for a Player.

#### Functions

Function | Return Value | Description | Tags
--- | --- | --- | ---
`ApplyToPlayer(Player)` | None | Apply settings from this settings object to player. | Server-Only
