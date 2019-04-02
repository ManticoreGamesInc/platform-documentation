# Core Lua Style Guide

**Goal:** Unify Lua conventions for a consistent style

## File Structure

> Note: Implementation specifics are tbd, this just notes the need for imports at the top of the file

* Start with any `require` calls, such as:

```lua
local myImport = require("assetID")
myImport.foo()
```

Current syntax:

```lua
local myImport = game:find_object_by_id("assetID").context
myImport.foo()
```

## Naming

* Spell out words fully! Abbreviations generally make code easier to write, but harder to read.
* Use `PascalCase` names for class and enum-like objects.
  * e.g. `Color`, `MyClass`
* Use `camelCase` names for local variables, member values, and functions.
  * e.g. `myClassInstance`, `myFunction`, `myParameter`
* Use `LOUD_SNAKE_CASE` names for local consants.
* Prefix private members with an underscore, like `_camelCase`.
  * Lua does not have visibility rules, but using a character like an underscore helps make private access stand out.

## Dot vs Colon

The colon is only used for methods (member functions, for those of you with a C++ background). Everything else is a dot.

For more details, here is how it breaks down:

* Static (**dot**)
  * Functions
    * Constructor
  * Constants
* Instance
  * Methods (**colon**)
    * Events
  * Properties (**dot**)

For examples:

```lua
Color.random() --static function
Color.new() --constructor
Color.red --constant
myColor:desaturate() --method
myColor.r --property
```

```lua
--Static function (or constructor) --> dot
local randomColor = Color.random()
local cyan = Color.new(0, 1, 1)

--Constant --> dot
local red = Color.red

--Instance method (or event) --> colon
local myColorInstance = Color.random()
myColorInstance:desaturate(0.5)

--Instance property --> dot
local redValue = myColorInstance.r
```

When making your own methods:

Good:
```lua
--Called as myClassInstance:speak(extra)
function MyClass:speak(extra)
    return self.speech .. extra
end
```


Bad:
```lua
--Called as MyClass.speak(myClassInstance, extra)
function MyClass.speak(self, extra)
    return self.speech .. extra
end
```

Both are perfectly valid, but following convention allows for the usage call to consistently use colons for clarity.

* Where possible, use getters and setters
  * Unless otherwise noted, mutating return types will affect the game object (pass by reference)

## General

* Use tabs
* No whitespace at end of lines
* No vertical alignment

## Styling

* Use one statement per line (stay away from massive one-liners). Prefer to put function bodies on new lines.

```lua
--Good
table.sort(stuff, function(a, b)
    local sum = a + b
    return math.abs(sum) > 3
end)

--Bad
table.sort(stuff, function(a, b) local sum = a + b return math.abs(sum) > 3 end)
```

* Put a space before and after operators, except when clarifying precedence.

```lua
--Good
print(5 + 5 * 6^2)

--Bad
print(5+5* 6 ^2)
```

* Put a space after each comma in tables and function calls.

```lua
--Good
local familyNames = {"bill", "amy", "joel"}

--Bad
local familyNames = {"bill","amy" ,"joel"}
```

* When creating blocks, inline any opening syntax elements.

Good:

```lua
local foo = {
    bar = 2,
}

if foo then
    -- do something
end
```

Bad:

```lua
local foo =
{
    bar = 2,
}

if foo
then
    -- do something
end
```

* Don't put parenthesis around conditionals; they aren't necessary in Lua.

* Use double quotes for string literals (e.g. `local myMessage = "Here's a message"`)

## Comments

Use block comments for documenting larger elements:

* Use a block comment at the top of files to describe their purpose.
* Use a block comment before functions or objects to describe their intent.

```lua
--[[
    Pauses time so our protagonist has ample opportunity to train.

    Should only be used when there is a legitimate need to save the world,
    or the effectiveness will degenerate.
]]
local function saveTheWorld()
    ...
end
```

Use single line comments for inline notes.

Comments should generally focus on _why_ code is written a certain way instead of _what_ the code is doing.

* Obviously there are exceptions to this rule, the more obfuscated your execution the more true this is.

Good:

```lua
-- Without this condition, the player's state would mismatch
if playerIsAirborne() then
    enableFlying()
end
```

Bad:

```lua
-- Check if the player is in the air
if playerIsAirborne() then
    -- Set them to flying
    enableFlying()
end
```

----

* Note: Some content here is inspired from Roblox's Style Guide - all credit where it is due.