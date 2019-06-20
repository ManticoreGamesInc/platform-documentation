# isSpatializationDisabled

###### [Classes](/core_api/raw_source) > [Audio](/core_api/classes/audio/AudioOverview)

### Description

Default false. Set true to play [Audio](/core_api/classes/audio/AudioOverview) without 3D positioning.

### Notes
!!! info
    This audio property is a read/write, dynamic boolean.

### Syntax

`.isSpatializationDisabled`

### Example

```lua
--[[ audioExample.lua ]]--

-- drag the audio "Ambience Suburbs Night Crickets 01 SFX" into the hierarchy --

local cricketsSFX = game:FindObjectByName("Ambience Suburbs Night Crickets 01 SFX")
print_to_screen("Spatialization is enabled by default.")
print_to_screen("Try walking away from the audio source!")
cricketsSFX:Play()

Task.Wait(4)
print_to_screen("The further away you are, the more distant the crickets sound...")
Task.Wait(4)
cricketsSFX:Stop()

cricketsSFX.isSpatializationDisabled = true
print_to_screen("Spatialization has been disabled.")
cricketsSFX:Play()
print_to_screen("Now, regardless of where you are in 3D space, you can hear the crickets!")

```

### See Also

* [Classes.Audio](/core_api/classes/audio/AudioOverview)
