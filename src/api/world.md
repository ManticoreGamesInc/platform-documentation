---
id: world
name: World
title: World
tags:
    - API
---

# World

World is a collection of functions for finding objects in the world.

## Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `World.GetRootObject()` | [`CoreObject`](coreobject.md) | Returns the root of the CoreObject hierarchy. | None |
| `World.FindObjectsByName(string name)` | `Array<`[`CoreObject`](coreobject.md)`>` | Returns a table containing all the objects in the hierarchy with a matching name. If none match, an empty table is returned. | None |
| `World.FindObjectsByType(string typeName)` | `Array<`[`CoreObject`](coreobject.md)`>` | Returns a table containing all the objects in the hierarchy whose type is or extends the specified type. If none match, an empty table is returned. | None |
| `World.FindObjectByName(string typeName)` | [`CoreObject`](coreobject.md) | Returns the first object found with a matching name. In none match, nil is returned. | None |
| `World.FindObjectById(string muid)` | [`CoreObject`](coreobject.md) | Returns the object with a given MUID. Returns nil if no object has this ID. | None |
| `World.SpawnAsset(string assetId, [table parameters])` | [`CoreObject`](coreobject.md) | Spawns an instance of an asset into the world. Optional parameters can specify a parent for the spawned object. Supported parameters include: parent (CoreObject) <br /> If provided, the spawned asset will be a child of this parent, and any Transform parameters are relative to the parent's Transform; `position (Vector3)`: Position of the spawned object; `rotation (Rotation or Quaternion)`: Rotation of the spawned object; `scale (Vector3)`: Scale of the spawned object. | None |
| `World.Raycast(Vector3 rayStart, Vector3 rayEnd, [table parameters])` | [`HitResult`](hitresult.md) | Traces a ray from `rayStart` to `rayEnd`, returning a `HitResult` with data about the impact point and object. Returns `nil` if no intersection is found. <br /> Optional parameters can be provided to control the results of the Raycast: `ignoreTeams (integer or Array<integer>)`: Don't return any players belonging to the team or teams listed; `ignorePlayers (Player, Array<Player>, or boolean)`: Ignore any of the players listed. If `true`, ignore all players. | None |

## Examples

Example using:

### `FindObjectById`

Finds an object in the hierarchy based on it's unique ID. To find an object's ID, right-click them in the hierarchy and select "Copy MUID". An object's ID can also be obtained at runtime through the `id` property. In this example we search for the default sky folder and print a warning if we find it.

```lua
local objectId = "8AD92A81CCE73D72:Default Sky"
local defaultSkyFolder = World.FindObjectById(objectId)
if defaultSkyFolder then
    warn(" The default sky is pretty good, but customizing the sky has a huge impact on your game's mood!")
end
```

See also: [CoreLua.warn](coreluafunctions.md)

---

Example using:

### `FindObjectByName`

Returns only one object with the given name. This example searches the entire hierarchy for the default floor object and prints a warning if it's found.

```lua
local floorObject = World.FindObjectByName("Default Floor")
-- Protect against error if the floor is missing from the game
if floorObject then
    warn(" Don't forget to replace the default floor with something better!")
end
```

See also: [CoreLua.warn](coreluafunctions.md)

---

Example using:

### `FindObjectsByName`

This example counts all the spawn points in the game for teams 1, 2 and 3, then prints how many belong to each team.

```lua
local team1Count = 0
local team2Count = 0
local team3Count = 0
local allSpawnPoints = World.FindObjectsByName("Spawn Point")

for _, point in ipairs(allSpawnPoints) do
    if point.team == 1 then
        team1Count = team1Count + 1

    elseif point.team == 2 then
        team2Count = team2Count + 1

    elseif point.team == 3 then
        team3Count = team3Count + 1
    end
end

print("Team 1 has " .. team1Count .. " spawn points.")
print("Team 2 has " .. team2Count .. " spawn points.")
print("Team 3 has " .. team3Count .. " spawn points.")
```

See also: [PlayerStart.team](playerstart.md) | [CoreLua.print](coreluafunctions.md)

---

Example using:

### `FindObjectsByType`

This example searches the hierarchy for all UI Containers and hides them when the player presses the 'U' key. Useful when capturing video! For this to work, setup the script in a Client context.

```lua
function OnBindingPressed(player, binding)
    if binding == "ability_extra_26" then
        local containers = World.FindObjectsByType("UIContainer")
        for _, c in pairs(containers) do
            c.visibility = Visibility.FORCE_OFF
        end
    end
end

function OnPlayerJoined(player)
    player.bindingPressedEvent:Connect(OnBindingPressed)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

See also: [CoreObject.visibility](coreobject.md) | [Player.bindingPressedEvent](player.md) | [Game.playerJoinedEvent](game.md) | [Event.Connect](event.md)

---

Example using:

### `GetRootObject`

There is a parent CoreObject for the entire hierarchy. Although not visible in the user interface, it's accessible with the World.GetRootObject() class function. This example walks the whole hierarchy tree (depth first) and prints the name+type of each Core Object.

```lua
function PrintAllNames(node)
    for _, child in ipairs(node:GetChildren()) do
        print(child.name .. " + " .. child.type)
        PrintAllNames(child)
    end
end

local worldRoot = World.GetRootObject()
PrintAllNames(worldRoot)
```

See also: [CoreObject.GetChildren](coreobject.md) | [Other.type](other.md)

---

Example using:

### `Raycast`

This example causes all players in the game to fly when they step off a ledge or jump. It does thy by using the Raycast() function to measure each player's distance to the ground below them.

```lua
local GROUND_DISTANCE = script:GetCustomProperty("GroundDistance") or 200
local downV = Vector3.New(0, 0, -GROUND_DISTANCE - 103)

function Tick()
    for _, player in pairs(Game.GetPlayers()) do
        local playerPos = player:GetWorldPosition()
        local hitResult = World.Raycast(playerPos, playerPos + downV, {ignorePlayers = true})

        if (player.isFlying and hitResult) then
            player:ActivateWalking()

        elseif (not player.isFlying and not hitResult) then
            player:ActivateFlying()
        end
    end
    Task.Wait(0.1)
end
```

See also: [HitResult.GetImpactPosition](hitresult.md) | [CoreObject.GetCustomProperty](coreobject.md) | [Game.GetPlayers](game.md) | [Player.GetWorldPosition](player.md) | [Vector3.New](vector3.md) | [CoreLua.Tick](coreluafunctions.md) | [Task.Wait](task.md)

---

Example using:

### `SpawnAsset`

In this example, whenever a player dies, an explosion VFX template is spawned  in their place and their body is flown upwards. The SpawnAsset() function also returns a reference to the new object, which allows us to do any number of adjustments to it--in this case a custom life span. This example assumes an explosion template exists in the project and it was added as a custom property onto the script object.

```lua
local EXPLOSION_TEMPLATE = script:GetCustomProperty("ExplosionVFX")

function OnPlayerDied(player, dmg)
    local playerPos = player:GetWorldPosition()
    local explosionObject = World.SpawnAsset(EXPLOSION_TEMPLATE, {position = playerPos})
    explosionObject.lifeSpan = 3

    player:AddImpulse(Vector3.UP * 1000 * player.mass)
end

function OnPlayerJoined(player)
    player.diedEvent:Connect(OnPlayerDied)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

See also: [CoreObject.Destroy](coreobject.md) | [Player.GetWorldPosition](player.md) | [Game.playerJoinedEvent](game.md) | [Vector3.UP](vector3.md) | [Event.Connect](event.md)

---
