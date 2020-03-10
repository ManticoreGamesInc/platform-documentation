---
id: custom_materials
name: Custom Materials in Core
title: Custom Materials in Core
tags:
    - Reference
---

# Custom Materials in Core

!!! warning
    Flagged for Review.
    Incomplete or outdated information may be present.

## Overview

Learn how to fully customize a material.

* **Completion Time:** > 10 minutes
* **Knowledge Level:** No prior knowledge of Core
* **Skills you will learn:**
    * Smart materials
    * Z-fighting
    * UV Tiling
    * Creating a custom material

![Materials](../../img/Materials/image19.png "Materials Screenshot"){: .center}

## Tutorial

### Changing Materials

Materials can be changed by looking at an object's Property tab. If you have experimented with applying different materials to objects in your game, you may have noticed most shapes have the blue "Grid Basic" applied to them. This is the default primitive material.

![Materials](../../img/Materials/image1.png "Materials Screenshot"){: .center}

![Materials](../../img/Materials/image5.png "Materials Screenshot"){: .center}

Some objects have multiple material slots, such as the Cube - Arcade 04 object, allowing you to further customize the look of your game.

![Materials](../../img/Materials/image13.png "Materials Screenshot"){: .center}

You can change an object's material a few different ways:

1. Double clicking the material name in the properties tab will open a window with all available materials. Select one to swap materials.

2. Drag a material from the Core Content tab into the material slot in the object's Property tab.

   ![Materials](../../img/Materials/image15.png "Materials Screenshot"){: .center}

3. Drag a material from the Core Content tab onto the object in the scene.

   ![Materials](../../img/Materials/image18.png "Materials Screenshot"){: .center}

Changing a material's color is as easy as clicking on the color block in the Materials section of the property tab and selecting a new color with the color picker.

### Smart Materials

![Materials](../../img/Materials/image16.png "Materials Screenshot"){: .center}

"Use Smart Material" is usually checked by default. Smart Materials are textures that align to the world, not the object. This makes it easier to seamlessly connect two objects using the same material.

![Materials](../../img/Materials/image10.png "Materials Screenshot"){: .center}

These two cubes both have the red brick material applied. Because they both have "Use Smart Material" checked, the brick pattern is perfectly projected onto the two objects.

![Materials](../../img/Materials/image11.png "Materials Screenshot"){: .center}

These two cubes both have the red brick material applied but they do not have "Use Smart Material" checked. The texture is aligned to the object, so it is stretched and looks different on these two differently sized cubes.

![Materials](../../img/Materials/image14.gif "Materials Screenshot"){: .center}

Additionally, objects with different materials or objects not using the Smart Materials feature may exhibit z-fighting, pictured above. This flickering is caused when different materials are layered over one another. Z-fighting can be distracting when playing games, so it's best to avoid it when you can.

### U and V Tiling Factor

Notice when you uncheck "Use Smart Material" two more customization options appear. "U Tiling Factor" and "V Tiling Factor" sliders are now available for you to further customize the look of your material.

U Tilling Factor controls how many times the pattern repeats on the X axis.

V Tilling Factor controls how many times the pattern repeats on the Y axis.

![Materials](../../img/Materials/image7.png "Materials Screenshot"){: .center}

Red brick material with U Tiling and V Tiling both set to 1.

![Materials](../../img/Materials/image8.png "Materials Screenshot"){: .center}

Red brick material with U Tiling set to 3 and V Tiling set to 1.

![Materials](../../img/Materials/image3.png "Materials Screenshot"){: .center}

Red brick material with U Tiling set to 1 and V Tiling set to 3.

![Materials](../../img/Materials/image12.png "Materials Screenshot"){: .center}

Red brick material with U Tiling and V Tiling both set to 3.

### Creating a New Custom Material

If you want to change more than one color and the U/V Tiling of a material, you'll have to create a custom material. Custom materials allow you to finely tune any material in Core's engine. By saving a custom material preset you can easily update every object in game using your custom preset with one click.

Create a new custom material by right clicking on a material in the Core Content. Your new custom material can be found in the My Content > Local Materials section under the Project Content tab. Edit your custom material by double clicking its name. It will be called "Custom -Name of Material-".

![Materials](../../img/Materials/image17.png "Materials Screenshot"){: .center}

Double clicking on the material will open the Material Editor window.

![Materials](../../img/Materials/image2.png "Materials Screenshot"){: .center}

You can change the name of each custom material by editing the text field at the top of the material editor. In order to easily edit your material, apply it to an object in your scene. Every time you change a property of your material, click "Update Material" otherwise you won't see your changes reflected in the viewer.

![Materials](../../img/Materials/image9.png "Materials Screenshot"){: .center}

Some materials have properties specific to them. For example, the ceramic materials have "Damage Amount" and "Cracks" allowing for a more distressed look. The easiest way to discover how each property visually affects the material is by reading the tool tip (hover over the property's name) or by simply experimenting.

![Materials](../../img/Materials/image6.png "Materials Screenshot"){: .center}

![Materials](../../img/Materials/image4.png "Materials Screenshot"){: .center}

<!-- TODO: Summary Text
## Summary
-->
