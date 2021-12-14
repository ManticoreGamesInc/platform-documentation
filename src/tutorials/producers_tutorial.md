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
