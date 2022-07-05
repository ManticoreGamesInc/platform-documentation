---
id: coregameevent
name: CoreGameEvent
title: CoreGameEvent
tags:
    - API
---

# CoreGameEvent

Metadata about a creator-defined event for a game on the Core platform.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `id` | `string` | The ID of the event. | Read-Only |
| `gameId` | `string` | The ID of the game this event belongs to. | Read-Only |
| `name` | `string` | The display name of the event. | Read-Only |
| `referenceName` | `string` | The reference name of the event. | Read-Only |
| `description` | `string` | The description of the event. | Read-Only |
| `state` | [`CoreGameEventState`](enums.md#coregameeventstate) | The current state of the event (active, scheduled, etc). | Read-Only |
| `registeredPlayerCount` | `integer` | The number of players currently registered for this event. | Read-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetTags()` | `Array`<`string`> | Returns a list of the tags selected when this event was published. | None |
| `GetStartDateTime()` | `CoreDateTime` | Returns the start date and time of the event. | None |
| `GetEndDateTime()` | `CoreDateTime` | Returns the end date and time of the event. | None |

## Examples

Example using:

### `id`

### `name`

### `description`

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

See also: [UIEventRSVPButton.eventId](uieventrsvpbutton.md) | [CoreGameEventCollection.GetResults](coregameeventcollection.md) | [CorePlatform.GetGameEventsForGame](coreplatform.md) | [CoreGameEventState](enums.md#coregameeventstate) | [UIButton.clickedEvent](uibutton.md) | [UIText.text](uitext.md) | [CoreObject.GetCustomProperty](coreobject.md)

---

Example using:

### `referenceName`

### `state`

In this example, an event is setup with the Reference Name `double_xp`. Whenever a player gains XP, we check for active events to see if one matches the Reference Name we are looking for and add extra XP. By using this approach, additional events can be setup in the future with the same Reference Name, without the need for any code changes.

```lua
local GAME_ID = "a3040c7ff0ca4a148d98191c701afe9a"

local function IsEventActive(refName)
    local collection = CorePlatform.GetGameEventsForGame(GAME_ID)
    for i, eventData in ipairs(collection:GetResults()) do
        if eventData.state == CoreGameEventState.ACTIVE
        and eventData.referenceName == refName then
            return true
        end
    end
    return false
end

local function IsDoubleXPActive()
    return IsEventActive("double_xp")
end

local function OnResourceChanged(player, resourceName, newValue)
    if resourceName == "xp" then
        if not locked and player.serverUserData.lastXP ~= nil and IsDoubleXPActive() then
            local delta = newValue - player.serverUserData.lastXP
            if delta > 0 then
                locked = true -- Lock the logic, so it doesn't go into a loop
                player:AddResource(resourceName, delta) -- Double the amount by adding it again
                locked = false -- Release the lock
            end
        end
        player.serverUserData.lastXP = player:GetResource(resourceName)
    end
end

local function ConnectReourceChanged(player)
    player.resourceChangedEvent:Connect(OnResourceChanged)
end

Game.playerJoinedEvent:Connect(ConnectReourceChanged)
```

See also: [CorePlatform.GetGameEventsForGame](coreplatform.md) | [CoreGameEventCollection.GetResults](coregameeventcollection.md) | [CoreGameEventState](enums.md#coregameeventstate) | [Player.AddResource](player.md) | [Game.playerJoinedEvent](game.md)

---

Example using:

### `state`

### `registeredPlayerCount`

### `GetEndDateTime`

### `GetStartDateTime`

### `GetTags`

In this example we look at all the events for a given game. The status of each one is printed to the Event Log. Events can be Active or Scheduled, in which case they have a remaining time or upcoming time, respectively. Events can also be in a "Canceled" state, but we ignore those. The advantages of using countdowns to express the end of an event (or wait for an upcoming one) are to build anticipation in the eyes of players, but also to avoid any complications with time zones for players around the world.

```lua
local GAME_ID = "a3040c7ff0ca4a148d98191c701afe9a"

function PrintTags(eventData)
    local tags = ""
    for _, tag in pairs(eventData:GetTags()) do
        tags = tags .. tag .. ","
    end
    print("  Tags = " .. tags)
end

local collection = CorePlatform.GetGameEventsForGame(GAME_ID)
local gameEvents = collection:GetResults()
for i, eventData in ipairs(gameEvents) do
    if eventData.state == CoreGameEventState.ACTIVE then
        local eventEnd = eventData:GetEndDateTime()
        local time = eventEnd.secondsSinceEpoch - DateTime.CurrentTime().secondsSinceEpoch
        print(eventData.name.." is active. Ends in "..time.." seconds")
        print("  Registered players: " .. eventData.registeredPlayerCount)
        PrintTags(eventData)

    elseif eventData.state == CoreGameEventState.SCHEDULED then
        local eventStart = eventData:GetStartDateTime()
        local time = eventStart.secondsSinceEpoch - DateTime.CurrentTime().secondsSinceEpoch
        print(eventData.name.." is scheduled. Starts in "..time.." seconds")
        print("  Registered players: " .. eventData.registeredPlayerCount)
        PrintTags(eventData)
    end
end
```

See also: [CorePlatform.GetGameEventsForGame](coreplatform.md) | [CoreGameEventCollection.GetResults](coregameeventcollection.md) | [CoreGameEventState](enums.md#coregameeventstate) | [DateTime.CurrentTime](datetime.md)

---

## Learn More

[CorePlatform.GetGameEventsForGame()](coreplatform.md)
