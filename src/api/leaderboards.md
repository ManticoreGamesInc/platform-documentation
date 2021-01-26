---
id: leaderboards
name: Leaderboards
title: Leaderboards
tags:
    - API
---

# API: Leaderboards

## Description

The Leaderboards namespace contains a set of functions for retrieving and updating player leaderboard data. Use the Global Leaderboards tab in the Core Editor to configure leaderboards for your game. Then drag a leaderboard from the Global Leaderboards tab to a `NetReference` custom property for use with the Leaderboards API.

## API

### Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `Leaderboards.HasLeaderboards()` | `bool` | Returns `true` if any leaderboard data is available. Returns `false` if leaderboards are still being retrieved, or if there is no leaderboard data. | None |
| `Leaderboards.GetLeaderboard(NetReference leaderboardRef, LeaderboardType)` | `Array<LeaderboardEntry>` | Returns a table containing a list of entries for the specified leaderboard. The `NetReference` parameter should be retrieved from a custom property, assigned from the Global Leaderboards tab in the editor. This returns a copy of the data that has already been retrieved, so calling this function does not incur any additional network cost. If the requested leaderboard type has not been enabled for this leaderboard, an empty table will be returned. Supported leaderboard types include:<br/>`LeaderboardType.GLOBAL`<br/>`LeaderboardType.DAILY`<br/>`LeaderboardType.WEEKLY`<br/>`LeaderboardType.MONTHLY` | None |
| `Leaderboards.SubmitPlayerScore(NetReference leaderboardRef, Player player, Number score, [string additionalData])` | `None` | Submits a new score for the given Player on the specified leaderboard. The `NetReference` parameter should be retrieved from a custom property, assigned from the Global Leaderboards tab in the editor. This score may be ignored if the player already has a better score on this leaderboard. The optional `additionalData` parameter may be used to store a very small amount of data with the player's entry. If provided, this string must be 8 characters or fewer. (More specifically, 8 bytes when encoded as UTF-8.) | Server-Only |

## Examples

- `HasLeaderboards`

- `GetLeaderboard`

- `SubmitPlayerScore`

- `id`

- `name`

- `score`

- `additionalData`

The `Leaderboards` namespace contains a set of functions for retrieving and updating player leaderboard data.  This is a special kind of persistance that lets you save high scores for a game, with the data being associated with the game itself, rather than any particular player.

In order to use these functions, you must first create a Global Leaderboard in the Core editor.  (Select Global Leaderboards, under the **Window** menu.)

```lua
function PrintLeaderboardEntry(entry)
    print(string.format("%s (%s): %d [%s]", entry.name, entry.id, entry.score, entry.additionalData))
end

-- To create this reference, create a custom property of type 'netreference',
-- and drag a leaderboard into it, from the Global Leaderboards tab:
local propLeaderboardRef = script:GetCustomProperty("LeaderboardRef")

-- Verify that we actually have leaderboard data to load:
if (Leaderboards.HasLeaderboards()) then
    -- Save a score to the leaderboard:
    Leaderboards.SubmitPlayerScore(propLeaderboardRef, player, math.random(0, 1000), "Xyzzy")

    -- Print out all the global scores on the leaderboard:
    print("Global scores:")
    local leaderboard = Leaderboards.GetLeaderboard(propLeaderboardRef, LeaderboardType.GLOBAL)
    for k, v in pairs(leaderboard) do
        PrintLeaderboardEntry(v)
    end

    -- Print out all the daily scores on the leaderboard:
    print("Daily scores:")
    local leaderboard = Leaderboards.GetLeaderboard(propLeaderboardRef, LeaderboardType.DAILY)
    for k, v in pairs(leaderboard) do
        PrintLeaderboardEntry(v)
    end
end
local leaderboard = Leaderboards.GetLeaderboard(propLeaderboardRef, LeaderboardType.MONTHLY)
local leaderboard = Leaderboards.GetLeaderboard(propLeaderboardRef, LeaderboardType.WEEKLY)
```

---
