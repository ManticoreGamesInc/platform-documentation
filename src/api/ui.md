---
id: ui
name: UI
title: UI
tags:
    - API
---

# UI

The UI namespace contains a set of class functions allowing you to get information about a Player's display and push information to their HUD. Most functions require the script to be inside a ClientContext and execute for the local Player.

## Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `UI.ShowFlyUpText(string message, Vector3 worldPosition, [table parameters])` | `None` | Shows a quick text on screen that tracks its position relative to a world position. The last parameter is an optional table containing additional parameters: duration (number) - How long the text should remain on the screen. Default duration is 0.5 seconds; color (Color) - The color of the Text. Default is white; font (string) - Asset ID for the font to use; isBig (boolean) - When true, larger text is used. | Client-Only |
| `UI.ShowDamageDirection(Vector3 worldPosition)` | `None` | Local player sees an arrow pointing towards some damage source. Lasts for 5 seconds. | Client-Only |
| `UI.ShowDamageDirection(CoreObject source)` | `None` | Local player sees an arrow pointing towards some CoreObject. Multiple calls with the same CoreObject reuse the same UI indicator, but refreshes its duration. | Client-Only |
| `UI.ShowDamageDirection(Player source)` | `None` | Local player sees an arrow pointing towards some other Player. Multiple calls with the same Player reuse the same UI indicator, but refreshes its duration. The arrow points to where the source was at the moment `ShowDamageDirection` is called and does not track the source Player's movements. | Client-Only |
| `UI.GetCursorPosition()` | [`Vector2`](vector2.md) | Returns a Vector2 with the `x`, `y` coordinates of the mouse cursor on the screen. Only gives results from a client context. May return `nil` if the cursor position cannot be determined. | None |
| `UI.GetScreenPosition(Vector3 worldPosition)` | [`Vector2`](vector2.md) | Calculates the location that worldPosition appears on the screen. Returns a Vector2 with the `x`, `y` coordinates, or `nil` if worldPosition is behind the camera. Only gives results from a client context. | None |
| `UI.GetScreenSize()` | [`Vector2`](vector2.md) | Returns a Vector2 with the size of the Player's screen in the `x`, `y` coordinates. Only gives results from a client context. May return `nil` if the screen size cannot be determined. | None |
| `UI.PrintToScreen(string message, [Color])` | `None` | Draws a message on the corner of the screen. Second optional Color parameter can change the color from the default white. | Client-Only |
| `UI.IsCursorVisible()` | `boolean` | Returns whether the cursor is visible. | Client-Only |
| `UI.SetCursorVisible(boolean isVisible)` | `None` | Sets whether the cursor is visible. | Client-Only |
| `UI.IsCursorLockedToViewport()` | `boolean` | Returns whether to lock cursor in viewport. | Client-Only |
| `UI.SetCursorLockedToViewport(boolean isLocked)` | `None` | Sets whether to lock cursor in viewport. | Client-Only |
| `UI.CanCursorInteractWithUI()` | `boolean` | Returns whether the cursor can interact with UI elements like buttons. | Client-Only |
| `UI.SetCanCursorInteractWithUI(boolean)` | `None` | Sets whether the cursor can interact with UI elements like buttons. | Client-Only |
| `UI.IsReticleVisible()` | `boolean` | Check if reticle is visible. | Client-Only |
| `UI.SetReticleVisible(boolean show)` | `None` | Shows or hides the reticle for the Player. | Client-Only |
| `UI.GetCursorHitResult()` | [`HitResult`](hitresult.md) | Return hit result from local client's view in direction of the Projected cursor position. Meant for client-side use only, for Ability cast, please use `ability:GetTargetData():GetHitPosition()`, which would contain cursor hit position at time of cast, when in top-down camera mode. | Client-Only |
| `UI.GetCursorPlaneIntersection(Vector3 pointOnPlane, [Vector3 planeNormal])` | [`Vector3`](vector3.md) | Return intersection from local client's camera direction to given plane, specified by point on plane and optionally its normal. Meant for client-side use only. Example usage: `local hitPos = UI.GetCursorPlaneIntersection(Vector3.New(0, 0, 0))`. | Client-Only |
| `UI.SetRewardsDialogVisible(boolean isVisible, [RewardsDialogTab currentTab])` | `None` | Sets whether the rewards dialog is visible, and optionally which tab is active. | Client-Only |
| `UI.IsRewardsDialogVisible()` | `boolean` | Returns whether the rewards dialog is currently visible. | Client-Only |
| `UI.SetSocialMenuEnabled(boolean isEnabled)` | `None` | Sets whether the social menu is enabled. | Client-Only |
| `UI.IsSocialMenuEnabled()` | `boolean` | Returns whether the social menu is enabled. | Client-Only |
| `UI.GetCoreModalType()` | [`CoreModalType`](enums.md#coremodaltype) | Returns the currently active core modal, or nil if none is active. | Client-Only |

## Events

| Event Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `UI.coreModalChangedEvent` | <[`CoreModalType`](enums.md#coremodaltype)`>` | Fired when the local player pauses the game or opens one of the built-in modal dialogs, such as the emote or mount picker. The modal parameter will be `nil` when the player has closed all built-in modals. | Client-Only |

## Examples

Example using:

### `GetScreenPosition`

The `GetScreenPosition` method is a powerful function that does a lot of behind the scenes math to convert any 3D point in the game world into a 2D screen coordinate. This script will use the `GetScreenPosition` method to cause a UI Text object to jump to different players and follow each player for 2 second intervals.

Your UI Text object needs to be set to dock in the top-left of the screen for the `GetScreenPosition` method to provide accurate 2D coordinates. Your UI Text object should also be a direct child of a UI Container for the `GetScreenPosition` method to provide accurate 2D coordinates.

```lua
-- Grab the text object
local propUIText = script:GetCustomProperty("UIText"):WaitForObject()

-- Represents how many seconds are left until the UI Text moves to the next player
local timeLeft = 0

-- Determines how long (in seconds) the text hovers above the name of a player
local intervalTime = 2

-- Represents which player the UI Text will is currently hovering over
local playerIndex = 1

-- Stores a list of players in the game
local playerList = Game.GetPlayers()

-- Stores the player object that the UI Text should hover above
local targetPlayer = nil

function Tick(deltaTime)
    -- Update the "playerList" to reflect any changes to the list of players in the game (players leaving the game or entering the game)
    playerList = Game.GetPlayers()

    -- Update the "timeLeft" variable
    timeLeft = timeLeft - deltaTime

    -- If "timeLeft" has reached 0 and there are still players in the game, reset the "timeLeft" variable and move the text to the next player
    if(timeLeft <= 0 and #playerList > 0) then
        -- Reset the "timeLeft" variable to "intervalTime" number of seconds
        timeLeft = intervalTime

        -- Move the "playerIndex" to the next player in the "playerLIst"
        playerIndex = playerIndex + 1

        -- If "playerIndex" is larger than the length of "playerList", reset "playerIndex" to the beginning of "playerList"
        if(playerIndex > #playerList) then
            playerIndex = 1
        end

        -- Update the "targetPlayer" variable with the player object located at "playerIndex" position on the "playerList"
        targetPlayer = playerList[playerIndex]
    end

    -- If "targetPlayer" refers to an actual player, update the position of the UI Text to
    -- be above that player's head
    if(Object.IsValid(targetPlayer)) then
        -- Get the position of the player's head by vertically offseting the position of the player
        local playerHeadPos = targetPlayer:GetWorldPosition() + Vector3.New(0, 0, 120)

        -- Convert the position of the player's head to 2D coordinates
        local playerHeadScreenPos = UI.GetScreenPosition(playerHeadPos)

        -- Change the text of the UI Text to display the name of the "targetPlayer"
        propUIText.text = targetPlayer.name

        -- Move the UI Text to the "playerHeadScreenPos" position
        propUIText.x = playerHeadScreenPos.x
        propUIText.y = playerHeadScreenPos.y
    end
end
```

See also: [Game.GetPlayers](game.md) | [Player.GetWorldPosition](player.md) | [UIText.textObject.IsValid](uitext.md) | [CoreObject.GetCustomProperty](coreobject.md)

---

Example using:

### `SetRewardsDialogVisible`

### `IsRewardsDialogVisible`

This example shows the basic usage of the reward points UI. It's possible to show the rewards dialog, in either the Quest or Game tabs, by calling `UI.SetRewardsDialogVisible()`. With the function `UI.IsRewardsDialogVisible()` we can detect when the player closes the dialog.

```lua
local PLAYER = Game.GetLocalPlayer()

local isDialogOpen = false

function Tick()
    if isDialogOpen and not UI.IsRewardsDialogVisible() then
        isDialogOpen = false
        print("Player closed the Reward Points dialog.")
    end
end

function OnBindingPressed(player, action)
    if action == "ability_extra_1" then
        UI.SetRewardsDialogVisible(true, RewardsDialogTab.REWARD_POINT_GAMES)

    elseif action == "ability_extra_2" then
        UI.SetRewardsDialogVisible(true, RewardsDialogTab.QUESTS)
    end
end

PLAYER.bindingPressedEvent:Connect(OnBindingPressed)
```

See also: [RewardsDialogTab](enums.md#rewardsdialogtab) | [Game.GetLocalPlayer](game.md) | [Player.bindingPressedEvent](player.md)

---

Example using:

### `coreModalChangedEvent`

This client script listens for changes in the local player's modal and prints to the Event Log information about which modal was opened, or if modals were closed.

```lua
-- Converts the enum CoreModalType into a string, to make the log more readable
function ToStringModaltype(modalType)
    -- The pause menu opened by pressing the Escape key, or other minor pause states
    if modalType == CoreModalType.PAUSE_MENU then return "PAUSE" end

    -- Popup when the player is choosing a character
    if modalType == CoreModalType.CHARACTER_PICKER then return "CHARACTER PICKER" end

    -- Popup when the player is choosing a mount
    if modalType == CoreModalType.MOUNT_PICKER then return "MOUNT PICKER" end

    -- Popup when the player is choosing an emote
    if modalType == CoreModalType.EMOTE_PICKER then return "EMOTE PICKER" end

    -- Popup when the player is inspecting another player for social actions
    if modalType == CoreModalType.SOCIAL_MENU then return "SOCIAL MENU" end

    -- Fallback, future-proof
    return "???" .. tostring(modalType)
end

function OnModalChanged(modalType)
    if modalType ~= nil then
        print("Modal changed to: " .. ToStringModaltype(modalType))
    else
        print("Closed modal.")
    end
end
UI.coreModalChangedEvent:Connect(OnModalChanged)
```

See also: [CoreModalType](enums.md#coremodaltype)

---

## Tutorials

[UI in Core](../references/ui.md)
