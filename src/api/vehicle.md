---
id: vehicle
name: Vehicle
title: Vehicle
tags:
    - API
---

# Vehicle

Vehicle is a CoreObject representing a vehicle that can be occupied and driven by a player.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `driver` | [`Player`](player.md) | The Player currently driving the vehicle, or `nil` if there is no driver. | Read-Only |
| `enterTrigger` | [`Trigger`](trigger.md) | Returns the Trigger a Player uses to occupy the vehicle. | Read-Only |
| `camera` | [`Camera`](camera.md) | Returns the Camera used for the driver while they occupy the vehicle. | Read-Only |
| `driverAnimationStance` | `string` | Returns the animation stance that will be applied to the driver while they occupy the vehicle. | Read-Only |
| `mass` | `number` | Returns the mass of the vehicle in kilograms. | Read-Write |
| `maxSpeed` | `number` | The maximum speed of the vehicle in centimeters per second. | Read-Write |
| `accelerationRate` | `number` | The approximate acceleration rate of the vehicle in centimeters per second squared. | Read-Write |
| `brakeStrength` | `number` | The maximum deceleration of the vehicle when stopping. | Read-Write |
| `coastBrakeStrength` | `number` | The deceleration of the vehicle while coasting (with no forward or backward input). | Read-Write |
| `tireFriction` | `number` | The amount of friction tires or treads have on the ground. | Read-Write |
| `gravityScale` | `number` | How much gravity affects this vehicle.  Default value is 1.9. | Read-Write |
| `isAccelerating` | `boolean` | Returns `true` if the vehicle is currently accelerating. | Read-Only |
| `isDriverHidden` | `boolean` | Returns `true` if the driver is made invisible while occupying the vehicle. | Read-Only |
| `isDriverAttached` | `boolean` | Returns `true` if the driver is attached to the vehicle while they occupy it. | Read-Only |
| `isBrakeEngaged` | `boolean` | Returns `true` if the driver of the vehicle is currently using the brakes. | Read-Only |
| `isHandbrakeEngaged` | `boolean` | Returns `true` if the driver of the vehicle is currently using the handbrake. | Read-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `SetDriver(Player)` | `None` | Sets the given player as the new driver of the vehicle. A `nil` value will remove the current driver. | None |
| `RemoveDriver()` | `None` | Removes the current driver from the vehicle. | None |
| `AddImpulse(Vector3)` | `None` | Adds an impulse force to the vehicle. | None |
| `GetPhysicsBodyOffset()` | [`Vector3`](vector3.md) | Returns the positional offset for the body collision of the vehicle. | None |
| `GetPhysicsBodyScale()` | [`Vector3`](vector3.md) | Returns the scale offset for the body collision of the vehicle. | None |
| `GetDriverPosition()` | [`Vector3`](vector3.md) | Returns the position relative to the vehicle at which the driver is attached while occupying the vehicle. | None |
| `GetDriverRotation()` | [`Rotation`](rotation.md) | Returns the rotation with which the driver is attached while occupying the vehicle. | None |
| `GetCenterOfMassOffset()` | [`Vector3`](vector3.md) | Returns the center of mass offset for this vehicle. | None |
| `SetCenterOfMassOffset(Vector3 offset)` | `None` | Sets the center of mass offset for this vehicle. This resets the vehicle state and may not behave nicely if called repeatedly or while in motion. | None |

## Events

| Event Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `driverEnteredEvent` | `Event<`[`Vehicle`](vehicle.md), [`Player`](player.md)`>` | Fired when a new driver occupies the vehicle. | None |
| `driverExitedEvent` | `Event<`[`Vehicle`](vehicle.md), [`Player`](player.md)`>` | Fired when a driver exits the vehicle. | None |

## Hooks

| Hook Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `clientMovementHook` | `Hook<`[`Vehicle`](vehicle.md) vehicle, table parameters`>` | Hook called when processing the driver's input. The `parameters` table contains "throttleInput", "steeringInput", and "isHandbrakeEngaged". This is only called on the driver's client. "throttleInput" is a number -1.0, to 1.0, with positive values indicating forward input. "steeringInput" is the same, and positive values indicate turning to the right. "isHandbrakeEngaged" is a boolean. | Client-Only |
| `serverMovementHook` | `Hook<`[`Vehicle`](vehicle.md) vehicle, table parameters`>` | Hook called when on the server for a vehicle with no driver. This has the same parameters as clientMovementHook. | Server-Only |

## Examples

Example using:

### `occupiedVehicle`

In this example, we can imagine a racing game where various start points are defined for the players. When a new round starts we teleport all players who have a vehicle to the starting points, so they can begin a new race. The start point objects are all children of a common group/folder that is set as a custom property. The objects used for start points can be anything, such as an empty group. For this type of invisible "level design object", sometimes creators use a server-context with a static mesh inside, so you can see the points during edit time, but they won't appear or collide for clients.

```lua
local START_POINTS_PARENT = script:GetCustomProperty("StartPoints"):WaitForObject()
local START_POINTS = START_POINTS_PARENT:GetChildren()

function OnRoundStart()
    for i,player in ipairs(Game.GetPlayers()) do
        local vehicle = player.occupiedVehicle
        if vehicle then
            -- Teleport them to the start points
            local startPoint = START_POINTS[i]
            if startPoint then
                local pos = startPoint:GetWorldPosition()
                local rot = startPoint:GetWorldRotation()
                vehicle:SetWorldPosition(pos)
                vehicle:SetWorldRotation(rot)
            else
                warn("Insufficient start points for all players")
            end
            -- Stop their movement
            vehicle:SetVelocity(Vector3.ZERO)
            vehicle:SetAngularVelocity(Vector3.ZERO)
        end
    end
end

Game.roundStartEvent:Connect(OnRoundStart)
```

See also: [CoreObject.SetVelocity](coreobject.md) | [CoreObjectReference.WaitForObject](coreobjectreference.md) | [Game.GetPlayers](game.md) | [Vector3.ZERO](vector3.md)

---

Example using:

### `accelerationRate`

### `maxSpeed`

### `tireFriction`

This example takes vehicle stats (acceleration, max speed and tire friction) and normalizes them to rating values between 1 and 5. This could be used, for example, in the UI of a vehicle selection screen to show how vehicles compare to each other in their various stats. When the script runs it searches the game for all vehicles that exist and prints their ratings to the Event Log.

```lua
local ACCELE_MIN = 400
local ACCELE_MAX = 4000
local TOP_SPEED_MIN = 2000
local TOP_SPEED_MAX = 20000
local HANDLING_MIN = 0.5
local HANDLING_MAX = 10

local RATING_LEVELS = 5

function RateStat(value, min, max)
    if value >= max then
        return RATING_LEVELS
    end
    if value > min and max > min then
        local p = (value - min) / (max - min)
        local rating = p * RATING_LEVELS
        rating = math.floor(rating) + 1
        return rating
    end
    return 1
end

function RateVehicle(vehicle)
    local accele = RateStat(vehicle.accelerationRate, ACCELE_MIN, ACCELE_MAX)
    local topSpeed = RateStat(vehicle.maxSpeed, TOP_SPEED_MIN, TOP_SPEED_MAX)
    local handling = RateStat(vehicle.tireFriction, HANDLING_MIN, HANDLING_MAX)

    -- Print vehicle ratings to the Event Log
    print(vehicle.name)
    print("Acceleration: " .. accele)
    print("Top Speed: " .. topSpeed)
    print("Handling: " .. handling)
    print("")
end

-- Search for all vehicles and rate them
for _,vehicle in ipairs(World.FindObjectsByType("Vehicle")) do
    RateVehicle(vehicle)
end
```

See also: [World.FindObjectsByType](world.md) | [CoreObject.name](coreobject.md)

---

Example using:

### `maxSpeed`

### `tireFriction`

### `accelerationRate`

### `turnRadius`

Off road sections are an excellent to encourage players to stay on the track. In this example, when vehicle with a driver enters a trigger, they will be slowed down and given more traction. Once the vehicles exits the trigger the vehicle will drive at its original speed.

```lua
-- Get the trigger object that will represent the off road area
local propTrigger = script:GetCustomProperty("Trigger"):WaitForObject()

-- This function will be called whenever an object enters the trigger
function OnEnter(trigger, other)
    -- Check if a vehicle has entered the trigger and if that vehicle is currently not off road
    if(other:IsA("Vehicle") and not other.serverUserData.offRoad) then

        -- Set the off road status of the vehicle to "true"
        other.serverUserData.offRoad = true

        -- Store the original specifications of the vehicle. The "serverUserData" properties
        -- are used in the case that other road obstacles are modifying the specifications of the vehicle
        other.serverUserData.originalTireFriction = other.serverUserData.originalTireFriction or other.tireFriction
        other.serverUserData.originalMaxSpeed = other.serverUserData.originalMaxSpeed or other.maxSpeed
        other.serverUserData.originalAccelerationRate = other.serverUserData.originalAccelerationRate or other.accelerationRate
        other.serverUserData.originalTurnRadius = other.serverUserData.originalTurnRadius or other.turnRadius

        -- Increase the tire friction of the vehicle by 900%, this will give the vehicle more traction
        other.tireFriction = other.tireFriction * 10.0
        -- Decrease the maximum speed of the vehicle by 90%
        other.maxSpeed = other.maxSpeed * 0.1
        -- Decrease the acceleration of the vehicle by 80%
        other.accelerationRate = other.accelerationRate * 0.2
        -- Shrink the turn radius by 80%, this will allow the vehicle to make tighter turns
        other.turnRadius = other.tireFriction * 0.2
    end
end

-- Bind the "OnEnter" function to the "beginOverlapEvent" of the "propTrigger" so that
-- when an object enters the "propTrigger" the "OnEnter" function is executed
propTrigger.beginOverlapEvent:Connect(OnEnter)

-- This function will be called whenever an object enters the trigger
function OnExit(trigger, other)
    -- If a vehicle has entered the trigger and the vehicle is off road, then reset
    -- the vehicle specifications (maximum speed, acceleration, turning radius)
    if(other:IsA("Vehicle") and Object.IsValid(other.driver) and other.serverUserData.offRoad) then
        -- Set the off road status of the vehicle to "false"
        other.serverUserData.offRoad = false

        -- Reset the vehicle specifications to the values before the vehicle
        -- had entered the boost pad
        other.maxSpeed = other.serverUserData.originalMaxSpeed
        other.turnRadius = other.serverUserData.originalTurnRadius
        other.accelerationRate = other.serverUserData.originalAccelerationRate
    end
end

-- Bind the "OnExit" function to the "endOverlapEvent" of the "propTrigger" so that
-- when an object exits the "propTrigger" the "OnExit" function is executed
propTrigger.endOverlapEvent:Connect(OnExit)
```

See also: [event:Trigger.beginOverlapEvent](event.md) | [CoreObject.serverUserData](coreobject.md)

---

Example using:

### `SetDriver`

### `driverExitedEvent`

In some games it will be important to override the built-in trigger behavior to add more gameplay. In this example, the vehicle belongs to a specific player (Bot1). If another player tries to drive it they will receive a message saying the car doesn't belong to them. This script expects to be placed as a child of the vehicle.

```lua
local VEHICLE = script:FindAncestorByType("Vehicle")
local TRIGGER = script:GetCustomProperty("EnterTrigger"):WaitForObject()
local OWNER = "Bot1"

function OnInteracted(trigger, player)
    if player.name == OWNER then
        VEHICLE:SetDriver(player)
        TRIGGER.isEnabled = false
    else
        Chat.BroadcastMessage("Not your car.", {players = player})
    end
end

function OnDriverExited(player)
    TRIGGER.isEnabled = true
end

TRIGGER.interactedEvent:Connect(OnInteracted)
VEHICLE.driverExitedEvent:Connect(OnDriverExited)
```

See also: [CoreObject.FindAncestorByType](coreobject.md) | [CoreObjectReference.WaitForObject](coreobjectreference.md) | [Player.name](player.md) | [Chat.BroadcastMessage](chat.md) | [Trigger.interactedEvent](trigger.md)

---

Example using:

### `driverEnteredEvent`

### `driverExitedEvent`

A common situation could be a game that has both weapons and vehicles. In this example, when a player enters the vehicle all their abilities are disabled. When they exit the vehicle their abilities are re-enabled. This script expects to be placed as a child of the vehicle.

```lua
local VEHICLE = script.parent

function OnDriverEntered(vehicle, player)
    for _,ability in ipairs(player:GetAbilities()) do
        ability.isEnabled = false
    end
end

function OnDriverExited(vehicle, player)
    for _,ability in ipairs(player:GetAbilities()) do
        ability.isEnabled = true
    end
end

VEHICLE.driverEnteredEvent:Connect(OnDriverEntered)
VEHICLE.driverExitedEvent:Connect(OnDriverExited)
```

See also: [CoreObject.parent](coreobject.md) | [Player.GetAbilities](player.md) | [Ability.isEnabled](ability.md)

---

Example using:

### `driverEnteredEvent`

### `driverExitedEvent`

### `accelerationRate`

### `maxSpeed`

### `tireFriction`

In this example, when the driver of the vehicle presses the spacebar, the vehicle launches up and forward a slight amount in the direction the vehicle is facing.

```lua
local VEHICLE = script:FindAncestorByType("Vehicle")
local bindingPressListener = nil

function OnBindingPressed(player, binding)
    if binding == "ability_extra_17" then
        -- Vector3 (forward, 0, up) rotated into the world space of the vehicle
        local impulseVector = VEHICLE:GetWorldRotation() * Vector3.New(1000, 0, 1000)
        VEHICLE:AddImpulse(impulseVector * VEHICLE.mass)
    end
end

function OnDriverEntered(vehicle, player)
    bindingPressListener = player.bindingPressedEvent:Connect(OnBindingPressed)
end

function OnDriverExited(vehicle, player)
    if bindingPressListener and bindingPressListener.isConnected then
        bindingPressListener:Disconnect()
    end
end

VEHICLE.driverEnteredEvent:Connect(OnDriverEntered)
VEHICLE.driverExitedEvent:Connect(OnDriverExited)
```

See also: [CoreObject.AddImpulse](coreobject.md) | [Player.bindingPressedEvent](player.md) | [EventListener.Disconnect](eventlistener.md) | [Vector3.New](vector3.md)

---

Example using:

### `driverExitedEvent`

In this example, players take damage when they exit a vehicle that is in motion. The amount of damage taken is variable, depending on how fast the vehicle is going. This script expects to be placed as a child of the vehicle.

```lua
local VEHICLE = script.parent
local MAX_SAFE_SPEED = 400
local LETHAL_SPEED = 4000

function OnDriverExited(vehicle, player)
    if MAX_SAFE_SPEED >= LETHAL_SPEED then return end

    local speed = vehicle:GetVelocity().size
    print("Exit speed = " .. speed)

    if not player.isDead and speed > MAX_SAFE_SPEED then
        local t = (speed - MAX_SAFE_SPEED) / (LETHAL_SPEED - MAX_SAFE_SPEED)

        local amount = CoreMath.Lerp(0, player.maxHitPoints, t)
        if amount > 0 then
            local damage = Damage.New(amount)
            damage.reason = DamageReason.MAP
            player:ApplyDamage(damage)
        end
    end
end

VEHICLE.driverExitedEvent:Connect(OnDriverExited)
```

See also: [CoreObject.GetVelocity](coreobject.md) | [Vector3.size](vector3.md) | [Player.isDead](player.md) | [CoreMath.Lerp](coremath.md) | [Damage.New](damage.md)

---

Example using:

### `serverMovementHook`

This script leverages the movement hook to implement a crude AI that autopilots a vehicle. It avoids obstacles and if it gets stuck, it backs up. It expects to be added as a server script under the vehicle's hierarchy. The script's position inside the vehicle is important, it should be at the front bumper, almost touching the vehicle, and its X-axis should point forward, in the direction the vehicle moves.

```lua
local VEHICLE = script:FindAncestorByType("Vehicle")
if not VEHICLE then return end

local reverseClock = 0
local forwardClock = 0
local deltaTime = 0
local averageSpeed = 100

function OnMovementHook(vehicle, params)
    -- Disable the handbrake
    params.isHandbrakeEngaged = false

    -- Pre-process information about the script's position and rotation
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
    local centerHit = World.Raycast(pos, pos + velocity)
    local leftHit = World.Raycast(pos - rightV, pos - rightV + velocity)
    local rightHit = World.Raycast(pos + rightV, pos + rightV + velocity)

    -- Reverse logic in case the vehicle gets stuck
    if forwardClock > 0 then
        forwardClock = forwardClock - deltaTime
        params.throttleInput = 1 -- Press the gas

    elseif reverseClock <= 0 and averageSpeed < 30 then
        -- Randomize the reverse duration in case multiple cars get stuck on each other
        reverseClock = 1 + math.random()
    end

    if reverseClock > 0 then
        reverseClock = reverseClock - deltaTime
        params.throttleInput = -1 -- Go in reverse
        if reverseClock <= 0 then
            forwardClock = 1
        end

    elseif centerHit then
        params.throttleInput = 0 -- Let go of gas
    else
        params.throttleInput = 1 -- Press the gas
    end

    -- Steer left/right
    if reverseClock > 0 then
        params.steeringInput = 1 -- Right (reverse)

    elseif rightHit then
        params.steeringInput = -1 -- Left

    elseif leftHit then
        params.steeringInput = 1 -- Right
    else
        params.steeringInput = 0 -- Don't steer
    end
end

function Tick(dt)
    deltaTime = dt
end

VEHICLE.serverMovementHook:Connect(OnMovementHook)
```

See also: [CoreObject.GetVelocity](coreobject.md) | [World.Raycast](world.md) | [Quaternion.GetForwardVector](quaternion.md) | [Vector3.size](vector3.md) | [CoreMath.Lerp](coremath.md)

---

Example using:

### `AddImpulse`

### `maxSpeed`

### `serverUserData`

In this example, when a vehicle enters a trigger, the vehicle will be launched forward for 0.5 seconds.

```lua
-- Get the trigger object that will represent the boost pad
local propTrigger = script:GetCustomProperty("Trigger"):WaitForObject()

-- This function will be called whenever an object enters the trigger
function OnEnter(trigger, other)
    -- Check if a vehicle has entered the trigger
    if(other:IsA("Vehicle")) then

        -- Get a vector that represents the direction the boost pad is pointing in
        local direction = trigger:GetWorldRotation() * Vector3.RIGHT

        -- Apply a force to the vehicle to give the vehicle sudden increase in speed
        other:AddImpulse(direction * 2000000)

        -- Check if the  maximum speed of the vehicle has already been increased
        if(not other.serverUserData.isBoosting) then
            other.serverUserData.isBoosting = true

            -- Store the original maximum speed of the vehicle. The "originalMaxSpeed" property
            -- is used in case any other road obstacles are modifying the "maxSpeed" of the vehicle
            local originalMaxSpeed = other.serverUserData.originalMaxSpeed or other.maxSpeed

            -- Increase the maximum speed of the vehicle by 300%`
            other.maxSpeed = originalMaxSpeed * 4.0

            -- Wait 0.5 seconds before returning the vehicle to its original speed
            Task.Wait(0.5)

            -- Return the vehicle to its original speed
            other.maxSpeed = originalMaxSpeed

            -- Set "isBoosting" to false so that the speed increase of boost pads can be activated
            -- when the vehicle passes over another boost pad
            other.serverUserData.isBoosting = false
        end
    end
end
-- Bind the "OnEnter" function to the "beginOverlapEvent" of the "propTrigger" so that
-- when an object enters the "propTrigger" the "OnEnter" function is executed
propTrigger.beginOverlapEvent:Connect(OnEnter)
```

See also: [event:Trigger.beginOverlapEvent](event.md) | [Rotation * Vector3](rotation.md)

---

Example using:

### `SetDriver`

In this example, a vehicle is spawned for each player at the moment they join the game. Also, when they leave the game we destroy the vehicle. For best results, delete the `Enter Trigger` that usually comes with vehicles and set the vehicle's `Exit Binding` to `None`.

```lua
local VEHICLE = script:GetCustomProperty("VehicleTemplate")

local playerVehicles = {}

function OnPlayerJoined(player)
    local pos = player:GetWorldPosition()
    local vehicleInstance = World.SpawnAsset(VEHICLE, {position = pos})
    vehicleInstance:SetDriver(player)
    playerVehicles[player] = vehicleInstance
end

function OnPlayerLeft(player)
    local vehicle = playerVehicles[player]
    if Object.IsValid(vehicle) then
        vehicle:Destroy()
    end
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
Game.playerLeftEvent:Connect(OnPlayerLeft)
```

See also: [CoreObject.Destroy](coreobject.md) | [Player.GetWorldPosition](player.md) | [World.SpawnAsset](world.md) | [Object.IsValid](object.md) | [Game.playerJoinedEvent](game.md)

---

Example using:

### `SetLocalAngularVelocity`

### `tireFriction`

### `maxSpeed`

### `driver`

In this example, entering the trigger will act like an oil slick. Any vehicles that enter the trigger will spin out of control.

```lua
-- Get the trigger that will represent the oil slick area
local propTrigger = script:GetCustomProperty("Trigger"):WaitForObject()

-- This function will be called whenever an object enters the trigger
function OnEnter(trigger, other)
    -- Check if the object entering is a vehicle and if the vehicle is currently not in an oil slick
    if(other:IsA("Vehicle") and not other.serverUserData.inOil) then
        -- Set the oil slick status of the vehicle to "true" so that any more oil slicks that the vehicle passes
        -- over do not affect the vehicle.
        other.serverUserData.inOil = true

        -- Store the original max speed of the vehicle
        local originalMaxSpeed = other.serverUserData.originalMaxSpeed or other.maxSpeed

        -- Store the original tire friction of the vehicle
        local originalTireFriction = other.serverUserData.originalTireFriction or other.tireFriction

        -- Set the maximum speed of the vehicle to 0 to stop it from moving
        other.maxSpeed = 1000

        -- Set the tire friction of the wheels to 0 so that the car can easily spin
        other.tireFriction = 0.5

        -- Make the vehicle spin for 2 seconds
        other:SetLocalAngularVelocity(Vector3.New(0, 0, 999))

        Task.Wait(2)

        -- Reset the specifications of the vehicle to the values before the vehicle entered the oil slick
        other.maxSpeed = originalMaxSpeed
        -- Resetting the "tireFriction" will cause the vehicle to stop spinning
        other.tireFriction = originalTireFriction

        -- Reset the in oil status of the vehicle so that the vehicle can be affected by another oil slick.
        other.serverUserData.inOil = false
    end
end
-- Bind the "OnEnter" function to the "beginOverlapEvent" of the "propTrigger" so that
-- when an object enters the "propTrigger" the "OnEnter" function is executed
propTrigger.beginOverlapEvent:Connect(OnEnter)
```

See also: [event:Trigger.beginOverlapEvent](event.md) | [CoreObject.serverUserData](coreobject.md)

---
