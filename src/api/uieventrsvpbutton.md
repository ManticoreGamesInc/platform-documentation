---
id: uieventrsvpbutton
name: UIEventRSVPButton
title: UIEventRSVPButton
tags:
    - API
---

# UIEventRSVPButton

A UIControl for a button which allows players to register for an event within a game. Similar to `UIButton`, but designed to present a consistent experience for players across all games. Inherits from [UIControl](uicontrol.md).

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `isInteractable` | `boolean` | Returns whether the button can interact with the cursor (click, hover, etc). | Read-Write |
| `eventId` | `string` | Returns the ID of the event for which this button is currently configured. This ID can be found in the creator dashboard or using the `CoreGameEvent.id` property of an event returned from various `CorePlatform` functions. | Read-Write |
| `isHittable` | `boolean` | When set to `true`, this control can receive input from the cursor and blocks input to controls behind it. When set to `false`, the cursor ignores this control and can interact with controls behind it. | Read-Write |

## Events

| Event Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `clickedEvent` | [`Event`](event.md)<[`UIEventRSVPButton`](uieventrsvpbutton.md)> | Fired when button is clicked. This triggers on mouse-button up, if both button-down and button-up events happen inside the button hitbox. | None |
| `pressedEvent` | [`Event`](event.md)<[`UIEventRSVPButton`](uieventrsvpbutton.md)> | Fired when button is pressed. (mouse button down) | None |
| `releasedEvent` | [`Event`](event.md)<[`UIEventRSVPButton`](uieventrsvpbutton.md)> | Fired when button is released. (mouse button up) | None |
| `hoveredEvent` | [`Event`](event.md)<[`UIEventRSVPButton`](uieventrsvpbutton.md)> | Fired when button is hovered. | None |
| `unhoveredEvent` | [`Event`](event.md)<[`UIEventRSVPButton`](uieventrsvpbutton.md)> | Fired when button is unhovered. | None |

## Examples

Example using:

### `eventId`

In this example, a client script controls a UI that prompts players to join (RSVP) an upcoming game event. In case the player has already registered for the event, then the UI does not show. The UI is populated with information about the event, such as name and description. Also, the RSVP Button must be given the game event's `id` in order to connect correctly with the platform service. The UI becomes hidden when the RSVP or Close buttons are clicked.

```lua
local GAME_ID = "a3040c7ff0ca4a148d98191c701afe9a"

local UI_ROOT = script:GetCustomProperty("UIContainer"):WaitForObject()
local CLOSE_BUTTON = script:GetCustomProperty("UIButton"):WaitForObject()
local UI_EVENT_NAME = script:GetCustomProperty("UITextBox"):WaitForObject()
local UI_EVENT_DESCRIPTION = script:GetCustomProperty("UITextBox_1"):WaitForObject()
local RSVP_BUTTON = script:GetCustomProperty("UIEventRSVPButton"):WaitForObject()

local player = Game.GetLocalPlayer()

function ShowUI()
    UI_ROOT.visibility = Visibility.INHERIT
end

function HideUI()
    UI_ROOT.visibility = Visibility.FORCE_OFF
end

function UpdateContents(eventData)
    UI_EVENT_NAME.text = eventData.name
    UI_EVENT_DESCRIPTION.text = eventData.description
    RSVP_BUTTON.eventId = eventData.id
end

function EvaluateUpcomingEvent()
    local collection = CorePlatform.GetGameEventsForGame(GAME_ID)
    for i, eventData in ipairs(collection:GetResults()) do
        if eventData.state == CoreGameEventState.SCHEDULED
        and not CorePlatform.IsPlayerRegisteredForGameEvent(player, eventData) then
            UpdateContents(eventData)
            ShowUI()
            return
        end
    end
end

CLOSE_BUTTON.clickedEvent:Connect(HideUI)
RSVP_BUTTON.clickedEvent:Connect(HideUI)

EvaluateUpcomingEvent()
```

See also: [CoreGameEventCollection.GetResults](coregameeventcollection.md) | [CorePlatform.GetGameEventsForGame](coreplatform.md) | [CoreGameEvent.state](coregameevent.md) | [CoreGameEventState](enums.md#coregameeventstate) | [UIButton.clickedEvent](uibutton.md) | [UIText.text](uitext.md) | [CoreObject.GetCustomProperty](coreobject.md)

---

## Tutorials

[UI in Core](../references/ui.md)
