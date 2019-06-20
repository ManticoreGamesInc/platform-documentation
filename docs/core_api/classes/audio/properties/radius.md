# radius

###### [Classes](/core_api/raw_source) > [Audio](/core_api/classes/audio)

### Description

If non-zero, will override default 3D spatial parameters of the [Audio](/core_api/classes/audio). Radius is the distance away from the sound position that will be played at 100% volume. Default 0 (off).


### Notes
!!! info
    This audio property is a read/write float.

### Syntax

`.radius`

### Example

```lua
--[[ audioExample.lua ]]--

-- drag the audio "Ambience Suburbs Night Crickets 01 SFX" into the hierarchy --

local cricketsSFX = game:FindObjectByName("Ambience Suburbs Night Crickets 01 SFX")
cricketsSFX:Play()
print_to_screen("The cricket SFX's radius is currently " .. tostring(cricketsSFX.radius) .. ".")
Task.Wait(1)

print_to_screen("Try walking away!")
Task.Wait(5)
cricketsSFX:Stop()
Task.Wait(1)

cricketsSFX.radius = cricketsSFX.radius * 5
print_to_screen("The cricket SFX radius has increased!")
print_to_screen("You can hear it now from " .. tostring(cricketsSFX.radius) .. " units away.")
cricketsSFX:Play()
Task.Wait(5)
cricketsSFX:Stop()

```

### See Also

* [Classes.Audio](/core_api/classes/audio)
