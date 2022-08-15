---
id: playertransferdata
name: PlayerTransferData
title: PlayerTransferData
tags:
    - API
---

# PlayerTransferData

PlayerTransferData contains information indicating how a player joined or left a game, and their next or previous game ID if they're moving directly from one game to another. Players may opt out of sharing this information by selecting "Hide My Gameplay Activity" or "Appear Offline" in the social panel settings.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `reason` | [`PlayerTransferReason`](enums.md#playertransferreason) | Indicates how the player joined or left a game. | Read-Only |
| `gameId` | `string` | The ID of the game the player joined from or left to join. Returns `nil` if the player joined while not already connected to a game or left for a reason other than joining another game. Also returns `nil` if the player has opted out of sharing this information. | Read-Only |
| `sceneId` | `string` | The scene ID that the player joined from or left to join. May return `nil`. | Read-Only |
| `sceneName` | `string` | The scene name that the player joined from or left to join. May return `nil`. | Read-Only |
| `spawnKey` | `string` | The spawn key used when transferring a player to another scene. May return `nil`. | Read-Only |

## Examples

Example using:

### `gameId`

### `reason`

### `sceneId`

### `sceneName`

In this example, transfer data is printed to the event log each time a player joins or leaves the game. While this works in preview mode, there will never be a `gameId` in that case, and the `reason` for the transfer will always be `BROWSE`. Therefore, this example works best when the game is published.

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
    local sceneId = transferData.sceneId
    local sceneName = transferData.sceneName
    local gameBio = FetchGameNameAndAuthor(gameId)
    print(
    "\n Player joined = " .. playerName ..
    "\n from game = " .. tostring(gameId) .. ":" .. gameBio ..
    "\n reason = " .. reason ..
    "\n scene = " .. tostring(sceneName) .. ":" .. tostring(sceneId))
end

function OnPlayerLeft(player)
    -- CorePlatform.GetGameInfo creates a delay while the data is being retrieved, during
    -- which time the player object may no longer be valid, so we cache the name first.
    local playerName = player.name
    local transferData = player:GetLeaveTransferData()
    local gameId = transferData.gameId
    local reason = ToStringTransferReason(transferData.reason)
    local sceneId = transferData.sceneId
    local sceneName = transferData.sceneName
    local gameBio = FetchGameNameAndAuthor(gameId)
    print(
    "\n Player left = " .. playerName ..
    "\n to game = " .. tostring(gameId) .. ":" .. gameBio ..
    "\n reason = " .. reason ..
    "\n scene = " .. tostring(sceneName) .. ":" .. tostring(sceneId))
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
Game.playerLeftEvent:Connect(OnPlayerLeft)
```

See also: [PlayerTransferReason](enums.md#playertransferreason) | [Player.TransferToGame](player.md) | [Game.TransferAllPlayersToGame](game.md) | [CoreGameInfo.name](coregameinfo.md)

---
