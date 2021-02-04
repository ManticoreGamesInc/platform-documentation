---
id: coreluafunctions
name: CoreLuaFunctions
title: CoreLuaFunctions
tags:
    - API
---

# API: CoreLuaFunctions

## Description

A few base functions provided by the platform.

## API

### Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Tick(Number deltaTime)` | `Number` | Tick event, used for things you need to check continuously (e.g. main game loop), but be careful of putting too much logic here or you will cause performance issues. DeltaTime is the time difference (in seconds) between this and the last tick. | None |
| `time()` | `Number` | Returns the time in seconds (floating point) since the game started on the server. | None |
| `print(string)` | `string` | Print a message to the event log. Access the Event Log from the **Window** menu. | None |
| `warn(string)` | `string` | Similar to `print()`, but includes the script name and line number. | None |
| `require(string)` | `table` | `require()` in Core differs slightly from vanilla Lua; Instead of giving it a script or file name, you give it a script ID. The script ID is usually assigned as a custom property (of type Asset Reference) that points to the script you want to `require()`. | None |

## Examples

- `print`

- `warn`

The common Lua `print()` statement puts text into the Event Log. It can be used from anywhere, and is often extremely useful for debugging.

There is a similar function, `warn()`, which functions also prints to the event log, except as a warning message. (So it's bright and yellow and hard to miss.)

```lua
-- This will be printed to the event log normally.
print("Hello world!")

-- This will be printed in scary yellow letters, as a warning!
warn("Something is amiss!")
```

---

- `time`

- `Tick`

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

---
