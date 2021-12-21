---
id: coreplayerprofile
name: CorePlayerProfile
title: CorePlayerProfile
tags:
    - API
---

# CorePlayerProfile

Public account profile for a player on the Core platform.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `id` | `string` | The ID of the player. | Read-Only |
| `name` | `string` | The name of the player. This field does not reflect changes that may have been made to the `name` property of a `Player` currently in the game. | Read-Only |
| `description` | `string` | A description of the player, provided by the player in the About section of their profile. | Read-Only |

## Examples

Example using:

### `id`

### `name`

### `description`

This client script example fetches the profile of the game's creator and uses information from it to print a welcome message into the chat window.

```lua
local GAME_NAME = "Example Simulator"
local CREATOR_ID = "c19fdb85adf94580b1f926764560682e"

local player = Game.GetLocalPlayer()

local creatorProfile = CorePlatform.GetPlayerProfile(CREATOR_ID)

if CREATOR_ID ~= creatorProfile.id then
    error("Received the wrong profile, for some reason.")
end

Chat.LocalMessage("Hi " .. player.name .. "!")
Chat.LocalMessage("welcome to " .. GAME_NAME)
Chat.LocalMessage("by " .. creatorProfile.name)
Chat.LocalMessage(creatorProfile.description)
```

See also: [CorePlatform.GetPlayerProfile](coreplatform.md) | [Chat.LocalMessage](chat.md) | [Game.GetLocalPlayer](game.md) | [Player.name](player.md)

---

## Learn More

[CorePlatform.GetPlayerProfile()](coreplatform.md)
