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
