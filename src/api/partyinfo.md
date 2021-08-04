---
id: partyinfo
name: PartyInfo
title: PartyInfo
tags:
    - API
---

# PartyInfo

Contains data about a party, returned by Player:GetPartyInfo()

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `id` | `string` | The party ID. | Read-Only |
| `name` | `string` | The party name. | Read-Only |
| `partySize` | `integer` | The current size of the party. | Read-Only |
| `maxPartySize` | `integer` | The maximum size of the party. | Read-Only |
| `partyLeaderId` | `string` | The player ID of the party leader. | Read-Only |
| `isPlayAsParty` | `boolean` | When true, calls to `Player:TransferToGame()` made on the party leader will transfer all players in the party. | Read-Only |
| `isPublic` | `boolean` | Returns `true` if this party is public, meaning anyone can join. | Read-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetTags()` | `Array<string>` | Returns an array of the party's tags. | None |
| `GetMemberIds()` | `Array<string>` | Returns an array of the player IDs of the party's members. | None |
| `IsFull()` | `boolean` | Returns `true` if the party is at maximum capacity. | None |
