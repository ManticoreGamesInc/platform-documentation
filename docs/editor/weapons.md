### Abstract

*page in progress*

In a lot of video games, the main character uses a weapon to make their way through the game world. "Weapon" can mean a gun, an axe, or even a tomato grenade. 
Programming a weapon can be the most complicated part of making a game, but to make that easier, Core comes with a built-in weapon system!

In Core, a `weapon` is an `equipment` type of object that can be created in any Core project. 

When a player picks up or *equips* a weapon object, the player is instantly able to use that weapon and all that it can do! 
So to create a weapon like a rifle, all that needs to be done is to spawn a weapon, modify the settings for how far the weapon can shoot, and equip it to a player.

!!! info
    A weapon can be anything imaginable that the player holds and uses to interact with the world.

### Tutorial

Adding a weapon to a game is more steps than just spawn, modify, and equip. The tutorial below will walk you through the entire process from an empty project, to using a gun of your own making in a level!

This gun will be placed in the world and the player will need to pick it up to use it.

In this tutorial, we will be adding a really simple gun to an empty project.

1. The first thing to do is to open the Object menu at the top of the editor, and select Create Weapon. This adds one empty weapon to your current game's hierarchy. 

!!! info
    The weapon will be completely "empty" having no visible parts at first! The look of the weapon can be made from any Core primitaves and shapes. These shapes should all be contained in a folder, and this folder should be made a child of the weapon by draggin the folder onto the weapon. This attaches the look of the weapon to the function of the weapon! 

2. Next, using the same Object menu, click "Create Box Trigger". We are going to make a gun that will need to be picked up by the player, and to detect whether the player is close enough to the weapon, we need to use a Box Trigger.

3. To help the trigger detect if the player is close enough to the weapon to pick it up, we need to create a script called `PickupWeaponScript`. In the Asset Manifest, click the create script button to make a new empty script.

4. Drag both the trigger and the script onto the weapon in the Hierarchy. This will cause the trigger and script to be children of the weapon, making it easier to access variables and keep everything contained.
The hierarchy should now look like this:

![Weapon Hierarchy](/img/EditorManual/Weapons/hierarchy.png)

5. The first step to writing this script is being able to access the things that we want. In this case, that would be both the trigger and the weapon. Get a reference to these things by using the code below:

```python
local weapon = script.parent
local trigger = weapon:FindChildByType("Trigger")
```

6. To actually make the equipping happen when the player is near the weapon, we need a function connected to an event. This code can also be taken from the script generator for Overlap Events, but copy this code below into your script:

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

7. To actually tie the function we made to the moment something overlaps the trigger, we need to connect the function to the trigger's interacted event. This is done with the following:

```python
trigger.interactedEvent:Connect(OnInteracted)
```

7. isINteractable
8. connect all events
9. test it out bro!

A second example will show how to have a player start with a specific weapon equipped.

### Examples

*Garden Warfare* includes several weapons used in various ways. 
