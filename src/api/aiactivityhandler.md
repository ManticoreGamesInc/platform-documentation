---
id: aiactivityhandler
name: AIActivityHandler
title: AIActivityHandler
tags:
    - API
---

# AIActivityHandler

AIActivityHandle is a CoreObject which can manage one or more `AIActivity`. Each tick, the handler calls a function on each of its registered activities to give them a chance to reevaluate their priorities. It then ticks the highest priority activity again, allowing it to perform additional work.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `isSelectedInDebugger` | `boolean` | True if this activity handler is currently selected in the AI Debugger. | Read-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `AddActivity(string name, [table functions])` | [`AIActivity`](aiactivity.md) | Creates a new AIActivity registered to the handler with the given unique name and optional functions. Raises an error if the provided name is already in use by another activity in the same handler. `functions` may contain the following:<br>`tick - function(number deltaTime)`: Called for each activity on each tick by the handler, expected to adjust the priority of the activity.<br>`tickHighestPriority - function(number deltaTime)`: Called after `tick` for whichever activity has the highest priority within the handler.<br>`start - function()`: Called between `tick` and `tickHighestPriority` when an activity has become the new highest priority activity within the handler.<br>`stop - function()`: Called when the current highest priority activity has been removed from the handler or is otherwise no longer the highest priority activity. | None |
| `RemoveActivity(string name)` | `None` | Removes the activity with the given name from the handler. Logs a warning if no activity is found with that name. If the named activity is currently the highest priority activity in the handler, its `stop` function will be called. | None |
| `ClearActivities()` | `None` | Removes all activities from the handler. Calls the `stop` function for the highest priority activity. | None |
| `GetActivities()` | `Array<`[`AIActivity`](aiactivity.md)`>` | Returns an array of all of the handler's activities. | None |
| `FindActivity(string name)` | [`AIActivity`](aiactivity.md) | Returns the activity with the given name, or `nil` if that name is not found in the handler. | None |

## Examples

Example using:

### `AddActivity`

### `elapsedTime`

### `priority`

The AI Activity system is a way to define multiple activities that each have `start`, `update` and `stop` functions. A priority defines which activity is active. In this example, a basic game loop with lobby, round and game over is implemented using the AI Activity component.

```lua
local ACTIVITY_HANDLER = script.parent

local LOBBY_DURATION = 7
local MIN_PLAYERS_TO_START = 1
local SCORE_TO_WIN = 5
local GAME_OVER_DURATION = 5

local isLobby = false
local isRound = false
local isGameOver = false

local Lobby = {}
local Round = {}
local GameOver = {}

-- Lobby

-- Called every frame for all activities, usually used to set the priority
function Lobby.tick(activity, deltaTime)
    if isLobby
    and activity.elapsedTime >= LOBBY_DURATION
    and #Game.GetPlayers() >= MIN_PLAYERS_TO_START then
        activity.priority = 0

    elseif not isRound then
        activity.priority = 200
    end
end
-- Called when this activity first becomes the highest priority
function Lobby.start(activity)
    print("Lobby start")

    isLobby = true
end
-- called when this was the highest priority, and a different activity has just taken over
function Lobby.stop(activity)
    print("Lobby stop")

    isLobby = false
end

-- Round

-- Called every frame for all activities, usually used to set the priority
function Round.tick(activity, deltaTime)
    activity.priority = 100
end
-- called when this activity first becomes the highest priority
function Round.start(activity)
    print("Round start")

    Game.StartRound()
    isRound = true
end
-- called when this was the highest priority, and a different activity has just taken over
function Round.stop(activity)
    print("Round stop")

    Game.EndRound()
    isRound = false
end

-- Game Over

-- Called every frame for all activities, usually used to set the priority
function GameOver.tick(activity, deltaTime)
    local team1Win = Game.GetTeamScore(1) >= SCORE_TO_WIN
    local team2Win = Game.GetTeamScore(2) >= SCORE_TO_WIN
    if team1Win or team2Win then
        activity.priority = 300
    else
        activity.priority = 0
    end
end
-- called after all activities have tick'd, but only for the activity with the highest priority
function GameOver.tickHighestPriority(activity, deltaTime)
    if activity.elapsedTime >= GAME_OVER_DURATION then
        -- Reset scores
        Game.SetTeamScore(1, 0)
        Game.SetTeamScore(2, 0)
    end
end
-- called when this activity first becomes the highest priority
function GameOver.start(activity)
    print("GameOver start")

    isGameOver = true
end
-- called when this was the highest priority, and a different activity has just taken over
function GameOver.stop(activity)
    print("GameOver stop")

    isGameOver = false
end

ACTIVITY_HANDLER:AddActivity("Lobby", Lobby)
ACTIVITY_HANDLER:AddActivity("Round", Round)
ACTIVITY_HANDLER:AddActivity("GameOver", GameOver)

-- For testing: Click left mouse button to score 1 point
Game.playerJoinedEvent:Connect(function(player)
    player.bindingPressedEvent:Connect(function(player, action)
        if action == "ability_primary" then
            print("Goal!")
            Game.IncreaseTeamScore(player.team, 1)
        end
    end)
end)
```

See also: [CoreObject.parent](coreobject.md) | [Game.GetPlayers](game.md) | [Player.bindingPressedEvent](player.md)

---
