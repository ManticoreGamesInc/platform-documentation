# Patch Notes

## Alpha Update 2: January 7th 2020

### Highlights
- Add community requested API to enable creators to do even more with CORE!
- Fix a ton of bugs so you can game on uninterrupted!
- Adds new content to play around with. Like, who **didn't** want Grenades and Curved Pipes? MacGyver anyone?
- Performance improvements to physics, networking and components.

### New Features

#### API

- Added `Player:SetVelocity(Vector3)`: Sets the velocity of the player to the given value.
- Added two new functions `GetLookWorldRotation()` and `SetLookWorldRotation()` to the `Player` object:
    - `GetLookWorldRotation()`: Returns the current rotation of the player's head (rotation at which the player is currently looking). Server/Client
    - `SetLookWorldRotation(Rotation newLookRotation)`: Sets the rotation at which the player should look. Can be used only on a client.
- Added `Player:GetResources()` function which returns a table containing all of the player's resource amounts. `Player:GetResourceNames()` and `Player:GetResourceNamesStartingWith()` are now deprecated.

#### Editor

- Added ability aim modes to player settings:
    - `ViewRelative`: Ability aim is calculated from the camera origin along the camera forward direction.
    - `LookRelative`: Ability aim is calculated from the player camera socket along the player look direction
- Added right click context menu to duplicate custom material and template asset in Project Content.
- Added hierarchy filter `/hasCustomParamWithWords=` which can show objects with custom parameters. It optionally takes words to match parameter names (ANDed together).
- Added `Max Allowable Slope` to Object Generator for restricting spawnable surface by angle between world up vector and surface normal.
- Added gamepad support for `Look at Cursor` mode in player movement settings.
- Added Weapon Trajectory mode property to weapons. It specifies how the weapon calculates the projectile trajectory:
    - `MuzzleToLookTarget`: The projectile is fired from the muzzle position to the target location.
    - `FollowLookVector`: The projectile is fired from the closet point on the look vector along the look direction.
    - `Custom`: The projectile is fired from the muzzle position in the direction specified by the `Muzzle Rotation` property.
- Support for creating asset reference parameters by drag-and-dropping assets onto the `Properties` tab.

#### Game Components

- Added Rocket Launcher, Grenade Launcher and Grenades.
- Thruster VFX now support using color alphas and has expanded gradient controls.
- You can now find 45-Degree Curved Pipe 3D objects in the BasicShapes folder in CORE!
- Added Resource Pickup. Can be used to give the player resources and/or heal/damage them. TODO: what is Resource Pickup exactly?
- Added a Cast Bar.
- Added a Resource Display.

### Changes

#### API

- `Player.resourceChangedEvent` now passes the modified `Resource` as an argument.
- `Player.resourceChangedEvent` is now fired after `Player.ClearResources()` is called.
- Reimplemented the following Lua functions, with minimal behavior changes:
    - `CoreObject:MoveTo()`
    - `CoreObject:MoveContinuous()`
    - `CoreObject:Follow()`
    - `CoreObject:StopMove()`
    - `CoreObject:RotateTo()`
    - `CoreObject:RotateContinuous()`
    - `CoreObject:LookAt()`
    - `CoreObject:LookAtContinuous()`
    - `CoreObject:LookAtLocalView()`
    - `CoreObject:StopRotate()`
    - `CoreObject:ScaleTo()`
    - `CoreObject:ScaleContinuous()`
    - `CoreObject:StopScale()`

All of these functions should now behave consistently in all cases. Client behavior should match the server and be smooth. A couple minor behavior changes are as follows:

- For all arguments that specify local or world space, that is now used only to interpret the values passed in to that function.
- All transforms now happen in local space.
- `RotateContinuous()` has a new overload that takes a `Vector3` interpreted as angular velocity.
- `LookAt` functions that had an option to lock the pitch component of rotation will now also lock the roll component.
- Setting the position, rotation, or scale manually will now stop any corresponding operation. For example, if you call `MoveTo()` and then `SetWorldPosition()` on the same object before `MoveTo()` has finished, it will be canceled and the object will remain at the position passed to `SetWorldPosition()`.

#### Editor

- All Effects should now properly respect the auto-play flag when effect elements are in a mixed state.
- Improved Decal performance.
- Interactable triggers that are in a static or default context now fire an interacted event on both client and server. An interactable trigger in a client context will fire interacted event on the client only. Interactable triggers will not work under a server context and will throw a warning.
- Framerate is limited to 30FPS when running in the frontend to reduce power usage and heat on laptops.
- Saving a file with a long path will report "File path too long" instead of a generic error message.
- Improved the look + feel of the terrain creator panel.
- Move handling of requesting and saving player profile data from the game runtime to player state so it can handle late arrival of a replicated IDs in a network environment and ignore unset ones so the bots won't spam in preview.
- Toggling World Space or Gizmo Visibility will show notifications.
- Enabled additional logging from Lua scripts.
- Gamepad support for `Look at Cursor` is now camera relative.
- In-game options screen title changed to `Preferences`.
- Improved UI for displaying breakpoints and current line in the Script Editor. Clicking on a line number now selects that line's text. Breakpoints may be toggled on and off by clicking the black gutter to the left of the line numbers.
- Improved drag select behavior in script editor when dragging outside the window.
- Changed pause menu options button to say `Preferences`.
- Improved wording of some Lua error messages.
- The <kbd>P</kbd> key no longer automatically binds to the pause menu.
- Networked events will now throw and error if unsupported types are passed as arguments to `Broadcast:()`.

#### Game Components

- Updated all weapons to new tunings.
- Physics objects now run on client with server correction, creating much smoother behavior.
- Reorganized structure in CORE Content so no components are hidden.
- Moved Inventory (and UI) to community content and fixed major issues (look for Basic Inventory).
- Removed Spectator Camera until jitters are fixed.

### Fixes

#### API

- Fix crash when passing `nil` as `Player` to `Equip()`.
- Fixed bug with required scripts accessing the wrong context in single-player preview mode.
- Fixed an issue that allowed client or static scripts to edit player properties or call functions that modify a player in local preview mode.

!!! warning "Projects that previously worked in local preview may now trigger errors to more closely match expected behavior in a multiplayer environment."

#### Editor

- Fixed bug with script editor marking empty scripts as modified when they weren't. Script editors should now open to the start of the script instead of the end.
- Fix publish template to remember private setting after taking a screenshot.
- Publishing `Release` and `Description` text boxes will show vertical scrollbars when needed.
- Fix publish review buttons sometimes drawing offscreen.
- Autosave should no longer get into a state where it spams messages repeatedly. Also, it no longer forces focus of the view window when an autosave message shows up.
- Fix for destroying objects that are spawned on the same frame and client context object spawning afterwards.
- Fixed stuck drag-select and orbiting during alt-click terrain edits.
- Fixed a bug where a player's kill count was incremented when they killed themselves.
- Fog Layered Density `Falloff` value now no longer has a trailing space.
- Fix bug where reparent through drag-and-drop in hierarchy fails for networked objects when desired parent is a network context.
- Fix bug where hiding the player from themselves still cast a shadow.
- Fixed bug where player appears inside their mounts in certain combinations of crouch, jump and mount.

#### Game Components

- Track #21 "Subtle House Club" in "Electronic Music Score Set" did not play the correct track.
- Fixed bug where built-in object references on `Weapon` and `Equipment` could break when put in a template.
- Updated effects to properly handle auto-play flag when emitters are being enabled or disabled.
- Flare billboard object now properly supports team coloring.
- Fixed invalid default animation string for `Ability` objects.
- Assets in the UI Textures section should now show icons of texture assets in CORE Content.
- The "Repeat" setting should now function on smart audio assets.
- Fixed submachine gun duplication issue and tuned all the existing weapons.
- Updated and improved many components based on feedback.

## Alpha Update 1: December 17th 2019

#### New Features

- Block indent was added to the script editor.
- Added advanced grenade and update advanced weapon reload binding.
- Added a new "View" -> "Reset Layout" menu item for using default tab layout for editor.
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
- Script Editor: Fix unnecessary save prompt triggered by UNIX or macOS line endings.
- Fixed the height of the "More Options" menu (seen when pressing the three dots on a game tile on the "Create" tab).
- Frontend "Games" button should take you to your game page, not the home page.
