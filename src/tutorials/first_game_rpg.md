---
id: first_game_rpg
name: First Game RPG
title: Build Your First Game - RPG!
tags:
    - Tutorial
---

# Create an RPG in Core

## Create a Framework Game

## Parts of the Framework

### Framework Documentation

This section contains two scripts, **DocumentationFrameworkOverview** and **DocumentationNPCKit**. These do not contain code, but instead have instructions on how to use this framework, and how to use the non-player character enemies in the dungeon (NPC's). You can also read this documentation online here.

### Game Settings

This section contains the existing logic of the game.

- **Game Settings** has options for in-game chat, player death behavior, and most importantly the **Enable Player Storage** setting which is necessary to save player's levels, gold, and equipment.
- **Team Settings** is used to create two teams, one for all of the players, and another for all of the enemies.
- The **ResourcePersisterServer** script keeps track of players' gold, even when they disconnect and reconnect later.
- The **EquipmentPersistentStarterServer** gives players the same weapons they had last when they disconnect and reconnect.
- **Basic Level Progression** allows players to increase in level with experience (XP), gaining more hit points (HP). In the **Levels List** folder, there are objects for each level with custom properties that allow you to change how much **RequiredXP** players need to reach the level, and what the player's **MaxHP** will be when they level up.
- The **Loot Drop Factory** template includes logic to make enemies give items to players when they are defeated. Inside this template are folders of the **Common**, **Uncommon**, and **Rare** drops which can be modified to change the rewards that players get, and how likely they are to appear.
- **Combat Dependencies** contains the scripts that allow enemy AI's to fight and take damage.
- **Third Person Camera Settings** has options for how the camera is controlled in game. You could trade out this object for one of the other **Camera Settings** objects in **Core Content** for a totally different player experience.

![Camera Settings Objects]()

### UI Settings

This section includes all the of the information displayed on the screen to tell players about their health, XP, coins, abilities, and which location they are in. You can change the way these are displayed. Check out the Core [UI Reference](ui_reference.md) to learn more about using the 2D User Interface elements.

### Map

The **Map** folder contains all of the objects you can see in the game. This is the section you will modify in this tutorial

- The **Environment** folder contains the sky template, which is currently the only source of light for the game.
- The **Lobby**  folder is the heart of the project. It has folders of all the example pieces, the shop, teleporters to the dungeons, and all the explanatory text that you can currently see in the world.
- The **Dungeons** folder contains the enemies and obstacles that make up each of the three dungeons
- The **Wall** and **Ground** folders contain all the objects that make up the ground and outer walls.
- The **Kill Zone** is a trigger that kills any player that gets outside of the boundaries of the dungeon, so that they can be reset back into the game rather than stuck outside of it.

### NavMesh

This folder contains a script that uses **Plain** objects to determine where the enemies can go. This is invisible by default, and we will make it visible in the tutorial in order to be able to build around the AI behavior, and modify it as necessary.

## Testing the Base Game

- Grab a costume
- Upgrade a Sword
- Do the first dungeon

### Player Stats

### The Portal to Core Haven

### Weapons Shop

###



## Building the Game

- Trying to figure out a system of hiding/locking elements so that we can just select objects to update
    - Hide UI Settings for cleaner workspace
    - Hide everything in Map except Environment and Ground
        - Lock NavMesh and KillZone
    - Right click Select all of the Ground Drag and drop a material onto ground
        - Lock ground
    - Show walls and replace their meshes
        - Fantasy Castle Wall 01 for the lobby
            - May have to flip 180 and translate
        - Half walls to replace half walls
    - Material change on dungeon walls
    - Lock Lobby, enable visibility on Dungeon, then hide and lock 2 and 3
        - Interlude about nav meshes
            - Add a large object with collision, test, and see the enemies run through
        - Show replacing a rock through Properties
        - Show copy and pasting properties to move object into same place
        - Note about Hierarchy organization
        - Suggestion to use community content
    - Make a shop
    - Delete Example Props, Gameplay Objects and World Labels

- Dungeon themes:
1. Stone (left)
2. Ice (middle)
3. Fire (right)

- Add a background with Terrain (background mountains) and folliage (trees only spawn on slopes)
- Delete all the World Text


- Move the dungeons below the lobby? (Stretch)