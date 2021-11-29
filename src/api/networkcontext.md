---
id: networkcontext
name: NetworkContext
title: NetworkContext
tags:
    - API
---

# NetworkContext

NetworkContext is a CoreObject representing a special folder containing client-only, server-only, or static objects.

They have no properties or functions of their own, but inherit everything from CoreObject.

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `SpawnSharedAsset(string assetId, [table parameters])` | [`CoreObject`](coreobject.md) | Spawns an instance of an asset into the world as a child of a networked Static Context, also spawning copies of the asset on clients without the overhead of additional networked objects. Any object spawned this way cannot be modified, as with other objects within a Static Context, but they may be destroyed by calling `DestroySharedAsset()` on the same `NetworkContext` instance. Raises an error if called on a non-networked Static Context or a Static Context which is a descendant of a Client Context or Server Context. Optional parameters can specify a transform for the spawned object. <br/>Supported parameters include: <br/>`position (Vector3)`: Position of the spawned object, relative to the parent NetworkContext. <br/>`rotation (Rotation or Quaternion)`: Local rotation of the spawned object. <br/>`scale (Vector3 or number)`: Scale of the spawned object, may be specified as a `Vector3` or as a `number` for uniform scale. <br/>`transform (Transform)`: The full transform of the spawned object. If `transform` is specified, it is an error to also specify `position`, `rotation`, or `scale`. | Server-Only |
| `DestroySharedAsset(CoreObject coreObject)` | `None` | Destroys an object that was spawned using `SpawnSharedAsset()`. Raises an error if `coreObject` was not created by this `NetworkContext`. | Server-Only |

## Examples

Example using:

### `SpawnSharedAsset`

### `DestroySharedAsset`

When Core Objects are spawned using `NetworkContext.SpawnSharedAsset()` they use far less networking resources, compared to spawning them with `World.SpawnAsset()`. On the other hand, objects spawned this way cannot be modified at runtime (only destroyed). In this example the game has no floor. At runtime, cubes are spawned below the players for them to walk on. As players move, the cubes are removed from behind them and added ahead of them. This script is placed in either the server or default context. A `Static Context` group is added to the hierarchy and has networking enabled on it. The `Static Context` is assigned to this script as a custom property. Finally, a template of a cube is also assigned as custom property to this script.

```lua
local STATIC_CONTEXT = script:GetCustomProperty("StaticContext"):WaitForObject()
local CUBE_TEMPLATE = script:GetCustomProperty("Cube")

-- Can be modified to make grids of different sizes
local CUBE_SCALE = 200

-- Memory of player positions and cube objects
local gridValues = {}
local gridCubes = {}

-- Each frame, check if player positions on the grid have changed
function Tick()
    for _,player in ipairs(Game.GetPlayers()) do
        local pos = player:GetWorldPosition()
        local lastX = player.serverUserData.gridX
        local lastY = player.serverUserData.gridY
        local newX = CoreMath.Round(pos.x / CUBE_SCALE)
        local newY = CoreMath.Round(pos.y / CUBE_SCALE)
        if newX ~= lastX or newY ~= lastY then
            player.serverUserData.gridX = newX
            player.serverUserData.gridY = newY
            
            for i = -1, 1 do
                for j = -1, 1 do
                    AddAt(newX + i, newY + j)
                end
            end
            if lastX and lastY then
                for i = -1, 1 do
                    for j = -1, 1 do
                        RemoveAt(lastX + i, lastY + j)
                    end
                end
            end
        end
    end
end

-- Try to add a cube at a given position on the floor grid
function AddAt(x, y)
    InitGridAt(x, y)
    gridValues[x][y] = gridValues[x][y] + 1
    if gridValues[x][y] == 1 then
        local cubePosition = Vector3.New(x, y, -0.5) * CUBE_SCALE
        local cubeScale = Vector3.ONE * CUBE_SCALE / 100
        local params = {position = cubePosition, scale = cubeScale}
        
        -- Spawn
        local cube = STATIC_CONTEXT:SpawnSharedAsset(CUBE_TEMPLATE, params)
        
        gridCubes[x][y] = cube
    end
end

-- Try to remove the cube at a given grid position
function RemoveAt(x, y)
    InitGridAt(x, y)
    gridValues[x][y] = gridValues[x][y] - 1
    if gridValues[x][y] == 0 then
        local cube = gridCubes[x][y]
        gridCubes[x][y] = nil
        
        -- Destroy
        STATIC_CONTEXT:DestroySharedAsset(cube)
    end
end

-- Make sure the grid is initialized at this position
function InitGridAt(x, y)
    if not gridValues[x] then
        gridValues[x] = {}
        gridValues[x][y] = 0
        gridCubes[x] = {}
        
    elseif not gridValues[x][y] then
        gridValues[x][y] = 0
    end
end
```

See also: [Player.serverUserData](player.md) | [Game.GetPlayers](game.md) | [CoreObject.GetCustomProperty](coreobject.md) | [CoreObjectReference.WaitForObject](coreobjectreference.md) | [CoreMath.Round](coremath.md) | [Vector3.New](vector3.md)

---
