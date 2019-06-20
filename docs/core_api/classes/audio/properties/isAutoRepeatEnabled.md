# isAutoRepeatEnabled

###### [Classes](/core_api/raw_source) > [Audio](/core_api/classes/audio)

### Description

Loops when [Audio](/core_api/classes/audio) playback has finished.

### Notes
!!! info
    This audio property is a read/write boolean.

### Syntax

`.isTransient`

### Example

```lua
--[[ audioExample.lua ]]--

-- drag the audio "Bullet Body Impact SFX --

local bulletSFX = game:FindObjectByName("Bullet Body Impact SFX")
print_to_screen("Audio is, by default, not transient.")
bulletSFX:Play()
print_to_screen("The bullet SFX can still be found in the hierarchy!")

Task.Wait(5)
bulletSFX.isTransient = true
print_to_screen("The audio is now transient and will destroy itself after finishing.")
bulletSFX:Play()
print_to_screen("The bullet SFX has been deleted!")


```

### See Also

* [Classes.Audio](/core_api/classes/audio)
