---
id: input
name: Input
title: Input
tags:
    - API
---

# Input

The Input namespace contains functions and hooks for responding to player input.

## Hooks

| Hook Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `escapeHook` | `Hook<`[`Player`](player.md) player, table parameters`>` | Hook called when the local player presses the Escape key. The `parameters` table contains a `boolean` named "openPauseMenu", which may be set to `false` to prevent the pause menu from being opened. Players may press `Shift-Esc` to force the pause menu to open without calling this hook. | Client-Only |

## Examples

Example using:

### `escapeHook`

Core has a default pause menu that appears when a player presses the ESC key. This client script demonstrates how to prevent Core's default pause from occurring and replace it with a custom menu. As a fallback in case your UI gets stuck, Shift + ESC allows you to access Core's default pause, even with the escape hook in place.

```lua
local CUSTOM_MENU = script:GetCustomProperty("MenuPanel"):WaitForObject()
local EXIT_BUTTON = script:GetCustomProperty("ExitButton"):WaitForObject()

CUSTOM_MENU.visibility = Visibility.FORCE_OFF
local isShowingMenu = false

function ShowMenu()
    -- Show our custom menu and enable mouse control
    isShowingMenu = true
    CUSTOM_MENU.visibility = Visibility.INHERIT
    UI.SetCanCursorInteractWithUI(true)
    UI.SetCursorVisible(true)
end

function HideMenu()
    -- Hide our custom menu and disable mouse control
    isShowingMenu = false
    CUSTOM_MENU.visibility = Visibility.FORCE_OFF
    UI.SetCanCursorInteractWithUI(false)
    UI.SetCursorVisible(false)
end

function OnEscape(localPlayer, params)
    -- Prevents Core's default pause from appearing
    params.openPauseMenu = false
    
    -- Toggle the custom menu on/off
    if isShowingMenu then
        HideMenu()
    else
        ShowMenu()
    end
end

-- Intercept the ESC key being pressed
Input.escapeHook:Connect(OnEscape)

-- Send players to Core World when they press the custom "Exit" button
EXIT_BUTTON.clickedEvent:Connect(function()
    Game.GetLocalPlayer():TransferToGame("e39f3e/core-world")
end)
```

See also: [Player.TransferToGame](player.md) | [UIButton.clickedEvent](uibutton.md) | [UI.SetCanCursorInteractWithUI](ui.md) | [Game.GetLocalPlayer](game.md)

---
