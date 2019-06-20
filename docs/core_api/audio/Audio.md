# Audio

###### [Classes](core_api/raw_source)

### Description

Audio objects are [CoreObjects](core_api/classes/coreobject) that wrap sound files. Most properties are exposed in the UI and can be set when placed in the editor, but some functionality (such as playback with fade in/out) requires Lua scripting.

While some audio properties can be applied while sounds are playing (such as volume and pitch), others (for example, spatial properties) require the sound to be stopped and restarted to take effect.
By default, playback will be networked. If an Audio object is simply placed in the scene and played, any connected clients within range also hear the sound playing.

Autoplay and Transient flags can be used to automatically play and clean-up a sound when spawned. Suggested use is at level start or in templates for one-time sounds such as when spawning objects - and you don't have to worry about any cleanup.
Attenuation distance is to the camera, not the player character. Distance parameters for radius / falloff are given in units of centimeters, so 100 is 1 meter. Radius and Falloff values of approximately 2000 may be a good starting point for room-scale sounds.

### Notes
!!! info
    Audio is a [CoreObject](core_api/classes/coreobject) class. For client-specific playback, place the Audio object in a client NetworkContext folder. Playback can then be started by a client script with different sounds on each client. Example use case: victory music only playing for the winning team. See also: the [Replicator](core_api/classes/replicator).

### Properties

* [isPlaying](core_api/classes/audio/properties/isPlaying)
* [length](core_api/classes/audio/properties/length)
* [currentPlaybackTime](core_api/classes/audio/properties/currentPlaybackTime)
* [isSpatializationDisabled](core_api/classes/audio/properties/isSpatializationDisabled)
* [isAutoPlayEnabled](core_api/classes/audio/properties/isAutoPlayEnabled)
* [isTransient](core_api/classes/audio/properties/isTransient)
* [isAutoRepeatEnabled](core_api/classes/audio/properties/isAutoRepeatEnabled)
* [pitch](core_api/classes/audio/properties/pitch)
* [volume](core_api/classes/audio/properties/volume)
* [radius](core_api/classes/audio/properties/radius)
* [falloff](core_api/classes/audio/properties/falloff)

### Functions

* [Play](core_api/classes/audio/functions/play)
* [Stop](core_api/classes/audio/functions/stop)
* [FadeIn](core_api/classes/audio/functions/fadein)
* [FadeOut](core_api/classes/audio/functions/fadeout)
