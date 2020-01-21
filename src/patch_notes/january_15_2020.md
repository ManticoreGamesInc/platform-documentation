---
id: patch_notes_jan_15_2020
name: Patch Notes for January 15th 2020
title: Patch Notes for January 15th 2020
---

# Alpha Update 3: January 15th 2020

## Highlights

- Tons of improvements to the included game frameworks.
- Added new CoreString namespace API with `Split()`, `Join()` and `Trim()` functions.
- Three new game frameworks: Last Team Standing, Gun Game and Assault!

## New Features

### API

- `CoreString.Split(string s, [string delimiter], [table optionalParams])`
    - Splits `s` into a list of substrings separated by `delimiter`. The delimiter is treated as an exact string that must be matched. `optionalParams` may contain the following optional parameters:
        - `removeEmptyResults` - defaults to `false`, filters out empty strings from the returned list.
        - `maxResults` - limits the number of strings that can be returned.
        - `delimiters` is a table of delimiter strings to split on, in addition to the delimiter parameter.
    - Example: `CoreString.Split("foo:bar:baz", ":", {maxResults = 2})` returns `foo, bar:baz`.
    - Note: `CoreString.Split()` can be called with a delimiter, with `optionalParams`, with both, or with neither. If `delimiter` is not provided and the delimiters optional parameter is also not provided, `s` is split on any whitespace characters. Multiple whitespace characters in a row will result in empty strings in the results, unless you specify `{ removeEmptyResults = true }`.
- `CoreString.Join(string delimiter, [string s1, [string s2...]])`
    - Concatenates `s1`, `s2`, etc into a single string, separated by `delimiter`.
- `CoreString.Trim(string s, [string trim1, [string trim2]])`
    - Removes instances of `trim1`, `trim2`, etc from the beginning and end of `s`. trimmed strings must be matched exactly, and the order of the trims matters if you provide more than one.
    - Example: `CoreString.Trim("foobarfoo", "foo", "oo")` returns `bar`, but `CoreString.Trim("foobarfoo", "oo", "foo")` returns `barf`.
    - Note: If no trims are specified, this will trim any whitespace from the start and end of `s`.

### Editor

- Added a "New Group" context menu item to create a group to the hierarchy UI.
- Mousing over an item in the content browser now displays the item's name in a tooltip.
- Added an icon to the editor's "Filter" buttons.
- Added a file size warning for Terrain on save if the terrain is above 50% of the max size.
- Added a "More" tile at the end of any Community Content page that has more items to load.
- Added "Random Spawn Point" option to respawn settings.
- Added two new respawn options:
    - Farthest from other players - Respawns the player at a start point which is furthest away from other players.
    - Farthest from enemy - Respawns the player at a start point which is furthest away from enemy players.

### CORE Content

- Added "Last Team Standing" framework.
- Added "Gun Game" framework.
- Added "Revolver Weapon" to CORE Content.
- Added "Assault" framework.
- "Fire Volume VFX" now supports an initial velocity to allow it to be used for jet flames, flame throwers, etc.

## Changes

### API

- `Player.ActivateFlying()` is now server-only.
- `Player.ActivateWalking()` is now server-only.
- `PlayerSettings.Apply()` is now server-only.
- Improved error messages for multiple unique objects, such as settings and sky objects.

### Editor

- The "Publish Game" success dialog will close on <kbd>ESC</kbd>.
- You can no longer publish a game while in preview mode.
- You can no longer publish a game that has missing required assets.
- The "Create New" button now opens a dialog that asks what to create the new game from.
- You can now delete your local projects by pressing the "More Options" button on your project tile and selecting "Delete".
- The Terrain Creator list now correctly displays the name of the terrain type, plus a % which indicates the file size / complexity.

### CORE Content

- Improved the "Cape" and "Teddy Bear" back pack dynamics.
- Renamed "Player Start" to "Spawn Point" in the empty scene.
- "Sky" templates from CORE content will no longer have "networking" enabled by default when placed in a scene.

## Fixes

### API

- Fixed "expected number, received number" error to be more specific about expecting an integer.

### Editor

- Fixed issue where a player would rotate in place on the server as if facing was set to "Look at Aim" while clients behaved in accordance to the correct facing mode.
- Names of long assets are no longer cut off when the content window is set to "Icon View".
- Fixed a bug preventing autoplay sounds/music from playing on startup for clients.
- Fixed CORE Content not showing items if you toggle the list/thumbnails.
- Fixed a problem where autosaves and regular saves could fight.
- Fixes networked custom properties on "Equipment" objects.
- Panel primitives will now have more correct collision when scaled.
- Dragging an asset into the hierarchy now allows navigation hotkeys to work afterwards.
- Fixed player settings in the empty scene.
- When cloning a game, the terrain files will now be copied over as well.

### CORE Content

- 45 degree pipes should now have working collision!
- Fixed incorrect pickup label on "Basic Grenade".
- Kitchen props will now retain correct collision when scaled non-uniformly.
- Backpack and cape dynamics are reset on mount/dismount to fix issues related to character "teleporting" when changing mount state.