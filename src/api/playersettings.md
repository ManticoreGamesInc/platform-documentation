---
id: playersettings
name: PlayerSettings
title: PlayerSettings
tags:
    - API
---

# PlayerSettings

Settings that can be applied to a Player.

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `ApplyToPlayer(Player)` | `None` | Apply settings from this settings object to Player. | Server-Only |

## Examples

Example using:

### `ApplyToPlayer`

The `Player Settings` object determines a player's movement, camera and other such properties. In this example, when an ability is activated it applies a special `Player Settings` for a short period of time. Afterwards, it reverts the player back to default settings.

```lua
local SPECIAL_PLAYER_SETTINGS = script:GetCustomProperty("SpecialPlayerSettings"):WaitForObject()
local DEFAULT_SETTINGS = World.FindObjectByName("Third Person Player Settings")
local ABILITY = script:FindAncestorByType("Ability")
local EFFECT_DURATION = 3

function OnAbilityExecute(ability)
    local player = ability.owner
    
    SPECIAL_PLAYER_SETTINGS:ApplyToPlayer(player)
    
    Task.Wait(EFFECT_DURATION)
    
    if Object.IsValid(player) then
        DEFAULT_SETTINGS:ApplyToPlayer(player)
    end
end

ABILITY.executeEvent:Connect(OnAbilityExecute)
```

See also: [Ability.executeEvent](ability.md) | [World.FindObjectByName](world.md) | [CoreObject.FindAncestorByType](coreobject.md) | [Object.IsValid](object.md) | [Task.Wait](task.md)

---

Example using:

### `ApplyToPlayer`

In this example, we can avoid exploits and bugs, such as players gaining infinite movement speed bonuses when they equip/unequip items in particular sequences. We achieve this by defining two functions, `ApplySettings()` and `RemoveSettings()` that are to be used instead of directly applying settings to a player. This adds a layer of decision-making when adding/removing settings, allowing a more complex project where multiple gameplay systems modify players at arbitrary moments. As long as Apply/Remove are called consistently problems are avoided and settings resolve themselves back, like an "Undo" stack.

```lua
local DEFAULT_SETTINGS = World.FindObjectByName("Third Person Player Settings")
    
function ApplySettings(player, settings)
    local stack = GetSettingsStack(player)
    
    table.insert(stack, settings)
    
    settings:ApplyToPlayer(player)
end

function RemoveSettings(player, settings)
    local stack = GetSettingsStack(player)
    
    for i = #stack, 1, -1 do
        if stack[i] == settings then
            table.remove(stack, i)

            if #stack == 0 then
                -- The stack is empty. Go back to default player settings
                DEFAULT_SETTINGS:ApplyToPlayer(player)
                
            elseif i == #stack + 1 then
                -- The top settings was removed. Go back to previous one
                local previousSettings = stack[#stack]
                previousSettings:ApplyToPlayer(player)
            else
                -- In case a setting from the middle of the stack is removed,
                -- do nothing.
            end
            return
        end
    end
end

function GetSettingsStack(player, ikAnchor)
    if player.serverUserData.settingsStack == nil then
        player.serverUserData.settingsStack = {}
    end
    return player.serverUserData.settingsStack
end
```

See also: [Player.serverUserData](player.md) | [World.FindObjectByName](world.md)

---
