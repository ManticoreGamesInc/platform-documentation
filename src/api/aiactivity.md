---
id: aiactivity
name: AIActivity
title: AIActivity
tags:
    - API
---

# AIActivity

AIActivity is an Object registered with an `AIActivityHandler`, representing one possible activity that the handler may execute each time it ticks.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `name` | `string` | This activity's name. | Read-Only |
| `owner` | [`AIActivityHandler`](aiactivityhandler.md) | The AIActivityHandler that owns this activity. May be `nil` if this activity has been removed from its owner. | Read-Only |
| `priority` | `number` | The current priority of this activity. Expected to be greater than 0, and expected to be adjusted by the `tick` function provided when adding the activity to its handler, though this can be set at any time. | Read-Write |
| `isHighestPriority` | `boolean` | True if this activity is the activity with the highest priority among its owner's list of activities. Note that this value does not update immediately when setting an activity's priority, but will be updated by the handler each tick when the handler evaluates its list of activities. | Read-Only |
| `elapsedTime` | `number` | If this activity is the highest priority for its handler, returns the length of time for which it has been highest priority. Otherwise returns the length of time since it was last highest priority, or since it was added to the handler. | Read-Only |
| `isDebugModeEnabled` | `boolean` | True if this activity has debugging enabled in the AI Debugger. Useful for deciding whether to log additional information about specific activities. | Read-Only |

## Examples

Example using:

### `priority`

### `elapsedTime`

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

See also: [AIActivityHandler.AddActivity](aiactivityhandler.md) | [Vehicle.serverMovementHook](vehicle.md) | [CoreObject.parent](coreobject.md) | [Quaternion.GetForwardVector](quaternion.md) | [World.Raycast](world.md) | [CoreMath.Lerp](coremath.md)

---
