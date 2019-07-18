### Abstract

In a lot of video games, the main character uses a weapon to make their way through the game world. "Weapon" can mean a gun, an axe, or even a tomato grenade. 
Programming a weapon can be the most complicated part of making a game, but to make that easier, Core comes with a built-in weapon system!

![A Sniper Rifle](/img/EditorManual/Weapons/holdingWeapon.PNG)

In Core, a `weapon` is an `equipment` type of object that can be created in any Core project. 

When a player picks up or *equips* a weapon object, the player is instantly able to use that weapon and all that it can do! 
So to create a weapon like a rifle, all that needs to be done is to spawn a weapon, modify the settings for how far the weapon can shoot, and equip it to a player.

!!! info
    A weapon can be anything imaginable that the player holds and uses to interact with the world.

### Tutorial

Adding a weapon to a game is more steps than just spawn, modify, and equip. The tutorial below will walk you through the entire process from an empty project, to using a gun of your own making in a level!

This gun will be placed in the world and the player will need to pick it up to use it.

In this tutorial, we will be adding a really simple gun to an empty project.

1. The first thing to do is to open the *Object* menu at the top of the editor, and select Create Weapon. This adds one empty weapon to your current game's hierarchy. 

2. The weapon will be completely "empty" having no visible parts at first! The look of the weapon can be made from any Core primitaves and shapes.  

   These shapes should all be contained in a folder, and this folder should be made a child of the weapon by dragging the folder onto the weapon.  

   This attaches the look of the weapon to the function of the weapon! 

3. Next, using the same *Object* menu at the top of the editor, click "**Create Box Trigger**".  
   We are going to make a gun that will need to be picked up by the player, and to detect whether the player is close enough to the weapon, we need to use a Box Trigger.  

   In the Box Trigger's Properties, check the Interactable box to be on. 

   Type "Press F to Equip" in the Interaction Label spot. This is what displays when the player approaches the trigger.

4. To allow the trigger to detect if the player is close enough to the weapon to pick it up, we need to create a script called `PickupWeaponScript`. In the *Asset Manifest*, click the create script button to make a new empty script.

5. Drag both the trigger and the script onto the weapon in the Hierarchy.  

   This will cause the trigger and script to be children of the weapon, making it easier to access variables and keep everything contained.
   The hierarchy should now look like this:

   ![Weapon Hierarchy](/img/EditorManual/Weapons/hierarchy.png)

6. The first step to writing this script is being able to access the things that we want. In this case, that would be both the trigger and the weapon. Get a reference to these things by using the code below:

   ```python
   local weapon = script.parent
   local trigger = weapon:FindChildByType("Trigger")
   ```

7. To actually make the equipping happen when the player is near the weapon, we need a function connected to an event.  
   This code can also be taken from the script generator for Overlap Events, but copy this code below into your script:

   ```python
   function OnInteracted(whichTrigger, other)
	 if other:IsA("Player") then
		weapon:Equip(other)
	 end
   end
   ```  

  This is a function that takes in both a trigger `whichTrigger` and an object `other`. When any Core object overlaps the trigger, it will cause this function to happen.  

  The code inside the function is checking if the `other` object is a player. If `other` is a player, then it does the code contained within it: equip the weapon onto `other`, which is a player in this case thanks to our `if` statement checking!  

  This alone won't make the weapon work!  

8. To actually tie the function we made to the moment something overlaps the trigger, we need to connect the function to the trigger's interacted event. This is done with the following:

   ```python
   trigger.interactedEvent:Connect(OnInteracted)
   ```

9. Now that the function we made will actually happen, there is some fixing to be done. If you've tried to hit play and pick up the weapon, it does get picked up, but walking becomes impossible. Unless you already turned off the collision of the weapon's shape, this needs to be done in scripting.

   To turn off the collision when the player picks up the weapon, we will want to make a new function and connect it to the equipped event of the weapon. To do this, let's make a new function called Pickup(). Copy the code from below:

   ```python
   function Pickup(equipment,  player)
	trigger.isInteractable = false
	trigger.isCollidable = false
   end
   ```
   This turns off both the collision of the shape so that the player can't constantly run into it anymore, and turns off the interaction of the weapon, so that another player cannot walk up and take it from you!

10. connect all events
11. test it out bro!

A second example will show how to have a player start with a specific weapon equipped.

### Examples

*Garden Warfare* includes several weapons used in various ways. 
