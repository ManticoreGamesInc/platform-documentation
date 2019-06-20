# falloff

###### [Classes](/core_api/raw_source) > [Audio](/core_api/classes/audio))

### Description

If non-zero, will override default 3D spatial parameters of the [Audio](/core_api/classes/audio). Falloff is the distance outside the radius over which the sound volume will gradually fall to zero. Default 0 (off).


### Notes
!!! info
    This audio property is a read/write float.

### Syntax

`.falloff`

### Example

```lua
--[[ audioExample.lua ]]--

-- drag the audio "Ambience Suburbs Night Crickets 01 SFX" into the hierarchy --

local cricketsSFX = game:FindObjectByName("Ambience Suburbs Night Crickets 01 SFX")
cricketsSFX:Play()
print_to_screen("The cricket SFX's falloff is currently " .. tostring(cricketsSFX.falloff) .. ".")
Task.Wait(1)

print_to_screen("Try walking past the 100% volume radius into the falloff area!")
Task.Wait(8)
cricketsSFX:Stop()
Task.Wait(1)

cricketsSFX.radius = cricketsSFX.radius * 5
print_to_screen("The cricket SFX's falloff has increased! Try walking further away!")
print_to_screen("The cricket SFX's falloff is currently " .. tostring(cricketsSFX.falloff) .. ".")
cricketsSFX:Play()
Task.Wait(5)
cricketsSFX:Stop()

```

### See Also

* [Classes.Audio](/core_api/classes/audio)
