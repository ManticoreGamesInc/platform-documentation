---
id: hooklistener
name: HookListener
title: HookListener
tags:
    - API
---

# HookListener

HookListeners are returned by Hooks when you connect a listener function to them.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `isConnected` | `boolean` | Returns `true` if this listener is still connected to its hook, `false` if the hook owner was destroyed or if `Disconnect` was called. | Read-Only |
| `priority` | `integer` | The priority of this listener. When a given hook is fired, listeners with a higher priority are called first. Default value is `100`. | Read-Write |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Disconnect()` | `None` | Disconnects this listener from its hook, so it will no longer be called when the hook is fired. | None |

## Examples

Example using:

### `isConnected`

### `priority`

### `Disconnect`

In this example, a client script implements a stun effect that prevents the local player from moving while one or more stuns are active.

```lua
local STUN_VFX = script:GetCustomProperty("StunVFX")
local STUN_DURATION = 1.5

local moveHookListener = nil
local stunVfx = nil

function ApplyStunToLocalPlayer()
    -- Get reference to the player
    local player = Game.GetLocalPlayer()
    
    -- Initialize stun count if needed
    if not player.clientUserData.stunCount then
        player.clientUserData.stunCount = 0
    end
    -- Keep track of how many times stun has been called, in case multiple stuns overlap in time
    player.clientUserData.stunCount = player.clientUserData.stunCount + 1
    
    -- Connect to the movement hook only once
    if not moveHookListener or not moveHookListener.isConnected then
        moveHookListener = player.movementHook:Connect(OnPlayerMovement)
        -- Set a low priority. In case other gameplay systems modify movement the stun happens last
        moveHookListener.priority = 20
    end
    
    -- Spawn a visual effect to communicate the stun, in case it doesn't exist yet
    if not stunVfx then
        local playerPos = player:GetWorldPosition()
        stunVfx = World.SpawnAsset(STUN_VFX, {position = playerPos})
    end
    
    -- Duration of the stun effect
    Task.Wait(STUN_DURATION)
    
    -- Stun effect has passed. Decrease the counter
    if player.clientUserData.stunCount > 0 then
        player.clientUserData.stunCount = player.clientUserData.stunCount - 1
    end
    
    -- If there are no more stuns active, cleanup
    if player.clientUserData.stunCount == 0 then
        stunVfx:Destroy()
        
        moveHookListener:Disconnect()
        moveHookListener = nil
    end
end

-- A server script will initiate the stun by calling `Events.BroadcastToPlayer()`
Events.Connect("StunPlayer", ApplyStunToLocalPlayer)

function OnPlayerMovement(player, params)
    if player.clientUserData.stunCount
    and player.clientUserData.stunCount > 0 then
        -- Prevent player from moving while there's an active stun
        params.direction = Vector3.ZERO
    end
end
```

See also: [Hook.Connect](hook.md) | [Player.movementHook](player.md) | [Events.BroadcastToPlayer](events.md) | [World.SpawnAsset](world.md) | [CoreObject.Destroy](coreobject.md) | [Task.Wait](task.md) | [Vector3.ZERO](vector3.md)

---
