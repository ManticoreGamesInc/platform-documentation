---
id: obby_tutorial
name: Make an Obby in Core
title: Make an Obby in Core
tags:
    - Tutorial
---

# Make an Obby in Core

## Overview

In this tutorial you are going to make an **Obby**, which is a platform and obstacle game. The game will have moving, rotating, and shrinking platforms as well as deadly spinning blades. The obby will also be timed so players can race to beat their best times.

* **Completion Time:** ~2 hours
* **Knowledge Level:** It's recommended to have completed the [Scripting Beginner](lua_basics_helloworld.md) and [Scripting Intermediate](lua_basics_lightbulb.md) tutorials.
* **Skills you will learn:**
    * Using CoreObject API to move, rotate, and scale objects
    * When to use Client, Networked, and Server contexts
    * Triggers and Equipment
    * Accurate time keeping
    * Communicating from server to client
    * Persistent storage
    * Sending and receiving private data

---

## Creating a Project and Starting Platform

Create a new empty project. In the **Hierarchy** window, select the **Default Floor** and rename it to `Starting Platform` using the ++F2++ button. Then in the scene, switch to **Scale Mode** using the ++R++ button and scale it to a smaller size.

<!-- TODO add image -->

## Creating a Moving Platform

The Moving Platforms will move back and forth between two positions. They pause for some time when they reach a position before heading back to the other position.

### Create a New Platform

Select the **Starting Platform** in the Hierarchy and duplicate it using the ++Ctrl+W++ shortcut. Rename the duplicated platform to `Platform`. In the scene, enter **Translation Mode** using the ++W++ button and move it away from the Starting Platform.

!!! info "This new platform is the next destination the player wants to reach from the Starting Platform."

<!-- TODO add image -->

### Create a Moving Platform

Open the Core Content window and search for `cube` to find a **Cube** object and place it into the scene. In the Hierarchy, rename the cube to `Moving Platform`. In the scene, position and resize the cube to be in the desired starting state.

<!-- TODO add image -->

### Network the Moving Platform

Currently, the **Moving Platform** is in a [Default Context](../references/networking.md). This context is useful for objects such as the **Starting Platform** because players need to collide with the object and the object will never change its position, rotation, or size. The Moving Platform will be changing its position so it needs to be in the **Default Context (Networked) Context**. In the Hierarchy, right click the **Moving Platform** and select the **Enable Networking**.

!!! warning "**Networked Objects** are the most expensive type of objects because the server has to constantly track and share information about them."

<!-- TODO add image -->

### Create the MovingPlatform Script

#### Add a New Script

Create a new script by pressing the **Script** button ![Script](../img/EditorManual/icons/AssetType_Script.png){: .image-inline-text .image-background } above the scene. Name it `MovingPlatform`. In the **Project Content** window, find the **MovingPlatform** script in the **My Scripts** section and drag it into the **Hierarchy**.

<!-- TODO add image -->

#### Add Custom Properties

In the Hierarchy, select the **MovingPlatform** script and then open the **Properties** window. The script will need some **custom properties** to know how to move the platform.

1. From the Hierarchy, drag and drop the **Moving Platform (networked)** object into the Custom Property section.
2. Add a new **Vector3** custom property and name it `TargetPosition`.
3. Add a new **Float** custom property and name it `TravelTime`.
4. Add a new **Float** custom property and name it `WaitTime`.

<!-- TODO add image -->

#### Set the Custom Properties

Set the **TravelTime** property to `2`. Set the **WaitTime** property to `1`. The TargetPosition property can be copied easily using the Moving Platform (networked) object.

1. In the scene, move the **Moving Platform (networked)** object to the desired target position.
2. In the **Properties** window, right click the **Position** property and select **Copy [Position]**.
3. In the Hierarchy, select the **MovingPlatform** script and open the Properties window.
4. Right click the **TargetPosition** custom property and select **Paste Last Copied**.
5. Move the **Moving Platform (networked)** object back to its starting position.

<!-- TODO add video -->

#### Add Code to the Script

In the Hierarchy, right click the **MovingPlatform** script and select **Edit Script** to open the Script Editor window.

##### Access Custom Properties

```lua
local MOVING_PLATFORM = script:GetCustomProperty("MovingPlatform"):WaitForObject()
local TARGET_POSITION = script:GetCustomProperty("TargetPosition")
local TRAVEL_TIME = script:GetCustomProperty("TravelTime")
local WAIT_TIME = script:GetCustomProperty("WaitTime")
```

There needs to be variables that have a reference to the custom properties inside the script.

!!! info "This code is automatically generated at the bottom of the Properties window for creators to easily copy and paste into their scripts."

##### Access Starting Position

```lua
local STARTING_POSITION = MOVING_PLATFORM:GetWorldPosition()
```

The **Moving Platform** is a [CoreObject](../api/coreobject.md) so it contains a function `GetWorldPosition` to access the current position of the object.

##### Loop the Movement

```lua
while true do
	Task.Wait(WAIT_TIME)
	MOVING_PLATFORM:MoveTo(TARGET_POSITION, TRAVEL_TIME, false)
	Task.Wait(TRAVEL_TIME + WAIT_TIME)
	MOVING_PLATFORM:MoveTo(STARTING_POSITION, TRAVEL_TIME, false)
	Task.Wait(TRAVEL_TIME)
end
```

The use of a `while true` loop will keep the code inside of it running indefinitely. This means the platform will forever move between the two locations. The `MoveTo` function requires three arguments to be passed in: The target position, the travel time, and whether the location is in local space.

??? "The MovingPlatform Script"
    ```lua
    local MOVING_PLATFORM = script:GetCustomProperty("MovingPlatform"):WaitForObject()
    local TARGET_POSITION = script:GetCustomProperty("TargetPosition")
    local TRAVEL_TIME = script:GetCustomProperty("TravelTime")
    local WAIT_TIME = script:GetCustomProperty("WaitTime")

    local STARTING_POSITION = MOVING_PLATFORM:GetWorldPosition()

    while true do
        Task.Wait(WAIT_TIME)
        MOVING_PLATFORM:MoveTo(TARGET_POSITION, TRAVEL_TIME, false)
        Task.Wait(TRAVEL_TIME + WAIT_TIME)
        MOVING_PLATFORM:MoveTo(STARTING_POSITION, TRAVEL_TIME, false)
        Task.Wait(TRAVEL_TIME)
    end
    ```

### Test the Moving Platform

Save the script and preview the project. The platform should be moving back and forth for the player to traverse platforms.

<!-- TODO add video -->

### Organize the Moving Platform

In the Hierarchy, multi-select the **MovingPlatform** script and **Moving Platform (networked)** object by holding down ++Ctrl++ button while left clicking the mouse. Right click and select the **New Group Containing These** option. Name the group `Moving Platform`.

<!-- TODO add image -->

### Add Material to Platform

Select the **Moving Platform (networked)** object and open the Properties window. Set the **Material** property to `Wood 9 Slice Crate 01`.

<!-- TODO add image -->

## Creating a Rotating Platform

The **Rotating Platform** will spin in a certain direction continuously.

### Create a New Platform

In the Hierarchy, select the **Platform** object and duplicate it. Extend the level by moving the duplicate platform away from the other platform.

<!-- TODO add image -->

### Create a Rotating Platform

In the **Core Content** window, find the **Cube** object and add it to the scene. Rename the cube to `Rotating Platform`. Then scale and position the cube to a good starting state.

<!-- TODO add image -->

### Network the Rotating Platform

The **Rotating Platform** needs collision and will also be rotating so it needs to be networked to update for all players properly. Right click the **Rotating Platform** and select **Enable Networking**.

<!-- TODO add image -->

### Create the RotatingPlatform Script

#### Add a New Script

Create a new script and name it `RotatingPlatform`. From the Project Content window, drag the **RotatingPlatform** script into the Hierarchy.

<!-- TODO add image -->

#### Add Custom Properties

In the Hierarchy, select the **RotatingPlatform** script and open the Properties window. The script will need two custom properties at the bottom.

1. Drag and drop the **Rotating Platform (networked)** object into the **Custom Properties** section of the script.
2. Add a **Vector3** custom property and name it `RotationSpeed`.

<!-- TODO add image -->

#### Set the RotationSpeed Property

!!! info "Rotation Axis"
    There are three axis that an object can rotate around (X, Y, and Z). When using Rotation Mode in the editor (enabled with the ++E++ button), there are three colored orbits around the object representing the axis. Dragging these colored orbits will also change the same colored Rotation values in the Properties window. This is helpful to understand which axis needs to change for a certain rotation direction.

    <!-- TODO add video -->

Set the **RotationSpeed** property to **X** `0`, **Y** `0`, **Z** `3`. This will only spin it on the Z axis at a speed of 3 degrees per tick.

#### Add Code to the Script

Open the **Script Editor** for the **MovingPlatform** script.

##### Access Custom Properties

Add code to access the custom properties for the platform and speed.

```lua
local ROTATING_PLATFORM = script:GetCustomProperty("RotatingPlatform"):WaitForObject()
local ROTATION_SPEED = script:GetCustomProperty("RotationSpeed")
```

##### Rotate Continuously

CoreObject has a function named `RotateContinuous` that allows two arguments to be passed: a Vector3 for the angular speed and a boolean for whether it is rotating in local space. Add this code to the bottom of the script.

```lua
ROTATING_PLATFORM:RotateContinuous(ROTATION_SPEED, false)
```

??? "The RotatingPlatform Script"
    ```lua
    local ROTATING_PLATFORM = script:GetCustomProperty("RotatingPlatform"):WaitForObject()
    local ROTATION_SPEED = script:GetCustomProperty("RotationSpeed")

    ROTATING_PLATFORM:RotateContinuous(ROTATION_SPEED, false)
    ```

#### Test the Rotating Platform

Save the script and preview the project. The platform should be rotating and the player should rotate if on top of it.

!!! tip "Use the ++Shift+=++ shortcut to spawn the player in Preview Mode where the creator camera currently is in the scene."

<!-- TODO add video -->

### Organize the Rotating Platform

In the Hierarchy, multi-select the **RotatingPlatform** script and **Rotating Platform (networked)** object by holding down ++Ctrl++ button while left clicking the mouse. Right click and select the **New Group Containing These** option. Name the group `Rotating Platform`.

<!-- TODO add image -->

### Add Material to Platform

Select the **Rotating Platform (networked)** object and open the Properties window. Set the **Material** property to `Wood 9 Slice Crate 01`.

<!-- TODO add image -->

## Creating a Shrink Platform

The **Shrink Platform** will detect if a player stepped on the platform and begin shrinking until it disappears. After some time, it will grow back to normal and wait again for a player to step on it.

### Add a New Cube

In the **Core Content** window, find the **Cube** object and add it to the scene. Rename the cube to `Shrink Platform`. Then scale and position the cube to a good starting state.

<!-- TODO add image -->

### Network the Shrink Platform

The **Shrink Platform** needs collision and will also be changing in size so it needs to be networked to update for all players properly. Right click the **Shrink Platform** and select **Enable Networking**.

<!-- TODO add image -->

### Add a Trigger

Press the ++9++ button to create a new **Trigger**. Position the trigger to be on top of the **Shrink Platform**.

<!-- TODO add image -->

!!! tip "Copying Properties"
    A useful tip to get the **Trigger** in the correct position and size is to copy it from the **Shrink Platform**. There is a **Copy Properties** <!-- TODO add icon -->button at the top right of the Properties window that will copy all the properties from an object. Then there is a **Paste Properties** <!-- TODO add icon -->button that let's the creator choose which properties to paste that were copied.

    <!-- TODO add video -->

### Create the ShrinkPlatform Script

Create a new script named `ShrinkPlatform` and add it to the **Hierarchy**.

#### Add Custom Properties

With the **ShrinkPlatform** script selected, open the **Properties** window. Add the following custom properties.

1. Drag and drop the **Shrink Platform (networked)** object as a custom property.
2. Drag and drop the **Trigger** object as a custom property.
3. Add a new **Float** custom property named `ShrinkTime` and set it to `2`.
4. Add a new **Float** custom property named `WaitTime` and set it to `1`.

#### Add Code to the Script

Open the **Script Editor** for the **ShrinkPlatform** script.

##### Access Custom Properties

Add this code to the script to access the custom properties.

```lua
local SHRINK_PLATFORM = script:GetCustomProperty("ShrinkPlatform"):WaitForObject()
local TRIGGER = script:GetCustomProperty("Trigger"):WaitForObject()
local SHRINK_TIME = script:GetCustomProperty("ShrinkTime")
local WAIT_TIME = script:GetCustomProperty("WaitTime")
```

##### Add More Variables

The platform will need to remember its starting size when it starts growing back. It also needs to know if it's in the shrinking phase to avoid activating the trigger more than once.

```lua
local STARTING_SIZE = SHRINK_PLATFORM:GetWorldScale()
local shrinking = false
```

##### Shrink Function

There is a **CoreObject** function named `ScaleTo` that will scale an object to a certain size and for a certain amount of time. Using `Vector3.ZERO` as a target size will make the object disappear once it becomes small enough. Add this function at the bottom of the script.

```lua
local function Shrink()
	shrinking = true
	SHRINK_PLATFORM:ScaleTo(Vector3.ZERO, SHRINK_TIME, false)
	Task.Wait(SHRINK_TIME + WAIT_TIME)
	SHRINK_PLATFORM:ScaleTo(STARTING_SIZE, SHRINK_TIME, false)
	Task.Wait(SHRINK_TIME)
	shrinking = false
end
```

##### OnBeginOverlap Function

When the Trigger detects a player has overlapped with it, then it will call the `Shrink` function as long as it is not shrinking already. Add this function at the bottom of the script.

```lua
function OnBeginOverlap(whichTrigger, other)
	if other:IsA("Player") and not shrinking then
		Shrink()
	end
end
```

##### Connect the Function to the Event

The `OnBeginOverlap` function needs to fire when the actual event of the **Trigger** object being overlapped occurs in game. Add this code to connect the function with the event.

```lua
TRIGGER.beginOverlapEvent:Connect(OnBeginOverlap)
```

??? "The ShrinkPlatform Script"
    ```lua
    local SHRINK_PLATFORM = script:GetCustomProperty("ShrinkPlatform"):WaitForObject()
    local TRIGGER = script:GetCustomProperty("Trigger"):WaitForObject()
    local SHRINK_TIME = script:GetCustomProperty("ShrinkTime")
    local WAIT_TIME = script:GetCustomProperty("WaitTime")

    local STARTING_SIZE = SHRINK_PLATFORM:GetWorldScale()
    --Used to disable trigger while the platform is shrinking
    local shrinking = false

    local function Shrink()
        shrinking = true
        --Vector3.ZERO will make the platform disappear after its done shrinking
        SHRINK_PLATFORM:ScaleTo(Vector3.ZERO, SHRINK_TIME, false)
        Task.Wait(SHRINK_TIME + WAIT_TIME)
        SHRINK_PLATFORM:ScaleTo(STARTING_SIZE, SHRINK_TIME, false)
        Task.Wait(SHRINK_TIME)
        shrinking = false
    end


    function OnBeginOverlap(whichTrigger, other)
        if other:IsA("Player") and not shrinking then
            Shrink()
        end
    end

    TRIGGER.beginOverlapEvent:Connect(OnBeginOverlap)
    ```

#### Test the Shrink Platform

Save the script and preview the project. The platform should shrink once the player lands on the platform and then reset to its normal size after some time.

<!-- TODO add video -->

### Organize the Shrink Platform

In the Hierarchy, multi-select the **ShrinkPlatform** script, **Trigger**, and **Shrink Platform (networked)** object by holding down ++Ctrl++ button while left clicking the mouse. Right click and select the **New Group Containing These** option. Name the group `Shrink Platform`.

<!-- TODO add image -->

### Add Material to Platform

Select the **Shrink Platform (networked)** object and open the Properties window. Set the **Material** property to `Concrete Basic 01`.

<!-- TODO add image -->

## Adding a Kill Zone and Spawn Settings

### Organize the Hierarchy

Before adding more, the Hierarchy needs to be cleaned up from all these new platforms. In the Hierarchy, multi-select (by holding ++Ctrl++) the **Starting Platform**, **Platform** objects, **Moving Platform** group, **Rotating Platform** group, and **Shrink Platform** group. Right click and select **New Group Containing These**.

<!-- TODO add image -->

## Creating a Deadly Spinning Blade

## Creating a Rewards Chest

## Making it a Game

## Learn More

[CoreObject API](../api/coreobject.md) | [Networking](../references/networking.md) | [Triggers](../references/triggers.md) | [Race Timer Tutorial](../tutorials/race_timer.md)
