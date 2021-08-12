---
id: party_system
name: Party System
title: Party System
tags:
    - Reference
---

# Party System

## Overview

The **Party System** allows players to form groups that move through the Multiverse together, joining the same server instance of any game with sufficient player count. Creators have access to whether a player in their game is part of a party, and whether or not they are the leader of that party, to customize the name and description.

A party has a leader that can move all the members of a party to the same instance of a any game.

## Party Settings for Players

Party leaders can set a variety of settings in the Party Tab of the social menu.

- If the **Play with Party** setting is enabled, then the party members will automatically go to whatever game instance the leader goes to. If *Play with Party* is disabled, players can play different games while remaining part of the party.
- Parties can also be made **Public**, which will allow other users to join them. The **Party Name** and **Genre Tags** describe what their party will be doing and playing.
- A player who is not in a party can use the **Party Tab** to search for a public party that matches what they are looking for.

## Player Party Information

Each player has a set of properties and functions to retrieve data about their party.bCreators can check if a player is in a party and if they are the party leader using the `.isInParty` and `.isPartyLeader` properties. Creators can also determine if two players are in the same party using the `IsInPartyWith` function.

### Moving an Entire Party to a Child Game

For creators who use `TransferToGame` to move players between Child Games or Scenes, all players in a party can be moved together by moving the party leader to the child game. See the [Player section of the Core API](../api/player.md) for examples.

--

## Learn More

[Party System Examples on the Core Lua API](../api/player.md)
