---
id: rpg_framework_documentation
name: D&D RPG Framework Documentation
title: Official D&D RPG Framework Documentation
tags:
    - Reference
---

# Official D&D RPG Framework Documentation

## D&D Game Jam Framework Documentation

---

This is a special framework created specifically for D&D Game Jam contest!
Use this framework to kickstart your dungeon, adventure or RPG game creation!

## Features and components included in this framework

---

- Persistent level progression
- 13 NPC enemies
- 11 fantasy weapons
- 5 player costumes
- Basic equipment shop stands
- Functional game objects
- NPC Navmesh pathfinding
- Basic dungeon map layout
- Example fantasy props

## Getting Started - Gameplay Preview

---

1. Play the framework in preview mode. A Basic Blade will be equipped automatically.
2. Explore the Lobby Area.
3. Enter Dungeon 1 and defeat some enemies
4. If you are back to the lobby after clearing the dungeon, try purchasing the Icy Blade weapon.
    If you don't have enough Coins, keep earning them by defeating few more enemies in the dungeon.
5. Once you upgraded your weapon, you can explore next harder dungeons.
    You can keep grinding until you defeat all main bosses in each dungeon with better weapons.
    Alternatively, you can also try aiming to earn enough Coins to buy the final costume called "Lava Elemental Costume".
6. That's it, you now got the sense of the gameplay!
    The game saves your level, xp, and equipment, so you can keep progressing anytime.

!!! info "The Lobby area is also a place that showcases fantasy props provided by Core."
    Feel free to use them in your own levels! More assets and props can be found in Core Content.

## Getting Started - Weapons

---

There are 4 types of weapons included in the framework: Melee, Projectile, Melee + Shield and Projectile AOE attack.
Each weapon is capable of damaging NPC enemies and enemy players.
Each weapon persists and getting saved by EquipmentPersisterServer script in the weapons.

Quick Start Guide
Drag out the weapons listed below into the hierarchy to understand their structure:

- Basic Dagger
- Basic Blade
- Basic Sword
- Basic Sword and Shield
- Basic Crossbow
- Basic Staff

Additionally, framework has a few more customized weapons that serve as an example of weapon kitbashing:

- Icy Blade
- Fiery Sword
- Mace and Shield
- Poison Crossbow
- Poison Staff

See properties on each weapon (and its child scripts) to tweak them to your needs.
Alternatively, you can read through comments on weapon scripts to dig in deeper on how the weapons are structured.

Start creating new weapons based on existing weapons in the framework or alter them to create your new weapons.

!!! info "Block ability broadcasts events to `BlockAbilityDisplayClient` that is located in Hierarchy. The script triggers block UI to show the cast duration phase for block ability."

## Getting Started - Costumes

---

Costumes can be equipped and be persistent like weapons.
Costumes by default are purchasable from the shop in Lobby area.

To modify a costume, follow these steps:

1. Drag any template with name ending " Costume" to the hierarchy from Project Content.
2. Deinstance the costume template.
3. Check / uncheck `IsPlayerVisible` if you want the player to be visible or not when wearing the costume.
4. Go to Client Context > Costume to edit the costume under each folder with player socket names.

There are lot more costumes you can integrate from Community Content.
Make sure to use existing costume as the base structure to create new costumes that persists and works with shop.

## Getting Started - NPCs

---

NPCs are created using a "NPC AI Kit" package provided by standardcombo from Community Content.
The package has been integrated with many slight modifications to ensure it works with other game components in this framework.

Useful facts about NPCs:

- NPCs attack the player by shooting invincible projectiles. They can also attack each other if they are on different teams.
- NPCs have invincible collider that can be enabled and resized.
- Most NPCs has costumes that are attached on an Animated Mesh object.

Quick Start Guide

1. To start modifying NPCs, drag out any template from Project Content that starts with "NPC - " into the hierarchy.
2. Check out all the properties for AI movement and tweak it to your liking.
3. Put the modified NPC to any dungeon.
4. Go to the dungeon in preview mode and observe the new NPC's behaviors.

NavMesh
NPCs automatically check for the existence of a "NavMesh" and use it if available.
If the "NavMesh" folder is deleted, NPCs will simply move on the ground without detecting obstacles.
To modify navmesh, enable visibility on "NavMesh" folder in the hierarchy to see the navmesh structure.
Add more areas for navmesh by duplicating or manipulating existing planes layout.

Spawn Points

1. Search for "NPC Camp - " in Project Content and drag out any template you wish to check out.
2. Each spawn point showcases different ways an NPC can spawn - Player Proximity, Always Spawn, Periodic Spawn.
3. You can also set up Waypoint system using any type of spawn.
    Drag out "NPC Camp - Waypoints" to check out how waypoints are set up with Always Spawn setup.

Note:

- NPCs doesn't work in the Lobby area because there is no navmesh in it.
- NPC AI Kit package relies on "Loot Drop Factory" and "Combat Dependencies" objects to be in the hierarchy.
Make sure they are always in the scene if you decide to clean up the framework map.

To learn more about NPC AI Kit, read the script called "DocumentationNPCKit"
    under "Framework Documentation" folder from the hierarchy.

## Getting Started - Player Level Progression

---

This framework introduces Level and XP as a concept.
Player gains XP by killing NPC enemies. With each new level, player gets max HP upgraded.

You can tweak the level progression by changing required XP, max HP per level.
To do that, find "Levels List" group under "Basic Level Progression" object.
The group has children, with each having two properties you can change. treat this group as a table of information.
If you want to add more levels, simply duplicate the Level object and tweak the properties on it.

Note: The XP and Level are saved as resources per player.
        The resources persist using the script "ResourcePersisterServer".

## Getting Started - Modifying the Map

---

1. Open the "Map" folder in Hierarchy
2. Delete "Example Fantasy Props" and "World Labels" folders under "Lobby" folder
    to clean up the example props scene.
3. Open the "Lobby" folder and modify the walls, shop, and game components to your liking.
4. Open the "Dungeons" folder and modify the dungeon's obstacles, walls, and spawn points.
5. Open the "Walls" and "Ground" folders to modify walls and ground.
6. Change the sky and lighting under "Environment" folder.
7. Move or add "Named Locations" objects around the map to name your new areas.
    Make sure to edit the Zone Trigger object to match with your area.
8. Finally, move the spawn point where you want the player to start the game.

Alternatively, you can hide / delete the whole map and start with a fresh map.
Use the framework map as reference if needed.

## Other Notes

---

Make sure to keep Corehaven Portal object in your level to link your game to the
main hub of D&D Game Jam contest.

To find out more about the D&D Game Jam contest rules, follow this link:
<https://www.coregames.com/create/>
