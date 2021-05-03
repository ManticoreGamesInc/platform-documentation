---
id: playertransferdata
name: PlayerTransferData
title: PlayerTransferData
tags:
    - API
---

# PlayerTransferData

PlayerTransferData contains information indicating how a player joined or left a game, and their next or previous game ID if they're moving directly from one game to another. Players may opt out of sharing this information by selecting "Hide My Gameplay Activity" or "Appear Offline" in the social panel settings.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `reason` | [`PlayerTransferReason`](enums.md#playertransferreason) | Indicates how the player joined or left a game. | Read-Only |
| `gameId` | `string` | The ID of the game the player joined from or left to join. Returns `nil` if the player joined while not already connected to a game or left for a reason other than joining another game. Also returns `nil` if the player has opted out of sharing this information. | Read-Only |
