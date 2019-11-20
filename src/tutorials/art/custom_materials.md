# Custom Materials in CORE

!!! warning
    Flagged for Review.
    Incomplete or outdated information may be present.

## Overview

Learn how to fully customize a material.

**Read time:** >10 minutes

**Knowledge level:** No prior knowledge of Core

![alt_text](../../img/Materials/image19.png "image_tooltip"){: .center}

This documentation will cover:

-   Smart materials
-   Z-fighting
-   UV Tiling
-   Creating a custom material

## Changing Materials

Materials can be changed by looking at an object’s Property tab. If you have experimented with applying different materials to objects in your game, you may have noticed most shapes have the blue "Grid Basic" applied to them. This is the default primitive material.

![alt_text](../../img/Materials/image1.png "image_tooltip"){: .center}

![alt_text](../../img/Materials/image5.png "image_tooltip"){: .center}

Some objects have multiple material slots, such as the Cube - Arcade 04 object, allowing you to further customize the look of your game.

![alt_text](../../img/Materials/image13.png "image_tooltip"){: .center}

You can change an object’s material a few different ways:

1. Double clicking the material name in the properties tab will open a window with all available materials. Select one to swap materials.

2. Drag a material from the Asset Manifest tab into the material slot in the object’s Property tab.

![alt_text](../../img/Materials/image15.png "image_tooltip"){: .center}
\

3. Drag a material from the Asset Manifest tab onto the object in the scene.

![alt_text](../../img/Materials/image18.png "image_tooltip"){: .center}

Changing a material’s color is as easy as clicking on the color block in the Materials section of the property tab and selecting a new color with the color picker.

## Smart Materials

![alt_text](../../img/Materials/image16.png "image_tooltip"){: .center}

"Use Smart Material" is usually checked by default. Smart Materials are textures that align to the world, not the object. This makes it easier to seamlessly connect two objects using the same material.

![alt_text](../../img/Materials/image10.png "image_tooltip"){: .center}

These two cubes both have the red brick material applied. Because they both have "Use Smart Material" checked, the brick pattern is perfectly projected onto the two objects.

![alt_text](../../img/Materials/image11.png "image_tooltip"){: .center}

These two cubes both have the red brick material applied but they do not have "Use Smart Material" checked. The texture is aligned to the object, so it is stretched and looks different on these two differently sized cubes.

![alt_text](../../img/Materials/image14.gif "image_tooltip"){: .center}

Additionally, objects with different materials or objects not using the Smart Materials feature may exhibit z-fighting, pictured above. This flickering is caused when different materials are layered over one another. Z-fighting can be distracting when playing games, so it’s best to avoid it when you can.

## U and V Tiling Factor

Notice when you uncheck "Use Smart Material" two more customization options appear. "U Tiling Factor" and "V Tiling Factor" sliders are now available for you to further customize the look of your material.

U Tilling Factor controls how many times the pattern repeats on the X axis.

V Tilling Factor controls how many times the pattern repeats on the Y axis.

![alt_text](../../img/Materials/image7.png "image_tooltip"){: .center}

Red brick material with U Tiling and V Tiling both set to 1.

![alt_text](../../img/Materials/image8.png "image_tooltip"){: .center}

Red brick material with U Tiling set to 3 and V Tiling set to 1.

![alt_text](../../img/Materials/image3.png "image_tooltip"){: .center}

Red brick material with U Tiling set to 1 and V Tiling set to 3.

![alt_text](../../img/Materials/image12.png "image_tooltip"){: .center}

Red brick material with U Tiling and V Tiling both set to 3.

## Creating a New Custom Material

If you want to change more than one color and the U/V Tiling of a material, you’ll have to create a custom material. Custom materials allow you to finely tune any material in CORE’s engine. By saving a custom material preset you can easily update every object in game using your custom preset with one click.

Create a new custom material by right clicking on a material in the Asset Manifest. Your new custom material can be found in the My Content > Local Materials section under the Project Content tab. Edit your custom material by double clicking its name. It will be called "Custom [Name of Material]".

![alt_text](../../img/Materials/image17.png "image_tooltip"){: .center}

Double clicking on the material will open the Material Editor window.

![alt_text](../../img/Materials/image2.png "image_tooltip"){: .center}

You can change the name of each custom material by editing the text field at the top of the material editor. In order to easily edit your material, apply it to an object in your scene. Everytime you change a property of your material, click "Update Material" otherwise you won’t see your changes reflected in the viewer.

![alt_text](../../img/Materials/image9.png "image_tooltip"){: .center}

Some materials have properties specific to them. For example, the ceramic materials have "Damage Amount" and "Cracks" allowing for a more distressed look. The easiest way to discover how each property visually affects the material is by reading the tool tip (hover over the property’s name) or by simply experimenting.

![alt_text](../../img/Materials/image6.png "image_tooltip"){: .center}

![alt_text](../../img/Materials/image4.png "image_tooltip"){: .center}
