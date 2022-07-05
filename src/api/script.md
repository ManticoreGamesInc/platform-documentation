---
id: script
name: Script
title: Script
tags:
    - API
---

# Script

Script is a CoreObject representing a script in the hierarchy. While not technically a property, a script can access itself using the `script` variable.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `context` | `table` | Returns the table containing any non-local variables and functions created by the script. This can be used to call (or overwrite!) functions on another script. | Read-Only |
| `scriptAssetId` | `string` | Returns the asset ID of the script this instance is executing. | Read-Only |

## Examples

Example using:

### `context`

With `context` two scripts can communicate directly by calling on each other's functions and properties. Notice that '.' is used instead of ':' when accessing context functions. In the following example, the first script is placed directly in the hierarchy and the second script is placed inside a template of some sort. When a new player joins, the first script spawns a copy of the template and tells it about the new player. The template then follows the player around as they move.

Script directly in hierarchy:

```lua
local followTemplate = script:GetCustomProperty("FollowTemplate")

local function OnPlayerJoined(player)
    local obj = World.SpawnAsset(followTemplate)
    -- Locate the script inside
    local followScript = obj:FindDescendantByType("Script")
    -- Call the context function
    followScript.context.SetTarget(player)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)

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

See also: [CoreObject.GetCustomProperty](coreobject.md) | [World.SpawnAsset](world.md) | [Game.playerJoinedEvent](game.md) | [Event.Connect](event.md)

---

Example using:

### `scriptAssetId`

Architectures designed for componentization have many advantages when building larger projects. In this example, we have a script that will be `required` and will serve as a central manager, where other scripts call to register themselves. In case a script gets duplicated, such as from the importing of Community Content, it's possible the game ends up with multiple mismatching versions of a component. By taking a moment to compare the script asset IDs we future-proof the system and make it more robust. The asset IDs are also printed to the Event Log, so they can be easily located by searching Project Content with `/muid=<asset ID>`.

```lua
local API = {}

local registeredComponents = {}
local registeredScriptAssets = {}

function API.Register(scriptObj)
    local existingAssetId = registeredScriptAssets[scriptObj.name]
    if existingAssetId then
        if existingAssetId ~= scriptObj.scriptAssetId then
            warn("Registering different scripts with the same name '"..scriptObj.name..
            "'. Different versions of the same script can lead to unexpected behavior. Assets: "..
            existingAssetId.." and "..scriptObj.scriptAssetId)
        end
    else
        registeredScriptAssets[scriptObj.name] = scriptObj.scriptAssetId
    end
    table.insert(registeredComponents, scriptObj)
end

return API
```

See also: [CoreLuaFunctions.require](coreluafunctions.md) | [CoreObject.name](coreobject.md)

---
