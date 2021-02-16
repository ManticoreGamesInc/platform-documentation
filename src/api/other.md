---
id: other
name: Other
title: Other
tags:
    - API
---

# Other

Other

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `type` | `string` | All data structures and Objects share the common `type` property. | Read-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `IsA()` | `bool` | Expects a string parameter representing an object type. E.g. `myObject:IsA("Equipment")`. Returns `true` if the object is of the given type or one of its subtypes, returns `false` otherwise. | None |

## Examples

Using:

- `IsA`
- `type`
- `type(property)`

Sometimes you have a variable, but you don't know exactly what type it is. Fortunately, Lua offers several ways of checking the type at runtime, and Core expands those with a few more!

```lua
local number = 42
local text = "Example"
local cube = World.SpawnAsset(propCubeTemplate, {position = Vector3.New(1000, 0, 300) })
local player = Game.GetPlayers()[1]
local vector = Vector3.UP

-- Most types described in the Core API have a .type property, which
-- can be used to check their type. It returns a string of the typename.
print("the type of [cube] is " .. cube.type)     -- "StaticMesh"
print("the type of [player] is " .. player.type) -- "Player"
print("the type of [vector] is " .. vector.type) -- "Vector3"
-- (Note that base Lua types (string, number, etc) do NOT have this property!)

-- These types also support the :IsA() method - it accepts a typename (as a string)
-- and returns true if the object is that type.
-- This is sometimes more useful than checking the .type directly, because :IsA()
-- returns true for parent classes of the type as well as exact matches:

print(cube:IsA("StaticMesh")) -- true
print(cube:IsA("CoreMesh"))   -- also true
print(cube:IsA("CoreObject")) -- still true!

-- You can also, of course, use the standard lua type() function, but for
-- anything other than basic lua types, it will return a type of "userdata".
print(type(cube)) -- userdata
print(type(vector)) -- also userdata
print(type(player)) -- still userdata!

-- It is useful for base lua types though!
print(type(text)) -- string
print(type(number)) -- number
```

---
