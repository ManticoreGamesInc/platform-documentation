---
id: corefriendcollectionentry
name: CoreFriendCollectionEntry
title: CoreFriendCollectionEntry
tags:
    - API
---

# CoreFriendCollectionEntry

Represents a single friend in a [CoreFriendCollection](corefriendcollection.md).

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `id` | `string` | The ID of the friend. | Read-Only |
| `name` | `string` | The name of the friend. | Read-Only |

## Examples

Example using:

### `id`

### `name`

In this example we get the first page of friends for each player who joins the game and print each friend's `name` and `id` into the Event Log window.

```lua
function OnPlayerJoined(player)
    print(player.name .. " friends:")
    
    local friendCollection = CoreSocial.GetFriends(player)
    local results = friendCollection:GetResults()
    
    for _,entry in ipairs(results) do
        print(entry.name .. ":" .. entry.id)
    end
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

See also: [CoreSocial.GetFriends](coresocial.md) | [CoreFriendCollection.GetResults](corefriendcollection.md) | [Game.playerJoinedEvent](game.md) | [Player.name](player.md)

---

## Learn More

[CoreSocial.GetFriends()](coresocial.md)
