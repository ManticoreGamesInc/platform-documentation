---
id: hitresult
name: HitResult
title: HitResult
tags:
    - API
---

# HitResult

Contains data pertaining to an impact or raycast.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `other` | [`CoreObject`](coreobject.md) or Player | Reference to a CoreObject or Player impacted. | Read-Only |
| `socketName` | `string` | If the hit was on a Player, `socketName` tells you which spot on the body was hit. | Read-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetImpactPosition()` | [`Vector3`](vector3.md) | The world position where the impact occurred. | None |
| `GetImpactNormal()` | [`Vector3`](vector3.md) | Normal direction of the surface which was impacted. | None |
| `GetShapePosition()` | [`Vector3`](vector3.md) | For HitResults returned by box casts and sphere casts, returns the world position of the center of the cast shape when the collision occurred. In the case of HitResults not related to a box cast or sphere cast, returns the world position where the impact occurred. | None |
| `GetTransform()` | [`Transform`](transform.md) | Returns a Transform composed of the position of the impact in world space, the rotation of the normal, and a uniform scale of 1. | None |

## Examples

Example using:

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

See also: [Game.GetLocalPlayer](game.md) | [Player.GetViewWorldPosition](player.md) | [World.Raycast](world.md) | [CoreDebug.DrawLine](coredebug.md) | [Rotation * Vector3](rotation.md) | [Vector3.FORWARD](vector3.md) | [Color.GREEN](color.md)

---

Example using:

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

See also: [CoreObject.GetCustomProperty](coreobject.md) | [ImpactData.GetHitResult](impactdata.md) | [World.SpawnAsset](world.md) | [Weapon.targetImpactedEvent](weapon.md) | [Transform.GetPosition](transform.md) | [Event.Connect](event.md)

---

Example using:

### `GetShapePosition`

### `GetImpactPosition`

HitResult can be the output of `World.BoxCast()` and `World.SphereCast()`. In these cases, the hit result's `GetShapePosition()` returns the center of the shape at point of impact. In this example, we cast a sphere starting at the position of the mouse cursor on screen. At the point of impact we draw a red circle, to indicate where the sphere ended, as well as a yellow dot, to indicate the collision point.

```lua
local RADIUS = 50
local PLAYER = Game.GetLocalPlayer()
    
UI.SetCursorVisible(true)

function Tick()
    local viewPosition = PLAYER:GetViewWorldPosition()
    local viewForward = PLAYER:GetViewWorldRotation() * Vector3.FORWARD
    
    local cursorStart = UI.GetCursorPlaneIntersection(viewPosition + viewForward * 100, viewForward)
    if not cursorStart then return end
    
    local direction = UI.GetCursorPlaneIntersection(viewPosition + viewForward * 200, viewForward)
    direction = direction - cursorStart
    
    local hitResult = World.Spherecast(cursorStart, cursorStart + direction * 5000, RADIUS)

    if hitResult then
        local center = hitResult:GetShapePosition()
        -- Draw red sphere representing where the spherecast ended
        CoreDebug.DrawSphere(center, RADIUS, {color = Color.RED, thickness = 2})
        -- Draw yellow dot representing the point of impact of the spherecast with objects
        CoreDebug.DrawSphere(hitResult:GetImpactPosition(), 3, {color = Color.YELLOW, thickness = 4})
    end
end
```

See also: [Player.GetViewWorldPosition](player.md) | [UI.GetCursorPlaneIntersection](ui.md) | [World.Spherecast](world.md) | [CoreDebug.DrawSphere](coredebug.md) | [Vector3.FORWARD](vector3.md) | [Game.GetLocalPlayer](game.md)

---

Example using:

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

See also: [CoreObject.parent](coreobject.md) | [ImpactData.GetHitResult](impactdata.md) | [other.IsA](other.md) | [Player.name](player.md) | [Weapon.targetImpactedEvent](weapon.md) | [CoreLua.print](coreluafunctions.md) | [Event.Connect](event.md)

---
