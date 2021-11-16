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
| `UI.coreModalChangedEvent` | [`Event`](event.md)<[`CoreModalType`](enums.md#coremodaltype)> | Fired when the local player pauses the game or opens one of the built-in modal dialogs, such as the emote or mount picker. The modal parameter will be `nil` when the player has closed all built-in modals. | Client-Only |

## Examples

Example using:

### `GetCoreModalType`

Modals are temporary dialogs that popup, usually in the middle of the screen. They take over the input focus and give the player some options. Core has several built-in modals identified by the `CoreModalType`. In this example, we keep track of the current modal and print to the Event Log whenever there is a change to the active modal.

```lua
local lastModalType = nil

function Tick()
    local newType = UI.GetCoreModalType()
    if lastModalType ~= newType then
        lastModalType = newType
        if newType then
            print("New modal active: "..ModalTypeToString(newType))
        else
            print("Modal closed.")
        end
    end
end

function ModalTypeToString(modalType)
    if modalType == CoreModalType.PAUSE_MENU then return "Pause Menu" end
    if modalType == CoreModalType.CHARACTER_PICKER then return "Character Picker" end
    if modalType == CoreModalType.MOUNT_PICKER then return "Mount Picker" end
    if modalType == CoreModalType.EMOTE_PICKER then return "Emote Picker" end
    if modalType == CoreModalType.SOCIAL_MENU then return "Social Menu" end
    return "Unknown Modal" -- Future-proof fallback
end
```

See also: [CoreModalType.PAUSE_MENU](coremodaltype.md)

---

Example using:

### `GetCursorHitResult`

### `SetCursorLockedToViewport`

### `SetCursorVisible`

In this example, a client script detects 3D objects being clicked on by using the function `UI.GetCursorHitResult()`. Sometimes nothing is clicked on, such as pointing into the sky. Results are print into the Event Log.

```lua
UI.SetCursorLockedToViewport(true)
UI.SetCursorVisible(true)

function OnBindingPressed(player, action)
    if action == "ability_primary" then
        local hit = UI.GetCursorHitResult()
        if hit and hit.other then
            print("Clicked on: "..hit.other.name)
        else
            print("Nothing was clicked on.")
        end
        UI.SetCursorVisible(false)
        Task.Wait(0.2)
        UI.SetCursorVisible(true)
    end
end

Game.GetLocalPlayer().bindingPressedEvent:Connect(OnBindingPressed)
```

See also: [HitResult.other](hitresult.md) | [Player.bindingPressedEvent](player.md) | [Game.GetLocalPlayer](game.md) | [Task.Wait](task.md)

---

Example using:

### `GetCursorPlaneIntersection`

### `SetCursorVisible`

Core packs several complex math operations that are really useful for gameplay scripts. In this example, we use the `UI.GetCursorPlaneIntersection()` to figure out which player is closest to the mouse cursor. The question of "who is closest to the cursor" is highly relative, as the cursor is in fact a 2D object, while the players are in 3D. To solve this, we can imagine the mouse cursor, instead of a 2D element, as being an infinite 3D line, starting at the camera and going directly forward. Therefore, we use `UI.GetCursorPlaneIntersection()` to create an imaginary 3D plane that is parallel to the camera. If the plane is placed on each player, an intersection of that plane and the cursor's 3D line occurs. This is similar to projecting the players onto the line and seeing who is closest to the line, based on their projected points. The example concludes by drawing a debug circle on the selected player.

```lua
local LOCAL_PLAYER = Game.GetLocalPlayer()

local viewForward = nil
local smallestDistSqr = nil
local targetPlayer = nil
local targetProjection = nil

UI.SetCursorVisible(true)

function Tick()
    Reset()
    for _,player in ipairs(Game.GetPlayers()) do
        if player ~= LOCAL_PLAYER then
            TestPlayer(player)
        end
    end
    DrawDebug()
end

function Reset()
    local viewRot = LOCAL_PLAYER:GetViewWorldRotation()
    viewForward = Quaternion.New(viewRot):GetForwardVector()
    
    targetPlayer = nil
end

function TestPlayer(player)
    local point = player:GetWorldPosition()
    
    local projection = UI.GetCursorPlaneIntersection(point, viewForward)
    if not projection then return end
    
    local distSqr = (point - projection).sizeSquared
    
    if targetPlayer == nil 
    or distSqr < smallestDistSqr then
        smallestDistSqr = distSqr
        targetPlayer = player
        targetProjection = projection
    end
end

function DrawDebug()
    if targetPlayer then
        local playerPos = targetPlayer:GetWorldPosition()
        local params = {thickness = 3, color = Color.RED}
        CoreDebug.DrawSphere(playerPos, 50, params)
        CoreDebug.DrawLine(playerPos, targetProjection, params)
    end
end
```

See also: [Player.GetViewWorldRotation](player.md) | [Vector3.sizeSquared](vector3.md) | [Quaternion.GetForwardVector](quaternion.md) | [CoreDebug.DrawSphere](coredebug.md) | [Game.GetPlayers](game.md)

---

Example using:

### `GetCursorPosition`

In this client script we listen for the player's primary action (e.g. Left mouse click) then print the position of their cursor to the event log.

```lua
function OnBindingPressed(player, action)
    if action == "ability_primary" then
        local cursorPos = UI.GetCursorPosition()
        if cursorPos then
            print("Clicked at: " .. cursorPos.x .. ", " .. cursorPos.y)
        else
            print("Clicked at an undefined position.")
        end
    end
end

local player = Game.GetLocalPlayer()
player.bindingPressedEvent:Connect(OnBindingPressed)
```

See also: [Game.GetLocalPlayer](game.md) | [Player.bindingPressedEvent](player.md) | [Vector2.x](vector2.md)

---

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

### `GetScreenSize`

Players will be using devices with wildly varied screen resolutions. Checking their resolution can be useful when polishing the game. For example, if they have a very wide screen, HUD elements in the corners will not deliver the same experience as someone with a more conventional 16:9 resolution. You can simulate different resolutions and screen ratios by changing the size of the main editor view, even while preview is running.

```lua
local screenSize = UI.GetScreenSize()
local width = CoreMath.Round(screenSize.x)
local height = CoreMath.Round(screenSize.y)
print("The player's screen size is: "..width.."x"..height)
```

See also: [CoreMath.Round](coremath.md) | [Vector2.x](vector2.md)

---

Example using:

### `IsCursorLockedToViewport`

### `PrintToScreen`

Often times it's worth doing simple tests, to better understand how Core operates. In this client script we are checking if the cursor begins locked or not. May be worth testing in different situations, such as single-player preview and multiplayer, to see if that gives different results.

```lua
Task.Wait(1)
if UI.IsCursorLockedToViewport() then
    UI.PrintToScreen("Core begins with the cursor locked")
else
    UI.PrintToScreen("In Core, the cursor does not begin locked")
end
```

See also: [Task.Wait](task.md)

---

Example using:

### `IsCursorVisible`

### `SetCursorVisible`

### `CanCursorInteractWithUI`

### `SetCanCursorInteractWithUI`

There is a common problem in games that want to enable/disable the cursor when a UI screen appears/disappears. Sometimes, you can have multiple screens appear simultaneously. Scripts on both screens are competing to show/hide the same cursor and you can end up with the cursor hidden while one of the screens is still visible. In such a case, the game can even go into a bad state where the player is stuck. This problem can be solved by having a central service that handles showing/hiding the cursor. It keeps count of multiple requests and only hides once the count goes back to zero. Other scripts will call `_G.CursorUtils.ShowCursor()` and `_G.CursorUtils.HideCursor()`.

```lua
local API = {}
_G.CursorUtils = API

local usageCount = 0

function API.ShowCursor()
    if UI.CanCursorInteractWithUI()
    or UI.IsCursorVisible() then
        usageCount = usageCount + 1
    else
        usageCount = 1
    end
    UI.SetCanCursorInteractWithUI(true)
    UI.SetCursorVisible(true)
end

function API.HideCursor()
    usageCount = usageCount - 1
    if usageCount <= 0 then
        UI.SetCanCursorInteractWithUI(false)
        UI.SetCursorVisible(false)
    end
end
```

---

Example using:

### `IsReticleVisible`

### `SetReticleVisible`

In this example, a client script toggles the default reticle on/off each time the left mouse button is clicked (or whatever is configured for the primary ability).

```lua
function OnBindingPressed(player, action)
    if action == "ability_primary" then
        if UI.IsReticleVisible() then
            UI.SetReticleVisible(false)
        else
            UI.SetReticleVisible(true)
        end
    end
end
Game.GetLocalPlayer().bindingPressedEvent:Connect(OnBindingPressed)
```

See also: [Player.bindingPressedEvent](player.md) | [Game.GetLocalPlayer](game.md) | [Event.Connect](event.md)

---

Example using:

### `PrintToScreen`

The `UI.PrintToScreen()` function can be really useful for debugging. Messages printed to the screen in this way last for a few seconds, then disappear.

```lua
UI.PrintToScreen("Hello World!")
UI.PrintToScreen("And now, red", Color.RED)
```

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

### `SetSocialMenuEnabled`

### `IsSocialMenuEnabled`

In this example, there is a designated area where the social menu becomes available to use. The area is defined by a trigger. Additionally, a UI element in the HUD turns on/off when the player is inside the area, to indicate that social interactions are available. When a trigger is inside a client-context, make sure collision on the context is enabled, otherwise the trigger will do nothing.

```lua
local TRIGGER = script:GetCustomProperty("SocialZone"):WaitForObject()
local UI_PANEL = script:GetCustomProperty("HUDSocialIndicator"):WaitForObject()
local PLAYER = Game.GetLocalPlayer()

function Tick()
    if UI.IsSocialMenuEnabled() then
        UI_PANEL.visibility = Visibility.INHERIT
    else
        UI_PANEL.visibility = Visibility.FORCE_OFF
    end
    Task.Wait(1)
end

TRIGGER.beginOverlapEvent:Connect(function(trigger, other)
    if other == PLAYER then
        UI.SetSocialMenuEnabled(true)
    end
end)

TRIGGER.endOverlapEvent:Connect(function(trigger, other)
    if other == PLAYER then
        UI.SetSocialMenuEnabled(false)
    end
end)
```

See also: [CoreObject.visibility](coreobject.md) | [Trigger.beginOverlapEvent](trigger.md) | [Game.GetLocalPlayer](game.md) | [Task.Wait](task.md) | [CoreObjectReference.WaitForObject](coreobjectreference.md)

---

Example using:

### `ShowDamageDirection`

In this example, the damage direction indicator is shown to a player when they take damage, but only if the source of that damage is another player. The script is broken into 2 parts, where the first one goes into a server script and the second one into a client script.

```lua
-- Server script:
function OnDamaged(player, dmg)
    local amount = dmg.amount
    local position = nil
    if dmg.sourcePlayer then
        position = dmg.sourcePlayer:GetWorldPosition()
    end
    Events.BroadcastToPlayer(player, "TookDamage", amount, position)
end

Game.playerJoinedEvent:Connect(function(player)
    player.damagedEvent:Connect(OnDamaged)
end)

-- Client script:
function OnDamaged(amount, position)
    if position then
        UI.ShowDamageDirection(position)
    end
end

Events.Connect("TookDamage", OnDamaged)
```

See also: [Damage.sourcePlayer](damage.md) | [Events.BroadcastToPlayer](events.md)

---

Example using:

### `ShowFlyUpText`

In this example, RP points can be granted to a player by calling the function GiveRewardPoints(player, amount). Additionally, a fly-up text appears and stays on screen for a bit, displaying the amount of RP that was gained. The script is broken into 2 parts, where the first one goes into a server script and the second one into a client script.

```lua
-- Server script:
function GiveRewardPoints(player, amount)
    player:GrantRewardPoints(amount, "MyRP")
    
    Events.BroadcastToPlayer(player, "ShowRPGain", amount)
end

-- Client script:
local RP_COLOR = Color.New(0.18, 0.09, 0.36)

function OnShowRPGain(amount)
    local message = "+"..amount.." RP"
    local pos = Game.GetLocalPlayer():GetWorldPosition() + Vector3.UP * 100
    local params = {color = RP_COLOR, isBig = true}
    UI.ShowFlyUpText(message, pos, params)
end
Events.Connect("ShowRPGain", OnShowRPGain)
```

See also: [Player.GrantRewardPoints](player.md) | [Events.BroadcastToPlayer](events.md) | [Game.GetLocalPlayer](game.md) | [Vector3.UP](vector3.md)

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
