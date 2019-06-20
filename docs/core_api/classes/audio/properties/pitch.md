# pitch

###### [Classes](/core_api/raw_source) > [Audio](/core_api/classes/audio)

### Description

Multiplies the playback pitch of the [Audio](/core_api/classes/audio).
Default 1. Note that some sounds have clamped pitch ranges (so 0.2-1 will work, above 1 might not.)

### Notes
!!! info
    This audio property is a read/write float.

### Syntax

`.pitch`

### Example

```lua
--[[ audioExample.lua ]]--

-- drag the audio "Ambience Suburbs Night Crickets 01 SFX" into the hierarchy --

local cricketsSFX = game:FindObjectByName("Ambience Suburbs Night Crickets 01 SFX")
print_to_screen("The cricket SFX pitch is " .. tostring(cricketsSFX.pitch) .. ", by default.")
cricketsSFX:Play()
Task.Wait(5)
cricketsSFX:Stop()

cricketsSFX.pitch = 0.8
print_to_screen("The cricket SFX pitch has been lowered to " .. tostring(cricketsSFX.pitch) .. ".")
cricketsSFX:Play()
Task.Wait(5)
cricketsSFX:Stop()

```

### See Also

* [Classes.Audio](/core_api/classes/audio)
