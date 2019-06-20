# isAutoPlayEnabled

###### [Classes](/core_api/raw_source) > [Audio](/core_api/classes/audio)

### Description

Default false. If set to true when placed in the editor (or included in a template), the [Audio](/core_api/classes/audio) will be automatically played when loaded.

### Notes
!!! info
    This audio property is a read-only boolean.

### Syntax

`.isAutoPlayEnabled`

### Example

```lua
--[[ audioExample.lua ]]--

-- drag the audio "Ambience Suburbs Night Crickets 01 SFX" into the hierarchy --

local cricketsSFX = game:FindObjectByName("Ambience Suburbs Night Crickets 01 SFX")
print_to_screen("Cricket SFX Autoplay is currently " .. tostring(cricketsSFX.isAutoPlayEnabled) .. ".")

if (cricketsSFX.isAutoPlayEnabled == false) then
	print_to_screen("Try checking Auto Play in the audio properties!")
end

```

### See Also

* [Classes.Audio](/core_api/classes/audio)
