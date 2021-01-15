---
id: projectile
name: Projectile
title: Projectile
tags:
    - API
---

# Projectile

## Description

Projectile is a specialized Object which moves through the air in a parabolic shape and impacts other objects. To spawn a Projectile, use `Projectile.Spawn()`.

## API

### Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `owner` | `Player` | The Player who fired this Projectile. Setting this property ensures the Projectile does not impact the owner or their allies. This will also change the color of the Projectile if teams are being used in the game. | Read-Write |
| `sourceAbility` | `Ability` | Reference to the Ability from which the Projectile was created. | Read-Write |
| `speed` | `Number` | Centimeters per second movement. Default 5000. | Read-Write |
| `maxSpeed` | `Number` | Max cm/s. Default 0. Zero means no limit. | Read-Write |
| `gravityScale` | `Number` | How much drop. Default 1. 1 means normal gravity. Zero can be used to make a Projectile go in a straight line. | Read-Write |
| `drag` | `Number` | Deceleration. Important for homing Projectiles (try a value around 5). Negative drag will cause the Projectile to accelerate. Default 0. | Read-Write |
| `bouncesRemaining` | `Integer` | Number of bounces remaining before it dies. Default 0. | Read-Write |
| `bounciness` | `Number` | Velocity % maintained after a bounce. Default 0.6. | Read-Write |
| `lifeSpan` | `Number` | Max seconds the Projectile will exist. Default 10. | Read-Write |
| `shouldBounceOnPlayers` | `bool` | Determines if the Projectile should bounce off players or be destroyed, when bouncesRemaining is used. Default false. | Read-Write |
| `piercesRemaining` | `Integer` | Number of objects that will be pierced before it dies. A piercing Projectile loses no velocity when going through objects, but still fires the impactEvent event. If combined with bounces, all piercesRemaining are spent before bouncesRemaining are counted. Default 0. | Read-Write |
| `capsuleRadius` | `Number` | Shape of the Projectile's collision. Default 22. | Read-Write |
| `capsuleLength` | `Number` | Shape of the Projectile's collision. A value of zero will make it shaped like a Sphere. Default 44. | Read-Write |
| `homingTarget` | `CoreObject` | The projectile accelerates towards its target. Homing targets are meant to be used with spawned projectiles and will not work with weapons. | Read-Write |
| `homingAcceleration` | `Number` | Magnitude of acceleration towards the target. Default 10,000. | Read-Write |
| `shouldDieOnImpact` | `bool` | If `true`, the Projectile is automatically destroyed when it hits something, unless it has bounces remaining. Default true. | Read-Write |

### Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Destroy()` | `Object` | Immediately destroys the object. | None |
| `GetWorldTransform()` | `Transform` | Transform data for the Projectile in world space. | None |
| `GetWorldPosition()` | `Vector3` | Position of the Projectile in world space. | None |
| `SetWorldPosition(Vector3)` | `None` | Position of the Projectile in world space. | None |
| `GetVelocity()` | `Vector3` | Current direction and speed vector of the Projectile. | None |
| `SetVelocity(Vector3)` | `None` | Current direction and speed vector of the Projectile. | None |

### Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `Projectile.Spawn(string childTemplateId, Vector3 startPosition, Vector3 direction)` | `Projectile` | Spawns a Projectile with a child that is an instance of a template. | None |

### Events

| Event Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `impactEvent` | `Event<Projectile, Object other, HitResult>` | Fired when the Projectile collides with something. Impacted object parameter will be either of type `CoreObject` or `Player`, but can also be `nil`. The HitResult describes the point of contact between the Projectile and the impacted object. | None |
| `lifeSpanEndedEvent` | `Event<Projectile>` | Fired when the Projectile reaches the end of its lifespan. Fired before it is destroyed. | None |
| `homingFailedEvent` | `Event<Projectile>` | Fired when the target is no longer valid, for example the Player disconnected from the game or the object was destroyed somehow. | None |

## Examples

### `Spawn`

### `lifeSpanEndedEvent`

### `lifeSpan`

Like `CoreObjects`, Projectiles have a `lifeSpan` property, which is the maximum number of seconds a projectile can be kept around. Once that time is up, the projectile is automatically destroyed by the engine.

When projectiles reach the end of their lifespan, they trigger a `lifeSpanEndedEvent` event. This event fires _before_ the projectile is destroyed, so it is still valid to reference it in the event handler.

In this example, we fire a projectile straight up, so its lifeSpan runs out before it collides with anything. When it does, the `lifeSpanEndedEvent` fires.

```lua
-- A template of a basic cube, attached to the script as a custom property:
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")

-- Fire this projectile straight up so it doesn't hit anything:
local mySlowProjectile = Projectile.Spawn(propCubeTemplate,
            Vector3.New(1000, 0, 200), -- starting position
            Vector3.UP)                -- direction

mySlowProjectile.lifeSpan = 1
mySlowProjectile.lifeSpanEndedEvent:Connect(function(projectile)
    print("Projectile lifespan over")
end)

mySlowProjectile:SetVelocity(Vector3.New(0, 0, 1000))
```

### `homingFailedEvent`

If a projectile has its `homingTarget` set, and then the target disappears for some reason, it will fire a `HomingFailedEvent`. This is usually because the CoreObject that the projectile is following was `Destroy`ed, or the player it was following logged out.

In this example, we spawn an object, fire a projectile at it, (and set the `homingTarget` property) and then immediately remove the target, leaving the projectile to feel dejected and confused.

```lua
-- A template of a basic cube, attached to the script as a custom property:
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")

local objectInWorld = World.SpawnAsset(propCubeTemplate)
objectInWorld:SetWorldPosition(Vector3.New(1000, 0, 0))

local objectHomingProjectile = Projectile.Spawn(propCubeTemplate,
            Vector3.New(1000, 1000, 1000), -- starting position
            Vector3.New(0, 0, 0))          -- direction
objectHomingProjectile.speed = 0
objectHomingProjectile.gravityScale = 0
objectHomingProjectile.homingTarget = objectInWorld
objectHomingProjectile.drag = 5
objectHomingProjectile.homingAcceleration = 5000

objectHomingProjectile.homingFailedEvent:Connect(function (projectile)
    print("Target lost!")
end)

Task.Wait(0.5)
objectInWorld:Destroy()
-- The event should fire now and the "target lost" message should be displayed.
```

### `impactEvent`

When a projectile hits a surface, it triggers an `impactEvent`, which is given various information about exactly what collided with what, and where.

Specifically, the event receives a reference to the projectile that did the impacting, a reference to whatever object or player it hit, and a `hitResult` object that can be used to determine things like the position and angle of the collision.

A very common pattern is to use the `Object:IsA("Player")` function to determine if the projectile has hit a player or not.

In this example, the projectile will hit something and print out information about what it hit.

```lua
-- A template of a basic cube, attached to the script as a custom property:
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")

-- Fire this projectile straight down so it hits the ground:
local myProjectile = Projectile.Spawn(propCubeTemplate,
            Vector3.New(1000, 0, 200), -- starting position
            Vector3.New(0, 0, -1))     -- direction

myProjectile.impactEvent:Connect(function(projectile, other, hitresult)
    print("Hit object: " .. other.name .. " with an impact normal of " .. tostring(hitresult:GetImpactNormal()))
    if other and other:IsA("Player") then
        print("We hit player " .. other.name .. "!!!")
    end
end)
```

### `Destroy`

Sometimes you will want to remove a projectile from the game even if it hasn't hit any targets yet. When this is the case, the `Destroy()` function does what you need - it does exactly what the name implies - the projectile is immediately removed from the game and no events are generated.

We can test if an object still exists via the Object:IsValid() function. This can be useful because sometimes things other than program code can remove an object from our game. (Existing for longer than the `lifeSpan`, or colliding with an object, in the case of projectiles.)

```lua
-- A template of a basic cube, attached to the script as a custom property:
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")

-- Fire this projectile straight up, so it will be in the air for a while.
local myProjectile = Projectile.Spawn(propCubeTemplate,
            Vector3.New(1000, 0, 200), -- starting position
            Vector3.UP)      -- direction
myProjectile.speed = 50
myProjectile.gravityScale = 0
Task.Wait(1)
print("Is the projectile still around?  " .. tostring(Object.IsValid(myProjectile)))
-- The projectile is still there.
myProjectile:Destroy()
print("How about now?  " .. tostring(Object.IsValid(myProjectile)))
-- The projectile is no longer in the game.
```

### `GetWorldTransform`

### `GetWorldPosition`

### `GetVelocity`

### `SetVelocity`

We can get various information about a projectile's position and velocity via several functions. `GetWorldTransform()` and `GetWorldPosition()` functions can tell us where it is and where it is facing. `GetVelocity()` tells us where it is moving and how fast. And `SetVelocity()` allows us to change its direction in mid-flight.

In this sample, we'll fire some more projectiles at the player. But we'll also give them a magic shield that reflects any projectiles that get too close!

```lua
-- A template of a basic cube, attached to the script as a custom property:
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")

-- utility function for spawning projectiles aimed at the player
function FireAtPlayer(startPos, player)
    local direction = (player:GetWorldPosition() - startPos):GetNormalized()
    local myProjectile = Projectile.Spawn(propCubeTemplate,
        startPos,
        direction)
    myProjectile.speed = 2000
    myProjectile.gravityScale = 0
    return myProjectile
end

local projectileList = {}
-- Fire the barrage!
for i = -4, 4 do
    projectileList[i] = FireAtPlayer(Vector3.New(1000, 250 * i, 500), targetPlayer)
end

local MagicShieldTask = Task.Spawn(function()
    while true do
        for k, projectile in pairs(projectileList) do
            local projectileToPlayer = targetPlayer:GetWorldPosition() - projectile:GetWorldPosition()
            -- if the projectile is within 200 units of the player...
            if projectileToPlayer.size < 200 then
                local t = projectile:GetWorldTransform()
                -- ... and is generally facing the player ...
                if projectileToPlayer .. t:GetForwardVector() > 0 then
                    -- then shoot it back where it came!
                    projectile:SetVelocity(projectile:GetVelocity() * -0.8)
                end
            end
                return
        end
        Task.Wait()
    end
end)
```

### `capsuleLength`

### `capsuleRadius`

When Core performs collision checks (to see if a projectile has hit anything) it assumes the projectile is a _capsule._  That is, a cylinder with a hemisphere on each flat end.

We can change the shape of this capsule by modifying the length and radius of the cylinder. A length of 0 means we have a sphere. (Because there is no space between the two hemispheres on the ends.)

This sample makes a few projectiles of varying shapes and sizes.

Note that this only changes the collision properties of the projectile! The visual representation on screen will be unchanged.

By default, projectiles have a radius of 22, and length of 44.

```lua
-- A template of a basic cube, attached to the script as a custom property:
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")

-- Fire this projectile straight up, so it will be in the air for a while.
function FireProjectile()
    local myProjectile = Projectile.Spawn(propCubeTemplate,
                Vector3.New(1000, 0, 200), -- starting position
                Vector3.UP)                -- direction
    myProjectile.speed = 100
    myProjectile.gravityScale = 0
    return myProjectile
end

-- The default projectile is radius 22, and length 44.
local defaultProjectile = FireProjectile()

-- This projectile is very long but narrow.
local longThinProjectile = FireProjectile()
longThinProjectile.capsuleRadius = 10
longThinProjectile.capsuleLength = 100

-- This projectile is short and fat.
local shortFatProjectile = FireProjectile()
shortFatProjectile.capsuleRadius = 50
shortFatProjectile.capsuleLength = 20

-- This projectile's collision volume is a sphere.
local sphereProjectile = FireProjectile()
sphereProjectile.capsuleRadius = 40
sphereProjectile.capsuleLength = 0
```

### `gravityScale`

### `bouncesRemaining`

### `bounciness`

### `shouldBounceOnPlayers`

By default, projectiles are destroyed when they impact a surface. If you set their `bouncesRemaining` though, whenever they hit a surface, they will lose one `bouncesRemaining` and ricochet off in a new direction. This can be used to simulate grenades, super balls, bouncing lasers, or similar. The amount of energy they lose (or gain!) from impact is controlled via the `bounciness` property.

`gravityScale` can be used to change the trajectory of projectiles in flight. Setting it to 0 means that the projectiles are unaffected by gravity, and will simply fly in a straight line until they hit something. Setting it to greater than zero means that the projectile will arc downwards like a normal thrown object. And setting it to less than zero means the projectile will arc upwards like a helium balloon.

In this example, we fire several projectiles, with various properties.

```lua
-- A template of a basic cube, attached to the script as a custom property:
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")

function fireProjectile()
    local myProjectile = Projectile.Spawn(propCubeTemplate,
        Vector3.New(500, 0, 200), -- starting position
        Vector3.New(0, 1, 0))     -- direction
    myProjectile.speed = 500
    myProjectile.lifeSpan = 3
    return myProjectile
end

-- this projectile will just fire off in a straight line with no gravity. It should never bounce.
local standardProjectile = fireProjectile()
standardProjectile.gravityScale = 0

-- this projectile will arc and hit the ground.
local arcingProjectile = fireProjectile()
arcingProjectile.gravityScale = 1

-- this projectile will arc upwards and fly off into the sky.
local floatingProjectile = fireProjectile()
floatingProjectile.gravityScale = -1

-- this projectile will arc further, because it has less gravity.
local furtherArcingProjectile = fireProjectile()
furtherArcingProjectile.gravityScale = 0.5

-- this projectile will arc and bounce up to three times.
local bouncingProjectile = fireProjectile()
bouncingProjectile.gravityScale = 0.5
bouncingProjectile.bouncesRemaining = 3

-- this projectile will bounce more times, but with less energy per bounce.
local lessBouncyProjectile = fireProjectile()
lessBouncyProjectile.gravityScale = 0.5
lessBouncyProjectile.bouncesRemaining = 5
lessBouncyProjectile.bounciness = 0.2
```

### `homingTarget`

### `drag`

### `homingAcceleration`

Projectiles can be set to home in on targets, via the `homingTarget` property. This can be either a player or a CoreObject.

This example spawns an object in the world, and then fires a projectile to home in on it.

The `drag` and `homingAcceleration` properties affect how fast the homing projectile can change direction, and how fast it loses velocity due to air resistance.

```lua
-- A template of a basic cube, attached to the script as a custom property:
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")

local objectInWorld = World.SpawnAsset(propCubeTemplate)
objectInWorld:SetWorldPosition(Vector3.New(1000, 0, 0))

local function ProjectileImpact(projectile, other, hitresult)
    print("Hit something! " .. other.name)
end

local objectHomingProjectile = Projectile.Spawn(propCubeTemplate,
            Vector3.New(1000, 1000, 1000), -- starting position
            Vector3.New(0, 0, 0))          -- direction
objectHomingProjectile.speed = 0
objectHomingProjectile.gravityScale = 0
objectHomingProjectile.homingTarget = objectInWorld
objectHomingProjectile.drag = 5
objectHomingProjectile.homingAcceleration = 5000

objectHomingProjectile.impactEvent:Connect(function(projectile, other, hitresult)
    print("Hit something! " .. other.name)
end)

-- The projectile will hit home towards the target object, and print out a message when it hits.
```

### `owner`

Projectiles have a property, `owner`, which stores data about who spawned the projectile. This is populated automatically, if the projectile is generated from a weapon interaction. Otherwise, we have to set it ourselves.

Projectiles will never impact their `owner`, or anyone on the `owner`'s team. They will just pass on through, and not trigger an `impactEvent`.

In this example, we fire several projectiles at the player, but set them to be owned by the player, so they are unhit.

```lua
-- A template of a basic cube, attached to the script as a custom property:
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")

function OnImpact(projectile, other, hitresult)
    --Count how many times each projectile hits the player:
    if other and other:IsA("Player") then
        print("Urk! I've been shot!")
    end
end

-- utility function for spawning projectiles aimed at the player
function FireAtPlayer(startPos, player)
    local direction = (player:GetWorldPosition() - startPos):GetNormalized()
    local myProjectile = Projectile.Spawn(propCubeTemplate,
        startPos,
        direction)
    myProjectile.speed = 1000
    myProjectile.impactEvent:Connect(OnImpact)
    myProjectile.gravityScale = 0
    myProjectile.owner = player
end

-- Fire the barrage!
for i = -4, 4 do
    FireAtPlayer(Vector3.New(1000, 250 * i, 500), targetPlayer)
end
-- Player will not be hit (and the hit message will never be printed) because
-- the projectiles are all owned by the player.
```

### `piercesRemaining`

### `shouldDieOnImpact`

Projectiles have the `piercesRemaining` property, which controls how many times they penetrate objects and keep going. In this sample, we spawn several walls and fire several projectiles at them, with different penetration numbers.

Projectiles also have a property that determines if they should be destroyed when they hit an object - `shouldDieOnImpact`. One of the projectiles we spawn here does not die on impact! So when it hits a wall, it simply stops and waits for its `lifeSpan` to run out.

```lua
-- A template of a basic cube, attached to the script as a custom property:
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")

function FirePiercingProjectile(pierceCount)
    local myProjectile = Projectile.Spawn(propCubeTemplate,
        Vector3.New(500, 0, 150 + pierceCount * 100), -- starting position
        Vector3.New(1, 0, 0))     -- direction
    myProjectile.speed = 1000
    myProjectile.lifeSpan = 3
    myProjectile.gravityScale = 0
    myProjectile.piercesRemaining = pierceCount
    return myProjectile
end

-- Make some walls for our projectiles to run into:
for i = 1, 8 do
    walls[i] = World.SpawnAsset(propCubeTemplate, {
        position = Vector3.New(500 + i * 500, 0, 250),
        scale = Vector3.New(1, 5, 5)
    })
end

-- this projectile will just fire off in a straight line with no gravity. It should never bounce.
local Pierce_x1 = FirePiercingProjectile(0)

-- This projectile will pierce the first wall and impact the second.
local Pierce_x2 = FirePiercingProjectile(1)

-- This projectile will pierce the first two walls, and impact the third.
local Pierce_x3 = FirePiercingProjectile(2)

-- This projectile will hit the first wall, and then stop, because it is set not to die on impact.
local DontDieOnImpact = FirePiercingProjectile(0)
DontDieOnImpact.shouldDieOnImpact = false
```

### `sourceAbility`

Projectiles have a field to report what ability spawned them. If the projectile is fired by a weapon, then the weapon automatically populates the sourceAbility property. If you spawn projectiles manually via spawnProjectile, then you are responsible for populating it yourself.

Here is an example of a weapon script that tests if the projectiles came from an ability called "FlameThrower." It is assumed that this is in a script that is a direct child of a weapon object.

```lua
function OnImpact(projectile, other, hitresult)
    if other and other:IsA("Player") then
        local damageScale = 1.0
        if projectile.sourceAbility ~= nil
                and projectile.sourceAbility.name == "FlameThrower" then
            local fireResistance = other:GetResource("fireResist")
            damageScale = damageScale * (1.0 - fireResistance)
            if (fireResistance > 0) then
                print("Damage reduced by fire resistance!")
            end
        end
        other:ApplyDamage(Damage.New(10 * damageScale))
    end
end

--Tell each projectile fired what to do when it hits something:
local weapon = script.parent
weapon.projectileSpawnedEvent:Connect(function(weapon, projectile)
    projectile.impactEvent:Connect(OnImpact)
end)
```

### `speed`

### `maxSpeed`

You can set the speed of a projectile directly, via the `speed` property. Note that this does not change the direction of a projectile - only how fast it is moving in whatever direction it is already pointing in.

You can also set a projectile's `maxSpeed` property, which clamps the speed to a given velocity. This can be useful in situations where the projectile is homing or affected by gravity - you can ensure that the speed never gets above a particular velocity, no matter how long it has been falling/accelerating.

One important thing to note, is that `maxSpeed` is only checked at the END of the frame, so if you manually set the speed to something large, it will only be clamped after your script has executed and the game has updated with a new 'tick'.

```lua
-- A template of a basic cube, attached to the script as a custom property:
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")

-- Fire this projectile straight up, so it will be in the air for a while.
local myProjectile = Projectile.Spawn(propCubeTemplate,
            Vector3.New(1000, 0, 200), -- starting position
            Vector3.UP)                -- direction
myProjectile.speed = 100
myProjectile.maxSpeed = 50
myProjectile.gravityScale = 0
-- The projectile is still going at 100 speed. Max Speed is only checked at the end of the frame.
print("This projectile's speed is " .. tostring(myProjectile.speed))

Task.Wait()    -- So if we wait one frame...
print("This projectile's speed is " .. tostring(myProjectile.speed))
-- It should now be clamped down to the maximum speed.
```
