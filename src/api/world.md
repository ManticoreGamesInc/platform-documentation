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
| `World.FindObjectsByName(string name)` | `Array`<[`CoreObject`](coreobject.md)> | Returns a table containing all the objects in the hierarchy with a matching name. If none match, an empty table is returned. | None |
| `World.FindObjectsByType(string typeName)` | `Array`<[`CoreObject`](coreobject.md)> | Returns a table containing all the objects in the hierarchy whose type is or extends the specified type. If none match, an empty table is returned. | None |
| `World.FindObjectByName(string typeName)` | [`CoreObject`](coreobject.md) | Returns the first object found with a matching name. In none match, nil is returned. | None |
| `World.FindObjectById(string muid)` | [`CoreObject`](coreobject.md) | Returns the object with a given MUID. Returns nil if no object has this ID. | None |
| `World.SpawnAsset(string assetId, [table parameters])` | [`CoreObject`](coreobject.md) | Spawns an instance of an asset into the world. Optional parameters can specify a parent, transform, or other properties of the spawned object. Note that when spawning a template, most optional parameters apply only to the root object of the spawned template. <br/>Supported parameters include: <br/>`parent (CoreObject)`: If provided, the spawned asset will be a child of this parent, and any Transform parameters are relative to the parent's Transform. <br/>`position (Vector3)`: Position of the spawned object. <br/>`rotation (Rotation or Quaternion)`: Rotation of the spawned object. <br/>`scale (Vector3 or number)`: Scale of the spawned object, may be specified as a `Vector3` or as a `number` for uniform scale. <br/>`transform (Transform)`: The full transform of the spawned object. If `transform` is specified, it is an error to also specify `position`, `rotation`, or `scale`. <br/>`networkContext` ([NetworkContextType](../api/enums#networkcontexttype)): Overrides the network context of the spawned object. This may be used, for example, to spawn networked or static objects from a server only context, or client-only objects from a client script running in a static context, but it cannot spawn client only objects from a server script or networked objects from a client script. If an invalid context is specified, an error will be raised. <br/>`name (string)`: Set the name of the spawned object. <br/>`team (integer)`: Set the team on the spawned object. <br/>`lifeSpan (number)`: Set the life span of the spawned object. <br/>`collision (Collision)`: Set the collision of the spawned object. <br/>`visibility (Visibility)`: Set the visibility of the spawned object. <br/>`cameraCollision (Collision)`: Set the camera collision of the spawned object. <br/>`color (Color)`: Set the color of the spawned object. | None |
| `World.Raycast(Vector3 startPosition, Vector3 endPosition, [table parameters])` | [`HitResult`](hitresult.md) | Traces a ray from `startPosition` to `endPosition`, returning a `HitResult` with data about the impact point and object. Returns `nil` if no intersection is found. Note that if a raycast starts inside an object, that object will not be returned by the raycast. <br /> Optional parameters can be provided to control the results of the Raycast:<br/>`ignoreTeams (integer or Array<integer>)`: Don't return any players belonging to the team or teams listed. <br/>`ignorePlayers (Player, Array<Player>, or boolean)`: Ignore any of the players listed. If `true`, ignore all players. <br/>`checkObjects (Object, Array<Object>)`: Only return results that are contained in this list. <br/>`ignoreObjects (Object, Array<Object>)`: Ignore results that are contained in this list. <br/>`useCameraCollision (boolean)`: If `true`, results are found based on objects' camera collision property rather than their game collision. <br/>`shouldDebugRender (boolean)`: If `true`, enables visualization of the raycast in world space for debugging. <br/>`debugRenderDuration (number)`: Number of seconds for which debug rendering should remain on screen. Defaults to 1 second. <br/>`debugRenderThickness (number)`: The thickness of lines drawn for debug rendering. Defaults to 1. <br/>`debugRenderColor (Color)`: Overrides the color of lines drawn for debug rendering. If not specified, multiple colors may be used to indicate where results were hit. | None |
| `World.RaycastAll(Vector3 startPosition, Vector3 endPosition, [table parameters])` | `Array`<[`HitResult`](hitresult.md)> | Traces a ray from `startPosition` to `endPosition`, returning a list of `HitResult` instances with data about all objects found along the ray. Returns an empty table if no intersection is found. Note that if a raycast starts inside an object, that object will not be returned by the raycast. Optional parameters can be provided to control the results of the raycast using the same parameters supported by `World.Raycast()`. | None |
| `World.Spherecast(Vector3 startPosition, Vector3 endPosition, number radius, [table parameters])` | [`HitResult`](hitresult.md) | Traces a sphere with the specified radius from `startPosition` to `endPosition`, returning a `HitResult` with data about the first object hit along the way. Returns `nil` if no intersection is found. Note that a sphere cast starting entirely inside an object with complex collision may not return that object. Optional parameters can be provided to control the results of the sphere cast using the same parameters supported by `World.Raycast()`. | None |
| `World.SpherecastAll(Vector3 startPosition, Vector3 endPosition, number radius, [table parameters])` | `Array`<[`HitResult`](hitresult.md)> | Traces a sphere with the specified radius from `startPosition` to `endPosition`, returning a list of `HitResult` instances with data about all objects found along the path of the sphere. Returns an empty table if no intersection is found. Note that a sphere cast starting entirely inside an object with complex collision may not return that object. Optional parameters can be provided to control the results of the sphere cast using the same parameters supported by `World.Raycast()`. | None |
| `World.Boxcast(Vector3 startPosition, Vector3 endPosition, Vector3 boxSize, [table parameters])` | [`HitResult`](hitresult.md) | Traces a box with the specified size from `startPosition` to `endPosition`, returning a `HitResult` with data about the first object hit along the way. Returns `nil` if no intersection is found. Note that a box cast starting entirely inside an object with complex collision may not return that object. Optional parameters can be provided to control the results of the box cast using the same parameters supported by `World.Raycast()`, as well as the following additional parameters: <br/>`shapeRotation (Rotation)`: Rotation of the box shape being cast. Defaults to (0, 0, 0). <br/>`isWorldShapeRotation (boolean)`: If `true`, the `shapeRotation` parameter specifies a rotation in world space, or if no `shapeRotation` is provided, the box will be axis-aligned. Defaults to `false`, meaning the rotation of the box is relative to the direction in which it is being cast. | None |
| `World.BoxcastAll(Vector3 startPosition, Vector3 endPosition, Vector3 boxSize, [table parameters])` | `Array`<[`HitResult`](hitresult.md)> | Traces a box with the specified size from `startPosition` to `endPosition`, returning a list of `HitResult` instances with data about all objects found along the path of the box. Returns an empty table if no intersection is found. Note that a box cast starting entirely inside an object with complex collision may not return that object. Optional parameters can be provided to control the results of the box cast using the same parameters supported by `World.Raycast()` and `World.Boxcast()`. | None |
| `World.FindObjectsOverlappingSphere(Vector3 position, number radius, [table parameters])` | `Array`<[`Object`](object.md)> | Returns all objects found overlapping or within a sphere with the specified position and radius. Optional parameters can be provided to control the results of the search:<br/>`ignoreTeams (integer or Array<integer>)`: Don't return any players belonging to the team or teams listed. <br/>`ignorePlayers (Player, Array<Player>, or boolean)`: Ignore any of the players listed. If `true`, ignore all players. <br/>`checkObjects (Object, Array<Object>)`: Only return results that are contained in this list. <br/>`ignoreObjects (Object, Array<Object>)`: Ignore results that are contained in this list. <br/>`useCameraCollision (boolean)`: If `true`, results are found based on objects' camera collision property rather than their game collision. | None |
| `World.FindObjectsOverlappingBox(Vector3 position, Vector3 boxSize, [table parameters])` | `Array`<[`Object`](object.md)> | Returns all objects found overlapping or within a box with the specified position and size. Optional parameters can be provided to control the results of the search using the same parameters as `World.FindObjectsOverlappingSphere()`, as well as the following:<br/>`shapeRotation (Rotation)`: Rotation of the box shape being checked. Defaults to (0, 0, 0). | None |
| `World.GetBoundingBoxFromObjects(Array<CoreObject> objects, [table parameters])` | [`Box`](box.md) | Returns a `Box` describing the combined bounds of a list of objects. The `Box` span may exceed the exact extrema of the objects. Optional parameters can be provided to control the results:<br/>`onlyCollidable (boolean)`: If true, the box will only describe the bounds of the mesh's collidable geometry. This can be affected by collision settings and network context. Defaults to false. | None |

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

This example counts all the spawn points in the game for teams 1, 2, and 3, then prints how many belong to each team.

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

This example searches the hierarchy for all UI Containers and hides them when the player presses the key set up for the action in the bindings manager. Useful when capturing video. For this to work, setup the script in a Client context.

```lua
-- The action name to check for when a binding has been pressed.
local ACTION_NAME = script:GetCustomProperty("ActionName")

function OnActionPressed(player, action)
    if binding == ACTION_NAME then
        local containers = World.FindObjectsByType("UIContainer")
        for _, c in pairs(containers) do
            c.visibility = Visibility.FORCE_OFF
        end
    end
end

Input.actionPressedEvent:Connect(OnActionPressed)
```

See also: [CoreObject.visibility](coreobject.md) | [Input.actionPressedEvent](input.md) | [Game.playerJoinedEvent](game.md) | [Event.Connect](event.md)

---

Example using:

### `FindObjectsOverlappingBox`

In this example we search a room for all objects belonging to team 1 and team 2. The script is placed in one corner of the room and another object (such as an empty group) is placed in the opposite corner of the volume. The position of those objects can be used to calculate the center of the room, as well as its size on all 3 axes.

```lua
local OPPOSITE_CORNER_OBJ = script:GetCustomProperty("OppositeObject"):WaitForObject()
local oppositeCorner = OPPOSITE_CORNER_OBJ:GetWorldPosition()
local corner = script:GetWorldPosition()

local center = (corner + oppositeCorner) / 2
local delta = corner - oppositeCorner
local size = Vector3.New(math.abs(delta.x), math.abs(delta.y), math.abs(delta.z))

local team1Objects = World.FindObjectsOverlappingBox(center, size, {ignoreTeams = 2})
local team2Objects = World.FindObjectsOverlappingBox(center, size, {ignoreTeams = 1})
```

See also: [CoreObject.GetWorldPosition](coreobject.md) | [CoreObjectReference.WaitForObject](coreobjectreference.md) | [Vector3.New](vector3.md)

---

Example using:

### `FindObjectsOverlappingSphere`

Players are also of type Damageable. In this example, we use the World.FindObjectsOverlappingSphere() to determine all objects in the explosion area and then apply damage to the damageable ones.

```lua
local EXPLOSION_RADIUS = 500

local epicenter = script:GetWorldPosition()
local allObjects = World.FindObjectsOverlappingSphere(epicenter, EXPLOSION_RADIUS)

for _, obj in ipairs(allObjects) do
if obj:IsA("Damageable") then
    local dmg = Damage.New(100)
    dmg.reason = DamageReason.COMBAT
    obj:ApplyDamage(dmg)
end
end
```

See also: [Damage.New](damage.md) | [Damageable.ApplyDamage](damageable.md) | [CoreObject.GetWorldPosition](coreobject.md) | [Other.IsA](other.md)

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

This example causes all players in the game to fly when they step off a ledge or jump. It does so by using the World.Raycast() function to measure each player's distance to the ground below them.

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

This example allows player's to damage other players that they are aiming at. This is done using World.RaycastAll(), which returns a table of hitResults. This means that if multiple players are in a line then all of those players will be damaged. A good use case for this function would be for a laser gun.

```lua
function OnActionPressed(player, action)
    if action == "Shoot" then
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

Input.actionPressedEvent:Connect(OnActionPressed)
```

See also: [Player.GetViewWorldPosition](player.md) | [Input.actionPressedEvent](input.md) | [Damage.New](damage.md)

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

### `Spherecast`

In this example a sphere (Static Mesh) is placed in the game with this script as a child. As the player looks around, they give a possible movement direction for the sphere. The algorithm takes the player's input and predicts where the sphere would impact if it were moved in that direction. The impact normal and reflection/bounce direction are also calculated.

```lua
local SPHERE = script.parent
local RADIUS = SPHERE:GetWorldScale().x * 50
local RANGE = 1000

local HALF_PI = math.pi / 2
local player = nil

function Tick()
    if not Object.IsValid(player) then return end

    local direction = player:GetViewWorldRotation() * Vector3.FORWARD
    direction = direction:GetNormalized()

    -- The movement vector
    local startPos = SPHERE:GetWorldPosition()
    local endPos = startPos + direction * RANGE

    -- Spherecast gives us the point of impact of the sphere
    local hitResult = World.Spherecast(startPos, endPos, RADIUS, {ignoreObjects = SPHERE})
    if hitResult then
        -- Project the impact point onto the movement vector
        local A = startPos
        local B = endPos
        local P = hitResult:GetImpactPosition()
        local AP = P - A
        local AB = B - A
        local projection = A + (AP..AB) / (AB..AB) * AB

        -- Calculate where the sphere's center will be at moment of impact
        local distanceImpactToProj = (projection - P).size
        local angle = math.acos(distanceImpactToProj / RADIUS)
        local centerPos = projection - direction * RADIUS * angle / HALF_PI

        -- This impact normal is not the same you'll get from the HitResult
        local normal = (centerPos - P):GetNormalized()

        -- Get the direction of movement after impact
        local reflection = AB - 2 * (AB .. normal) * normal

        -- Draw where the sphere will be at moment of impact
        CoreDebug.DrawSphere(centerPos, RADIUS)
        -- Draw movement vector
        CoreDebug.DrawLine(startPos, centerPos, {thickness = 3, color = Color.RED})
        -- Draw normal vector
        CoreDebug.DrawLine(P, P + normal * 200, {thickness = 3, color = Color.MAGENTA})
        -- Draw reflection; direction of movement after impact
        CoreDebug.DrawLine(centerPos, centerPos + reflection, {thickness = 3, color = Color.YELLOW})
    else
        -- There was no impact. For example the Player aimed into the sky
        CoreDebug.DrawLine(startPos, endPos, {thickness = 3, color = Color.RED})
    end
end

Game.playerJoinedEvent:Connect(function(p)
    -- The first player to join gains control of the movement vector
    player = p
end)
```

See also: [Player.GetViewWorldRotation](player.md) | [CoreDebug.DrawLine](coredebug.md) | [Vector3.GetNormalized](vector3.md) | [CoreObject.GetWorldScale](coreobject.md) | [Game.PlayerJoinedEvent](game.md)

---

Example using:

### `SpherecastAll`

This example allows player's to damage other players that they are aiming at. This is done using World.SpherecastAll(), which returns a table of hitResults. This means that if multiple players are in a line then all of those players will be damaged. A good use case for this function would be for a laser gun.

```lua
function OnActionPressed(player, action)
    if action == "Shoot" then
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

Input.actionPressedEvent:Connect(OnActionPressed)
```

See also: [Player.GetViewWorldPosition](player.md) | [Input.actionPressedEvent](input.md) | [Damage.New](damage.md)

---
