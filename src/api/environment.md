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

## Examples

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

We may want to press a key to display some UI. However, in single-player preview mode, The [Tab] key pauses the simulation. In this example, we assign [Tab] to display the scoreboard. On each action the `Environment` is checked, to see if it is single-player preview, in which case [Caps Lock] is used instead of [Tab].

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
