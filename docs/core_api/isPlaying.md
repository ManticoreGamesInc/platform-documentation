# isPlaying

###### [Classes](core_api/raw_source) > [Audio](core_api/audio)

### Description

Returns whether the [Audio](core_api/audio) [CoreObject](core_api/CoreObject) is currently playing.

### Notes
!!! info
    isPlaying is a property of [audio](core_api/audio) that returns a boolean.

### Syntax

`.isPlaying`

### Example

[Live example]()

```lua
--[[ Main.lua ]]--

-- drag the "Ambience Suburbs Night Crickets 01 SFX" into the hierarchy --

local cricketsSFX = game:FindObjectByName("Ambience Suburbs Night Crickets 01 SFX")
cricketsSFX:Play()
Task.Wait(3)
print_to_screen(tostring(cricketsSFX.isPlaying))
-- prints "true" in the Event Log window --

Task.Wait(3)
cricketsSFX:Stop()
print_to_screen(tostring(cricketsSFX.isPlaying))
-- prints "false" in the Event Log window --


```

### See Also

* [Classes.Audio]()
