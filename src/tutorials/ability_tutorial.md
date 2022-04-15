---
id: abilities
name: Abilities in Core
title: Abilities in Core
tags:
    - Tutorial
---

# Abilities in Core

## Overview

In this tutorial you will create an ability that can be picked up in the world, and when activated, the player will wave. You will be using Core Content components that can be place in the Hierarchy, so no Lua knowledge is needed.

* **Completion Time:** 10 minutes
* **Knowledge Level:** No prior knowledge required
* **Skills you will learn:**
    * How to create an ability.
    * How to use an animation.
    * How to set up UI connected to an ability.

<div class="mt-video" style="width:100%">
    <video autoplay muted playsinline controls loop class="center" style="width:100%">
        <source src="/img/AbilityTutorial/preview.mp4" type="video/mp4" />
    </video>
</div>

---

## What is an Ability

In Core, an **Ability** is an object that holds information about how to behave when used. You can set how long the ability lasts for, the cooldown of the ability until the player can use it again, and all sorts of other properties. For example, an ability could allow the player to sprint when they activate an action.

## Create Equipment

**Equipment** is an object that can be equipped to the player, and any Ability objects that are children of the Equipment are added to the Player automatically.

1. Click on the **Gameplay Objects** category under **GAME OBJECTS** in the **Core Content** window.
2. Add the **Equipment** object to the **Hierarchy**.
3. Make sure the **Position** of the Equipment in the **Properties** windows is set to 0 for **X**, **Y**, and **Z**.

![!Equipment](../img/AbilityTutorial/equipment.png){: .center loading="lazy" }

### Set Equipment Trigger

By default, an Equipment object will be equipped to the player when they overlap the trigger. Let us change that so the player needs to interact with the trigger to equip it.

1. Click on the **BoxTrigger** that is a child of the **Equipment** object.
2. In the **Properties** window, enable **Interactable**, and set the **Interaction Label** to `Pickup Equipment`.

![!Trigger](../img/AbilityTutorial/trigger.png){: .center loading="lazy" }

## Create a new Binding

The **Default Binding** set will need a new binding added to detect when the player presses the key to trigger the ability.

Open up the **Bindings Manager** window from the Window menu, or by double clicking on the **Default Binding** set in **My Binding Sets** found in the **Project Content** window.

![!Bindings Window](../img/BindingSets/General/bindings_window.png){: .center loading="lazy" }

### Add Binding

From the **Bindings Window**, click on the **Add Bindings** button and add a new **Basic Binding** to the binding set.

1. In the **Action** field, enter `Wave`.
2. From the **Keyboard Primary** drop down, select the **1** key.

![!Add Binding](../img/AbilityTutorial/add_binding.png){: .center loading="lazy" }

## Create Ability

An Ability will handle playing the waving animation when the player presses the **1** key, which is tied to the **Wave** action in the Binding Set.

1. Find the **Ability** object In **Gameplay Objects** in the **GAME OBJECTS** category of the **Project Content** tab.
2. Add the Ability object as a child of the **Equipment** object in the **Hierarchy**.
3. Rename the Ability object to `Wave`.

![!Add Ability](../img/AbilityTutorial/add_ability.png){: .center loading="lazy" }

### Set Ability Properties

There are some properties on the ability that need to be set. One of those is the **Action Name** that is used to trigger the ability. In this case the binding is set to **1** with an action name of **Wave**.

Abilities have a lot of other properties that can be changed to customize how the ability behaves. For example, the cooldown of the ability could be made shorter or longer.

1. Set the **Action Name** property to `Wave`.
2. Change the **Animation** property to `unarmed_wave`.

![!Properties](../img/AbilityTutorial/props.png){: .center loading="lazy" }

## Create Ability Display

Having some UI (User Interface) that displays on screen for players can be useful so they know they have an ability. This can give them helpful information such as which key binding to press, and if the ability is on cooldown.

1. In Core Content, search for `abilities display` and add it to the **Hierarchy**.
2. Right-click on the object in the **Hierarchy** and select **Deinstance Template**.
3. Inside the object, open up the **Abilities Container** and delete one of the **Ability Display Panel** objects.
4. Click on the other **Ability Display Panel** and in the Properties window, set the **ActionName** property to `Wave`.
5. Feel free to adjust the **Icon** for the ability by open up the group and change the image for the **Icon** object.

![!Display](../img/AbilityTutorial/display.png){: .center loading="lazy" }

## Test the Game

Test the game to make sure the equipment can be picked up and pressing the key **1** activates the ability and makes the player character wave.

<div class="mt-video" style="width:100%">
    <video autoplay muted playsinline controls loop class="center" style="width:100%">
        <source src="/img/AbilityTutorial/preview.mp4" type="video/mp4" />
    </video>
</div>

## Summary

There are a lot of use cases for abilities, and combined with Lua scripts, you can make some advanced abilities that suit your game. Checkout [Spellshock 2](https://www.coregames.com/games/f8b143/spellshock-2) which has a lot of unique abilities players can use.

## Learn More

[Ability API](../api/ability.md) | [Binding Sets](../references/binding_sets.md) | [Advanced Abilities](../tutorials/abilities_advanced.md) | [Equipment API](../api/equipment.md) | [Animations](../api/animations.md)
