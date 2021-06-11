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
| `mass` | `number` | Returns the mass of the vehicle in kilograms. | Read-Only |
| `maxSpeed` | `number` | Returns the maximum speed of the vehicle in centimeters per second. | Read-Only |
| `accelerationRate` | `number` | Returns the approximate acceleration rate of the vehicle in centimeters per second squared. | Read-Only |
| `brakeStrength` | `number` | Returns the maximum deceleration of the vehicle when stopping. | Read-Only |
| `tireFriction` | `number` | Returns the amount of friction tires or treads have on the ground. | Read-Only |
| `gravityScale` | `number` | Returns how much gravity affects this vehicle.  Default value is 1.9. | Read-Only |
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

## Events

| Event Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `driverEnteredEvent` | `Event<`[`Vehicle`](vehicle.md), [`Player`](player.md)`>` | Fired when a new driver occupies the vehicle. | None |
| `driverExitedEvent` | `Event<`[`Vehicle`](vehicle.md), [`Player`](player.md)`>` | Fired when a driver exits the vehicle. | None |

## Examples

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
