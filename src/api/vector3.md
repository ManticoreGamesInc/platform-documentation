---
id: vector3
name: Vector3
title: Vector3
tags:
    - API
---

# API: Vector3

## Description

A three-component vector that can represent a position or direction.

## API

### Constructors

| Constructor Name | Return Type | Description | Tags |
| ----------- | ----------- | ----------- | ---- |
| `Vector3.New([Number x, Number y, Number z])` | `Vector3` | Constructs a Vector3 with the given `x`, `y`, `z` values, defaults to (0, 0, 0). | None |
| `Vector3.New(Number v)` | `Vector3` | Constructs a Vector3 with `x`, `y`, `z` values all set to the given value. | None |
| `Vector3.New(Vector2 xy, Number z)` | `Vector3` | Constructs a Vector3 with `x`, `y` values from the given Vector2 and the given `z` value. | None |
| `Vector3.New(Vector3 v)` | `Vector3` | Constructs a Vector3 with `x`, `y`, `z` values from the given Vector3. | None |
| `Vector3.New(Vector4 v)` | `Vector3` | Constructs a Vector3 with `x`, `y`, `z` values from the given Vector4. | None |

### Constants

| Constant Name | Return Type | Description | Tags |
| ----------- | ----------- | ----------- | ---- |
| `Vector3.ZERO` | `Vector3` | (0, 0, 0) | None |
| `Vector3.ONE` | `Vector3` | (1, 1, 1) | None |
| `Vector3.FORWARD` | `Vector3` | (1, 0, 0) | None |
| `Vector3.UP` | `Vector3` | (0, 0, 1) | None |
| `Vector3.RIGHT` | `Vector3` | (0, 1, 0) | None |

### Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `x` | `Number` | The `x` component of the Vector3. | Read-Write |
| `y` | `Number` | The `y` component of the Vector3. | Read-Write |
| `z` | `Number` | The `z` component of the Vector3. | Read-Write |
| `size` | `Number` | The magnitude of the Vector3. | Read-Only |
| `sizeSquared` | `Number` | The squared magnitude of the Vector3. | Read-Only |

### Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetNormalized()` | `Vector3` | Returns a new Vector3 with size 1, but still pointing in the same direction. Returns (0, 0, 0) if the vector is too small to be normalized. | None |

### Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `Vector3.Lerp(Vector3 from, Vector3 to, Number progress)` | `Vector3` | Linearly interpolates between two vectors by the specified progress amount and returns the resultant Vector3. | None |

### Operators

| Operator Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Vector3 + Vector3` | `Vector3` | Component-wise addition. | None |
| `Vector3 + Number` | `Vector3` | Adds the right-side Number to each of the components in the left side and returns the resulting Vector3. | None |
| `Vector3 - Vector3` | `Vector3` | Component-wise subtraction. | None |
| `Vector3 - Number` | `Vector3` | Subtracts the right-side Number from each of the components in the left side and returns the resulting Vector3. | None |
| `Vector3 * Vector3` | `Vector3` | Component-wise multiplication. | None |
| `Vector3 * Number` | `Vector3` | Multiplies each component of the Vector3 by the right-side Number. | None |
| `Number * Vector3` | `Vector3` | Multiplies each component of the Vector3 by the left-side Number. | None |
| `Vector3 / Vector3` | `Vector3` | Component-wise division. | None |
| `Vector3 / Number` | `Vector3` | Divides each component of the Vector3 by the right-side Number. | None |
| `-Vector3` | `Vector3` | Returns the negation of the Vector3. | None |
| `Vector3 .. Vector3` | `Number` | Returns the dot product of the Vector3s. | None |
| `Vector3 ^ Vector3` | `Vector3` | Returns the cross product of the Vector3s. | None |

## Examples

- `Lerp`

Vector3.Lerp is a function for finding a spot part way between two vectors. When combined with a tick function or loop, we can use it to smoothly animate something moving between two points.

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")
local myObject = World.SpawnAsset(propCubeTemplate)

local startPosition = Vector3.New(500, -500, 500)
local endPosition = Vector3.New(500, 500, 500)

myObject:SetWorldPosition(startPosition)

-- Note: You generally would not want to call SetWorldPosition except in a client context. (Otherwise,
-- it would "jitter" due to network lag.)  If you want to do this kind of effect for objects on the server,
-- consider using CoreObject:MoveTo() and similar functions!
for i = 1, 30 do
    myObject:SetWorldPosition(Vector3.Lerp(startPosition, endPosition, i/300))
    Task.Wait()
end

print("Tah dah!")
```

---

- `New`

There are several different ways to create Vector3s. You can directly specify the x, y, z coordinates, or you can feed it a Vector2 or Vector4 to pull coordinates from, or you can just give it a single number to apply to x y and z.

```lua
-- Makes a vector3 where x=1, y=2, z=3:
local myVector3_0 = Vector3.New(1, 2, 3)

-- Another way of making a vector3 where x=1, y=2, z=3:
local myVec2 = Vector2.New(1, 2)
local myVector3_1 = Vector3.New(myVec2, 3)

-- Yet another way of making a vector3 where x=1, y=2, z=3:
local myVec4 = Vector4.New(1, 2, 3, 4)
local myVector3_2 = Vector3.New(myVec4)

-- Makes a vector3 where x=6, y=6, z=6:
local myVector3_3 = Vector3.New(6)

-- We can also make new Vector3s based on existing ones:
local copyOfVector3_3 = Vector3.New(myVector3_3)
```

---

- `ZERO`

- `ONE`

- `FORWARD`

- `UP`

- `RIGHT`

The Vector3 namespace includes a small selection of constants, for commonly-used Vector3 values.

```lua
print(Vector3.ZERO)    -- (0, 0, 0)

print(Vector3.ONE)    -- (1, 1, 1)

print(Vector3.FORWARD)    -- (1, 0, 0)

print(Vector3.RIGHT)    -- (0, 1, 0)

print(Vector3.UP)    -- (0, 0, 1)
```

---

- `Vector3+Vector3`

- `Vector3+Number`

- `Vector3-Vector3`

- `Vector3-Number`

- `Vector3*Vector3`

- `Vector3*Number`

- `Number*Vector3`

- `Vector3/Vector3`

- `Vector3/Number`

- `-Vector3`

Most arithmetic operators will work on Vector3s in straightforward ways.

```lua
local a = Vector3.New(1, 2, 3)
local b = Vector3.New(4, 5, 6)

-- Adding and subtracting vectors is the same as adding or subtracting each of their components.
print(a + b) -- (5, 7, 9)
print(b - a) -- (3, 3, 3)

-- You can also add or subtract a number and a vector - it will just add or subtract that
-- number from each component.
print(a + 2) -- 3, 4, 5

print(b - 2) -- 2, 3, 4

-- Multiplication and Division work the same way:
print (a * b) -- 4, 10, 18
print (a * 2) -- 2, 4, 6
print (2 * a) -- 2, 4, 6

print(a / b) -- (0.25, 0.4, 0.3)
print(b / 4) -- (1, 1.25, 1.5)

-- You can also just negate a vector:

print(-a) -- -1, -2, -3
```

---

- `GetNormalized()`

- `Vector3`

- `Vector3^Vector3`

A normalized vector is a vector who's magnitude (size) is equal to 1. Vector3 variables have a `GetNormalized()` function, which returns this value. Its equivalent to dividing the vector by its own size, and is useful in linear algebra.

Dot Product and Cross Product are two other common linear algebra operations, which can be represented in Lua byh the `..` and `^` operators respectively.

Here is a sample that uses these operations to determine if an object is aimed within 15 degrees of a player.

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")
local myObject = World.SpawnAsset(propCubeTemplate, {
        position = Vector3.New(500, 0, 250)
    })

myObject:RotateContinuous(Rotation.New(0, 0, 40))

for i = 1, 10, 0.05 do
    local playerPos = player:GetWorldPosition()
    local objectPos = myObject:GetWorldPosition()
    local objectAim = myObject:GetWorldTransform():GetForwardVector()
    local objToPlayer = (playerPos - objectPos):GetNormalized()

    -- draw a line so we can see where it is "looking"
    CoreDebug.DrawLine(objectPos, objectPos + objectAim * 1000,
        {
            duration = 0.05,
            thickness = 5,
            color = Color.RED
        })

    -- Is the object facing the player?  (And not 180 degrees the opposite direction?)
    -- When the vectors are normalized, (which these are), the dot product is equal to
    -- the cosine of the angle between the vectors. Which means it will be positive,
    -- if the two vectors aren't more than 90 degrees apart. This makes it a great way to check
    -- if something is "generally facing" something else!
    if (objToPlayer .. objectAim > 0) then
        -- Here we check if the player is actually within 15 degrees of the aim.
        -- we can do this, because if the input vectors are normalized (which again, these are),
        -- then the output vector has a magnitude equal to the sin of the angle between them.
        -- So this makes it a really easy way to check if a vector is within a certain angle
        -- of another vector. (Especially if we combine it with the previous check to make sure
        -- they're facing the same direction!)
        if (objToPlayer ^ objectAim).size < math.sin(15) then
            print("I see you!")
        end
    end
    Task.Wait(0.05)
end
```

---

- `size`

- `sizeSquared`

A lot of vector math requires knowing the magnitude of a vector - i. e. if you think of the vector as a point, how far away is it from (0, 0, 0)?

In Lua, you can get that value via the `size` property. There is also the `sizeSquared` property, which is sometimes useful as a CPU optimization. Typically `sizeSquared` is used instead of `size` in distance comparisons, because if `a.size < b.size`, then `a.sizeSquared < b.sizeSquared`.

This sample creates a healing aura around an object, that heals the player more, the closer they are to it.

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")
local healNode = World.SpawnAsset(propCubeTemplate, {
            position = Vector3.New(500, 0, 0)
        })

local healRadius = 1000

-- The heal node will pulse 50 times, 5 times per second:
for i = 1, 50 do
    for k, player in pairs(Game.GetPlayers()) do
        local p = player:GetWorldPosition()
        local n = healNode:GetWorldPosition()
        local distanceSquared = (p - n).sizeSquared
        if distanceSquared < healRadius * healRadius then
            local distance = (p - n).size
            -- Apply a negative damage to heal the player:
            local healAmount = 5 * (1 - distance / healRadius)
            player:ApplyDamage(Damage.New(-healAmount))
            print("Player is being healed for " .. tostring(healAmount))

        end
    end
    Task.Wait(0.2)
end
```

---

- `x`

- `y`

- `z`

After creating a `Vector3`, we can read or write to its x, y, z components directly.

```lua
local myVector3 = Vector3.New(1, 2, 3)

print(myVector3.x) -- 1
print(myVector3.y) -- 2
print(myVector3.z) -- 3

-- We can also modify them directly, to create a new vector:
myVector3.x = 4
myVector3.y = 5
myVector3.z = 6

print(myVector3)
-- myVector3 now equals (4, 5, 6)
```

---
