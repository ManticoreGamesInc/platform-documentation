---
id: spawnpoints
name: Spawn Points in Core
title: Spawn Points in Core
tags:
    - Reference
---

# Spawn Point Reference

## Overview

## Spawn Points

## Create a Spawn Point

### Properties

The **Team** property determines what team the players that spawn at this spawn point will be on.

The **Key** property acts as an identifier for a spawn point. The value of the **Key** does not have to be unique, multiple spawn points can share the same **Key** value. When using the `Spawn` command a `spawnKey` parameter can be passed into the `Spawn` command. An example of how the `spawnKey` paramter is used, can be found below.

```lua
function OnJoin(player)
    player:Spawn({spawnKey="Spawn Key 1"})
end
Game.playerJoinedEvent:Connect(OnJoin)
```

The code snippet above will cause all players that join the game to randomly spawn at a spawn point with a **Key** value of "Spawn Key 1".

The **Player Scale Multiplier** controls how much larger or smaller players will be when they spawn at this spawn point. A value greater than 1 will make the players larger. A value smaller than 1 will make the players smaller.

The **Spawn Template** property is an asset reference property that refers to an asset that will be spawned whenever a player spawns at this spawn point.

## Spawn Settings

### Create Spawn Settings

### Properties

#### Spawn Properties

The **Start Spawned** property

The **Spawn Key** property

#### Respawn Properties

The **Respawn Mode** property

The **Respawn Key** property

The **Respawn Delay** property
