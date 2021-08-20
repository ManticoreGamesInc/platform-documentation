---
id: events_hooks_reference
name: Events and Hooks Reference
title: Events and Hooks Reference
tags:
    - Reference
---

# Events and Hooks

## Summary

An **Event** is something that happens. The source of the event can be many things, from an object, broadcast, to even **Player** input. For example, when the **Player** presses a key, any event listeners connected to a binding event will be fired, allowing you to react and perform any additional tasks based on which binding was pressed.

A **Hook** is like an event, but the purpose is to view or change something that's already going on. For example, modifying the player direction in a movement hook.

## Broadcasting and Connecting

**Core** has a robust event system for communicating between scripts by using functions from the **Events** namespace. There are functions in the **Events** namespace that help with server to client and client to server communication. Along with that, broadcasting between scripts in the same network context can help with modularizing your systems.

- `Events.Broadcast`

    This function allows for user created events to be broadcasted in the same network context. These events have an added benefit where they are not networked, so can be used as much as needed. This is helpful when there are scripts in the same network context but need a way to talk to each other or pass data. `Events.Broadcast` also supports any number of arguments that will get passed to the listener function.

    As an example of same network context communication.

    ```lua linenums="1"
    Events.Broadcast("PrintMessage", "Hello World!")
    ```

    The code above would be in one script that handles broadcasting to the `PrintMessage` event.

    ```lua linenums="1"
    Events.Connect("PrintMessage", function(msg)
        print(msg)
    end)
    ```

    The above code would be in another script that listens for the `PrintMessage` event.

- `Events.Connect`

    This function allows for user created events to be listened too by passing the event name as the first argument, and the event listener function as the second argument. When the event is broadcasted too, the listener function will be fired.

    When setting up a listener, an `EventListener` object is returned that can be used to determine if the listener is connected and disconnecting of the event to stop listening.

    ```lua linenums="1"
    -- Script "A"
    -- Wait 1 frame to give other script a chance to setup the listener.

    Task.Wait()
    Events.Broadcast("CallOnce", "Hello World!")
    Events.Broadcast("CallOnce", "Hello Again!")
    ```

    ```lua linenums="1"
    -- Script "B"

    local myEvent

    myEvent = Events.Connect("CallOnce", function(msg)
        print(msg)

        -- Check if myEvent is connected, if so, disconnect.

        if myEvent.isConnected then
            myEvent:Disconnect()
            myEvent = nil
        end
    end)
    ```

    In the above code, the event `CallOnce` is broadcasted which will fire all listeners attached to that event. The connected listener will only be fired once. A reference to the `eventListener` is stored in the `myEvent` variable so that the event `CallOnce` can be disconnected later.

- `Events.BroadcastToAllPlayers`

    This function broadcasts the event to all clients over the network and fires all listeners attached to that event. Any arguments after the event name are passed to the listener on the client. The function returns a result code and a message. This is a networked event so will count against all players rate limits.

    ```lua linenums="1"
    -- Server script

    Events.BroadcastToAllPlayers("RoundCompleted", time())
    ```

    ```lua linenums="1"
    -- Client script

    Events.Connect("RoundCompleted", function(roundEndTime)
        print("Round Completed", roundEndTime)
    end)
    ```

- `Events.BroadcastToPlayer`

    This function broadcasts the event to a specific client over the network and fires all listeners attached on the client. The first argument specifies the **Player** who will receive the event. The arguments after the event name will be passed to the listener on the client. The function returns a result code and a message. This is a networked event so will count against the receiving player's rate limits.

    ```lua linenums="1"
    -- Server script
    -- Broadcast to the player when they join the game.

    Game.playerJoinedEvent:Connect(function(player)
        Events.BroadcastToPlayer(player, "OnJoinSay", "Welcome")
    end)
    ```

    ```lua linenums="1"
    -- Client script

    Events.Connect("OnJoinSay", function(message)
        print(message)
    end)
    ```

- `Events.BroadcastToServer`

    This function broadcasts the event to the server from the client over the network and fires all listeners attached on the server. Any arguments after the event name are passed to the listener on the server. The function returns a result code and a message. This is a networked event so will count against the rate limit for the server.

    ```lua linenums="1"
    -- Client script

    Events.BroadcastToServer("PurchaseItem", item_id)
    ```

    ```lua linenums="1"
    -- Server script

    Events.Connect("PurchaseItem", function(item_id)
        print(item_id)
    end)
    ```

- `Events.ConnectForPlayer`

    This function registers a listener for the event that will be called every time the event is fired using `BroadcastToServer`. The first parameter the function receives will be the **Player** that fired the event. Any arguments after the event name are passed to the listener.

    ```lua linenums="1"
    -- Client script

    Events.BroadcastToServer("PurchaseItem", item_id)
    ```

    ```lua linenums="1"
    -- Server script

    Events.ConnectForPlayer("PurchaseItem", function(player, item_id)
        print(player.name, item_id)
    end)
    ```

### Rate Limits

Functions in the **Events** namespace that communicate across the network have rate limits in place. This is to control the amount of network traffic between the server and the client.

When approaching the allowed rate limit, a warning will be displayed in the **Event Log**.

Each of the following functions return a `BroadcastEventResultCode` and error message. See the enums for the result code [here](../api/enums.md#broadcasteventresultcode).

- `BroadcastToAllPlayers`

    Rate limited to 10 per second. Will fail to broadcast if one or more connections are exceeding the rate limit. This means that each **Player** has a rate limit of 10 per second, but if any **Player** reaches the rate limit, then events will fail to broadcast.

- `BroadcastToServer`

    Rate limited to 10 per second.

- `BroadcastToPlayer`

    Rate limited to 10 per second. The rate limit is per **Player** and not for all players.

See [Events](../api/events.md) API and [Platform Limits](https://forums.coregames.com/t/platform-limits/1616) for more information.

### Data Transfer

The functions in the **Events** namespace have a limit of 128 bytes per broadcast. Broadcasts have higher priority over other methods for transferring data over the network. When needing to transfer far more data over the network, there are better alternatives that can be used.

- Networked Properties

    Using networked properties is a way to transfer data to all clients. This is very useful when clients need to know about the game state, or setting AI animations. Networked properties are replicated to all clients, this has the benefit of all clients receiving the change, however it increases network traffic. The data is replicated as soon as possible, but changing a lot of properties, or having a large amount of data can cause a delay.

- Private Networked Data

    This is ideal for transferring large chunks of data to the player. For example, loading the player's inventory from **Storage** which could contain a large number of items. This has the added benefit where data is replicated to the receiving client and not all clients.

See [SetNetworkedCustomProperty](../api/coreobject.md#setnetworkedcustomproperty) and [SetPrivateNetworkedData](../api/player.md#setprivatenetworkeddata).

## Object Events

There are various objects in **Core** that have their own events.

### Ability

Abilities can be added to players and guide the player's animation in sync with the ability's state machine. Abilities can be assigned an action binding so that when the player presses that specific binding, the ability state machine will go through the phases. Each phase of an ability will fire any attached listeners.

```lua linenums="1"
local ABILITY = script.parent
local WEAPON = script:FindAncestorByType("weapon")
local LOW_AMMO_SOUND = script:GetCustomProperty("lowAmmoSound")

local lowAmmoPercent = 0.2

function OnExecute(ability)
    if weapon.currentAmmo / weapon.maxAmmo <= lowAmmoPercent then
        World.SpawnAsset(LOW_AMMO_SOUND, { position = weapon:GetWorldPosition() })
    end
end

ability.executeEvent:Connect(OnExecute)
```

In the example code above, the **Ability** will fire `executeEvent` each time the **Ability** is used. The listener function will check the amount of ammo for the weapon, if the ammo is less than or equal to `lowAmmoPercent` a sound will be spawned. This is useful to provide feedback to the player.

See [Ability](../api/ability.md) API for more information.

### AnimatedMesh

**AnimatedMesh** objects are skeletal meshes with parameterized animations baked into them. Some animations have events that fire when certain parts of the animations are reached. This allows you to sync up hit effects with animations.

- `animationEvent`

    This event is fired with the animated mesh that triggered it and the name of the event at those points.

    ```lua linenums="1"
    local RAPTOR = script:GetCustomProperty("RaptorMob")
    local raptorMesh = World.SpawnAsset(RAPTOR)

    function AnimEventListener(mesh, eventName)
        print("Animated Mesh just hit event " .. eventName)
    end

    raptorMesh.animationEvent:Connect(AnimEventListener)
    raptorMesh:PlayAnimation("unarmed_claw")
    ```

    In the code above, the `AnimEventListener` will fire if the animation has an event. In this case the `unarmed_claw` animation has an `impact` event. This could be useful for playing a slash effect when the raptor impacts an object such as a **Player**.

See [AnimatedMesh](../api/animatedmesh.md) API for more information.

### CoreObject

**CoreObject** is an object placed in the scene hierarchy during edit mode or can be part of a template. For example, a **Cube** is a **CoreObject**, it can be placed in the hierarchy or be part of a template.

There are a lot of useful events that a **CoreObject** can use, one of those being `destroyEvent`. The `destroyEvent` is fired when this object is about to be destroyed.

```lua linenums="1"
local RAPTOR = script:GetCustomProperty("RaptorMob"):WaitForObject()

RAPTOR.destroyEvent:Connect(function(obj)
    print(obj .. " Destroyed")
end)

Task.Wait(1)
RAPTOR:Destroy()
```

In the example code above, a Raptor is destroyed by calling the `Destroy` function after 1 second. The `destroyEvent` gets the object that was destroyed.

See [CoreObject](../api/coreobject.md#events) API for more information.

### Equipment

**Equipment** is a **CoreObject** representing an equippable item for players. They generally have a visual component that attaches to the Player, but a visual component is not a requirement. Any Ability objects added as children of the **Equipment** are added / removed from the Player automatically as it becomes equipped / unequipped.

See [Equipment](../api/equipment.md#events) API for more information.

### Game

The **Game** namespace has a collection of functions and events related to players in the game, rounds of a game, and team scoring. Below are 2 useful events that you will find yourself using a lot of the time.

- `Game.playerJoinedEvent`

    Fired when a **Player** has joined the game and their character is ready. When used in client context it will fire off for each player already connected to the server.

    ```lua linenums="1"
    local function OnPlayerJoined(player)
        print(player.name .. " joined the game.")
    end

    Game.playerJoinedEvent:Connect(OnPlayerJoined)
    ```

    Knowing when a **Player** has joined the game allows you to do many things. For example, letting other players in the game know when other players have joined.

    Another useful way to use the `playerJoinedEvent` is loading the the player's data from **Storage** when they join the server, and then sending that data to them (i.e. Private Networked Data).

- `Game.playerLeftEvent`

    Fired when a player has disconnected from the game or their character has been destroyed. This event fires before the player has been removed.

    ```lua linenums="1"
    local function OnPlayerLeft(player)
        print(player.name .. " has left the game")
    end

    Game.playerLeftEvent:Connect(OnPlayerLeft)
    ```

    Knowing when a player has left the game can be used in many ways. From updating the player's **Storage**, to cleaning up variables and tables that may hold references to the **Player** leaving the game.

See [Game](../api/game.md#events) API for more information.

### IK Anchor

**IKAnchors** are objects that can be used to control player animations. They can be used to specify the position of a specific hand, foot, or the hips of a **Player**. **IKAnchors** have events that can be listened too to detect when an **IKAnchor** is activated on a player, and deactivated from the player.

See [IKAnchors](../api/ikanchor.md#events) API for more information.

### Player

**Player** is an object representation of the state of a player connected to the game, as well as their avatar in the world. The **Player** object contains a lot of useful events that can be listened too. For example, a useful thing to know is what key binding the **Player** has pressed. Listening to the `bindingPressedEvent` when a **Player** presses a specific key binding is an easy way to do this.

```lua linenums="1"
local localPlayer = Game.GetLocalPlayer()

localPlayer.bindingPressedEvent:Connect(function(player, binding)
    print("The player pressed " .. binding)
end)
```

In the code above, when a player presses a binding, it will print out to the **Event Log** what the binding was. This is useful if you need to perform a specific action based on what binding the **Player** has pressed.

See [Player](../api/player.md#events) and [Bindings](../api/key_bindings.md) API for more information.

### Trigger

A **Trigger** is an invisible and non-colliding **CoreObject** which fires events when it interacts with another object (e.g. A **Player** walks into it). **Triggers** can be used in a wide range of cases, one of them being a way to detect when a **Player** has entered the **Trigger** to show an interaction label to open a door.

!!! tip "A **Trigger** will also work in a **Client Context** by setting the **Collision** property to **Force On**."

```lua linenums="1"
local TRIGGER = script:GetCustomProperty("pickupTrigger")

TRIGGER.beginOverlapEvent:Connect(function(trigger, obj)
    if Object.IsValid(obj) and obj:IsA("Player") then
        print("Player entered the trigger").
    end
end)

TRIGGER.endOverlapEvent:Connect(function(trigger, obj)
    if Object.IsValid(obj) and obj:IsA("Player") then
        print("Player left the trigger").
    end
end)
```

In the example code above, the listeners will display a message in the **Event Log** when the **Player** enters and exits the **Trigger**.

!!! warning "When a **Vehicle** enters or exits a **Trigger**, it will fire the listener twice."

See [Trigger](../api/trigger.md#events) API for more information.

### Vehicle

**Vehicle** is a CoreObject representing a vehicle that can be occupied and driven by a **Player**. Events can be setup to listen for when a **Player** enters or exits a **Vehicle**.

See [Vehicle](../api/vehicle.md#events) API for more information.

### Weapon

A **Weapon** is an Equipment that comes with built-in Abilities and fires Projectiles. Some weapons may have projectiles, so it may be useful to know when a projectile has spawned, or when it has impacted something like a wall.

See [Weapon](../api/weapon.md#events) API for more information.

## UI Events

The **UI** namespace contains a set of class functions allowing you to get information about a Player's display and push information to their HUD. Most functions require the script to be inside a **Client Context** and execute for the local Player.

### Button

A **UIButton** is a useful UI component that allows players to interact with the **UIButton**, and various listeners can fire depending on the state of the **UIButton**. For example, detecting when a **Player** has clicked the button. Or when a player has hovered over the **UIButton** to grow the size of the **UIButton** for a nice animation effect.

See [UIButton](../api/uibutton.md#events) API for more information.

## Hooks

**Hooks** appear as properties on several objects. Similar to Events, functions may be registered that will be called whenever that hook is fired. **Hooks** are similar to **Events**, the difference being that a **Hook** is used to view or change something that's already going on in a system.

See [Hook](../api/hook.md) and [Hook](../api/hooklistener.md) API for more information.

### Chat

The Chat namespace contains functions and hooks for sending and reacting to chat messages. This could be used for example, as a way for an admin to use special commands in the chat to perform actions either on the server (moderation), or in game (give a player a resource). **Chat** hooks can even be used to turn a **Chat** into a game.

See [Chat](../api/chat.md#hooks) API for more information.

### Movement

The **Movement** hook is called when processing a player's movement. The parameters table contains a Vector3 named "direction", indicating the direction the player will move. For example, in a click to move game, the client script would detect mouse input and modify the players direction.

See [Movement](../api/player.md#hooks) API for more information.

### Input

The Input namespace contains hooks for responding to player input. For example, in a lot of games the ++escape++ key is used to open up a games menu. In **Core** the default behaviour is to open up the browse games page. Using an **Input** hook, this can be changed.

!!! tip "Players may press ++Shift++ + ++Esc++ to force the pause menu to open if the default behaviour has been changed for the ++escape++ key."

See [Input](../api/input.md) API for more information.

### Vehicle

Vehicles have 2 movement hooks that work on the client and server. The client hook `clientMovementHook` is called when processing the driver's input. `serverMovementHook` is called when on the server for a vehicle with no driver. This has the same parameters as `clientMovementHook`.

See [Vehicle](../api/vehicle.md#hooks) API for more information.

## Disconnecting

It's a good idea to disconnect any events that will no longer be used. Some events that aren't disconnected will continue to be fired even when the script that setup the listener is destroyed. A build up of events can lead to poor game performance for your players, so it's recommended to disconnect any events that no longer have a use.

Below is an example that sets up some listeners, and later when the script has been destroyed, disconnects any listeners still connected.

```lua linenums="1"
-- A table will be used to store all listeners

local myEvents = {}

-- When a listener is setup, it gets added to the myEvents table

myEvents[#myEvents + 1] = Events.Connect("YourEvent", SomeFunction)
myEvents[#myEvents + 1] = Events.Connect("YourOtherEvent", SomeOtherFunction)

-- When the script is destroyed, disconnect all events by looping through the table

script.destroyEvent:Connect(function()
    for index, event in ipairs(myEvents) do
        if event.isConnected then
            event:Disconnect()
        end
    end
end)
```

## Learn More

[Event](../api/event.md) | [Hook](../api/hook.md) | [HookListener](../api/hooklistener.md) | [EventListener](../api/eventlistener.md)
