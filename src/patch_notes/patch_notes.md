---
id: patch_notes
name: Patch Notes
title: Patch Notes
---

# Alpha Update 4: January 28th 2020

## Highlights
- Added "Last Man Standing" framework.
- The <kbd>SHIFT</kbd> + <kbd>X</kbd> hotkey to place objects in the viewport now takes into account extra settings from the Object Generator tab like "Only Spawn On Terrain", "Randomize Scale" etc.
- **Breaking Change**:
    - `#!lua isVisible` property has been deprecated. Replacement is the `#!lua visibility` property. Possible values: `#!lua Visibility.FORCE_ON/FORCE_OFF/INHERIT`.
    - `#!lua isCollidable` property has been deprecated. Replacement is the `#!lua collision` property. Possible values: `#!lua Collision.FORCE_ON/FORCE_OFF/INHERIT`.
    - `#!lua targetInteractionEvent<WeaponInteraction>` has been deprecated. Replacement is `#!lua targetImpactedEvent<Weapon, ImpactData>`.
    - `#!lua WeaponInteraction` type has been renamed to `#!lua ImpactData`.
    - `#!lua targetImpactedEvent` returns the parameters `#!lua <Weapon, ImpactData>` instead of `#!lua <WeaponInteraction>` to ensure consistency with other events.
    - In both changes, old code will continue to work but may produce deprecation warnings.

!!! info "If your game make use of these (or any of the built-in weapons), here are the quick changes you can make to update them"
        - WeaponDamageShootServer.lua:
            - `#!lua function OnWeaponInteraction(weapon, weaponInteraction)` -> `#!lua function OnTargetImpacted(weapon, weaponInteraction)`
            - `#!lua WEAPON.targetInteractionEvent:Connect(OnWeaponInteraction)` -> `#!lua WEAPON.targetImpactedEvent:Connect(OnTargetImpacted)`
        - WeaponProjectileExplosionServer.lua:
            - `#!lua function OnProjectileInteracted(weapon, interaction)` -> `#!lua function OnTargetImpacted(weapon, interaction)`
            - `#!lua WEAPON.targetInteractionEvent:Connect(OnProjectileInteracted)` -> `#!lua WEAPON.targetImpactedEvent:Connect(OnTargetImpacted)`
- A lot of bug fixes!

## About Deprecations during Alpha

We will sometimes need to deprecate code during the course of development.
Games using deprecated features will continue to work for the near future, but may produce deprecation warnings. Deprecated features may be removed entirely down the line; we recommend affected games eventually remove the feature/code!

## New Features

### API
- Creators can now set `collision` / `visibility` to "Force On," "Force Off," or "Inherit From Parent".

### Editor
- Added "Last Man Standing" framework.
- The <kbd>SHIFT</kbd> + <kbd>X</kbd> hotkey to place objects in the viewport now takes into account extra settings from the Object Generator tab like "Only Spawn On Terrain", "Randomize Scale" etc.
- Added a volume slider to the Options menu.
- Adding "Orbit around selection" option to camera controls and toolbar.
- Two new experimental root motion ability animations: "unarmed_roll" and "unarmed_kick_ball".
- Added a Settings button to the drop-down menu in the upper-right corner of the launcher.

### CORE Content
- Two new characters have been added to CORE: Cruze and Cobra.
- Added new "Unexplored Wasteland Layers" kit.
- Added several melee weapon props to the 3D Objects folder: A pipe, bat, crowbar, knife, and axe! Knife and axe are each split into a handle and a blade object.
- Minor updates to existing components, and several new components:
    - Double Door - Two connected doors, usually adjacent.
    - Lobby Start Clear Resources - Clears all resources on round start.
    - Player Launcher - Launches players who touch it.
    - Sliding Door - Door that slides.
    - Team Auto-Balancer - Keeps your teams balanced and optionally scrambles teams between rounds.
    - Teleporter - Teleports players.

## Changes

### API
- The `Respawned` event will now fire on both server and client.
- **Breaking Change**:
    - `#!lua isVisible` property has been deprecated. Replacement is `visibility` the property. Possible values: `#!lua Visibility.FORCE_ON/FORCE_OFF/INHERIT`.
    - `#!lua isCollidable` property has been deprecated. Replacement is `collision` the property. Possible values: `#!lua Collision.FORCE_ON/FORCE_OFF/INHERIT`.
    - `#!lua targetInteractionEvent<WeaponInteraction>` has been deprecated. Replacement is `#!lua targetImpactedEvent<Weapon, ImpactData>`.
    - `#!lua WeaponInteraction` type has been renamed to `#!lua ImpactData`.
    - `#!lua targetImpactedEvent` returns the parameters `#!lua <Weapon, ImpactData>` instead of `#!lua <WeaponInteraction>` to ensure consistency with other events.
    - In both changes, old code will continue to work but may produce deprecation warnings.

!!! info "If your game make use of these (or any of the built-in weapons), here are the quick changes you can make to update them"
        - WeaponDamageShootServer.lua:
            - `#!lua function OnWeaponInteraction(weapon, weaponInteraction)` -> `#!lua function OnTargetImpacted(weapon, weaponInteraction)`
            - `#!lua WEAPON.targetInteractionEvent:Connect(OnWeaponInteraction)` -> `#!lua WEAPON.targetImpactedEvent:Connect(OnTargetImpacted)`
        - WeaponProjectileExplosionServer.lua:
            - `#!lua function OnProjectileInteracted(weapon, interaction)` -> `#!lua function OnTargetImpacted(weapon, interaction)`
            - `#!lua WEAPON.targetInteractionEvent:Connect(OnProjectileInteracted)` -> `#!lua WEAPON.targetImpactedEvent:Connect(OnTargetImpacted)`

### Editor
- Key bindings for "Fly Down" and "Swim Down" now default to <kbd>CTRL (Left)</kbd>.
- All subfolders in the CORE Content tab are now sorted by name.
- <kbd>ALT</kbd> + <kbd>Mouse Right</kbd> dragging now zooms in for down/right movement (and vice versa).
- The "Publish Game" results dialog will now always show a game link, no longer a play link.
- Clean up of orbit behavior:
    - The default selection mode is now "Object".
    - The camera now has a "focal point" in front of it that is the center of orbit operations. This point is set when you focus on an object, and travels with the camera while flying (right-drag + WASD) and panning (middle-drag).
    - Zooming with the scroll wheel will move the camera forwards and backwards like flying, but holding <kbd>ALT</kbd> (as well as <kbd>ALT</kbd> + right-drag to zoom) will move towards/away from the focal point, keeping it where it is and leaving orbit movements centered on the same location in the scene.
    - Enabling "Orbit around selection" in the camera controls will always use the center of whatever you have selected instead of the focal point.

### CORE Content
- Updated advanced weapons with new API visibility calls.
- Polished and updated Battle Royale and Deathmatch framework.
- Faucet water material now uses a vector instead of a color for bubble direction.
- Explosion and Generic Cloud Materials:
    - Speed value is now a vector instead of a color.
    - Note: This may require updating or creating new custom materials.
- Wispy Fog Volume:
    - Improvements to light interaction.
    - Now lights in a more realistic manner.
    - This will brighten some existing instances of this effect.
    - Note: Levels using this effect will need to lower the color value and will benefit from lowering overall particle density.
- Updated weapon scripts to change from `targetInteractionEvent` to `targetImpactedEvent`.
- Improved Sniper Rifle and Revolver weapons.

## Fixes

### API
- The `#!lua Events.Broadcast*` family of functions should now properly send player arguments in preview mode.
- Note: The size of a Player argument as transmitted over the wire has gone up to correct certain behavior, but this means that it is possible for scripts that previously worked to now fail if they are firing events with `Player` arguments. Some calls that previously returned `#!lua BroadcastEventResultCode.SUCCESS` may now return `#!lua BroadcastEventResultCode.EXCEEDED_SIZE_LIMIT` because of that.
- `Game.GetTeamScore()` now returns the correct result when called on server during `Game.teamScoreChangedEvent`. (Reported by Seth Leyens)
- Fixed `CoreObject` events missing from `Ability` instances. (Reported by RaMo)

### Editor
- Fixed uncommon client crash when equipment is modified.
- Fixed player falling through floor when respawning in place.
- Fixed terrain error message about size limits.
- Fix for manipulator crash.
- Fix to prevent debris physics objects stopping projectiles.
- Physics objects now have the correct icon in the hierarchy.
- <kbd>CTRL</kbd> + <kbd>A</kbd> in the viewport will now highlight objects in the hierarchy as well.
- Fixed case resulting in incorrect non-uniform scale error.
- Fixed crash when drag-selecting.
- Fixed a bug that caused every category to appear selected upon opening the Settings menu.

### CORE Content
- Falling Leaves VFX: Non-burning leaves should now not have edge highlight colors when eroding and now work properly for all LODs.
- Basic Explosion:  Now respects local space flag.
- Gameplay: Fixed Users are not taking damage on their lower halves.
- Improved tiling/repeating UVs on arcade cube models. These objects will now look better with a wider range of materials. May cause weirdness to existing material changes on arcade cubes, but only to material display size.