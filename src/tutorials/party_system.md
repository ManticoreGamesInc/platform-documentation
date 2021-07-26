---
id: party_system
name: Party System
title: Party System
tags:
    - Reference
---

# Party System Reference

## Overview

**Party System** allow players to easily join games with a group of people. A party has a leader that can move all the members of a party to the same instance of a any game.

## Party Settings

Party leaders can set a variety of settings in the Party Tab of the social menu.

- If the "Play with Party" setting is on, then the party members will automatically go to whatever game instance the leader goes to. If this is off, then all party members can all join games independently.

- Parties can also be made public, which will allow other users to join them. Use Party names and Genre Tags to better describe your party.

- A player that is not in a party can use the Party Tab to search for a public party that matches what they are looking for.

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
