---
id: network_dormancy_tutorial
name: Network Dormancy
title: Network Dormancy
tags:
    - Tutorial
---

# Network Dormancy

## Overview

In this tutorial, you will learn how to manually replicate network objects that can make your games more performant and utilize more networked behavior. You will be changing material colors on an object, and forcing the replication to other clients who will receive the changes.

Disabling a networked object's replication means that the server will not be checking to see if the object has changed, and will not send any new information about that object down to clients, until either the object has replication enabled again, or until you explicitly request the server replicate the object down to each client with a Lua function.

* **Completion Time:** ~20 minutes
* **Knowledge Level:** No previous knowledge.
* **Skills you will learn:**
    * How to set a networked object to dormant by default.
    * How to force replication with Lua.
    * How to change object dormancy using Lua.

## Add Objects and set Dormancy

We will need a few objects added to the **Hierarchy** that will be used to help show off how dormancy works.

### Create Volleyball Object

1. In **Core Content** search for `Volleyball` to find the object **Ball - Volleyball 01**.
2. Add the volleyball to the **Hierarchy** and name it `Volleyball`.
3. Right-click on the volleyball object in the **Hierarchy** and select **Enable Networking**.

![!Volleyball](../img/Dormancy/Volleyball.png){: .center loading="lazy" }

### Create Volleyball Clone Object

Create a copy of the **Volleyball** object that will be a clone. Any changes made to the other Volleyball will carry over to this object periodically to show when replication has been enabled or disabled.

1. In **Core Content** search for `Volleyball` to find the object **Ball - Volleyball 01**.
2. Add the volleyball to the **Hierarchy** and name it `Volleyball Clone`.
3. Right-click on the volleyball object in the **Hierarchy** and select **Enable Networking**.
4. With the **Volleyball** selected, in the **Properties** window enable the **Advanced Settings** option.
5. In the **Properties** window for the **Volleyball** object, disable the option **Start Replicating** under the **Network Relevance** group.

With the option **Start Replicating** disabled, the object will only use network bandwidth when it is created, and when replication is forced by using a Lua function.

![!Volleyball](../img/Dormancy/dormant.png){: .center loading="lazy" }

### Create UI Crosshair

To see where you are clicking on an object, you will create some UI to have a crosshair show up.

1. Create a **Client Context** in the **Hierarchy**.
2. Add a **UI Container** to the Client Context.
3. Add a **UI Image** to the UI Container and set the **Anchor** and **Dock** to **Middle Center**.
4. Find a crosshair image for the UI Image.

![!Crosshair](../img/Dormancy/crosshair.png){: .center loading="lazy" }

## Create ChangeColorClient Script

Create a new script called `ChangeColorClient` and place it into the **Client Context** folder. This script will check when certain action bindings have been pressed and modify the slot color of the material that was returned by the raycast hit.

### Create OnActionPressed Function

Create a function called `OnActionPressed`. This function will receive the player who triggered the action and the action name. By dividing the screen size for `x` and `y` by 2, we get the center position of the screen where the crosshair will be pointing. Using `GetHitResult` with the Vector2 passed in, we can check if we have a `hit` and check if the object `other` is networked.

Left-clicking will set a random color for the material slot returned, and right-clicking will reset the color of the material slot.

A broadcast to the server is done that will send the object reference, the slot name, and the color.

```lua
local function OnActionPressed(player, action)
    if action == "Shoot" or action == "Aim" then
        local screenSize = UI.GetScreenSize()
        local hit = UI.GetHitResult(Vector2.New(screenSize.x / 2, screenSize.y / 2))

        if hit ~= nil and hit.other.isNetworked then
            local materialSlot = hit:GetMaterialSlot()

            if materialSlot ~= nil then
                local color = nil

                if action == "Shoot" then
                    color = Color.New(math.random(0, 1), math.random(0, 1), math.random(0, 1))
                end

                Events.BroadcastToServer("ChangeColor", hit.other:GetReference(), materialSlot.slotName, color)
            end
        end
    end
end
```

### Connect actionPressedEvent

Connect the `actionPressedEvent` which calls the connected function `OnActionPressed` when the player presses a binding.

```lua
Input.actionPressedEvent:Connect(OnActionPressed)
```

### The ChangeColorClient Script

??? "ChangeColorClient"
    ```lua
    local function OnActionPressed(player, action)
        if action == "Shoot" or action == "Aim" then
            local screenSize = UI.GetScreenSize()
            local hit = UI.GetHitResult(Vector2.New(screenSize.x / 2, screenSize.y / 2))

            if hit ~= nil and hit.other.isNetworked then
                local materialSlot = hit:GetMaterialSlot()

                if materialSlot ~= nil then
                    local color = nil

                    if action == "Shoot" then
                        color = Color.New(math.random(0, 1), math.random(0, 1), math.random(0, 1))
                    end

                    Events.BroadcastToServer("ChangeColor", hit.other:GetReference(), materialSlot.slotName, color)
                end
            end
        end
    end

    Input.actionPressedEvent:Connect(OnActionPressed)
    ```

## Create ChangeColorServer Script

Create a **Server Context** folder and create a new script called `ChangeColorServer` and put that inside the Server Context folder. This script will be responsible for handling the color change, and the replication to all clients to receive the updated colors.

### Add Custom Property

The `ChangeColorServer` script will need a reference to the **Volleyball Clone** so that it can update the colors periodically.

1. Add the **Volleyball Clone** object as a custom property on the **ChangeColorServer** script.
2. Name the property `VolleyballClone`.

![!Clone Property](../img/Dormancy/cloneprop.png){: .center loading="lazy" }

### Edit ChangeColorServer Script

Open up the **ChangeColorServer** script and add the reference to the custom property and a variable called `setReplication` that will keep track of the state of the dormancy for the object.

```lua
local VOLLEYBALL_CLONE = script:GetCustomProperty("VolleyballClone"):WaitForObject()

local setReplication = true
```

#### Create ChangeColor Function

Create a function called `ChangeColor`. This function will receive the object reference, material slot name, and the color the material slot will be changed to.

If the `color` is `nil` then the material slot will be reset using the `ResetColor` function.

The color of the material slot for the `VOLLEYBALL_CLONE` is also set so it matches the object being replicated. When the `ChangeColor` function is called, at the end after the changes have been done to the `obj`, a call to `ForceReplication` is done. This will send the changes on the `obj` to all clients. This is efficient because you are in control of when replication happens, and how often it happens.

```lua hl_lines="12"
local function ChangeColor(objRef, materialSlot, color)
    local obj = objRef:GetObject()

    if color ~= nil then
        obj:GetMaterialSlot(materialSlot):SetColor(color)
    else
        obj:GetMaterialSlot(materialSlot):ResetColor()
    end

    VOLLEYBALL_CLONE:GetMaterialSlot(materialSlot):SetColor(obj:GetMaterialSlot(materialSlot):GetColor())

    obj:ForceReplication()
end
```

#### Create Task

Create a task that will update the dormancy of the `VOLLEYBALL_CLONE` every 3 seconds. By passing either `true` or `false` to the `SetReplicationEnabled` function, the object with either replicate normally or not replicate at all. The `setReplication` variable will be flipped each time so that every 3 seconds it changes the dormancy state.

```lua
local task = Task.Spawn(function()
    VOLLEYBALL_CLONE:SetReplicationEnabled(not setReplication)
    setReplication = not setReplication
end, 3)

task.repeatCount = -1
task.repeatInterval = 3
```

#### Connect Event

Connect the `ChangeColor` event that is broadcasted to the server from the client.

```lua
Events.Connect("ChangeColor", ChangeColor)
```

### The ChangeColorServer Script

??? "ChangeColorServer"
    ```lua
    local VOLLEYBALL_CLONE = script:GetCustomProperty("VolleyballClone"):WaitForObject()

    local setReplication = true

    local function ChangeColor(objRef, materialSlot, color)
        local obj = objRef:GetObject()

        if color ~= nil then
            obj:GetMaterialSlot(materialSlot):SetColor(color)
        else
            obj:GetMaterialSlot(materialSlot):ResetColor()
        end

        VOLLEYBALL_CLONE:GetMaterialSlot(materialSlot):SetColor(obj:GetMaterialSlot(materialSlot):GetColor())

        obj:ForceReplication()
    end

    local task = Task.Spawn(function()
        VOLLEYBALL_CLONE:SetReplicationEnabled(not setReplication)
        setReplication = not setReplication
    end, 3)

    task.repeatCount = -1
    task.repeatInterval = 3

    Events.Connect("ChangeColor", ChangeColor)
    ```

### Test the Game

Testing network dormancy needs to be done in multiplayer preview. Load multiplayer preview with 2 clients and test clicking on the volleyball and watch as the colors change. You will notice the volleyball clone will change, but after 3 seconds it will stop receiving updates, and then start receiving again.

<div class="mt-video" style="width:100%">
    <video autoplay muted playsinline controls loop class="center" style="width:100%">
        <source src="/img/Dormancy/preview.mp4" type="video/mp4" />
    </video>
</div>

## Summary

Having the ability to change how frequently objects are replicated in your game can greatly improve performance. Updating objects only when they need to be updated allows for a more relaxed approach to networked objects that are dormant.

## Learn More

[Networking](../references/networking.md) | [Network Relevancy](../references/network_relevancy.md)
