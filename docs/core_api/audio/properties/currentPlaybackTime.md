# currentPlaybackTime

###### [Classes](core_api/raw_source) > [Audio](core_api/classes/audio)

### Description

Returns the playback position (in seconds) of the [Audio](core_api/classes/audio).

### Notes
!!! info
  This audio property is a read-only float.

### Syntax

`.currentPlaybackTime`

### Example

[Live example]()

```lua
--[[ Main.lua ]]--

-- drag the audio "Ambience Suburbs Night Crickets 01 SFX" into the hierarchy --

local cricketsSFX = game:FindObjectByName("Ambience Suburbs Night Crickets 01 SFX")
cricketsSFX:Play()
Task.Wait(3)
print("The cricket SFX has been playing for " .. tostring(cricketsSFX.currentPlaybackTime) .. " seconds.")
-- will print ~3 seconds in the Event Log window --

```

### See Also

* [Classes.Audio]()
