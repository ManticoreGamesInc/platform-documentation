---
id: first_game_rpg
name: First Game RPG
title: Build Your First Game - RPG!
tags:
    - Tutorial
---

# Create an RPG in Core

## Create a Framework Game

## Building the Game

### Lock the Project

This framework contains many different scripts, and essential elements that you do not want to change accidentally. To prevent this, use the **Lock** ![Lock](../img/EditorManual/icons/Icon_Lock.png){: .image-inline-text .image-background}.

1. In the **Hierarchy**, press the **Collapse All** button the close all the project folders.
2. Click the **Lock** ![Lock](../img/EditorManual/icons/Icon_Lock.png){: .image-inline-text .image-background} icon next to each folder except for **Map**.

![Hierarchy Folders Locked]()

### Hide Elements to Focus on One Area

Next, we will hide elements of the project to work on one part at a time. This has two benefits:

- It is easier to focus on one part of the map at a time.
- You can click to select objects easily without grabbing parts that you do not want to change.

1. Click the **Visibile** ![Visible](../img/EditorManual/icons/Icon_Visible.png){: .image-inline-text .image-background} next to **UI Settings** to hide all the UI elements from the screen.
2. Click the arrow next to **Map** to open the **Map** folder.
3. Click ![Visible](../img/EditorManual/icons/Icon_Visible.png){: .image-inline-text .image-background} next to the **Lobby**, **Dungeons**, and **Wall** folders so that you can only see the gray floor tiles.
4. Click ![Lock](../img/EditorManual/icons/Icon_Lock.png){: .image-inline-text .image-background} next to the **Kill Zone** to prevent any changes to this element as well.

![Hierarchy Setup to Edit Ground]()

### Add Materials to the Ground

With the other elements hidden, you can now left click and drag to select multiple objects in the scene.

![Selected Dungeon Floor]()

!!! hint You can hold <kbd>Ctrl</kbd> and click to unselect objects, and hold <kbd>Shift</kbd> and click to select more objects.

1. Make sure **Object Select Mode** ![Object Mode](../img/EditorManual/icons/Icon_ObjectMode.png){: .image-inline-text .image-background} is enabled by clicking the ![Object Mode](../img/EditorManual/icons/Icon_GroupMode.png){: .image-inline-text .image-background} icon in the Top Toolbar and clicking **Object**, or pressing <kbd>C</kbd>.
2. Press the Left Mouse Button and drag it across the floor tiles that you want to select.
3. Open the **Materials** folder in **Core Content** and select the Material to use for the ground section.
4. Drag that Material into the selected floor tiles, or into the **Properties** window, in the **Floor** Material property.

!!! info Whitebox Floor tiles have two sides that can have different materials. You can add the same material to both sides, or ignore the one you cannot see.

![Floor with Materials]()

In this image, the Lobby tiles have the **Bricks Cobblestone Floor 01** material, and the Dungeon tiles have the **Stone Basic** material.

### Change the Walls

The next step is to change the outer walls. You can add materials to them the same way you did the ground, or try using different meshes, like the walls of the Castle tileset.

To change the object that is used by the walls, select several walls that are currently using the same mesh: **Whitebox Wall 01**. You will likely want to choose a different piece for half walls, so avoid the corner walls toward the Corehaven portal.

![Selecting Whitebox Walls]()

1. With the walls selected, open the **Properties** window and find the **Mesh** property.
2. Double click the image of the mesh (the whitebox wall) to open the **STATIC MESH PICKER** menu.
3. Search for ``castle wall`` to find a wall to use, like **Fantasy Castle Wall Interior 01**.
4. When you select the new mesh, it should immediately apply to the selected objects.

![Walls Now Use Fantasy Castle Wall Mesh]()

!!! info Changing the mesh will not change the name of the object, so they will still have the name "Whitebox ..." unless you change it with <kbd>F2</kbd>


## Notes

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