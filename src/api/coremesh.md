---
id: coremesh
name: CoreMesh
title: CoreMesh
tags:
    - API
---

# CoreMesh

CoreMesh is a CoreObject representing a mesh that can be placed in the scene. It is the parent type for both AnimatedMesh and StaticMesh.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `team` | `Integer` | Assigns the mesh to a team. Value range from `0` to `4`. `0` is neutral team. | Read-Write |
| `isTeamColorUsed` | `bool` | If `true`, and the mesh has been assigned to a valid team, players on that team will see a blue mesh, while other players will see red. Requires a material that supports the color property. | Read-Write |
| `isTeamCollisionEnabled` | `bool` | If `false`, and the mesh has been assigned to a valid team, players on that team will not collide with the mesh. | Read-Write |
| `isEnemyCollisionEnabled` | `bool` | If `false`, and the mesh has been assigned to a valid team, players on other teams will not collide with the mesh. | Read-Write |
| `isCameraCollisionEnabled` | `bool` | If `false`, the mesh will not push against the camera. Useful for things like railings or transparent walls. | Read-Write |
| `meshAssetId` | `string` | The ID of the mesh asset used by this mesh. | Read-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetColor()` | `Color` | Returns the color override previously set from script, or `0, 0, 0, 0` if no such color has been set. | None |
| `SetColor(Color)` | `None` | Overrides the color of all materials on the mesh, and replicates the new colors. | None |
| `ResetColor()` | `None` | Turns off the color override, if there is one. | None |

## Examples

Using:

- `GetColor`
- `SetColor`
- `ResetColor`

You can set a color override for a mesh. Exactly what this means will depend on the material of the mesh, but in general, setting a mesh's color will make the mesh be tinted to match that color.

```lua
local cube = World.SpawnAsset(propCubeTemplate, {position = Vector3.New(1000, 0, 300) })

cube:SetColor(Color.WHITE)
for i = 1, 40 do
    local cubeColor = cube:GetColor()
    local newColor = Color.New(cubeColor.r * 0.95, cubeColor.g * 0.95, cubeColor.b * 0.95)
    cube:SetColor(newColor)
    Task.Wait(0.025)
end
cube:ResetColor()
```

See also: [World.SpawnAsset](world.md) | [Vector3.New](vector3.md) | [Color.WHITE](color.md) | [Task.Wait](task.md)

---

Using:

- `meshAssetId`

You can check the asset ID of a static mesh. This will be the MUID of the Core Content object it was created from!

```lua
local cube = World.SpawnAsset(propCubeTemplate, {position = Vector3.New(1000, 0, 300) })
print("The asset ID is " .. cube.meshAssetId)
```

See also: [World.SpawnAsset](world.md) | [Vector3.New](vector3.md) | [CoreLua.print](coreluafunctions.md)

---

Using:

- `team`
- `isTeamColorUsed`
- `isTeamCollisionEnabled`
- `isEnemyCollisionEnabled`
- `isCameraCollisionEnabled`

You can set a mesh to belong to a particular "team". These match the teams that players can be set to. (0-4)  There are also several properties that are keyed to what team an object is on.

This sample sets a mesh (and all of its children) to be on a particular team.

You can also control whether the camera is allowed to clip into a mesh or not.

```lua
function AssignMeshToTeam(mesh, team)
    local objects = mesh:FindDescendantsByType("CoreMesh")
    table.insert(objects, mesh)
    for k, mesh in ipairs(objects) do
        -- Set the team
        mesh.team = team
        -- Make the mesh tinted based on the color of the team it is on.
        mesh.isTeamColorUsed = true
        -- Enable collision for enemies, but not allies.
        mesh.isTeamCollisionEnabled = false
        mesh.isEnemyCollisionEnabled = true
        -- Set the camera to not collide with this mesh.
        mesh.isCameraCollisionEnabled = false
    end
end
AssignMeshToTeam(cube, 1)
```

See also: [CoreObject.FindDescendantsByType](coreobject.md)

---
