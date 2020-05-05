---
id: environment_art
name: Environment Art in Core
title: Environment Art in Core
tags:
    - Tutorial
---

# Environment Art in Core

![Finished Scene](../img/EnvironIntro/EnvironmentalArt/EnvironmentalArt_FinishedScene.png){: .center loading="lazy" }

## Overview

Learn how to generate, sculpt, and paint terrain, as well as adding foliage and a swimmable water post-process effect. This tutorial will focus on making a landscape with a path and river, but can be customize to build any natural environment.

- **Completion Time:** 30 minutes
- **Previous Knowledge:** [Introduction to the Core Editor](editor_intro.md)
- **Skills you will learn:**
    - Creating and sculpting terrain
    - Creating swimmable volumes
    - Painting terrain and foliage
    - Customizing sky templates
    - Adding rain visual effects

## The Terrain Creator

The Terrain Creator tool creates different landscapes using premade HeightMaps.

### Open the Terrain Creator

1. Start from a new empty project.
2. Click the ![Terrain](../img/EditorManual/icons/Icon_Terrain.png) button to open the **Terrain Creator**.
 {: .image-inline-text .image-background}
3. Choose **Generate New Terrain** from the drop down menu.

![Open Terrain Creator](../img/EnvironIntro/edits/TerrainTutorial/OpenTerrainCreator.png){: .center}

### Generate Terrain

There are different options for types of terrain that can be generated in Core. You can click any of the terrain types to see a description of what it will generate.

1. Select **Rocky Hills**.
2. Change the size to ``256 x 256`` voxels and ``0.50`` meters.
3. Click **Generate**.
4. Press ![Play](../img/EditorManual/icons/Icon_Play.png) or <kbd>=</kbd> to explore the newly generated terrain from a player perspective.
 {: .image-inline-text .image-background}

![ArtIntro](../img/EnvironIntro/image36.png "Art Screenshot"){: .center loading="lazy" }

### Rearrange the Scene

You may have fallen through your terrain, and you may see an unusually flat area where Default Floor still exists in the scene.

1. Find the **Spawn Point** in the **Hierarchy** and move it to a new spot, above the terrain and just outside of the default floor.
2. Right click on **Default Floor** in the **Hierarchy** and select **Delete**.
3. Click the ![Terrain](../img/EditorManual/icons/Icon_Terrain.png) **Terrain** button again to see that it now lists the **Terrain (Rolling Hills)** as **Primary**
 {: .image-inline-text .image-background}

!!! note
    Primary Terrain is the terrain in your scene with collision enabled. You can have multiple terrains, but only one that players can actually walk on.

### Apply a Material

Any material can be added to a terrain. However, materials that begin with "Terrain" are designed to be used for terrain and will apply different textures to the steeper and flatter parts of the terrain.

1. Open the **Materials** tab of **Core Content**.
2. Test out different materials by dragging them onto the terrain.
3. Search the **Core Content** tab for  `terrain`.
4. Find **Terrain - Grass** and drag it onto the terrain.

![Add a Material to the Terrain](../img/EnvironIntro/EnvironmentalArt/EnvironmentalArt_AddGrassMaterial.png)

## Terrain Sculpting

### Open the Sculpt Menu

The shape of terrain can be changed using sculpting tools in the **Properties** menu.

1. Select the terrain in the **Hierarchy**.
2. Open the **Properties** window.
3. Click on the ![Terrain Sculpt](../img/EditorManual/icons/Icon_TerrainSculpt.png){: .image-inline-text style="width:2em; background:#15181e"} icon to open the **Sculpt** menu..

![Sculpt Tool Menu](../img/EnvironIntro/edits/TerrainTutorial/SculptToolSetup.png){: .center}

### Create a Flat Area

![Select Level Tool](../img/EnvironIntro/EnvironmentalArt/EnvironmentalArt_ConfigureLevelTool.png){ .center loading="lazy" }

1. In the **Tool** menu, select the ![Level](../img/EditorManual/icons/Icon_TerrainLevel.png){: .image-inline-text style="width:2em; background:#15181e"} **Level** tool.
2. Click on an area that is the ideal height, then drag around it to make the rest of the terrain match.

![Leveled Terrain](../img/EnvironIntro/EnvironmentalArt/EnvironmentalArt_LeveledArea.png){ .center loading="lazy" }

### Carve out a Pond and Stream

1. In the **Tool** menu, select the ![Surface](../img/EditorManual/icons/Icon_TerrainSurface.png){: .image-inline-text style="width:2em; background:#15181e"} **Surface** tool.
2. Change the mode from ![Additive](../img/EditorManual/icons/Icon_TerrainPull.png){: .image-inline-text style="width:2em; background:#15181e"} **Additive** to ![Destructive](../img/EditorManual/icons/Icon_TerrainPush.png){: .image-inline-text style="width:2em; background:#15181e"} **Destructive**.
{: .image-inline-text}
3. Lower the **Strength** value in the **General** subcategory to ``0.1``
4. Click and drag on the terrain to carve bowl shape for a pond, and extend it to a river on either side.

![Carved Pond and River](../img/EnvironIntro/EnvironmentalArt/EnvironmentalArt_CarvePondAndRiver.png){: .center loading="lazy" }

### Smooth the Terrain

1. Change the sculpting tool from ![Terrain Sculpt](../img/EditorManual/icons/Icon_TerrainSurface.png){: .image-inline-text style="width:2em; background:#15181e"} **Surface** to ![Terrain Smooth](../img/EditorManual/icons/Icon_TerrainSmooth.png){: .image-inline-text style="width:2em; background:#15181e"} **Smooth**.
2. Click and drag the pond  and rivers to give it a more natural appearance.

![Smoothed Pond and River](../img/EnvironIntro/EnvironmentalArt/EnvironmentalArt_SmoothedPond.png){: .center loading="lazy" }

## Water and Swimming

### Add a Cube to the Scene

1. Search for a cube in the **Core Content** window.
2. Drag the cube into the scene, above the spaces sculpted for the water.

![Add Cube to Scene](../img/EnvironIntro/EnvironmentalArt/EnvironmentalArt_ResizeACube.png){: .center loading="lazy" }

### Resize and Reposition the Cube

1. Resize the cube until it fills your crater.
2. Move the cube down until it looks like a pool of water inside the sand dunes.

![Move Cube Down for Water](../img/EnvironIntro/EnvironmentalArt/EnvironmentalArt_PositionTheCube.png){: .center loading="lazy" }

### Add a Material

1. Search **Core Content**  for ``water``.
2. Choose a water material, and drag it onto the cube.
3. Preview the scene to see the water in person.

![Cube with Water Material](../img/EnvironIntro/EnvironmentalArt/EnvironmentalArt_AddWaterMaterial.png){: .center loading="lazy" }

!!! note
    Select the **Cube** in the Hierarchy and press <kbd>F2</kbd> to rename it to **Water Cube**.

### Disable Collision on the Water

The water cube now has the appearance of water, but a player will walk over it, rather than into it, because the cube has collision by default.

![Force Off Collision](../img/EnvironIntro/EnvironmentalArt/EnvironmentalArt_ForceOffCollision.png){: .center loading="lazy" }

1. Select the water cube.
2. On the **Properties** window, and find the **Scene** section.
3. Change the **Collision** property to **Force Off**.
4. Preview again to test that you can now pass through the water as a player.

### Use the Underwater Post Process

Now you can pass through the water, but once inside it looks like the volume disappears. We can use the **Underwater Post Process** volume to achieve an underwater effect.

1. Find the **Underwater Post Process** volume under the **Post Processing** section of **Core Content**.
2. Drag it into your scene on top of your water.

![Find Underwater Post Process](../img/EnvironIntro/EnvironmentalArt/EnvironmentalArt_FindUnderwaterPostProcess.png){: .center loading="lazy" }

### Resize the Underwater Post Process

Core makes it easy to copy properties from one object to another. We can use this to make the Underwater Post Process match the size and position of the Water cube.

1. Select the cube that represents the water and open **Properties** window.
2. Click the ![Copy Properties](../img/EnvironIntro/edits/TerrainTutorial/Icon_PropertyCopy.png){: .image-inline-text}**Copy Properties** button in the top right corner.
3. Select the **Underwater Post Process** volume and return to the **Properties** window.
4. Click the ![Paste Properties](../img/EnvironIntro/edits/TerrainTutorial/Icon_PropertyPaste.png){: .image-inline-text} **Paste Properties** button, in the top right corner.
5. Check **Position**, **Rotation** and **Scale** in the menu that pops up and press **Paste Selected Parameter Values**

![Copy and Paste Properties](../img/EnvironIntro/EnvironmentalArt/EnvironmentalArt_CopyPasteProperties.png){: .center loading="lazy" }

### Test Swimming

With the Underwater Post Process in the same area as the water, you should now start swimming automatically when you enter it. Press **Play** to preview and jump in the water. If it is deep enough, your character should switch to the swimming animation. You will also notice some distortion and color in the water. You can change how these work in the **Properties** menu for the Underwater Post Process.

![Swimming](../img/EnvironIntro/EnvironmentalArt/EnvironmentalArt_Swimming.png){: .center loading="lazy" }

## Terrain Painting

### Open the Terrain Painting Tool

The terrain painting tool is also found in the terrain **Properties** tab. Terrains must have painting enabled, and this can be done through the painting menu.

1. Select the terrain in the **Hierarchy**.
2. Open the **Properties** window.
3. Click on the ![Terrain Sculpt](../img/EditorManual/icons/Icon_TerrainPaint.png){: .image-inline-text style="width:2em; background:#15181e"} icon to open the **Paint** menu..
4. Click **Create new terrain material**

This will change the terrain's material to **Terrain Material**, but keep the grassy appearance.

### Choose Materials

To paint terrain, we need to create a palette of materials to use on the terrain. In the **Palette** section, select **Edit Materials**

Each of the Materials, labeled **Material1** through **Material4** corresponds to one of the visible materials in the **Paint** menu. Each has two Materials channels, one for flat sections of the material, **Material Base**, and another for the steeper, vertical sections of the game, **Material Side**.

### Paint a Path

1. In the Edit Materials menu, find **Material2**
2. Click the empty image next to **Material Base** to open the **Material Picker**
3. Select **Bricks Cobblestone Floor 01**
4. Close the Edit Materials menu.
5. Select the second Material in the Paint menu **Palette**
6. In the **General** section, increase the **Target Value** value to ``0.4`` to blend the brick material with the grass.
7. Click and drag where you want a path to create some stones coming out of the grass.

![Terrain Painted Path](../img/EnvironIntro/EnvironmentalArt/EnvironmentalArt_StonePath.png){: .center loading="lazy" }

!!! Hint
    You can hold <kbd>Alt</kbd> while dragging on the scene to unpaint materials from areas that you recently painted.

### Paint the River Bottom

#### Choose the Materials

![Choose Riverbed Materials](../img/EnvironIntro/EnvironmentalArt/EnvironmentalArt_SelectRiverBottom.png){: .center loading="lazy" }

1. In the Hierarchy, click the **eye** icon next to the Water Cube to hide it temporarily.
2. In the Edit Materials menu, find **Material3**
3. Set the **Material Base** to **Rocks River Bed 01**
4. Set the **Material Side** to **Grass and Soil** and close the Edit Materials menu.

#### Paint the River

1. Select the third Material in the Paint menu **Palette**
2. Click and drag along the river to cover it with the new materials.
3. Click the **eye** icon next to the Water Cube to show it again

![Painted River](../img/EnvironIntro/EnvironmentalArt/EnvironmentalArt_PaintedRiver.png){: .center loading="lazy" }

#### Preview the Materials Underwater

Press the **Play** button to preview the new materials under the Underwater Post Process effect by swimming through the river.

![River Materials Underwater](../img/EnvironIntro/EnvironmentalArt/EnvironmentalArt_SwimmingTheRiver.png){: .center loading="lazy" }

### Paint the River Bank

#### Using a Mask

Masks allow you to use more complex shapes in applying a new material.

1. In the Edit Materials menu, find **Material4**
2. Set the **Material Base** to **Rocks River Bed 01**
3. In the **Mask** section, check the **Use Mask** box.
4. Click the image icon in the **Mask** property, and select **Cells**

![Cells Mask for Painting Materials](../img/EnvironIntro/EnvironmentalArt/EnvironmentalArt_PaintWithMask.png){: .center loading="lazy" }

#### Using Wetness

Terrain materials can be further customized **Wetness**. It allows you to make areas look soaked by making them darker and shinier.

1. Select **Wetness** from the **Modifiers** section of the Palette.
2. Click and drag on the edge of the riverbank to give an impression that it is soaked on the edges.

![Painted Wetness Channel](../img/EnvironIntro/EnvironmentalArt/EnvironmentalArt_PaintedWetnessChannel.png){: .center loading="lazy" }

## Foliage

In addition to painting textures, objects can be added to the terrain materials as **foliage**. These will not have collision and will be made to work better on a machine than just adding lots of objects.

### Open the Foliage Tool

In the **Properties** window with the terrain selected, click the tab next to **Paint** called **Foliage**

### Choose Foliage

1. Click the **Add Foliage** button.
2. In the **Static Mesh Picker**, search for ``grass`` to find **Grass Tall**.

### Access Foliage Settings

You should have grass springing up on your terrain as soon as you add the object. Click on the object image that appears now in the **Foliage** tab to see its customizable properties.

![Grass on the Grassy Terrain](../img/EnvironIntro/EnvironmentalArt/EnvironmentalArt_GrassOnGrass.png){: .center loading="lazy" }

### Grow Grass along the River

Next, we're going to change the river to look more like a marsh by filling it with tall grasses.

![Foliage with Tall Grass Selected](../img/EnvironIntro/EnvironmentalArt/EnvironmentalArt_FoliageProperties.png){: .center loading="lazy" }

1. In the **General** section,  change the **Material Channel** to the third material, the one used to paint the river.
2. Change the **Distance Between Instances** to ``2.0m``.
3. In the **Spawn Settings**, change the **Scale** property to have a ``Min 3.0x``.
4. You can now return to the **Paint** menu to repaint with the River bottom material any areas that are missing grasses. The foliage will generate with the terrain paint.

![Grass along the River](../img/EnvironIntro/EnvironmentalArt/EnvironmentalArt_GrassTaller.png){: .center loading="lazy" }

!!! Hint
   If foliage is spawning in unexpected places, use the **Show Debug Material** option in the **Paint** terrain **Palette** menu to check which material is being applied in any area of the terrain.

## Stormy Ambience

In the next few steps, we will focus on making the scene overcast and rainy, as well as adding props. There are many options to customize for different effects.

### Change the Sky

The **Default Sky** in Core is composed of three parts, **Sun Light** and **Sky Light** which are currently the only two sources of light in the scene, and **Sky Dome** which controls the appearance of the sky. Each of these can be customized through the **Properties** menu.

There are other complete sky templates available, as well as the different versions of these individual components.

1. Search for ``sky overcast`` in **Core Content** and find the **Sky Overcast 01** template.
2. Drag the sky template into the scene.
3. Delete the **Default Sky** template.

![Overcast Sky](../img/EnvironIntro/EnvironmentalArt/EnvironmentalArt_Overcast.png){: .center loading="lazy" }

### Customize the Sky

1. Open up the **Sky Overcast 01** folder in the **Hierarchy**.
2. Select the **Environment Fog Default VFX** and open the **Properties** window.
3. In the **Smart** section, change the **Color** property to a bright white.
4. Increase the **Fog Density** property to whatever value gives the scene a misty look.

### Add Rain

1. In **Core Content** search for ``rain`` and add the **Rain Volume VFX** and **Rain Splash Volume VFX** objects to your scene.
2. Place the **Rain Volume VFX** object up in the sky, and expand it using the **Transform Scale** tool to cover the area with droplets falling from the sky
3. Place the **Rain Splash Volume VFX** on the ground and expand it to cover the area under the rain to create splashes on the ground.

![Overcast Sky](../img/EnvironIntro/EnvironmentalArt/EnvironmentalArt_FinishedScene.png){: .center loading="lazy" }

### Finish the Scene

The final step is to add structures and props that finish the scene. See the [Complex Modeling](modeling_reference.md) and [Community Content](community_content.md) reference to learn about creating props and using props made by other Core creators.

## Learn More

[Custom Materials](custom_materials.md) | [Complex Modeling](modeling_reference.md) | [Community Content](community_content.md) | [Visual Effects](vfx_tutorial.md)
