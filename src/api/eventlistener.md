---
id: eventlistener
name: EventListener
title: EventListener
tags:
    - API
---

# EventListener

EventListeners are returned by Events when you connect a listener function to them.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `isConnected` | `bool` | Returns true if this listener is still connected to its event. false if the event owner was destroyed or if Disconnect was called. | Read-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Disconnect()` | `None` | Disconnects this listener from its event, so it will no longer be called when the event is fired. | None |

## Examples

Using:

- `Disconnect`
- `isConnected`

When `Connect()` is called, an `EventListener` structure is returned. In some situations it's good to save the listener in order to disconnect from the event later. In the following example, we are listening for the local player gaining or losing resources. However, if this script is destroyed for some reason, then it will be hanging in memory due to the event connection. In this case it's important to `Disconnect()` or a small memory leak is created. This script presumes to be in a Client Context.

```lua
function OnResourceChanged(player, resName, resValue)
    print("Resource " .. resName .. " = " .. resValue)
end

local resourceChangedListener = nil

function OnPlayerJoined(player)
    if player == Game.GetLocalPlayer() then
        resourceChangedListener = player.resourceChangedEvent:Connect(OnResourceChanged)
    end
end

if Game.GetLocalPlayer() then
    OnPlayerJoined(Game.GetLocalPlayer())
else
    Game.playerJoinedEvent:Connect(OnPlayerJoined)
end

function OnDestroyed(obj)
    if resourceChangedListener and resourceChangedListener.isConnected then
        resourceChangedListener:Disconnect()
        resourceChangedListener = nil
    end
end

script.destroyEvent:Connect(OnDestroyed)
```

---
