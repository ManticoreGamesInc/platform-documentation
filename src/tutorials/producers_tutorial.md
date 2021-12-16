---
id: producers_tutorial
name: Producers, Buffs and Areas Tutorial
title: Producers, Buffs and Areas Tutorial
tags:
    - Tutorial
---

# Producers, Buffs and Areas Tutorial

<!--- TODO add video --->

## Overview

In this tutorial, you learn about the [Producers, Buffs, and Areas](../references/producers.md) Example Project which builds off the [Gatherables and Inventory](../references/gatherables.md) Example Project. The project allows creators to design games around **producers** which transform items into different items over time, **buffs** which provide customizable restrictions on the producers, and **areas** which allow the world space to be divided into distinct pieces which can be loaded on demand.

This tutorial will be making a system to produce an Alien Raptor. The player will start with an Alien Egg in their inventory. The player needs to place a Terminal and Incubator machine in the Scifi area. In order for the Incubator to receive an Electricity buff, it needs to be placed close to the Terminal. With the buff, the player can place the Alien Egg into the Incubator and wait for it to produce an Alien Raptor. If the player takes too long to collect the Alien Raptor, then the Alien Egg will burn and produce a Burnt Egg instead.

* **Completion Time:** ~1 hour
* **Knowledge Level:** No Lua scripting involved, but basic [Core Editor](../getting_started/editor_intro.md) knowledge is recommended.
* **Skills you will learn:**
    * Creating **Inventory Items**
    * Creating a **Placeable Area**
    * Creating a **Producer** item
    * Creating **Placeable** items
    * Creating a **Buff**
    * Using a **3D Icon Generator**

## Creating a New Producers, Buffs and Areas Project

### Download from the CREATE Menu

The **Producers, Buffs and Areas** Example Project can be found in the **CREATE** menu alongside the Empty and Framework project options.

![!Creating a New Producers Project](../img/Producers/Producers_CreateNewProject.png){: .center loading="lazy" }

1. In Core, click the **CREATE** tab at the top to open options for new and existing projects.
2. In the top bar menu of **CREATE**, select **NEW PROJECT**.
3. In the **EXAMPLE PROJECTS** section, select **Producers, Buffs and Areas**.
4. Give the project a name in the **Name** field and press the **CREATE** button.

### Open the Basic Camp Fire Example

The project is divided into Scenes which showcase distinct ways the Producers, Buffs and Areas systems can be used to create gameplay. To access the Scenes window, click Window in the top toolbar and select Scenes. Double-click the **Basic Camp Fire Example** to the load the correct scene.

![!All Producers Example Scenes](../img/Producers/Producers_Scenes.png){: .center loading="lazy" }

### Test the Cooked Fruit System

The Basic Camp Fire Example scene, has a working example where the player can cook fruit. This tutorial will be using this example as a guide to make a completely different system.

Test the game and make sure the following works.

1. Use the **number keys** to equip items in the **Hotbar Inventory** displayed at the bottom.
2. Use the **left mouse button** to place/use items down when applicable.
3. Place a **Campfire Ring** item on the **Dirt** area and then place the **Fire Spit** item on top of it.
4. Place **Firewood** into the campfire ring and light it with the **Matches**.
5. Place the **Red Fruit** item onto the fire spit.
6. Collect the **Cooked Fruit** and wait for the fire to burn out to collect **Charcoal**.
7. Relight a new fire and place another fruit. This time do not collect until the fruit burns.
8. Use the **Hammer** item to break down and collect placed items.
9. Press ++F1++ to **reset the Player's Data** (clears the Area and resets the Inventory).

<!--- TODO add video --->

## Creating a Scifi Placeable Area

Currently there is a single **Player Lot** with a **Dirt Placeable Area** within it. This signifies where the player can place certain items and have it be saved between play sessions. There will be a new **Scifi Placeable Area** in the same Player Lot that will handle the Alien Raptor production.

<!--- TODO add pic --->

### Duplicate the Dirt Placeable Area

In the Hierarchy, expand the **Player Lot** group. Select the **Dirt (Farmable Area)** group and duplicate it using ++Ctrl+W++. Rename the duplicated group to `Scifi (Incubating Area)`.

<!--- TODO add pic --->

### Modify the Scifi Area Properties

Select the **Scifi (Incubating Area)** group and open the **Properties** window. Set the custom **AreaType** property to `Scifi`. This string will need to match the placeable item properties later on.

<!--- TODO add pic --->

### Modify the Scifi Area Material

Inside the **Scifi (Incubating Area)** group, select the **Cube** object and open the **Properties** window. Set the **Material** property to `Animated Glowing Hex`.

<!--- TODO add pic --->

### Transform the Areas

The Dirt and Scifi areas are on top of each other. The cubes for each of these areas need to be resized and moved so they are both visible.

1. Select the **Cube** within the **Scifi (Incubating Area)** group.
2. Activate **Scale Mode** by pressing ++R++ and shorten the width of the cube by half.
3. Activate **Translation Mode** by pressing ++W++ and move the cube to the side.
4. Select the **Cube** within the **Dirt (Farmable Area)** group.
5. Activate **Scale Mode** by pressing ++R++ and shorten the width of the cube by half.
6. Activate **Translation Mode** by pressing ++W++ and move the cube to the side.

<!--- TODO add pic --->

## Creating an Alien Egg

The Alien Egg will be an item starting in the player's inventory. It will need 3 templates for being held in the player's hand, dropped on the floor, and seen in the inventory slot.

These are the templates for the Red Fruit item. Note they all have the same art model but are transformed to the desired context (e.g. laying on the ground or placed in the player's hand).

<!--- TODO add pic --->

### Create the Art Model

The art model for the egg will be a simple mesh shape with a material on it.

1. Open the **Core Content** window and search for `Ovoid 01`.
2. Drag and drop the mesh into the **Hierarchy**.
3. Rename the mesh to `Alien Egg Model`.
4. Select the mesh and open the **Properties** window.
5. Set the **Material** property to `Plastic Matte`.
6. Set the **Color Override** to a green color.

<!--- TODO add pic --->

### Duplicate the Red Fruit Item

In the Hierarchy, open the **Global Database** folder and then expand the **Items** script. Any item that will be placed in the inventory will need data in this group. Right click the **Red Fruit** script and select **Duplicate**. Rename the duplicated Red Fruit script to `Alien Egg`.

<!--- TODO add pic --->

### Open the Alien Egg Properties

Select the Alien Egg and open the Properties window. There are many custom properties for each item.

<!--- TODO add table --->

### Change the Name and Description

Set the **Name** property to `Alien Egg`. Then, set the **Description** property to `An egg with an alien embryo inside.`.

<!--- TODO add pic --->

### Change the Drop Template

The **DropTemplate** property should already have a template from the Red Fruit item named **Product - Fresh Red Fruit (Drop Icon)**. The template contains a Geo group with the mesh displaying the red fruit item on the ground.

1. Click the **Find in Asset Catalog** button <!--- TODO add icon ---> to the right of the **DropTemplate** property to open the Project Content window with the template selected.
2. Drag and drop the **Product - Fresh Red Fruit (Drop Icon)** template into the scene besides the Alien Egg Model.
3. Right click the template and select **Deinstance This Object**.
4. Right click the **Alien Egg Model** in the Hierarchy and select Duplicate.
5. Drag and drop the duplicated Alien Egg Model into the **Geo** folder of the **Product - Fresh Red Fruit (Drop Icon)**.
6. Position the duplicated Alien Egg Model to be on top of the red fruit (Basic Pepper 02).
7. Resize the duplicated Alien Egg Model to the desired in-game size.
8. Delete the **Basic Pepper 02** mesh from the Geo folder.
9. Right click **Product - Fresh Red Fruit (Drop Icon)** and select **Create New Template From This**.
10. Name the template `Alien Egg (Drop Icon)`.
11. Delete the **Alien Egg (Drop Icon)** template from the Hierarchy.
12. Search the Hierarchy for the `Alien Egg` script and open the Properties window.
13. Set the **DropTemplate** property to **Alien Egg (Drop Icon)**.

<!--- TODO add pic --->

### Change the Icon Asset

The Icon Asset template has three different options to display an inventory icon. The option used for the red fruit template requires knowledge of the **Icon Generator**.

!!! info "The Icon Generator"
    The Icon Generator is a component used to render 3D icons. It uses a remote camera in a black box to capture an image of a template. The black box should be moved in a published project to a place out of sight.
    <!--- TODO add pic --->

#### Duplicate the Icon Asset

The template for the icon asset is usually a particular size to get a clear capture on the camera. This is why using the red fruit icon asset as a base will make the process easier.

1. Open the Project Content window and search for `Product - Fresh Red Fruit (Inventory Icon)`.
2. Drag and drop the **Product - Fresh Red Fruit (Inventory Icon)** template into the scene besides the Alien Egg Model.
3. Right click the **Product - Fresh Red Fruit (Inventory Icon)** and select **Deinstance This Object**.
4. Right click the **Alien Egg Model** in the Hierarchy and select Duplicate.
5. Drag and drop the duplicated Alien Egg Model into the **Geo** folder of the **Product - Fresh Red Fruit (Inventory Icon)**.
6. Position the duplicated Alien Egg Model to be on top of the red fruit (Basic Pepper 02).
7. Resize the duplicated Alien Egg Model to match the red fruit.
8. Delete the **Basic Pepper 02** mesh from the Geo folder.
9. Right click **Product - Fresh Red Fruit (Inventory Icon)** and select **Create New Template From This**.
10. Name the template `Alien Egg (Inventory Icon)`.
11. Delete the **Alien Egg (Inventory Icon)** template from the Hierarchy.
12. Search the Hierarchy for the `Alien Egg` script and open the Properties window.
13. Set the **IconAsset** property to **Alien Egg (Inventory Icon)**.

<!--- TODO add pic --->

#### Visualize the Icon

As long as the **Alien Egg (Inventory Icon)** matched the red fruit icon template, then it will most likely produce a clear inventory icon. However, it is good to know how the **Icon Generator** is placing the template in front of the capturing camera in case adjustments are needed.

1. In the Hierarchy, expand the **UI** folder and right click the **Icon Generator** and select **Desinstance This Object**.
2. Inside the Icon Generator, expand the **ClientContent** group and find the **Icon Container** group.
3. Open the Project Content window and search for `Alien Egg (Inventory Icon)`.
4. Drag and drop the template into the **Icon Container** group in the Hierarchy.
5. Select the **Alien Egg (Inventory Icon)** and press ++F++ to focus the editor camera on it. The model should be centered and contained inside a gray box indicating the capture frame.
6. If necessary, adjust the **Alien Egg Model** and update the **Alien Egg (Inventory Icon)** template.
7. Delete the **Alien Egg (Inventory Icon)** template from the Hierarchy.

<!--- TODO add pic --->

### Change the Equipment Visual Template

The Equipment Visual Template is the attached player equipment if an item is selected. The red fruit's equipment has a specific position and rotation to fit in the player's hand.

1. Click the **Find in Asset Catalog** button <!--- TODO add icon ---> to the right of the **EquipmentVisualTemplate** property to open the Project Content window with the template selected.
2. Drag and drop the **Product - Fresh Red Fruit (Held)** template into the scene besides the Alien Egg Model.
3. Right click the template and select **Deinstance This Object**.
4. Right click the **Alien Egg Model** in the Hierarchy and select Duplicate.
5. Drag and drop the duplicated Alien Egg Model into the **Geo** folder of the **Product - Fresh Red Fruit (Held)**.
6. Position the duplicated Alien Egg Model to be on top of the red fruit (Basic Pepper 02).
7. Resize the duplicated Alien Egg Model to the desired in-game size.
8. Delete the **Basic Pepper 02** mesh from the Geo folder.
9. Right click **Product - Fresh Red Fruit (Held)** and select **Create New Template From This**.
10. Name the template `Alien Egg (Held)`.
11. Delete the **Alien Egg (Held)** template from the Hierarchy.
12. Search the Hierarchy for the `Alien Egg` script and open the Properties window.
13. Set the **EquipmentVisualTemplate** property to **Alien Egg (Held)**.

<!--- TODO add pic --->

## Starting with an Alien Egg

## Creating a Burnt Egg

## Creating an Alien Raptor

## Creating an Incubator

## Creating a Terminal

## Creating an Electricity Buff

## Creating an Incubator Placeable

## Creating a Terminal Placeable

## Creating an Incubating Egg Producer

## Learn More

[Producers, Buffs, and Areas Reference](../references/producers.md) | [Gatherables and Inventory Reference](../references/gatherables.md)
