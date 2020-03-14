---
id: environment_art
name: Environmental Art in Core
title: Environmental Art in Core
tags:
    - Reference
---

# Environmental Art in Core

![ArtIntro](../../img/EnvironIntro/image45.png "Art Screenshot"){: .hero}

## Overview

Learn how to use the Terrain Creator, swimmable volumes, and  the Object Generator. This tutorial will focus on making a desert landscape with a hidden green oasis, but can be customize to build any natural scene with an area where players swim.

- **Completion Time:** 20 minutes
- **Previous Knowledge:** [Introduction to the Core Editor](editor_intro.md)
- **Skills you will learn:**
    - Creating and sculpting terrain
    - Creating swimmable volumes
    - Using the Object Generator tool

<!-- Image says "Generate Terrain" -->

## The Terrain Creator

The Terrain Generator tool creates a different landscapes, either from a premade HeightMap, or through random generation.

### Open the Terrain Creator

1. Start from an new empty project.
2. Click the ![Terrain](../../img/EditorManual/icons/Icon_Terrain.png) button to open the **Terrain Creator**.
 {: .image-inline-text .image-background}
3. Choose **Generate New Terrain** from the drop down menu.

   ![ArtIntro](../../img/EnvironIntro/image11.png "Art Screenshot"){: .center}

### Generate Terrain

There are different options for types of terrain that can be generated in Core. You can click any of the terrain types to see a description of what it will generate.

1. Select **Rolling Hills**.
2. Click **Generate**.
3. Press ![Play](../../img/EditorManual/icons/Icon_Play.png) or <kbd>=</kbd> to explore the newly generated terrain from a player perspective.

   ![ArtIntro](../../img/EnvironIntro/image36.png "Art Screenshot"){: .center}
   <!-- Image has "Heightmap" before pre-defined maps -->

### Rearrange the Scene

You may have fallen through your terrain, and you may see an unusually flat area where Default Floor still exists in the scene.

1. Find the **Spawn Point** in the **Hierarchy** and move it too a new spot, above the terrain and just outside of the default floor.
2. Right click on **Default Floor** in the **Heirarchy** and select **Delete**.
3. Click the ![Terrain](../../img/EditorManual/icons/Icon_Terrain.png) **Terrain** button again to see that it now lists the **Terrain(Rolling Hills)** as **Primary**

!!! note "Tip: Primary Terrain is the terrain in your scene with collision enabled. You can have multiple terrains, but only one will have collision."

### Apply Materials

Any material can be added to a terrain. However, materials that begin with **Terrain** are designed to be used for terrain and will have more variation in how they are applied.

1. Open the **Materials** tab of **Core Content**.
2. Test out different materials by dragging them onto the terrain.
3. Search the **Core Content** tab for  `terrain`.
4. Find **Terrain - Desert** and drag it onto the terrain.

   ![ArtIntro](../../img/EnvironIntro/image32.gif "Art Screenshot"){: .center}

### Open the Sculpt Menu

The shape of terrain can be changed using sculpting tools in the **Properties** menu.

1. Click on the terrain, either in the Main Viewport or the Hierarchy.
2. Open the **Properties** window.
3. Click on the ![Terrain Sculpt](../../img/EditorManual/icons/Icon_TerrainSculpt.png){: .image-inline-text style="width:2em; background:#15181e"} **Sculpt** tab.

### Sculpt the Terrain

The sculpting menu contains tools to change the landscape according to the intended style.

1. In the **Tool** menu, select the ![Terrain Sculpt](../../img/EditorManual/icons/Icon_TerrainSurface.png){: .image-inline-text style="width:2em; background:#15181e"} **Surface** tool.
2. Change the mode from ![Additive](../../img/EditorManual/icons/Icon_TerrainPull.png){: .image-inline-text style="width:2em; background:#15181e"} **Additive** to ![Destructive](../../img/EditorManual/icons/Icon_TerrainPush.png){: .image-inline-text style="width:2em; background:#15181e"} **Destructive**.
{: .image-inline-text}
3. Lower the **Strength** value in the **General** subcategory to ``0.1``
4. Click and drag on the terrain to make a crater deep enough to fill with water.

   ![ArtIntro](../../img/EnvironIntro/image28.png "Art Screenshot"){: .center}

### Smooth the Terrain

1. Change the sculpting tool from ![Terrain Sculpt](../../img/EditorManual/icons/Icon_TerrainSurface.png){: .image-inline-text style="width:2em; background:#15181e"} **Surface** to ![Terrain Smooth](../../img/EditorManual/icons/Icon_TerrainSmooth.png){: .image-inline-text style="width:2em; background:#15181e"} **Smooth**.
2. Click and drag the crater to give it a more natural appearance.

   ![ArtIntro](../../img/EnvironIntro/image7.png "Art Screenshot"){: .center}

## Water and Swimming

### Add a Cube to the Scene

1. Search for a cube in the **Core Content** window.
2. Drag the cube into the scene, in the middle of your crater.

   ![ArtIntro](../../img/EnvironIntro/image29.png "Art Screenshot"){: .center}

### Resize and Reposition the Cube

1. Resize the cube until it fills your crater.
2. Move the cube down until it looks like a pool of water inside the sand dunes.

   ![ArtIntro](../../img/EnvironIntro/image14.png "Art Screenshot"){: .center}

### Add a Material

1. Search **Core Content**  for ``water``.
2. Choose a water material, and drag it onto the cube.
3. Preview the scene to see the water in person.

   ![ArtIntro](../../img/EnvironIntro/image18.png "Art Screenshot"){: .center}

!!! note
    Double-click **Cube** in the Hierarchy to rename it to **Water** to make it easier to navigate your project in the future.

### Disable Collision on the Water

   ![ArtIntro](../../img/EnvironIntro/image12.png "Art Screenshot"){: .center}

1. Select the water cube.
2. On the **Properties** window, and find the **Scene** section.
3. Change the **Collision** property to **Force Off**.
4. Preview again to test that you can now pass through the water as a player.

### Use the Underwater Post Process

Now you can pass through the water, but once inside it looks like the volume disappears. We can use the **Underwater Post Process** volume to achieve an underwater effect.

1. Find the **Underwater Post Process** volume under the **Post Processing** section of **Core Content**.
2. Drag it into your scene on top of your water.

   ![ArtIntro](../../img/EnvironIntro/image13.png "Art Screenshot"){: .center}

### Resize the Underwater Post Process

Core makes it easy to copy properties from one object to another. We can use this to make the Underwater Post Process match the size and position of the Water cube.

1. Select the cube that represents the water and open **Properties** window.
2. Click the  **Copy Properties** button in the top right corner.
3. Select the **Underwater Post Process** volume and return to the **Properties** window.
4. Click the **Paste Properties** button, in the top right corner.
5. Check **Position**, **Rotation** and **Scale** in the menu that pops up and press **Paste Selected Parameter Values**
6. Start a preview to test out swimming. The Underwater Post Process should now be in the same place and the same size as the water object.

   ![ArtIntro](../../img/EnvironIntro/image15.png "Art Screenshot"){: .center}

## Generating Foliage

The Object Generator is a way to take any object, and let Core place several copies of on the terrain, according to customizable settings.

### Duplicate the Water Object

1. Select the water object and press <kbd>Ctrl</kbd> + <kbd>W</kbd> to dublicate it.
2. Drag the duplicate cube up above the terrain.

   ![ArtIntro](../../img/EnvironIntro/image43.png "Art Screenshot"){: .center}

### Select the Objects

To use the Object Generator, you need to select both an object to generate, and another object in the scene for the objects to generate *beneath*, in this case, the duplicated water.

![ArtIntro](../../img/EnvironIntro/image40.png "Art Screenshot"){: .center}

1. In the **Core Content** tab open the **3D Objects** menu to find the **Nature** menu.
2. Select a grass object.
3. Make sure that the duplicate water is also selected in the Hierarchy.

!!! info "Tip: Templates you've created or downloaded from Community Content also work with the object generator!"

### Spawn Grass

1. Open the 4. Open the **Object Generator** by going to the **View** in the menu top bar. by going to the **View** in the menu top bar.
2. In the **Object Generator** menu, check the **Randomize Scale** box, and change the **Max Scale** value to two
    - **Randomize Scale** makes the objects generated vary in size.
    - Make the **Min Scale** and **Max Scale** values closer for less variation in size.
3. Check the **Randomize Yaw** box.
    - This will place the grasses at different angles relative to the ground
4. Check the **Use Random Color** Box, and change **Min G** to ``0.5`` and **Max B** to 0.
   - This will randomize the grasses color between yellow (100% red with 100% green) and 100% green with no red.
5. Check the **Only Spawn On Terrain** box to put grass on the sand, but not the water object.
6. Click **Spawn Selected Asset Under Selected Hierarchy Object**.

<!-- ## Using the Object Generator

![ArtIntro](../../img/EnvironIntro/image35.png "Art Screenshot"){: .center}

Checking **Randomize Scale** will generate differently sized objects. If you want your scene to feel more realistic, check this box. It is pretty unrealistic to have bushes or rocks that are all the same size - when was the last time you saw that in nature? Even varying the scale a little will make your environment feel more lifelike.

You can set the **Min Scale** and **Max Scale** to control the range of how big and small your objects spawn.

![ArtIntro1](../../img/EnvironIntro/image9.png "Art Screenshot1")
![ArtIntro2](../../img/EnvironIntro/image21.png "Art Screenshot2")
*Randomize Scale unchecked (left) vs. Randomize Scale checked with a Min Scale of 0.7 and a Max Scale of 1.3 (right)*
{: .image-cluster}

Check **Use Non-Uniform Scale** if you would like to further fine tune the scale of your objects. You can set the **Min** and **Max Scale** for each of an object's axis (X, Y, and Z).

![ArtIntro](../../img/EnvironIntro/image6.png "Art Screenshot"){: .center}

Yaw is an object's rotation along the Y-axis. Checking **Randomize Yaw** ensures all of your objects will be facing different directions. This is another box you should keep checked if you want your scene to feel more realistic!

![ArtIntro1](../../img/EnvironIntro/image9.png "Art Screenshot1")
![ArtIntro2](../../img/EnvironIntro/image42.png "Art Screenshot2")
*Randomized Yaw unchecked (left) vs. checked (right)*
{: .image-cluster}

![ArtIntro](../../img/EnvironIntro/image23.png "Art Screenshot"){: .center}

If you would like to randomize the color of your spawned objects check **Use Random Color**. Most objects in real life aren't the same color, however setting the correct min and max RGB values can be tricky… it can be hard to understand if you aren't already familiar with how RGB values are assigned. Unfortunately we won't be covering it in this tutorial!

![ArtIntro1](../../img/EnvironIntro/image9.png "Art Screenshot1")
![ArtIntro2](../../img/EnvironIntro/image44.png "Art Screenshot2")
*Randomized Color unchecked (left) vs. checked (right)*
{: .image-cluster}

![ArtIntro](../../img/EnvironIntro/image25.png "Art Screenshot"){: .center}

**In-Between Distance** controls how far apart objects are from each other in meters. If **Distance** is set to `5`, each object will spawn in the center of a 5x5 meter square. Higher numbers means objects will spawn further apart.

![ArtIntro1](../../img/EnvironIntro/image9.png "Art Screenshot1")
![ArtIntro2](../../img/EnvironIntro/image33.png "Art Screenshot1")
*In-Between Distance set to 5 (left) vs. set to 2 (right)*
{: .image-cluster}

**Position Randomness** is a percentage that randomizes the placement of each object based on what **In-Between Distance** is set to. If Distance is set to `5` and **Randomness** is set to `0`, each object will spawn in exactly the center of a 5x5 square. If you set **Randomness** to `1`, each object will spawn up to 5 meters away (100% of **Distance**) from the center of it's square. If you set **Randomness** to `2`, each object will spawn up to 10 meters away (200% of **Distance**) from the center of it's square.

TL;DR: The higher **Position Randomness** is set to, the more displaced objects spawned will be.

![ArtIntro1](../../img/EnvironIntro/image9.png "Art Screenshot1")
![ArtIntro2](../../img/EnvironIntro/image3.png "Art Screenshot2")
![ArtIntro3](../../img/EnvironIntro/image31.png "Art Screenshot3")
![ArtIntro4](../../img/EnvironIntro/image20.png "Art Screenshot4")
*Randomness set to 0 (top left), Randomness set to 0.5 (top right), Randomness set to 1 (bottom left), Randomness set to 3 (bottom right)*
{: .image-cluster}

Leave **Spawn Upright** unchecked if you want your objects to spawn aligned to the terrain. It's best to leave **Spawn Upright** unchecked for organic things like plants and trees.

![ArtIntro1](../../img/EnvironIntro/image37.png "Art Screenshot1")
![ArtIntro2](../../img/EnvironIntro/image8.png "Art Screenshot2")
*Spawn Upright unchecked (left) vs. checked (right)*
{: .image-cluster}

Checking **Only Spawn On Terrain** ensures spawned objects will only spawn on the terrain - if left unchecked they will spawn on anything underneath the object selected in the **Hierarchy**.

![ArtIntro1](../../img/EnvironIntro/image38.png "Art Screenshot1")
![ArtIntro2](../../img/EnvironIntro/image39.png "Art Screenshot2")
*Only Spawn on Terrain checked (left) vs. unchecked (right)*
{: .image-cluster}

Keep **Group In Folder** checked to spawn all new objects in a folder. This helps keep your Hierarchy organized.

You can also spawn individual objects using the **Object Generator**'s settings by placing your cursor in the scene and pressing <kbd>SHIFT</kbd> + <kbd>X</kbd> with an object selected in the **Core Content** tab. The object will spawn under your cursor. This allows you finer control over an object's placement without having to worry about randomizing its rotation, scale, or color. -->

### Spawn More Desert Objects

Continue using the **Object Generator** to decorate your scene. When you are done, delete the duplicate water cube.

<!-- TODO: Summary Text
## Summary
-->

![ArtIntro](../../img/EnvironIntro/image45.png "Art Screenshot"){: .center}
