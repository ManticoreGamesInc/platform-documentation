---
id: childgames_scenes
name: Migrate from Child Games to Scenes
title: Migrate from Child Games to Scenes
tags:
    - Tutorial
---

# Intro

With the introduction of Scenes, we've made it way easier for creators to easily divide up their games while keeping the same project content accessible across all scenes. A game can be made up of many scenes (e.g. main menu, tutorial, different levels) that display different information, and usually there is some way for a Player to get from one scene to the other. Transferring between scenes as a player is like transferring between games and there will be a loading screen.

If you've been using our Child Games system previously, here's how you convert it to the new Scenes system:

## Copy the Files

Open the project you want to be your "Main" Scene (likely to be the parent project in a parent/child setup) in the editor. This is the scene that will load when a player enters the game. Now create a scene for each of the child projects you want to include. Save your project and close the editor.

For each child project:

- From Windows explorer, navigate to `../Maps/<child project>/Data/Scenes/Main/`
- Copy all files and folders except `SceneMeta.pbt`.
- In Windows explorer, navigate to `../Maps/<main project>/Data/Scenes/`.
- Paste the files and confirm replacing the existing ones.

For each child project:

- From Windows explorer, navigate to `.../Maps/<childProject>/`
- Copy all Terrain files.
- From windows explorer, navigate to `.../Maps/<main project>/` from your main scene project.
- Paste the files and confirm replacing the existing ones.

From each child project:

- Copy scripts, materials, templates, etc. to the corresponding folder in your main project's `../Maps/<main project>/Data/` folder.

!!! note "Migration Conflicts"
    Important: When migrating, there may be a few scripts that have the same name but are different in their contents. To fix this issue just create a brand new script (with a different name) and copy the contents into it."

## Adjust your Scripts

- Change scripts from `player:TransferToGame()` to `player:TransferToScene()`.
- Change scripts from `Game.TransferAllPlayersToGame()` to `Game.TransferAllPlayersToScene()`.

!!! note "Keep in mind that scenes share the same leaderboards and player storage."
