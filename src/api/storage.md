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
| `Storage.GetConcurrentSharedPlayerData(NetReference concurrentSharedStorageKey, string playerId)` | <`table` data, [`StorageResultCode`](enums.md#storageresultcode) resultCode, `string` errorMessage> | Requests the concurrent player data associated with the specified player and storage key. The storage key must be of type `CONCURRENT_SHARED_PLAYER_STORAGE`. This function may yield until data is available. Returns the data (`nil` if not available), a result code, and an optional error message if an error occurred. | Server-Only |
| `Storage.SetConcurrentSharedPlayerData(NetReference concurrentSharedStorageKey, string playerId, function callback)` | <`table` data, [`StorageResultCode`](enums.md#storageresultcode) resultCode, `string` errorMessage> | Updates the concurrent player data associated with the specified player and storage key. The storage key must be of type `CONCURRENT_SHARED_PLAYER_STORAGE`. This function retrieves the most recent copy of the player's data, then calls the creator-provided `callback` function with the data table as a parameter. `callback` is expected to return the player's updated data table, which will then be saved. This function yields until the entire process is complete, returning a copy of the player's updated data (`nil` if not available), a result code, and an optional error message if an error occurred. | Server-Only |
| `Storage.GetConcurrentCreatorData(NetReference concurrentCreatorStorageKey)` | <`table` data, [`StorageResultCode`](enums.md#storageresultcode) resultCode, `string` errorMessage> | Requests the concurrent data associated with the given storage key. The storage key must be of type `CONCURRENT_CREATOR_STORAGE`. This data is player- and game-agnostic. This function may yield until data is available. Returns the data (`nil` if not available), a result code, and an optional error message if an error occurred. | Server-Only |
| `Storage.SetConcurrentCreatorData(NetReference concurrentCreatorStorageKey, function callback)` | <`table` data, [`StorageResultCode`](enums.md#storageresultcode) resultCode, `string` errorMessage> | Updates the concurrent data associated with the given storage key. The storage key must be of type `CONCURRENT_CREATOR_STORAGE`. This data is player- and game-agnostic. This function retrieves the most recent copy of the creator data, then calls the creator-provided `callback` function with the data table as a parameter. `callback` is expected to return the updated data table, which will then be saved. This function yields until the entire process is complete, returning a copy of the updated data (`nil` if not available), a result code, and an optional error message if an error occurred. | Server-Only |
| `Storage.ConnectToConcurrentPlayerDataChanged(string playerId, function eventListener, [...])` | [`EventListener`](eventlistener.md) | Listens for any changes to the concurrent data associated with `playerId` for this game. Calls to `Storage.SetConcurrentPlayerData()` from this or other game servers will trigger this listener. The listener function parameters should be: `string` player ID, `table` player data. Accepts any number of additional arguments after the listener function, those arguments will be provided, in order, after the `table` argument. Returns an EventListener which can be used to disconnect from the event or check if the event is still connected. | None |
| `Storage.ConnectToConcurrentSharedPlayerDataChanged(NetReference concurrentSharedStorageKey, string playerId, function eventListener, [...])` | [`EventListener`](eventlistener.md) | Listens for any changes to the concurrent shared data associated with `playerId` and `concurrentSharedStorageKey`. Calls to `Storage.SetConcurrentSharedPlayerData()` from this or other game servers will trigger this listener. The listener function parameters should be: `NetReference` storage key, `string` player ID, `table` shared player data. Accepts any number of additional arguments after the listener function, those arguments will be provided, in order, after the `table` argument. Returns an EventListener which can be used to disconnect from the event or check if the event is still connected. | None |
| `Storage.ConnectToConcurrentCreatorDataChanged(NetReference concurrentCreatorStorageKey, function eventListener, [...])` | [`EventListener`](eventlistener.md) | Listens for any changes to the concurrent data associated with `concurrentCreatorStorageKey`. Calls to `Storage.SetConcurrentCreatorData()` from this or other game servers will trigger this listener. The listener function parameters should be: `NetReference` storage key, `table` creator data. Accepts any number of additional arguments after the listener function, those arguments will be provided, in order, after the `table` argument. Returns an EventListener which can be used to disconnect from the event or check if the event is still connected. | None |
| `Storage.HasPendingSetConcurrentPlayerData(string playerId)` | `boolean` | Returns `true` if this server has a pending call to `Storage.SetConcurrentPlayerData()` either waiting to be processed or actively running for the specified player ID. | None |
| `Storage.HasPendingSetConcurrentSharedPlayerData(NetReference concurrentSharedStorageKey, string playerId)` | `boolean` | Returns `true` if this server has a pending call to `Storage.SetConcurrentSharedPlayerData()` either waiting to be processed or actively running for the specified player ID and shared storage key. | None |
| `Storage.HasPendingSetConcurrentCreatorData(NetReference concurrentCreatorStorageKey)` | `boolean` | Returns `true` if this server has a pending call to `Storage.SetConcurrentCreatorData()` either waiting to be processed or actively running for the specified creator storage key. | None |

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
