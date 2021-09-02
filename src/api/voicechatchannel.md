---
id: voicechatchannel
name: VoiceChatChannel
title: VoiceChatChannel
tags:
    - API
---

# VoiceChatChannel

A VoiceChatChannel represents a channel in voice chat, which may be used to find which players are in the channel and mute or unmute players.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `name` | `string` | The name of this channel. | Read-Only |
| `channelType` | [`VoiceChannelType`](enums.md#voicechanneltype) | This channel's type. | Read-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetPlayers()` | `Array<`[`Player`](player.md)`>` | Returns a list of players in this channel. | None |
| `IsPlayerInChannel(Player)` | `boolean` | Returns `true` if the given player is in this channel, otherwise returns `false`. | None |
| `IsPlayerMuted(Player)` | `boolean` | Returns `true` if the given player is muted in this channel, otherwise returns `false`. | None |
| `MutePlayer(Player)` | `none` | Mutes the given player in this channel. | Server-Only |
| `UnmutePlayer(Player)` | `none` | Unmutes the given player in this channel. | Server-Only |
