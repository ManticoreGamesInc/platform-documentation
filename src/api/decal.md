---
id: decal
name: Decal
title: Decal
tags:
    - API
---

# Decal

A Decal is a SmartObject representing a decal that is projected onto nearby surfaces.

## Examples

Example using:

In this example, the "Decal Elven Symbols" is added to the game and assigned as a custom property to this client script. Every half-second we change the shape of the decal, cycling through all 16 shapes.

```lua
local DECAL = script:GetCustomProperty("DecalElvenSymbols"):WaitForObject()
local TOTAL_SHAPES = 16

while true do
    Task.Wait(0.5)
    -- Next shape
    local index = DECAL:GetSmartProperty("Shape Index")
    index = (index + 1) % TOTAL_SHAPES
    DECAL:SetSmartProperty("Shape Index", index)
end
```

See also: [SmartObject.GetSmartProperty](smartobject.md) | [CoreObject.GetCustomProperty](coreobject.md) | [Task.Wait](task.md)

---
