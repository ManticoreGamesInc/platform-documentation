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

### Modifying the Ability Animations


1. Add another `ability` to the `weapon` as a child.

2. Change the name of the ability to "FireBombAttackAbility".

3. We're going to change the animations first, as this is the most dramatic visual change to make firing look correct.

    1. Change the animation string to "2hand_staff_magic_bolt" so that it looks better when firing.

    2. On the AttackAbility that already exists on the weapon, change the animation string to "2hand_staff_magic_bolt" as well.

    3. On the ReloadAbility, change the animation string to "2hand_staff_magic_up" to make it look like you're calling upon the magic of the gods to be rejuvinated.

6. Use the VFX section of the simple weapon tutorial to create cool VFX for your weapon, and lean into fire themes to match the look of this fire staff.


### Right Click to Aim

We're going to add the ability to focus zoom with right click for better aiming!

1. First, we're going to add a bunch of custom properties to the weapon--custom properties give us a nice place to add variables that can be easily changed without having to open the code once it's been written!

     1. To start we need a custom property added to the weapon object of type boolean called "*EnableAim*". Check this on to allow the weapon to zoom in for aiming!

     2. Add a custom property to the weapon object called "*AimBinding*" that is type String. Give it the value "*ability_secondary*". This is for picking what ability binding, or keyboard key, to press to activate the ability. Ability secondary, in this case, is right click on a mouse.

     3. Add another custom property of type string and call it "*AimActiveStance*". Set the value to "*2hand_rifle_aim_shoulder*". This determines what animation pose is used while aiming.

     4. Add a custom property of type Float and call it "*AimWalkSpeedPercentage*". Give it a value of .5. This value will determine what fraction of the regular walk speed the player will move while aiming.

     5. Lastly for this part, add a custom property called "*AimZoomDistance*" of type integer, and give it a value of 100. This assigns how far the camera zooms in when aiming.

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

5. Now let's tackle one of those functions used in the above `Tick()` function.

     First, we'll do the `LerpCameraDistance(deltatime)`.

     1. Below is the code for this function:
         ```lua
         function LerpCameraDistance(deltaTime)
            if lerpTime >= 1 then return end
            if not activeCamera then return end

            lerpTime = lerpTime + deltaTime
            activeCamera.currentDistance = CoreMath.Lerp(activeCamera.currentDistance, cameraTargetDistance, lerpTime)
         end
         ```

6. Now we need a function that accesses the camera for the local player, so that we can change it when we want to.

     1. To do this, copy the code below beneath your function from the previous step.
         ```lua
        function GetPlayerActiveCamera(player)
            if not Object.IsValid(player) then
                return nil
            end

            if player:GetOverrideCamera() then
                return player:GetOverrideCamera()
            else
                return player:GetDefaultCamera()
            end
        end
         ```

7. The above is followed directly by another function--`EnableScoping(player)`. This turns on the aiming!

     1. Again, beneath the above code, type:
         ```lua
         function EnableScoping(player)
             if player.isDead then return end
             cameraTargetDistance = ZOOM_DISTANCE
             lerpTime = 0
             Events.Broadcast("WeaponAiming", player, true)
         end
         ```

8. Now we need a function to reset the aiming back to default when not zoomed in.

     1. To reset the camera distance, use the code below.
         ```lua
         function ResetScoping(player)
             cameraTargetDistance = cameraResetDistance
             lerpTime = 0
             Events.Broadcast("WeaponAiming", player, false)
         end
         ```

9. These next two functions are specifically for turning on and off being zoomed in--if the player presses the assigned ability binding key, then it triggers the functions we wrote to enable and reset scoping!

     1. Add these two functions below to the bottom of your script so far:
         ```lua
         function OnBindingPressed(player, actionName)
             if actionName == AIM_BINDING then
                 EnableScoping(player)
            end
         end

         function OnBindingReleased(player, actionName)
             if actionName == AIM_BINDING then
                 ResetScoping(player)
            end
         end
         ```

10. Now that we've added all these functions for how to initiate aiming, we need to protect for a case that could break how zooming-in works: what happens when the player dies.

     1. To reset the camera back to normal when the player dies, let's add this function:
         ```lua
         function OnPlayerDied(player, damage)
             ResetScoping(player)
         end
         ```

11. So, we've added functions for how to make the camera change zoom amounts, but we still need to pull all of this together to connect our functions to the built-in events of CORE equipment and player events.

     1. We're going to start with making the `OnEquipped()` function that we are calling already in the Tick function we first wrote.

         ```lua
         function OnEquipped(weapon, player)
             if not CAN_AIM then return end

             pressedHandle = player.bindingPressedEvent:Connect(OnBindingPressed)
             releasedHandle = player.bindingReleasedEvent:Connect(OnBindingReleased)
             playerDieHandle = player.diedEvent:Connect(OnPlayerDied)

             -- Set new active camera
             activeCamera = GetPlayerActiveCamera(player)
             if activeCamera then
                 cameraResetDistance = activeCamera.currentDistance
                 cameraTargetDistance = cameraResetDistance
             end
             lerpTime = 0
         end
         ```

     2. Now we need the other half of that, the `OnUnequipped()` function that disconnects things and resets data.

         ```lua
         function OnUnequipped(weapon, player)
             if not CAN_AIM then return end

            if (pressedHandle) then pressedHandle:Disconnect() end
            if (releasedHandle) then releasedHandle:Disconnect() end
             if (playerDieHandle) then playerDieHandle:Disconnect() end

             ResetScoping(player)

             -- Remove the reference to the camera
             if activeCamera then
                 activeCamera.currentDistance = cameraResetDistance
                 activeCamera = nil
             end
         end
         ```

     3. Last but not least, all `weapon` objects come with a built-in unequip event that happens when the player unequips the weapon. So, we need to connect the function that we built to this event to cause our function to happen at the right moment.

         ```lua
         WEAPON.unequippedEvent:Connect(OnUnequipped)
         ```  

So this was the first half of the camera aim setup--we have created a script for the client context, that only each individual player uses. The next part is the script that will live in a server context, as this is the part that needs to be replicated back to the server.

This server script will seem fairly similar to the client script, but this one is directly changing and affecting variables of the player.

So let's get started on the server script!

1. Create a new script and call it "*WeaponAimServer*".  

2. In your project Hierarchy, nagivate to the Fire Staff `weapon` object. Right click this object, and hover over "*Create Network Context*" to select "*New Server Context*".  

     Here is where we will keep our new script!  

3. Drag the *WeaponAimServer* script into the Server Context folder that we just created.

4. Next is adding in the coding sections--open up the new script to begin.

5. We first need to access the custom variables we created on the `weapon`. This will look really similar to the WeaponAimClient script.  

     1. Start with creating a reference to the `weapon` itself so that we can find the variables, and the safety error checking we made just like last time.  

         ```lua
         local WEAPON = script:FindAncestorByType('Weapon')
         if not WEAPON:IsA('Weapon') then
             error(script.name .. " should be part of Weapon object hierarchy.")
         end
         ```  

     2. Now we'll want to create in-script variables that use the custom variables we put on the weapon. To access these, use the code below:  

         ```lua
         local CAN_AIM = WEAPON:GetCustomProperty("EnableAim")
         local AIM_BINDING = WEAPON:GetCustomProperty("AimBinding")
         local AIM_WALK_SPEED_PERCENTAGE = WEAPON:GetCustomProperty("AimWalkSpeedPercentage")
         local AIM_ACTIVE_STANCE = WEAPON:GetCustomProperty("AimActiveStance")
         ```  

     3. Next comes the variables we need to create so that we can use them later:  

         ```lua
         local speedReduced = 0
         local pressedHandle = nil
         local releasedHandle = nil
         local playerDieHandle = nil
         local UNARMED_STANCE = "unarmed_stance"
         ```  

6. Now that we've created our variables, we can get into the function writing! We'll start with a function that sets the walking speed of the player while they are aiming.  

     1. Type the following function below all the variables in your script.  

         ```lua
         function SetAimingSpeed(player)
             if Object.IsValid(player) and player == WEAPON.owner then
                 speedReduced = player.maxWalkSpeed * AIM_WALK_SPEED_PERCENTAGE
                 player.maxWalkSpeed = player.maxWalkSpeed - speedReduced
                 player.animationStance = AIM_ACTIVE_STANCE
             end
         end
         ``` 

7. Going along with setting the walk speed, we need a function to reset the player's speed back to normal when they are not zoomed in.  

     1. The code below is a function that will reset the player's walk speed--add this beneath the previous function.  

         ```lua
         function ResetPlayerSpeed(player)
             if WEAPON and Object.IsValid(player) then
                 player.maxWalkSpeed = player.maxWalkSpeed + speedReduced
                 player.animationStance = WEAPON.animationStance
                 speedReduced = 0
             end
         end
         ``` 

8. Similar to the WeaponAimClient script, we now need functions that trigger our speed-modifying functions by binding them to the buttons the player will press.  

     1. First comes the function for when a button is pressed:  

         ```lua
         function OnBindingPressed(player, actionName)
             if actionName == AIM_BINDING then
                 SetAimingSpeed(player)
            end
         end
         ```  

     2. Followed by a function for when a button is released:  

         ```lua
         function OnBindingReleased(player, actionName)
             if actionName == AIM_BINDING then
                 ResetPlayerSpeed(player)
            end
         end
         ```      

     3. Another way we need to reset the speed of the player is when they die--check out the code below for doing this:  

         ```lua
         function OnPlayerDied(player, damage)
             ResetPlayerSpeed(player)
         end
         ```  

9. The most important functions for bringing this all together are the `OnEquipped()` and `OnUnequipped()` functions. Just like in the other script, but affecting the speed and animations rather than the camera movements, we'll create both.  

     1. Use this code for the `OnEquipped()` portion, and as usual, type it directly beneath the previous section:  

         ```lua
         function OnEquipped(weapon, player)
             if not CAN_AIM then return end

             pressedHandle = player.bindingPressedEvent:Connect(OnBindingPressed)
             releasedHandle = player.bindingReleasedEvent:Connect(OnBindingReleased)
             playerDieHandle = player.diedEvent:Connect(OnPlayerDied)
         end
         ```  

     2. Then comes the `OnUnequipped()` section:  

         ```lua
         function OnBindingReleased(player, actionName)
             if actionName == AIM_BINDING then
                 ResetPlayerSpeed(player)
            end
         end
         ```  

10. On to the last step for camera movement! Similar to the *WeaponAimClient* script, we need to connect the functions we wrote to the built-in events that happen on a `weapon` object.  

     1. At the very end of your script, beneath all the other functions, add these two lines of code to connect the functions:  

         ```lua
         WEAPON.equippedEvent:Connect(OnEquipped)
         WEAPON.unequippedEvent:Connect(OnUnequipped)
         ```  

Now, if you hit play to test out your weapon, you should be able to zoom in when you hold right click!  

### Critical Hit

- go over the short script that Tung included in AdvancedRifle called WeaponDamageShootServer
- it jsut defines what a headshot is and does more damage when the shot is a headshot

### Ammo as a Pickup

One way to really change gameplay and force players to explore a map and be more resourceful is to give the weapon a limited ammo supply. Eventually, they'll have to go look for more. 

With this fire staff, we could use something thematic and firey like *ember* as an ammo pickup.

The main thing to change for our ammo supply is to change the properties of the `weapon` itself.

1. With the fire staff selected, scroll in the **Properties** window down to the **Ammo** section.

     Check the box that says "Finite Ammo Supply" on.

2. Change the **Ammo Type** to "*embers*". This name will need to match the resource we create for our player to pick up.

3. Now we need to build the ammunition pickup itself.  

     1. We'll start by creating a `trigger` object for our player to interact with.  

         Navigate to **CORE Content**, and drag a `trigger` object from the Gameplay Objects section into your project Hierarchy.

     2. So now we have the object that handles the player running into it, but we need something for the player to actually see in-game.  

         This can be anything you want--for a Fire Staff, a spark-looking object could be cool.  

         Choose whatever object you would like from CORE Content, and drag it onto the `trigger` in the Hierarchy. From there, edit it however you would like.  

         Right click this object and create a group containing this.

     3. Now that you have this group containing your ember shape, right click it and create a New Client Context Containing This. In general, you always want to keep art in client context or server context folders, to allow the game to run more smoothly.

4. That settles the art portion--now for the script that will make the game magic happen!  

     1. Within your project content, create a new script and call it "EmberPickupScript".  

     2. Drag this script onto the Trigger in your project Hierarchy.

     3. Open the script. The first thing we'll need is a reference to the trigger itself, so that we can access the events that it comes with.  

         This line is very quick and simple since the script is a child of the trigger:  

         ```lua
         local trigger = script.parent 
         ```  

     4. Now we need a function that determines what to do when the player touches the trigger. We want it to add 1 unit of ammo to the player's resources, and then we want to destroy the ammo object so that they cannot keep picking up the same one.  

         We can do all these things in one function--use the code below to get this to happen!  

         ```lua
         function OnBeginOverlap(whichTrigger, other)
            if other:IsA("Player") then
                print(whichTrigger.name .. ": Begin Trigger Overlap with " .. other.name)
                other:AddResource("embers",1)
                print("Player has "..tostring(other:GetResource("embers")).." embers.")
                trigger:Destroy()
            end
         end
         ```  

     5. Lastly, we need to connect the function we just made to the trigger's built-in event for overlapping.  

         Add this code to the very bottom of your script:  

         ```lua
         trigger.beginOverlapEvent:Connect(OnBeginOverlap)
         ```  

### Connecting UI

You'll likely want to set up User Interface (UI) for your magic staff's abilities. For a refresher on how to set this up, check out the **[Ability Tutorial](/tutorials/gameplay/abilities/#core-component-ability-display)**'s section on UI.

## Examples

* _Spellshock_ includes advanced abilities using ability objects.
* _CORE Content_ includes pre-made and ready-to-use weapons! Check in Components > Weapons to see what is available. Compare what we made here with "Advanced" weapons to see what is possible.
