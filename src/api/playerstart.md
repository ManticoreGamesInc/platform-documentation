---
id: playerstart
name: PlayerStart
title: PlayerStart
tags:
    - API
---

# PlayerStart

PlayerStart is a CoreObject representing a spawn point for players.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `team` | `integer` | Determines which players are eligible to spawn/respawn at this point. | Read-Write |
| `playerScaleMultiplier` | `number` | The scale applied to a player that is spawned at this start point. | Read-Write |
| `spawnTemplateId` | `string` | The asset ID of a template spawned on clients when a player spawns at this start point. May be nil. | Read-Only |
| `key` | `string` | The key associated with this start point. | Read-Write |
| `shouldDecrowdPlayers` | `boolean` | When set to `true`, a collision check will be performed for spawning players to prevent them from overlapping with other players. | Read-Write |

## Examples

Example using:

### `team`

### `playerScaleMultiplier`

### `spawnKey`

In this example, 5 seconds after the game starts, all players will respawn at this spawnpoint. Also, all players will be twice as tall and be on team 1.

```lua
local playerStartSettings = script.parent

--All players that use this spawnpoint will be on team 1 when respawned
playerStartSettings.team = 1

--When a player spawns at this spawnpoint, they will be twice their normal size
playerStartSettings.playerScaleMultiplier = Vector3.New(2, 2, 2)

--Set the "spawnKey" of this spawn point so that it can be referenced when a player respawns
playerStartSettings.spawnKey = "FirstSpawnPoint"

function OnGameStarted()
    --Get a list of all players
    local players = Game.GetPlayers()

    --Wait 5 seconds before respawning all players at this spawn point
    Task.Wait(5)

    for _, player in ipairs(players) do
        player:Spawn({spawnKey="FirstSpawnPoint"})
    end
end

Game.roundStartEvent:Connect(OnGameStarted)
```

See also: [Player.Spawn](player.md) | [Task.Wait](task.md) | [Game.GetPlayers](game.md) | [CoreObject.parent](coreobject.md) | [Vector3.New](vector3.md)

---
