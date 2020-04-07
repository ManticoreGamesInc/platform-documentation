---
id: custom_materials
name: Custom Materials in Core
title: Custom Materials in Core
tags:
    - Reference
---

# Custom Materials in Core

## Overview

Materials are the way to change the appearance of an object, using a complete package of shaders and textures. Core has a variety of different materials to chose from, and each can be modified in different ways to create **custom materials**.

![Sample Materials](../img/Materials/SampleMaterials.png){: .center}

## Applying Materials

### Find the Current Material

The material on an object can be found by in the **Properties** menu. Most shapes start out with the blue **Grid Basic** material, which is the default for all basic shapes.

![Materials](../img/Materials/image5.png "Materials Screenshot"){: .center}

### Multiple Materials

Some objects have multiple material slots, such as the **Cube - Arcade 04** object, allowing you to further customize the look of your game.

![Materials](../img/Materials/image13.png "Materials Screenshot"){: .center}

### Change Materials by Dragging and Dropping from Core Content

The easiest way to change materials is to drag the material onto an object in the **Main Viewport**. You can also drag the material into a specific slot in the **Properties** window.

   ![Materials](../img/Materials/image18.png "Materials Screenshot"){: .center}

### Change Materials Using the Properties Window

The **Material Picker** allows you to select a new material for an object from a list of all the available materials.

1. Select the object and open the **Properties** window.
2. Double click the image of the material to open the **Material Picker**.
3. Select a material to be applied to the object.

   ![Materials](../img/Materials/MaterialPicker.png "Materials Screenshot"){: .center}

### Change the Color of a Material

The base color of a material can be changed using the **Material Override** property.

1. Open the object's **Properties** window and scroll to the appropriate material section.
2. Double click the colored box next to the **Material Override**.
3. Select a color in the **Color Picker** window that pops open, and click **OK** to apply the color to the material.

![Materials](../img/Materials/ColorPicker.png "Materials Screenshot"){: .center}

## Smart Material

**Smart Materials** are textures that align to the world, rather than the object. This makes it easy to seamlessly connect two objects using the same material.

### Enable and Disable Smart Material

**Use Smart Material** is enabled by default on materials that have repeating patterns.

1. Select an object and open the **Properties** window.
2. Scroll down to the Material section.
3. Check or uncheck **Use Smart Material**.

![Materials](../img/Materials/image16.png "Materials Screenshot"){: .center}

#### Smart Materials On

These two cubes both have the red brick material applied. Because they both have **Use Smart Material** checked, the brick pattern is projected the same way onto the two objects.

![Materials](../img/Materials/image10.png "Materials Screenshot"){: .center}

#### Smart Materials Off

These two cubes both have the red brick material applied but they do not have "Use Smart Material" checked. The texture is aligned to the object, so it is stretched and looks different on these two differently sized cubes.

![Materials](../img/Materials/image11.png "Materials Screenshot"){: .center}

### Z Fighting

Objects with different materials or objects not using the Smart Materials feature may exhibit **z-fighting**. This flickering is caused when different materials are layered over one another. Z-fighting can be distracting when playing games, so it's best to avoid it.

![Materials](../img/Materials/image14.gif "Materials Screenshot"){: .center}

### U/V Tiling

When you uncheck **Use Smart Material**, two more customization options appear: **U Tiling Override** and **V Tiling Override**.

- **U Tiling Factor** controls how many times the pattern repeats on the X axis.
- **V Tiling Factor** controls how many times the pattern repeats on the Y axis.

#### U Tiling and V Tiling both set to 1

![Materials](../img/Materials/image7.png "Materials Screenshot"){: .center}

#### U Tiling set to 3 and V Tiling set to 1

![Materials](../img/Materials/image8.png "Materials Screenshot"){: .center}

#### U Tiling set to 1 and V Tiling set to 3

![Materials](../img/Materials/image3.png "Materials Screenshot"){: .center}

#### U Tiling and V Tiling both set to 3

![Materials](../img/Materials/image12.png "Materials Screenshot"){: .center}

## Custom Materials

Custom materials allow you to finely tune any Core material beyond one color and the U/V tiling.

### Create a Custom Material

There are two ways to create a custom material for your project.

#### From Core Content

1. Find a material to customize in **Core Content**.
2. Right-click and select **New Custom Material**.
3. Open the **Project Content** window and select **My Materials**.
4. Double click on the new custom material to open the **Material Editor**.

Your new custom material can be found in the My Content > Local Materials section under the Project Content tab. Edit your custom material by double clicking its name. It will be called "Custom -Name of Material-".

![Materials](../img/Materials/image17.png "Materials Screenshot"){: .center}

#### From an Object

1. Select an object and open the **Properties** window.
2. Scroll down to the material.
3. Click the **New Custom Material** button.
4. Click the ![Pencil](../img/EditorManual/icons/Icon_Edit.png) icon to open the **Material Editor**.
{: .image-inline-text .image-background}

### Use the Material Editor

The **Material Editor** allows you to customize values for each type of material.

![Materials](../img/Materials/MaterialEditor.png){: .center}

Some materials have properties specific to them. For example, the ceramic materials have **Damage Amount** and **Cracks**, allowing for a more distressed look. Hover over any property name to read what it does.

![Materials](../img/Materials/image6.png "Materials Screenshot"){: .center}

### Rename a Custom Material

Change the name of each custom material by editing the text field at the top of the **Material Editor**. This will allow you to easily find and re-use the material on different objects in the game.

## Learn More

[Environmental Art](environmental_art.md) | [Modeling Basics](modeling_basics.md)
