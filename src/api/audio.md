---
id: audio
name: Audio
title: Audio
tags:
    - API
---

# API: Audio

## Description

Audio is a CoreObject that wrap sound files. Most properties are exposed in the UI and can be set when placed in the editor, but some functionality (such as playback with fade in/out) requires Lua scripting.

## API

### Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `isPlaying` | `bool` | Returns if the sound is currently playing. | Read-Only |
| `length` | `Number` | Returns the length (in seconds) of the Sound. | Read-Only |
| `currentPlaybackTime` | `Number` | Returns the playback position (in seconds) of the sound. | Read-Only |
| `isSpatializationEnabled` | `bool` | Default true. Set to false to play sound without 3D positioning. | Read-Write |
| `isAttenuationEnabled` | `bool` | Default true, meaning sounds will fade with distance. | Read-Write |
| `isOcclusionEnabled` | `bool` | Default true. Changes attenuation if there is geometry between the player and the audio source. | Read-Write |
| `isAutoPlayEnabled` | `bool` | Default false. If set to true when placed in the editor (or included in a template), the sound will be automatically played when loaded. | Read-Only |
| `isTransient` | `bool` | Default false. If set to true, the sound will automatically destroy itself after it finishes playing. | Read-Write |
| `isAutoRepeatEnabled` | `bool` | Loops when playback has finished. Some sounds are designed to automatically loop, this flag will force others that don't. Useful for looping music. | Read-Write |
| `pitch` | `Number` | Default 1. Multiplies the playback pitch of a sound. Note that some sounds have clamped pitch ranges (0.2 to 1). | Read-Write |
| `volume` | `Number` | Default 1. Multiplies the playback volume of a sound. Note that values above 1 can distort sound, so if you're trying to balance sounds, experiment to see if scaling down works better than scaling up. | Read-Write |
| `radius` | `Number` | Default 0. If non-zero, will override default 3D spatial parameters of the sound. Radius is the distance away from the sound position that will be played at 100% volume. | Read-Write |
| `falloff` | `Number` | Default 0. If non-zero, will override default 3D spatial parameters of the sound. Falloff is the distance outside the radius over which the sound volume will gradually fall to zero. | Read-Write |
| `fadeInTime` | `Number` | Sets the fade in time for the audio.  When the audio is played, it will start at zero volume, and fade in over this many seconds. | Read-Write |
| `fadeOutTime` | `Number` | Sets the fadeout time of the audio.  When the audio is stopped, it will keep playing for this many seconds, as it fades out. | Read-Write |
| `startTime` | `Number` | The start time of the audio track. Default is 0. Setting this to anything else means that the audio will skip ahead that many seconds when played. | Read-Write |
| `stopTime` | `Number` | The stop time of the audio track. Default is 0. A positive value means that the audio will stop that many seconds from the start of the track, including any fade out time. | Read-Write |

### Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Play()` | `None` | Begins sound playback. | None |
| `Stop()` | `None` | Stops sound playback. | None |
| `FadeIn(Number time)` | `None` | Starts playing and fades in the sound over the given time. | None |
| `FadeOut(Number time)` | `None` | Fades the sound out and stops over time seconds. | None |
