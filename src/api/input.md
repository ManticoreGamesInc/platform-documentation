---
id: input
name: Input
title: Input
tags:
    - API
---

# Input

The Input namespace contains functions and hooks for responding to player input.

## Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `Input.GetActionValue(Player, string actionName)` | `value` | Returns the current input value associated with the specified action. This will return a `Vector2` for direction bindings, a `number` for basic and axis bindings, or `nil` for invalid bindings. `nil` may also be returned when called on the server with a non-networked action name or a networked action which simply hasn't been pressed yet. | None |
| `Input.IsActionHeld(Player, string actionName)` | `boolean` | Returns `true` if the specified action is currently being held by the player, otherwise returns `false`. | None |
| `Input.GetCurrentInputType()` | [`InputType`](enums.md#inputtype) | Returns the current active input type. | Client-Only |
| `Input.IsYAxisInverted(InputType)` | `boolean` | Returns `true` if the player has inverted the Y axis in their settings for the given input type, otherwise returns `false`. | Client-Only |
| `Input.GetActionDescription(string actionName)` | `string` | Returns the description set in the Bindings Manager for the specified action. Returns `nil` if given an invalid action name. | Client-Only |

## Events

| Event Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `Input.actionPressedEvent` | [`Event`](event.md)<[`Player`](player.md) player, `string` actionName, `value` value> | Fired when a player starts an input action by pressing a key, button, or other input control. The third parameter, `value`, will be a `Vector2` for direction bindings, or a `number` for axis and basic bindings. | None |
| `Input.actionReleasedEvent` | [`Event`](event.md)<[`Player`](player.md) player, `string` actionName> | Fired when a player stops an input action by releasing a key, button, or other input control. | None |
| `Input.inputTypeChangedEvent` | [`Event`](event.md)<[`Player`](player.md) player, [`InputType`](enums.md#inputtype) inputType> | Fired when the active input device has changed to a new type of input. | None |

## Hooks

| Hook Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `escapeHook` | [`Hook`](hook.md)<[`Player`](player.md) player, `table` parameters> | Hook called when the local player presses the Escape key. The `parameters` table contains a `boolean` named "openPauseMenu", which may be set to `false` to prevent the pause menu from being opened. Players may press `Shift-Esc` to force the pause menu to open without calling this hook. | Client-Only |

## Examples

Example using:

### `actionPressedEvent`

Hotbars in games are a useful way for players to access things such as abilities, weapons, or tools quickly. This example shows how the mouse wheel can be used to scroll through all the slots in a hotbar. It supports wrapping around when scrolling past the start or end of the hotbar.

```lua
-- Client script.

-- The container that holds the slots.
local SLOTS_CONTAINER = script:GetCustomProperty("SlotsContainer"):WaitForObject()

-- The color of the slot frame when it is active.
local ACTIVE_COLOR = script:GetCustomProperty("ActiveColor")

-- The color of the slot frame when it is inactive.
local INACTIVE_COLOR = script:GetCustomProperty("InactiveColor")

-- The current active slot index.
local currentSlotIndex = 1

-- All the slots in the container.
local slots = SLOTS_CONTAINER:GetChildren()

-- Total slots, just caching it here for use later.
local totalSlots = #slots

-- Sets a slot to become active based on the index passed in.
local function SetActiveSlot(index)
    slots[index]:FindChildByName("Frame"):SetColor(ACTIVE_COLOR)
end

-- Clears the last active slot based on the index passed in.
local function ClearActiveSlot(index)
    slots[index]:FindChildByName("Frame"):SetColor(INACTIVE_COLOR)
end

-- Listens for when an action is pressed.
Input.actionPressedEvent:Connect(function(player, action, value)
    -- Checks to see if the action is the Zoom action.
    -- This could be a custom action, doesn't need to be named "Zoom".
    if action == "Zoom" then
        -- Need to store the old slot to compare later on.
        local oldSlotIndex = currentSlotIndex

        -- Scroll wheel will either be -1 or 1.
        if value > 0 then
            currentSlotIndex = currentSlotIndex == totalSlots and 1 or (currentSlotIndex + 1)
        elseif value < 0 then
            currentSlotIndex = currentSlotIndex == 1 and totalSlots or (currentSlotIndex - 1)
        end

        -- If the slot has changed, clear the old one and set the new one.
        if oldSlotIndex ~= currentSlotIndex then
            ClearActiveSlot(oldSlotIndex)
            SetActiveSlot(currentSlotIndex)
        end
    end
end)

-- Set the active slot from the start (1 in this case).
SetActiveSlot(currentSlotIndex)
```

See also: [CoreObject.GetCustomProperty](coreobject.md) | [CoreObjectReference.WaitForObject](coreobjectreference.md) | [UIImage.SetColor](uiimage.md)

---

Example using:

### `escapeHook`

Core has a default pause menu that appears when a player presses the ESC key. This client script demonstrates how to prevent Core's default pause from occurring and replace it with a custom menu. As a fallback in case your UI gets stuck, Shift + ESC allows you to access Core's default pause, even with the escape hook in place.

```lua
-- "MenuPanel" is a UI Panel assigned as a custom property to the script.
local CUSTOM_MENU = script:GetCustomProperty("MenuPanel"):WaitForObject()
-- "ExitButton" is a UI Button within that panel. Also assigned as a custom property.
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

Example using:

### `inputTypeChangedEvent`

In this example, the UI will update to show what input type the player is currently using, and will update the UI when the player changes the input type.

```lua
-- Client script.

-- UI image for mouse input.
local MOUSE_IMAGE = script:GetCustomProperty("MouseImage"):WaitForObject()

-- UI image for controller input.
local CONTROLLER_IMAGE = script:GetCustomProperty("ControllerImage"):WaitForObject()

-- Fired when the input has changed.
function UpdateInputImage(player, changedInputType)
    -- Check the changed input type by comparing with the
    -- InputType enum.
    if changedInputType == InputType.KEYBOARD_AND_MOUSE then
        MOUSE_IMAGE.visibility = Visibility.FORCE_ON
        CONTROLLER_IMAGE.visibility = Visibility.FORCE_OFF
    elseif changedInputType == InputType.CONTROLLER then
        MOUSE_IMAGE.visibility = Visibility.FORCE_OFF
        CONTROLLER_IMAGE.visibility = Visibility.FORCE_ON
    end
end

Input.inputTypeChangedEvent:Connect(UpdateInputImage)

-- Update the input type image first time
UpdateInputImage(Game.GetLocalPlayer(), Input.GetCurrentInputType())
```

See also: [CoreObject.GetCustomProperty](coreobject.md) | [Game.GetLocalPlayer](game.md) | [CoreObjectReference.WaitForObject](coreobjectreference.md) | [Input.GetCurrentInputType](input.md) | [KEYBOARD_AND_MOUSE](enums.md#keyboard_and_mouse)

---
