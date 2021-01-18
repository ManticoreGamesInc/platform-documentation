---
id: lua_styleguide
name: Lua Style Guide
title: Lua Style Guide
tags:
    - Tutorial
---

## Overview

This document aims to provide a general overview of what we at Manticore see as sensible defaults for writing code in Lua.

## File Structure

- Start with any `require` calls, such as:

```lua
local myImport = require("assetID")

myImport.Foo()
```

Current syntax:

```lua
local myImport = World.FindObjectByID("assetID")

myImport.Foo()
```

## General

- No whitespace at end of lines
- No vertical alignment
- Spell out words fully! Abbreviations generally make code easier to write, but harder to read.

### Casing

| Element    | Styling         |
| ---------- | --------------- |
| Classes    | PascalCase      |
| Functions  | PascalCase      |
| Enums      | PascalCase      |
| Properties | camelCase       |
| Variables  | camelCase       |
| Constants  | LOUD_SNAKE_CASE |

#### Casing Calls

| Example                   | Casing                        | Dot or Colon |
| ------------------------- | ----------------------------- | ------------ |
| Enum.ENUM_ENTRY           | PascalCase -> LOUD_SNAKE_CASE | Dot          |
| Class.StaticFunction()    | PascalCase -> PascalCase      | Dot          |
| instance.property         | camelCase -> camelCase        | Dot          |
| instance:MemberFunction() | camelCase -> PascalCase       | Colon        |

### Examples

Generic Example:

```lua
--[[
    Files start with a descriptive multi-line comment
]]--

-- Imports go next
local DogClass = require('DogClass')

-- Functions are PascalCase
local function GiveDog(player)
    -- Local variables use camelCase, classes use PascalCase
    local doggo = DogClass.New()

    -- Properties are camelCase, constants are UPPER_CASE
    doggo.color = Colors.BROWN

    -- Member functions are called with a ':' (while static functions, see above, are called with a '.')
    doggo:AttachToPlayer(player, PlayerSockets.RIGHT_ANKLE)
end

-- Event subscriptions are located at the end of the file
Game.playerJoinedEvent:Connect(GiveDog)
```

Real example:

```lua
--[[
    When a player collides with a coin, give them the coin as a resource and remove the coin from the world
]]

-- Handle picking up a coin
local function HandleOverlap(trigger, player)
    -- Check that the object colliding with the trigger is a player
    if player ~= nil and player:IsA("Player") then
        -- If so, increment the 'Manticoin' resource count for that player
        player:AddResource("Manticoin", 1)
        -- Destroy the object in the scene so nobody else can pick it up
        trigger.parent:Destroy()
    end
end

-- Whenever an object collides with the coin's trigger, run this function
trigger.beginOverlapEvent:Connect(HandleOverlap)
```

```lua
-- Spawn player 30 units higher than normal, and print out new position
local function HandlePlayerJoined(player)
    local x, y, z = player:GetPosition()

    player:SetPosition(Vector3.New(x, y + 30, z))
    UI.PrintToScreen("New Position: " .. x .. y .. z)
end

World.playerJoinedEvent:Connect(HandlePlayerJoined)
```

```lua
-- Handle picking up a coin
local function HandleOverlap(trigger, object)
    if object ~= nil and object:IsA("Player") then
        object:AddResource("Manticoin", 1)
        trigger.parent:Destroy()
    end
end

script.parent.beginOverlapEvent:Connect(HandleOverlap)
```

```lua
-- Cat helper script
local DEBUG_PRINT = false

local function IncreaseAge(currentAge)
    currentAge = currentAge + 1

    if DEBUG_PRINT then
        print("Current age updated to" .. currentAge)
    end

    return currentAge
end

local function Main()
    local cat = Cat.New()

    for i = 1, 30 do
        local furColors = cat:GetColors()
        -- Note: table.contains is native Lua so it doesn't follow Core's conventions
        if table.contains(furColors, "grey") then
            currentAge = IncreaseAge(cat.age)
        end

        if DEBUG_PRINT then
            local meowText = cat:Meow()
            print(meowText)
        end
    end
end
```

## Dot vs Colon

The colon is only used for methods that pass `self` as the first parameter, everything else is a dot.

This means that `x:Bar(1, 2)` is the same as `x.Bar(x, 1, 2)`

For more details, here is how it breaks down:

- Static (**dot**)
    - Functions
    - Constructor
    - Constants
- Instance
    - Methods (**colon**)
    - Properties (**dot**)
    - Events

For example:

```lua
Color.New() -- static functions + constructors
Colors.RED -- constants
player.name -- properties
player:ApplyDamage() -- member functions
```

```lua
-- Casing + operations

uppercase -> Enum.ENUM_ENTRY
          -> Class.StaticFunction()
lowercase -> instance:MemberFunction()
          -> instance.property

-- You should be able to determine the type of operation by the casing alone

-- PascalCase|PascalCase
Class.StaticFunction()

-- camelCase|camelCase
instance.property

-- camelCase|PascalCase
instance:Method()
```

When making your own methods:

```lua
-- Good

-- Called as myClassInstance:Speak(extra)
local function MyClass:Speak(extra)
    return self.speech .. extra
end

-- Bad

-- Called as MyClass.Speak(myClassInstance, extra)
local function MyClass.Speak(self, extra)
    return self.speech .. extra
end
```

Both are perfectly valid, but following convention allows for the usage call to consistently use colons for clarity.

- Where possible, use getters and setters
    - Unless otherwise noted, mutating return types will affect the game object (pass by reference)
    - Properties use getter/setter methods unless you can both get _and_ set the value in which case you can directly access them.

## Styling

- Use one statement per line, stay away from massive one-liners.
- Prefer to put function bodies on new lines.

```lua
-- Good
table.sort(stuff, function(a, b)
    local sum = a + b

    return math.abs(sum) > 3
end)

-- Bad
table.sort(stuff, function(a, b) local sum = a + b return math.abs(sum) > 3 end)
```

- Put a space before and after operators, except when clarifying precedence.

```lua
-- Good
print(5 + 5 * 6^2)

-- Bad
print(5+5* 6 ^2)
```

- Put a space after each comma in tables and function calls.

```lua
-- Good
local familyNames = {"bill", "amy", "joel"}

-- Bad
local familyNames = {"bill","amy" ,"joel"}
```

- When creating blocks, inline any opening syntax elements.

```lua
-- Good
local foo = {
    bar = 2,
}

if foo then
    -- do something
end

-- Bad
local foo =
{
    bar = 2,
}

if foo
then
    -- do something
end
```

- Only put parenthesis around complicated conditionals to keep your sanity, otherwise they aren't necessary in Lua.
- Use double quotes for string literals (e.g. `local myMessage = "Here's a message"`)

## Comments

Use block comments for documenting larger elements:

- Use a block comment at the top of files to describe their purpose.
- Use a block comment before functions or objects to describe their intent.

```lua
--[[
    Pauses time so our protagonist has ample opportunity to train.

    Should only be used when there is a legitimate need to save the world,
    or the effectiveness will degenerate.
]]
local function SaveTheWorld()
    ...
end
```

- Use single line comments for inline notes.
- Comments should generally focus on _why_ code is written a certain way instead of _what_ the code is doing.
- Obviously there are exceptions to this rule, the more obfuscated your execution the more true this is.

```lua
-- Good

-- Without this condition, the player's state would mismatch
if PlayerIsAirborne() then
    EnableFlying()
end

-- Bad

-- Check if the player is in the air
if PlayerIsAirborne() then
    -- Set them to flying
    EnableFlying()
end
```

- Each line of a block comment starts with `--` and a single space.
- Inline comments should be separated by at least two spaces from the statement. They should start with `--` and a single space.

```lua
-- One space for block/single-line comments
local myNum = 2  -- Two spaces after the code, then one space for inline comments
```

---

## Best Practices

In general, you should always try to use `local` functions and variables, the only exception should be when you overwrite global functions like `Tick()`.
Make sure to always declare your variables and functions in the order they are using in. Lua parses the file top to bottom, if you try to use a function before it has been declared, you will error.

### Miscellaneous

### \_G vs require

`require()` explicitly makes a script execute if it hasn't already, and only executes a given script once.

If you need multiple instances of the same script dynamically spawned, `require()` should not be used.

### Using External Data

You can use `require()` and a script that returns a long string to encapsulate JSON data in its own script.
Afterwards use `require()` again with a [JSON library](https://github.com/rxi/json.lua).
To make a script that returns a JSON string when you require it, start with
this:

```lua
return [===[
    -- JSON here, make sure it does not contain "]===]" though!
]===]
```
