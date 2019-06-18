# length

###### [Classes](core_api/raw_source) > [Audio](core_api/classes/audio)

### Description

Returns the length (in seconds) of the sound.

### Notes
!!! info
  This audio property is a read-only float.

### Syntax

`.length`

### Example

[Live example]()

```lua
--[[ Main.lua ]]--

-- drag the audio "Ambience Suburbs Night Crickets 01 SFX" into the hierarchy --

local cricketsSFX = game:FindObjectByName("Ambience Suburbs Night Crickets 01 SFX")
cricketsSFX:Play()
print_to_screen("This sound effect will play for " .. tostring(cricketsSFX.length) .. " seconds.")
-- will print ~52.196 seconds in the Event Log window --

```

### See Also

* [Classes.Audio]()
