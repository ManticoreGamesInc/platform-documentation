---
id: script
name: Script
title: Script
tags:
    - API
---

# Script

## Description

Script is a CoreObject representing a script in the hierarchy. While not technically a property, a script can access itself using the `script` variable.

## API

### Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `context` | `table` | Returns the table containing any non-local variables and functions created by the script. This can be used to call (or overwrite!) functions on another script. | Read-Only |

## Examples

### `context`

With `context` two scripts can communicate directly by calling on each other's functions and properties. Notice that '.' is used instead of ':' when accessing context functions. In the following example, the first script is placed directly in the hierarchy and the second script is placed inside a template of some sort. When a new player joins, the first script spawns a copy of the template and tells it about the new player. The template then follows the player around as they move.

Script directly in hierarchy:

```lua
local followTemplate = script:GetCustomProperty("FollowTemplate")

Game.playerJoinedEvent:Connect(function(player)
    local obj = World.SpawnAsset(followTemplate)
    -- Locate the script inside
    local followScript = obj:FindDescendantByType("Script")
    -- Call the context function
    followScript.context.SetTarget(player)
end)

--[[#description
    Script located inside a template. The 'targetPlayer' property and the 'SetTarget()' function can be
    accessed externally through the context.
]]
targetPlayer = nil

function SetTarget(player)
    targetPlayer = player
    script:FindTemplateRoot():Follow(player, 400, 300)
end
```
