---
id: coreluafunctions
name: CoreLuaFunctions
title: CoreLuaFunctions
tags:
    - API
---

# CoreLuaFunctions

A few base functions provided by the platform.

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Tick(number deltaTime)` | `number` | Tick event, used for things you need to check continuously (for example main game loop), but be careful of putting too much logic here or you will cause performance issues. DeltaTime is the time difference (in seconds) between this and the last tick. | None |
| `time()` | `number` | Returns the time in seconds (floating point) since the game started on the server. | None |
| `print(string)` | `string` | Print a message to the event log. Access the Event Log from the **Window** menu. | None |
| `warn(string)` | `string` | Similar to `print()`, but includes the script name and line number. | None |
| `require(string)` | `table` | `require()` in Core differs slightly from vanilla Lua; Instead of giving it a script or file name, you give it a script ID. The script ID is usually assigned as a custom property (of type Asset Reference) that points to the script you want to `require()`. | None |

## Examples

Example using:

### `Tick`

### `time`

Functions named `Tick()` are special - if you have a script with a `Tick()` function, then that function will be called every frame of the game. This is not something you want to do often, because of performance costs, but can be used to set up animations. (Ideally inside of client contexts.)

The `time()` function is very useful for this sort of thing - it will return the number of seconds since the map started running on the server, which makes it very useful in creating animations based on time.

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")
local startTime = time()
local fadeDuration = 1.0
local currentColor = Color.RED
local nextColor = Color.BLUE
local cube = World.SpawnAsset(propCubeTemplate, {position = Vector3.FORWARD * 200})

function Tick()
    local currentTime = time()
    if currentTime > startTime + fadeDuration then
        startTime = currentTime
        local temp = currentColor
        currentColor = nextColor
        nextColor = temp
    end

    local progress = (currentTime - startTime) / fadeDuration
    cube:SetColor(Color.Lerp(currentColor, nextColor, progress))
end
```

See also: [CoreObject.GetCustomProperty](coreobject.md) | [Color.RED](color.md) | [World.SpawnAsset](world.md) | [Vector3.FORWARD](vector3.md) | [CoreMesh.SetColor](coremesh.md)

---

Example using:

### `print`

### `warn`

The common Lua `print()` statement puts text into the Event Log. It can be used from anywhere, and is often extremely useful for debugging.

There is a similar function, `warn()`, which functions also prints to the event log, except as a warning message. (So it's bright and yellow and hard to miss.)

```lua
-- This will be printed to the event log normally.
print("Hello world!")

-- This will be printed in scary yellow letters, as a warning!
warn("Something is amiss!")
```

---

Example using:

### `require`

Using `require()` is a powerful way to abstract code and break it apart into separate responsibilities, as well as reusable components. In this example we have two scripts. The first script is in the hierarchy and calls `require()` on the second script. To link the two scripts together, select the first script in the hierarchy and drag the second script from Project Content into the Properties view. This action creates a custom property that points to the script asset.

```lua
-- Contents of the script in the hierarchy:
local REQUIRED_SCRIPT = require( script:GetCustomProperty("SecondScript") )

REQUIRED_SCRIPT.DoSomething()

-- The second script returns a table, containing the DoSomething() function:
local API = {}

function API.DoSomething()
    print("Hello world!")
end

return API
```

See also: [CoreObject.GetCustomProperty](coreobject.md)

---
