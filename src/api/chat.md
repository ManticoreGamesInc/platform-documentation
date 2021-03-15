---
id: chat
name: Chat
title: Chat
tags:
    - API
---

# Chat

The Chat namespace contains functions and hooks for sending and reacting to chat messages.

## Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `Chat.BroadcastMessage(string message, [table optionalParameters])` | <[`BroadcastMessageResultCode`](enums.md#broadcastmessageresultcode), string errorMessage`>` | Sends a chat message to players. Messages sent from the server have a rate limit of 10 messages per second. Maximum message length is 280 characters. Messages exceeding that length will be cropped.<br />Optional parameters: `players` (Player or Array<Player>): A list of players who should receive the message. Defaults to all players in the game. | Server-Only |
| `Chat.LocalMessage(string message)` | <[`BroadcastMessageResultCode`](enums.md#broadcastmessageresultcode), string errorMessage`>` | Sends a chat message to the local player. Maximum message length is 280 characters. There is no rate limit for local messages. | Client-Only |

## Hooks

| Hook Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `receiveMessageHook` | `Hook<`[`Player`](player.md), speaker, table parameters`>` | Hook called when receiving a chat message from a Player. The `parameters` table contains a `string` named "message" containing the text of the message received, and a `string` named "speakerName" with the name of the message sender as it will be displayed in the chat window. Replacing "message" with an empty string will cancel receipt of the message. | None |
| `sendMessageHook` | `Hook<table parameters>` | Hook called when sending a chat message. The `parameters` table contains a `string` named "message" containing the text of the message to be sent. Replacing "message" with an empty string will cancel sending the message. | None |

## Examples

Example using:

### `BroadcastMessage`

### `receiveMessageHook`

`Chat.BroadcastMessage` allows you to send mesages directly to the chat log. This sample listens for users who type `/coinflip`, and will print the results of the coinflip to everyone's chat.

```lua
function CoinFlipChecker(speaker, params)
local message = string.lower(params.message)
if message == "/coinflip" then
    local result = "heads"
    if math.random() > 0.5 then result = "tails" end
    Chat.BroadcastMessage(string.format("%s flipped a coin, and it came up %s!", speaker.name, result))
end
end

Chat.receiveMessageHook:Connect(CoinFlipChecker)
```

See also: [Chat.sendMessageHook](chat.md)

---

Example using:

### `receiveMessageHook`

`Chat.receiveMessageHook` allows the system to respond when chat messages are received. It executes first on the server, and then on all of the clients once the message is broadcast.

Being a hook, it is possible to modify contents of the triggering message. This sample demonstrates this by scanning all incoming chats for words in a "bad words" list, and blanks them out.

```lua
-- Put our bad words into a table for easy access.  Note that
-- we're using the word as the key, instead of the value, for
-- faster lookup!
local badwordList = {["dang"] = true, ["darn"] = true, ["heck"] = true}

function WordFilter(s)
if badwordList[s:lower()] ~= nil then
    return string.rep("#", s:len())
end
end

function CheckForBlockedWords(speaker, params)
local res = string.gsub(params.message, "%a+", WordFilter)
print(res)
params.message = res
end

Chat.receiveMessageHook:Connect(CheckForBlockedWords)
```

See also: [Chat.sendMessageHook](chat.md)

---

Example using:

### `sendMessageHook`

### `LocalMessage`

`Chat.sendMessageHook` is triggered on the client every time a player tries to send a chat message. Modifications happen before the message is even sent on to the server.

`Chat.LocalMessage` is similar to `Chat.BroadcastMessage`, but the resulting chat is only visible by the local player.

```lua
-- This needs to be in a client context. Chat.LocalMessage only
-- sends to the local player.
function WhoCommand(params)
local message = string.lower(params.message)
if message == "/who" then
    local result = "Current players:\n  "
    for _, p in ipairs(Game.GetPlayers()) do
        result = result .. p.name .. "\n  "
    end
    Chat.LocalMessage(result)
    params.message = ""
end
end

Chat.sendMessageHook:Connect(WhoCommand)
```

See also: [Chat.receiveMessageHook](chat.md)

---
