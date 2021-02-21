---
id: weapon
name: Weapon
title: Weapon
tags:
    - API
---

# Weapon

A Weapon is an Equipment that comes with built-in Abilities and fires Projectiles.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `animationStance` | `string` | When the Weapon is equipped this animation stance is applied to the Player. | Read-Only |
| `attackCooldownDuration` | `number` | Interval between separate burst sequences. The value is set by the Shoot ability's Cooldown duration. | Read-Only |
| `multiShotCount` | `integer` | Number of Projectiles/Hitscans that will fire simultaneously inside the spread area each time the Weapon attacks. Does not affect the amount of ammo consumed per attack. | Read-Only |
| `burstCount` | `integer` | Number of automatic activations of the Weapon that generally occur in quick succession. | Read-Only |
| `shotsPerSecond` | `number` | Used in conjunction with burstCount to determine the interval between automatic weapon activations. | Read-Only |
| `shouldBurstStopOnRelease` | `boolean` | If `true`, a burst sequence can be interrupted by the Player by releasing the action button. If `false`, the burst continues firing automatically until it completes or the Weapon runs out of ammo. | Read-Only |
| `isHitscan` | `boolean` | If `false`, the Weapon will produce simulated Projectiles. If `true`, it will instead use instantaneous line traces to simulate shots. | Read-Only |
| `range` | `number` | Max travel distance of the Projectile (isHitscan = False) or range of the line trace (isHitscan = True). | Read-Only |
| `damage` | `number` | Damage applied to a Player when the weapon attack hits a player target. If set to zero, no damage is applied. | Read-Only |
| `projectileTemplateId` | `string` | Asset reference for the visual body of the Projectile, for non-hitscan Weapons. | Read-Only |
| `muzzleFlashTemplateId` | `string` | Asset reference for a Vfx to be attached to the muzzle point each time the Weapon attacks. | Read-Only |
| `trailTemplateId` | `string` | Asset reference for a trail Vfx to follow the trajectory of the shot. | Read-Only |
| `beamTemplateId` | `string` | Asset reference for a beam Vfx to be placed along the trajectory of the shot. Useful for hitscan Weapons or very fast Projectiles. | Read-Only |
| `impactSurfaceTemplateId` | `string` | Asset reference of a Vfx to be attached to the surface of any CoreObjects hit by the attack. | Read-Only |
| `impactProjectileTemplateId` | `string` | Asset reference of a Vfx to be spawned at the interaction point. It will be aligned with the trajectory. If the impacted object is a CoreObject, then the Vfx will attach to it as a child. | Read-Only |
| `impactPlayerTemplateId` | `string` | Asset reference of a Vfx to be spawned at the interaction point, if the impacted object is a player. | Read-Only |
| `projectileSpeed` | `number` | Travel speed (cm/s) of Projectiles spawned by this weapon. | Read-Only |
| `projectileLifeSpan` | `number` | Duration after which Projectiles are destroyed. | Read-Only |
| `projectileGravity` | `number` | Gravity scale applied to spawned Projectiles. | Read-Only |
| `projectileLength` | `number` | Length of the Projectile's capsule collision. | Read-Only |
| `projectileRadius` | `number` | Radius of the Projectile's capsule collision | Read-Only |
| `projectileDrag` | `number` | Drag on the Projectile. | Read-Only |
| `projectileBounceCount` | `integer` | Number of times the Projectile will bounce before it's destroyed. Each bounce generates an interaction event. | Read-Only |
| `projectilePierceCount` | `integer` | Number of objects that will be pierced by the Projectile before it's destroyed. Each pierce generates an interaction event. | Read-Only |
| `maxAmmo` | `integer` | How much ammo the Weapon starts with and its max capacity. If set to -1 then the Weapon has infinite capacity and doesn't need to reload. | Read-Only |
| `currentAmmo` | `integer` | Current amount of ammo stored in this Weapon. | Read-Write |
| `ammoType` | `string` | A unique identifier for the ammunition type. | Read-Only |
| `isAmmoFinite` | `boolean` | Determines where the ammo comes from. If `true`, then ammo will be drawn from the Player's Resource inventory and reload will not be possible until the Player acquires more ammo somehow. If `false`, then the Weapon simply reloads to full and inventory Resources are ignored. | Read-Only |
| `outOfAmmoSoundId` | `string` | Asset reference for a sound effect to be played when the Weapon tries to activate, but is out of ammo. | Read-Only |
| `reloadSoundId` | `string` | Asset reference for a sound effect to be played when the Weapon reloads ammo. | Read-Only |
| `spreadMin` | `number` | Smallest size in degrees for the Weapon's cone of probability space to fire Projectiles in. | Read-Only |
| `spreadMax` | `number` | Largest size in degrees for the Weapon's cone of probability space to fire Projectiles in. | Read-Only |
| `spreadAperture` | `number` | The surface size from which shots spawn. An aperture of zero means shots originate from a single point. | Read-Only |
| `spreadDecreaseSpeed` | `number` | Speed at which the spread contracts back from its current value to the minimum cone size. | Read-Only |
| `spreadIncreasePerShot` | `number` | Amount the spread increases each time the Weapon attacks. | Read-Only |
| `spreadPenaltyPerShot` | `number` | Cumulative penalty to the spread size for successive attacks. Penalty cools off based on `spreadDecreaseSpeed`. | Read-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `HasAmmo()` | `boolean` | Informs whether the Weapon is able to attack or not. | None |
| `Attack(target)` | `None` | Triggers the main ability of the Weapon. Optional target parameter can be a Vector3 world position, a Player, or a CoreObject. | None |

## Events

| Event Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `targetImpactedEvent` | `Event<`[`Weapon`](weapon.md), [`ImpactData`](impactdata.md)`>` | Fired when a Weapon interacts with something. E.g. a shot hits a wall. The `ImpactData` parameter contains information such as which object was hit, who owns the Weapon, which ability was involved in the interaction, etc. | Server-Only |
| `projectileSpawnedEvent` | `Event<`[`Weapon`](weapon.md), [`Projectile`](projectile.md)`>` | Fired when a Weapon spawns a projectile. | None |

## Examples

Using:

- `projectileSpawnedEvent`

Although it is ineffective to modify a projectile that comes through the `projectileSpawnedEvent`, it's still a useful event for various gameplay mechanics. In this example, a weapon script adds recoil impulse in the opposite direction of shots.

```lua
local WEAPON = script:FindAncestorByType('Weapon')
local KNOCKBACK_SPEED = 1000

-- Adds impulse to the owner once the attack ability is executed
function OnProjectileSpawned(weapon, projectile)
    local player = weapon.owner

    local projectileDirection = projectile:GetWorldTransform():GetForwardVector()
    local knockbackVector = projectileDirection * player.mass * -KNOCKBACK_SPEED

    -- Push the player away from the spawned projectile
    player:AddImpulse(knockbackVector)
end

WEAPON.projectileSpawnedEvent:Connect(OnProjectileSpawned)
```

See also: [Equipment.owner](equipment.md) | [Player.AddImpulse](player.md) | [CoreObject.FindAncestorByType](coreobject.md) | [Projectile.GetWorldTransform](projectile.md) | [Transform.GetForwardVector](transform.md) | [Vector3 * Number](vector3.md)

---

Using:

- `targetImpactedEvent`

In this example, a weapon has a healing mechanic, where the player gains 2 hit points each time they shoot an enemy player.

```lua
local WEAPON = script:FindAncestorByType('Weapon')

function OnTargetImpactedEvent(weapon, impactData)
    if ImpactData.targetObject and ImpactData.targetObject:IsA("Player") then
        weapon.owner.hitPoints = weapon.owner.hitPoints + 2
    end
end

WEAPON.targetImpactedEvent:Connect(OnTargetImpactedEvent)
```

See also: [Equipment.owner](equipment.md) | [CoreObject.FindAncestorByType](coreobject.md) | [ImpactData.targetObject](impactdata.md) | [other.IsA](other.md) | [Player.hitPoints](player.md) | [Event.Connect](event.md)

---

Using:

- `Attack`

Generally, weapons are thought to be equipped on players. However, a weapon can be used on an NPC such as a vehicle or tower by calling the `Attack()` function. In this example, a weapon simply fires each second. Shots will go out straight in the direction the weapon is pointing.

```lua
local WEAPON = script:FindAncestorByType('Weapon')

function Tick()
    WEAPON:Attack()
    Task.Wait(1)
end
```

See also: [CoreObject.FindAncestorByType](coreobject.md) | [CoreLua.Tick](coreluafunctions.md) | [Task.Wait](task.md)

---

Using:

- `HasAmmo`

In this example, a custom sound is played when someone picks up a weapon that has no ammo in it. For this hypothetical game, weapons can be found without any ammo and it's an important mechanic. It should be displayed in the user interface. However, players hear sound effects much faster than they can read UI.

```lua
local WEAPON = script:FindAncestorByType('Weapon')
local EMPTY_PICKUP_SOUND = script:GetCustomProperty("EmptyPickupSound")

function OnEquipped(weapon, player)
    if (not weapon:HasAmmo()) then
        World.SpawnAsset(EMPTY_PICKUP_SOUND, {position = weapon:GetWorldPosition()})
    end
end

WEAPON.equippedEvent:Connect(OnEquipped)
```

See also: [Equipment.equippedEvent](equipment.md) | [CoreObject.FindAncestorByType](coreobject.md) | [World.SpawnAsset](world.md) | [Event.Connect](event.md)

---

Using:

- `ammoType`

In this simple auto-reload script, the weapon's current ammo is monitored. If it goes to zero and the player has ammo of the correct type, then the reload ability is activated. This script only works in a client-context and expects the Reload ability to be assigned as a custom property.

```lua
local WEAPON = script:FindAncestorByType('Weapon')
local RELOAD_ABILITY = script:GetCustomProperty("Reload"):WaitForObject()

local LOCAL_PLAYER = Game.GetLocalPlayer()

function Tick(deltaTime)
    if WEAPON.owner ~= LOCAL_PLAYER then return end

    if WEAPON.currentAmmo == 0 and
    (not WEAPON.isAmmoFinite or LOCAL_PLAYER:GetResource(WEAPON.ammoType) > 0) then

        RELOAD_ABILITY:Activate()

        Task.Wait(
            RELOAD_ABILITY.castPhaseSettings.duration +
            RELOAD_ABILITY.executePhaseSettings.duration +
            RELOAD_ABILITY.recoveryPhaseSettings.duration)
    end
end
```

See also: [Weapon.currentAmmo](weapon.md) | [Equipment.owner](equipment.md) | [Ability.Activate](ability.md) | [AbilityPhaseSettings.duration](abilityphasesettings.md) | [CoreObject.FindAncestorByType](coreobject.md) | [CoreObjectReference.WaitForObject](coreobjectreference.md) | [Game.GetLocalPlayer](game.md) | [Player.GetResource](player.md) | [Task.Wait](task.md) | [CoreLua.Tick](coreluafunctions.md)

---

Using:

- `animationStance`

A weapon's `animationStance` is assigned to the player automatically when the item is equipped. In this example, we add an additional stance to the weapon in the form of a defensive posture that players can trigger by holding down the secondary ability button (mouse right-click). The script alternates between the shield block stance and the weapon's default stance, as the secondary button is pressed/released.

```lua
local WEAPON = script:FindAncestorByType('Weapon')
local ACTION_BINDING = "ability_secondary"
local ACTIVE_STANCE = "1hand_melee_shield_block"

function EnableStance(player)
    if Object.IsValid(player) and player == WEAPON.owner then
        player.animationStance = ACTIVE_STANCE
    end
end

function DisableStance(player)
    if WEAPON and Object.IsValid(player) then
        player.animationStance = WEAPON.animationStance
    end
end

function OnBindingPressed(player, actionName)
    if actionName == ACTION_BINDING then
        EnableStance(player)
    end
end

function OnBindingReleased(player, actionName)
    if actionName == ACTION_BINDING then
        DisableStance(player)
    end
end

function OnPlayerDied(player, damage)
    DisableStance(player)
end

function OnEquipped(weapon, player)
    player.bindingPressedEvent:Connect(OnBindingPressed)
    player.bindingReleasedEvent:Connect(OnBindingReleased)
end

WEAPON.equippedEvent:Connect(OnEquipped)
```

See also: [Equipment.equippedEvent](equipment.md) | [Player.animationStance](player.md) | [CoreObject.FindAncestorByType](coreobject.md) | [Object.IsValid](object.md) | [Event.Connect](event.md)

---

Using:

- `attackCooldownDuration`
- `multiShotCount`
- `burstCount`
- `shotsPerSecond`

The following function approximates a weapon's effective damage per second (DPS).

```lua
local WEAPON = script:FindAncestorByType("Weapon")

function ComputeDPS(weapon)
    local dps = 6.2
    while weapon.shotsPerSecond < dps do
        dps = dps / 2
    end

    local burst = math.max(1, weapon.burstCount)
    if burst < weapon.maxAmmo or weapon.maxAmmo <= 0 then
        local burstPeriod = (burst / dps + weapon.attackCooldownDuration)
        dps = burst / burstPeriod
    end

    return dps * weapon.damage * weapon.multiShotCount
end

print("DPS = " .. ComputeDPS(WEAPON))
```

See also: [Weapon.maxAmmo](weapon.md) | [CoreObject.FindAncestorByType](coreobject.md) | [CoreLua.print](coreluafunctions.md)

---

Using:

- `currentAmmo`
- `maxAmmo`

This script plays audio to the weapon owner when the weapon reaches 20% amount of ammo. It works best if the script is in a client context under the weapon, that way the audio is heard only by the player who is using the weapon.

```lua
local WEAPON = script:FindAncestorByType('Weapon')
local SHOOT_ABILITY = script:GetCustomProperty("ShootAbility"):WaitForObject()
local LOW_AMMO_SOUND = WEAPON:GetCustomProperty("LowAmmoSound")
local LOW_AMMO_PERCENTAGE = 0.2

function OnShootExecute(ability)
    if Object.IsValid(WEAPON) and ability.owner == WEAPON.owner then
        if WEAPON.currentAmmo / WEAPON.maxAmmo <= LOW_AMMO_PERCENTAGE then
            if LOW_AMMO_SOUND then
                World.SpawnAsset(LOW_AMMO_SOUND, {position = WEAPON:GetWorldPosition()})
            end
        end
    end
end

SHOOT_ABILITY.executeEvent:Connect(OnShootExecute)
```

See also: [Equipment.owner](equipment.md) | [Ability.owner](ability.md) | [CoreObject.FindAncestorByType](coreobject.md) | [CoreObjectReference.WaitForObject](coreobjectreference.md) | [Object.IsValid](object.md) | [World.SpawnAsset](world.md) | [Event.Connect](event.md)

---

Using:

- `isAmmoFinite`
- `reloadSoundId`

While various properties are read-only, they are still useful in determining what behavior should occur, leading to more general purpose scripts. In this example, a script controls auto-reloading of weapons. It expects to be in a client context, because the ability's `Activate()` function is client-only.

```lua
local WEAPON = script:FindAncestorByType('Weapon')

local RELOAD_ABILITY = nil
-- Grabs reload ability from the weapon. Keep trying in case the client hasn't loaded the object yet
while not Object.IsValid(RELOAD_ABILITY) do
    Task.Wait()
    RELOAD_ABILITY = WEAPON:GetAbilities()[2]
end
-- The client script can now keep going, after it has acquired a reference to the reload ability
-- The above could also have been implemented with a :GetCustomProperty(...):WaitForObject()

-- Manually spawn the reloading audio
function SpawnReloadingAudio()
    if WEAPON.reloadSoundId ~= nil then
        World.SpawnAsset(WEAPON.reloadSoundId, {position = WEAPON:GetWorldPosition()})
    end
end

function Tick(deltaTime)

    -- Makes sure that the weapon owner is the local player
    if not Object.IsValid(WEAPON) then return end
    if not WEAPON.owner == Game.GetLocalPlayer() then return end

    if not WEAPON.isAmmoFinite then
        -- Checks when the weapon has empty ammo to reload
        if WEAPON.currentAmmo == 0 then
            SpawnReloadingAudio()
            RELOAD_ABILITY:Activate()
            Task.Wait(RELOAD_ABILITY.castPhaseSettings.duration)
        end
    end
end
```

See also: [Weapon.GetAbilities](weapon.md) | [Equipment.owner](equipment.md) | [Ability.Activate](ability.md) | [AbilityPhaseSettings.duration](abilityphasesettings.md) | [Game.GetLocalPlayer](game.md) | [CoreObject.FindAncestorByType](coreobject.md) | [World.SpawnAsset](world.md) | [Object.IsValid](object.md) | [Task.Wait](task.md) | [CoreLua.Tick](coreluafunctions.md)

---

Using:

- `isHitscan`
- `range`
- `damage`
- `projectileTemplateId`
- `trailTemplateId`
- `impactSurfaceTemplateId`
- `impactProjectileTemplateId`
- `impactPlayerTemplateId`
- `projectileSpeed`
- `projectileLifeSpan`
- `projectileGravity`
- `projectileLength`
- `projectileRadius`
- `projectileDrag`

This script implements a Wall Bang mechanic, allowing shots to go through walls.

Configuring walls/objects to be penetrable: For each wall or object that should be penetrable, add to them the "WallBang" custom property (float). Only objects with this property will be penetrable. Higher values mean the wall reduces more damage from shots that go through them. Objects with a "WallBang" value of 0 will let shots through but will not affect the damage amount.

Configuring this script on a weapon: Set this script's "WallBang" property to affect the weapon's penetrability when it's compared against objects. A higher value means it penetrates tougher walls and takes less damage reduction. A weapon can further control how much of its damage is reduced by setting the "DamageReduction" property on this script (Between zero and 1).

```lua
local WEAPON = script:FindAncestorByType("Weapon")
local WALL_BANG = script:GetCustomProperty("WallBang") or 2
local DAMAGE_REDUCTION = script:GetCustomProperty("DamageReduction") or 1

if WALL_BANG <= 0 then return end

function OnTargetImpactedEvent(weapon, impactData)
    if not Object.IsValid(weapon) then return end

    local wall = impactData.targetObject
    if not wall or not wall:IsA("StaticMesh") then return end

    -- If the wall hasn't defined the WallBang property it's impenetrable
    local wallBangResistance = wall:GetCustomProperty("WallBang")
    if not wallBangResistance or wallBangResistance >= WALL_BANG then return end

    -- Calculate damage
    local damage = weapon.damage
    if DAMAGE_REDUCTION > 0 then
        local percent = (WALL_BANG - wallBangResistance) / WALL_BANG
        damage = CoreMath.Lerp(0, weapon.damage, percent)

        percent = CoreMath.Clamp(DAMAGE_REDUCTION)
        damage = CoreMath.Lerp(weapon.damage, damage, percent)
    end

    -- Gather info about position and direction of the shot
    local impactPos = impactData:GetHitResult():GetImpactPosition()
    local direction = impactPos - weapon:GetWorldPosition()
    local remainingTravel = weapon.range - impactData.travelDistance

    -- TODO : Perhaps do more if the weapon is of hitscan type
    if not weapon.isHitscan then
        if impactData.projectile then
            direction = impactData.projectile:GetVelocity()
        end
    end
    direction = direction:GetNormalized()

    -- Do a series of raycasts to figure out where is the bullet's exit point
    local rayStart = impactPos + direction * 5
    local rayEnd = rayStart + direction * remainingTravel
    local rayParams = {}

    if Object.IsValid(impactData.weaponOwner) and impactData.weaponOwner.team > 0 then
        rayParams.ignoreTeams = weapon.owner.team
    end

    local hit = World.Raycast(rayStart, rayEnd, rayParams)
    if hit then
        rayEnd = rayStart
        rayStart = hit:GetImpactPosition()
    else
        local swapValue = rayEnd
        rayEnd = rayStart
        rayStart = swapValue
    end
    -- The 'hitInverted' is the info about the bullet's exit point
    local hitInverted = World.Raycast(rayStart, rayEnd, rayParams)
    if not hitInverted then return end

    -- Spawn the surface impact VFX on the opposite side of the object
    if weapon.impactSurfaceTemplateId then
        local t = hitInverted:GetTransform()
        SpawnVfx(weapon.impactSurfaceTemplateId, t:GetPosition(), t:GetRotation())
    end

    -- Spawn a new projectile to continue on the trajectory
    local projLength = 5 + weapon.projectileLength + weapon.projectileRadius
    startPos = hitInverted:GetImpactPosition() + direction * projLength
    local projectile = Projectile.Spawn(weapon.projectileTemplateId, startPos, direction)
    -- Copy properties from the weapon to the new projectile
    projectile.owner = impactData.weaponOwner
    projectile.sourceAbility = impactData.sourceAbility
    projectile.speed = weapon.projectileSpeed
    projectile.gravityScale = weapon.projectileGravity
    projectile.drag = weapon.projectileDrag
    projectile.lifeSpan = weapon.projectileLifeSpan * remainingTravel / weapon.range
    projectile.capsuleLength = weapon.projectileLength
    projectile.capsuleRadius = weapon.projectileRadius
    -- If some weapon properties are needed later it's safer to stash them in serverUserData,
    -- because the weapon might be destroyed while the projectile is still in the air:
    projectile.serverUserData.impactSurfaceTemplateId = weapon.impactSurfaceTemplateId
    projectile.serverUserData.impactPlayerTemplateId = weapon.impactPlayerTemplateId
    projectile.serverUserData.impactProjectileTemplateId = weapon.impactProjectileTemplateId
    projectile.serverUserData.direction = direction
    -- Store damage calculation onto the projectile because there may be multiple ones
    projectile.serverUserData.damage = damage

    -- Listen for the impact, to spawn effects and apply damage
    projectile.impactEvent:Connect(OnProjectileImpacted)

    -- Spawn a trail to follow the projectile
    if weapon.trailTemplateId and projectile.speed > 0 then
        local pos = hitInverted:GetImpactPosition()
        local trailLifeSpan = (rayStart - pos).size / projectile.speed
        trailLifeSpan = math.min(projectile.lifeSpan, trailLifeSpan)
        if trailLifeSpan > 0 then
            local rot = Rotation.New(direction, Vector3.UP)
            local trail = World.SpawnAsset(weapon.trailTemplateId, {position = pos, rotation = rot})
            trail:MoveContinuous(direction * projectile.speed)
            trail.lifeSpan = trailLifeSpan
        end
    end
end

function OnProjectileImpacted(projectile, other, hitResult)
    if not Object.IsValid(projectile) then return end

    local impactTemplate = nil

    if other:IsA("Player") then
        -- Construct and apply damage to player
        local dmg = Damage.New(projectile.serverUserData.damage)
        dmg.reason = DamageReason.COMBAT
        dmg:SetHitResult(hitResult)
        dmg.sourceAbility = projectile.sourceAbility
        dmg.sourcePlayer = projectile.owner
        other:ApplyDamage(dmg)

        impactTemplate = projectile.serverUserData.impactPlayerTemplateId
    else
        impactTemplate = projectile.serverUserData.impactSurfaceTemplateId
       end

    -- Spawn impact VFX
    local t = hitResult:GetTransform()
    if impactTemplate then
        SpawnVfx(impactTemplate, t:GetPosition(), t:GetRotation())
    end

    impactTemplate = projectile.serverUserData.impactProjectileTemplateId
    if impactTemplate then
        local rot = Rotation.New(projectile.serverUserData.direction, Vector3.UP)
        SpawnVfx(impactTemplate, t:GetPosition(), rot)
    end
end

function SpawnVfx(template, pos, rot)
    local vfx = World.SpawnAsset(template, {position = pos, rotation = rot})
    if vfx.lifeSpan <= 0 then
        vfx.lifeSpan = 1.2
    end
end

WEAPON.targetImpactedEvent:Connect(OnTargetImpactedEvent)
```

See also: [Weapon.targetImpactedEvent](weapon.md) | [World.Raycast](world.md) | [ImpactData.targetObject](impactdata.md) | [HitResult.GetImpactPosition](hitresult.md) | [Projectile.Spawn](projectile.md) | [Damage.New](damage.md) | [Player.team](player.md) | [CoreObject.FindAncestorByType](coreobject.md) | [Object.serverUserData](object.md) | [other.isA](other.md) | [CoreMath.Lerp](coremath.md) | [Vector3.GetNormalized](vector3.md) | [Rotation.New](rotation.md) | [Transform.GetPosition](transform.md) | [Event.Connect](event.md)

---

Using:

- `muzzleFlashTemplateId`

This sample demonstrates several things. First, it creates a copy of the weapon's muzzle flash effect and attaches it to where the script is. Then, it shows how to traverse an object's hierarchy and create a custom table of objects to operate upon later--in this case it's trying to find smart objects that have both the `Stop()` and `Play()` functions. Finally, It shows how sound and VFX from a single spawned template can be played and stopped randomly--in other words, they are reused without having to spawn a new copy of the template each time.

```lua
local WEAPON = script:FindAncestorByType("Weapon")

if WEAPON.muzzleFlashTemplateId == nil then return end

local smartObjects = {}

local muzzleInstance = World.SpawnAsset(WEAPON.muzzleFlashTemplateId, {parent = script})

-- A utility function that runs the same operation on all nodes in an object's hierarchy
function ForEachChild(coreObj, functionToCall)
    functionToCall(coreObj)

    for _, child in ipairs(coreObj:GetChildren()) do
        ForEachChild(child, functionToCall)
    end
end

-- Find all the core objects in the template that have both the Play() and Stop() functions
ForEachChild(muzzleInstance, function(coreObj)
    if coreObj.Play and coreObj.Stop then
        table.insert(smartObjects, coreObj)
        coreObj:Stop()
    end
end)

while true do
    -- Wait between 0 and 1 second
    Task.Wait(math.random())

    -- Play all the effects
    for _, obj in ipairs(smartObjects) do
        obj:Play()
    end

    -- Wait between 0 and 0.3 seconds
    Task.Wait(math.random() * 0.3)

    -- Stop all the effects
    for _, obj in ipairs(smartObjects) do
        obj:Stop()
    end
    -- Repeat...
end
```

See also: [CoreObject.FindAncestorByType](coreobject.md) | [World.SpawnAsset](world.md) | [Vfx.Play](vfx.md) | [SmartAudio.Play](smartaudio.md) | [Task.Wait](task.md)

---

Using:

- `outOfAmmoSoundId`

Weapons are also of type Equipment. In this example we listen to when a player equips the weapon. When they do, if the weapon is out of ammo then we play the "out of ammo" sound effect which normally only plays after trying to shoot while empty.

```lua
local WEAPON = script:FindAncestorByType('Weapon')

function OnEquipped(equipment, player)
    if WEAPON.currentAmmo == 0 and WEAPON.outOfAmmoSoundId then
        local pos = WEAPON:GetWorldPosition()
        World.SpawnAsset(WEAPON.outOfAmmoSoundId, {position = pos})
    end
end

WEAPON.equippedEvent:Connect(OnEquipped)
```

See also: [Equipment.equippedEvent](equipment.md) | [CoreObject.FindAncestorByType](coreobject.md) | [World.SpawnAsset](world.md) | [Event.Connect](event.md)

---

Using:

- `projectileBounceCount`
- `projectilePierceCount`

A weapon-viewing interface can show detailed specs about each weapon to players. In this example, the weapon's damage, as well as indicators if the shots bounce or pierce are setup for the player to view. This script would exist as part of a greater user interface, with various images and texts, and the ShowUI() function would be called depending on the game state (e.g. the player is browsing a shop).

```lua
local WEAPON_DETAILS_UI = script.parent
local DAMAGE_LABEL = script:GetCustomProperty("DamageLabel"):WaitForObject()
local BOUNCE_UI = script:GetCustomProperty("BounceGroup"):WaitForObject()
local PIERCE_UI = script:GetCustomProperty("PierceGroup"):WaitForObject()

function ShowUI(weapon)
    WEAPON_DETAILS_UI.visibility = Visibility.INHERIT

    -- Damage
    DAMAGE_LABEL.text = "Damage: " .. tostring(weapon.damage)

    -- Bounces? yes/no
    if weapon.projectileBounceCount > 0 then
        BOUNCE_UI.visibility = Visibility.INHERIT
    else
        BOUNCE_UI.visibility = Visibility.FORCE_OFF
    end

    -- Pierces? yes/no
    if weapon.projectilePierceCount > 0 then
        PIERCE_UI.visibility = Visibility.INHERIT
    else
        PIERCE_UI.visibility = Visibility.FORCE_OFF
    end
end

function HideUI()
    WEAPON_DETAILS_UI.visibility = Visibility.FORCE_OFF
end
```

See also: [Weapon.damage](weapon.md) | [CoreObject.parent](coreobject.md) | [CoreObjectReference.WaitForObject](coreobjectreference.md) | [UIText.text](uitext.md)

---

Using:

- `shouldBurstStopOnRelease`

The following function evaluates a weapon and returns the "type" of weapon it thinks it is, based on some of its properties.

```lua
WeaponClass.AutomaticRifle = 1
WeaponClass.BurstRifle = 2
WeaponClass.Sniper = 3
WeaponClass.Pistol = 4
WeaponClass.Shotgun = 5

function ClassifyWeapon(weapon)
    if weapon.burst > 1 then
        if weapon.shouldBurstStopOnRelease then
            return WeaponClass.AutomaticRifle
        else
            return WeaponClass.BurstRifle
        end
    else
        if weapon.multiShotCount > 1 then
            return WeaponClass.Shotgun

        elseif string.match(weapon:GetAbilities()[1].animation, "pistol") then
            return WeaponClass.Pistol
        else
            return WeaponClass.Sniper
        end
    end
end
```

See also: [Equipment.GetAbilities](equipment.md) | [Ability.animation](ability.md)

---

Using:

- `spreadMin`
- `spreadMax`
- `spreadAperture`
- `spreadDecreaseSpeed`
- `spreadIncreasePerShot`
- `spreadPenaltyPerShot`

It can be hard to understand the implications of spread on the efficacy of a weapon, especially as there is a complex relationship with firing rate. This example demonstrates a data-driven approach to studying gameplay. If this script is added to each weapon they will register their stats into a global table, which could then be analyzed to draw conclusions about the game's balance.

```lua
local WEAPON = script:FindAncestorByType("Weapon")

if _G.WeaponStudy == nil then
    _G.WeaponStudy = {}
    _G.WeaponStudy.samples = {}

    _G.WeaponStudy.AddSample = function(weapon)
        local key = weapon.name
        if _G.WeaponStudy.samples[key] then return end

        _G.WeaponStudy.samples[key] = {
            spreadMin = weapon.spreadMin,
            spreadMax = weapon.spreadMax,
            spreadAperture = weapon.spreadAperture,
            spreadDecreaseSpeed = weapon.spreadDecreaseSpeed,
            spreadPenaltyPerShot = weapon.spreadPenaltyPerShot,
            damageDealt = 0
        }
    end

    _G.WeaponStudy.ReportDamage = function(weapon, amount)
        local key = weapon.name
        local dmg = _G.WeaponStudy.samples[key].damageDealt
        _G.WeaponStudy.samples[key].damageDealt = dmg + amount
    end
end

_G.WeaponStudy.AddSample(WEAPON)

local GOOD = true
local BAD = false

function CalcStatRating(statName, compareTo, goodOrBad)
    local minValue
    local maxValue
    for weaponName,data in pairs(_G.WeaponStudy.samples) do
        local statValue = data[statName]
        if not minValue or statValue < minValue then
            minValue = statValue
        end
        if not maxValue or statValue > maxValue then
            maxValue = statValue
        end
    end
    if not minValue then
        error("Missing samples")
        return
    end

    local result
    if maxValue == minValue then
        -- Avoid division by zero
        result = 1
    else
        result = (compareTo - minValue) / (maxValue - minValue)
    end

    if goodOrBad == GOOD then
        return result
    end
    return 1 - result
end

function RateMyGun()
    local spreadMinRating = CalcStatRating("spreadMin", WEAPON.spreadMin, BAD)
    local spreadMaxRating = CalcStatRating("spreadMax", WEAPON.spreadMax, BAD)
    local spreadApertureRating = CalcStatRating("spreadAperture", WEAPON.spreadAperture, BAD)
    local spreadDecreaseSpeedRating = CalcStatRating("spreadDecreaseSpeed", WEAPON.spreadDecreaseSpeed, GOOD)
    local spreadPenaltyPerShotRating = CalcStatRating("spreadPenaltyPerShot", WEAPON.spreadPenaltyPerShot, BAD)
    print("")
    print("Rating - " .. WEAPON.name)
    print("  spreadMin: " .. tostring(spreadMinRating))
    print("  spreadMax: " .. tostring(spreadMaxRating))
    print("  spreadAperture: " .. tostring(spreadApertureRating))
    print("  spreadDecreaseSpeed: " .. tostring(spreadDecreaseSpeedRating))
    print("  spreadPenaltyPerShot: " .. tostring(spreadPenaltyPerShotRating))
end

-- We're keeping track of damage dealt here, but additional study is needed to draw conclusions.
-- Plus, this would need to be tested in multiplayer and the data accessed somehow.
function OnTargetImpacted(weapon, impactData)
    if ImpactData.targetObject and ImpactData.targetObject:IsA("Player") then
        -- The damage calculation may change per weapon. This is a generic example
        local damageAmount = weapon.damage

        _G.WeaponStudy.ReportDamage(WEAPON, damageAmount)
    end
end

WEAPON.targetImpactedEvent:Connect(OnTargetImpacted)

-- Rate each gun based on how it measures against all the other ones in the hierarchy.
-- Works best if there are several guns in the scene, with a varying spread of stats.
Task.Wait(1)
RateMyGun()
```

See also: [Weapon.targetImpactedEvent](weapon.md) | [ImpactData.targetObject](impactdata.md) | [CoreObject.FindAncestorByType](coreobject.md) | [CoreLua.print](coreluafunctions.md) | [other.IsA](other.md) | [Event.Connect](event.md) | [Task.Wait](task.md)

---

Using:

- `spreadMin`
- `spreadMax`
- `spreadDecreaseSpeed`

Often in shooting games, the weapon loses precision while moving. For weapons in Core this is achieved by modifying the player's `spreadModifier` property, and can be implemented in many different ways. In this example, a client-context script uses the weapon's configured `spreadMin` and `spreadMax` properties to determine the maximum penalty when the player is moving. The weapon's `spreadDecreaseSpeed` is then used as an interpolation coefficient to smoothly move the spread penalty up and down, non-linearly, as the player moves or stops moving.

```lua
local WEAPON = script:FindAncestorByType("Weapon")
local MOVING_THRESHOLD = 250

local wasMoving = false
local targetSpreadModifier = 0

function Tick()
    local player = WEAPON.owner
    if not Object.IsValid(player) then return end

    -- Evaluate if the player is moving right now
    local isMovingNow = false
    if player.isJumping then
        isMovingNow = true
    else
        local playerSpeed = player:GetVelocity().size
        if playerSpeed >= MOVING_THRESHOLD then
            isMovingNow = true
        end
    end

    -- Select target spread modifier based on current movement
    if isMovingNow ~= wasMoving then
        if isMovingNow then
            -- Moving
            targetSpreadModifier = WEAPON.spreadMax - WEAPON.spreadMin
        else
            -- Not moving
            targetSpreadModifier = 0
        end
    end
    wasMoving = isMovingNow

    -- Adjust the player spread modify gradually over time
    local t = WEAPON.spreadDecreaseSpeed / 100
    player.spreadModifier = CoreMath.Lerp(player.spreadModifier, targetSpreadModifier, t)
end
```

See also: [Equipment.owner](equipment.md) | [Player.spreadModifier](player.md) | [CoreObject.FindAncestorByType](coreobject.md) | [Object.IsValid](object.md) | [Vector3.size](vector3.md) | [CoreLua.Tick](coreluafunctions.md) | [CoreMath.Lerp](coremath.md)

---

## Tutorials

[Weapons in Core](../tutorials/weapons.md) | [Weapons & Abilities (Advanced)](../tutorials/abilities_advanced.md)
