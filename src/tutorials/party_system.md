---
id: party_system
name: Party System
title: Party System
tags:
    - Reference
---

# Party System Reference

## Overview

**Party System** allow players to easily join games with a group of people. A party has a leader that can move all the members of a party from one game to another. 

## Player's Party Information

Each player has a set of properties and functions to retrieve data about their party. You can know if a player is inside a party and if he is a party leader using the `.isInParty` and `.isPartyLeader` properties. You can also determine if two players are in the same party using the `player:IsInPartyWith(other)` method.

If your game has two teams, you can for example use this to force them to be on the same team.

## Party Properties

The function `player:GetPartyInfo()` returns an `PartyInfo` object that contains several properties about the current party of the player.

| Property                                 | Description |
| ---------------------------------------- | ----------- |
| **id**                                   | The Party id. |
| **name**                                 | The Party name. |
| **partySize**                            | The size of the Party. |
| **maxPartySize**                         | The maximum size of the Party. |

| Functions                                | Description |
| ---------------------------------------- | ----------- |
| **GetMembersIds()**                      | Returns the list of members ids. |
| **GetTags()**                            | Returns the list of tags of this Party. |
| **IsFull()**                             | Returns true if **maxPartySize** is reached. |

---

## Learn More

[Party System Examples on the Core Lua API](../api/player.md)
