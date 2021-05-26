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
