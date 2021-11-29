---
id: storage
name: Storage
title: Storage
tags:
    - API
---

# Storage

The Storage namespace contains a set of functions for handling persistent storage of data. To use the Storage API, you must place a Game Settings object in your game and check the Enable Player Storage property on it.

Core storage allows a maximum of 32Kb (32768 bytes) of encoded data to be stored. Any data exceeding this limit is not guaranteed to be stored and can potentially cause loss of stored data. Exceeding the limit will cause a warning to be displayed in the event log when in preview mode.

`Storage.SizeOfData()` can be used to check the size of data (in bytes) before assigning to storage. If size limit has been exceeded consider replacing strings with numbers or using advanced techniques such as bit packing to reduce the size of data stored.

## Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `Storage.GetPlayerData(Player player)` | `table` | Returns the player data associated with `player`. This returns a copy of the data that has already been retrieved for the player, so calling this function does not incur any additional network cost. Changes to the data in the returned table will not be persisted without calling `Storage.SetPlayerData()`. | Server-Only |
| `Storage.SetPlayerData(Player player, table data)` | <[`StorageResultCode`](enums.md#storageresultcode) resultCode, `string` errorMessage> | Updates the data associated with `player`. Returns a result code and an error message. See below for supported data types. | Server-Only |
| `Storage.GetSharedPlayerData(NetReference sharedStorageKey, Player player)` | `table` | Returns the shared player data associated with `player` and `sharedStorageKey`. This returns a copy of the data that has already been retrieved for the player, so calling this function does not incur any additional network cost. Changes to the data in the returned table will not be persisted without calling `Storage.SetSharedPlayerData()`. | Server-Only |
| `Storage.SetSharedPlayerData(NetReference sharedStorageKey, Player player, table data)` | <[`StorageResultCode`](enums.md#storageresultcode) resultCode, `string` errorMessage> | Updates the shared data associated with `player` and `sharedStorageKey`. Returns a result code and an error message. See below for supported data types. | Server-Only |
| `Storage.SizeOfData(table data)` | `integer` | Computes and returns the size required for the given `data` table when stored as Player data. | Server-Only |
| `Storage.GetOfflinePlayerData(string playerId)` | `table` | Requests the player data associated with the specified player who is not in the current instance of the game. This function may yield until data is available, and may raise an error if the player ID is invalid or if an error occurs retrieving the information. If the player is in the current instance of the game, `Storage.GetPlayerData()` should be used instead. | Server-Only |
| `Storage.GetSharedOfflinePlayerData(NetReference sharedStorageKey, string playerId)` | `table` | Requests the shared player data associated with `sharedStorageKey` and the specified player who is not in the current instance of the game. This function may yield until data is available, and may raise an error if the player ID is invalid or if an error occurs retrieving the information. If the player is in the current instance of the game, `Storage.GetSharedPlayerData()` should be used instead. | Server-Only |
| `Storage.GetConcurrentPlayerData(string playerId)` | <`table` data, [`StorageResultCode`](enums.md#storageresultcode) resultCode, `string` errorMessage> | Requests the concurrent player data associated with the specified player. This function may yield until data is available. Returns the data (`nil` if not available), a result code, and an optional error message if an error occurred. | Server-Only |
| `Storage.SetConcurrentPlayerData(string playerId, function callback)` | <`table` data, [`StorageResultCode`](enums.md#storageresultcode) resultCode, `string` errorMessage> | Updates the concurrent player data associated with the specified player. This function retrieves the most recent copy of the player's data, then calls the creator-provided `callback` function with the data table as a parameter. `callback` is expected to return the player's updated data table, which will then be saved. This function yields until the entire process is complete, returning a copy of the player's updated data (`nil` if not available), a result code, and an optional error message if an error occurred. | Server-Only |
| `Storage.ConnectToConcurrentPlayerDataChanged(string playerId, function eventListener, [...])` | [`EventListener`](eventlistener.md) | Listens for any changes to the concurrent data associated with `playerId` for this game. Calls to `Storage.SetConcurrentPlayerData()` from this or other game servers will trigger this listener. The listener function parameters should be: `string` player ID, `table` player data. Accepts any number of additional arguments after the listener function, those arguments will be provided, in order, after the `table` argument. Returns an EventListener which can be used to disconnect from the event or check if the event is still connected. | Server-Only |
| `Storage.HasPendingSetConcurrentPlayerData(string playerId)` | `boolean` | Returns `true` if this server has a pending call to `Storage.SetConcurrentPlayerData()` either waiting to be processed or actively running for the specified player ID. | Server-Only |
| `Storage.GetConcurrentSharedPlayerData(NetReference concurrentSharedStorageKey, string playerId)` | <`table` data, [`StorageResultCode`](enums.md#storageresultcode) resultCode, `string` errorMessage> | Requests the concurrent player data associated with the specified player and storage key. The storage key must be of type `CONCURRENT_SHARED_PLAYER_STORAGE`. This function may yield until data is available. Returns the data (`nil` if not available), a result code, and an optional error message if an error occurred. | Server-Only |
| `Storage.SetConcurrentSharedPlayerData(NetReference concurrentSharedStorageKey, string playerId, function callback)` | <`table` data, [`StorageResultCode`](enums.md#storageresultcode) resultCode, `string` errorMessage> | Updates the concurrent player data associated with the specified player and storage key. The storage key must be of type `CONCURRENT_SHARED_PLAYER_STORAGE`. This function retrieves the most recent copy of the player's data, then calls the creator-provided `callback` function with the data table as a parameter. `callback` is expected to return the player's updated data table, which will then be saved. This function yields until the entire process is complete, returning a copy of the player's updated data (`nil` if not available), a result code, and an optional error message if an error occurred. | Server-Only |
| `Storage.ConnectToConcurrentSharedPlayerDataChanged(NetReference concurrentSharedStorageKey, string playerId, function eventListener, [...])` | [`EventListener`](eventlistener.md) | Listens for any changes to the concurrent shared data associated with `playerId` and `concurrentSharedStorageKey`. Calls to `Storage.SetConcurrentSharedPlayerData()` from this or other game servers will trigger this listener. The listener function parameters should be: `NetReference` storage key, `string` player ID, `table` shared player data. Accepts any number of additional arguments after the listener function, those arguments will be provided, in order, after the `table` argument. Returns an EventListener which can be used to disconnect from the event or check if the event is still connected. | Server-Only |
| `Storage.HasPendingSetConcurrentSharedPlayerData(NetReference concurrentSharedStorageKey, string playerId)` | `boolean` | Returns `true` if this server has a pending call to `Storage.SetConcurrentSharedPlayerData()` either waiting to be processed or actively running for the specified player ID and shared storage key. | Server-Only |
| `Storage.GetConcurrentCreatorData(NetReference concurrentCreatorStorageKey)` | <`table` data, [`StorageResultCode`](enums.md#storageresultcode) resultCode, `string` errorMessage> | Requests the concurrent data associated with the given storage key. The storage key must be of type `CONCURRENT_CREATOR_STORAGE`. This data is player- and game-agnostic. This function may yield until data is available. Returns the data (`nil` if not available), a result code, and an optional error message if an error occurred. | Server-Only |
| `Storage.SetConcurrentCreatorData(NetReference concurrentCreatorStorageKey, function callback)` | <`table` data, [`StorageResultCode`](enums.md#storageresultcode) resultCode, `string` errorMessage> | Updates the concurrent data associated with the given storage key. The storage key must be of type `CONCURRENT_CREATOR_STORAGE`. This data is player- and game-agnostic. This function retrieves the most recent copy of the creator data, then calls the creator-provided `callback` function with the data table as a parameter. `callback` is expected to return the updated data table, which will then be saved. This function yields until the entire process is complete, returning a copy of the updated data (`nil` if not available), a result code, and an optional error message if an error occurred. | Server-Only |
| `Storage.ConnectToConcurrentCreatorDataChanged(NetReference concurrentCreatorStorageKey, function eventListener, [...])` | [`EventListener`](eventlistener.md) | Listens for any changes to the concurrent data associated with `concurrentCreatorStorageKey`. Calls to `Storage.SetConcurrentCreatorData()` from this or other game servers will trigger this listener. The listener function parameters should be: `NetReference` storage key, `table` creator data. Accepts any number of additional arguments after the listener function, those arguments will be provided, in order, after the `table` argument. Returns an EventListener which can be used to disconnect from the event or check if the event is still connected. | Server-Only |
| `Storage.HasPendingSetConcurrentCreatorData(NetReference concurrentCreatorStorageKey)` | `boolean` | Returns `true` if this server has a pending call to `Storage.SetConcurrentCreatorData()` either waiting to be processed or actively running for the specified creator storage key. | Server-Only |

## Additional Info

??? "Storage Supported Types"
    - boolean
    - Int32
    - Float
    - string
    - Color
    - Rotator
    - Vector2
    - Vector3
    - Vector4
    - Player
    - table

## Examples

Example using:

### `GetConcurrentCreatorData`

### `SetConcurrentCreatorData`

### `ConnectToConcurrentCreatorDataChanged`

### `HasPendingSetConcurrentCreatorData`

With concurrent storage, a game can have data that is shared between all server instances and is not tied to any specific player. In this example, we track the total number of players in all servers. Due to the fact concurrent data becomes locked to the process that is modifying it, it would be suboptimal to update data immediately as players join/leave. Therefore, each server keeps track of a temporary "delta" value-- the difference between players joining and leaving during a small window of time. Periodically, the delta is added to the total and is reset. In this way, we are batching multiple changes into a single `Set` operation.

```lua
local CONCURRENT_KEY = script:GetCustomProperty("ConcurrentKey")
local SEND_PERIOD = script:GetCustomProperty("SendPeriod") or 10

-- Add players when they join. Subtract when they leave.
local deltaPlayers = 0

Game.playerJoinedEvent:Connect(function(player)
    deltaPlayers = deltaPlayers + 1
end)

Game.playerLeftEvent:Connect(function(player)
    deltaPlayers = deltaPlayers - 1
end)

function Tick()
    Task.Wait(SEND_PERIOD)

    -- Nothing has changed. Try again later
    if deltaPlayers == 0 then return end

    -- There's already a Set operation in progress. Try again later
    if Storage.HasPendingSetConcurrentCreatorData(CONCURRENT_KEY) then return end

    -- Apply the differece in total players
    local data, result, message = Storage.SetConcurrentCreatorData(CONCURRENT_KEY, function(data)
        if not data.totalPlayers then
            data.totalPlayers = deltaPlayers
        else
            data.totalPlayers = data.totalPlayers + deltaPlayers
        end
        return data
    end)
    deltaPlayers = 0

    -- Possible error message
    if result ~= StorageResultCode.SUCCESS then
        warn("Failed to set total players. Result code = " ..result ..", "..tostring(message))
    end
end

-- Listen for changes to the data and update the `totalPlayers` variable.
local totalPlayers = 0

function OnConcurrentDataChanged(_, data)
    if data.totalPlayers and data.totalPlayers ~= totalPlayers then
        totalPlayers = data.totalPlayers
        -- Tell everyone about the new total players across all games
        Chat.BroadcastMessage("Total players: " .. totalPlayers)
    end
end
Storage.ConnectToConcurrentCreatorDataChanged(CONCURRENT_KEY, OnConcurrentDataChanged)

-- When this server instance comes online, fetch the latest data right away
local data, result, message = Storage.GetConcurrentCreatorData(CONCURRENT_KEY)
if result == StorageResultCode.SUCCESS then
    OnConcurrentDataChanged(_, data)
else
    warn("Initial get of total players failed.")
end
```

See also: [StorageResultCode](enums.md#storageresultcode) | [Chat.BroadcastMessage](chat.md) | [Game.playerJoinedEvent](game.md) | [Task.Wait](task.md) | [CoreObject.GetCustomProperty](coreobject.md)

---

Example using:

### `GetConcurrentPlayerData`

### `SetConcurrentPlayerData`

### `ConnectToConcurrentPlayerDataChanged`

### `HasPendingSetConcurrentPlayerData`

Concurrent storage can be used to send data to a specific player, regardless if they are in the same server instance, or even online at all. In this example we implement an inbox to which messages can be sent. While it's natural that text messages could be sent this way, the same exact code could be used to send an entire table with complex data of different types. This allows rich communication between players. The idea of "inbox" can be abstracted away from the concept of text messages, towards general-purpose communication and asynchronous gameplay.

```lua
local NEW_MESSAGE_EVENT_ID = "NewMessage"

local pendingIds = {}
local pendingMessages = {}

-- This function can be called to send any message to a player, even if they are not in the game
function SendToPlayer(playerId, message)
    table.insert(pendingIds, playerId)
    table.insert(pendingMessages, message)
end

function Tick()
    -- This Tick() will usually do nothing, until there is a new message waiting to be sent
    if #pendingIds > 0 then
        local playerId = pendingIds[1]
        local message = pendingMessages[1]

        -- In case concurrent storage is busy for this player, exit and try again later
        if Storage.HasPendingSetConcurrentPlayerData(playerId) then return end

        -- Moving ahead with the attempt to send message. Remove it from the pending queue
        table.remove(pendingIds, 1)
        table.remove(pendingMessages, 1)

        -- Try to put the message into the player's inbox
        local data, result, message = Storage.SetConcurrentPlayerData(playerId, function(data)
            if not data.inbox then
                data.inbox = {}
            end
            table.insert(data.inbox, message)
            return data
        end)

        if result == StorageResultCode.EXCEEDED_SIZE_LIMIT then
            warn("Inbox full for player " .. playerId)
        end
    end
end

-- Requests the latest concurrent storage data for a player
function CheckInbox(player)
    local playerId = player.id
    local data, result, message = Storage.GetConcurrentPlayerData(playerId)
    if result == StorageResultCode.SUCCESS then
        NotifyInbox(player, data.inbox)
    else
        warn("Failed to get inbox for player " .. playerId .. ". Result code: " .. result)
    end
end

-- Called when the server detects changes to a player's concurrent data
function OnConcurrentPlayerDataChanged(playerId, data)
    -- Find the actual player object based on their ID
    local player = Game.FindPlayer(playerId)
    NotifyInbox(player, data.inbox)
end

function NotifyInbox(player, inbox)
    -- Send the messages to the player's Client. They could be displayed in the UI
    -- At this point no messages are removed from their inbox
    if Object.IsValid(player) and inbox ~= nil then
        for _,message in ipairs(inbox) do
            Events.BroadcastToPlayer(player, NEW_MESSAGE_EVENT_ID, message)
        end
    end
end

local playerStorageListeners = {}

Game.playerJoinedEvent:Connect(function(player)
    -- Only the server in which a player has joined listens for new messages in their inbox
    local listener = Storage.ConnectToConcurrentPlayerDataChanged(player.id, OnConcurrentPlayerDataChanged)
    -- Save the event listener so we can disconnect from it later
    playerStorageListeners[player] = listener
    Task.Wait(3)
    -- After the player joins, check their inbox
    if Object.IsValid(player) then
        CheckInbox(player)
    end
end)

Game.playerLeftEvent:Connect(function(player)
    -- The player is leaving. Disconnect the event listener to stop receiving message events on this server
    if playerStorageListeners[player].isConnected then
        playerStorageListeners[player]:Disconnect()
        playerStorageListeners[player] = nil
    end
end)
```

See also: [StorageResultCode](enums.md#storageresultcode) | [EventListener.Disconnect](eventlistener.md) | [Game.FindPlayer](game.md) | [Events.BroadcastToPlayer](events.md) | [Object.IsValid](object.md) | [Task.Wait](task.md)

---

Example using:

### `GetConcurrentSharedPlayerData`

### `SetConcurrentSharedPlayerData`

In this example, we track the last timestamp and scene name in which a player joined the game. This could be used, for example, to augment a leaderboard with extra columns.

```lua
local STORAGE_KEY = script:GetCustomProperty("StorageKey")

function OnPlayerJoined(player)
    -- Do as much work as possible outside of the callback, to minimize duration of lock
    local sceneName = Game.GetCurrentSceneName()
    local timestamp = DateTime.CurrentTime():ToIsoString()
    local lastSeenData = {
        sceneName = sceneName,
        timestamp = timestamp
    }
    Storage.SetConcurrentSharedPlayerData(STORAGE_KEY, player.id, function(data)
        data.lastSeen = lastSeenData
        return data
    end)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)

function GetLastSeen(playerId)
    local data, result = Storage.GetConcurrentSharedPlayerData(STORAGE_KEY, playerId)
    if result == StorageResultCode.SUCCESS then
        return data.lastSeen
    end
    return nil
end
```

See also: [StorageResultCode](enums.md#storageresultcode) | [Game.GetCurrentSceneName](game.md) | [DateTime.CurrentTime](datetime.md)

---

Example using:

### `GetOfflinePlayerData`

### `GetSharedOfflinePlayerData`

In this example a global leaderboard is enriched with additional data about the player, in this case just their Level, but other data could be included when filling the leaderboard with information. To do this, the script combines a few different concepts about player data. First, the leaderboard data itself provides a list of players for which we then fetch additional data. It's likely the player is not connected to the server, thus offline storage is used, but if they are, regular storage is faster and doesn't yield the thread. Finally, the game may have defined a shared key, resulting in 4 different ways in which the additional player data (level number) is retrieved.

```lua
local LEADERBOARD_REF = script:GetCustomProperty("LeaderboardRef")
local STORAGE_KEY = script:GetCustomProperty("StorageKey")

-- Wait for leaderboards to load.
-- If a score has never been submitted it will stay in this loop forever
while not Leaderboards.HasLeaderboards() do
    Task.Wait(1)
end

local leaderboard = Leaderboards.GetLeaderboard(LEADERBOARD_REF, LeaderboardType.GLOBAL)
for i, entry in ipairs(leaderboard) do
    local playerId = entry.id
    local player = Game.FindPlayer(playerId)
    local data
    if player then
        -- The player is on this server, access data directly
        if STORAGE_KEY and STORAGE_KEY.isAssigned then
            -- If there is a shared game key
            data = Storage.GetSharedPlayerData(STORAGE_KEY, player) -- method 1
        else
            data = Storage.GetPlayerData(player) -- method 2
        end
    else
        -- Player is not here, use offline storage. This yields the thread
        if STORAGE_KEY and STORAGE_KEY.isAssigned then
            -- If there is a shared game key
            data = Storage.GetSharedOfflinePlayerData(STORAGE_KEY, playerId) -- method 3
        else
            data = Storage.GetOfflinePlayerData(playerId) -- method 4
        end
    end
    -- Get the additional data
    local playerLevel = data["level"] or 0

    print(i .. ")", entry.name, ":", entry.score, "- Level " .. playerLevel)
end
```

See also: [Storage.GetPlayerData](storage.md) | [Game.FindPlayer](game.md) | [Leaderboards.HasLeaderboards](leaderboards.md) | [LeaderboardEntry.id](leaderboardentry.md) | [Task.Wait](task.md) | [CoreObject.GetCustomProperty](coreobject.md)

---

Example using:

### `GetPlayerData`

This example detects when a player joins the game and fetches their XP and level from storage. Those properties are moved to the player's resources for use by other gameplay systems.

```lua
function OnPlayerJoined(player)
    local data = Storage.GetPlayerData(player)
    -- In case it's the first time for this player we use default values 0 and 1
    local xp = data["xp"] or 0
    local level = data["level"] or 1
    -- Each time they join they gain 1 XP. Stop and play the game again to test that this value keeps going up
    xp = xp + 1
    player:SetResource("xp", xp)
    player:SetResource("level", level)
    print("Player " .. player.name .. " joined with Level " .. level .. " and XP " .. xp)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

See also: [Storage.SetPlayerData](storage.md) | [Player.SetResource](player.md) | [Game.playerJoinedEvent](game.md) | [Event.Connect](event.md)

---

Example using:

### `GetSharedPlayerData`

This example shows how to read data that has been saved to Shared Storage. Because this is saved via shared-key persistence, the data may have been written by a different game. This allows you to have multiple games share the same set of player data.

For this example to work, there is some setup that needs to be done:

- Storage needs to be enabled in the Game Settings object.

- You have to create a shared key.

- The NetReference for the shared key needs to be added to the script as a custom property.

See the <a href="https://docs.coregames.com/tutorials/shared_storage/">Shared Storage</a> documentation for details on how to create shared keys.

```lua
local propSharedKey = script:GetCustomProperty("DocTestSharedKey")
local returnTable = Storage.GetSharedPlayerData(propSharedKey, player)

-- Print out the data we retrieved:
for k, v in pairs(returnTable) do
    print(k, v)
end
```

---

Example using:

### `SetPlayerData`

This example detects when a player gains XP or level and saves the new values to storage.

```lua
function OnResourceChanged(player, resName, resValue)
    if (resName == "xp" or resName == "level") then
        local data = Storage.GetPlayerData(player)
        data[resName] = resValue
        local resultCode,errorMessage = Storage.SetPlayerData(player, data)
    end
end

function OnPlayerJoined(player)
    player.resourceChangedEvent:Connect(OnResourceChanged)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

See also: [Storage.GetPlayerData](storage.md) | [Player.resourceChangedEvent](player.md) | [Game.playerJoinedEvent](game.md) | [Event.Connect](event.md)

---

Example using:

### `SetSharedPlayerData`

This example shows how to write data to the Shared Storage. With this, any maps that you enable with your shared key can all access the same data that is associated with a player. This means that you could have several games where reward, levels, or achievements carry over between them.

For this example to work, there is some setup th at needs to be done:

- Storage needs to be enabled in the Game Settings object.

- You have to create a shared key.

- The NetReference for the shared key needs to be added to the script as a custom property.

See the <a href="https://docs.coregames.com/tutorials/shared_storage/">Shared Storage</a> documentation for details on how to create shared keys.

```lua
local propSharedKey = script:GetCustomProperty("DocTestSharedKey")

local sampleData = {
    name = "Philip",
    points = 1000,
    favorite_color = Color.RED,
    skill_levels = {swordplay = 8, flying = 10, electromagnetism = 5, friendship = 30}
}
Storage.SetSharedPlayerData(propSharedKey, player, sampleData)
```

---

## Tutorials

Check out our [Persistent Data Storage in Core](../tutorials/persistent_storage_tutorial.md) tutorial to learn how to apply this API in practice.

## Learn More

[NetReference on the Core API](netreference.md) | [Persistent Storage Reference](../references/persistent_storage.md)
