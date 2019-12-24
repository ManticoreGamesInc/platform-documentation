# Patch Notes

## Alpha Update 1: December 17th 2019

#### New Features

- Block indent was added to the script editor.
- Added advanced grenade and update advanced weapon reload binding.
- Added View->Reset Layout menu item for using default tab layout for editor.
- Added a Publish Template button to Project Content.
- The events `Event:Connect()`, `Events.Connect()`, and `Events.ConnectForPlayer` now accept any number of additional arguments after the listener function. When that listener is called, those additional arguments will be provided after the event's own parameters.

Example:

```lua
local function OnHandleOverlap(trigger, other, extraArg)
    print(extraArg)
end
script.parent.beginOverlapEvent:Connect(OnHandleOverlap, "Hello")
script.parent.endOverlapEvent:Connect(OnHandleOverlap, "World!")
```

#### Changes

- Moving the mouse or using the keyboard now resets the autosave timer.
- `Player.isDead` Lua property is now read-only.
- Removed "Add Script" button from Project Content.
- Abilities no longer have an option to toggle Flying mode.
- New projects are now saved directly in the Maps folder, instead of in "Maps/username".
- Edgeline materials now use `Vector3` instead of `Color` for setting material velocity.
- When spawning objects with X key, the Shift modifier is now interpreted as "use settings from Object Generator", which now takes "Spawn Upright" into account.

#### Fixes

- Explosion effect now properly makes use of color parameter.
- Fixed a bug in the selection system that was sometimes making the "audio preview" button not show up after testing a map.
- Fix for the crash that happened when you used portals between games.
- When previewing audio in the editor, adjusting settings will now update the sound in real time, rather than making it stop playing.
- Fix "Character data unavailable" error when exiting preview mode.
- UI tweaks for modals giving information about non-uniform scaling.
- Window styling fixes for terrain generation/importing.
- Limit possible request count when using `UIImage:SetImage()` in certain cases.
- Fixed a crash when dragging SmartAudio assets into the scene.
- Script Editor: Fixed bug where autocomplete popup would lose its selected candidate.
- Script Editor: Fix unnecessary save prompt triggered by unix or mac line endings.
- Fixed the height of the "More Options" menu (seen when pressing the three dots on a game tile on the "Create" tab).
- Frontend "Games" button should take you to your game page, not the home page.
