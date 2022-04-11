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
| `GetActivities()` | `Array`<[`AIActivity`](aiactivity.md)> | Returns an array of all of the handler's activities. | None |
| `FindActivity(string name)` | [`AIActivity`](aiactivity.md) | Returns the activity with the given name, or `nil` if that name is not found in the handler. | None |

## Examples

Example using:

### `AddActivity`

The AI Activity system is a way to define multiple activities that each have `start`, `update` and `stop` functions. A priority defines which activity is active. In this example, a basic game loop with lobby, round, and game over is implemented using the AI Activity component.

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
-- The Shoot action in the Binding Set will need to be networked for it to be detected on the server.
function OnActionPressed(player, action)
    if action == "Shoot" then
        print("Goal!")
        Game.IncreaseTeamScore(player.team, 1)
    end
end

Input.actionPressedEvent:Connect(OnActionPressed)
```

See also: [AIActivity.priority](aiactivity.md) | [CoreObject.parent](coreobject.md) | [Game.GetPlayers](game.md) | [Input.actionPressedEvent](input.md) | [Player.team](player.md)

---

Example using:

### `AddActivity`

### `RemoveActivity`

### `FindActivity`

In this example, an AI Activity Handler is added to a vehicle, with this script as a child of the Handler. The vehicle's AI is composed of two activities: 1) Drive forward. 2) Reverse in case it can't move.

```lua
local ACTIVITY_HANDLER = script.parent
local VEHICLE = script:FindAncestorByType("Vehicle")

local averageSpeed = 100
local centerHit
local leftHit
local rightHit

local reverseTimeRemaining = 0

local throttle = 0
local steering = 0

local drivingActivityTable = {}
local reverseActivityTable = {}

-- Driving forward activity
function drivingActivityTable.tick(activity, deltaTime)
    activity.priority = 100
end

function drivingActivityTable.tickHighestPriority(activity, deltaTime)
    UpdateKnowledge()

    if centerHit and activity.elapsedTime > 0.5 then
        throttle = 0 -- Let go of gas
    else
        throttle = 1 -- Press the gas
    end

    if rightHit then
        steering = -1 -- Left

    elseif leftHit then
        steering = 1 -- Right
    else
        steering = 0 -- Don't steer
    end

    if averageSpeed < 30 and activity.elapsedTime > 1 then
        -- Go in reverse under these conditions
        ACTIVITY_HANDLER:AddActivity("Reverse", reverseActivityTable)
    end
end

-- Reverse activity
function reverseActivityTable.tick(activity, deltaTime)
    activity.priority = 200
end

function reverseActivityTable.tickHighestPriority(activity, deltaTime)
    UpdateKnowledge()

    throttle = -1 -- Go in reverse
    steering = 1 -- and steer to the right

    reverseTimeRemaining = reverseTimeRemaining - deltaTime
    if reverseTimeRemaining <= 0 then
        -- Stop going in reverse
        ACTIVITY_HANDLER:RemoveActivity("Reverse")
    end
end

function reverseActivityTable.start(activity)
    reverseTimeRemaining = 1 + math.random()
end

ACTIVITY_HANDLER:AddActivity("Driving", drivingActivityTable)

-- Gather information about the vehicle's speed and obstacles ahead
function UpdateKnowledge()
    local pos = script:GetWorldPosition()
    local qRotation = Quaternion.New(script:GetWorldRotation())
    local forwardV = qRotation:GetForwardVector()
    local rightV = qRotation:GetRightVector() * 120
    local speed = VEHICLE:GetVelocity().size
    averageSpeed = CoreMath.Lerp(averageSpeed, speed, 0.1)
    speed = math.max(speed * 1.2, 120)
    local velocity = forwardV * speed
    -- Cast 3 rays forward to see if they hit something. The decisions to
    -- steer and accelerate are based on the results of these:
    centerHit = World.Raycast(pos, pos + velocity)
    leftHit = World.Raycast(pos - rightV, pos - rightV + velocity)
    rightHit = World.Raycast(pos + rightV, pos + rightV + velocity)
end

-- Apply driving decisions to vehicle
function OnMovementHook(vehicle, params)
    -- Disable the handbrake
    params.isHandbrakeEngaged = false
    -- Copy throttle and steering
    params.throttleInput = throttle
    params.steeringInput = steering
end

VEHICLE.serverMovementHook:Connect(OnMovementHook)
```

See also: [AIActivity.priority](aiactivity.md) | [Vehicle.serverMovementHook](vehicle.md) | [CoreObject.parent](coreobject.md) | [Quaternion.GetForwardVector](quaternion.md) | [World.Raycast](world.md) | [CoreMath.Lerp](coremath.md)

---
