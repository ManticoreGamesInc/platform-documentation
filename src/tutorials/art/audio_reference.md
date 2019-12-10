---
name: Audio Reference
categories:
    - Reference
---

# Audio in CORE

!!! warning
    Flagged for Review.
    Incomplete or outdated information may be present.

## Overview

With CORE™, there is a massive, in-built library of high quality background music, sound effects, and instruments for a variety of genres and moods. You can drag and drop an Audio CoreObject from the **CORE Content** tab and customize its properties, which is also exposed for use in Lua scripts.

When a player makes an action like jumping or running in CORE, sound effects (like grunts or footsteps) play by default in the client. There are currently 1000+ sfx, music, and instrument assets for you to create any soundscape you want. The properties you can edit on audio assets allow for you to morph sounds. Most sounds are dynamically produced, meaning you do not have to worry about repeating sounds sounding monotonous and robotic. For example, the gunshot sounds will never sound the exact same every time and footstep sound effects also change depending on whether a character is running over water or brick.

### How to Play Audio

![Audio Preview](../../img/EditorManual/Art/AudioPreview.png "Audio Preview"){: .center}

To preview the raw sound file, you can preview audio by pressing the blue play button to the top right. If you check the button for "SFX On" to the right, you will hear a preview of the audio from your camera position in 3D space with your customized parameters.

Alternatively, you can activate audio at any time via script access with the audio function `:Play`. For example, when a player interacts with a doorbell, you may want to activate a bell SFX in a Trigger's script. In such a case, you may want to reference the audio with a "CoreObject Reference" custom property or as a child of a script.

### Audio Properties

![Audio Properties](../../img/EditorManual/Art/AudioProperties.png "Audio Properties"){: .center}

There are several customizable properties to any audio asset. Some of the most often used properties include "Autoplay" which can be used to automatically play a sound upon object spawn. The Transient flag is great for cleaning up a sound after it spawns and finishes playing. Suggested use is at level start or in templates for one-time sounds such as when spawning objects.

You can customize how the audio sounds in an environment with control over spatialization, attenuation, and occlusion. Distance parameters for radius/falloff are given in units of centimeters, so 100 is 1 meter. Radius and falloff values of approximately 2000 are a good starting point for room-scale sounds.

!!! note
    While some audio properties can be applied while sounds are playing (such as the audio properties `volume` and `pitch`), others (such as `isSpatializationEnabled`) require the sound to be stopped and restarted to take effect.

### Audio Networking

By default, playback will be networked to all clients. If an Audio object is simply placed in the scene and played, any connected clients within range also hear the sound playing. For client-specific playback, place the Audio object in a Client NetworkContext folder. In such a case, playback would be started by a client script, and different sounds could be heard on each client. Example use case: victory music only playing for the winning team.
