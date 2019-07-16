# Stop()

###### [Classes](/core_api/raw_source) > [Audio](/core_api/classes/audio/AudioOverview))

### Description

Stops the [Audio](core_api/classes/audio/AudioOverview) playback.

### Notes
!!! info
    None

### Syntax

`:Stop()`

### Example

```lua
-- audioExample.lua --
-- drag the audio "Ambience Suburbs Night Crickets 01 SFX" into the hierarchy --

local cricketsSFX = game:FindObjectByName("Ambience Suburbs Night Crickets 01 SFX")
cricketsSFX:Play()
print_to_screen("The crickets will stop chirping after 3 seconds!")
Task.Wait(3)
cricketsSFX:Stop()

```

### See Also

* [Classes.Audio](/core_api/classes/audio/AudioOverview)
