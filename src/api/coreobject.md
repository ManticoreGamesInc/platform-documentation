---
id: coreobject
name: CoreObject
title: CoreObject
tags:
    - API
---

# CoreObject

CoreObject is an Object placed in the scene hierarchy during edit mode or is part of a template. Usually they'll be a more specific type of CoreObject, but all CoreObjects have these properties and functions:

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `name` | `string` | The object's name as seen in the Hierarchy. | Read-Write |
| `id` | `string` | The object's MUID. | Read-Only |
| `parent` | `CoreObject` | The object's parent object, may be nil. | Read-Write |
| `visibility` | `enum` | Turn on/off the rendering of an object and its children. Values: `Visibility.FORCE_ON`, `Visibility.FORCE_OFF`, `Visibility.INHERIT`. | Read-Write |
| `collision` | `enum` | Turn on/off the collision of an object and its children. Values: `Collision.FORCE_ON`, `Collision.FORCE_OFF`, `Collision.INHERIT`. | Read-Write |
| `isEnabled` | `bool` | Turn on/off an object and its children completely. | Read-Write |
| `isStatic` | `bool` | If `true`, dynamic properties may not be written to, and dynamic functions may not be called. | Read-Only |
| `isClientOnly` | `bool` | If `true`, this object was spawned on the client and is not replicated from the server. | Read-Only |
| `isServerOnly` | `bool` | If `true`, this object was spawned on the server and is not replicated to clients. | Read-Only |
| `isNetworked` | `bool` | If `true`, this object replicates from the server to clients. | Read-Only |
| `lifeSpan` | `Number` | Duration after which the object is destroyed. | Read-Write |
| `sourceTemplateId` | `string` | The ID of the Template from which this CoreObject was instantiated. `nil` if the object did not come from a Template. | Read-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetTransform()` | `Transform` | The Transform relative to this object's parent. | None |
| `SetTransform(Transform)` | `None` | The Transform relative to this object's parent. | None |
| `GetPosition()` | `Vector3` | The position of this object relative to its parent. | None |
| `SetPosition(Vector3)` | `None` | The position of this object relative to its parent. | None |
| `GetRotation()` | `Rotation` | The rotation relative to its parent. | None |
| `SetRotation(Rotation)` | `None` | The rotation relative to its parent. | None |
| `GetScale()` | `Vector3` | The scale relative to its parent. | None |
| `SetScale(Vector3)` | `None` | The scale relative to its parent. | None |
| `GetWorldTransform()` | `Transform` | The absolute Transform of this object. | None |
| `SetWorldTransform(Transform)` | `None` | The absolute Transform of this object. | None |
| `GetWorldPosition()` | `Vector3` | The absolute position. | None |
| `SetWorldPosition(Vector3)` | `None` | The absolute position. | None |
| `GetWorldRotation()` | `Rotation` | The absolute rotation. | None |
| `SetWorldRotation(Rotation)` | `None` | The absolute rotation. | None |
| `GetWorldScale()` | `Vector3` | The absolute scale. | None |
| `SetWorldScale(Vector3)` | `None` | The absolute scale. | None |
| `GetVelocity()` | `Vector3` | The object's velocity in world space. | None |
| `SetVelocity(Vector3)` | `None` | Set the object's velocity in world space. Only works for physics objects. | None |
| `GetAngularVelocity()` | `Vector3` | The object's angular velocity in degrees per second. | None |
| `SetAngularVelocity(Vector3)` | `None` | Set the object's angular velocity in degrees per second in world space. Only works for physics objects. | None |
| `SetLocalAngularVelocity(Vector3)` | `None` | Set the object's angular velocity in degrees per second in local space. Only works for physics objects. | None |
| `GetReference()` | `CoreObjectReference` | Returns a CoreObjectReference pointing at this object. | None |
| `GetChildren()` | `Array<CoreObject>` | Returns a table containing the object's children, may be empty. | None |
| `IsVisibleInHierarchy()` | `bool` | Returns true if this object and all of its ancestors are visible. | None |
| `IsCollidableInHierarchy()` | `bool` | Returns true if this object and all of its ancestors are collidable. | None |
| `IsEnabledInHierarchy()` | `bool` | Returns true if this object and all of its ancestors are enabled. | None |
| `FindAncestorByName(string name)` | `CoreObject` | Returns the first parent or ancestor whose name matches the provided name. If none match, returns nil. | None |
| `FindChildByName(string name)` | `CoreObject` | Returns the first immediate child whose name matches the provided name. If none match, returns nil. | None |
| `FindDescendantByName(string name)` | `CoreObject` | Returns the first child or descendant whose name matches the provided name. If none match, returns nil. | None |
| `FindDescendantsByName(string name)` | `Array<CoreObject>` | Returns the descendants whose name matches the provided name. If none match, returns an empty table. | None |
| `FindAncestorByType(string typeName)` | `CoreObject` | Returns the first parent or ancestor whose type is or extends the specified type. For example, calling FindAncestorByType('CoreObject') will return the first ancestor that is any type of CoreObject, while FindAncestorByType('StaticMesh') will only return the first mesh. If no ancestors match, returns nil. | None |
| `FindChildByType(string typeName)` | `CoreObject` | Returns the first immediate child whose type is or extends the specified type. If none match, returns nil. | None |
| `FindDescendantByType(string typeName)` | `CoreObject` | Returns the first child or descendant whose type is or extends the specified type. If none match, returns nil. | None |
| `FindDescendantsByType(string typeName)` | `Array<CoreObject>` | Returns the descendants whose type is or extends the specified type. If none match, returns an empty table. | None |
| `FindTemplateRoot()` | `CoreObject` | If the object is part of a template, returns the root object of the template (which may be itself). If not part of a template, returns nil. | None |
| `IsAncestorOf(CoreObject)` | `bool` | Returns true if this CoreObject is a parent somewhere in the hierarchy above the given parameter object. False otherwise. | None |
| `GetCustomProperties()` | `table` | Returns a table containing the names and values of all custom properties on a CoreObject. | None |
| `GetCustomProperty(string propertyName)` | `value, bool` | Gets data which has been added to an object using the custom property system. Returns the value, which can be an Integer, Number, bool, string, Vector2, Vector3, Vector4, Rotation, Color, CoreObjectReference, a MUID string (for Asset References), NetReference, or nil if not found. Second return value is a bool, true if found and false if not. | None |
| `SetNetworkedCustomProperty(string propertyName, value)` | `bool` | Sets the named custom property if it is marked as replicated and the object it belongs to is server-side networked or in a client/server context. The value must match the existing type of the property, with the exception of CoreObjectReference properties (which accept a CoreObjectReference or a CoreObject) and Asset Reference properties (which accept a string MUID). AssetReferences, CoreObjectReferences, and NetReferences also accept `nil` to clear their value, although `GetCustomProperty()` will still return an unassigned CoreObjectReference or NetReference rather than `nil`. (See the `.isAssigned` property on those types.) | None |
| `AttachToPlayer(Player, string socketName)` | `None` | Attaches a CoreObject to a Player at a specified socket. The CoreObject will be un-parented from its current hierarchy and its `parent` property will be nil. See [Socket Names](../api/animations.md#socket-names) for the list of possible values. | None |
| `AttachToLocalView()` | `None` | Attaches a CoreObject to the local player's camera. Reminder to turn off the object's collision otherwise it will cause camera to jitter. | Client-Only |
| `Detach()` | `None` | Detaches a CoreObject from any player it has been attached to, or from its parent object. | None |
| `GetAttachedToSocketName()` | `string` | Returns the name of the socket this object is attached to. | None |
| `MoveTo(Vector3, Number, [bool])` | `None` | Smoothly moves the object to the target location over a given amount of time (seconds). Third parameter specifies if the given destination is in local space (true) or world space (false). | None |
| `RotateTo(Rotation/Quaternion, Number, [bool])` | `None` | Smoothly rotates the object to the target orientation over a given amount of time. Third parameter specifies if given rotation is in local space (true) or world space (false). | None |
| `ScaleTo(Vector3, Number, [bool])` | `None` | Smoothly scales the object to the target scale over a given amount of time. Third parameter specifies if the given scale is in local space (true) or world space (false). | None |
| `MoveContinuous(Vector3, [bool])` | `None` | Smoothly moves the object over time by the given velocity vector. Second parameter specifies if the given velocity is in local space (true) or world space (false). | None |
| `RotateContinuous(Rotation/Quaternion, [Number, [bool]])` | `None` | Smoothly rotates the object over time by the given rotation (per second). The second parameter is an optional multiplier, for very fast rotations. Third parameter specifies if the given rotation or quaternion is in local space (true) or world space (false (default)). | None |
| `RotateContinuous(Vector3, [bool])` | `None` | Smoothly rotates the object over time by the given angular velocity. Second parameter specifies whether to interpret the given velocity in local space (true) or world space (false (default)). | None |
| `ScaleContinuous(Vector3, [bool])` | `None` | Smoothly scales the object over time by the given scale vector per second. Second parameter specifies if the given scale rate is in local space (true) or world space (false). | None |
| `StopMove()` | `None` | Interrupts further movement from MoveTo(), MoveContinuous(), or Follow(). | None |
| `StopRotate()` | `None` | Interrupts further rotation from RotateTo(), RotateContinuous(), LookAtContinuous(), or LookAtLocalView(). | None |
| `StopScale()` | `None` | Interrupts further movement from ScaleTo() or ScaleContinuous(). | None |
| `Follow(Object, [Number, [Number]])` | `None` | Follows a CoreObject or Player at a certain speed. If the speed is not supplied it will follow as fast as possible. The third parameter specifies a distance to keep away from the target. | None |
| `LookAt(Vector3 position)` | `None` | Instantly rotates the object to look at the given position. | None |
| `LookAtContinuous(Object, [bool], [Number])` | `None` | Smoothly rotates a CoreObject to look at another given CoreObject or Player. Second parameter is optional and locks the pitch, default is unlocked. Third parameter is optional and sets how fast it tracks the target (in radians/second). If speed is not supplied it tracks as fast as possible. | None |
| `LookAtLocalView([bool])` | `None` | Continuously looks at the local camera. The bool parameter is optional and locks the pitch. (Client-only) | None |
| `Destroy()` | `None` | Destroys the object and all descendants. You can check whether an object has been destroyed by calling `Object.IsValid(object)`, which will return true if object is still a valid object, or false if it has been destroyed. | None |

## Events

| Event Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `childAddedEvent` | `Event<CoreObject parent, CoreObject newChild>` | Fired when a child is added to this object. | None |
| `childRemovedEvent` | `Event<CoreObject parent, CoreObject removedChild>` | Fired when a child is removed from this object. | None |
| `descendantAddedEvent` | `Event<CoreObject ancestor, CoreObject newChild>` | Fired when a child is added to this object or any of its descendants. | None |
| `descendantRemovedEvent` | `Event<CoreObject ancestor, CoreObject removedChild>` | Fired when a child is removed from this object or any of its descendants. | None |
| `destroyEvent` | `Event<CoreObject>` | Fired when this object is about to be destroyed. | None |
| `networkedPropertyChangedEvent` | `Event<CoreObject owner, string propertyName>` | Fired whenever any of the networked custom properties on this object receive an update. The event is fired on the server and the client. Event payload is the owning object and the name of the property that just changed. | None |

## Examples

Using:

- `childAddedEvent`

This event fires when something gets added as a direct child of an object. (i. e. not a child of a child.)

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")
local obj = World.SpawnAsset(propCubeTemplate)

local function ChildAdded()
    -- This code will be executed every time a child is added to the object.
    UI.PrintToScreen("A child was added to the object!")
end

obj.childAddedEvent:Connect(ChildAdded)

-- This will cause ChildAdded to execute.
local obj2 = World.SpawnAsset(propCubeTemplate, {parent = obj})

-- This will NOT cause ChildAdded to execute, because obj3 is not a direct child of obj.
local obj3 = World.SpawnAsset(propCubeTemplate, {parent = obj2})
```

---

Using:

- `childRemovedEvent`

This event fires when a direct child of the object is removed.

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")
local obj = World.SpawnAsset(propCubeTemplate)

local function ChildRemoved()
    -- This code will be executed every time a child is removed from the object.
    UI.PrintToScreen("A child was removed from the object!")
end

obj.childRemovedEvent:Connect(ChildRemoved)

local obj2 = World.SpawnAsset(propCubeTemplate, {parent = obj})

-- This will cause ChildRemoved to fire, because we are removing a child from obj.
obj2:Destroy()
```

---

Using:

- `descendantAddedEvent`

This event fires when something gets added as a direct child of an object. (i. e. not a child of a child.)

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")
local obj = World.SpawnAsset(propCubeTemplate)

local function DescendantAdded()
    -- This code will be executed every time a child is added to the object, or one of its children.
    UI.PrintToScreen("A descendant was added to the object!")
end

obj.descendantAddedEvent:Connect(DescendantAdded)

-- This will cause DescendantAdded to execute.
local obj2 = World.SpawnAsset(propCubeTemplate, {parent = obj})

-- This will also cause DescendantAdded to execute, because obj3 is a descendant of obj.
local obj3 = World.SpawnAsset(propCubeTemplate, {parent = obj2})
```

---

Using:

- `descendantRemovedEvent`

This event fires when a descendant of the object is removed. This is any object that has the object somewhere up the hierarchy tree as a parent.

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")
local obj = World.SpawnAsset(propCubeTemplate)

local function DescendantRemoved()
    -- This code will be executed every time a descendant is removed from the object.
    UI.PrintToScreen("A descendant was removed from the object!")
end

obj.descendantRemovedEvent:Connect(DescendantRemoved)

local obj2 = World.SpawnAsset(propCubeTemplate, {parent = obj})
local obj3 = World.SpawnAsset(propCubeTemplate, {parent = obj2})

-- This will cause DescendantRemoved to fire, because we are removing a descendant from obj.
obj3:Destroy()
-- This will also cause DescendantRemoved to fire, because we are removing a descendant from obj.
obj2:Destroy()
```

---

Using:

- `destroyEvent`
- `Destroy`
- `lifeSpan`

There are several ways of destroying `CoreObject`s, and noticing when they are destroyed.

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")

function OnDestroyListener(obj)
    print(obj.name .. " has been destroyed!")
end

local template1 = World.SpawnAsset(propCubeTemplate)
local template2 = World.SpawnAsset(propCubeTemplate, {parent = template1})

-- You can destroy an object directly, via the Destroy() method.
-- Children are also automatically destroyed when their parent is destroyed.

template1.destroyEvent:Connect(OnDestroyListener)
template2.destroyEvent:Connect(OnDestroyListener)

template1.name = "Template 1"
template2.name = "Template 2"

template1:Destroy()

-- output:
-- Template 2 has been destroyed!
-- Template 1 has been destroyed!

-- You can also set the lifeSpan of objects. They will destroy themselves in
-- that many seconds.
local template3 = World.SpawnAsset(propCubeTemplate)
template3.name = "Template 3"
template3.destroyEvent:Connect(OnDestroyListener)
template3.lifeSpan = 1
Task.Wait(1.5)
-- Template 3 has been destroyed.

-- The timer for lifespans is set when the lifeSpan property is changed.
-- So even though the object has existed for 1 second already, setting the
-- lifeSpan to 0.5 does not immediately destroy it - instead, the object
-- is destroyed 0.5 seconds after the lifeSpan is set.
local template4 = World.SpawnAsset(propCubeTemplate)
template4.name = "Template 4"
template4.destroyEvent:Connect(OnDestroyListener)
Task.Wait(1)
template4.lifeSpan = 0.5
Task.Wait(1)
```

See also: [CoreObject.GetCustomProperty](coreobject.md) | [World.SpawnAsset](world.md) | [Event.Connect](event.md) | [Task.Wait](task.md) | [CoreLua.print](coreluafunctions.md)

---

Using:

- `AttachToPlayer`
- `AttachToLocalView`
- `Detach`
- `GetAttachedToSocketName`
- `GetAttachedObjects`

Whether you're building sticky-mines, or costumes, sometimes it is useful to be able to attach a `CoreObject` directly to a spot on a player.

When attaching an object to a player you need to specify the "socket" you want to attach it to. The list of legal sockets can be found on its own page in the documentation.

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")
local cube = World.SpawnAsset(propCubeTemplate)
cube.collision = Collision.FORCE_OFF

-- attach the cube to the player's head
cube:AttachToPlayer(player, "head")

-- We can also check what socket an object is attached to.
print(cube:GetAttachedToSocketName())   -- Head

-- Alternately, we can ask the player for a list of CoreObjects that
-- are attached to it:
print("Attached objects: ")
for _, v in ipairs(player:GetAttachedObjects()) do
    print(tostring(v.name))
end

cube:Detach()

--[[#description
It's also possible to attach objects to the local view on the client.
Note that this only works from inside a client context:
]]
cube:AttachToLocalView()
```

See also: [CoreObject.GetCustomProperty](coreobject.md) | [World.SpawnAsset](world.md) | [CoreLua.print](coreluafunctions.md)

---

Using:

- `Destroy`

A simple example on how to destroy a CoreObject.

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")
-- This is the object you would like to destroy/remove:
local cube = World.SpawnAsset(propCubeTemplate)

cube:Destroy() -- This will destroy the object.
```

---

Using:

- `Follow`
- `LookAt`
- `LookAtContinuous`
- `LookAtLocalView`

There are some handy convenience functions for animating certain kinds of behaviors. There is a `CoreObject:LookAt()` function, which forces a `CoreObject` to rotate itself to be facing a specific point in the world. There is a `CoreObject:Follow()` function, that tells a `CoreObject` to follow a set distance and speed behind another object. And there is a `CoreObject:LookAtContinuous()`, which tells a core object to rotate itself towards another `CoreObject` or `Player`, and keep looking at them until stopped.

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")
local movingCube = World.SpawnAsset(propCubeTemplate, {position = Vector3.New(500, -200, 100)})
local followingCube = World.SpawnAsset(propCubeTemplate, {position = Vector3.New(500, 0, 100)})
local watchingCube = World.SpawnAsset(propCubeTemplate, {position = Vector3.New(500, 200, 100)})

-- We can make an object turn to face any given point in the world:
watchingCube:LookAt(movingCube:GetWorldPosition())

-- We can also have an object keep facing a player or object, until we
-- call stopRotate. This example makes a cube move, while an other
-- cube watches it, while yet a third cube tries to follow it. (While
-- staying 200 units away.)
movingCube:MoveTo(movingCube:GetWorldPosition() + Vector3.UP * 1000, 5)
followingCube:Follow(movingCube, 500, 200)
watchingCube:LookAtContinuous(movingCube)
Task.Wait(5)

--[[#Description
    It's also possible to make an object always look at EVERY player. This obviously only works
    on objects that are in a client context, but the `LookAtLocalView` function causes a client-context
    object to always turn and face the local player.
]]
    local watchingCube = World.SpawnAsset(propCubeTemplate, {position = Vector3.New(500, 200, 100)})
    watchingCube:LookAtLocalView() -- This only works in a client context!
```

See also: [CoreObject.GetCustomProperty](coreobject.md) | [World.SpawnAsset](world.md) | [Vector3.New](vector3.md) | [Task.Wait](task.md)

---

Using:

- `GetChildren`
- `FindAncestorByName`
- `FindChildByName`
- `FindDescendantByName`
- `FindDescendantsByName`
- `FindAncestorByType`
- `FindChildByType`
- `FindDescendantByType`
- `FindDescendantsByType`
- `FindTemplateRoot`
- `IsAncestorOf`
- `parent`

You can inspect most of the hierarchy at runtime.

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")
local propSampleSoundFX = script:GetCustomProperty("SampleSoundFX")

local template1 = World.SpawnAsset(propCubeTemplate)
local template2 = World.SpawnAsset(propSampleSoundFX, {parent = template1})
local template3 = World.SpawnAsset(propCubeTemplate, {parent = template2})
local template4 = World.SpawnAsset(propSampleSoundFX, {parent = template2})

template1.name = "template1"
template2.name = "template2"
template3.name = "child"
template4.name = "child"

-- The hierarchy should now look like this:
--
-- template 1
--   +-template 2      -- Note that this one is an audio object!
--       +-template 3
--       +-template 4  -- This is also audio

-- We can get references to other things in the tree if we know their string name:
local ancestor = template4:FindAncestorByName("template1")

-- This one only looks at direct children.
local child = template1:FindChildByName("template2")

-- You can also get a list of all direct children:
local childList = template2:GetChildren()

-- CoreObjects are also aware of their own parents, if any:
print(template2.parent.name) -- template1

if ancestor:IsAncestorOf(child) then
    print("This is an ancestor!")
end

-- FindDescendantByName will return the *first* descendant that matches the name.
local descendant = template1:FindDescendantByName("child")
-- descendant now equals template3

-- FindDescendantsByName will return an array of ALL the descendants who match the name.
local descendantList = template1:FindDescendantsByName("child")
-- descendantList is an array that contains {template3, template4}

-- We can also search by object type. template2 is an Audio object, so we can search for it:
local audioDescendant = template1:FindDescendantByType("Audio")
local audioDescendantList = template1:FindDescendantsByType("Audio")
-- audioDescendantList is an array that contains {template2, template4}

-- FindChildByType will only look at direct children.
local child = template1:FindChildByType("Audio")
-- Should give us template2

-- We can search up the tree by type as well:
local ancestorByType = template3:FindAncestorByType("StaticMesh")
-- This one goes all the way up the tree and returns template 1, because template3's direct
-- parent is an Audio object and not a StaticMesh.

-- If we have a reference to an object in a template, we can also find the root of the template.
local templateRoot = template1:FindTemplateRoot()
-- this should just give us back Template1, because it is already the root.
```

See also: [CoreObject.GetCustomProperty](coreobject.md) | [World.SpawnAsset](world.md) | [CoreLua.print](coreluafunctions.md)

---

Using:

- `GetCustomProperties`
- `GetCustomProperty`

Almost any object in the hierarchy can have "custom properties" associated with it. These are values that you can change in the editor, but that scripts can easily access. They're useful for making modular components that can be configured without needing to modify Lua code. You can specify the data type of a custom property, to tell the Core editor what sort of data you plan on storing in there.

In this example, we've added some custom properties onto the script, to demonstrate how to access them.

Specifically, we've added the following custom types to our script:

`BestFood` : String

`NumberOfCats` : Int

`FavoriteColor` : Color

```lua
-- We can read from custom properties directly, if we know their name:
-- When you add a custom property, code like this is auto-generated in the
-- inspector window, and can be easily cut-and-pasted into your script!
local propBestFood = script:GetCustomProperty("BestFood")
local propNumberOfCats = script:GetCustomProperty("NumberOfCats")
local propFavoriteColor = script:GetCustomProperty("FavoriteColor")

-- In some cases, a script might not know which custom properties exist.
-- We can request a list of ALL custom properties, in table form:

for propName, propValue in pairs(script:GetCustomProperties()) do
    print("Found property [" .. propName .. "] with value [" .. tostring(propValue) .. "]")
end
```

See also: [CoreLua.print](coreluafunctions.md)

---

Using:

- `GetTransform`
- `SetTransform`
- `GetPosition`
- `SetPosition`
- `GetRotation`
- `SetRotation`
- `GetScale`
- `SetScale`
- `GetWorldTransform`
- `SetWorldTransform`
- `GetWorldPosition`
- `SetWorldPosition`
- `GetWorldRotation`
- `SetWorldRotation`
- `GetWorldScale`
- `SetWorldScale`

One of the most common basic thing you will want to do, is move things around in the world. All CoreObjects have a Transform, which represents where they are, which direction they are facing, and what size they are. You can read or write this, either as a whole `Transform` object, or by its components. (Scale, Rotation and Position)

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")
local cube1 = World.SpawnAsset(propCubeTemplate)
local cube2 = World.SpawnAsset(propCubeTemplate)

cube2.parent = cube1

cube1:SetWorldPosition(Vector3.New(0, 500, 100))
cube2:SetPosition(Vector3.New(0, 200, 0))
-- Cube 1 has been placed in the world, and cube2 has been placed, relative to cube1.

print("cube2 relative position: " .. tostring(cube2:GetPosition()))      -- X=0.000 Y=200.000 Z=0.000
print("cube2 world position:    " .. tostring(cube2:GetWorldPosition())) -- X=0.000 Y=700.000 Z=100.000

cube1:SetWorldRotation(cube1:GetWorldRotation() + Rotation.New(0, 0, 90))
cube2:SetRotation(cube2:GetRotation() + Rotation.New(0, 0, 90))
-- Both cubes have been rotated by 90 degrees, but cube2 gets the combined rotation
-- because it is the child of cube1.

print("cube2 relative rotation: " .. tostring(cube2:GetRotation()))      -- X=0.000 Y=0.000 Z=90.000
print("cube2 world rotation:    " .. tostring(cube2:GetWorldRotation())) -- X=0.000 Y=0.000 Z=180.000

cube1:SetWorldScale(cube1:GetWorldScale() * 2)
cube2:SetScale(cube2:GetScale() * 2)
-- Both cubes have been doubled in size. But again, the child cube (cube2) also takes the scale
-- of the parent. (cube1)
print("cube2 relative scale:    " .. tostring(cube2:GetScale()))      -- X=2.000 Y=2.000 Z=2.000
print("cube2 world scale:       " .. tostring(cube2:GetWorldScale())) -- X=4.000 Y=4.000 Z=4.000

-- It's also possible to read and write the entire transform at once!
local cube3 = World.SpawnAsset(propCubeTemplate)
local cube4 = World.SpawnAsset(propCubeTemplate)
cube4.parent = cube1

cube3:SetWorldTransform(cube1:GetWorldTransform())
cube4:SetTransform(cube2:GetTransform())

-- Cube1 and cube3 now have the same transforms, and cube2 and cube4 also match.
```

See also: [CoreObject.GetCustomProperty](coreobject.md) | [World.SpawnAsset](world.md) | [Vector3.New](vector3.md) | [Rotation.New](rotation.md) | [CoreLua.print](coreluafunctions.md)

---

Using:

- `GetVelocity`
- `SetVelocity`
- `GetAngularVelocity`
- `SetAngularVelocity`
- `SetLocalAngularVelocity`

Some core objects are handled by the physics system. Anything that is marked as "debris physics" is such an object, as well as some special objects in the catalog, such as "Physics Sphere".

For objects like this, you can set their velocity and angular velocity directly.

```lua
local propPhysicsSphere = script:GetCustomProperty("PhysicsSphere")
local sphere = World.SpawnAsset(propPhysicsSphere, {position = Vector3.New(500, -200, 300)})

sphere:SetVelocity(Vector3.UP * 1000)
sphere:SetAngularVelocity(Vector3.UP * 1000)

Task.Wait(2)
-- Cut the velocity (and angular velocity) down to 25%
sphere:SetVelocity(sphere:GetVelocity() * 0.25)
sphere:SetAngularVelocity(sphere:GetAngularVelocity() * 0.25)

-- You can also set the angular velocity in local space, relative to the angular
-- velocity of its parent, if any:
sphere:SetLocalAngularVelocity(sphere:GetAngularVelocity() * 0.25)
```

See also: [CoreObject.GetCustomProperty](coreobject.md) | [World.SpawnAsset](world.md) | [Vector3.New](vector3.md) | [Task.Wait](task.md)

---

Using:

- `MoveTo`
- `RotateTo`
- `ScaleTo`
- `MoveContinuous`
- `RotateContinuous`
- `ScaleContinuous`
- `StopMove`
- `StopRotate`
- `StopScale`

There are quite a few functions that make it easy to animate `CoreObject`s in your game. Since most things are `CoreObject`s, this gives you a lot of flexibility in creating animations for a wide variety of objects!

`MoveTo()`, `RotateTo()` and `ScaleTo()` are the most basic, and they allow you to change a `CoreObject`'s position, rotation, or scale over time. The base version of these functions just takes a destination position/scale/rotation, and how much time it should take to get there.

There are also continuous versions of these functions, that cause a `CoreObject` to continuously change position/scale/rotation forever, or until told to stop.

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")
local movingCube = World.SpawnAsset(propCubeTemplate, {position = Vector3.New(500, -200, 100)})
local spinningCube = World.SpawnAsset(propCubeTemplate, {position = Vector3.New(500, 0, 100)})
local shrinkingCube = World.SpawnAsset(propCubeTemplate, {position = Vector3.New(500, 200, 100)})

local transitionTime = 5

-- These functions will make cubes rise, spin, and shrink, over the next 5 seconds.
movingCube:MoveTo(movingCube:GetWorldPosition() + Vector3.UP * 1000, transitionTime)
spinningCube:RotateTo(Rotation.New(0, 0, 179), transitionTime)
shrinkingCube:ScaleTo(Vector3.ZERO, transitionTime)

Task.Wait(transitionTime)

-- These functions will make the cubes fall, spin, and grow indefinitely, until stopped.
movingCube:MoveContinuous(Vector3.UP * -100)
spinningCube:RotateContinuous(Rotation.New(0, 0, 20))
shrinkingCube:ScaleContinuous(Vector3.New(0.2, 0.2, 0.2))

-- And here, 2 seconds later, we stop them!
Task.Wait(2)
movingCube:StopMove()
spinningCube:StopRotate()
shrinkingCube:StopScale()
```

See also: [CoreObject.GetCustomProperty](coreobject.md) | [World.SpawnAsset](world.md) | [Vector3.New](vector3.md) | [Rotation.New](rotation.md) | [Task.Wait](task.md)

---

Using:

- `SetNetworkedCustomProperty`
- `networkedPropertyChangedEvent`
- `GetReference`

Networked custom properties are a special kind of custom property that can be used to communicate with client contexts. (They're actually one of the few ways that the server can send data that a client context can respond to!)

To create a networked custom property, right click a custom property in the Core editor, and select "Enable Property Networking."

Once a custom property has been set to be networked, the server can change its value at runtime via `SetNetworkedCustomProperty()`, and the client can listen for changes to that property via `networkedPropertyChangedEvent`.

In this sample, it is assumed that the script has a custom networked property.

In a client context, we can set up listeners to tell us when a custom property changes, and what its current value is:

```lua
-- Client context:
script.networkedPropertyChangedEvent:Connect(function(coreObject, propertyName)
    print("The networked property [" .. coreObject.name .. "] just had its ["
            .. propertyName .. "] property changed.")

    local newValue = script:GetCustomProperty(propertyName)
    print("New value: " .. tostring(newValue))
end)

--[[#description
    Now, if the server changes the custom property, the client is notified:
]]

-- Server context:
script:SetNetworkedCustomProperty("NetworkedGreeting", "Buenos Dias")

-- The client should print out:
-- The networked property [test_CoreObject] just had its [NetworkedGreeting] property changed.
-- New value: Buenos Dias

--[[#description
    In addition to basic types (strings, integers, colors, etc) you can also pass
    references to core objects via networked custom properties. This is really useful
    if you want to have a client-side script know about a particular networked object.

    To do this, you need to first convert the `CoreObject` into a `CoreObjectReference`.
]]
-- Server context:
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")
local cube = World.SpawnAsset(propCubeTemplate)
script:SetNetworkedCustomProperty("NetworkedCoreObjectReference", cube:GetReference())

```

See also: [CoreObject.GetCustomProperty](coreobject.md) | [World.SpawnAsset](world.md) | [Event.Connect](event.md) | [CoreLua.print](coreluafunctions.md)

---

Using:

- `name`
- `id`
- `sourceTemplateId`
- `isStatic`
- `isClientOnly`
- `isServerOnly`
- `isNetworked`

You can find out a lot about an object via its CoreProperties.

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")

local template = World.SpawnAsset(propCubeTemplate)

-- The name of the object is its name in the hierarchy, or the name of the
-- template it was spawned from.
print("Name: " .. template.name)
-- The ID of the object is its core object reference. (A MUID)
print("Id: " .. template.id)
-- The source template id is the MUID of template it was spawned from.
-- (Or nil if it was just placed in the hierarchy at edit-time.)
print("sourceTemplateId: " .. template.sourceTemplateId)

-- You can also tell if an object is networked, and if it is in a static, client, or server context:
if template.isNetworked then
    print("It is networked!")
else
    print("It is not networked!")
end
if template.isClientOnly then print("It is Client only!") end
if template.isServerOnly then print("It is Server only!") end
if template.isStatic then print("It is Static") end

-- Output:
--    Name: GoldCube
--    Id: E355483D7F78F3B1:GoldCube
--    sourceTemplateId: AF4DDC200B982801
--    It is networked!
```

See also: [CoreObject.GetCustomProperty](coreobject.md) | [CoreObjectReference.WaitForObject](coreobjectreference.md) | [World.SpawnAsset](world.md) | [CoreLua.print](coreluafunctions.md)

---

Using:

- `visibility`
- `collision`
- `isEnabled`
- `IsVisibleInHierarchy`
- `IsCollidableInHierarchy`
- `IsEnabledInHierarchy`

You can make objects appear and disappear in the world in several different ways.

By changing their `visibility` property, you can make them appear or disappear, but they will otherwise still exist. (Players can collide with them, etc.)

By changing their `collision` property, you can make the object something that players (and other objects) can no longer collide with. The object will still be visible though.

You can also completely disable an object, via the `isEnabled` property. Objects with `isEnabled` set to `false` cannot be seen or collided with, nor can any of their children.

Both collision and visibility have three possible values:  `FORCE_ON`, `FORCE_OFF` and `INHERIT`. By default, things are set to `INHERIT`, which means they will have whatever visibility or collision settings their parent object has. This makes it convenient to hide or remove collision from a whole group of things, by simply changing the settings of the root object.

`FORCE_ON` and `FORCE_OFF` override this, and force the object to be collidable or visible (or not) regardless of the state of their parents.

It is sometimes useful to know if an object is currently visible/collidable/enabled. Because this may depend on the state of its parents, there are several convenience functions that allow you to check, without having to climb the hierarchy yourself.

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")
local cube1 = World.SpawnAsset(propCubeTemplate)
local cube2 = World.SpawnAsset(propCubeTemplate)
cube2.parent = cube1

-- Cube2 is now the child of cube1.
-- By default they both off with Visibility.INHERIT and Collision.INHERIT
print("default state:")
print("cube2 visible?    " .. tostring(cube2:IsVisibleInHierarchy()))
print("cube2 collidable? " .. tostring(cube2:IsCollidableInHierarchy()))
print("cube2 enabled?    " .. tostring(cube2:IsEnabledInHierarchy()))
-- These should all be true when we start.

-- If we set cube1 to be disabled, then cube2 is no longer visible or collidable:
cube1.isEnabled = false
print("parent disabled:")
print("cube2 visible?    " .. tostring(cube2:IsVisibleInHierarchy()))
print("cube2 collidable? " .. tostring(cube2:IsCollidableInHierarchy()))
print("cube2 enabled?    " .. tostring(cube2:IsEnabledInHierarchy()))

-- Note that isEnabled overrides visibility/collision settings. So even
-- if we set cube2 to force its visibility and collision on, they are
-- still overridden as long as its parent is disabled:
print("parent disabled, but forcing things on:")
cube2.visibility = Visibility.FORCE_ON
cube2.collision = Collision.FORCE_ON
print("cube2 visible?    " .. tostring(cube2:IsVisibleInHierarchy()))
print("cube2 collidable? " .. tostring(cube2:IsCollidableInHierarchy()))
-- These are both false because the parent is still disabled.

-- On the other hand, if we set cube1 to enabled, but FORCE_OFF for
-- collision and visibility, cube2 is now visible and collidable, because
-- it is still FORCE_ON for both values, meaning it ignores its parent.
cube1.visibility = Visibility.FORCE_OFF
cube1.collision = Collision.FORCE_OFF
cube1.isEnabled = true
print("cube2 visible?    " .. tostring(cube2:IsVisibleInHierarchy()))
print("cube2 collidable? " .. tostring(cube2:IsCollidableInHierarchy()))
-- These are both true now because the parent is no longer disabled.
```

See also: [CoreObject.GetCustomProperty](coreobject.md) | [World.SpawnAsset](world.md) | [CoreLua.print](coreluafunctions.md)

---
