---
id: event
name: Event
title: Event
tags:
    - API
---

# Event

Events appear as properties on several objects. The goal is to register a function that will be fired whenever that event happens. E.g. `playerA.damagedEvent:Connect(OnPlayerDamaged)` chooses the function `OnPlayerDamaged` to be fired whenever `playerA` takes damage.

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Connect(function eventListener, [...])` | [`EventListener`](eventlistener.md) | Registers the given function which will be called every time the event is fired. Returns an EventListener which can be used to disconnect from the event or check if the event is still connected. Accepts any number of additional arguments after the listener function, those arguments will be provided after the event's own parameters. | None |

## Examples

Using:

- `Connect`

Core uses events for a variety of built-in state changes that can happen in a game. Events appear as properties on several objects. By connecting a function to the desired event, scripts can listen and act on them. In this example, both `Game.playerJoinedEvent` and `player.damagedEvent` are connected to. The `OnPlayerDamaged()` function will be called each time a player takes damage. Any number of extra parameters can be added when connecting and those values will be passed back to the listening function.

```lua
function OnPlayerDamaged(player, dmg, joinTime)
    local elapsedTime = time() - joinTime
    print("Player " .. player.name .. " took " .. dmg.amount .. " damage after joining the game for " .. elapsedTime .. " seconds.")
end

function OnPlayerJoined(player)
    -- Passing extra float parameter
    player.damagedEvent:Connect(OnPlayerDamaged, time())
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

See also: [CoreLua.time](coreluafunctions.md) | [Player.name](player.md) | [Damage.amount](damage.md) | [Game.playerJoinedEvent](game.md)

---
