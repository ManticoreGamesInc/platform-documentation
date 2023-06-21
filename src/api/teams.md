---
id: teams
name: Teams
title: Teams
tags:
    - API
---

# Teams

The Teams namespace contains a set of class functions for dealing with teams and team settings.

## Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `Teams.AreTeamsEnemies(integer team1, integer team2)` | `boolean` | Returns true if teams are considered enemies under the current TeamMode. If either team is TEAM_NEUTRAL=0, returns false. | None |
| `Teams.AreTeamsFriendly(integer team1, integer team2)` | `boolean` | Returns true if teams are considered friendly under the current TeamMode. If either team is TEAM_NEUTRAL=0, returns true. | None |
| `Teams.SetTeamMode(TeamMode team_mode)` | `None` | Set the current team mode. | Server-Only |
| `Teams.GetTeamMode()` | [`TeamMode`](enums.md#teammode) | Get the current team mode. | None |

## Examples

Example using:

### `AreTeamsEnemies`

### `AreTeamsFriendly`

In this example, a loop is done over 5 teams to see which are friendly, and which are enemies. Both functions can be used in a client script and server script.

Team 0 is always considered neutral.

```lua
-- Client script
local localPlayer = Game.GetLocalPlayer()
local playerTeam = localPlayer.team

for i = 0, 4 do
    if Teams.AreTeamsEnemies(playerTeam, i) then
        print("You are enemies with team: " .. tostring(i))
    elseif Teams.AreTeamsFriendly(playerTeam, i) then
        print("You are friendly with team: " .. tostring(i))
    end
end
```

See also: [Game.GetLocalPlayer](game.md) | [Player.team](player.md) | [CoreLua.print](coreluafunctions.md)

---
