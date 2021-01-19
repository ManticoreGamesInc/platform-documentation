---
id: teams
name: Teams
title: Teams
tags:
    - API
---

# Teams

## Description

The Teams namespace contains a set of class functions for dealing with teams and team settings.

## API

### Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `Teams.AreTeamsEnemies(Integer team1, Integer team2)` | `bool` | Returns true if teams are considered enemies under the current TeamMode. If either team is TEAM_NEUTRAL=0, returns false. | None |
| `Teams.AreTeamsFriendly(Integer team1, Integer team2)` | `bool` | Returns true if teams are considered friendly under the current TeamMode. If either team is TEAM_NEUTRAL=0, returns true. | None |
