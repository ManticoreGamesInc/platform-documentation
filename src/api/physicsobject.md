---
id: physicsobject
name: PhysicsObject
title: PhysicsObject
tags:
    - API
---

# PhysicsObject

A CoreObject with simulated physics that can interact with players and other objects. PhysicsObject also implements the [Damageable](damageable.md) interface.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `team` | `integer` | Assigns the physics object to a team. Value range from `0` to `4`. `0` is neutral team. | Read-Write |
| `isTeamCollisionEnabled` | `boolean` | If `false`, and the physics object has been assigned to a valid team, players on that team will not collide with the object. | Read-Write |
| `isEnemyCollisionEnabled` | `boolean` | If `false`, and the physics object has been assigned to a valid team, players on other teams will not collide with the object. | Read-Write |
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
| `damagedEvent` | [`Event`](event.md)<[`PhysicsObject`](physicsobject.md) object, [`Damage`](damage.md) damage> | Fired when the object takes damage. | Server-Only |
| `diedEvent` | [`Event`](event.md)<[`PhysicsObject`](physicsobject.md) object, [`Damage`](damage.md) damage> | Fired when the object dies. | Server-Only |

## Examples

Example using:

### `damagedEvent`

### `diedEvent`

Physics Objects are also of type `Damageable`. In this example, a script is responsible for spawning a series of target dummies. One dummy is spawned each time the function `SpawnDummy()` is called. Dummies are spawned on either the left or right side, randomly, and move towards the other side. Each time a target dummy takes damage, the team inflicting the damage scores 1 point.

```lua
local DUMMY_TEMPLATE = script:GetCustomProperty("DummyTarget")
local MOVEMENT_RANGE = 500
local MOVEMENT_DURATION = 5

function SpawnDummy()
    -- Calculate the dummy's start position and movement destination
    local startOffset = Vector3.New(0, MOVEMENT_RANGE, 0)
    if math.random() < 0.5 then
        startOffset = -startOffset
    end
    local pos = script:GetWorldPosition() + startOffset
    local destination = pos - startOffset * 2
    
    -- Spawn the target dummy
    local dummy = World.SpawnAsset(DUMMY_TEMPLATE, {position = pos})
    
    -- Tell the dummy to move towards the destination
    dummy:MoveTo(destination, MOVEMENT_DURATION)
    
    -- Listen to damage/death events
    -- Save the event listeners so we can clean up later
    local listeners = {}
    table.insert(listeners, 
        dummy.damagedEvent:Connect(OnTargetDamaged)
    )
    table.insert(listeners,
        dummy.diedEvent:Connect(OnTargetDied)
    )
    dummy.serverUserData.eventListeners = listeners
end

function OnTargetDamaged(dummy, damage)
    if damage.sourcePlayer
    and damage.sourcePlayer.team
    then
        -- The team dealing damage gains 1 point
        Game.IncreaseTeamScore(damage.sourcePlayer.team, 1)
    end
end

function OnTargetDied(dummy, damage)
    -- Disconnect event listeners to avoid memory leak
    for _,eventListener in ipairs(dummy.serverUserData.eventListeners) do
        if eventListener.isConnected then
            eventListener:Disconnect()
        end
    end
    dummy.serverUserData.eventListeners = {}
end
```

See also: [Damage.sourcePlayer](damage.md) | [Game.IncreaseTeamScore](game.md) | [World.SpawnAsset](world.md) | [CoreObject.MoveTo](coreobject.md) | [Vector3.New](vector3.md) | [Event.Connect](event.md) | [EventListener.Disconnect](eventlistener.md)

---

Example using:

### `ApplyDamage`

### `collidedEvent`

In this example, a Physics Object takes 5 damage each time it collides with any object.

```lua
local PHYSICS_OBJECT = script.parent
local DAMAGE_AMOUNT = 5

function OnObjectCollided(obj, hitResult)
    if not obj.isDead then
        local dmg = Damage.New(DAMAGE_AMOUNT)
        dmg.reason = DamageReason.MAP
        
        if other:IsA("Player") then
            dmg.sourcePlayer = hitResult.other
        end
        
        obj:ApplyDamage(dmg)
    end
end

PHYSICS_OBJECT.collidedEvent:Connect(OnObjectCollided)
```

See also: [Damage.New](damage.md) | [HitResult.other](hitresult.md) | [DamageableObject.isDead](damageableobject.md) | [CoreObject.parent](coreobject.md) | [Event.Connect](event.md)

---

Example using:

### `Die`

In this example, a Physics Object dies if it falls below the world. The world's bottom limit is here defined as -100 meters.

```lua
local PHYSICS_OBJECT = script.parent

function Tick()
    if not PHYSICS_OBJECT.isDead then
        local position = PHYSICS_OBJECT:GetWorldPosition()
        
        if position.z < -10000 then
            PHYSICS_OBJECT:Die()
        end
    end
    -- Wait a little. It would be inefficient to run this logic each frame
    Task.Wait(0.25)
end
```

See also: [CoreObject.GetWorldPosition](coreobject.md) | [DamageableObject.isDead](damageableobject.md) | [Vector3.z](vector3.md)

---

Example using:

### `hitPoints`

### `maxHitPoints`

### `isDead`

Physics Objects are also of type `Damageable`. In this example, a progress bar is used to display the object's hit points. In case the object is dead, then the progress bar will be empty.

```lua
local PHYSICS_OBJECT = script:GetCustomProperty("PhysicsObject"):WaitForObject()
local UI_PROGRESS_BAR = script:GetCustomProperty("UIProgressBar"):WaitForObject()

function Tick()
    local percent = 0
    if PHYSICS_OBJECT.maxHitPoints > 0 and not PHYSICS_OBJECT.isDead then
        percent = PHYSICS_OBJECT.hitPoints / PHYSICS_OBJECT.maxHitPoints
        percent = CoreMath.Clamp(percent)
    end
    UI_PROGRESS_BAR.progress = percent
end
```

See also: [UIProgressBar.progress](uiprogressbar.md) | [CoreMath.Clamp](coremath.md) | [CoreObject.GetCustomProperty](coreobject.md) | [CoreObjectReference.WaitForObject](coreobjectreference.md)

---

Example using:

### `isImmortal`

### `isInvulnerable`

This example demonstrates an architecture for keeping track of temporary status effects or buffs. Two functions are implemented for Physics Objects, MakeImmortal() and MakeInvulnerable(). Because the functions may be called multiple times with overlapping durations, it's important to keep count of the number of active copies of the effect and only revert the property when the counter returns to zero.

```lua
local PHYSICS_OBJECT = script:GetCustomProperty("PhysicsObject"):WaitForObject()

-- Makes the object immortal for a given duration
function MakeImmortal(duration)
    PHYSICS_OBJECT.isImmortal = true
    local cleanup = CountAndWait("immortal", duration)
    if cleanup then
        PHYSICS_OBJECT.isImmortal = false
    end
end

-- Makes the object invulnerable for a given duration
function MakeInvulnerable(duration)
    PHYSICS_OBJECT.isInvulnerable = true
    local cleanup = CountAndWait("invulnerable", duration)
    if cleanup then
        PHYSICS_OBJECT.isInvulnerable = false
    end
end

-- Function common to both implementations. Yields the thread
-- Returns True if no copies of the effect remain
local function CountAndWait(effectId, duration)
    local userData = PHYSICS_OBJECT.serverUserData
    if not userData[effectId] then
        userData[effectId] = 0
    end
    userData[effectId] = userData[effectId] + 1
    
    Task.Wait(duration)
    
    userData[effectId] = userData[effectId] - 1
    return userData[effectId] <= 0
end

-- Utility function that says if a specific effect is active or not
function IsActive(effectId)
    local userData = PHYSICS_OBJECT.serverUserData
    return userData[effectId] and userData[effectId] > 0
end

-- Utility function that gives the current count for a given effect
function GetEffectCount(effectId)
    local userData = PHYSICS_OBJECT.serverUserData
    if userData[effectId] then
        return userData[effectId]
    end
    return 0
end
```

See also: [CoreObject.serverUserData](coreobject.md) | [Task.Wait](task.md)

---

Example using:

### `isTeamCollisionEnabled`

### `isEnemyCollisionEnabled`

In this example, a Physics Sphere can be given a special "ghost" ability. During this effect, the sphere cannot be touched by enemies and goes straight through them. At the end of the effect collision with enemies is restored, but then collision with allies is disabled for a short period, as a drawback to the powerful effect. This effect depends on a team value having been assigned to the object previously. If the sphere's team is still 0 (default), then nothing should happen.

```lua
local PHYSICS_SPHERE = script.parent

local GHOST_DURATION_ENEMY = 1.5
local GHOST_DURATION_ALLY = 1

local isSuper = false

function MakeGhostBall()
    if isSuper then return end
    isSuper = true
    
    PHYSICS_SPHERE.isEnemyCollisionEnabled = false
    
    Task.Wait(GHOST_DURATION_ENEMY)
    
    PHYSICS_SPHERE.isEnemyCollisionEnabled = true
    PHYSICS_SPHERE.isTeamCollisionEnabled = false
    
    Task.Wait(GHOST_DURATION_ALLY)
    
    PHYSICS_SPHERE.isTeamCollisionEnabled = true
    isSuper = true
end
```

See also: [CoreObject.parent](coreobject.md) | [Task.Wait](task.md)

---

Example using:

### `team`

### `collidedEvent`

In this example, a Physics Sphere detects players bumping into it. Each time a player collides with the sphere its team is changed to equal the player's team. In the sphere's client context, an additional script keeps a watch on changes to the team property and adjusts the mesh's team to equal that of the physics object. This results in the sphere changing color to blue/red, depending on who touched it last.

```lua
-- Server script
local PHYSICS_SPHERE = script.parent

function OnPhysicsCollided(ball, hitResult)
    if hitResult.other:IsA("Player") then
        ball.team = hitResult.other.team
    end
end

PHYSICS_SPHERE.collidedEvent:Connect(OnPhysicsCollided)

-- Client script
local PHYSICS_SPHERE = script:GetCustomProperty("PhysicsSphere"):WaitForObject()
local PHYSICS_SPHERE_MESH = script:GetCustomProperty("PhysicsSphereMesh"):WaitForObject()

function Tick()
    if PHYSICS_SPHERE.team == 0 then
        PHYSICS_SPHERE_MESH.isTeamColorUsed = false
    else
        PHYSICS_SPHERE_MESH.isTeamColorUsed = true
        PHYSICS_SPHERE_MESH.team = PHYSICS_SPHERE.team
    end
    Task.Wait(0.1)
end
```

See also: [CoreMesh.isTeamColorUsed](coremesh.md) | [Player.team](player.md) | [HitResult.other](hitresult.md) | [Task.Wait](task.md) | [Event.Connect](event.md)

---
