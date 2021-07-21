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
| `id` | `string` | The party Id. | Read-Only |
| `name` | `string` | The party name. | Read-Only |
| `isFull` | `boolean` | If the party is at maximum capacity. | Read-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetTags()` | `Array<string>` | Returns an array of the party's tags. | None |
