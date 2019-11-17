# Weapons in CORE

!!! warning
    Flagged for Review.
    Incomplete or outdated information may be present.

## Abstract

In a lot of video games, the main character uses a weapon to make their way through the game world. "Weapon" can mean a gun, an axe, or even a tomato grenade.
Programming a weapon can be the most complicated part of making a game, but to make that easier, Core comes with a built-in weapon system!

![A Sniper Rifle](../../img/EditorManual/Weapons/holdingWeaponNew.png)

In Core, a `weapon` is an `equipment` type of object that can be created in any Core project.

There are a lot of differences between a piece of `equipment` and a `weapon`, but the main difference is that all weapons come with one built-in `ability` that handles the main use of the weapon.
This ability is bound to Left Click on the keyboard, and can be used for the traditional guns cycle of shoot-reload that you'd expect from guns-- or for the cast-reel cycle you'd expect from a fishing pole!

Read more about [Equipment] or [Abilities] on their own pages.

When a player picks up or *equips* a weapon object, the player is instantly able to use that weapon and all the abilities that it comes with! So to create a weapon like a rifle, all that needs to be done is to spawn a weapon, modify the settings for how far the weapon can shoot, and equip it to a player.

!!! info
    A weapon can be anything imaginable that the player holds and uses to interact with the world.
    This could be a fishing pole, a wand... anything that the player would use.

## Tutorial

Each step of creating a weapon allows for added creativity. While doing this tutorial you might come up with more ways to fancify your weapon! The tutorial below will walk you through the entire process from an empty project, to using a gun of your own making in a level!

This gun will be placed in the world and the player will need to pick it up to use it.

In this tutorial, we will be adding a really simple gun to an empty project.

### Setting Up the Weapon

!!! info "Steampunk Rifle Model"
    ![Steampunk Rifle](../../img/EditorManual/Weapons/steampunkRifle.png)
     You can download the Steampunk Rifle from **Community Content** on Core to have a ready-made weapon, or you can make your own model from props in Core!

1. The first thing to do is to open the *Object* menu at the top of the editor, and select **Create Weapon**. This adds one empty weapon to your current game's hierarchy.

2. The weapon will be completely "empty" having no visible parts at first!
 The look of the weapon can be made from any Core primitaves and shapes, or you can use the Steampunk Rifle model.
  This model should all be contained in a folder, and this folder should be made a child of the weapon by dragging the folder onto the weapon.
 This attaches the visuals of the weapon to the function of the weapon!
  Your Hierarchy should now look like this:
 ![Initial Hierarchy](../../img/EditorManual/Weapons/hierarchyFirst.png)

3. Right click on that folder of shapes, and click Create Network Context > Create New Client Context Containing This.
This puts a lot less pressure on the game to run well. To understand more about a Client Context, read [the related page].

4. Next, using the same *Object* menu at the top of the editor, click "**Create Box Trigger**".
   We are going to make a gun that will need to be picked up by the player, and to detect whether the player is close enough to the weapon, we need to use a Box Trigger.
    1. In the Box Trigger's Properties, check the Interactable box to be on.
    2. Type "Press F to Equip" in the Interaction Label spot. This is what displays when the player approaches the trigger.

5. To allow the trigger to detect if the player is close enough to the weapon to pick it up, we need to create a script called `PickupWeaponScript`. In the *Asset Manifest*, click the create script button to make a new empty script.

6. Currently, the weapon can't shoot anything! For a bullet to fire out of the gun when using Left Click to fire, a bullet template needs to be dragged into the weapon.
    1. Click on the weapon in the hierarchy. In the Properties window, scroll down to the Projectile section. There is a property called "**Projectile Template**". Here is where we would drag a template for the bullet!
  To do this, let's add a capsule object to our project Hierarchy. This can be found in the *Asset Manifest*, within the Basic Shapes section. Drag one into the viewport, and change the scale to shrink the size until you are satisfied with the bullet shape.
    2. Once you are happy with the bullet shape, right click the object in the Hierarchy and click "New Folder Containing This" to wrap our object in a folder. This needs to be done so that our resizing is saved--whenever a template is spawned in Core, it will always have even 1:1 transformations, which would ruin our shape.
    2. Right click this folder, and click "Enable Networking".
    3. Next, right click this folder again, and click "Create New Template From This".
    4. Once it is a template, delete it from the project Hierarchy. We now can drag that bullet template from our Asset Manifest into the Projectile Template property of the weapon!

7. Drag the `PickupWeaponScript` into the Hierarchy. Then, drag both that script and the BoxTrigger onto the weapon.
 This will cause the trigger and script to be children of the weapon, making it easier to access variables and keep everything contained.

8. Lastly for the setup, right click on the weapon in the Hierarchy, and click "Enable Networking" to allow the gun to be picked up properly.
   The hierarchy should now look like this:

   ![Weapon Hierarchy](../../img/EditorManual/Weapons/hierarchy.png)

### Programming the Weapon

1. The first step to writing this script is being able to access the things that we want. In this case, that would be both the trigger and the weapon. Get a reference to these things by copying the code below and pasting it into the `PickupWeaponScript`:

   ```lua
   local weapon = script.parent
   local trigger = weapon:FindChildByType("Trigger")
   ```

2. To actually make the equipping happen when the player is near the weapon, we need a function connected to an event.
   This code can also be taken from the script generator for Overlap Events, but copy this code below into `PickupWeaponScript`, beneath the references made above:

   ```lua
   function OnInteracted(whichTrigger, other)
       if other:IsA("Player") then
         weapon:Equip(other)
       end
   end
   ```

    This is a function that takes in both a trigger `whichTrigger` and an object `other`. When any Core object overlaps the trigger, it will show a pop up with the text we set on the trigger's Interaction Label, and when interacted with, will cause this function to happen.
    The code inside the function is checking if the `other` object is a player. If `other` is a player, then it does the code contained within it: equip the weapon onto `other`!

3. To tie the function we made to the moment something overlaps the trigger, we need to connect the function to the trigger's interacted event. Copy this code to the very bottom of the `PickupWeaponScript`:

   ```lua
   trigger.interactedEvent:Connect(OnInteracted)
   ```

    This makes use of `EventListeners` to bind a function to an event.
     *More information on EventListeners can be found in the Lua API.*

4. Now that the function we made will actually happen, there is some fixing to be done. If you've tried to hit play and pick up the weapon, it does get picked up, but walking might be impossible. Objects in Core have collision turned on by default, meaning that when the weapon is held in the hand of the player, the overlap in collision with the weapon makes the player movement do crazy things.
 Unless you already turned off the collision of the weapon's shape, this needs to be done in scripting.
   To turn off the collision when the player picks up the weapon, we will want to make a new function and connect it to the equipped event of the weapon. To do this, let's make a new function called `Pickup()`. Copy the code from below and paste it beneath the `OnInteracted()` function, and above the `:Connect()`:

   ```lua
   function Pickup(equipment,  player)
       trigger.isInteractable = false
       weapon.isCollidable = false
   end
   ```

   This turns off both the collision of the shape so that the player can't constantly run into it anymore, and turns off the interaction of the weapon, so that another player cannot walk up and take it from you!

5. You may also notice that the weapon, when equipped, is not at all in the right spot. The animations should be correct, but the weapon position might be through your body or above your head.

 ![Weapon Hierarchy](../../img/EditorManual/Weapons/brokenLocationWeapon.png)

 When equipped, the weapon's origin will snap to the attachment point, which is the player's right hand in this case. The odds are high that the weapon will be held in the wrong spot when equipped the first time.
  **To fix the weapon model's position**, move the folder within the weapon around in the world to find the right spot.
   This takes some experimenting!

6. So that handles what happens when a player picks up a weapon, but what about when they drop it? That interaction and collision needs to be turned back on. The code for that is almost exactly the same, but we will use a separate function called `Drop()`. Copy this code and paste it into your `PickupWeaponScript`, directly beneath the `Pickup()` function:

    ```lua
    function Drop()
        trigger.isInteractable = true
        weapon.isCollidable = true
    end
    ```

7. Now that we have created all these functions for Pickup and Drop, we need to connect them to the corresponding event on the weapon. Copy this code below:

    ```lua
    weapon.equippedEvent:Connect(Pickup)
    weapon.unequippedEvent:Connect(Drop)
    ```

    This causes the `Pickup()` function to happen any time the weapon is equipped, and `Drop()` to happen any time the weapon is unequipped.

At this time when testing the game, you should also be able to equip the weapon and shoot it freely, but nothing will happen when the bullet hits something.

### The Attack Script

To get the gun to fire when shot, we need to create an `AttackScript`. This will deal with everything that happens the moment the gun fires!

!!! info "Not All Weapons Need to Shoot"
    The weapon system can be used for things that aren't weapons! If you were making a bubble blower, or a fishing pole, maybe you wouldn't call it "Attack Script" but whatever fits your weapon type. The key is that this is what actually happen when the player uses the weapon!

1. The first step is to create a new script, and call it `AttackScript`.  Drag this empty script onto the weapon in the Hierarchy.
    The Hierarchy should now look like this:

    ![Current Weapon Hierarchy](../../img/EditorManual/Weapons/hierarchy2.png)

2. We're going to make our gun do straightforward gun things: damage a player when shot.
 Weapons do not come with a damage property by default, so we're going to add a **Custom Property** to our weapon for easier editing later when testing damage amounts.
    1. Click on the weapon itself. In the **Properties** window, at the bottom, click "Add Parameter". A little window will pop up, and here we want to change the drop-down menu to a `Float`, and change the words in the box to `Damage_Amount`.
    2. This property we just made shows up at the bottom of the Properties window, in a section named "Custom". Enter the number 50 into the Damage_Amount box.
    3. This is how you can change the damage the gun does at any time later!

3. Next, open the `AttackScript` we made earlier. Delete all code currently in there. We need to create a reference to that `Damage_Amount` property we made. Copy this code into your empty script:

   ```lua
   local damageAmount = script.parent:GetCustomProperty("Damage_Amount") or 1
   ```

   This sets the variable `damageAmount` to whatever value we entered into the Properties box, or sets it to 1 if nothing was set in the box.

4. Now that we have all the references we need, we can make the function that actually causes damage.
 All `weapon` objects have an event, `targetInteractionEvent`, that is triggered the moment their projectile collides with an object, and what we want to do is make a function to connect to that event.
  So we want a player to take damage the moment a bullet hits them! To do this, copy the code here and paste it into the `AttackScript` below the `damageAmount` line:

  ```lua
  local function HandleInteracted(weaponInteraction)
    local other = weaponInteraction.targetObject

    if other and damageAmount then
        if other:IsA("Player") then
            -- hurt target player
            other:ApplyDamage(Damage.New(damageAmount))
        end
    end
  end
  ```

  Here, the function takes in the parameter `weaponInteraction` which gives a bunch of information about what was hit the moment the bullet makes contact with an object.
   We created the variable `other` and set it to what the `targetObject` is so that we can compare if that `other` is a player, as opposed to a rock or the floor.
   If `other` is a player, then we `ApplyDamage()` to them! `ApplyDamage()` is a built-in function for Core.
   `Damage` is also a built-in Core class, and we create a New instance of it to plug in our `damageAmount`.

5. Lastly, we need to use the `EventListeners` to connect our function to the `targetInteractionEvent` of the weapon. Copy this code into the bottom of your `AttackScript`:

 ```lua
 script.parent.targetInteractionEvent:Connect(HandleInteracted)
 ```

Now all the basics are hooked up! The gun should be able to shoot and kill other players.

This is a really simple version of a gun. Each part could be done a different way or made more complicated for whatever your imagination can dream up! You could go back into what we have created to add more functionality.
 Some possible improvements are included in the next section.

### Polish the Weapon

1. What happens if the player picks up a weapon while they are already holding one? Bad stuff! To fix the weapon so the player can only hold one at a time, we need to add code in the `Pickup()` event of the `PickupWeaponScript`. Add this code below to `Pickup()`:

   ```lua
    for _,prevEquip in pairs(player:GetEquipment()) do
        if (prevEquip ~= weapon and prevEquip.socket == weapon.socket) then
            prevEquip:Unequip()
        end
    end
   ```

    With this added, the entire `Pickup()` function should now look like this:

   ```lua
   function Pickup(equipment,  player)
     -- remove any equipment the player already has
     for _,prevEquip in pairs(player:GetEquipment()) do
         if (prevEquip ~= weapon and prevEquip.socket == weapon.socket) then
             prevEquip:Unequip()
         end
     end

     trigger.isInteractable = false
     weapon.isCollidable = false
   end
   ```

## Examples

**ETDM: Abduction** includes fully functional weapons and game logic created by the Lead Gameplay Programmer.
 **Garden Warfare** includes several functional weapons used in various ways, created by several Interns.
