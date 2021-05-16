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
| `CorePlatform.GetGameCollection(string collectionId)` | `Array<`[`CoreGameCollectionEntry`](coregamecollectionentry.md)`>` | Requests a list of games belonging to a given collection. This function may yield until a result is available, and may raise an error if the collection ID is invalid or if an error occurs retrieving the information. Results may be cached for later calls. Supported collection IDs include: "new", "popular", "hot_games", "active", "featured", "highest_rated", "most_played", and "tournament". | None |
| `CorePlatform.GetPlayerProfile(string playerId)` | [`CorePlayerProfile`](coreplayerprofile.md) | Requests the public account profile for the player with the given ID. This function may yield until a result is available, and may raise an error if the player ID is invalid or if an error occurs retrieving the information. Results may be cached for later calls. When called in preview mode with a bot's player ID, a placeholder profile will be returned. | None |

## Examples

Example using:

### `GetGameCollection`

This example prints the list of all active games, listing their rank, game name and owner.

```lua
print("### Active Games ###")

local popularGames = CorePlatform.GetGameCollection("active")

for i,entry in ipairs(popularGames) do
    print(i .. ") " .. entry.name .. " (by " .. entry.ownerName .. ")")
end
```

See also: [CoreGameCollectionEntry](coregamecollectionentry.md)

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

See also: [Player.GetJoinTransferData](player.md) | [PlayerTransferData.gameId](playertransferdata.md) | [PlayerTransferReason](playertransferreason.md) | [Game.TransferAllPlayersToGame](game.md) | [CoreGameInfo.name](coregameinfo.md)

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
