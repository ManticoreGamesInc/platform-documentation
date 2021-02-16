---
id: impactdata
name: ImpactData
title: ImpactData
tags:
    - API
---

# ImpactData

A data structure containing all information about a specific Weapon interaction, such as collision with a character.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `targetObject` | `Object` | Reference to the CoreObject/Player hit by the Weapon. | Read-Only |
| `projectile` | `Projectile` | Reference to a Projectile, if one was produced as part of this interaction. | Read-Only |
| `sourceAbility` | `Ability` | Reference to the Ability which initiated the interaction. | Read-Only |
| `weapon` | `Weapon` | Reference to the Weapon that is interacting. | Read-Only |
| `weaponOwner` | `Player` | Reference to the Player who had the Weapon equipped at the time it was activated, ultimately leading to this interaction. | Read-Only |
| `travelDistance` | `Number` | The distance in cm between where the Weapon attack started until it impacted something. | Read-Only |
| `isHeadshot` | `bool` | True if the Weapon hit another player in the head. | Read-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetHitResult()` | `HitResult` | Physics information about the impact between the Weapon and the other object. | None |
| `GetHitResults()` | `Array<HitResult>` | Table with multiple HitResults that hit the same object, in the case of Weapons with multi-shot (e.g. Shotguns). If a single attack hits multiple targets you receive a separate interaction event for each object hit. | None |

## Examples

Using:

- `GetHitResult`

HitResult is used by Weapons to transmit data about the interaction. In this example, the `socketName` property is used in determining how much damage to apply, depending on what part of the target's body was hit. For this to work, the weapon's default damage number should be set to zero, with all damage applied through this script.

```lua
local WEAPON = script:FindAncestorByType('Weapon')

local HEADSHOT_DAMAGE = WEAPON:GetCustomProperty("HeadshotDamage")
local NECK_DAMAGE = WEAPON:GetCustomProperty("NeckDamage")
local TORSO_DAMAGE = WEAPON:GetCustomProperty("TorsoDamage")
local LIMB_DAMAGE = WEAPON:GetCustomProperty("BaseDamage")

function OnTargetImpacted(weapon, impactData)
    local target = impactData.targetObject

    -- Apply damage to target only if it's a player
    if Object.IsValid(target) and target:IsA("Player") then
        local hitResult = impactData:GetHitResult()
        local socketName = hitResult.socketName

        -- Figure out how much damage this did
        local amount = LIMB_DAMAGE
        if impactData.isHeadshot then
            amount = HEADSHOT_DAMAGE

        elseif socketName == "neck"
        or socketName == "left_clavicle"
        or socketName == "right_clavicle" then
            amount = NECK_DAMAGE

        elseif socketName == "pelvis"
        or socketName == "lower_spine"
        or socketName == "upper_spine" then
            amount = TORSO_DAMAGE
        end

        -- Creating damage information
        local damageInfo = Damage.New(amount)
        damageInfo.reason = DamageReason.COMBAT
        damageInfo.sourceAbility = impactData.sourceAbility
        damageInfo.sourcePlayer = impactData.weaponOwner

        -- Apply damage to the enemy player
        target:ApplyDamage(damageInfo)
    end
end

WEAPON.targetImpactedEvent:Connect(OnTargetImpacted)
```

---

Using:

- `GetHitResults`
- `targetObject`
- `weaponOwner`
- `isHeadshot`

When it comes to weapons damaging players, there is a built-in damage value that works. However, additional mechanics can be layered on top, with scripts. In this example, some weapons can have multiple shots at once (e.g. Shotgun) and headshots are defined to have a different damage value. For this to work, the weapon's default damage number should be set to zero, with all damage applied through this script.

```lua
local WEAPON = script:FindAncestorByType('Weapon')

local BASE_DAMAGE = WEAPON:GetCustomProperty("BaseDamage")
local HEADSHOT_DAMAGE = WEAPON:GetCustomProperty("HeadshotDamage")

local function OnTargetImpacted(weapon, impactData)
    local target = impactData.targetObject

    -- Apply damage to target only if it's a player
    if Object.IsValid(target) and target:IsA("Player") then

        -- Figure out how much damage this did
        local amount = BASE_DAMAGE
        if impactData.isHeadshot then
            amount = HEADSHOT_DAMAGE
        end

        -- The GetHitResults() returns a table. The # symbol gives the size of the table
        local numberOfHits = #impactData:GetHitResults()

        -- Creating damage information
        local damageInfo = Damage.New(amount * numberOfHits)
        damageInfo.reason = DamageReason.COMBAT
        damageInfo.sourceAbility = impactData.sourceAbility
        damageInfo.sourcePlayer = impactData.weaponOwner

        -- Apply damage to the enemy player
        target:ApplyDamage(damageInfo)
    end
end

WEAPON.targetImpactedEvent:Connect(OnTargetImpacted)
```

---

Using:

- `projectile`

Projectiles that are fired from weapons cannot be controlled in the same was as projectiles that are created with `Projectile.Spawn()`. That's because they are client-predicted, which is a tradeoff that usually leads to better gameplay fidelity. That said, there are still mechanics that can be explored with access to the `ImpactData`'s projectile object. In this example, the weapon is setup with a value on the `Projectile Pierces` property. This causes shots to go through objects. In this hypothetical game we want shots that hit player limbs to go through them and hit objects behind. If the impact happened on any other object or part of their body, then we destroy the projectile.

```lua
local WEAPON = script:FindAncestorByType('Weapon')

local function StringBeginsWith(str, start)
   return str:sub(1, #start) == start
end

local function OnTargetImpacted(weapon, impactData)
    local target = impactData.targetObject
    local projectile = impactData.projectile

    if Object.IsValid(target) and target:IsA("Player") then
        local hitResult = impactData:GetHitResult()
        local socketName = hitResult.socketName

        if not StringBeginsWith(socketName, "left")
        and not StringBeginsWith(socketName, "right") then
            -- The projectile hit a player, but not on a limb
            projectile:Destroy()
        end
    else
        -- The projectile hit a non-player object
        projectile:Destroy()
    end
end

WEAPON.targetImpactedEvent:Connect(OnTargetImpacted)
```

---

Using:

- `sourceAbility`

In this example, the shoot ability is manipulated as a result of the `targetImpactEvent`. If the shot was a headshot the ability continues as normal and will immediately refresh. However, if it was not a headshot there is an additional 1 second delay during which the player can't use the shoot ability.

```lua
local WEAPON = script:FindAncestorByType('Weapon')

local function OnTargetImpacted(weapon, impactData)
    local attackAbility = impactData.sourceAbility

    if Object.IsValid(attackAbility)
    and not impactData.isHeadshot then
        attackAbility.isEnabled = false

        Task.Wait(1)

        if Object.IsValid(attackAbility) then
            attackAbility.isEnabled = true
        end
    end
end

WEAPON.targetImpactedEvent:Connect(OnTargetImpacted)
```

---

Using:

- `travelDistance`

The `travelDistance` property tells us the distance (in centimeters) between the origin of the shot and the impact point. In this example, we use that information to create a weapon that deals variable damage, depending on the distance. It could be configured to do either maximum damage at maximum range or minimum damage at the max range, all dependent upon custom property values. For this to work, the weapon's default damage number should be set to zero, with all damage applied through this script.

```lua
local WEAPON = script:FindAncestorByType('Weapon')

local DAMAGE_AT_MIN = WEAPON:GetCustomProperty("MinDamage")
local DAMAGE_AT_MAX = WEAPON:GetCustomProperty("MaxDamage")
local MIN_DAMAGE_RANGE = WEAPON:GetCustomProperty("MinDamageRange")
local MAX_DAMAGE_RANGE = WEAPON:GetCustomProperty("MaxDamageRange")

local function OnTargetImpacted(weapon, impactData)
    local target = impactData.targetObject

    -- Apply damage to target only if it's a player
    if Object.IsValid(target) and target:IsA("Player") then

        -- Figure out how much damage this did
        local percent = (impactData.travelDistance - MIN_DAMAGE_RANGE) / (MAX_DAMAGE_RANGE - MIN_DAMAGE_RANGE)
        percent = CoreMath.Clamp(percent)
        local amount = CoreMath.Lerp(DAMAGE_AT_MIN, DAMAGE_AT_MAX, percent)

        -- Creating damage information
        local damageInfo = Damage.New(amount)
        damageInfo.reason = DamageReason.COMBAT
        damageInfo.sourceAbility = impactData.sourceAbility
        damageInfo.sourcePlayer = impactData.weaponOwner

        -- Apply damage to the enemy player
        target:ApplyDamage(damageInfo)
    end
end

WEAPON.targetImpactedEvent:Connect(OnTargetImpacted)
```

---

Using:

- `weapon`

While the `targetImpactedEvent` conveniently provides the weapon as the first parameter, the `ImpactData` that comes as the second parameter also contains a reference to the weapon. This is useful if we are forwarding the logic off to another script. In this case we only need to pass the `ImpactData` and the other script will have all the information it needs. In this example, a damage manager script is `required()` by the weapon and the combat decision is forwarded to the manager.

```lua
local WEAPON = script:FindAncestorByType('Weapon')
local COMBAT_MANAGER = require( WEAPON:GetCustomProperty("CombatManager") )

local function OnTargetImpacted(weapon, impactData)
    COMBAT_MANAGER.TargetImpacted(impactData)
end

WEAPON.targetImpactedEvent:Connect(OnTargetImpacted)

--[[#description
    Combat manager script that is required by the weapon:
]]
function TargetImpacted(impactData)
    local weapon = impactData.weapon
    local owner = impactData.sourcePlayer

    -- Life Steal mechanic
    if owner:GetResource("LifeSteal") > 0 then
        owner.hitPoints = owner.hitPoints + weapon.damage
        if owner.hitPoints > owner.maxHitPoints then
            owner.hitPoints = owner.maxHitPoints
        end
    end

    -- TODO : Other combat mechanics
    -- ...
end

-- return {
--     TargetImpacted = TargetImpacted
-- }
```

---
