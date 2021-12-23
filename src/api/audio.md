---
id: audio
name: Audio
title: Audio
tags:
    - API
---

# Audio

Audio is a CoreObject that wrap sound files. Most properties are exposed in the UI and can be set when placed in the editor, but some functionality (such as playback with fade in/out) requires Lua scripting.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `isPlaying` | `boolean` | Returns if the sound is currently playing. | Read-Only |
| `length` | `number` | Returns the length (in seconds) of the Sound. | Read-Only |
| `currentPlaybackTime` | `number` | Returns the playback position (in seconds) of the sound. | Read-Only |
| `isSpatializationEnabled` | `boolean` | Default true. Set to false to play sound without 3D positioning. | Read-Write |
| `isAttenuationEnabled` | `boolean` | Default true, meaning sounds will fade with distance. | Read-Write |
| `isOcclusionEnabled` | `boolean` | Default true. Changes attenuation if there is geometry between the player and the audio source. | Read-Write |
| `isAutoPlayEnabled` | `boolean` | Default false. If set to true when placed in the editor (or included in a template), the sound will be automatically played when loaded. | Read-Only |
| `isTransient` | `boolean` | Default false. If set to true, the sound will automatically destroy itself after it finishes playing. | Read-Write |
| `isAutoRepeatEnabled` | `boolean` | Loops when playback has finished. Some sounds are designed to automatically loop, this flag will force others that don't. Useful for looping music. | Read-Write |
| `pitch` | `number` | Default 1. Multiplies the playback pitch of a sound. Note that some sounds have clamped pitch ranges (0.2 to 1). | Read-Write |
| `volume` | `number` | Default 1. Multiplies the playback volume of a sound. Note that values above 1 can distort sound, so if you're trying to balance sounds, experiment to see if scaling down works better than scaling up. | Read-Write |
| `radius` | `number` | Default 0. If non-zero, will override default 3D spatial parameters of the sound. Radius is the distance away from the sound position that will be played at 100% volume. | Read-Write |
| `falloff` | `number` | Default 0. If non-zero, will override default 3D spatial parameters of the sound. Falloff is the distance outside the radius over which the sound volume will gradually fall to zero. | Read-Write |
| `fadeInTime` | `number` | Sets the fade in time for the audio. When the audio is played, it will start at zero volume, and fade in over this many seconds. | Read-Write |
| `fadeOutTime` | `number` | Sets the fadeout time of the audio. When the audio is stopped, it will keep playing for this many seconds, as it fades out. | Read-Write |
| `startTime` | `number` | The start time of the audio track. Default is 0. Setting this to anything else means that the audio will skip ahead that many seconds when played. | Read-Write |
| `stopTime` | `number` | The stop time of the audio track. Default is 0. A positive value means that the audio will stop that many seconds from the start of the track, including any fade out time. | Read-Write |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Play()` | `None` | Begins sound playback. | None |
| `Stop()` | `None` | Stops sound playback. | None |
| `FadeIn(number time)` | `None` | Starts playing and fades in the sound over the given time. | None |
| `FadeOut(number time)` | `None` | Fades the sound out and stops over time seconds. | None |

## Examples

Example using:

### `Play`

In this example, a small script is placed as the child of an audio object in the hierarchy. After a 3 second wait we play the sound. For best results place audio objects inside a client context.

```lua
local SFX = script.parent

Task.Wait(3)

SFX:Play()
```

See also: [CoreObject.parent](coreobject.md) | [Task.Wait](task.md)

---

Example using:

### `Play`

### `Stop`

### `FadeIn`

### `FadeOut`

### `isPlaying`

In this example, a random song from a folder containing a list of songs is picked and played for 10 seconds before another song is picked at random.

```lua
-- Client script

-- The folder containing a list of songs to pick from.
local musicFolder = script:GetCustomProperty("music"):WaitForObject()

-- The time a song is allowed to player for.
local allowedPlayTime = 10

-- If the song should fade in and out.
local fadeInOut = true

-- Duration of the fade in and out.
local fadeInTime = 1
local fadeOutTime = 1

local songs = musicFolder:GetChildren()
local current

local totalPlayTime = 0

-- Attempt to find a song that wasn't played previously.
local function GetRandomSong()
    local song

    if current == nil then
        song = songs[math.random(1, #songs)]
    else
        if #songs == 1 then
            song = songs[1]
        else
            repeat
                song = songs[math.random(1, #songs)]
            until song ~= current
        end
    end

    return song
end

local function PlaySong()
    if current ~= nil then
        if fadeInOut then
            current:FadeOut(fadeOutTime)
        else
            current:Stop()
        end
    end

    totalPlayTime = 0
    current = GetRandomSong()

    if fadeInOut then
        current:FadeIn(fadeInTime)
    else
        current:Play()
    end
end

-- Keep track of how long the song has been playing for.
function Tick(dt)
    if current ~= nil then
        if totalPlayTime > allowedPlayTime then
            PlaySong()
        else
            if not current.isPlaying then
                totalPlayTime = 0
            else
                totalPlayTime = totalPlayTime + dt
            end
        end
    end
end

PlaySong()
```

See also: [CoreObject.GetCustomProperty](coreobject.md) | [CoreLua.Tick](coreluafunctions.md)

---

Example using:

### `pitch`

### `isPlaying`

### `Play`

In this client script the pitch of a piano note is modified over time to give it a vibrato-like effect.

```lua
local SFX = script:GetCustomProperty("PianoSampledInstrument01"):WaitForObject()
local PITCH_CHANGE = 200
local DURATION = 0.25
local elapsedTime = 0

function PlayWithLinearVibrato()
    SFX.pitch = 0
    SFX:Play()
    elapsedTime = 0
end

function Tick(deltaTime)
    if SFX.isPlaying and elapsedTime < DURATION then
        elapsedTime = elapsedTime + deltaTime
        if elapsedTime > DURATION then
            elapsedTime = DURATION
        end
        -- Linear modification of pitch over time
        SFX.pitch = PITCH_CHANGE * elapsedTime / DURATION
        print("pitch = " .. SFX.pitch)
    end
end

Task.Wait(1)
PlayWithLinearVibrato()
```

See also: [CoreObject.GetCustomProperty](coreobject.md) | [CoreObjectReference.WaitForObject](coreobjectreference.md) | [CoreLua.Tick](coreluafunctions.md) | [Task.Wait](task.md)

---

Example using:

### `volume`

In this example, two UI buttons are setup to control the volume of a music object. The script is placed as a child of the music object and the buttons are added to the script as custom properties.

```lua
local MUSIC = script.parent
local PLUS_BUTTON = script:GetCustomProperty("PlusButton"):WaitForObject()
local MINUS_BUTTON = script:GetCustomProperty("MinusButton"):WaitForObject()

MUSIC:Play()

function IncreaseVolume()
    MUSIC.volume = MUSIC.volume + 0.1
end

function DecreaseVolume()
    MUSIC.volume = MUSIC.volume - 0.1
end

PLUS_BUTTON.clickedEvent:Connect(IncreaseVolume)
MINUS_BUTTON.clickedEvent:Connect(DecreaseVolume)
```

See also: [UIButton.clickedEvent](uibutton.md) | [CoreObject.parent](coreobject.md)

---
