---
id: hitresult
name: HitResult
title: HitResult
tags:
    - API
---

# HitResult

## Description

Contains data pertaining to an impact or raycast.

## API

### Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `other` | `CoreObject or Player` | Reference to a CoreObject or Player impacted. | Read-Only |
| `socketName` | `string` | If the hit was on a Player, `socketName` tells you which spot on the body was hit. | Read-Only |

### Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetImpactPosition()` | `Vector3` | The world position where the impact occurred. | None |
| `GetImpactNormal()` | `Vector3` | Normal direction of the surface which was impacted. | None |
| `GetTransform()` | `Transform` | Returns a Transform composed of the position of the impact in world space, the rotation of the normal, and a uniform scale of 1. | None |

## Examples

### `GetImpactPosition`

### `GetImpactNormal`

This example shows the power of `World.Raycast()` which returns data in the form of a `HitResult`. The physics calculation starts from the center of the camera and shoots forward. If the player is looking at something, then a reflection vector is calculated as if a shot ricocheted from the surface. Debug information is drawn about the ray, the impact point and the reflection. This script must be placed under a Client Context and works best if the scene has objects or terrain.

```lua
function Tick()
    local player = Game.GetLocalPlayer()

    local rayStart = player:GetViewWorldPosition()
    local cameraForward = player:GetViewWorldRotation() * Vector3.FORWARD
    local rayEnd = rayStart + cameraForward * 10000

    local hitResult = World.Raycast(rayStart, rayEnd, {ignorePlayers = true})

    if hitResult then
        local hitPos = hitResult:GetImpactPosition()
        local normal = hitResult:GetImpactNormal()
        local mirror = cameraForward - 2 * (cameraForward .. normal) * normal
        -- The green line is the impact normal
        CoreDebug.DrawLine(hitPos, hitPos + normal * 100, {thickness = 3, color = Color.GREEN, duration = 0.03})
        -- The blue line connects the camera to the impact point
        CoreDebug.DrawLine(rayStart, hitPos, {thickness = 2, color = Color.BLUE, duration = 0.03})
        -- The magenta line represents the reflection off the surface
        CoreDebug.DrawLine(hitPos, hitPos + mirror * 1000, {thickness = 2, color = Color.MAGENTA, duration = 0.03})
    end
end
```

### `GetTransform`

HitResult is used by Weapons when attacks hit something. In this example, a custom template is spawned at the point of impact. The rotation of the new object is conveniently taken from the HitResult's transform data. This example assumes the script is placed as a child of a Weapon.

```lua
local impactTemplate = script:GetCustomProperty("ImpactObject")
local weapon = script.parent

function OnTargetImpacted(_, impactData)
    local hitResult = impactData:GetHitResult()
    if hitResult then
        local hitT = hitResult:GetTransform()
        World.SpawnAsset(impactTemplate, {position = hitT:GetPosition(), rotation = hitT:GetRotation()})
    end
end

weapon.targetImpactedEvent:Connect(OnTargetImpacted)
```

### `other`

### `socketName`

HitResult is used by Weapons to transmit data about the interaction. In this example, the `other` property is used in figuring out if the object hit was another player. If so, then the `socketName` property tells us exactly where on the player's body the hit occurred, allowing more detailed gameplay systems.

```lua
local weapon = script.parent

function OnTargetImpacted(_, impactData)
    local hitResult = impactData:GetHitResult()
    if hitResult and hitResult.other and hitResult.other:IsA("Player") then
        local playerName = hitResult.other.name
        local socketName = hitResult.socketName
        print("Player " .. playerName .. " was hit in the " .. socketName)
    end
end

weapon.targetImpactedEvent:Connect(OnTargetImpacted)
```
