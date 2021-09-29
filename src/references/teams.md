---
id: teams_reference
name: Teams Reference
title: Teams Reference
tags:
    - Reference
---

# Teams

## Summary

There can be different team modes in games, for example, players working together in a team to accomplish a goal (co-operative, team objective), or where all players are fighting against each other (deathmatch, free for all).

When creating a new project, the default mode will be **Friendly**. This means that players will not be able to apply damage to each other.

## Team Settings

To change the team mode for a game, a **Team Settings** object can be added to the **Hierarchy** where the **Team Mode** can be changed. This can be found in **Core Content**, under **Settings Objects**.

![Team Settings](../img/Scenes/team_settings.png){: .center loading="lazy" }

### Team Mode

On the **Team Settings** object, there is a drop down for the **Team Mode** that controls how players are assigned to teams.

| Mode | Description |
| ---- | ----------- |
| Free For All | Players are hostile to all other players. |
| Team Versus | Player are assigned to teams that are hostile to each other. |
| Friendly | Players are friendly to all other players. |

There can be a maximum of 4 teams with **Team Versus** mode, and each player that joins the game is randomly assigned to a team. This means that teams could become uneven due to the random team assigning. This can be solved from Lua using a script, or using the **Team Autobalance** component.

## Spawn Points

If the **Team Mode** on the **Team Settings** object is set to **Team Versus**, additional spawn points will be needed to create the teams (maximum of 4 teams). If only one spawn point is in the **Hierarchy**, or the **Team** property is the same for all spawn points, then all players will be on the same team.

See the [Spawn Points](/references/spawnpoints.md) for more information.

## Team Autobalancer

The **Team Autobalancer** component in **Game Components** will help split up players between the number of teams specified.

| Property | Description |
| ---- | ----------- |
| TeamCount | How many teams does this game have. We assume they are teams 1 through this number. |
| MaxTeamSizeDifference | Team can be at most this different in size before players will get swapped if they are eligible. |
| OnlySwitchDeadPlayers | Only switch players who are already dead. |
| KillOnTeamSwitch | If we can swap live players, kill them when we do. |
| ScrambleAtRoundEnd | Also scramble teams entirely t the end of the round. |

![Team Autobalancer](../img/Scenes/team_autobalancer.png){: .center loading="lazy" }

## CoreMesh Team Settings

Meshes have a couple of properties that can be used with teams.

| Property | Description |
| ---- | ----------- |
| Team | A team number can be set which can be accessed from a script in Lua using the `team` property. |
| Use Team Color | The color of the object will change to the color of the team the player is on. Blue for same team, red for enemy team. |
| Enable Team Collision | If enabled, the object will have collision for players on the same team as the team property. |
| Enable Enemy Collision | If enabled, the object will have collision for players on the enemy team. |

![CoreMesh Settings](../img/Scenes/mesh_settings.png){: .center loading="lazy" }

Example of detecting which team an object is on by accessing the `team` property.

```lua
local MESH = script:GetCustomProperty("Mesh"):WaitForObject()
local DAMAGEABLE = MESH:FindAncestorByType("Damageable")

local function OnDamaged(obj, damage)
    if Object.IsValid(damage.sourcePlayer) then
        print("Object is on team:", MESH.team, "Player is on team:", damage.sourcePlayer.team)
    end
end

if Object.IsValid(DAMAGEABLE) then
    DAMAGEABLE.damagedEvent:Connect(OnDamaged)
end
```

<div class="mt-video" style="width:100%">
    <video autoplay muted playsinline controls loop class="center" style="width:100%">
        <source src="/img/Teams/team_example.mp4" type="video/mp4" />
    </video>
</div>

## Team Chat

The **Game Settings** object has settings to control how teams can communicate with each other.

### Game Chat

The game chat category in the **Properties** panel has an option to change the **Chat Mode**. By default, this is set to **Team and All**.

| Mode | Description |
| ---- | ----------- |
| None | Chat is disabled and can't be used by players. |
| Team Only | Only players on the same team can communicate with each other. |
| Team and All | Players have the option to switch the channel between Team and All with ++tab++. |
| All Only | All players can communicate with each other. |

![Game Chat](../img/Scenes/game_chat.png){: .center loading="lazy" }

### Voice Chat

The voice chat category in the **Properties** panel has an option to change the **Voice Chat Mode**. By default this is set to **All**.

| Mode | Description |
| ---- | ----------- |
| None | Voice chat is disabled and can't be used by players. |
| Team Only | Only players on the same team can communicate with each other using Voice Chat. |
| All | All players in the game can communicate with each other using Voice Chat. |

![Voice Chat](../img/Scenes/voice_chat.png){: .center loading="lazy" }

## Teams Namespace

The **Teams** namespace in the Lua API has some functions that can be used from a Lua script to determine if specific teams are enemies or friendly.

See the [Teams](/api/teams.md) namespace for more information.

## Game Namespace

The **Game** namespace in the Lua API has functions that can be used to handle team scoring.

See the [Game](/api/game.md) namespace for more information.

## Player Object

The **Player** object in the Lua API has a `team` property that can be accessed from a Lua script to retrieve the current team the player is on.

For example, getting the team the player is on when they join the game.

```lua
Game.playerJoinedEvent:Connect(function(player)
    print("Player is on team:", player.team, player.name)
end)
```

See the [Player](/api/player.md) object for more information.

## Learn More

[Spawn Points](/references/spawnpoints.md) | [Teams](/api/teams.md) | [Game](/api/game.md) | [Player](/api/player.md) | [Voice Chat](/references/voice_chat.md)
