---
id: leaderboardentry
name: LeaderboardEntry
title: LeaderboardEntry
tags:
    - API
---

# API: LeaderboardEntry

## Description

A data structure containing a player's entry on a leaderboard. See the `Leaderboards` API for information on how to retrieve or update a `LeaderboardEntry`.

## API

### Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `id` | `string` | The ID of the `Player` whose entry this is. | Read-Only |
| `name` | `string` | The name of the `Player` whose entry this is. | Read-Only |
| `score` | `Number` | The Player's score. | Read-Only |
| `additionalData` | `string` | Optional additional data that was submitted along with the Player's score. (See `Leaderboards.SubmitPlayerScore()` for more information.) | Read-Only |
