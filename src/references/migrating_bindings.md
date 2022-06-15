---
id: migrating_bindings_reference
name: Migrating to Action Bindings
title: Migrating to Action Bindings
tags:
  - Reference
---

# Migrating to Action Bindings

## Overview

For creators who want to convert their older games to use the newer binding system, then this document will have examples of using the deprecated API functions and events that will show how to migrate to action bindings.

It is recommended to have read the [Binding Sets](../references/binding_sets.md) manual before starting. The focus will be on the Lua code rather than creating actions in the Bindings Manager.

## Core Content

All Core Content such as weapons are using action bindings and are a great way to learn how to migrate older weapon templates from projects or Community Content to action bindings.

For example, below is a comparison between the **WeaponAimClient** script that is used in some Core Content weapons and the same script that is used in older Community Content.

On the left `Input.actionPressedEvent` and `Input.actionRleasedEvent` events are used, compared to the deprecated events `player.bindingPressedEvent` and `player.bindingReleasedEvent`. With the Default Binding set, the **Aim** action will be used that is set on the custom property **AimBinding** on the weapon object.

![!Compare](../img/MigrateBindings/compare.png){: .center loading="lazy" }

## Shift to Sprint

A common thing in games is to allow Players to sprint when they hold a key down. In this case, the example below will be the ++Shift++ key which is `ability_feet` for the deprecated bindings.

```lua title="Deprecated Binding Example" hl_lines="2 8 14 15"
local function OnBindingPressed(player, binding)
    if binding == "ability_feet" then
        player.maxWalkSpeed = 1200
    end
end

local function OnBindingReleased(player, binding)
    if binding == "ability_feet" then
        player.maxWalkSpeed = 600
    end
end

local function OnPlayerJoined(player)
    player.bindingPressedEvent:Connect(OnBindingPressed)
    player.bindingReleasedEvent:Connect(OnBindingReleased)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

Migrating the above code to an action binding is straightforward. With a networked action binding for `Sprint` created in the **Bindings Manager**, it is easy to update the code.

```lua title="Action Binding Example" hl_lines="2 8 14 15"
local function OnBindingPressed(player, binding)
    if binding == "Sprint" then
        player.maxWalkSpeed = 1200
    end
end

local function OnBindingReleased(player, binding)
    if binding == "Sprint" then
        player.maxWalkSpeed = 600
    end
end

local function OnPlayerJoined(player)
    Input.actionPressedEvent:Connect(OnBindingPressed)
    Input.actionReleasedEvent:Connect(OnBindingReleased)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

## Holding a Binding

A held binding can be useful for some game mechanics such as unlocking a crate. The player would hold the binding down until the progress bar fills up which would then unlock the crate for the player.

In the example below, the `IsBindingPressed` function is used to check if the player is pressing the `ability_extra_33` key. This would the ++f++ key that is commonly used for interactions.

```lua title="Deprecated Binding Example" hl_lines="7"
local IMAGE = script:GetCustomProperty("UIImage"):WaitForObject()

local LOCAL_PLAYER = Game.GetLocalPlayer()
local isShowingImage = false

function Tick()
    if LOCAL_PLAYER:IsBindingPressed("ability_extra_33") then
        IMAGE.visibility = Visibility.INHERIT
        isShowingImage = true
    elseif isShowingImage then
        IMAGE.visibility = Visibility.FORCE_OFF
        isShowingImage = false
    end
end
```

Converting the above code to use action bindings can be done easily. The `Input` namespace has a function called `IsActionHeld` that accepts the player and action name as arguments. This is now far more readable than `ability_extra_33`.

```lua title="Action Binding Example" hl_lines="7"
local IMAGE = script:GetCustomProperty("UIImage"):WaitForObject()

local LOCAL_PLAYER = Game.GetLocalPlayer()
local isShowingImage = false

function Tick()
    if Input.IsActionHeld(LOCAL_PLAYER, "Interact") then
        IMAGE.visibility = Visibility.INHERIT
        isShowingImage = true
    elseif isShowingImage then
        IMAGE.visibility = Visibility.FORCE_OFF
        isShowingImage = false
    end
end
```

## Summary

Games that use Binding Sets give the player the option to customize their bindings how they want, this is a limiting factor with the deprecated binding API, and also made it difficult to remember which binding string represented a key without looking it up.

## Learn More

[Binding Sets](../references/binding_sets.md) | [Deprecated Key Bindings](https://github.com/ManticoreGamesInc/platform-documentation/blob/development/src/api/key_bindings.md)
