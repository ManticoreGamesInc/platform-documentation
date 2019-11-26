# Modeling Basics

!!! warning
    Flagged for Review.
    Incomplete or outdated information may be present.

## Overview

Learning modelling basics in CORE by making delicious food.

* **Completion time:** ~20 minutes (TODO)
* **Knowledge level:** How to use the transform widget, how to change materials (TODO)
* **Skills you will learn:**
    * Using a reference image
    * Using decals

![ModelingBasics](../../img/ModelingBasics/image15.png "image_tooltip"){: .center}

## Tutorial

This tutorial will show you how easy it is to create realistic in-game objects with very few primitives utilizing materials and decals. We will be making pancakes to learn basic modelling tips and tricks. You are welcome to make whatever you want! Food is a good starting point for beginners because it is easily recognizable and there are plenty of reference images available. (Although you might be hungry by the end of the tutorial!)

### Finding reference images

Almost every artist uses reference images when recreating something. It is hard to remember every single thing about an object; using a reference image will allow you to see small details you would otherwise forget.

![ModelingBasics](../../img/ModelingBasics/image5.png "image_tooltip"){: .center}
_Google is your friend. Searching "**Pancakes**" has given us more than enough reference images!_
{: .image-cluster}

### Makin' pancakes

The key to creating 3D models is to see the basic shapes in your reference image and finding the primitives in Core that best represent that shape. We'll start by making a plate for our pancakes.

#### Setting the Table

![ModelingBasics](../../img/ModelingBasics/image3.png "image_tooltip"){: .center}

Plates are a very straightforward shape. This is a cylinder scaled down.

!!! info "CORE Tip: Use <kbd>W</kbd>, <kbd>E</kbd>, and <kbd>R</kbd> to toggle between _Move_, _Rotate_, and _Scale_ respectively when using the transform widget."

![ModelingBasics](../../img/ModelingBasics/image2.png "image_tooltip"){: .center}

Most plates have a lip or edge that runs around them. These small details make the object look more realistic. I used "**Ring Beveled**" and scaled it down until it looked right.

!!! info "CORE Tip: Use _Snap to Grid_ (<kbd>G</kbd>) to place approximately in your scene. Turn off _Snap to Grid_ to fine tune their placement."

![ModelingBasics](../../img/ModelingBasics/image10.png "image_tooltip"){: .center}

Let's change the material. I used "**Clear Coat**" set to white, but you can use whatever material you want.

#### Making Pancakes

![ModelingBasics](../../img/ModelingBasics/image4.png "image_tooltip"){: .center}

Time to get cooking! Start with one "**Chamfered Cylinder**" and scale it down to pancake size on the plate.

![ModelingBasics](../../img/ModelingBasics/image7.png "image_tooltip"){: .center}

Let's add a little more appeal to this smooshed cylinder. I used "**Stucco Tintable**" in a light yellow color, with "**Use Smart Material**" unchecked. Small objects usually look better with "**Smart Materials**" off, otherwise there isn't enough space to see the material.

Our pancake still looks a little naked, so let's add a few more details.

![ModelingBasics](../../img/ModelingBasics/image16.png "image_tooltip"){: .center}

A lot of pancakes have a crispy edge to them from being fried. I used "**Ring (thin)**" scaled down in a color slightly darker than my pancake to make it look like it'd spent some time in the skillet.

Time...

![ModelingBasics](../../img/ModelingBasics/image12.png "image_tooltip"){: .center}

...to...

![ModelingBasics](../../img/ModelingBasics/image13.png "image_tooltip"){: .center}

...stack!

Copy and paste the "**Chamfered Cylinder and Ring (thin)**". Resize your new pancake and set it slightly off-center. Perfectly stacked pancakes would look unnatural. Repeat until desired stack height is reached.

#### Adding Details

![ModelingBasics](../../img/ModelingBasics/image8.png "image_tooltip"){: .center}

Our pancakes looked like they were undercooked, so I added "**Decal Stains Round 01**" to the top in a brown color to give it a nice crisp on top. They're starting to look good.

!!! info "CORE Tip: To easily place a decal on a surface move your cursor to where you want to place a decal and press <kbd>X</kbd>."

![ModelingBasics](../../img/ModelingBasics/image6.png "image_tooltip"){: .center}

No pancakes should be eaten without butter. Here's a "**Cube - Rounded**" scaled down with "**Plastic Shiny**" material applied in a light yellow color.

![ModelingBasics](../../img/ModelingBasics/image1.png "image_tooltip"){: .center}

Don't forget the maple syrup! This is the "**Liquid Decal**" set to a light yellow color with "**Shape Index**" set to "**5**" (feel free to experiment with the different decale shapes).

#### Time for Garnishes

![ModelingBasics](../../img/ModelingBasics/image11.png "image_tooltip"){: .center}

I added some fruit to our plate for more detail and color. The addition of different shapes and textures makes our pancakes more visually appealing.

![ModelingBasics](../../img/ModelingBasics/image9.png "image_tooltip"){: .center}

The blueberries use the **"Snow 01"** material, the raspberries use "**Clear Coat Reflector Triangle 01**", and the banana slices are "**Birch Leaves 01**" with a decal and small spheres added to them. You wouldn't think each of these materials on their own could be used for fruit - but with the right shape and color they are very convincing!

It's important to remember your player will most likely not be viewing your creations up close - even if they aren't 100% realistic chances are it will go unnoticed.

From far away you can't even tell the raspberries use "**Clear Coat Reflector Triangle 01**".

Try adding your own garnishes using the techniques we used to make the pancakes. Maybe some orange wedges or a side of hash browns? Share your creation on our **#showcase**(TODO) [Discord](https://discord.gg/85k8A7V) channel so others can see what you made!

## Summary

TODO

![ModelingBasics](../../img/ModelingBasics/image15.png "image_tooltip"){: .center}
