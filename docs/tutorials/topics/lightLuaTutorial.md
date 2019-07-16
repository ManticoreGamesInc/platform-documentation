LIGHT SWITCH LUA TUTORIAL
Create a light switch that turns on and off a light.



This tutorial will cover:
Rotating an object
Global and local rotation
Creating a script
Using triggers
Interactable events
Creating and updating trigger labels
Creating a custom property
Spawning a template/asset

Step 1: Downloading the template
Download “Light Switch & Bulb” (by Tasha) from Shared Content and place it into your scene.

Step 2: Creating a new script
Create a new script by clicking the “Create Script” button in the Asset Manifest to the left of the search bar.
 


We’ll name this one “LuaLightTutorial”.

Delete all of the default coding included in each new script (function Tick(deltaTime) end) as we won’t be needing it for this project.

Drag our newly created script from the Asset Manifest into the Light Switch folder within the Light Switch & Bulb template. A popup titled “Reparenting Template Subobjects” will appear - click “Deinstance and Reparent.”



Make sure our script is first in the Light Switch’s hierarchy.



Step 3: Defining the switch variable
We want our light switch to function just like it would in real life: the switch will point up or down depending on whether the light is turned on or off. First we need to tell the script which object in our scene is the switch, so it knows what to rotate. Type the following into Line 1 of LuaLightTutorial:

local switch = script.parent:GetChildren()[2]

local tells the script the following variable only happens in this instance and is not a global variable.


switch is our name for the part of the light switch that is being flipped. We can name it anything but it’s important to create variables with self-explanatory names so our scripts are easy to read and understand.

script.parent refers to the script’s parent - the group or folder the script it placed in. In this case it refers to the “Light switch” group. If we wanted to refer to the entire “Light Switch & Bulb” template we would use script.parent.parent.

GetChildren()[2] refers to the second child in a hierarchy. Because this is attached to script.parent, the script knows this refers to the second child in our Light Switch group, which is the object we want to rotate.



local switch = script.parent:GetChildren()[2] tells the script we are defining a local variable named “switch” and what object in the hierarchy our new variable corresponds to. 

Step 4: Rotating the switch
We need to rotate the Press enter twice, so you are now typing on line 3 in the script. Type: 

switch:RotateTo(Rotation.New(0, 90, 0), 2)

switch tells the script to rotate the object attached to this variable.

RotateTo is an expression (?) that tells Core we will be rotating an object.

Rotation.New means we are telling the script to rotate our object to a new set of coordinates. You will almost always use Rotation.New when rotating an object, but when applicable you can use Rotation.ZERO which will rotate the object to (0, 0, 0).

(0, 90, 0) are the x, y, and z coordinates (respectively) of where we want our switch to rotate to. We want to rotate our switch up along the y axis by 90 degrees.

2 sets the amount of the action takes to be completed. In this case, our rotation will take 2 seconds to complete.  

Our script should look like:



Let’s press play and see how our switch moves.



Unfortunately that didn’t quite work out the way we wanted… Depending on where in the scene you placed your light switch, it might look like the above photo, where the switch rotated sideways instead of up. That’s because we didn’t take into account the switche’s initial rotation in the scene. 

The switch’s starting global rotation is (180, -50, -90). This is it’s rotation relative to everything else in the scene. When you click on the switch and look at it’s rotation you will see it’s local rotation (180, -50, -180) which is it’s rotation relative to its parent.

BASIC CONCEPTS: GLOBAL VS. LOCAL ROTATION


Light switch’s global rotation: (0, 0, 90)

Light switch’s global rotation: (0, 0, 180)

Switch’s local rotation: (180, -50, -180)

Switch’s local rotation: (180, -50, -180)

Switch’s global rotation: (180, -50, -90)

Switch’s global rotation: (180, -50, 0)


Here we have rotated the entire light switch 90 degrees to the left (clockwise). Notice how the switch’s local rotation does not change but it’s global rotation does; this is because you are not changing the switch’s rotation relative to its parent but you are still changing its rotation relative to other objects in the scene. 

We want the script to rotate our switch 90 degrees up. But our problem is the script is rotating the switch globally while we want to rotate it locally; it’s changing the switch’s global rotation from (180, -50, -90) to (0, 90, 0). In order to get the script to rotate the switch the way we want, only along the y axis, it has to know where the switch’s starting rotation. 

Let’s create a variable that defines the switch’s starting rotation. Go to the line 2 of the code and type:

local startingRotation = switch:GetWorldRotation()

startingRotation is the name of our new variable that will define the switch’s starting rotation.

switch:GetWorldRotation() tells the script to get the global rotation coordinates of our first variable, switch.

Our startingRotation variable contains information (a set of coordinates) and isn’t an object like our first variable switch. So we won’t be able to use it in exactly the same way.

Our script should now look like:



Now that we have switch’s starting rotation set to a variable we just need to include it in our rotation statement: 

switch:RotateTo(startingRotation + Rotation.New(0, -90, 0), 2)
Let’s press play and test it out.



Success!

Step 5: Adding a trigger
We want the player to be able to flip the switch to turn on and off our light. To do this we need a trigger. A trigger defines the area an interaction can take place in. This sounds pretty abstract, but will be clear once we start using one.

To create a trigger go up to “Object” on the menu bar and click “Create Box Trigger”.


Now there is an object called “BoxTrigger” in our hierarchy. Select it and press F, this will find the trigger in our viewer. If you can’t see the trigger, press V to enable Gizmos visibility. Drag the trigger over to the light switch. The size of the trigger determines how close a player needs to be to interact with the trigger. Here’s what mine looks like:



Look at the properties of the trigger. Under “Gameplay” there is a parameter called “Interactable,” check the box next to it.



If left unchecked, we won’t be able to interact with the trigger. 

Drag the trigger into the light switch hierarchy. It should be the 4th child in the group. A “Reparenting non-Networked Object to Networked Object” pop up will appear; click the middle option, “Make Children Networked”.  



Our hierarchy should now look like this:



Now we need to tell the script what our trigger is and what should happen when the player interacts with it. Under our startingRotation variable definition type:

local trigger = script.parent:GetChildren()[4]

trigger is the name for our trigger variable.

script.parent:GetChildren()[4] defines the object we are using as our trigger - the fourth child of the script’s parent group.

Now that the script knows which object we are using as a trigger we need to define what happens when we interact with the trigger.

Press enter twice after our rotation statement on line 5, so we are writing on line 7. Type:

function onInteraction()

end

A function is a set of actions the script carries out every time the function is referenced in the script.

onInteraction is the name of our function.

end tells the script the function is over.

Eventually we want the switch to flip up and down when the player interacts with it, turning the light on and off. For now we’ll just place our rotate statement inside it, which is just the switch turning down. Cut and paste the rotation statement from line 5 into our onInteraction function.

Our script should now look like this:



Lastly, we need an event statement that tells the script to execute the onInteraction function when the player interacts with the switch’s trigger. Press enter twice after end on line 9 and type the following on line 11: 

trigger.interactedEvent:Connect(onInteraction) 

trigger is the name of our trigger. 

interactedEvent:Connect() tells the script every time the player interacts with trigger to execute the function within the Connect parenthesis.

onInteraction is the name of the function we are calling on. 

Without this statement the script wouldn’t know to call on onInteraction function when the player interacts with the trigger.

Our script should now look like this:



Let’s press play and see if our trigger is working properly.

Perfect! When the player presses F our switch rotates down.

BEST PRACTICES: ORGANIZING YOUR CODE
It is important to keep your code organized so it is easily read and understood. You might come back to your project after not working on it for a while, or you might be collaborating with other people; in both cases it is nice to have an explanation of your functions do. It can also make finding specific functions in your script easier.

Programmers use comments to define and explain certain parts of their code. See the example below for how you might comment on our current script. 



I’ve blocked out different sections of our script by Variables, Functions, and Events that will make it easier to find lines of code.

It is also common practice to indent lines of code that nest within functions and other  statements.



As our script gets longer it these practices will make our script easier to read.

Step 6: 
