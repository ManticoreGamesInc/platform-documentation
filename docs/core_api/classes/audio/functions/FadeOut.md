# FadeOut(Number time)

###### [Classes](/core_api/raw_source) > [Audio](/core_api/classes/audio/AudioOverview)

### Description

Fades the [Audio](/core_api/classes/audio/AudioOverview) out and stops over time seconds.

### Notes
!!! info
    This is an [Audio](/core_api/classes/audio/AudioOverview) function that takes in a number input.

### Syntax

`:FadeOut()`

### Example

```lua
-- audioExample.lua --
-- drag the audio "Ambience Suburbs Night Crickets 01 SFX" into the hierarchy --

local cricketsSFX = game:FindObjectByName("Ambience Suburbs Night Crickets 01 SFX")
print_to_screen("This is how the crickets sound without fadeout.")
cricketsSFX:Play()
Task.Wait(5)
cricketsSFX:Stop()

print_to_screen("This is how the crickets sound with fadeout over 5 seconds!")
cricketsSFX:Play()
Task.Wait(5)
cricketsSFX:FadeOut(5)

```

### See Also

* [Classes.Audio](/core_api/classes/audio/AudioOverview)
