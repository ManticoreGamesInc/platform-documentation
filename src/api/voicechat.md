---
id: voicechat
name: VoiceChat
title: VoiceChat
tags:
    - API
---

# VoiceChat

The VoiceChat namespace contains functions for controlling voice chat in a game.

## Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `VoiceChat.SetVoiceChatMode(VoiceChatMode)` | `none` | Enables or disables voice chat in the current game. | Server-Only |
| `VoiceChat.GetVoiceChatMode()` | [`VoiceChatMode`](enums.md#voicechatmode) | Returns the current voice chat mode. | None |

## Examples

Example using:

### `SetVoiceChatMode`

### `GetVoiceChatMode`

This example shows to switch the Voice Chat Mode.

Only an admin player can change the mode for the server by pressing 1, 2, or 3.  When the mode has changed, all players in the game will be notified in chat.

```lua
-- Name of the player who is allowed to change the voice chat mode.
-- Set this up as a custom property called "adminName" on the script.

local ADMIN_NAME = script:GetCustomProperty("adminName")

-- Will hold the binding event for the admin player.

local adminBindingEvt = nil

-- Handler for the binding pressed event.

function OnBindingPressed(player, binding)

    -- Key 1 changes the mode to TEAM.

    if(binding == "ability_extra_1") then
        VoiceChat.SetVoiceChatMode(VoiceChatMode.TEAM)

        Chat.BroadcastMessage("Voice Chat Mode set to TEAM")

    -- Key 2 changes the mode to ALL.

    elseif(binding == "ability_extra_2") then
        VoiceChat.SetVoiceChatMode(VoiceChatMode.ALL)

        Chat.BroadcastMessage("Voice Chat Mode set to ALL")

    -- Key 3 changes the mode to NONE.

    elseif(binding == "ability_extra_3") then
        VoiceChat.SetVoiceChatMode(VoiceChatMode.NONE)

        Chat.BroadcastMessage("Voice Chat Mode set to NONE")
    end
end

-- Handler for the player joined event.

function OnPlayerJoined(player)

    -- Check if the player joining the game is the admin player
    -- so the binding event can be setup just for them.

    if player.name == ADMIN_NAME then
        adminBindingEvt = player.bindingPressedEvent:Connect(OnBindingPressed)
    end
end

-- When a player leaves the game, check if it was the admin player so
-- the binding event can be disconnected.

function OnPlayerLeft(player)
    if(player.name == ADMIN_NAME and adminBindingEvt ~= nil and adminBindingEvt.isConnected) then
        adminBindingEvt:Disconnect()
        adminBindingEvt = nil
    end
end

-- Bind the joined and left events

Game.playerJoinedEvent:Connect(OnPlayerJoined)
Game.playerLeftEvent:Connect(OnPlayerLeft)
```

See also: [EventListener.Disconnect](eventlistener.md) | [Game.playerJoinedEvent](game.md) | [Chat.BroadcastMessage](chat.md) | [Player.bindingPressedEvent](player.md)

---
