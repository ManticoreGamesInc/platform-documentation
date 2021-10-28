---
id: coreplatform
name: CorePlatform
title: CorePlatform
tags:
    - API
---

# CorePlatform

The CorePlatform namespace contains functions for retrieving game metadata from the Core platform.

## Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `CorePlatform.GetGameInfo(string gameId)` | [`CoreGameInfo`](coregameinfo.md) | Requests metadata for a game with the given ID. Accepts full game IDs (eg "67442ee5c0654855b51c4f5fc96ab0fd") as well as the shorter slug version ("67442e/farmers-market"). This function may yield until a result is available, and may raise an error if the game ID is invalid or if an error occurs retrieving the information. Results may be cached for later calls. | None |
| `CorePlatform.GetGameCollection(string collectionId)` | `Array`<[`CoreGameCollectionEntry`](coregamecollectionentry.md)> | Requests a list of games belonging to a given collection. This function may yield until a result is available, and may raise an error if the collection ID is invalid or if an error occurs retrieving the information. Results may be cached for later calls. Supported collection IDs include: "new", "popular", "hot_games", "active", "featured", "highest_rated", "most_played", "most_engaging", "solo_friendly", and "tournament". | None |
| `CorePlatform.GetPlayerProfile(string playerId)` | [`CorePlayerProfile`](coreplayerprofile.md) | Requests the public account profile for the player with the given ID. This function may yield until a result is available, and may raise an error if the player ID is invalid or if an error occurs retrieving the information. Results may be cached for later calls. When called in preview mode with a bot's player ID, a placeholder profile will be returned. | None |
| `CorePlatform.GetGameEvent(string eventId)` | [`CoreGameEvent`](coregameevent.md) | Requests metadata for a creator event with the given event ID. Event IDs for specific events may be found in the Creator Events Dashboard. This function may yield until a result is available, and may raise an error if the event ID is invalid or if an error occurs retrieving the information. Results may be cached for later calls. | None |
| `CorePlatform.GetGameEventCollection(string collectionId, [table parameters])` | [`CoreGameEventCollection`](coregameeventcollection.md) | Requests a list of creator events belonging to a given collection. This function may yield until a result is available, and may raise an error if the collection ID is invalid or if an error occurs retrieving the information. Results may be cached for later calls. Supported event collection IDs include: "active", "upcoming", "popular", and "suggested". <br/>The following optional parameters are supported:<br/>`state (CoreGameEventState)`: Filters the returned collection to include only events with the specified state. By default, active and upcoming events are returned. | None |
| `CorePlatform.GetGameEventsForGame(string gameId, [table parameters])` | [`CoreGameEventCollection`](coregameeventcollection.md) | Requests a list of creator events for the specified game. This function may yield until a result is available, and may raise an error if the game ID is invalid or if an error occurs retrieving the information. Results may be cached for later calls. <br/>The following optional parameters are supported:<br/>`state (CoreGameEventState)`: Filters the returned events to include only events with the specified state. By default, active and upcoming events are returned. <br/>`tag (string)`: Filters the returned events to include only events with the given tag. | None |
| `CorePlatform.IsPlayerRegisteredForGameEvent(Player player, CoreGameEvent event)` | `boolean` | Returns `true` if the given player is registered for the given event, or `false` if they are not. This function may yield until a result is available, and may raise an error if an error occurs retrieving the information. Results may be cached for later calls, and so may also not be immediately up to date. This function will raise an error if called from a client script with a player other than the local player. | None |
| `CorePlatform.GetRegisteredGameEvents(Player player, [table parameters])` | [`CoreGameEventCollection`](coregameeventcollection.md) | Requests a list of creator events for which the given player is registered. This function may yield until a result is available, and may raise an error if an error occurs retrieving the information. This function will raise an error if called from a client script with a player other than the local player. Results may be cached for later calls. <br/>The following optional parameters are supported:<br/>`state (CoreGameEventState)`: Filters the returned events to include only events with the specified state. By default, active and upcoming events are returned. | None |

## Examples

Example using:

### `GetGameCollection`

This example prints the list of all active games, listing their rank, game name and owner.

```lua
print("### Active Games ###")

local popularGames = CorePlatform.GetGameCollection("active")

for i, entry in ipairs(popularGames) do
    print(i .. ") " .. entry.name .. " (by " .. entry.ownerName .. ")")
end
```

See also: [CoreGameCollectionEntry](coregamecollectionentry.md)

---

Example using:

### `GetGameEvent`

In this example, a specific event is fetched. If found, a countdown begins, with the remaining time until the event begins updated every second. The countdown text is print to the Event Log, but it could be set into the UI for players to see.

```lua
local EVENT_ID = "a3040c7ff0ca4a148d98191c701afe9a-ec20a9adcf374e7ab1ef5f862499c834"
local eventData = CorePlatform.GetGameEvent(EVENT_ID)

function Tick()
    Task.Wait(1)
    if eventData ~= nil then
        local eventStart = eventData:GetStartDateTime()
        local diff = eventStart.secondsSinceEpoch - DateTime.CurrentTime().secondsSinceEpoch
        if diff >= 0 then
            print(eventData.name .." starts In: ".. FormatCasualTimespan(diff))
        else
            print(eventData.name .." has started")
        end
    end
end

function FormatCasualTimespan(totalSeconds)
    if totalSeconds <= 0 then
        return "0s"
    end
    local seconds = totalSeconds
    local minutes = math.floor(seconds / 60)
    seconds = seconds - minutes*60

    if minutes > 0 then
        local hours = math.floor(minutes / 60)
        minutes = minutes - hours*60

        if hours > 0 then
            local days = math.floor(hours / 24)
            hours = hours - days*24

            if days > 0 then
                if hours > 0 then
                    return days.."d " .. hours.."h " .. minutes.."m"
                end
                return days.."d"

            elseif (minutes > 0) then
                return hours.."h " .. minutes.."m " .. seconds.."s"
            end
            return hours.."h"
        end
        return minutes.."m " .. seconds.."s"
    end
    return seconds.."s"
end
```

See also: [CoreGameEvent.GetStartDateTime](coregameevent.md) | [DateTime.CurrentTime](datetime.md) | [Task.Wait](task.md)

---

Example using:

### `GetGameEventsForGame`

In this example we look at all the events for a given game. The status of each one is printed to the Event Log. Events can be Active or Scheduled, in which case they have a remaining time or upcoming time, respectively. Events can also be in a "Canceled" state, but we ignore those. The advantages of using countdowns to express the end of an event (or wait for an upcoming one) are to build anticipation in the eyes of players, but also to avoid any complications with time zones for players around the world.

```lua
local GAME_ID = "a3040c7ff0ca4a148d98191c701afe9a"

local collection = CorePlatform.GetGameEventsForGame(GAME_ID)
local gameEvents = collection:GetResults()
for i, eventData in ipairs(gameEvents) do
    if eventData.state == CoreGameEventState.ACTIVE then
        local eventEnd = eventData:GetEndDateTime()
        local time = eventEnd.secondsSinceEpoch - DateTime.CurrentTime().secondsSinceEpoch
        print(eventData.name.." is active. Ends in "..time.." seconds")

    elseif eventData.state == CoreGameEventState.SCHEDULED then
        local eventStart = eventData:GetStartDateTime()
        local time = eventStart.secondsSinceEpoch - DateTime.CurrentTime().secondsSinceEpoch
        print(eventData.name.." is scheduled. Starts in "..time.." seconds")
    end
end
```

See also: [CoreGameEventCollection.GetResults](coregameeventcollection.md) | [CoreGameEvent.state](coregameevent.md) | [CoreGameEventState](enums.md#coregameeventstate) | [DateTime.CurrentTime](datetime.md)

---

Example using:

### `GetGameInfo`

In this example, transfer data is printed to the server log each time a player joins or leaves the game. While this works in preview mode, there will never be a `gameId` in that case, and the `reason` for the transfer will always be `BROWSE`. Therefore, this example works best when the game is published.

To see the server logs of a published game, select the Game Settings object in the hierarchy and enable "Play Mode Profiling". When playing the published game press F4 to see the profiler and access the logs. You may need a second player joining/leaving to observe the logs while testing the various different reasons.

```lua
-- Converts the enum reason into a string, to make the log more readable
function ToStringTransferReason(reason)
    -- Default reason, or player has opted out from sharing this info
    if reason == PlayerTransferReason.UNKNOWN then return "UNKNOWN" end

    -- If they leave to edit their character/collection
    if reason == PlayerTransferReason.CHARACTER then return "CHARACTER" end

    -- If they leave by pressing the "Create" tab
    if reason == PlayerTransferReason.CREATE then return "CREATE" end

    -- If they leave by pressing the "Shop" tab
    if reason == PlayerTransferReason.SHOP then return "SHOP" end

    -- If they join/leave by browsing games or from a URL
    if reason == PlayerTransferReason.BROWSE then return "BROWSE" end

    -- If they join/leave by joining a game their friend is playing
    if reason == PlayerTransferReason.SOCIAL then return "SOCIAL" end

    -- If they join/leave when a game uses player:TransferToGame()
    if reason == PlayerTransferReason.PORTAL then return "PORTAL" end

    -- If they leave from being inactive for longer than the AFK limit
    if reason == PlayerTransferReason.AFK then return "AFK" end

    -- If they close Core or log out
    if reason == PlayerTransferReason.EXIT then return "EXIT" end

    -- Fallback, future-proof
    return "???" .. tostring(reason)
end

-- Given a game ID, retrieves the game's name and author
function FetchGameNameAndAuthor(gameId)
    if gameId then
        -- This yields the thread while the data is retrieved
        local gameInfo = CorePlatform.GetGameInfo(gameId)
        if gameInfo then
            return gameInfo.name .. ", by " .. gameInfo.ownerName
        end
    end
    return ""
end

function OnPlayerJoined(player)
    -- CorePlatform.GetGameInfo creates a delay while the data is being retrieved, during
    -- which time the player object may no longer be valid, so we cache the name first.
    local playerName = player.name
    local transferData = player:GetJoinTransferData()
    local gameId = transferData.gameId
    local reason = ToStringTransferReason(transferData.reason)
    local gameBio = FetchGameNameAndAuthor(gameId)
    print(
    "\n Player joined = " .. playerName ..
    "\n from game = " .. tostring(gameId) .. ":" .. gameBio ..
    "\n reason = " .. reason)
end

function OnPlayerLeft(player)
    -- CorePlatform.GetGameInfo creates a delay while the data is being retrieved, during
    -- which time the player object may no longer be valid, so we cache the name first.
    local playerName = player.name
    local transferData = player:GetLeaveTransferData()
    local gameId = transferData.gameId
    local reason = ToStringTransferReason(transferData.reason)
    local gameBio = FetchGameNameAndAuthor(gameId)
    print(
    "\n Player left = " .. playerName ..
    "\n to game = " .. tostring(gameId) .. ":" .. gameBio ..
    "\n reason = " .. reason)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
Game.playerLeftEvent:Connect(OnPlayerLeft)
```

See also: [Player.GetJoinTransferData](player.md) | [PlayerTransferData.gameId](playertransferdata.md) | [PlayerTransferReason](enums.md#playertransferreason) | [Game.TransferAllPlayersToGame](game.md) | [CoreGameInfo.name](coregameinfo.md)

---

Example using:

### `GetPlayerProfile`

### `id`

### `name`

### `description`

This client script example fetches the profile of the game's creator and uses information from it to print a welcome message into the chat window.

```lua
local GAME_NAME = "Example Simulator"
local CREATOR_ID = "c19fdb85adf94580b1f926764560682e"

local player = Game.GetLocalPlayer()

local creatorProfile = CorePlatform.GetPlayerProfile(CREATOR_ID)

if CREATOR_ID ~= creatorProfile.id then
    error("Received the wrong profile, for some reason.")
end

Chat.LocalMessage("Hi " .. player.name .. "!")
Chat.LocalMessage("welcome to " .. GAME_NAME)
Chat.LocalMessage("by " .. creatorProfile.name)
Chat.LocalMessage(creatorProfile.description)
```

See also: [Chat.LocalMessage](chat.md) | [Game.GetLocalPlayer](game.md) | [Player.name](player.md)

---

Example using:

### `GetRegisteredGameEvents`

In this example, when a player joins we check if they are registered for any upcoming game events. Results are print out to the Event Log.

```lua
function OnPlayerJoined(player)
    local params = {state = CoreGameEventState.SCHEDULED}
    local collection = CorePlatform.GetRegisteredGameEvents(player, params)
    local gameEvents = collection:GetResults()
    if #gameEvents == 0 then
        print(player.name .. " is not registered for any upcoming events.")
    else
        print(player.name .. " is registered for:")
        for i, eventData in ipairs(gameEvents) do
            local eventStart = eventData:GetStartDateTime()
            local time = eventStart.secondsSinceEpoch - DateTime.CurrentTime().secondsSinceEpoch
            print(eventData.name..". Starts in "..time.." seconds")
        end
    end
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

See also: [CoreGameEventCollection.GetResults](coregameeventcollection.md) | [CoreGameEventState](enums.md#coregameeventstate) | [CoreGameEvent.GetStartDateTime](coregameevent.md) | [DateTime.CurrentTime](datetime.md) | [Player.name](player.md)

---

Example using:

### `IsPlayerRegisteredForGameEvent`

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

See also: [UIEventRSVPButton.eventId](uieventrsvpbutton.md) | [CoreGameEventCollection.GetResults](coregameeventcollection.md) | [CorePlatform.GetGameEventsForGame](coreplatform.md) | [CoreGameEvent.state](coregameevent.md) | [CoreGameEventState](enums.md#coregameeventstate) | [UIButton.clickedEvent](uibutton.md) | [UIText.text](uitext.md) | [CoreObject.GetCustomProperty](coreobject.md)

---
