---
id: hook
name: Hook
title: Hook
tags:
    - API
---

# API: Hook

## Description

Hooks appear as properties on several objects. Similar to Events, functions may be registered that will be called whenever that hook is fired, but Hooks allow those functions to modify the parameters given to them. E.g. `player.movementHook:Connect(OnPlayerMovement)` calls the function `OnPlayerMovement` each tick, which may modify the direction in which a player will move.

## API

### Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Connect(function hookListener, [...])` | `HookListener` | Registers the given function which will be called every time the hook is fired. Returns a HookListener which can be used to disconnect from the hook or change the listener's priority. Accepts any number of additional arguments after the listener function, those arguments will be provided after the hook's own parameters. | None |

## Examples

### `Connect`

A basic example on how to implement "Click to Move" in your game.

```lua
UI.SetCursorVisible(true)
UI.SetCanCursorInteractWithUI(true)

local goal
local holdPosition = false

Game.GetLocalPlayer().movementHook:Connect(function(player, params)
    if not holdPosition and goal and params.direction == Vector3.ZERO then
        local playerPos = player:GetWorldPosition()
        if (goal - playerPos).size < 120 then
            goal = nil
        else
            CoreDebug.DrawLine(playerPos, goal, {thickness = 15, color = Color.New(1, .5, 0)})
            params.direction = ((goal - playerPos)*(Vector3.ONE - Vector3.UP)):GetNormalized()
            return
        end
    else
        goal = nil
    end
end)

Game.GetLocalPlayer().bindingPressedEvent:Connect(function(player, binding)
    if binding == "ability_primary" then
        local hitResult = UI.GetCursorHitResult()
        if hitResult then
            goal = hitResult:GetImpactPosition()
        end
    end
    if binding == "ability_feet" then
        holdPosition = true
    end
end)

Game.GetLocalPlayer().bindingReleasedEvent:Connect(function(player, binding)
    if binding == "ability_feet" then
        holdPosition = false
    end
end)
```

### `Connect`

How to reverse a player's walking direction.

```lua
Game.GetLocalPlayer().movementHook:Connect(function(player, params)
params.direction = -params.direction
end)
```
