# FadeIn(Number time)

###### [Classes](/core_api/raw_source) > [Audio](/core_api/classes/audio/AudioOverview)

### Description

Starts playing and fades the [Audio](/core_api/classes/audio/AudioOverview) in over the given time.

### Notes
!!! info
    This is an [Audio](/core_api/classes/audio/AudioOverview) function that takes in a number input.

### Syntax

`:FadeIn()`

### Example

```lua
-- audioExample.lua --
-- drag the audio "Ambience Suburbs Night Crickets 01 SFX" into the hierarchy --

local cricketsSFX = game:FindObjectByName("Ambience Suburbs Night Crickets 01 SFX")
print_to_screen("This is how the crickets sound without fadein.")
cricketsSFX:Play()
Task.Wait(5)
cricketsSFX:Stop()

print_to_screen("This is how the crickets sound with fadein over 5 seconds!")
cricketsSFX:FadeIn(5)
Task.Wait(5)
cricketsSFX:Stop()

```

### See Also

* [Classes.Audio](/core_api/classes/audio/AudioOverview)
