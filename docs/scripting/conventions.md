# Core Lua Style Guide

Goal: Unify Lua conventions for a consistent style

## File Structure

* Start with any `require` calls, such as:

```lua
local myImport = require("assetID")
myImport.foo()
```

## Casing

## Naming
* Spell out words fully! Abbreviations generally make code easier to write, but harder to read.
* Use `PascalCase` names for class and enum-like objects.
  * e.g. `Color`, `MyClass`
* Use `camelCase` names for local variables, member values, and functions.
  * e.g. `myClassInstance`, `myFunction`, `myParameter`
* Use `LOUD_SNAKE_CASE` names for local consants.
* Prefix private members with an underscore, like `_camelCase`.
  * Lua does not have visibility rules, but using a character like an underscore helps make private access stand out.
* Where possible, use getters and setters
  * Unless otherwise noted, mutating return types will affect the game object (pass by reference)

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

## Archive - dot vs colon

Color.new() → constructor, dot, parenthesis
Color.red → constant, dot
{color}.r → property, dot
{color}:desaturate() → member functions, colon, parenthesis
Color.random() → static functions, dot, parenthesis
{ability}.on_cast → event, dot

ClassInstance [dot] -> properties, events
ClassInstance [colon] -> member functions
Note: Should move event to colon, as it’s closer to a function than property
Class [dot] -> constants, static functions (including constructor)

TL;DR: The only time there is a colon is with a method. Everything else is a dot.

### General

* Use tabs
* No whitespace at end of lines
* No vertical alignment


### Styling

Use one statement per line. Prefer to put function bodies on new lines.

Good:

```lua
table.sort(stuff, function(a, b)
    local sum = a + b
    return math.abs(sum) > 2
end)
```

Bad:

```lua
table.sort(stuff, function(a, b) local sum = a + b return math.abs(sum) > 2 end)
Put a space before and after operators, except when clarifying precedence.

Good:

```lua
print(5 + 5 * 6^2)
```

Bad:

```lua
print(5+5* 6 ^2)
```

Put a space after each commas in tables and function calls.

Good:

```lua
local friends = {"bob", "amy", "joe"}
foo(5, 6, 7)
```

Bad:

```lua
local friends = {"bob","amy" ,"joe"}
foo(5,6 ,7)
```

When creating blocks, inline any opening syntax elements.

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

Don't put parenthesis around conditionals; they aren't necessary in Lua.

Use double quotes for string literals (e.g. `local myMessage = "Here's a message"`)

### Tables

