---
id: uiperkpurchasebutton
name: UIPerkPurchaseButton
title: UIPerkPurchaseButton
tags:
    - API
---

# UIPerkPurchaseButton

A UIControl for a button which allows players to purchase perks within a game. Similar to `UIButton`, but designed to present a consistent purchasing experience for players across all games. Inherits from [UIControl](uicontrol.md).

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `isInteractable` | `boolean` | Returns whether the button can interact with the cursor (click, hover, etc). | Read-Write |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetPerkReference()` | [`NetReference`](netreference.md) | Returns a reference to the perk for which this button is currently configured. If no perk has been set, returns an unassigned NetReference. (See the `.isAssigned` property on `NetReference`.) | None |
| `SetPerkReference(NetReference)` | `None` | Configures this button to use the specified perk. | None |

## Events

| Event Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `clickedEvent` | [`Event`](event.md)<[`UIPerkPurchaseButton`](uiperkpurchasebutton.md)> | Fired when button is clicked. This triggers on mouse-button up, if both button-down and button-up events happen inside the button hitbox. | None |
| `pressedEvent` | [`Event`](event.md)<[`UIPerkPurchaseButton`](uiperkpurchasebutton.md)> | Fired when button is pressed. (mouse button down) | None |
| `releasedEvent` | [`Event`](event.md)<[`UIPerkPurchaseButton`](uiperkpurchasebutton.md)> | Fired when button is released. (mouse button up) | None |
| `hoveredEvent` | [`Event`](event.md)<[`UIPerkPurchaseButton`](uiperkpurchasebutton.md)> | Fired when button is hovered. | None |
| `unhoveredEvent` | [`Event`](event.md)<[`UIPerkPurchaseButton`](uiperkpurchasebutton.md)> | Fired when button is unhovered. | None |

## Examples

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
