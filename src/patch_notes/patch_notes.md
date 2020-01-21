---
id: patch_notes
name: Patch Notes
title: Patch Notes
---

# Alpha Update 4: January 22nd 2020

## Highlights
- Added "Last Man Standing" framework.
- The <kbd>SHIFT</kbd> + <kbd>X</kbd> hotkey to place objects in the viewport now takes into account extra settings from the Object Generator tab like "Only Spawn On Terrain", "Randomize Scale" etc.
- **Breaking Change**: `targetInteractionEvent` now returns the parameters `<Weapon, WeaponInteraction>` instead of `<WeaponInteraction>` to ensure consistency with other events.
- A lot of bugfixes!

## New Features

### API

### Editor
- Added "Last Man Standing" framework.
- The <kbd>SHIFT</kbd> + <kbd>X</kbd> hotkey to place objects in the viewport now takes into account extra settings from the Object Generator tab like "Only Spawn On Terrain", "Randomize Scale" etc.
- Added a volume slider to the Options menu.
- Adding "Orbit around selection" option to camera controls and toolbar.
- Two new experimental root motion ability animations: "unarmed_roll" and "unarmed_kick_ball".

### CORE Content
- Two new characters have been added to CORE: Cruze and Cobra.
- Added default volume level settings for "Unexplored Wasteland (Layers) Music Kit"
- Added new "Unexplored Wasteland Layers" kit that only contains the "Full" layers. Now labled and named as "Unexplored Wasteland Layers Simple Music Kit"
- Added new music kit: "Unexplored Wasteland Kit Sections"

## Changes

### API
- The `Respawned` event will now fire on both server and client.
- **Breaking Change**: `targetInteractionEvent` now returns the parameters `<Weapon, WeaponInteraction>` instead of `<WeaponInteraction>` to ensure consistency with other events.

### Editor
- Set default key binding for "Fly Down" and "Swim Down" to <kbd>CTRL (Left)</kbd>.
- All subfolders in the CORE Content tab are now sorted by name.
- <kbd>ALT</kbd> + <kbd>Mouse Right</kbd> dragging now zooms in for down/right movement (and vice versa).
- The "Publish Game" results dialog will now always show a game link, no longer a play link.
- Clean up of orbit behavior, the default selection more is now "Object".
    - Details:
        - The camera now has a "focal point" in front of it that is the center of orbit operations. This point is set when you focus on an object, and travels with the camera while flying (right-drag + WASD) and panning (middle-drag).
        - Zooming with the scroll wheel will move the camera forwards and backwards like flying, but holding <kbd>ALT</kbd> (as well as <kbd>ALT</kbd> + right-drag to zoom) will move towards/away from the focal point, keeping it where it is and leaving orbit movements centered on the same location in the scene.
        - Enabling "Orbit around selection" in the camera controls will always use the center of whatever you have selected instead of the focal point.

### CORE Content
- Removed "Full" layers from the "Unexplored Wasteland Layers Music Kit"
- Moved "Unexplored Wasteland" Music kits to Audio > BGM > Action

## Fixes

### API
- The `Events.Broadcast*` family of functions should now properly send player arguments in preview mode.
- Note: The size of a Player argument as transmitted over the wire has gone up to correct certain behavior, but this means that it is possible for scripts that previously worked to now fail if they are firing events with `Player` arguments. Some calls that previously returned `BroadcastEventResultCode.SUCCESS` may now return `BroadcastEventResultCode.EXCEEDED_SIZE_LIMIT` because of that.

### Editor
- Fixed uncommon client crash when equipment is modified.
- Fixed player falling through floor when respawning in place.
- Fixed terrain error message about size limits.
- Fixed for manipulator crash.
- Fixed to prevent debris physics objects stopping projectiles.
- Physics objects now have the correct icon in the hierarchy.
- <kbd>CTRL</kbd> + <kbd>A</kbd> in the viewport will now highlight objects in the hierarchy as well.
- Fixed case resulting in incorrect non-uniform scale error.

### CORE Content
- Falling Leaves VFX: Non-burning leaves should now not have edge highlight colors when eroding and now work properly for all LODs.