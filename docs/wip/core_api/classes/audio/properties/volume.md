# volume

###### [Classes](/core_api/raw_source) > [Audio](/core_api/classes/audio/AudioOverview)

### Description

Multiplies the playback volume of the [Audio](core_api/classes/audio/AudioOverview).
Default 1. Note that values above 1 can distort sound. When balancing sound, it is recommended to scale down rather than up.


### Notes
!!! info
    This audio property is a read/write float.

### Syntax

`.volume`

### Example

```lua
-- audioExample.lua --
-- drag the audio "Ambience Suburbs Night Crickets 01 SFX" into the hierarchy --

local cricketsSFX = game:FindObjectByName("Ambience Suburbs Night Crickets 01 SFX")
print_to_screen("The cricket SFX volume is " .. tostring(cricketsSFX.volume) .. ", by default.")
cricketsSFX:Play()
Task.Wait(5)
cricketsSFX:Stop()
Task.Wait(1)

cricketsSFX.volume = 0.5
print_to_screen("The cricket SFX volume has been lowered to " .. tostring(cricketsSFX.volume) .. ".")
cricketsSFX:Play()
Task.Wait(5)
cricketsSFX:Stop()

```

### See Also

* [Classes.Audio](/core_api/classes/audio/AudioOverview)
