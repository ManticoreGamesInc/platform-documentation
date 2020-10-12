---
id: abilities
name: Abilities in Core
title: Abilities in Core
tags:
    - Tutorial
---

# Abilities in Core

## Overview

An ability is anything that the player can do themselves.

Anytime that a player can do something more than just jump and crouch, that should be added to a Core project as an ability. Abilities are how a creator can add functions that a player can activate, and these abilities can be anything.

An ability could be to sprint, a cheering emote, the opening of a hidden menu; an ability can be anything that ought to happen on a button press or at a certain moment, repeatedly.

!!! info
    Comparing with Unreal and other game engines, an ability is basically a fancier keyboard input. "Fancier" because it has events built-in that can be set at each phase of execution.

* **Completion Time:** 10 minutes
* **Knowledge Level:** No prior knowledge required
* **Skills you will learn:**
    * How to create an ability
    * How to use an animation
    * How to set up UI connected to an ability

<video autoplay loop muted playsinline poster="/img/EditorManual/Abilities/Gem.png" class="center">
    <source src="/img/EditorManual/Abilities/unarmed_wave.webm" type="video/webm" alt="Create an Ability"/>
    <source src="/img/EditorManual/Abilities/unarmed_wave.mp4" type="video/mp4" alt="Create an Ability"/>
</video>

---

### What is an Ability

In Core, an `Ability` is an object that holds information about how to behave when used. You can set how long the ability lasts for, how long until the ability can be used a second time, and all sorts of other properties.

While there are ways to utilize all these properties, for your first dive into abilities, we're just going to touch on the very basics.

Abilities can either be assigned to players at the start of a game, or when they equip a special item.

---

## Tutorial

Adding a simple ability to a game is only a couple of steps. We'll go over how to activate an animation on a button press, with no coding necessary!

We're going to make a piece of equipment that the player can pick up, and when they do, they will gain a new ability.

For this tutorial, we are going to make the player wave hello.

### Getting Started with Equipment

1. With Core open to a project, navigate to the **Core Content tab**, and scroll down to the bottom of the left side panel list to the **GAME OBJECTS** section. Select **Gameplay Objects**, and drag an **Equipment Object** into the project **Hierarchy**.

    ![Hierarchy Collapsed](../img/EditorManual/Abilities/GameObjects.png "Hierarchy Collapsed"){: .center loading="lazy" }

    This will add an **Equipment** object to your project Hierarchy. `Equipment` comes with a `PickupTrigger` that allows players to equip the object when the player touches it.

    ![Hierarchy Collapsed](../img/EditorManual/Abilities/EquipmentInHierarchy.png "Hierarchy Collapsed"){: .center loading="lazy" }
    ![Hierarchy Uncollapsed](../img/EditorManual/Abilities/EquipmentInHierarchy2.png "Hierarchy Uncollapsed"){: .center loading="lazy" }

    When you drag the `Equipment` into the project **Hierarchy**, it will drop into your game scene at the location (0,0,0) which will look like the image below if you started in an empty project. **If you do not see anything**, press "V" on the keyboard to toggle the **gizmos** (all the game-only objects) on.

    ![A trigger at 0,0,0](../img/EditorManual/Abilities/trigger000.png "This trigger is halfway into the ground."){: .center loading="lazy" }

    This box you are seeing is the `PickupTrigger`, which is what allows you to pick up the equipment! When a player walks into this, they will immediately "equip" the equipment.

2. With the `Equipment` object selected in the **Hierarchy**, check out the **Properties** window. Scroll down to the section titled "Equipment".

    Change the **Socket** property from "head" to "pelvis".

    The **Socket** property determines _where_ the equipment will be attached to the player--we want the equipment to disappear, so for simplicity we will attach it somewhere that it will be hidden by the player's body.

    Doing these first two steps will already let you pick up the `Equipment` when playing the game and walking through it--but it is hard to pick up something you can't see!

3. To make this a more usable power-up object, let's add a model to it that players can see.

    You can choose whatever you would like and would fit your game, but in my case I am going to use a classic gem.

    1. In the **Core Content** tab, search for "diamond" and drag the `Gem - Diamond 6-Sided Polished` into your Project Hierarchy.

        ![Basic Gem Model](../img/EditorManual/Abilities/Gem.png "Basic Gem Model"){: .center loading="lazy" }

        Feel free to change the material, or make the model suit your own game more. To learn more about how to make cool art & models in Core, read our **[Art Reference Guide](art_reference.md)** or try a **[Tutorial](modeling_basics.md)**.

        I went with a simple red gem, and made it a little smaller than the default diamond.

        ![Red Gem Model](../img/EditorManual/Abilities/redGem.png "Red Gem Model"){: .center loading="lazy" }

    2. Drag it onto the `Equipment` object and it will become a child of the `Equipment` object. It will prompt you to make the Gem _Networked_, and select "Make Children Networked" when this window appears.

        For better organization, right click the Gem object and select "New Group Containing This", and name it "Art".

        ![Art Folder](../img/EditorManual/Abilities/EquipmentInHierarchy3.png "Art Folder"){: .center loading="lazy" }

    3. In the **Properties** window, scroll down to the _Scene_ section. We need to change the **Collision** section from "Inherit From Parent" to "Force Off". This way the gem won't mess with your camera when it's attached to the player.

        ![Art Folder Collision](../img/EditorManual/Abilities/ArtFolderCollision.png "Art Folder Collision"){: .center loading="lazy" }

    4. Right click the Art folder, and hover over **"Create Network Context..."** to select **"New Client Context Containing This"** to ensure better performance for the game by wrapping the art in a Client Context.

        Now that we've created a visible object that can be picked up, it needs to do something!

4. Before we set up the animation to work, let's make sure everything is together. So far in this tutorial, if you have been dragging things directly into the project Hierarchy, they should all be sitting at the (0,0,0) position of the game world.

    Make sure everything is together in the spot you expect, and that your art model and equipment trigger are in the same location.

    You might even want to drag the whole thing upwards so that the trigger rests on top of the floor rather than halfway into the floor! When you want to move the whole thing, be sure to move the root folder: the `Equipment` object.

    All together, it should look something like this:

    ![Everything together at 0,0,0](../img/EditorManual/Abilities/trigger000withGem.png "This equipment setup is fully above the ground now."){: .center loading="lazy" }

5. Now to set up the animation! Navigate back to the **Core Content** tab and the **Gameplay Objects** section, and this time drag an **Ability Object** into your project **Hierarchy**.

    1. Click on the `Ability` object and drag it onto the `Equipment` object to make it a child of the `Equipment` object.

        ![Ability Object in Hierarchy](../img/EditorManual/Abilities/EquipmentInHierarchy4.png "Ability Object in Hierarchy"){: .center loading="lazy" }

    2. Rename the `Ability` object to "Wave" by clicking on the `Ability` object and pressing F2. This can also be done by right clicking and selecting "Rename", or by changing the name at the top of the **Properties** panel.

    Now when the player picks up the equipment, they will automatically gain the `Ability`! Of course, we still need to set it up to cause the wave animation.

6. The `Ability` object starts with default settings in the **Properties** window. To make our own wave, we only need to change two things:

    1. With the `Ability` object selected, navigate to the **Properties** window and scroll down to the _Ability_ section to change the **Action Binding** property to "Ability Feet".

        The Key Binding is which button will activate the ability. In this case, _Ability Feet_ is the ++shift++ key on keyboards.

    2. Still in the **Properties** window and right beneath the Key Binding, change the **Animation** property to `unarmed_wave`.

        ![Ability Properties Panel](../img/EditorManual/Abilities/AbilityPropertiesChange.png "Ability Properties Panel"){: .center loading="lazy" }

7. Abilities also affect how the camera works when the ability is used, and in the case of this wave animation, it would be nice to be able to face the camera when we do it. To make sure this happens:

    1. With the ability selected, in the **Properties** window, scroll down to the **Cast** section. We want to change the Facing Mode from _Aim_ to **_None_** so that our camera is not affected in that stage of the ability.

        ![Facing Mode](../img/EditorManual/Abilities/FacingModeNone.png "Change the Facing Mode to "None.""){: .center loading="lazy" }

    2. Do the same thing to the Facing Mode in the **Execute** section.

**Now the ability is fully useable!** When you play your game, pick up the object, and then press ++shift++, you will be able to wave hello!

!!! info "Good Object Placement"
    If you haven't moved your `Equipment` object at all so far, your gem may be clipping into the ground! Feel free to move the whole `Equipment` object upwards to make it both easier to see and simpler to pick up.

  If you'd like to change the amount of time between when you use (also known as **Cast**) an ability, this can be altered within the `Ability` object!

  1. In the **Properties** window for the ability object, scroll down to the section called **Cooldown**.

  2. Change the **Duration** property. This is in seconds, so by default 3 seconds must pass after using your dance before you can use it again.

    Increase or lower this to suit your gameplay needs.

    ![Ability Properties Panel: Cooldown](../img/EditorManual/Abilities/CooldownDuration.png "Ability Properties Panel: Cooldown"){: .center loading="lazy" }

  Of course, it would be nice to know when the ability has been activated, and how long it will be until you can use it again display on-screen.

  For this we need UI!

---

### Core Component: Ability Display

A crucial part of a video game is the feedback it gives--players need to know that they're using an ability.

While you can make a User Interface _(often abbreviated to UI)_ element yourself, there is a pre-made template within **Core Content** that we can use to very quickly set up simple UI for our new ability!

When the `Ability` is in the Cooldown phase, it will darken the ability button and show the seconds remaining until the `Ability` is usable again.

<video autoplay loop muted playsinline poster="/img/EditorManual/Abilities/Gem.png" class="center">
    <source src="/img/EditorManual/Abilities/abilityDisplay.webm" type="video/webm" alt="Ability Display"/>
    <source src="/img/EditorManual/Abilities/abilityDisplay.mp4" type="video/mp4" alt="Ability Display"/>
</video>

To get this to work correctly with the `Ability` we made above, there are only a few steps:

1. In **Core Content**, search for the **Ability Display** object, and drag this into your **Hierarchy**. It can also be found in the category Game Components > UI.

2. If you now click this object from within the **Hierarchy**, the **Properties** tab will show a few custom properties that we need to change to set up the ability display.

    ![Ability Control](../img/EditorManual/Abilities/AbilityButtonProperties.png "Ability Control"){: .center loading="lazy" }

    1. Change the **Binding** property from `ability_primary` to `ability_feet`.
    2. Change the **Text** field to ++shift++ , to stand for left-shift.
    3. Check the **ShowAbilityName** property, so that "Wave" will display over the button.

    What is really the key here is the **Binding** property--this connects whatever ability is currently connected to that binding to the Ability Display.

3. To make sure our icon symbol matches our ability, shift-click the AbilityBindingDisplay in the **Hierarchy** to expand all of the children subfolders.

    Select the **Icon** object, and from within the **Properties** window, double-click the **Image** property to choose from all of Core's other built-in UI icons.

    In my case, I chose the "Icon hand" image!

    ![Hierarchy](../img/EditorManual/Abilities/ComponentHierarchy.png "Hierarchy"){: .center loading="lazy" }

Now the UI element will update automatically once the ability is cast.

**Congrats on creating your first ability!** You are well on your way to making anything you can imagine a reality.

<video autoplay loop muted playsinline poster="/img/EditorManual/Abilities/Gem.png" class="center">
    <source src="/img/EditorManual/Abilities/unarmed_wave_full.webm" type="video/webm" alt="Wave Full"/>
    <source src="/img/EditorManual/Abilities/unarmed_wave_full.mp4" type="video/mp4" alt="Wave Full"/>
</video>

---

### Networking for Multiplayer Games

Abilities themselves work in multiplayer games perfectly without any extra programming effort. If you made your own ability UI icon and did not use the Core Content template above, the UI will not update properly in multiplayer games. For the UI to update as the ability happens, the UI relating to the player's abilities must be placed in a Client Context folder.

This has already been done for us in the Core Content template, so no action is needed!

!!! info "Client Context"
    Generally speaking, all UI related to the player should be in a Client Context folder.

---

## Altering Properties the Easy Way: The Ability Object

Abilities can get more complex, and often you may want to tweak the values in an ability quickly without having to open up scripts.

To create a more advanced ability system and read more about Ability objects, read our **[next tutorial using abilities](abilities_advanced.md)**.

---

## Examples

* **[Spellshock](https://www.coregames.com/games/e23e99658d084ef59897ecee49f5d393)** includes advanced abilities using ability objects.
