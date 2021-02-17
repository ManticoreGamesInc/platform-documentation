---
id: staticmesh
name: StaticMesh
title: StaticMesh
tags:
    - API
---

# StaticMesh

StaticMesh is a static CoreMesh. StaticMeshes can be placed in the scene and (if networked or client-only) moved at runtime, but the mesh itself cannot be animated.

See AnimatedMesh for meshes with animations.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `isSimulatingDebrisPhysics` | `bool` | If `true`, physics will be enabled for the mesh. | Read-Write, Client-Only |

## Examples

Using:

- `isSimulatingDebrisPhysics`

The debris physics simulation is a client-only feature. The exact movement of simulated meshes is not expected to be the same across clients and should be used for visual effects, not for determining gameplay outcomes.

The following example takes several Static Meshes and explodes them randomly away from the epicenter. As written, it modifies only meshes that are children of the script object. When the player approaches the script at 3 meters or less then the function ExplodeChildren() is called, enabling the property `isSimulatingDebrisPhysics` for all the children, in addition to an impulse vector.

```lua
local DISTANCE_TO_EXPLODE = 300
local EXPLOSION_FORCE = 450
local hasExploded = false

function ExplodeChildren()
    local rng = RandomStream.New()

    local epicenter = script:GetWorldPosition()

    for _, child in ipairs(script:GetChildren()) do
        -- Enable client physics
        child.isSimulatingDebrisPhysics = true
        -- Impulse vector
        local direction = (child:GetWorldPosition() - epicenter):GetNormalized()
        child:SetVelocity((rng:GetVector3() + direction * 2) * EXPLOSION_FORCE)
    end
end

function Tick()
    -- Call the explosion function only once
    if hasExploded then return end

    -- Detect if the local player has gotten close to the objects
    local player = Game.GetLocalPlayer()
    local distance = (player:GetWorldPosition() - script:GetWorldPosition()).size

    if distance < DISTANCE_TO_EXPLODE then
        hasExploded = true
        ExplodeChildren()
    end
end
```

See also: [RandomStream.New](randomstream.md) | [CoreObject.GetWorldPosition](coreobject.md) | [Game.GetLocalPlayer](game.md) | [Player.GetWorldPosition](player.md) | [Vector3.GetNormalized](vector3.md) | [CoreLua.Tick](coreluafunctions.md)

---
