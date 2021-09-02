---
id: damageableobject
name: DamageableObject
title: DamageableObject
tags:
    - API
---

# DamageableObject

DamageableObject is a CoreObject which implements the [Damageable](damageable.md) interface.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `hitPoints` | `number` | Current amount of hit points. | Read-Write |
| `maxHitPoints` | `number` | Maximum amount of hit points. | Read-Write |
| `isDead` | `boolean` | True if the object is dead, otherwise false. Death occurs when damage is applied which reduces hit points to 0, or when the `Die()` function is called. | Read-Only |
| `isImmortal` | `boolean` | When set to `true`, this object cannot die. | Read-Write |
| `isInvulnerable` | `boolean` | When set to `true`, this object does not take damage. | Read-Write |
| `destroyOnDeath` | `boolean` | When set to `true`, this object will automatically be destroyed when it dies. | Read-Only |
| `destroyOnDeathDelay` | `number` | Delay in seconds after death before this object is destroyed, if `destroyOnDeath` is set to `true`. Defaults to 0. | Read-Only |
| `destroyOnDeathClientTemplateId` | `string` | Optional asset ID of a template to be spawned on clients when this object is automatically destroyed on death. | Read-Only |
| `destroyOnDeathNetworkedTemplateId` | `string` | Optional asset ID of a networked template to be spawned on the server when this object is automatically destroyed on death. | Read-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `ApplyDamage(Damage)` | `None` | Damages the object, unless it is invulnerable. If its hit points reach 0 and it is not immortal, it dies. | Server-Only |
| `Die([Damage])` | `None` | Kills the object, unless it is immortal. The optional Damage parameter is a way to communicate cause of death. | Server-Only |

## Events

| Event Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `damagedEvent` | `Event<`[`DamageableObject`](damageableobject.md) object, Damage damage`>` | Fired when the object takes damage. | Server-Only |
| `diedEvent` | `Event<`[`DamageableObject`](damageableobject.md) object, Damage damage`>` | Fired when the object dies. | Server-Only |

## Examples

Example using:

### `damagedEvent`

### `diedEvent`

Vehicles implement the DamageableObject interface. As such, they have all the properties and events from that type. In this example, we add a script to a vehicle that causes it to pass to the driver some of the damage it receives. By default, a vehicle's damageable properties are configured to make them immune-- Change them for this example to work.

```lua
local VEHICLE = script:FindAncestorByType("Vehicle")
local CHANCE_TO_PASS_DAMAGE = 0.5
local DAMAGE_REDUCTION = 0.2
local ON_DEATH_DIRECT_DAMAGE_TO_DRIVER = 75

function ApplyDamageToDriver(newAmount, vehicleDamage)
    -- Create new damage object for the player
    local damage = Damage.New(newAmount)
    -- Copy properties from the vehicle's damage object
    damage.reason = vehicleDamage.reason
    damage.sourceAbility = vehicleDamage.sourceAbility
    damage.sourcePlayer = vehicleDamage.sourcePlayer
    damage:SetHitResult(vehicleDamage:GetHitResult())

    local player = VEHICLE.driver
    -- If we think the player will die from this damage, eject them and
    -- wait a bit, so they will ragdoll correctly
    if player.hitPoints <= damage.amount then
        VEHICLE:RemoveDriver()
        Task.Wait(0.15)
    end
    -- Apply it
    player:ApplyDamage(damage)
end

function OnDamaged(_, damage)
    if damage.amount <= 0 then return end
    if not Object.IsValid(VEHICLE.driver) then return end

    -- Chance to apply damage to the player or prevent it completely
    if math.random() >= CHANCE_TO_PASS_DAMAGE then return end

    -- Reduction of the original damage amount
    local newAmount = damage.amount * (1 - DAMAGE_REDUCTION)
    newAmount = math.ceil(newAmount)

    -- Apply reduced damage
    ApplyDamageToDriver(newAmount, damage)
end

function OnDied(_, damage)
    if not Object.IsValid(VEHICLE.driver) then return end
    local player = VEHICLE.driver

    -- Apply the on-death damage
    ApplyDamageToDriver(ON_DEATH_DIRECT_DAMAGE_TO_DRIVER, damage)
end

VEHICLE.damagedEvent:Connect(OnDamaged)
VEHICLE.diedEvent:Connect(OnDied)
```

See also: [Vehicle.driver](vehicle.md) | [CoreObject.FindAncestorByType](coreobject.md) | [Damage.New](damage.md) | [Player.ApplyDamage](player.md) | [Object.IsValid](object.md)

---

Example using:

### `damagedEvent`

### `isInvulnerable`

### `hitPoints`

### `maxHitPoints`

In this example, when the health of an NPC reaches a certain threshold, the NPC will become invulnerable to all damage for a certain amount of time. While the NPC is invulnerable, it will regenerate health. The NPC can only regenerate the health once so that it can be killed.

```lua
-- Place script as a child of a Damageable Object.

-- Reference to the Damageable Object
local DAMAGEABLE_OBJECT = script.parent

-- At what point should the object start regenerating health
local invulnerableThreshold = 0.25 -- 25 percent

-- Only allow the regen to happen once
local hasRegened = false

-- Regenerate the health of the object passed in by adding 25 health
-- every .5 seconds.
local function regenHealth(obj)
    local counter = 0

    -- Spawn a repeating task that runs 6 times. Each iteration is counted
    -- so that the object can be vulnerable again at >= 6
    local regenTask = Task.Spawn(function()

        -- Prevent hitPoints being bigger than maxHitPoints
        obj.hitPoints = math.min(obj.hitPoints + 15, obj.maxHitPoints)

        -- At 6 or more iterations, make the object vulnerable so it can be killed
        if counter >= 6 then
            obj.isInvulnerable = false
        end

        counter = counter + 1
    end)

    regenTask.repeatCount = 6
    regenTask.repeatInterval = .5
end

local function OnDamaged(obj, damage)

    -- Check the object is valid
    if Object.IsValid(obj) then
        local currentHealth = obj.hitPoints
        local maxHealth = obj.maxHitPoints
        local percentageLeft = currentHealth / maxHealth

        -- Check if the health is less than or equal to the threshold and make sure
        -- the object hasn't already regened health
        if percentageLeft <= invulnerableThreshold and not hasRegened then
            hasRegened = true
            obj.isInvulnerable = true

            regenHealth(obj)
        end
    end
end

-- Print out to the Event Log the current health of the damageable object.
-- This is for debugging so you can see the health going down, and stops
-- when the health threshold is reached.
function Tick()
    print("Current Health: ", DAMAGEABLE_OBJECT.hitPoints)
    Task.Wait(.5)
end

-- Listen for when the damage is received.
DAMAGEABLE_OBJECT.damagedEvent:Connect(OnDamaged)
```

See also: [Task.Spawn](task.md) | [Object.IsValid](object.md) | [CoreObject.parent](coreobject.md)

---

Example using:

### `diedEvent`

In Core, many gameplay objects are kitbashed from various Static Meshes. In this example an object explodes, sending all its kitbashed parts flying. A pair of server/client scripts are added to the hierarchy of the `DamageableObject`. The server script detects the death and forwards that event to all clients by use of a broadcast. The client script then searches its local hierarchy for all Static Meshes and enables debris physics on them. Because the Damageable Object is most likely being destroyed, we need to move the meshes to a new parent that will outlive it: For the script to work, add a Client-Context group to the hierarchy and rename it to "DebrisParent".

```lua
-- Server Script:
local DAMAGEABLE = script:FindAncestorByType("Damageable")

function OnDied(_, _)
    -- Detects the death and forwards it to clients
    Events.BroadcastToAllPlayers("Scatter"..DAMAGEABLE.id)
end
DAMAGEABLE.diedEvent:Connect(OnDied)

-- Client Script:
local DAMAGEABLE = script:FindAncestorByType("Damageable")
local EXPLOSION_POWER = 2000
local RNG = RandomStream.New()

function OnDied()
    -- The client script receive the death event
    -- Finds all Static Meshes in the local hierarchy
    local childMeshes = script.parent:FindDescendantsByType("StaticMesh")
    -- Finds the new parent, a Client-context named "DebrisParent"
    local clientContext = World.FindObjectByName("DebrisParent")
    for _,mesh in ipairs(childMeshes) do
        -- Change parent, as we assume the old one is being destroyed
        mesh.parent = clientContext
        -- Enable debris physics
        mesh.isSimulatingDebrisPhysics = true
        -- Some Static Meshes don't support debris physics, so we must check
        if mesh.isSimulatingDebrisPhysics then
            -- Additional collision settings
            mesh.collision = Collision.FORCE_ON
            mesh.cameraCollision = Collision.FORCE_OFF
            -- Set a life span, so the mesh destroys itself after a few seconds
            mesh.lifeSpan = RNG:GetNumber(3, 5)
            -- Give a random velocity to the mesh, away from ground
            local vel = RNG:GetVector3FromCone(Vector3.UP, 90) * EXPLOSION_POWER
            mesh:SetVelocity(vel)
        else
            -- Destroy meshes immediately if they don't support debris physics
            mesh:Destroy()
        end
    end
end

Events.Connect("Scatter"..DAMAGEABLE.id, OnDied)
```

See also: [StaticMesh.isSimulatingDebrisPhysics](staticmesh.md) | [CoreObject.id](coreobject.md) | [Events.BroadcastToAllPlayers](events.md) | [RandomStream.GetVector3FromCone](randomstream.md) | [World.FindObjectByName](world.md)

---

Example using:

### `diedEvent`

In this example, 2 teams battle it out by destroying objects that match their team color. Everytime a Damageable Object is destroyed, it respawns a new one with a random team color by using the property "Destroy on Death Networked Template ID".

```lua
-- Place script as a child of a Damageable Object

-- Set the "Destroy on Death Networked Template ID" on the Damageable Object
-- with a copy of the template that contains this script so that it gets
-- respawned each time the Damageable Object has died

-- Reference to the damageable object
local DAMAGEABLE_OBJECT = script.parent

-- Reference to the static mesh which will be colored either red or blue
-- Enable the property "Is Team Color Used" on the static mesh
local MESH_OBJECT = script:GetCustomProperty("MeshObj"):WaitForObject()

-- Amount of score to give to the team for destroying an object
-- that matches the team they are on
local score = 5

local function OnDied(obj, damage)
    if Object.IsValid(obj) then

        -- Get the static mesh team number
        local meshObjTeam = MESH_OBJECT.team

        -- Get the team number from the player who destroyed the object
        local team = damage.sourcePlayer.team

        -- Compare the static mesh team value against the player team value
        if meshObjTeam == team then
            Game.IncreaseTeamScore(team, score)
        else

            -- Print to the Event log when a player destroys an object
            -- for the other team
            print("Wrong color", team, meshObjTeam)
        end

        -- Print out the team scores to the Event Log after each object
        -- is destroyed.
        print("Team 1 Score: ", Game.GetTeamScore(1))
        print("Team 2 Score: ", Game.GetTeamScore(2))
        print("------------------------------------")
    end
end

-- Connect the died event that will fire when the object is destoyed
DAMAGEABLE_OBJECT.diedEvent:Connect(OnDied)

-- Set to a random team number between 1 and 2 (both inclusive)
MESH_OBJECT.team = math.random(1, 2)
```

See also: [Object.IsValid](object.md) | [CoreObject.parent](coreobject.md) | [Game.IncreaseTeamScore](game.md) | [Damage.sourcePlayer](damage.md) | [Player.team](player.md)

---
