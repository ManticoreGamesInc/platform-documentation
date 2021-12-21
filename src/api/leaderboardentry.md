---
id: leaderboardentry
name: LeaderboardEntry
title: LeaderboardEntry
tags:
    - API
---

# LeaderboardEntry

A data structure containing a player's entry on a leaderboard. See the `Leaderboards` API for information on how to retrieve or update a `LeaderboardEntry`.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `id` | `string` | The ID of the `Player` whose entry this is. | Read-Only |
| `name` | `string` | The name of the `Player` whose entry this is. | Read-Only |
| `score` | `number` | The Player's score. | Read-Only |
| `additionalData` | `string` | Optional additional data that was submitted along with the Player's score. (See `Leaderboards.SubmitPlayerScore()` for more information.) | Read-Only |

## Examples

Example using:

### `id`

### `name`

### `score`

### `additionalData`

The `Leaderboards` namespace contains a set of functions for retrieving and updating player leaderboard data. This is a special kind of persistence that lets you save high scores for a game, with the data being associated with the game itself, rather than any particular player.

In order to use these functions, you must first create a Global Leaderboard in the Core editor. (Select Global Leaderboards, under the **Window** menu.)

```lua
function PrintLeaderboardEntry(entry)
    print(string.format("%s (%s): %d [%s]", entry.name, entry.id, entry.score, entry.additionalData))
end

-- To create this reference, create a custom property of type 'netreference',
-- and drag a leaderboard into it, from the Global Leaderboards tab:
local LEADERBOARD_REF = script:GetCustomProperty("LeaderboardRef")

-- Verify that we actually have leaderboard data to load:
if Leaderboards.HasLeaderboards() then
    -- Save a score to the leaderboard:
    Leaderboards.SubmitPlayerScore(LEADERBOARD_REF, player, math.random(0, 1000), "Xyzzy")

    -- Print out all the global scores on the leaderboard:
    print("Global scores:")
    local leaderboard = Leaderboards.GetLeaderboard(LEADERBOARD_REF, LeaderboardType.GLOBAL)
    for k, v in pairs(leaderboard) do
        PrintLeaderboardEntry(v)
    end

    -- Print out all the daily scores on the leaderboard:
    print("Daily scores:")
    local leaderboard = Leaderboards.GetLeaderboard(LEADERBOARD_REF, LeaderboardType.DAILY)
    for k, v in pairs(leaderboard) do
        PrintLeaderboardEntry(v)
    end
end
local leaderboard = Leaderboards.GetLeaderboard(LEADERBOARD_REF, LeaderboardType.MONTHLY)
local leaderboard = Leaderboards.GetLeaderboard(LEADERBOARD_REF, LeaderboardType.WEEKLY)
```

See also: [Leaderboards.GetLeaderboard](leaderboards.md)

---
