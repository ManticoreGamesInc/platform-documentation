# Core Lua Style Guide

**Goal:** Unify Lua conventions for a consistent style

## File Structure

> Note: Implementation specifics are tbd, this just notes the desire for imports at the top of the file

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
* Use `PascalCase` names for classes, enum-like objects, and functions (both static and member) - `Enum.ENTRY`, `MyClass`, `MyFunction`
  * e.g. `Colors.RED`, `Dog = {}`, `function SaveTheWorld()` --Note: OO syntax TBD
* Use `camelCase` names for local variables and properties - `myClassInstance`, `myProperty`
  * e.g. `local furColor = panda.furColor`
* Prefix private fields with an underscore, like `_camelCase`.
  * Lua does not have visibility rules, but using a character like an underscore helps make private access stand out.
* Use `LOUD_SNAKE_CASE` names for constants (including enum entries)
* Make class names singular, unless it is a static (helper) class or enum
  * e.g. `Person`, `Cat` vs `StringUtils`, `DogBreeds`

Element | Styling
--- | ---
Classes | PascalCase
Functions | PascalCase
Enums | PascalCase
Properties | camelCase
Variables | camelCase
Constants | LOUD_SNAKE_CASE

Here is a tiny example with all the above:

```lua
-- Instantiate car object
local car = Car.New()
-- Set the car's color property
car.color = Colors.GREEN
-- Drive off into the sunset
car:Drive()
```

### Questions

* ToDo: Wrap everything, add it all to _G with namespace prefixes for everything but the most common functionality (e.g. print)
* ToDo: Write a linter to enforce all the conventions

* How to resolve Lua's conventions without wrapping everything (e.g. `table.contains`, `tostring()`)
  * Or should we wrap everything?
* Prefixing everything/namespaces for packaging for future compatibility as opposed to it all in the global namespace
  * `ToString(myObj)` vs vs `Utils.ToString(myObj)`
  * Can do capitals to differentiate (e.g. print vs Print)
* Changing all properties to getter/setter member functions would fix inconsistencies, but this has its own issues too

Here are some examples of code that conform to the above:

```lua
-- Spawn player 30 units higher than normal, and print out new position
function HandlePlayerJoined(player)
    player.position = Position.New(player.position.x, player.position.y + 30, player.position.z)
    Utils.Print("New Position: "player.position:toString())
end

game.onPlayerJoined:Connect(HandlePlayerJoined)
```

```lua
-- Handle picking up a coin
function HandleOverlap(trigger, object)
	if (object ~= nil and object:IsA("Player")) then
        object:AddResource("Manticoin", 1)
        trigger.parent:Destroy()
	end
end

script.parent.onBeginOverlap:Connect(HandleOverlap)
```

```lua
-- Cat helper script
local DEBUG_PRINT = false

local function IncreaseAge(currentAge)
    currentAge = currentAge + 1
    if DEBUG_PRINT then
        -- Note: `tostring` is native Lua so it doesn't follow Core's conventions
        print("Current age updated to" .. tostring(currentAge))
    end
    return currentAge
end

local function Main()
    local cat = Cat.New()

    for i = 1, 30 do
        local furColors = cat:GetColors()
        -- Note: table.contains is uncapitalized because Lua
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
--[[ GOOD ]]

--Called as myClassInstance:Speak(extra)
function MyClass:Speak(extra)
    return self.speech .. extra
end

--[[ BAD ]]

--Called as MyClass.Speak(myClassInstance, extra)
function MyClass.Speak(self, extra)
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

Each line of a block comment starts with `--` and a single space (unless it is indented text inside the comment).

Inline comments should be separated by at least two spaces from the statement. They should start with `--` and a single space.

```lua
-- One space for block/single-line comments
local myNum = 2  -- Two spaces after the code, then one space for inline comments
```

----

* Option: Use `PascalCase` for functions, or prefixes to clear ambiguity here (e.g. fMyFunction, pMyProperty)
    * Option2: Functions as PascalCase too?
    * Warframe's UI uses component based model using 'resource' system as needed to fake inheritence:
      * Functions as PascalCase, local variables as camelCase
      * All member variables are camelCase, but the first letter is always 'm' (mCamelCase)
      * All parameter variables are camelCase, but the first letter is always 'p'(pCamelCase)
      * Example: 
```lua
local BUTTON_RES = resource("/PathToScript/Button.lua")
local LIST_RES = resource("/PathToScript/List.lua")
local buttonList = LIST_RES.Create("List.Button", xOffset, yOffset) --element to duplicate, additive x and y offsets for each duplicated element
buttonList.OnElementAdded =
    function(pElement)
        --pElement is the element that was created (IE: a table)
        --pElement.mCompName is a unique duplicated element based on the original (IE: List.Button1, List.Button2, etc)
        pElement.mButton = BUTTON_RES.Create(pElement.mCompName, pElement.mLabel)
    end
for i = 1, 10 do
    buttonList.AddElement() --duplicate the element we passed in when creating the list, then call OnElementAdded
end
```

* Note: Some content here is inspired from Roblox's Style Guide - all credit where it is due.