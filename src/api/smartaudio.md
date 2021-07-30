---
id: smartaudio
name: SmartAudio
title: SmartAudio
tags:
    - API
---

# SmartAudio

SmartAudio objects are SmartObjects that wrap sound files. Similar to Audio objects, they have many of the same properties and functions.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `isPlaying` | `boolean` | Returns if the sound is currently playing. | Read-Only |
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

## Tutorials

[Audio in Core](../references/audio.md)
