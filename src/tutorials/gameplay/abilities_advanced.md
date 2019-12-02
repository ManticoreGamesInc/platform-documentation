# Advanced Abilities in CORE

!!! warning
    Flagged for Review.
    Incomplete or outdated information may be present.

    TODO:  

    - Add & Updates Images  

    - Complete tutorial sections

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

### Setting up the Basics

To begin, let's set up the look of the fire staff and create our weapon object. Open the project you wish to use, or an empty project.

1. Create an empty `weapon` object by dragging one into your Hierarchy from the Gameplay Objects section of CORE Content.

2. Just like in the first weapon tutorial, we are going to create a Client Context folder within the weapon to hold the model of the staff.  

     1. You can combine shapes in whatever way you like with the help of an **[Art Tutorial](/tutorials/art/modeling_basics/)** or **[Reference](/tutorials/art/art_reference/)**, or you can use the Community Content asset [uhhhhhhh] as your fire staff.  

3. In the weapon's Properties, make sure to uncheck the box for "Is Hitscan Weapon" so that is still fires actual projectiles. Hitscan weapons have immediate impact on whatever they're firing at, so the projectile wouldn't need to travel through the air first.

4. Create a bullet template, just like in the first tutorial--go for something thematic like a sphere with a custom Plasma material applied!

### Modifying the Abilities


1. Add another `ability` to the `weapon` as a child.

2. Change the name of the ability to "FireBombAttackAbility".

3. We're going to change the animations first, as this is the most dramatic visual change to make firing look correct.  

    1. Change the animation string to "2hand_staff_magic_bolt" so that it looks better when firing.

    2. On the AttackAbility that already exists on the weapon, change the animation string to "2hand_staff_magic_bolt" as well.

    3. On the ReloadAbility, change the animation string to "2hand_staff_magic_up" to make it look like you're calling upon the magic of the gods to be rejuvinated. 

6. Use the VFX section of the simple weapon tutorial to create cool VFX for your weapon, and lean into fire themes to match the look of this fire staff.


### Create Camera Feedback

We're going to add the ability to focus zoom with right click for better aiming!

1. First, we're going to add a bunch of custom properties to the weapon--custom properties give us a nice place to add variables that can be easily changed without having to open the code once it's been written!

     1. Add a custom property to the weapon object called "*AimBinding*" that is type String. Give it the value "*ability_secondary*". This is for picking what ability binding, or keyboard key, to press to activate the ability. Ability secondary, in this case, is right click on a mouse.

     2. Add another custom property of type string and call it "*AimActiveStance*". Set the value to "*2hand_rifle_aim_shoulder*". This determines what animation pose is used while aiming. 

     3. Add a custom property of type Float and call it "*AimWalkSpeedPercentage*". Give it a value of .5. This value will determine what fraction of the regular walk speed the player will move while aiming.

     4. Lastly for this part, add a custom property called "*AimZoomDistance*" of type integer. This assigns how far the camera zooms in when aiming.

2. Now we're going to build the script! Create a new script and call it "WeaponAimClient".

3. Open this script, removing any existing text, and let's start by accessing our variables.

     1. We first want to create a reference to the weapon object, so type this at the top of the script:

         ```lua
         local WEAPON = script:FindAncestorByType('Weapon')
         ```  

     2. To protect ourselves from putting this script in the wrong place, we can add an error check into the script. Beneath the above line, add:  

         ```lua
         if not WEAPON:IsA('Weapon') then
             error(script.name .. " should be part of Weapon object hierarchy.")
         end
         ```  

         This will check if the parent of this script is a `weapon`, based on the line we wrote above first! If it is not, it will give us the error message.

     3. Next we need to create references to those custom properties we made earlier on the weapon. To do this, add the code below to your script:  

         ```lua
         local CAN_AIM = WEAPON:GetCustomProperty("EnableAim")
         local AIM_BINDING = WEAPON:GetCustomProperty("AimBinding")
         local ZOOM_DISTANCE = WEAPON:GetCustomProperty("AimZoomDistance")
         ```  

         Just like with the `WEAPON` variable, these variables are in all-capitals. This is because they are constants--meaning they will never change while the script is running.

     4. Now we need empty variables for use in future functions, so beneath the above variables, add this:  

         ```lua
         local pressedHandle = nil
         local releasedHandle = nil
         local playerDieHandle = nil
         ```  

     5. Lastly for variables is creating values to hold the camera settings. Copy or type the text below into your script, below everything else so far:  

         ```lua
         local cameraResetDistance = 0
         local cameraTargetDistance = 0
         local lerpTime = 0
         local activeCamera = nil
         ```  

     Now we have our variables set up! Next is getting into creating the functions that use these variables.  

4. To get a better understanding of what we're going to be making, let's set up the `Tick()` function.  

     The `Tick()` function happens constantly while the game runs, creating a loop of time flowing. The parameter `deltaTime` within it is the difference in seconds between this tick and the last tick.  

     1. First, we don't want the script to do anything unless we are actively aiming, so we need a line that breaks out of the `Tick` loop.  

         After that line, we use another `if` statement to determine if the weapon already had an owner, and if not, then it runs the `OnEquipped` function to set up the weapon camera's ownership to the player that equipped it.  

         Lastly, to stay smooth in movement, we use the function `LerpCameraDistance(deltaTime)` to smoothly move the camera to a new position.  

         All of this together reads like this:  

         ```lua
         function Tick(deltaTime)
             if not CAN_AIM then return end

             -- Setup the new weapon camera owner
             if WEAPON and WEAPON.owner and activeCamera == nil then
                 OnEquipped(WEAPON, WEAPON.owner)
             end

             -- Smoothly lerps the camera distance when player aims
             LerpCameraDistance(deltaTime)
         end
         ``` 



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

The main thing to change for our ammo supply is to change the properties of the weapon itself.

1. With the fire staff selected, scroll in the Properties window down to the Ammo section.  

     Check the box that says "Finite Ammo Supply" on.

2. Change the "Ammo Type" to fire. This name will need to match the resource we create for our player to pick up.

### Connecting UI

You'll likely want to set up User Interface (UI) for your magic staff's abilities. For a refresher on how to set this up, check out the **[Ability Tutorial](/tutorials/gameplay/abilities/#core-component-ability-display)**'s section on UI. 

## Examples

* _Spellshock_ includes advanced abilities using ability objects.
* _CORE Content_ includes pre-made and ready-to-use weapons! Check in Components > Weapons to see what is available. Compare what we made here with "Advanced" weapons to see what is possible.
