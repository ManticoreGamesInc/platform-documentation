# Advanced Abilities in CORE

!!! warning
    Flagged for Review.
    Incomplete or outdated information may be present.

## Overview

While both weapons and abilities can be utilized without having to code, if you *do* use scripting, so much more is possible.

With the power of Lua scripting, abiliites can cause different chains of events to happen, as well as trigger visual effects and sound effects to really make something awesome.

In the first tutorials for abilities and weapons, we went over the quickest possible way to get something cool happening at the press of a button. In this more advanced tutuorial, we are going to utilize the Lua scripting language to make something much more powerful and fun.

If you're fresh and new to any kind of programming, it would be good to visit the **[Intro to Lua tutorial](/tutorials/gameplay/lua_basics_lightbulb/)**. This will go over some key words and practices you would want to know.

![Heavy Slash](../../img/EditorManual/Abilities/ComplexAbilities/Heavy_Slash.gif){: .center}

---

Before doing this tutorial, make sure you've already gone through the Ability tutorial and the Weapon tutorial to understand the basics of how these things work.

We're going to be making a more complex `weapon` that utilizes scripting, and has multiple abilities.

To really see the power that the ability system gives us to make cool gameplay mechanics, you should understand what is happening behind the scenes of an `ability`.

---

### The 4 Phases of an Ability

In CORE™, an ability is treated as 4 separate steps that happen immediately one right after another. This allows for distinctly different things to be programmed by a creator in each phase, creating a more complex overall ability.

The 4 different phases of an ability are:

- **Cast**
    - The wind-up time--this is the prep phase before the ability actually happens.

- **Execute**
    - The actual ability.
    - Whatever the ability is going to do, it happens at this moment.

- **Recovery**
    - Additional ability actions that aren’t part of the main action.

- **Cooldown**
    - The rest period after an ability is finished being cast, and cannot be cast again.


!!! info "A More Natural Example"
    Try thinking of it like the casting of a magical spell:
    Cast: The witch charges up her spell, twirling her wand in the air in preparation.
    Execute: The witch flicks her wand, launching magic sparks at her enemy.
    Recovery: Out of breath from the power, the witch lowers her arm.
    Cooldown: The witch waits for her magic powers to return to her.

Once an ability is triggered to start, it cycles through **Cast** > **Execute** > **Recovery** > **Cooldown**. The amount of time that each phase lasts can be set in the code. These timings would be very different depending on the type of ability being created.

![Ability States](../../img/EditorManual/Abilities/Ability_States.png){: .center}

To tie functionality to the different phases of an ability, CORE uses **Events**. Each phase has an event that is activated at the very beginning of that phase.

A created function can be connected to these events, using `:Connect(ability_name)` within a script.

Connecting functions to events in an ability is the main task to be done when creating an ability, and is what makes each one different and infinitely customizable.

!!! info "Customize Your Ability"
    A magical spell might have a long cast time, whereas a punch would have a very short if not instant cast time.

---

## Altering Properties the Easy Way: The Ability Object

CORE allows building gameplay with as little or as much scripting as you would like. A powerful aspect of abilities is that they are kept in an Ability Object. This is a single Hierarchy object that holds all the most useful proprties you might want to change to make your specific ability unique.

Using an Ability object in combination with scripting makes it similar to a data structure; an ability object is a nice single location to test different variables.

---

## Tutorial

In this tutorial, we will be making a magic fire staff that the player can pick up, granting them two different abilities: a left-click fire burst and a right-click charged fire bomb.

So, let's make magic!

### Setting up the Visuals

To begin, let's set up the look of the fire staff and create our weapon object. Open the project your wish to use, or an empty project.

1. Create an empty `weapon` object by dragging one into your Hierarchy from the Gameplay Objects section of CORE Content.

2. Just like in the first weapon tutorial, we are going to create a Client Content folder within the weapon to hold the model of the staff.  

     1. You can combine shapes in whatever way you like with the help of an **[Art Tutorial](/tutorials/art/modeling_basics/)** or **[Reference](/tutorials/art/art_reference/)**, or you can use the Community Content asset [uhhhhhhh] as your fire staff.  

### Modifying the Abilities

- mainly need to address how to make an ability itself do fancy things, like cause splash AOE damage, as that's pretty much the only thing that can't be done in code. Use code for spawning vfx in a pattern possibly? A weapon can be set up so nicely without code, even have more abilities, but it's the fancy triggering of effects and splash damage and camera stuff that can't be done without code. Need to address stuff people might not be able to just figure out by just looking at API, such as how to effectively use weapon and ability events.

- Tung's advanced weapons use a different camera setup, can zoom in on right click, spread to damage, and has an auto reload. Overall it feels better to use, but it's super subtle.

- Tung's basic weapons don't auto reload because they have infinite ammo, and don't do any sort of fancy things. They are so dang bare minimum, my tutorial goes a bit fancier by explaining reload.

### Create Camera Feedback

- So to model after Tung's advanced systems, the fire staff should change camera setup, have a damage spread, and require gaining more ammo as a pickup to explain how that works.

- This means the advanced tutorial is more about how to modify the camera, how ammo pickups work, and how to make damage spread happen. This can get the user thinking more about ways they can add to and modify the system.

### Critical Hit

-   advanced weapon has headshot damage (critical hits)
-   get the basic weapon function working (shoot a lil fireball)
-   involves creating an attack ability, a reticle, vfx (look what vfx tung used, see how it is triggered, do a simple version of that coding)
- design some sort of reticle, possible do camera shake?
-   set up fireball ammo needing to be recharged
-   add another ability for the right click spot (charge fire blast)
-   involves another ability script, reticle, vfx
-   explain setting up the ability in programming
-   add vfx for ability
-   now it's a weapon with an additional ability
-   probably end here but maybe make longer if something else should be explained? I don't think anything new would happen
-   set up UI, perhaps link to first ability tutorial for reference again on how to set it up or explain again quickly.

### Ammo as a Pickup

- grab them bullets, dude

### Connecting UI

You'll likely want to set up User Interface (UI) for your magic staff's abilities. For a refresher on how to set this up, check out the **[Ability Tutorial](/tutorials/gameplay/abilities/#core-component-ability-display)**'s section on UI. 

## Examples

* _Spellshock_ includes advanced abilities using ability objects.
* _CORE Content_ includes pre-made and ready-to-use weapons! Check in Components > Weapons to see what is available. Compare what we made here with "Advanced" weapons to see what is possible.
