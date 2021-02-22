---
id: events
name: Events
title: Events
tags:
    - API
---

# Events

User defined events can be specified using the Events namespace. The Events namespace uses the following class functions:

## Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `Events.Connect(string eventName, function eventListener, [...])` | [`EventListener`](eventlistener.md) | Registers the given function to the event name which will be called every time the event is fired using Broadcast. Returns an EventListener which can be used to disconnect from the event or check if the event is still connected. Accepts any number of additional arguments after the listener function, those arguments will be provided after the event's own parameters. | None |
| `Events.ConnectForPlayer(string eventName, function eventListener, [...])` | [`EventListener`](eventlistener.md) | Registers the given function to the event name which will be called every time the event is fired using BroadcastToServer. The first parameter the function receives will be the Player that fired the event. Returns an EventListener which can be used to disconnect from the event or check if the event is still connected. Accepts any number of additional arguments after the listener function, those arguments will be provided after the event's own parameters. | Server-Only |
| `Events.Broadcast(string eventName, [...])` | `string` | Broadcasts the given event and fires all listeners attached to the given event name if any exists. Parameters after event name specifies the arguments passed to the listener. Any number of arguments can be passed to the listener function. The events are not networked and can fire events defined in the same context. | None |
| `Events.BroadcastToAllPlayers(string eventName, [...])` | <[`BroadcastEventResultCode`](enums.md#broadcasteventresultcode), string errorMessage`>` | Broadcasts the given event to all clients over the network and fires all listeners attached to the given event name if any exists. Parameters after event name specify the arguments passed to the listener on the client. The function returns a result code and a message. This is a networked event. | Server-Only |
| `Events.BroadcastToPlayer(Player player, string eventName, [...])` | <[`BroadcastEventResultCode`](enums.md#broadcasteventresultcode), string errorMessage`>` | Broadcasts the given event to a specific client over the network and fires all listeners attached to the given event name if any exists on that client. The first parameter specifies the Player to which the event will be sent. The parameters after event name specify the arguments passed to the listener on the client. The function returns a result code and a message. This is a networked event. | Server-Only |
| `Events.BroadcastToServer(string eventName, [...])` | <[`BroadcastEventResultCode`](enums.md#broadcasteventresultcode), string errorMessage`>` | Broadcasts the given event to the server over the network and fires all listeners attached to the given event name if any exists on the server. The parameters after event name specify the arguments passed to the listener on the server. The function returns a result code and a message. This is a networked event. | Client-Only |

## Additional Info

The maximum size a networked event can send is 128 bytes and all networked events are subjected to a rate limit of 10 events per second.

??? "Broadcast Event Result Codes"
    - BroadcastEventResultCode.SUCCESS
    - BroadcastEventResultCode.FAILURE
    - BroadcastEventResultCode.EXCEEDED_SIZE_LIMIT
    - BroadcastEventResultCode.EXCEEDED_RATE_WARNING_LIMIT
    - BroadcastEventResultCode.EXCEEDED_RATE_LIMIT

??? "Networked Events Supported Types"
    - boolean
    - CoreObjectReference
    - Color
    - Float
    - Int32
    - Player
    - Rotation
    - string
    - table
    - Vector2
    - Vector3
    - Vector4

## Examples

Using:

- `BroadcastToAllPlayers`

This event connection allows the server to send a message to all players. In this example, two scripts communicate over the network. The first one is on the server as child of a Trigger and the second one is in a Client Context. The server is authoritative over the state of the flag being captured and listens for overlaps on the Trigger. When a new team captures the flag a message is sent to all clients with information about who captured and what team they belong to.

Server script:

```lua
local teamHasFlag = 0

function OnBeginOverlap(trigger, other)
    if other and other:IsA("Player") and other.team ~= teamHasFlag then
        teamHasFlag = other.team

        local resultCode, errorMsg = Events.BroadcastToAllPlayers("FlagCaptured", other.name, other.team)
        print("Server sent FlagCaptured event. Result Code = " .. resultCode .. ", error message = " .. errorMsg)
    end
end

script.parent.beginOverlapEvent:Connect(OnBeginOverlap)

--[[#description
    Client script:
]]
function OnFlagCaptured(playerName, playerTeam)
    local message = playerName .. " captured the flag for team " .. playerTeam

    UI.PrintToScreen(message, Color.MAGENTA)
    print(message)
end

Events.Connect("FlagCaptured", OnFlagCaptured)
```

See also: [other.IsA](other.md) | [Player.team](player.md) | [CoreLua.print](coreluafunctions.md) | [CoreObject.parent](coreobject.md) | [Trigger.beginOverlapEvent](trigger.md) | [UI.PrintToScreen](ui.md) | [Events.Connect](events.md) | [Event.Connect](event.md)

---

Using:

- `BroadcastToPlayer`

If your script runs on a server, you can broadcast game-changing information to your players. In this example, the OnExecute function was connected to an ability object's executeEvent. This bandage healing ability depends on a few conditions, such as bandages being available in the inventory and the player having actually lost any hit points. If one of the conditions is not true, the broadcast function is used for delivering a user interface message that only that player will see.

```lua
local ABILITY

function OnExecute(ability)
    if ability.owner:GetResource("Bandages") <= 0 then
        Events.BroadcastToPlayer(ability.owner, "BannerSubMessage", "No Bandages to Apply")
        return
    end

    if ability.owner.hitPoints < ability.owner.maxHitPoints then
        ability.owner:ApplyDamage(Damage.New(-30))
        ability.owner:RemoveResource("Bandages", 1)
    else
        Events.BroadcastToPlayer(ability.owner, "BannerSubMessage", "Full Health")
    end
end

ABILITY.executeEvent:Connect(OnExecute)
```

See also: [Ability.owner](ability.md) | [Player.GetResource](player.md) | [Damage.New](damage.md) | [Event.Connect](event.md)

---

Using:

- `Connect`
- `Broadcast`

The `Events` namespace allows two separate scripts to communicate without the need to reference each other directly. In this example, two scripts communicate through a custom "GameStateChanged" event. The first one has the beginnings of a state machine and broadcasts the event each time the state changes. The second script listens for that specific event. This is a non-networked message.

Primary script that drives the state machine:

```lua
local currentState = ""

function SetState(newState)
    currentState = newState
    Events.Broadcast("GameStateChanged", newState)
end

function Tick(deltaTime)
    SetState("Lobby")
    Task.Wait(1)
    SetState("Playing")
    Task.Wait(3)
end

--[[#description
    A separate script that listens to event changes:
]]
function OnStateChanged(newState)
    print("New State = " .. newState)
end

Events.Connect("GameStateChanged", OnStateChanged)
```

See also: [Task.Wait](task.md) | [CoreLua.Tick](coreluafunctions.md)

---

Using:

- `ConnectForPlayer`
- `BroadcastToServer`

This event connection allows the server to listen for broadcasts that originate from clients. In this example, two scripts communicate over the network. The first one is in a Server Context and the second one is in a Client Context. The client can send input data to the server, in this case their cursor's position.

Server script:

```lua
function OnPlayerInputData(player, data)
    print("Player " .. player.name .. " sent  data = " .. tostring(data))
end

Events.ConnectForPlayer("CursorPosition", OnPlayerInputData)

--[[#description
    Client script:
]]
UI.SetCursorVisible(true)

function Tick(deltaTime)
    local cursorPos = UI.GetCursorPosition()
    Events.BroadcastToServer("CursorPosition", cursorPos)
    Task.Wait(0.25)
end
```

See also: [Player.name](player.md) | [UI.SetCursorVisible](ui.md) | [CoreLua.Tick](coreluafunctions.md) | [Task.Wait](task.md)

---
