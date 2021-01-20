---
id: vfx
name: Vfx
title: Vfx
tags:
    - API
---

# API: Vfx

## Description

Vfx is a specialized type of SmartObject for visual effects. It inherits everything from SmartObject.

## API

### Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Play([table optionalParameters])` | `None` | Starts playing the effect. The `optionalParameters` table may be provided containing:<br/> `includeDescendants (bool)`: If `true`, also plays any `Vfx` descendants of this instance. | None |
| `Stop([table optionalParameters])` | `None` | Stops playing the effect. The `optionalParameters` table may be provided containing:<br/> `includeDescendants (bool)`: If `true`, also stops any `Vfx` descendants of this instance. | None |

## Examples

### `Play`

In this example, a script is placed as a child of a Visual Effect object (e.g. Spark Explosion VFX). The `Play()` function is called periodically, with a random delay between 2 and 4 seconds. VFXs work best when they are under a client context.

```lua
local VFX = script.parent

local MIN_DELAY = 2
local MAX_DELAY = 4

while true do
    local delay = math.random(MIN_DELAY, MAX_DELAY)
    Task.Wait(delay)

    VFX:Play()
end
```

### `Stop`

In this example, a script detects when players enter and exit a trigger. If there are any players in the trigger, a looping visual effect is played (e.g. Fire Volume VFX). Once all players have left the trigger the VFX stops playing. The `Stop()` function is also called in the very beginning in case the VFX comes with "Auto Play" enabled and we are assuming no players begin inside the trigger.

```lua
local VFX = script.parent
local TRIGGER = script:GetCustomProperty("Trigger"):WaitForObject()

VFX:Stop()

local playerCount = 0

function OnBeginOverlap(trigger, other)
    if other:IsA("Player") then
        playerCount = playerCount + 1

        if playerCount == 1 then
            VFX:Play()
        end
    end
end

function OnEndOverlap(trigger, other)
    if other:IsA("Player") then
        playerCount = playerCount - 1

        if playerCount == 0 then
            VFX:Stop()
        end
    end
end

TRIGGER.beginOverlapEvent:Connect(OnBeginOverlap)
TRIGGER.endOverlapEvent:Connect(OnEndOverlap)
```

## Tutorials

[Visual Effects in Core](../tutorials/vfx_tutorial.md)
