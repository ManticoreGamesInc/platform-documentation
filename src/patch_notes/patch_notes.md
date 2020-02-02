---
id: patch_notes
name: Patch Notes
title: Patch Notes
---

# Alpha Update 4: February 4th 2020

## Highlights

## About Deprecations during Alpha

We will sometimes need to deprecate code during the course of development.
Games using deprecated features will continue to work for the near future, but may produce deprecation warnings. Deprecated features may be removed entirely down the line; we recommend affected games eventually remove the feature/code!

## New Features

### API

- Added `CoreObject:GetCustomProperties()` and `SmartObject:GetSmartProperties()`, which return a table containing all of the object's custom properties or smart properties, respectively. Both functions are also shown in the script debugger.
- `Events.BroadcastToServer`, `Events.BroadcastToAllPlayers`, and `Events.BroadcastToPlayer` will now print warning messages in the Event Log when the broadcast fails.

### Editor

- You can now enable/disable autosaves from the preferences menu.
- Added more information to the "General" settings category.
- Added a "Stop VFX" button to effect properties in edit mode.

### CORE Content

- Rocket Trail VFX: Now supports lower alpha values. Smoke or Fire can now be independently controlled.

## Changes

### API

- Deprecate `Game.abilitySpawnedEvent`. It never fired and was left over after a previous change.

### Editor

- You can no longer interact with the world while the options screen is open.
- Updated the settings menu to only display tabs related to your current game mode.

### CORE Content

- Emissive Cutoff Liquid: Surface orientation and bubble direction values are now vectors instead of colors.

## Fixes

### API

- Fix CoreObject events missing from Ability instances. (Reported by RaMo)

### Editor

- Fixed a bug with the "New Project" dialog not closing when navigating away from the "Create" tab.
- Fixed publishing flow so that tags are correctly capped at 30 characters.
- The text preview of a selected script now updates when changes to the script are saved.
- Improved performance when selecting many objects at once.

### CORE Content

- Attachments on the left prop when in "unarmed" stance should no longer pop when idling, relaxed or transitioning from ability animations.
- Underwater volume: Volume physics now properly respects the enabled flag.
- Underwater volume: No longer enables hidden environement fog when exiting volume.
- Corrected CORE Content asset name typos:
    - "Ambient Rain SFX" to "Ambient Rain 01 SFX"
    - "Japanese Moonlight Music Construction Kit (Layers) 01" to "Japanese Moonlight Music Construction Kit (Sections) 01"
