---
id: ikanchor
name: IKAnchor
title: IKAnchor
tags:
    - API
---

# IKAnchor

IKAnchors are objects that can be used to control player animations. They can be used to specify the position of a specific hand, foot, or the hips of a player, and can be controlled from script to create complex animations.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `target` | [`Player`](player.md) | Which Player the IKAnchor is activated on. | Read-Only |
| `anchorType` | [`IKAnchorType`](enums.md#ikanchortype) | Which socket this IKAnchor applies to. | Read-Only |
| `blendInTime` | `number` | The duration over which this IKAnchor is blended when it is activated. | Read-Write |
| `blendOutTime` | `number` | The duration over which this IKAnchor is blended when it is deactivated. | Read-Write |
| `weight` | `number` | The amount this IKAnchor blends with the underlying animation. A value of 0 means the animation is player unchanged, and a value of 1 means the animation is ignored and the IKAnchor is used. | Read-Write |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Activate(Player)` | `None` | Activates the IKAnchor on the given player. | None |
| `Deactivate()` | `None` | Deactivates the IKAnchor from whatever player it is active on. | None |
| `GetAimOffset(Ability)` | [`Vector3`](vector3.md) | Returns the aim offset property. | None |
| `SetAimOffset(Vector3)` | `None` | Sets the aim offset of this IKAnchor. | None |

## Events

| Event Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `activatedEvent` | `Event<`[`IKAnchor`](ikanchor.md), [`Player`](player.md)`>` | Fired when this IKAnchor is activated on a player. | None |
| `deactivatedEvent` | `Event<`[`IKAnchor`](ikanchor.md), [`Player`](player.md)`>` | Fired when this IKAnchor is deactivated from a player. | None |

## Examples

Example using:

### `Activate`

### `Deactivate`

In this example, the local player is tilted forward when they run. This is done by slightly rotating a pelvis IK anchor forwards and then activating and deactivating it depending on the speed of the player.

```lua
-- Core object reference to a pelvis IK anchor
local IKAnchor = script:GetCustomProperty("IKAnchor"):WaitForObject()

-- The minimum speed the player has to be moving at for the IK anchors to be activated
local ACTIVATION_SPEED = 500

-- How many degrees forward the player will lean when running
local LEAN_ANGLE = 15

local player = Game.GetLocalPlayer()

-- Store the current activation status of the IK Anchor
local isActivated = false

-- Attach the IK Anchor object to the root joint of the player so they move together
IKAnchor:AttachToPlayer(player, "pelvis")

IKAnchor:SetRotation(Rotation.New(0, -LEAN_ANGLE, 0))

function Tick(deltaTime)
-- Deactivate the IK Anchor if the player is not grounded, not pressing the "W" key, or not moving faster than the `ACTIVATION_SPEED`
    if((not player.isWalking or not player:IsBindingPressed("ability_extra_21") or player:GetVelocity().size <= ACTIVATION_SPEED) and isActivated) then
        IKAnchor:Deactivate(player)
        isActivated = false
    -- Only activate the IK Anchor if the player is grounded, pressing the "W" key, and moving faster than the `ACTIVATION_SPEED`
    elseif (player.isWalking and not isActivated and player:IsBindingPressed("ability_extra_21") and player:GetVelocity().size > ACTIVATION_SPEED) then
        IKAnchor:Activate(player)
        isActivated = true
    end
end
```

See also: [CoreObject.AttachToPlayer](coreobject.md) | [player.IsBindingPressed](player.md) | [Game.GetLocalPlayer](game.md)

---
