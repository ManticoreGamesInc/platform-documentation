# isPlaying

###### [Classes](/core_api/raw_source) > [Audio](/core_api/classes/audio/AudioOverview)

### Description

Returns whether the [Audio](/core_api/classes/audio/AudioOverview) [CoreObject](/core_api/classes/coreobject) is currently playing.

### Notes
!!! info
    This audio property a read-only boolean.

### Syntax

`.isPlaying`

### Example

```lua
--[[ audioExample.lua ]]--

-- drag the audio "Ambience Suburbs Night Crickets 01 SFX" into the hierarchy --

local cricketsSFX = game:FindObjectByName("Ambience Suburbs Night Crickets 01 SFX")
cricketsSFX:Play()
Task.Wait(3)
print(tostring(cricketsSFX.isPlaying))
-- will print "true" in the Event Log window --

Task.Wait(3)
cricketsSFX:Stop()
print(tostring(cricketsSFX.isPlaying))
-- will print "false" in the Event Log window --


```

### See Also

* [Classes.Audio](/core_api/classes/audio/AudioOverview)
