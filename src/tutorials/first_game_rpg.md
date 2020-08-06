---
id: first_game_rpg
name: First Game RPG
title: Build Your First Game - RPG!
tags:
    - Tutorial
---

# Create an RPG in Core

## Create a Framework Game

To get started, use the **Create** menu to make a new project

### Click **Create New**

1. With Core open, click the **Create** Tab on the left side menu.
2. Click **Create New Game**.

### Select the **D&D Game Jam** framework

1. Click **View Frameworks** in the **Core Game Frameworks** option.
2. Click **D&D Game Jam**.
3. Name your project.
4. Click **Create**.

## Building the Floor and Walls

### Lock the Project

This framework contains many different scripts, and essential elements that you do not want to change accidentally. To prevent this, use the **Lock** ![Lock](../img/EditorManual/icons/Icon_Lock.png).
{: .image-inline-text .image-background }

1. In the **Hierarchy**, press the **Collapse All** button the close all the project folders.
2. Click the **Lock** ![Lock](../img/EditorManual/icons/Icon_Lock.png) icon next to each folder except for **Map**.
{: .image-inline-text .image-background }

![Hierarchy Folders Locked](../img/RPG/HierarchyLockAllButMap.png){: .center loading="lazy" }

### Hide Elements to Focus on One Area

Next, we will hide elements of the project to work on one part at a time. This has two benefits:

- It is easier to focus on one part of the map at a time.
- You can click to select objects easily without grabbing parts that you do not want to change.

1. Click the **Visible** ![Visible](../img/EditorManual/icons/Icon_Visible.png) next to **UI Settings** to hide all the UI elements from the screen.
{: .image-inline-text .image-background}
2. Click the arrow next to **Map** to open the **Map** folder.
3. Click ![Visible](../img/EditorManual/icons/Icon_Visible.png) next to the **Lobby**, **Dungeons**, and **Wall** folders so that you can only see the gray floor tiles.
{: .image-inline-text .image-background }
4. Click ![Lock](../img/EditorManual/icons/Icon_Lock.png) next to the **Kill Zone** to prevent any changes to this element as well.
{: .image-inline-text .image-background }

![Hierarchy Setup to Edit Ground](../img/RPG/HierarchySetupGround.png){: .center loading="lazy" }

### Add Materials to the Ground

With the other elements hidden, you can now left click and drag to select multiple objects in the scene.

![Selected Dungeon Floor](../img/RPG/SelectGroundTiles.png){: .center loading="lazy" }

!!! hint
    You can hold ++Ctrl++ and click to unselect objects, and hold ++Shift++ and click to select more objects.

1. Make sure **Object Select Mode** ![Object Mode](../img/EditorManual/icons/Icon_ObjectMode.png) is enabled by clicking the ![Object Mode](../img/EditorManual/icons/Icon_GroupMode.png) icon in the Top Toolbar and clicking **Object**, or pressing ++C++.
{: .image-inline-text .image-background}
2. Press the Left Mouse Button and drag it across the floor tiles that you want to select.
3. Open the **Materials** folder in **Core Content** and select the Material to use for the ground section.
4. Drag that Material into the selected floor tiles, or into the **Properties** window, in the **Floor** Material property.

!!! info
    Whitebox Floor tiles have two sides that can have different materials. You can add the same material to both sides, or ignore the one you cannot see.

![Floor with Materials](../img/RPG/GroundMaterials.png){: .center loading="lazy" }

In this image, the Lobby tiles have the **Bricks Cobblestone Floor 01** material, and the Dungeon tiles have the **Stone Basic** material.

### Change the Walls

The next step is to change the outer walls. You can add materials to them the same way you did the ground, or try using different meshes, like the walls of the Castle tileset.

To change the object that is used by the walls, select several walls that are currently using the same mesh: **Whitebox Wall 01**. You will likely want to choose a different piece for half walls, so avoid the corner walls toward the Corehaven portal.

![Selecting Whitebox Walls](../img/RPG/SelectFullWalls.png){: .center loading="lazy" }

1. With the walls selected, open the **Properties** window and find the **Mesh** property.
2. Double click the image of the mesh (the whitebox wall) to open the **STATIC MESH PICKER** menu.
3. Search for `castle wall` to find a wall to use, like **Fantasy Castle Wall Interior 01**.
4. When you select the new mesh, it should immediately apply to the selected objects.

![Walls Now Use Fantasy Castle Wall Mesh](../img/RPG/WallMeshSelectCastleWallInterior.png){: .center loading="lazy" }

!!! info
    Changing the mesh will not change the name of the object, so they will still have the name "Whitebox ..." unless you change it with ++F2++

#### Half Walls

Half walls will be best substituted by other half wall sized meshes. Select the two corner half walls to apply a different mesh to them.

![Half Whitebox Walls Selected](../img/RPG/HalfWallsSelected.png){: .center loading="lazy" }

#### Finish the Exterior Walls

Using materials or mesh substitution, finishing designing the exterior wall for the game.

!!! hint
    Whitebox walls have two different sides for materials, so they are very useful when making two different areas right next to each other.

![Textured Outer Walls](../img/RPG/TexturedOuterWalls.png){: .center loading="lazy" }

## Building the Dungeons

### Make the First Dungeon Visible

1. Lock the **Wall** folder so that we can make changes without selecting the outer walls.
2. Click the ![Visible](../img/EditorManual/icons/Icon_Visible.png) icon next to **Dungeons** to show all the Dungeon elements.
{: .image-inline-text .image-background }
3. Click the arrow next to **Dungeons** to see the folders for each of the three dungeons.
4. Click the ![Visible](../img/EditorManual/icons/Icon_Visible.png) next to **Dungeon 2** and **Dungeon 3** so that only the first Dungeon is visible.
{: .image-inline-text .image-background }

![Hierarchy Setup to Edit Dungeon 1](../img/RPG/HierarchySetupDungeon1.png){: .center loading="lazy" }

### Reveal the NavMesh

Enemy AI's do not follow the same collision rules as players. Instead, they have a **NavMesh** which defines the areas where they can and cannot walk. To build a dungeon where the enemies cannot go through objects, we need to build around the NavMesh.

1. Select the **NavMesh** folder in the Hierarchy and click the **Lock** ![Lock](../img/EditorManual/icons/Icon_Lock.png) to enable changes.
{: .image-inline-text .image-background}
2. In the **Properties** window, change the **Visibility** property to **Force On**.

### Designing around the NavMesh

With the NavMesh visible, you can see all of the walkable areas have plains indicated that the enemies can walk on them too, and where the walls and obstacles are, there is no NavMesh. To use this in your design, make sure there is no NavMesh under objects that enemies should not be able to walk through.

### Replace the Whitebox Walls

You can use the same method used for the outer walls to simply change the mesh in place, and then reposition and resize the new object as necessary. You can also just add new objects from Core Content, but you will need to make sure that these get moved into the correct folder.

![Rock Substituting For Wall](../img/RPG/ReplaceWithRock.png){: .center loading="lazy" }

1. Select a new object from Core Content to replace one of the whitebox walls.
2. Drag that object into the scene, on top of the wall.
3. Resize, rotate, and reposition it to fit within the space not covered by NavMesh.
4. Drag the new object into the **Walls** folder of **Dungeon1**.
5. Select the old wall and press ++Delete++.

![Moving Rock to Appropriate Folder](../img/RPG/DragIntoWallsFolder.png){: .center loading="lazy" }

### Finish the Dungeons

Repeat this process to replace all the remaining whitebox pieces in Dungeon 1. Once you have finished, lock Dungeon 1 and make Dungeon 2 visible, and finally move on to Dungeon 3.

## Customizing the Shop

### Create a New Weapon

Each item in the shop is part of a **Equipment Display Purchase Pad**, which combines the visual display of the item, its price, and level requirements, as well as the script that handles taking the player's gold and given them a copy of the right weapon.

You can change any of the **Equipment Display Purchase Pad** to sell different items, or just change the prices and level requirements by select the object, and changing the custom properties.

![Equipment Display Custom Properties](../img/RPG/EquipmentPurchaseCustomProperties.png){: .center loading="lazy" }

You can create new items to purchase by finding the **Equipment Display Purchase Pad** template in the **Project Content** window, and dragging it into the **Main Viewport**.

### Move the Shop Items

To move the items in the shop, make sure **Group Select Mode** is enabled, so that you grab the template, including the text, triggers, and display.

Click the ![Object Mode](../img/EditorManual/icons/Icon_ObjectMode.png) icon in the Top Toolbar and select **Group**, or press ++C++ to switch between the two modes.
{: .image-inline-text .image-background }

Now, you can click and move the shop items to fit in the environment that you build for them.

### Add Community Content

You can use the many fantasy props to build out a shop, but there are even more props available in **Community Content**.

1. Use the search in the **Community Content** window to find available templates.
2. Click the **Import** button to add it to your project.
3. Open the **Core Content** window and find the **Imported Content** section in the navigation.
4. Double click the **Bundle** ![Lock](../img/EditorManual/icons/AssetType_Bundle.png) icon to open it.
{: .image-inline-text .image-background }
5. Drag the green **Template** icon into the **Main Viewport** to add it into the scene.

### Example: The Blacksmith

A blacksmith would be one way you could create a more immersive shop that fits in the world. Check out these community content items to build it!

#### Trellis by mjcortes782

![Community Content Trellis](../img/RPG/CommunityContentTrellis.png){: .center loading="lazy" }

#### Cart, Anvil, Blacksmith Hammer Point, and Blacksmith Hammer 1 by Flex

![Community Content Cart](../img/RPG/CommunityContentCart.png){: .center loading="lazy" }
![Community Content Blacksmith Items](../img/RPG/CommunityContentBlacksmith.png){: .center loading="lazy" }

## Finishing Up

### Create Background Mountains

To finish the project, we'll add some terrain around the dungeon to give it a place to be. You can customize this any number of different ways. This is just one example.

#### Generate New Terrain

1. Click the **Terrain** tool and select **Generate New Terrain**.
2. Select **Background Mountains** and change the **Voxel Size** to `2.0m`.

![Generate New Terrain Menu](../img/RPG/GenerateTerrainMenu.png){: .center loading="lazy" }

#### Position and Paint the Terrain

![Generated Terrain](../img/RPG/GeneratedTerrain.png){: .center loading="lazy" }

1. Move the generated terrain so that it is below your dungeons and lobby.
2. In the **Properties** menu, click the **Paint Tab** and select **Create new terrain material**.
3. This will automatically give the terrain the grass and cliffs textures, which is perfect for this setting. You can customize this further using the other material channels. See the [Environment Art](environment_art.md) tutorial to learn more about how to do this.

![Painted Terrain](../img/RPG/PaintedTerrain.png){: .center loading="lazy" }

### Delete Unnecessary Objects

For the final step, remove all of the objects that are not part of the final game.

1. Select the **NavMesh** folder and change its **Visibility** property back to **Force Off**.
2. In the **Map** folder, open the **Lobby** folder.
3. Select the **Example Fantasy Props** folder and press ++Delete++.
4. Select the **World Labels** folder and press ++Delete++.
5. Open the **Gameplay Objects** folder. Delete each folder inside EXCEPT the **Corehaven Portal**.

![Deleting Gameplay Objects Except Corehaven Portal](../img/RPG/DeletingGameplayObjects.png){: .center loading="lazy" }

### Preview in Multiplayer

Now that you have finished the steps to make the game, it is time to do more more test before publishing.

1. Click ![Multiplayer Preview Mode](../img/EditorManual/icons/Icon_MultiplayerTest.png) to switch the Preview Mode to Multiplayer.
{: .image-inline-text .image-background }

2. Press ![Play](../img/EditorManual/icons/Icon_Play.png) to start the preview. This will open a separate game window for each player.
{: .image-inline-text .image-background }

Try out your dungeons, testing enemy AI behavior, the shop items, and making sure you can't get trapped anywhere. Once you are happy with the game, you are ready to [publish](publishing.md)!

## Learn More

[Publishing Your Game](publishing.md) | [D&D RPG Framework Reference](rpg_framework_reference.md) | [D&D RPG Framework Official Documentation](rpg_framework_documentation.md) | [Environment Art Tutorial](environment_art.md) | [Weapons Tutorial](weapons.md)
