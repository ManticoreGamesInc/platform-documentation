---
id: equipment
name: Equipment
title: Equipment
tags:
    - API
---

# Equipment

## Description

Equipment is a CoreObject representing an equippable item for players. They generally have a visual component that attaches to the Player, but a visual component is not a requirement. Any Ability objects added as children of the Equipment are added/removed from the Player automatically as it becomes equipped/unequipped.

## API

### Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `socket` | `string` | Determines which point on the avatar's body this equipment will be attached. See [Socket Names](../api/animations.md#socket-names) for the list of possible values. | Read-Write |
| `owner` | `Player` | Which Player the Equipment is attached to. | Read-Only |

### Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Equip(Player)` | `None` | Attaches the Equipment to a Player. They gain any abilities assigned to the Equipment. If the Equipment is already attached to another Player it will first unequip from that other Player before equipping unto the new one. | None |
| `Unequip()` | `None` | Detaches the Equipment from any Player it may currently be attached to. The Player loses any abilities granted by the Equipment. | None |
| `AddAbility(Ability)` | `None` | Adds an Ability to the list of abilities on this Equipment. | None |
| `GetAbilities()` | `Array<Ability>` | A table of Abilities that are assigned to this Equipment. Players who equip it will get these Abilities. | None |

### Events

| Event Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `equippedEvent` | `Event<Equipment, Player>` | Fired when this equipment is equipped onto a player. | None |
| `unequippedEvent` | `Event<Equipment, Player>` | Fired when this object is unequipped from a player. | None |

## Examples

### `equippedEvent`

### `unequippedEvent`

Usually equipment are attached one at a time. However, in some cases you may want multiple equipment to behave as a single unit, such as a pair of boxing gloves. This example shows how to have a secondary equipment piece that attaches and detaches alongside a primary piece. It's not enough to listen only to the `equippedEvent`, the `unequippedEvent` must also be mirrored because in some games the equipment may be dropped or put away in the inventory. This script expects to be the child of the primary equipment, with the secondary equipment as its sibling.

```lua
local primaryEquipment = script.parent
local secondaryEquipment = primaryEquipment:FindDescendantByType("Equipment")
local secondaryDefaultTransform = secondaryEquipment:GetTransform()

function OnEquipped(equipment, player)
    secondaryEquipment:Equip(player)
end

function OnUnequipped(equipment, player)
    secondaryEquipment:Unequip()
    secondaryEquipment.parent = primaryEquipment
    secondaryEquipment:SetTransform(secondaryDefaultTransform)
end

primaryEquipment.equippedEvent:Connect(OnEquipped)
primaryEquipment.unequippedEvent:Connect(OnUnequipped)
```

### `AddAbility`

One of the primary roles of equipment is to contain several abilities. Those abilities are automatically added/removed from the player when they equip/unequip the item. This example shows how an equipment can be spawned and then procedurally assembled with different abilities depending on RNG.

```lua
local EQUIPMENT = script.parent
local ABILITY_TEMPLATE_1 = script:GetCustomProperty("Ability1")
local ABILITY_TEMPLATE_2 = script:GetCustomProperty("Ability2")
local ABILITY_TEMPLATE_3 = script:GetCustomProperty("Ability3")

function Add(abilityTemplate)
    local newAbility = World.SpawnAsset(abilityTemplate, {parent = EQUIPMENT})
    EQUIPMENT:AddAbility(newAbility)
end

local permutation = math.random(3)

if permutation == 1 then
    Add(ABILITY_TEMPLATE_1)
    Add(ABILITY_TEMPLATE_2)
elseif permutation == 2 then
    Add(ABILITY_TEMPLATE_1)
    Add(ABILITY_TEMPLATE_3)
else
    Add(ABILITY_TEMPLATE_2)
    Add(ABILITY_TEMPLATE_3)
end

for i, ability in ipairs(EQUIPMENT:GetAbilities()) do
    print("Ability " .. i .. " = " .. ability.name)
end
```

### `Equip`

This example shows how players can be given default equipment when they join a game.

```lua
local EQUIPMENT_TEMPLATE = script:GetCustomProperty("EquipmentTemplate")

function OnPlayerJoined(player)
    local equipment = World.SpawnAsset(EQUIPMENT_TEMPLATE)
    equipment:Equip(player)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

### `GetAbilities`

Weapons are a specialized type of Equipment that have lots of built-in functionality, including two abilities that are usually included: One for attacking and the second one for reloading. In this example, a cosmetic part of a weapon is hidden after the attack happens and is enabled again after it reloads. This could be used, for instance, in a rocket launcher or a crossbow. The script should be a descendant of a `Weapon`. It works best if under a Client Context and the "ObjectToHide" custom property must be hooked up.

```lua
local WEAPON = script:FindAncestorByType('Weapon')
local ATTACK_ABILITY = WEAPON:GetAbilities()[1]
local RELOAD_ABILITY = WEAPON:GetAbilities()[2]
local OBJECT_TO_HIDE = script:GetCustomProperty("ObjectToHide"):WaitForObject()

function onExecuteAttack()
    OBJECT_TO_HIDE.visibility = Visibility.FORCE_OFF
end

ATTACK_ABILITY.executeEvent:Connect(onExecuteAttack)

function onExecuteReload()
    OBJECT_TO_HIDE.visibility = Visibility.FORCE_ON
end

RELOAD_ABILITY.executeEvent:Connect(onExecuteReload)
```

### `Unequip`

In this example, when a player dies all equipment they have is unequipped and dropped to the ground.

```lua
function DropToGround(equipment)
    equipment:Unequip()

    -- The pickup trigger needs to be re-enabled (if there is one)
    local pickupTrigger = equipment:FindDescendantByType("Trigger")

    if pickupTrigger then
        pickupTrigger.collision = Collision.FORCE_ON
    end

    -- Move it to the ground
    local rayStart = equipment:GetWorldPosition()
    local rayEnd = rayStart + Vector3.UP * -500
    local hitResult = World.Raycast(rayStart, rayEnd, {ignorePlayers = true})

    if hitResult then
        local dropPos = hitResult:GetImpactPosition() + Vector3.UP * 40
        equipment:SetWorldPosition(dropPos)
    end
end

function OnPlayerDied(player)
    for _, equipment in ipairs(player:GetEquipment()) do
        DropToGround(equipment)
    end
end

function OnPlayerJoined(player)
    player.diedEvent:Connect(OnPlayerDied)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

### `owner`

In this example, a weapon has a healing mechanic, where the player gains 2 hit points each time they shoot an enemy player.

```lua
local WEAPON = script:FindAncestorByType('Weapon')

function OnTargetImpactedEvent(weapon, impactData)
    if impactData.targetObject and impactData.targetObject:IsA("Player") then
        weapon.owner.hitPoints = weapon.owner.hitPoints + 2
    end
end

WEAPON.targetImpactedEvent:Connect(OnTargetImpactedEvent)
```

### `socket`

The socket is the attachment point on the player where the equipment will be placed. In this example, the socket property is used for comparing between the new equipment and any previous ones. If there's a competition for the same socket then the old equipment is dropped. This script expects to be placed as a child of the equipment and the equipment's default "Pickup Trigger" property should be cleared, as that behavior is re-implemented in the `OnInteracted()` function. Without re-implementing our own `interactedEvent`, by default the old equipment would be destroyed, instead of dropped, when there is competition for a socket.

```lua
local EQUIPMENT = script.parent
local TRIGGER = script.parent:FindDescendantByType("Trigger")

function Drop(equipment)
    equipment:Unequip()
    -- The pickup trigger needs to be re-enabled (if there is one)
    local pickupTrigger = equipment:FindDescendantByType("Trigger")

    if pickupTrigger then
        pickupTrigger.collision = Collision.FORCE_ON
    end
end

function OnEquipped(equipment, player)
    for _, e in ipairs(player:GetEquipment()) do
        if e ~= equipment and e.socket == equipment.socket then
            Drop(e)
        end
    end
end

function OnInteracted(trigger, player)
    TRIGGER.collision = Collision.FORCE_OFF
    EQUIPMENT:Equip(player)
end

EQUIPMENT.equippedEvent:Connect(OnEquipped)
TRIGGER.interactedEvent:Connect(OnInteracted)
```
