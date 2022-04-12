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
| `VoiceChat.IsPlayerSpeaking(Player)` | `boolean` | Returns true if the given player is currently speaking in the game channel. | Client-Only |
| `VoiceChat.GetPlayerSpeakingVolume(Player)` | `number` | Returns a value from 0.0 to 1.0 to indicate how loudly the given player is speaking. | Client-Only |
| `VoiceChat.GetChannel(string channelName)` | [`VoiceChatChannel`](voicechatchannel.md) | Returns the channel with the given name, or `nil` if no such channel exists. | None |
| `VoiceChat.GetChannels()` | `Array`<[`VoiceChatChannel`](voicechatchannel.md)> | Returns a list of voice chat channels. | None |
| `VoiceChat.GetChannelsForPlayer(Player)` | `Array`<[`VoiceChatChannel`](voicechatchannel.md)> | Returns a list of voice chat channels that the given player is in. | None |
| `VoiceChat.IsPlayerInChannel(Player, string channelName)` | `boolean` | Returns `true` if the given player is in the specified channel, otherwise returns `false`. | None |
| `VoiceChat.MutePlayerInChannel(Player, string channelName)` | `none` | Mutes the given player in the specified channel. | Server-Only |
| `VoiceChat.UnmutePlayerInChannel(Player, string channelName)` | `none` | Unmutes the given player in the specified channel. | Server-Only |
| `VoiceChat.IsPlayerMutedInChannel(Player, string channelName)` | `boolean` | Returns `true` if the given player is muted in the specified channel, otherwise returns `false`. | None |
| `VoiceChat.HasMicrophone(Player player)` | `boolean` | Returns `true` if Core has detected a microphone for the given player, otherwise returns `false`. | None |
| `VoiceChat.IsVoiceChatEnabled(Player player)` | `boolean` | Returns `true` if the given player has enabled voice chat in their settings. | None |
| `VoiceChat.GetVoiceChatMethod()` | [`VoiceChatMethod`](enums.md#voicechatmethod) | Returns the method the local player has selected in their settings to activate voice chat. | Client-Only |

## Examples

Example using:

### `GetChannelsForPlayer`

### `MutePlayer`

### `UnmutePlayer`

In this example, players are muted when they die and unmuted when they respawn. While it's possible to mute a player in a specific channel, this example loops through all the channels a player participates in and mutes them in all.

```lua
function OnDied(player)
    for _,channel in ipairs(VoiceChat.GetChannelsForPlayer(player)) do
        channel:MutePlayer(player)
    end
end

function OnSpawned(player)
    for _,channel in ipairs(VoiceChat.GetChannelsForPlayer(player)) do
        channel:UnmutePlayer(player)
    end
end

Game.playerJoinedEvent:Connect(function(player)
    player.diedEvent:Connect(OnDied)
    player.spawnedEvent:Connect(OnSpawned)
end)
```

See also: [Game.playerJoinedEvent](game.md) | [Player.diedEvent](player.md)

---

Example using:

### `HasMicrophone`

### `IsVoiceChatEnabled`

### `GetVoiceChatMethod`

This client script demonstrates ways to detect the local player's access to voice chat. The results are print to screen and refreshed every 5 seconds. In case the player has their voice set to "Push-to-talk", the script figures out what key is bound to that action and provides it as information to the player.

```lua
local player = Game.GetLocalPlayer()

function UpdateVoiceStatus()
    local hasMic = VoiceChat.HasMicrophone(player)
    local voiceEnabled = VoiceChat.IsVoiceChatEnabled(player)
    local method = VoiceChat.GetVoiceChatMethod()

    UI.PrintToScreen("Has microphone: " .. tostring(hasMic))
    UI.PrintToScreen("Voice enabled: " .. tostring(voiceEnabled))
    UI.PrintToScreen("Voice method: " .. tostring(method))
    UI.PrintToScreen("")

    if not hasMic then
        UI.PrintToScreen("No microphone found")

    elseif not voiceEnabled then
        UI.PrintToScreen("Voice chat is disabled. Enable it in settings.")

    elseif method == VoiceChatMethod.PUSH_TO_TALK then
        local pttLabel = Input.GetActionInputLabel("PushToTalk")
        UI.PrintToScreen("Push-to-talk: " .. pttLabel)
    else
        UI.PrintToScreen("Open microphone")
    end
end

while true do
    UpdateVoiceStatus()
    Task.Wait(5)
end
```

See also: [Input.GetActionInputLabel](input.md) | [UI.PrintToScreen](ui.md) | [Game.GetLocalPlayer](game.md) | [Task.Wait](task.md)

---

Example using:

### `IsPlayerSpeaking`

In this example, a client context is setup with a UI Container and some UI Images underneath. This script finds all those images and assigns one to each player, setting the player's profile picture to appear in the image and tinting the image green whenever they speak.

```lua
-- Client Only
local IMAGES = script.parent:FindDescendantsByType("UIImage")

function Tick()
    for i,player in ipairs(Game.GetPlayers()) do
        local image = IMAGES[i]
        if image then
            image:SetPlayerProfile(player)

            if VoiceChat.IsPlayerSpeaking(player) then
                -- If this player is speaking, tint their picture green
                image:SetColor(Color.GREEN)
            else
                -- Otherwise, set their picture color back to normal
                image:SetColor(Color.WHITE)
            end
        end
    end
end
```

See also: [CoreObject.FindDescendantsByType](coreobject.md) | [UIImage.SetPlayerProfile](uiimage.md) | [Game.GetPlayers](game.md) | [Color.GREEN](color.md)

---

Example using:

### `SetVoiceChatMode`

### `GetVoiceChatMode`

This example shows how to change the Voice Chat Mode. It will only allow an admin player to change the mode for the server by pressing 1, 2, or 3. When the mode has changed, all players in the game will be notified in chat.

Changing mode could be done automatically. For example, in the lobby the mode could be set to **ALL** so all players can hear each other, but in game it could be set to **TEAM** so only players on the same team can hear each other. This could be handy when discussing tactics.

```lua
-- Binding actions for the keys.
-- You can create 3 bindings in the Binding Manager.
local ACTION_NAME_1 = script:GetCustomProperty("ActionName1")
local ACTION_NAME_2 = script:GetCustomProperty("ActionName2")
local ACTION_NAME_3 = script:GetCustomProperty("ActionName3")

-- Name of the player who is allowed to change the voice chat mode.
-- Set this up as a custom property called "adminName" on the script.
local ADMIN_NAME = script:GetCustomProperty("adminName")

-- Will hold the binding event for the admin player.
local adminBindingEvt

function OnActionPressed(player, action)
    -- Action 1 changes the mode to TEAM.
    if action == ACTION_NAME_1 then
        VoiceChat.SetVoiceChatMode(VoiceChatMode.TEAM)

        Chat.BroadcastMessage("Voice Chat Mode set to TEAM")

    -- Action 2 changes the mode to ALL.
    elseif action == ACTION_NAME_2 then
        VoiceChat.SetVoiceChatMode(VoiceChatMode.ALL)

        Chat.BroadcastMessage("Voice Chat Mode set to ALL")

    -- Action 3 changes the mode to NONE.
    elseif action == ACTION_NAME_3 then
        VoiceChat.SetVoiceChatMode(VoiceChatMode.NONE)
        Chat.BroadcastMessage("Voice Chat Mode set to NONE")
    end
end

-- Handler for the player joined event.
function OnPlayerJoined(player)
    -- Check if the player joining the game is the admin player
    -- so the action pressed event can be setup just for them.
    if player.name == ADMIN_NAME then
        adminBindingEvt = Input.actionPressedEvent:Connect(OnActionPressed)
    end
end

-- When a player leaves the game, check if it was the admin player so
-- the binding event can be disconnected.
function OnPlayerLeft(player)
    if player.name == ADMIN_NAME and adminBindingEvt ~= nil and adminBindingEvt.isConnected then
        adminBindingEvt:Disconnect()
        adminBindingEvt = nil
    end
end

-- Bind the joined and left events
Game.playerJoinedEvent:Connect(OnPlayerJoined)
Game.playerLeftEvent:Connect(OnPlayerLeft)
```

See also: [EventListener.Disconnect](eventlistener.md) | [Game.playerJoinedEvent](game.md) | [Chat.BroadcastMessage](chat.md) | [Input.actionPressedEvent](input.md) | [CoreObject.GetCustomProperty](coreobject.md)

---
