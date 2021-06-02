---
id: coresocial
name: CoreSocial
title: CoreSocial
tags:
    - API
---

# CoreSocial

The CoreSocial namespace contains functions for retrieving social metadata from the Core platform.

## Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `CoreSocial.IsFriendsWithLocalPlayer(Player)` | `bool` | Returns `true` if the given Player is friends with the local player. | Client-Only |
| `CoreSocial.IsFriendsWithLocalPlayer(string playerId)` | `bool` | Returns `true` if the specified player is friends with the local player. | Client-Only |
| `CoreSocial.GetFriends(Player)` | [`CoreFriendCollection`](corefriendcollection.md) | Requests a list of the given Player's friends. This function may yield until a result is available, and may raise an error if an error occurs retrieving the information. Results may be cached for later calls. A partial list of friends may be returned, depending on how many friends the player has. See `CoreFriendCollection` for information on retrieving more results. If a player has no friends, or when called in multiplayer preview mode for a bot player, an empty `CoreFriendCollection` will be returned. | None |

## Examples

Example using:

### `GetFriends`

### `GetResults`

### `GetMoreResults`

### `name`

### `id`

In this client script, a function is setup to gather the names and ID of all players that are Core friends of the local player. The function is then called and the data is printed out to the Event Log. The pagination aspect of the friend collection, with `GetMoreResults()` is worth considering as part of the game's user interface, instead of collecting the entire data set as in this example. That is because these CoreSocial functions yield the thread as they wait for the results, which might cause the UI to freeze for players that have hundreds of friends.

```lua
function GetAllFriendEntries(player)
    local friendCollection = CoreSocial.GetFriends(player)
    local entries = friendCollection:GetResults()
    
    while true do
        friendCollection = friendCollection:GetMoreResults()
        if friendCollection then
            local moreEntries = friendCollection:GetResults()
            for _,entry in ipairs(moreEntries) do
                table.insert(entries, entry)
            end
        else
            break
        end
    end
    return entries
end

local player = Game.GetLocalPlayer()
print("All friends of " .. player.name .. ":")

local entries = GetAllFriendEntries(player)
for _,entry in ipairs(entries) do
    print(entry.name .. " : " .. entry.id)
end
```

See also: [Game.GetLocalPlayer](game.md)

---

Example using:

### `GetFriends`

### `GetResults`

### `GetMoreResults`

### `name`

### `id`

In this second example, pagination is used to peruse the player's friend list. The size of the page is flexible, to best fit the user interface and not tied to the return limits of `GetResults()`. UI buttons could be tied to the `NextPage()` and `PreviousPage()` functions, but here we demonstrate by printing out all the pages into the Event Log. The functions `HasNextPage()` and `HasPreviousPage()` can be used to disable/enable the next & previous buttons.

```lua
local PLAYER = Game.GetLocalPlayer()
local PAGE_SIZE = 5
local currentPageIndex = 1
local friendCollection = nil
local allEntries = nil
local currentPage = nil
local moreToLoad = true
local pageCount = 0

function Init()
    friendCollection = CoreSocial.GetFriends(PLAYER)
    local entries = friendCollection:GetResults()
    
    if allEntries == nil then
        allEntries = entries
    else
        for _,entry in ipairs(entries) do
            table.insert(allEntries, entry)
        end
    end
    
    if #allEntries < PAGE_SIZE * 2 then
        LoadMore()
    end
    
    UpdateCurrentPage()
end

function UpdateCurrentPage()
    pageCount = math.ceil(#allEntries / PAGE_SIZE)
    currentPage = {}
    local startIndex = (currentPageIndex - 1) * PAGE_SIZE + 1
    local endIndex = startIndex + PAGE_SIZE - 1
    for i = startIndex, endIndex do
        if i > #allEntries then
            return currentPage
        end
        table.insert(currentPage, allEntries[i])
    end
    return currentPage
end

function LoadMore()
    friendCollection = friendCollection:GetMoreResults()
    if friendCollection then
        local moreEntries = friendCollection:GetResults()
        for _,entry in ipairs(moreEntries) do
            table.insert(allEntries, entry)
        end
    else
        moreToLoad = false
    end
end

function NextPage()
    if moreToLoad and (currentPageIndex + 2) * PAGE_SIZE > #allEntries then
        LoadMore()
    end
    if currentPageIndex * PAGE_SIZE + 1 <= #allEntries then
        currentPageIndex = currentPageIndex + 1
    end    
    return UpdateCurrentPage()
end

function PreviousPage()
    if currentPageIndex <= 1 then
        return currentPage
    end
    currentPageIndex = currentPageIndex - 1
    
    return UpdateCurrentPage()
end

function HasNextPage()
    return currentPageIndex < pageCount
end

function HasPreviousPage()
    return currentPageIndex > 1
end

Init()

-- Print all pages to the Event Log

function PrintCurrentPage()
    print("\nPage " .. currentPageIndex)
    for _,entry in ipairs(currentPage) do
        print(entry.name .. " : " .. entry.id)
    end
end

PrintCurrentPage()
while HasNextPage() do
    NextPage()
    PrintCurrentPage()
end
```

See also: [Game.GetLocalPlayer](game.md)

---

Example using:

### `IsFriendsWithLocalPlayer`

In this example, when a player joins the game, we look through all other players to see if one of them is friends with the new player. If that's the case, then we send a message to the server to request a change of team, so the players can be on the same team.

```lua
-- Client script, goes inside a client context
local player = Game.GetLocalPlayer()
for _,p in ipairs(Game.GetPlayers()) do
    if player ~= p and
    CoreSocial.IsFriendsWithLocalPlayer(p) then
        local friendId = p.id
        Events.BroadcastToServer("Friendly", friendId)
        break
    end
end

-- Server script, can be in default context or server context
function OnFriendly(player, friendId)
    local friendPlayer = Game.FindPlayer(playerId)
    if Object.IsValid(friendPlayer) then
        player.team = friendPlayer.team
    end
end
Events.ConnectForPlayer("Friendly", OnFriendly)
```

See also: [Game.GetLocalPlayer](game.md) | [Player.id](player.md) | [Events.BroadcastToServer](events.md) | [Object.IsValid](object.md)

---

Example using:

### `IsFriendsWithLocalPlayer`

In this client script example a global leaderboard is enriched with additional data about the players, in this case wheather the player on the leaderboard is you, or if they are a friend of yours.

```lua
local LEADERBOARD_REF = script:GetCustomProperty("LeaderboardRef")

-- Wait for leaderboards to load.
-- If a score has never been submitted it will stay in this loop forever
while not Leaderboards.HasLeaderboards() do
    Task.Wait(1)
end

local player = Game.GetLocalPlayer()

local leaderboard = Leaderboards.GetLeaderboard(LEADERBOARD_REF, LeaderboardType.GLOBAL)
for i, entry in ipairs(leaderboard) do
    local playerId = entry.id
    local additionalMessage =  ""
    if playerId == player.id then
        additionalMessage = "You"
    else
        additionalMessage = "friend"
    end
    local isFriends = CoreSocial.IsFriendsWithLocalPlayer(playerId)
    print(i .. ")", entry.name, ":", entry.score, "- "..additionalMessage)
end
```

See also: [Leaderboards.HasLeaderboards](leaderboards.md) | [LeaderboardEntry.id](leaderboardentry.md) | [Game.GetLocalPlayer](game.md) | [Task.Wait](task.md) | [CoreObject.GetCustomProperty](coreobject.md)

---
