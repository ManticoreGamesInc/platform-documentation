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
| `World.Raycast(Vector3 startPosition, Vector3 endPosition, [table parameters])` | [`HitResult`](hitresult.md) | Traces a ray from `startPosition` to `endPosition`, returning a `HitResult` with data about the impact point and object. Returns `nil` if no intersection is found. Note that if a raycast starts inside an object, that object will not be returned by the raycast. <br /> Optional parameters can be provided to control the results of the Raycast:<br/>`ignoreTeams (integer or Array<integer>)`: Don't return any players belonging to the team or teams listed. <br/>`ignorePlayers (Player, Array<Player>, or boolean)`: Ignore any of the players listed. If `true`, ignore all players. <br/>`checkObjects (Object, Array<Object>)`: Only return results that are contained in this list. <br/>`ignoreObjects (Object, Array<Object>)`: Ignore results that are contained in this list. <br/>`shouldDebugRender (boolean)`: If `true`, enables visualization of the raycast in world space for debugging. <br/>`debugRenderDuration (number)`: Number of seconds for which debug rendering should remain on screen. Defaults to 1 second. <br/>`debugRenderThickness (number)`: The thickness of lines drawn for debug rendering. Defaults to 1. <br/>`debugRenderColor (Color)`: Overrides the color of lines drawn for debug rendering. If not specified, multiple colors may be used to indicate where results were hit. | None |
| `World.RaycastAll(Vector3 startPosition, Vector3 endPosition, [table parameters])` | `Array<`[`HitResult`](hitresult.md)`>` | Traces a ray from `startPosition` to `endPosition`, returning a list of `HitResult` instances with data about all objects found along the ray. Returns an empty table if no intersection is found. Note that if a raycast starts inside an object, that object will not be returned by the raycast. Optional parameters can be provided to control the results of the raycast using the same parameters supported by `World.Raycast()`. | None |
| `World.Spherecast(Vector3 startPosition, Vector3 endPosition, number radius, [table parameters])` | [`HitResult`](hitresult.md) | Traces a sphere with the specified radius from `startPosition` to `endPosition`, returning a `HitResult` with data about the first object hit along the way. Returns `nil` if no intersection is found. Note that a sphere cast starting entirely inside an object with complex collision may not return that object. Optional parameters can be provided to control the results of the sphere cast using the same parameters supported by `World.Raycast()`. | None |
| `World.SpherecastAll(Vector3 startPosition, Vector3 endPosition, number radius, [table parameters])` | `Array<`[`HitResult`](hitresult.md)`>` | Traces a sphere with the specified radius from `startPosition` to `endPosition`, returning a list of `HitResult` instances with data about all objects found along the path of the sphere. Returns an empty table if no intersection is found. Note that a sphere cast starting entirely inside an object with complex collision may not return that object. Optional parameters can be provided to control the results of the sphere cast using the same parameters supported by `World.Raycast()`. | None |
| `World.Boxcast(Vector3 startPosition, Vector3 endPosition, Vector3 boxSize, [table parameters])` | [`HitResult`](hitresult.md) | Traces a box with the specified size from `startPosition` to `endPosition`, returning a `HitResult` with data about the first object hit along the way. Returns `nil` if no intersection is found. Note that a box cast starting entirely inside an object with complex collision may not return that object. Optional parameters can be provided to control the results of the box cast using the same parameters supported by `World.Raycast()`, as well as the following additional parameters: <br/>`shapeRotation (Rotation)`: Rotation of the box shape being cast. Defaults to (0, 0, 0). <br/>`isWorldShapeRotation (boolean)`: If `true`, the `shapeRotation` parameter specifies a rotation in world space, or if no `shapeRotation` is provided, the box will be axis-aligned. Defaults to `false`, meaning the rotation of the box is relative to the direction in which it is being cast. | None |
| `World.BoxcastAll(Vector3 startPosition, Vector3 endPosition, Vector3 boxSize, [table parameters])` | `Array<`[`HitResult`](hitresult.md)`>` | Traces a box with the specified size from `startPosition` to `endPosition`, returning a list of `HitResult` instances with data about all objects found along the path of the box. Returns an empty table if no intersection is found. Note that a box cast starting entirely inside an object with complex collision may not return that object. Optional parameters can be provided to control the results of the box cast using the same parameters supported by `World.Raycast()` and `World.Boxcast()`. | None |

## Examples

Example using:

### `Boxcast`

In this example any object that the player looks at will be outlined using an Outline Object. This is done using World.Boxcast(), which returns a hitResult with the impacted object. Using a Boxcast here is useful because the player doesn't have to look directly at an object for it to be highlighted but just close to it.

```lua
local OutlineObject = script:GetCustomProperty("OutlineObject"):WaitForObject()

local LOCAL_PLAYER = Game.GetLocalPlayer()
local viewedObject = nil

function Tick()
    local rayStart = LOCAL_PLAYER:GetViewWorldPosition()
    local lookVector = LOCAL_PLAYER:GetViewWorldRotation() * Vector3.FORWARD
    local hitResult = World.Boxcast(rayStart, rayStart + (lookVector * 5000), Vector3.New(30), {ignorePlayers=LOCAL_PLAYER})

    if hitResult and not hitResult.other:IsA("Player") and hitResult.other ~= viewedObject then
        OutlineObject:SetSmartProperty("Object To Outline", hitResult.other)
        OutlineObject:SetSmartProperty("Enabled", true)
        viewedObject = hitResult.other
    elseif not hitResult then
        OutlineObject:SetSmartProperty("Enabled", false)
        viewedObject = nil
    end
end
```

See also: [Player.GetViewWorldPosition](player.md) | [Damage.New](damage.md) | [CoreLua.Tick](coreluafunctions.md)

---

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

### `RaycastAll`

This example allows player's to damage other players that they are aiming at. This is done using World.RaycastAll(), which returns a table of hitResults. This means that if multiple players are in a line then all of those players will be damaged. A good usecase for this function would be for a laser gun.

```lua
function OnBindingPressed(player, binding)
    if binding == "ability_primary" then
        local rayStart = player:GetViewWorldPosition()
        local lookVector = player:GetViewWorldRotation() * Vector3.FORWARD
        local results = World.RaycastAll(rayStart, rayStart + (lookVector * 5000), {ignorePlayers=player, shouldDebugRender = true})

        for _, hitResult in ipairs(results) do
            if hitResult.other:IsA("Player") then
                if not hitResult.other.isDead then
                    local dmg = Damage.New(10)
                    hitResult.other:ApplyDamage(dmg)
                end
            else
                break
            end
        end
    end
end

function OnPlayerJoined(player)
    player.bindingPressedEvent:Connect(OnBindingPressed)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

See also: [Player.GetViewWorldPosition](player.md) | [Damage.New](damage.md)

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

Example using:

### `SpawnAsset`

The function `World.SpawnAsset()` also supports spawning non-template assets, such as a `UI Image` or `Script`. In this example, the Alien icon is set as a custom property of the script. The script is placed as a child of a UI Container. The script spawns the image as a child of the container and aligns it to the center of the screen.

```lua
local UI_CONTAINER = script.parent
local UI_IMAGE = script:GetCustomProperty("Alien")

local image = World.SpawnAsset(UI_IMAGE, {parent = UI_CONTAINER})
image.anchor = UIPivot.MIDDLE_CENTER
image.dock = UIPivot.MIDDLE_CENTER
```

See also: [UIControl.anchor](uicontrol.md) | [CoreObject.GetCustomProperty](coreobject.md)

---

Example using:

### `Spherecast`

In this example any object that the player looks at will be outlined using an Outline Object. This is done using World.Spherecast(), which returns a hitResult with the impacted object. Using a Spherecast here is useful because the player doesn't have to look directly at an object for it to be highlighted but just close to it.

```lua
local OutlineObject = script:GetCustomProperty("OutlineObject"):WaitForObject()

local LOCAL_PLAYER = Game.GetLocalPlayer()
local viewedObject = nil

function Tick()
    local rayStart = LOCAL_PLAYER:GetViewWorldPosition()
    local lookVector = LOCAL_PLAYER:GetViewWorldRotation() * Vector3.FORWARD
    local hitResult = World.Spherecast(rayStart, rayStart + (lookVector * 5000), 30, {ignorePlayers=LOCAL_PLAYER})

    if hitResult and not hitResult.other:IsA("Player") and hitResult.other ~= viewedObject then
        OutlineObject:SetSmartProperty("Object To Outline", hitResult.other)
        OutlineObject:SetSmartProperty("Enabled", true)
        viewedObject = hitResult.other
    elseif not hitResult then
        OutlineObject:SetSmartProperty("Enabled", false)
        viewedObject = nil
    end
end
```

See also: [Player.GetViewWorldPosition](player.md) | [Damage.New](damage.md) | [CoreLua.Tick](coreluafunctions.md)

---

Example using:

### `SpherecastAll`

This example allows player's to damage other players that they are aiming at. This is done using World.SpherecastAll(), which returns a table of hitResults. This means that if multiple players are in a line then all of those players will be damaged. A good usecase for this function would be for a laser gun.

```lua
function OnBindingPressed(player, binding)
    if binding == "ability_primary" then
        local rayStart = player:GetViewWorldPosition()
        local lookVector = player:GetViewWorldRotation() * Vector3.FORWARD
        local results = World.SpherecastAll(rayStart, rayStart + (lookVector * 5000), 50, {ignorePlayers=player, shouldDebugRender = true})

        for _, hitResult in ipairs(results) do
            if hitResult.other:IsA("Player") then
                if not hitResult.other.isDead then
                    local dmg = Damage.New(10)
                    hitResult.other:ApplyDamage(dmg)
                end
            else
                break
            end
        end
    end
end

function OnPlayerJoined(player)
    player.bindingPressedEvent:Connect(OnBindingPressed)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

See also: [Player.GetViewWorldPosition](player.md) | [Damage.New](damage.md)

---
