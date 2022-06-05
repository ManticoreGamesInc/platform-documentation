---
id: fourwheeledvehicle
name: FourWheeledVehicle
title: FourWheeledVehicle
tags:
    - API
    - Vehicle
---

# FourWheeledVehicle

FourWheeledVehicle is a Vehicle with wheels. (Four of them.)

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `turnRadius` | `number` | The radius, in centimeters, measured by the inner wheels of the vehicle while making a turn. | Read-Write |

## Examples

Example using:

### `turnRadius`

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
    if vehicle:IsA("TreadedVehicle") then
        print("Type: Treaded, " .. vehicle.turnSpeed)
    elseif vehicle:IsA("FourWheeledVehicle") then
        print("Type: 4-wheel, " .. vehicle.turnRadius)
    else
        print("Type: Unknown")
    end
    print("")
end

-- Search for all vehicles and rate them
for _,vehicle in ipairs(World.FindObjectsByType("Vehicle")) do
    RateVehicle(vehicle)
end
```

See also: [Vehicle.maxSpeed](vehicle.md) | [TreadedVehicle.turnSpeed](treadedvehicle.md) | [World.FindObjectsByType](world.md) | [CoreObject.name](coreobject.md)

---
