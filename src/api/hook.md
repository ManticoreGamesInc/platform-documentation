---
id: hook
name: Hook
title: Hook
tags:
    - API
---

# Hook

Hooks appear as properties on several objects. Similar to Events, functions may be registered that will be called whenever that hook is fired, but Hooks allow those functions to modify the parameters given to them. E.g. `player.movementHook:Connect(OnPlayerMovement)` calls the function `OnPlayerMovement` each tick, which may modify the direction in which a player will move.

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Connect(function hookListener, [...])` | [`HookListener`](hooklistener.md) | Registers the given function which will be called every time the hook is fired. Returns a HookListener which can be used to disconnect from the hook or change the listener's priority. Accepts any number of additional arguments after the listener function, those arguments will be provided after the hook's own parameters. | None |

## Examples

Using:

- `Connect`

A simple example of how to implement "Click to Move" in your game, useful in conjunction with a top down camera. This client script detects mouse clicks with the `OnBindingPressed` function and saves the clicked point as the `goal`. Then, in the `OnPlayerMovement` function the goal is used to recalculate the player's direction.

```lua
UI.SetCursorVisible(true)
UI.SetCanCursorInteractWithUI(true)

local PLAYER = Game.GetLocalPlayer()
local STOP_THRESHOLD = 120*120
local goal = nil

function OnPlayerMovement(player, params)
    if goal and params.direction == Vector3.ZERO then
        local playerPos = player:GetWorldPosition()
        local direction = goal - playerPos
        if direction.sizeSquared < STOP_THRESHOLD then
            goal = nil
        else
            CoreDebug.DrawLine(playerPos, goal, {thickness = 15, color = Color.New(1, .5, 0)})
            direction = direction * Vector3.New(1, 1, 0)
            params.direction = direction:GetNormalized()
        end
    else
        goal = nil
    end
end

function OnBindingPressed(player, binding)
    if binding == "ability_primary" then
        local hitResult = UI.GetCursorHitResult()
        if hitResult then
            goal = hitResult:GetImpactPosition()
        end
    end
end

PLAYER.movementHook:Connect(OnPlayerMovement)
PLAYER.bindingPressedEvent:Connect(OnBindingPressed)
```

See also: [Player.bindingPressedEvent](player.md)

---

Using:

- `Connect`

How to reverse a player's walking direction.

```lua
Game.GetLocalPlayer().movementHook:Connect(function(player, params)
params.direction = -params.direction
end)
```

See also: [Player.movementHook](player.md)

---
