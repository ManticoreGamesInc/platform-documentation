---
id: abilitytarget
name: AbilityTarget
title: AbilityTarget
tags:
    - API
---

# AbilityTarget

A data type containing information about what the Player has targeted during a phase of an Ability.

## Constructors

| Constructor Name | Return Type | Description | Tags |
| ----------- | ----------- | ----------- | ---- |
| `AbilityTarget.New()` | [`AbilityTarget`](abilitytarget.md) | Constructs a new Ability Target data object. | None |

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `hitObject` | [`Object`](object.md) | Object under the reticle, or center of the screen if no reticle is displayed. Can be a Player, StaticMesh, etc. | Read-Write |
| `hitPlayer` | [`Player`](player.md) | Convenience property that is the same as hitObject, but only if hitObject is a Player. | Read-Write |
| `spreadHalfAngle` | `Number` | Half-angle of cone of possible target space, in degrees. | Read-Write |
| `spreadRandomSeed` | `Integer` | Seed that can be used with RandomStream for deterministic RNG. | Read-Write |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetOwnerMovementRotation()` | [`Rotation`](rotation.md) | Gets the direction the Player is moving. | None |
| `SetOwnerMovementRotation(Rotation)` | `None` | Sets the direction the Player faces, if `Ability.facingMode` is set to `AbilityFacingMode.MOVEMENT`. | None |
| `GetAimPosition()` | [`Vector3`](vector3.md) | Returns the world space position of the camera. | None |
| `SetAimPosition(Vector3)` | `None` | The world space location of the camera. Setting this currently has no effect on the Player's camera. | None |
| `GetAimDirection()` | [`Vector3`](vector3.md) | Returns the direction the camera is facing. | None |
| `SetAimDirection(Vector3)` | `None` | Sets the direction the camera is facing. | None |
| `GetHitPosition()` | [`Vector3`](vector3.md) | Returns the world space position of the object under the Player's reticle. If there is no object, a position under the reticle in the distance. If the Player doesn't have a reticle displayed, uses the center of the screen as if there was a reticle there. | None |
| `SetHitPosition(Vector3)` | `None` | Sets the hit position property. This may affect weapon behavior. | None |
| `GetHitResult()` | [`HitResult`](hitresult.md) | Returns physics information about the point being targeted | None |

## Examples

Using:

- `New`

The ability's targeting data can be generated programatically, for specific results. In this example, We create a target that is always at the world origin (Vector3.ZERO). If added to a rifle's Shoot ability, all shots will go to (0,0,0). For this to work the script should be placed in a client context under the ability. The ability should also have the option "Is Target Data Update" turned off for the Execute phase, otherwise any data set programatically will be overwritten when the phase changes.

```lua
local abilityTarget = AbilityTarget.New()
abilityTarget:SetHitPosition(Vector3.ZERO)

local ability = script:FindAncestorByType("Ability")

function OnCast(ability)
    ability:SetTargetData(abilityTarget)
end

ability.castEvent:Connect(OnCast)
```

See also: [AbilityTarget.SetHitPosition](abilitytarget.md) | [CoreObject.FindAncestorByType](coreobject.md) | [World.SpawnAsset](world.md) | [Ability.SetTargetData](ability.md) | [Event.Connect](event.md)

---

Using:

- `GetAimPosition`
- `GetAimDirection`

In this example, a non-weapon ability needs to know where the player is aiming in order to spawn the effect correctly. It creates an effect that moves down the center of where the camera is aiming. However, if the effect were to begin at the camera's position that could be weird in a third-person game. Instead, the player's position is projected onto the camera's vector to determine a more suitable starting point.

```lua
local ability = script:FindAncestorByType("Ability")

function ProjectPointOnLine(p, linePoint, lineDirection)
    local lineToP = p - linePoint
    return linePoint + (lineToP..lineDirection) / (lineDirection..lineDirection) * lineDirection
end

function OnExecute(ability)
    local targetData = ability:GetTargetData()

    -- Project the player's position onto the camera vector, to get a starting point for the effect
    local playerPos = ability.owner:GetWorldPosition()
    local aimPosition = targetData:GetAimPosition()
    local aimDirection = targetData:GetAimDirection()
    local playerProjection = ProjectPointOnLine(playerPos, aimPosition, aimDirection)

    -- Placeholder for some ability effect. Draw a red line 9 meters long
    local params = {duration = 3, color = Color.RED, thickness = 3}
    CoreDebug.DrawLine(playerProjection, playerProjection + aimDirection * 900, params)
end

ability.executeEvent:Connect(OnExecute)
```

See also: [CoreObject.FindAncestorByType](coreobject.md) | [World.SpawnAsset](world.md) | [Vector3 - Vector3](vector3.md) | [Ability.GetTargetData](ability.md) | [Player.GetWorldPosition](player.md) | [Color.RED](color.md) | [CoreDebug.DrawLine](coredebug.md) | [Event.Connect](event.md)

---

Using:

- `GetHitPosition`
- `SetHitPosition`

The ability's targeting data gives a lot of information about where and what the player is aiming at. If setup correctly, it can also be modified programatically. In this example, the Z position of the target is flattened horizontally. Useful, for example, in a top-down shooter. For this to work it should be placed in a client context under the ability. The ability should also have the option "Is Target Data Update" turned off for the Execute phase, otherwise any data set programatically will be overwritten when the phase changes.

```lua
local ability = script:FindAncestorByType("Ability")

function OnCast(ability)
    local abilityTarget = ability:GetTargetData()
    local pos = abilityTarget:GetHitPosition()

    pos.z = ability.owner:GetWorldPosition().z + 50

    abilityTarget:SetHitPosition(pos)
    ability:SetTargetData(abilityTarget)
end

ability.castEvent:Connect(OnCast)
```

See also: [CoreObject.FindAncestorByType](coreobject.md) | [World.SpawnAsset](world.md) | [Ability.GetTargetData](ability.md) | [Vector3.z](vector3.md) | [Player.GetWorldPosition](player.md) | [Event.Connect](event.md)

---

Using:

- `GetHitResult`

At any phase of an ability's activation, you can get data about what is under the cursor and would be hit.

This code snippet prints out the name of whatever was under the cursor when the player executes this ability!

```lua
local ability = script:FindAncestorByType("Ability")

function OnExecute(ability)
    local hr = ability:GetTargetData():GetHitResult()
    if hr.other then
        print("You shot " .. hr.other.name)
    else
        print("You didn't hit anything...")
    end
end

ability.executeEvent:Connect(OnExecute)
```

See also: [CoreObject.FindAncestorByType](coreobject.md) | [World.SpawnAsset](world.md) | [Ability.owner](ability.md) | [HitResult.other](hitresult.md) | [Player.name](player.md) | [Event.Connect](event.md) | [CoreLua.print](coreluafunctions.md)

---

Using:

- `hitObject`
- `hitPlayer`

In this example, an ability casts a magical area of effect (AOE) in front of the player. In case the player was aiming at another player or object that position is used instead.

```lua
local ability = script:FindAncestorByType("Ability")
local AOE_ASSET = script:GetCustomProperty("AOEAsset")

function OnExecute(ability)
    -- The default position to spawn at
    local ownerForwardVect = ability.owner:GetWorldTransform():GetForwardVector()
    local spawnPos = ability.owner:GetWorldPosition() + ownerForwardVect * 600 - Vector3.UP * 50

    -- Consider alternate positions based on the ability's targeting information
    local targetData = ability:GetTargetData()
    if targetData.hitPlayer then
        spawnPos = targetData.hitPlayer:GetWorldPosition()

    elseif targetData.hitObject then
        spawnPos = targetData:GetHitPosition()
    end

    -- Spawn the AOE object
    local instance = World.SpawnAsset(AOE_ASSET, {position = spawnPos})
    -- Give the AOE object a reference back to this ability. E.g. if the AOE kills an enemy,
    -- then it has enough information to correctly attribute a score increase.
    instance.serverUserData.sourceAbility = ability
end

ability.executeEvent:Connect(OnExecute)
```

See also: [CoreObject.FindAncestorByType](coreobject.md) | [World.SpawnAsset](world.md) | [Ability.owner](ability.md) | [Player.GetWorldTransform](player.md) | [Transform.GetForwardVector](transform.md) | [Vector3.UP](vector3.md) | [AbilityTarget.GetHitPosition](abilitytarget.md) | [Object.serverUserData](object.md) | [Event.Connect](event.md)

---
