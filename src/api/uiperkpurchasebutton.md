---
id: uiperkpurchasebutton
name: UIPerkPurchaseButton
title: UIPerkPurchaseButton
tags:
    - API
    - UI
---

# UIPerkPurchaseButton

A UIControl for a button which allows players to purchase perks within a game. Similar to `UIButton`, but designed to present a consistent purchasing experience for players across all games. Inherits from [UIControl](uicontrol.md).

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `isInteractable` | `boolean` | Returns whether the button can interact with the cursor (click, hover, etc). | Read-Write |
| `isHittable` | `boolean` | When set to `true`, this control can receive input from the cursor and blocks input to controls behind it. When set to `false`, the cursor ignores this control and can interact with controls behind it. | Read-Write |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetPerkReference()` | [`NetReference`](netreference.md) | Returns a reference to the perk for which this button is currently configured. If no perk has been set, returns an unassigned NetReference. (See the `.isAssigned` property on `NetReference`.) | None |
| `SetPerkReference(NetReference)` | `None` | Configures this button to use the specified perk. | None |
| `GetCurrentTouchIndex()` | `integer` | Returns the touch index currently interacting with this button. Returns `nil` if the button is not currently being interacted with. | Client-Only |

## Events

| Event Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `clickedEvent` | [`Event`](event.md)<[`UIPerkPurchaseButton`](uiperkpurchasebutton.md)> | Fired when button is clicked. This triggers on mouse-button up, if both button-down and button-up events happen inside the button hitbox. | None |
| `pressedEvent` | [`Event`](event.md)<[`UIPerkPurchaseButton`](uiperkpurchasebutton.md)> | Fired when button is pressed. (mouse button down) | None |
| `releasedEvent` | [`Event`](event.md)<[`UIPerkPurchaseButton`](uiperkpurchasebutton.md)> | Fired when button is released. (mouse button up) | None |
| `hoveredEvent` | [`Event`](event.md)<[`UIPerkPurchaseButton`](uiperkpurchasebutton.md)> | Fired when button is hovered. | None |
| `unhoveredEvent` | [`Event`](event.md)<[`UIPerkPurchaseButton`](uiperkpurchasebutton.md)> | Fired when button is unhovered. | None |
| `touchStartedEvent` | [`Event`](event.md)<[`UIPerkPurchaseButton`](uiperkpurchasebutton.md), [`Vector2`](vector2.md) location, `integer` touchIndex> | Fired when the player starts touching the control on a touch input device. Parameters are the screen location of the touch and a touch index used to distinguish between separate touches on a multitouch device. | Client-Only |
| `touchStoppedEvent` | [`Event`](event.md)<[`UIPerkPurchaseButton`](uiperkpurchasebutton.md), [`Vector2`](vector2.md) location, `integer` touchIndex> | Fired when the player stops touching the control on a touch input device. Parameters are the screen location from which the touch was released and a touch index used to distinguish between separate touches on a multitouch device. | Client-Only |
| `tappedEvent` | [`Event`](event.md)<[`UIPerkPurchaseButton`](uiperkpurchasebutton.md), [`Vector2`](vector2.md) location, `integer` touchIndex> | Fired when the player taps the control on a touch input device. Parameters are the screen location of the tap and the touch index with which the tap was performed. | Client-Only |
| `flickedEvent` | [`Event`](event.md)<[`UIPerkPurchaseButton`](uiperkpurchasebutton.md), `number` angle> | Fired when the player performs a quick flicking gesture on the control on a touch input device. The `angle` parameter indicates the direction of the flick. 0 indicates a flick to the right. Values increase in degrees counter-clockwise, so 90 indicates a flick straight up, 180 indicates a flick to the left, etc. | Client-Only |
| `pinchStartedEvent` | [`Event`](event.md)<[`UIPerkPurchaseButton`](uiperkpurchasebutton.md)> | Fired when the player begins a pinching gesture on the control on a touch input device. `Input.GetPinchValue()` may be polled during the pinch gesture to determine how far the player has pinched. | Client-Only |
| `pinchStoppedEvent` | [`Event`](event.md)<[`UIPerkPurchaseButton`](uiperkpurchasebutton.md)> | Fired when the player ends a pinching gesture on a touch input device. | Client-Only |
| `rotateStartedEvent` | [`Event`](event.md)<[`UIPerkPurchaseButton`](uiperkpurchasebutton.md)> | Fired when the player begins a rotating gesture on the control on a touch input device. `Input.GetRotateValue()` may be polled during the rotate gesture to determine how far the player has rotated. | Client-Only |
| `rotateStoppedEvent` | [`Event`](event.md)<[`UIPerkPurchaseButton`](uiperkpurchasebutton.md)> | Fired when the player ends a rotating gesture on a touch input device. | Client-Only |

## Examples

Example using:

In this example a player can click on a UI Perk Purchase Button (Client UI with Perk Net Reference), and will be given a certain amount of gems. These gems will be added to the player's resource, and also save in player storage so that the total gems persist between game sessions.

The UI Perk Button doesn't need any client side Lua logic when a player clicks the button because Core handles this for you.

```lua
-- Server script. Player storage enabled.
-- The perk reference (repeatable).
local GEMS_PERK = script:GetCustomProperty("Gems")

-- Total gems to give per purchase.
local TOTAL_GEMS = script:GetCustomProperty("TotalGems") or 1

-- Check if a perk is assigned.
if not GEMS_PERK.isAssigned then
    warn("No perk reference assigned")
end

-- Will be called when a perk is purchased by the player.
local function PerkChanged(player, perk)
    print(string.format("%s purchased %s perk", player.name, perk))

    -- Check that the perk that was purchased matches
    -- the GEMS_PERK reference so you can give gems.
    if perk == GEMS_PERK then
        player:AddResource("Gems", TOTAL_GEMS)

        -- Fetch the players existing data.
        local playerData = Storage.GetPlayerData(player)

        -- Update the gems amount in the player data.
        playerData.gems = player:GetResource("Gems")

        -- Set the players storage data with the updated data.
        Storage.SetPlayerData(player, playerData)
    end
end

-- For debugging to see if the gems resource updated.
-- This would usually be in a client script that would update
-- the player's UI with their updated Gem amount.
local function PlayerResourceChanged(player, resource, newAmount)
    if resource == "Gems" then
        print(string.format("%s gems: %s", player.name, newAmount))
    end
end

-- Set the perkChangedEvent for the player when the join
-- the game.
local function OnPlayerJoined(player)
    player.perkChangedEvent:Connect(PerkChanged)

    local playerData = Storage.GetPlayerData(player)

    -- Set the players resource with the gems in storage.
    player:SetResource("Gems", playerData.gems or 0)

    -- This would usually be in a client script to update
    -- the UI for the player to show their resources when
    -- the amount changes.
    player.resourceChangedEvent:Connect(PlayerResourceChanged)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

See also: [Player.HasPerk](player.md) | [NetReference.isAssigned](netreference.md) | [Game.playerJoinedEvent](game.md) | [CoreObject.GetCustomProperty](coreobject.md) | [Storage.SetPlayerData](storage.md) | [CoreLua.print](coreluafunctions.md)

---

Example using:

### `GetTouchPosition`

### `GetPinchValue`

### `GetRotateValue`

### `pinchStartedEvent`

### `pinchStoppedEvent`

### `rotateStartedEvent`

### `rotateStoppedEvent`

In this example we manipulate a UI object with a multi-touch pinching gesture. The pinch gesture is used to move, scale and rotate a the UI Text on screen.

```lua
-- Client Script as a child of the UI object.
local UI_OBJECT = script.parent

-- Make the UI Control hittable
UI_OBJECT.isHittable = true

local isPinching = false
local isRotating = false
local startingWidth
local startingHeight
local startingAngle

function Tick()
    -- Position
    local touch1 = Input.GetTouchPosition(1)
    local touch2 = Input.GetTouchPosition(2)

    if touch1 ~= nil and touch2 ~= nil then
        local position = (touch1 + touch2) / 2

        UI_OBJECT:SetAbsolutePosition(position)
    end

    -- Scale
    if isPinching then
        local pinchPercent = Input.GetPinchValue()

        UI_OBJECT.width = CoreMath.Round(startingWidth * pinchPercent)
        UI_OBJECT.height = CoreMath.Round(startingHeight * pinchPercent)
    end

    -- Rotate
    if isRotating then
        local angle = Input.GetRotateValue()

        UI_OBJECT.rotationAngle = startingAngle + angle
    end
end

local function OnPinchStarted()
    isPinching = true
    startingWidth = UI_OBJECT.width
    startingHeight = UI_OBJECT.height
end

local function OnPinchStopped()
    isPinching = false
end

-- Detect pinch gesture start/end
UI_OBJECT.pinchStartedEvent:Connect(OnPinchStarted)
UI_OBJECT.pinchStoppedEvent:Connect(OnPinchStopped)

local function OnRotateStarted()
    isRotating = true
    startingAngle = UI_OBJECT.rotationAngle
end

local function OnRotateStopped()
    isRotating = false
end

-- Detect rotation gesture start/end
UI_OBJECT.rotateStartedEvent:Connect(OnRotateStarted)
UI_OBJECT.rotateStoppedEvent:Connect(OnRotateStopped)
```

See also: [UIControl.SetAbsolutePosition](uicontrol.md) | [UIPerkPurchaseButton.isHittable](uiperkpurchasebutton.md) | [CoreObject.parent](coreobject.md) | [CoreMath.Round](coremath.md)

---

Example using:

### `tappedEvent`

### `flickedEvent`

In this example we listen for the tapped and flicked touch gestures on the UI object. When one of those events is triggered, the pertinent information is printed to the screen.

```lua
-- Client Script as a child of the UI object.
local UI_OBJECT = script.parent

-- Make the UI Control hittable
UI_OBJECT.isHittable = true

function OnTappedEvent(control, location, touchIndex)
    UI.PrintToScreen("Tap ".. touchIndex ..": ".. tostring(location))
end

function OnFlickedEvent(control, angle)
    UI.PrintToScreen("Flick: " .. angle)
end

UI_OBJECT.tappedEvent:Connect(OnTappedEvent)
UI_OBJECT.flickedEvent:Connect(OnFlickedEvent)
```

See also: [UI.PrintToScreen](ui.md) | [Event.Connect](event.md) | [UIPerkPurchaseButton.isHittable](uiperkpurchasebutton.md)

---

Example using:

### `touchStartedEvent`

### `touchStoppedEvent`

In this example, the touch inputs on the UI object are tracked in two different ways, with a counter and with a table. Each time the amount of touches change a summary of the touch information is printed to screen.

```lua
-- Client Script as a child of the UI object.
local UI_OBJECT = script.parent

-- Make the UI Control hittable
UI_OBJECT.isHittable = true

local touchCount = 0
local activeTouches = {}

function PrintTouchInfo()
    local str = touchCount .. ": ["
    local addComma = false

    for id,_ in pairs(activeTouches) do
        if addComma then
            str = str .. ", "
        end

        addComma = true
        str = str .. id
    end

    str = str .. "]"

    UI.PrintToScreen(str)
end

local function OnTouchStarted(control, location, touchId)
    touchCount = touchCount + 1
    activeTouches[touchId] = true

    PrintTouchInfo()
end

local function OnTouchStopped(control, location, touchId)
    touchCount = touchCount - 1
    activeTouches[touchId] = nil

    PrintTouchInfo()
end

UI_OBJECT.touchStartedEvent:Connect(OnTouchStarted)
UI_OBJECT.touchStoppedEvent:Connect(OnTouchStopped)
```

See also: [UI.PrintToScreen](ui.md) | [Event.Connect](event.md) | [UIPerkPurchaseButton.isHittable](uiperkpurchasebutton.md)

---

Example using:

### `GetPerkReference`

### `SetPerkReference`

Perks are a system to create in-game purchases that allow players to support game creators and enable exclusive content.

Learn more about Perks [here](https://docs.coregames.com/references/perks/program/).

In the following example, a script is a child of a Perk Purchase Button, of type `UIPerkPurchaseButton`. The user interface container that has the button is in a client context. The specifics of the Perk come in through the custom property `MyPerk`, which is then assigned to the button with `SetPerkReference()`. When the player joins we connect to the `perkChangedEvent` and print out their existing perks with the LogPerks() function.

```lua
-- Perk Net Reference custom parameters
local MY_PERK = script:GetCustomProperty("MyPerk")
local TEST_LIMITED_TIME = script:GetCustomProperty("TestLimitedTime")
local TEST_PERMANENT = script:GetCustomProperty("TestPermanent")
local TEST_REPEATABLE = script:GetCustomProperty("TestRepeatable")

-- Mapping of PerkNetRefs to table of properties, in this case a name
local perkList = {}
perkList[TEST_LIMITED_TIME] = { name = "limited-time" }
perkList[TEST_PERMANENT] = { name = "permanent" }
perkList[TEST_REPEATABLE] = { name = "repeatable" }

-- Set purchase button's Perk to given custom property
script.parent:SetPerkReference(MY_PERK)

function DebugLog(msg)
    print(msg)
    UI.PrintToScreen(msg)
end

function OnPerkChanged(player, perkRef)
    DebugLog("on perks changed " .. player.name)

    if (perkList[perkRef] ~= nil) then
        DebugLog("perk changed: " .. perkList[perkRef].name)
    end

    LogPerks(player)
end

function LogPerks(player)
    -- Example of HasPerk() and GetPerkCount().
    -- For non-repeatable perks checking GetPerkCount() > 0
    -- is equivalent to HasPerk() == true
    for perkRef, prop in pairs(perkList) do
        DebugLog("-- perk: " .. prop.name)

        local hasPerkMsg = "    has perk?: " .. tostring(player:HasPerk(perkRef))
        local perkCountMsg = "    count: " .. tostring(player:GetPerkCount(perkRef))

        DebugLog(hasPerkMsg)
        DebugLog(perkCountMsg)

        -- Example of getting Perk reference of parent Perk button
        local parentPerkRef = script.parent:GetPerkReference()
        if (parentPerkRef.isAssigned and perkRef == parentPerkRef) then
            DebugLog("is parent perk ref")
        end
    end
end

function OnPlayerJoined(player)
    -- Connect perkChangedEvent
    player.perkChangedEvent:Connect(OnPerkChanged)

    -- Log perks player has initially on join
    LogPerks(player)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

See also: [Player.HasPerk](player.md) | [NetReference.isAssigned](netreference.md) | [Game.playerJoinedEvent](game.md) | [CoreObject.GetCustomProperty](coreobject.md) | [CoreLua.print](coreluafunctions.md) | [UI.PrintToScreen](ui.md) | [Event.Connect](event.md)

---

## Tutorials

[UI in Core](../references/ui.md) | [Implementing Perks](../references/perks/implementing.md)
