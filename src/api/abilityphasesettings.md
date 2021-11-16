---
id: abilityphasesettings
name: AbilityPhaseSettings
title: AbilityPhaseSettings
tags:
    - API
---

# AbilityPhaseSettings

Each phase of an Ability can be configured differently, allowing complex and different Abilities. AbilityPhaseSettings is an Object.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `duration` | `number` | Length in seconds of the phase. After this time the Ability moves to the next phase. Can be zero. Default values per phase: 0.15, 0, 0.5 and 3. | Read-Only |
| `canMove` | `boolean` | Is the Player allowed to move during this phase. True by default. | Read-Only |
| `canJump` | `boolean` | Is the Player allowed to jump during this phase. False by default in Cast & Execute, default True in Recovery & Cooldown. | Read-Only |
| `canRotate` | `boolean` | Is the Player allowed to rotate during this phase. True by default. | Read-Only |
| `preventsOtherAbilities` | `boolean` | When true this phase prevents the Player from casting another Ability, unless that other Ability has canBePrevented set to False. True by default in Cast & Execute, false in Recovery & Cooldown. | Read-Only |
| `isTargetDataUpdated` | `boolean` | If `true`, there will be updated target information at the start of the phase. Otherwise, target information may be out of date. | Read-Only |
| `facingMode` | [`AbilityFacingMode`](enums.md#abilityfacingmode) | How and if this Ability rotates the Player during execution. Cast and Execute default to "Aim", other phases default to "None". Options are: AbilityFacingMode.NONE, AbilityFacingMode.MOVEMENT, AbilityFacingMode.AIM | Read-Only |

## Examples

Example using:

### `duration`

In this example, while the ability is on cooldown the percent completion of the cooldown is calculated. This could be useful, for instance, in displaying user interface.

```lua
function GetCooldownRemaining(ability)
    if ability:GetCurrentPhase() == AbilityPhase.COOLDOWN then
        return ability:GetPhaseTimeRemaining()
    end
    return ability.cooldownPhaseSettings.duration
end
```

See also: [Ability.GetPhaseTimeRemaining](ability.md)

---

Example using:

### `isTargetDataUpdated`

In this example, a shotgun is configured to have a deterministic sequence of spread patterns. Both the angle and the randomness of the shots can be controlled in a way where they follow a predictable pattern of shots that repeats for every 5 shots. Some properties of the ability targeting can only be changed at runtime if the ability's execute phase has the property 'Is Target Data Updated' disabled. Otherwise, any changes to the target data are overriden at the start of the execute phase. The script expects to be placed under the shotgun's client context.

```lua
local WEAPON = script:FindAncestorByType("Weapon")
local SHOOT_ABILITY = WEAPON:GetAbilities()[1]

if SHOOT_ABILITY.executePhaseSettings.isTargetDataUpdated then
    warn("For dynamic spread angle to work, select the Shoot ability and disable its 'Is Target Data Updated' in the execute phase.")
end

local sequenceAngle = {
    10, 8, 6, 4, 2
}
local sequenceRngSeed = {
    1, 2, 3, 4, 5
}
local sequenceIndex = 1

function OnCast(ability)
    local targetData = ability:GetTargetData()
    
    targetData.spreadHalfAngle = sequenceAngle[sequenceIndex]
    targetData.spreadRandomSeed = sequenceRngSeed[sequenceIndex]
    
    ability:SetTargetData(targetData)
    
    sequenceIndex = sequenceIndex + 1
    if sequenceIndex > #sequenceAngle then
        sequenceIndex = 1
    end
end

SHOOT_ABILITY.castEvent:Connect(OnCast)
```

See also: [AbilityTarget.spreadHalfAngle](abilitytarget.md) | [Ability.GetTargetData](ability.md) | [CoreObject.FindAncestorByType](coreobject.md) | [Weapon.GetAbilities](weapon.md)

---
