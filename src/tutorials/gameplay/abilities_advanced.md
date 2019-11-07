## Overview

Abilities can get as complicated as you would like them to get. 

With the power of Lua scripting, abiliites can cause different chains of events to happen, as well as trigger visual effects and sound effects to really make something awesome.

In the first ability tutorial, we went over the quickest possible way to get something cool happening at the press of a button. In  this more advanced tutuorial, we are going to utilize the Lua scripting language to make something much more powerful and fun.

If you're fresh and new to any kind of programming, it would be good to visit the Intro to Lua tutorial. This will go over some key words and practices you would want to know.

![Heavy Slash](/docs/img/EditorManual/Abilities/ComplexAbilities/Heavy Slash.GIF)

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

![Ability States](/docs/img/EditorManual/Abilities/Ability States.png)

To tie functionality to the different phases of an ability, CORE uses **Events**. Each phase has an event that is activated at the very beginning of that phase. 

A created function can be connected to these events, using `:Connect(ability_name)` within a script.

Connecting functions to events in an ability is the main task to be done when creating an ability, and is what makes each one different and infinitely customizable.

!!! info "Customize Your Ability"
    A magical spell might have a long cast time, whereas a punch would have a very short if not instant cast time.

---

## Altering Properties the Easy Way: The Ability Object

CORE allows building gameplay with as little or as much scripting as you would like. A powerful aspect of abilities is that they are kept in an Ability Object. This is a single Hierarchy object that holds all the most useful proprties you might want to change to make your specific ability unique.

Using an Ability object in combination with scripting makes it similar to a data structure; it is a nice single location to test different variables.

---

## Tutorial

In this tutorial, we will be making a magic staff that the player can pick up, granting them two different abilities. The data for these abilities will be kept in Ability Objects.

So, let's make magic!

### step 1



### CORE Component: Ability Display

link to this in intro tutorial?

## Examples

*FAA_GameMode* includes functioning abilities.  
*Spellshock* includes advanced abilities using ability objects. 