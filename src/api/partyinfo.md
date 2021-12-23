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
| `GetTags()` | `Array`<`string`> | Returns an array of the party's tags. | None |
| `GetMemberIds()` | `Array`<`string`> | Returns an array of the player IDs of the party's members. | None |
| `IsFull()` | `boolean` | Returns `true` if the party is at maximum capacity. | None |

## Examples

Example using:

### `id`

### `name`

### `partySize`

### `maxPartySize`

### `partyLeaderId`

### `isPlayAsParty`

### `isPublic`

### `GetTags`

### `GetMemberIds`

### `IsFull`

This example, when a player joins the game we print all information about their party into the Event Log.

```lua
function PrintPartyInfo(partyInfo)
    print("Party Info")
    print("id: " .. partyInfo.id)
    print("name: " .. partyInfo.name)
    print("partySize: " .. partyInfo.partySize)
    print("maxPartySize: " .. partyInfo.maxPartySize)
    print("partyLeaderId: " .. partyInfo.partyLeaderId)
    print("isPlayAsParty: " .. tostring(partyInfo.isPlayAsParty))
    print("isPublic: " .. tostring(partyInfo.isPublic))
    print("Tags: " .. JoinStrings(partyInfo:GetTags()))
    print("MemberIds: " .. JoinStrings(partyInfo:GetMemberIds()))
    print("IsFull: " .. tostring(partyInfo:IsFull()))
end

function JoinStrings(arrayOfStrings)
    return CoreString.Join(",", table.unpack(arrayOfStrings))
end

function OnPlayerJoined(player)
    print("=== Player " .. player.name .. " joined ===")
    if player.isInParty then
        local partyInfo = player:GetPartyInfo()
        PrintPartyInfo(partyInfo)
    else
        print("They are not in a party.")
    end
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

See also: [Player.GetPartyInfo](player.md) | [Game.playerJoinedEvent](game.md)

---

Example using:

### `partyLeaderId`

### `isPlayAsParty`

This example, we setup a portal that allows any member of a party to enter the portal and take the entire party with them, instead of going by themselves.

```lua
local TRIGGER = script.parent
local GAME_ID = "b983bc/core-plaza"

function PortalPlayerToGame(player)
    if player.isInParty then
        local partyInfo = player:GetPartyInfo()
        if partyInfo.isPlayAsParty then
            -- Change the player reference to point at the leader of the party
            player = Game.FindPlayer(partyInfo.partyLeaderId)
        end
    end
    -- Send the player to the destination game
    player:TransferToGame(GAME_ID)
end

TRIGGER.beginOverlapEvent:Connect(function(_, player)
    if player:IsA("Player") then
        PortalPlayerToGame(player)
    end
end)
```

See also: [Player.GetPartyInfo](player.md) | [Trigger.beginOverlapEvent](trigger.md) | [Other.IsA](other.md)

---
