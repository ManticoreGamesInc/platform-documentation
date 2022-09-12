---
id: environment
name: Environment
title: Environment
tags:
    - API
---

# Environment

The Environment namespace contains a set of functions for determining where a script is running. Some of these functions are paired together. For example, a script will return `true` for one of `Environment.IsServer()` or `Environment.IsClient()`, but never for both. Similarly, either `Environment.IsLocalGame()` or `Environment.IsHostedGame()` will return `true`, but not both.

## Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `Environment.IsServer()` | `boolean` | Returns `true` if the script is running in a server environment. Note that this can include scripts running in the editor in preview mode (where the editor acts as server for the game) or for the "Play Locally" option in the Main Menu. This will always return `false` for scripts in a Client Context. | None |
| `Environment.IsClient()` | `boolean` | Returns `true` if the script is running in a client environment. This includes scripts that are in a Client Context, as well as scripts in a Static Context on a multiplayer preview client or a client playing a hosted game. Note that single-player preview and the "Play Locally" option only execute Static Context scripts once, and that is in a server environment. | None |
| `Environment.IsHostedGame()` | `boolean` | Returns `true` if running in a published online game, for both clients and servers. | None |
| `Environment.IsLocalGame()` | `boolean` | Returns `true` if running in a local game on the player's computer. This includes preview mode, as well as the "Play Locally" option in the Main Menu. | None |
| `Environment.IsPreview()` | `boolean` | Returns `true` if running in preview mode. | None |
| `Environment.IsMultiplayerPreview()` | `boolean` | Returns `true` if running in multiplayer preview mode. | None |
| `Environment.IsSinglePlayerPreview()` | `boolean` | Returns `true` if running in single-player preview mode. | None |
| `Environment.GetDetailLevel()` | [`DetailLevel`](enums.md#detaillevel) | Returns the Detail Level selected by the player in the Settings menu. Useful for determining whether to spawn templates for VFX or other client-only objects, or selecting templates that are optimized for a particular detail level based on the player's settings. | Client-Only |
| `Environment.GetPlatform()` | [`PlatformType`](enums.md#platformtype) | Returns the type of platform on which Core is currently running. | None |

## Examples

Example using:

### `GetDetailLevel`

In this example, we implement an `Explosion()` function that can be called as a result of some gameplay moment. However, the explosion effects may be too expensive on low-end devices. To solve this, we provide two alternative VFX templates. At runtime we decide which of the two to spawn, based on the player's chosen level of detail.

```lua
local FULL_VFX_TEMPLATE = script:GetCustomProperty("FullVFX")
local BASIC_VFX_TEMPLATE = script:GetCustomProperty("BasicVFX")

function Explosion(epicenter, radius, damageAmount)
    -- An optimization because .sizeSquared is faster than .size
    local radiusSquared = radius * radius

    -- Deal damage in the area
    local damageables = World.FindObjectsByType("Damageable")
    local dmg = Damage.New(damageAmount)

    for _,obj in ipairs(damageables) do
        local deltaPos = epicenter - obj:GetWorldPosition()
        if deltaPos.sizeSquared <= radiusSquared then
            obj:ApplyDamage(dmg)
        end
    end

    -- Spawn visual effects
    local detailLevel = Environment.GetDetailLevel()

    if detailLevel > DetailLevel.LOW then
        -- High-quality effects
        World.SpawnAsset(FULL_VFX_TEMPLATE, {position = epicenter})
    else
        -- Basic effects, for low-end devices
        World.SpawnAsset(BASIC_VFX_TEMPLATE, {position = epicenter})
    end
end
```

See also: [World.FindObjectsByType](world.md) | [CoreObject.GetCustomProperty](coreobject.md) | [Damage.New](damage.md) | [Vector3.sizeSquared](vector3.md)

---

Example using:

### `GetPlatform`

Knowing what platform Core is running on can be useful if you need to handle something specific for one platform. For example, on iOS it could be possible that the player is using a controller plugged into the device, so the input type would be controller. Having a way to detect the platform type would allow creators to handle things such as what UI to display based on the platform type instead of the input type.

```lua
-- Client script

-- Get the platform for the client, this is an integer
local platform = Environment.GetPlatform()

-- A check against the PlatformType enums can be done.

if platform == PlatformType.IOS then
    print("Do something specific for the iOS platform.")
else
    print("Do something for all other platforms.")
end

-- Creators can access the enum directly by passing in the integer, and
-- will get back the platform name
print(PlatformType.GetName(Environment.GetPlatform()))
```

See also: [PlatformType](enums.md#platformtype) | [CoreLua.print](coreluafunctions.md)

---

Example using:

### `IsServer`

### `IsClient`

Sometimes a script can be written for use on either server or client contexts. In this example, we access the player's user data tables in an abstract way, by creating a function that checks the environment and returns the correct table.

```lua
function GetUserData(player)
    if Environment.IsServer() then
        return player.serverUserData

    elseif Environment.IsClient() then
        return player.clientUserData
    end
end

GetUserData(player)["example"] = true
```

See also: [Player.serverUserData](player.md)

---

Example using:

### `IsSinglePlayerPreview`

We may want to press a key to display some UI. However, in single-player preview mode, The ++tab++ key pauses the simulation. In this example, we assign ++tab++ to display the scoreboard. On each action the `Environment` is checked, to see if it is single-player preview, in which case ++caps-lock++ is used instead of ++tab++.

```lua
local CAPS_LOCK_ACTION = script:GetCustomProperty("CapsLockAction")
local TAB_ACTION = script:GetCustomProperty("TabAction")

local function IsTabAction(action)
    if Environment.IsSinglePlayerPreview() then
        return action == CAPS_LOCK_ACTION
    else
        return action == TAB_ACTION
    end
end

local function OnActionPressed(player, action)
    if IsTabAction(action) then
        print("Show Scoreboard")
        Events.Broadcast("ShowScoreboard")
    end
end

Input.actionPressedEvent:Connect(OnActionPressed)
```

See also: [Game.playerJoinedEvent](game.md) | [Input.actionPressedEvent](input.md) | [Events.Broadcast](events.md)

---
