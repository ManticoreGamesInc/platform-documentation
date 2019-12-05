---
name: Lua Reference
categories:
    - Reference
---

# Lua in CORE

!!! warning
    Flagged for Review.
    Incomplete or outdated information may be present.

## Overview

CORE uses **Lua**, a lightweight and flexible programming language to accomplish
scripting in the engine. It is a :fas fa-external-link-alt: [dynamically
typed](https://en.wikipedia.org/wiki/Type_system#Combining_static_and_dynamic_type_checking)
language, has no inbuilt conception of classes, and has minimal to no data
structures present in the base language. As of late May 2019, we are using Lua version **5.3.4**.

The next steps depend on your level of previous programming experience.

### Beginner

After you're done reading this primer, check out this [tutorial](lua_basics_lightbulb.md), and review the :fas fa-external-link-alt: [official](https://www.lua.org/pil/contents.html) docs after.

!!! note "Programming In Lua (offical link) is based on Lua 5.0 and missing additions of later version!"

### Intermediate

Skim through the beginner content, then try our [Manticoin Game](lua_basics_manticoin.md) tutorial.

### Advanced

Check out this :fas fa-external-link-alt: [primer](https://learnxinyminutes.com/docs/lua/), or this :fas fa-external-link-alt: [reference-sheet](http://lua-users.org/files/wiki_insecure/users/thomasl/luarefv51.pdf) for tips on syntax. Use the
official :fas fa-external-link-alt: [reference](http://www.lua.org/manual/5.3/) as needed, then make yourself familiar with the [CORE API](../../core_api.md) and take a look at our [style guide](lua_style_guide.md) and [Editor extensions](../../extensions.md).

#### Coming from other engines

Other engines also have good sources of documentation for Lua. Check out our [other-engines](../../getting_started/other_engines.md) page that has a few hints on whats different between them and **CORE**.

## Basics

While there are already a ton of good Lua tutorials out there, we're still going to teach you the most basic things right here.

```lua
-- Two dashes start a one-line comment.

--[[
     Adding two ['s and ]'s makes it a
     multi-line comment.
--]]
```

## Variables and Flow Control

```lua
num = 42  -- All numbers are doubles.
-- Don't freak out, 64-bit doubles have 52 bits for
-- storing exact int values; machine precision is
-- not a problem for ints that need < 52 bits.

s = 'walternate'  -- Immutable strings like Python.
t = "double-quotes are also fine"
u = [[ Double brackets
       start and end
       multi-line strings.]]
t = nil  -- Undefines t; Lua has garbage collection.

-- Blocks are denoted with keywords like do/end:
while num < 50 do
  num = num + 1  -- No ++ or += type operators.
end

-- If clauses:
if num > 40 then
  print("over 40")
elseif s ~= "walternate" then  -- ~= is not equals.
  -- Equality check is == like Python; ok for strs.
  io.write("not over 40\n")  -- Defaults to stdout.
else
  -- Variables are global by default.
  thisIsGlobal = 5  -- Camel case is common.

  -- How to make a variable local:
  local line = io.read()  -- Reads next stdin line.

  -- String concatenation uses the .. operator:
  print("Winter is coming, " .. line)
end

-- Undefined variables return nil.
-- This is not an error:
foo = anUnknownVariable  -- Now foo = nil.

aBoolValue = false

-- Only nil and false are falsy; 0 and "" are true!
if not aBoolValue then print("twas false") end

-- "or" and "and" are short-circuited.
-- This is similar to the a?b:c operator in C/js:
ans = aBoolValue and "yes" or "no"  --> "no"

karlSum = 0
for i = 1, 100 do  -- The range includes both ends.
  karlSum = karlSum + i
end

-- The range is: begin, end[, step], use -1 as the range to count down
fredSum = 0
for j = 100, 1, -1 do
  fredSum = fredSum + j
end

-- Another loop construct:
repeat
  print("the way of the future")
  num = num - 1
until num == 0
```

## Functions

```lua
function Fib(n)
  if n < 2 then return 1 end
  return Fib(n - 2) + Fib(n - 1)
end

-- Closures and anonymous functions are ok:
function Adder(x)
  -- The returned function is created when Adder is
  -- called, and remembers the value of x:
  return function(y) return x + y end
end

a1 = Adder(9)
a2 = Adder(36)
print(a1(16))  --> "25"
print(a2(64))  --> "100"

-- Returns, func calls, and assignments all work
-- with lists that may be mismatched in length.
-- Unmatched receivers are nil.
-- Unmatched senders are discarded.

x, y, z = 1, 2, 3, 4
-- Now x = 1, y = 2, z = 3, and 4 is thrown away.

function Bar(a, b, c)
  print(a, b, c)
  return 4, 8, 15, 16, 23, 42
end

x, y = Bar("zaphod")  --> "zaphod  nil nil"
-- Now x = 4, y = 8, values 15..42 are discarded.

-- Functions are first-class, may be local/global.
-- These are the same:
function F(x)
  return x * x
end

F = function(x)
  return x * x
end

-- And so are these:
local function G(x)
  return math.sin(x) -- Trigonometry funcs work in radians, by the way.
end

local G
G = function(x)
  return math.sin(x)
end
-- the "local G" declaration makes g-self-references ok.
```

## Tables

```lua
-- Tables = Lua's only compound data structure;
--          they are associative arrays.
-- Similar to php arrays or js objects, they are
-- hash-lookup dicts that can also be used as lists.

-- Using tables as dictionaries / maps:

-- Dict literals have string keys by default:
t = {key1 = 'value1', key2 = false}

-- String keys can use js-like dot notation:
print(t.key1)  --> "value1"
t.newKey = {}  -- Adds a new key/value pair.
t.key2 = nil   -- Removes key2 from the table.

-- Literal notation for any (non-nil) value as key:
u = {["@!#"] = "qbert", [{}] = 1729, [6.28] = "tau"}
print(u[6.28])  --> "tau"

-- Key matching is basically by value for numbers
-- and strings, but by identity for tables.
a = u["@!#"]  -- Now a = "qbert".
b = u[{}]     -- We might expect 1729, but it's nil:
-- b = nil since the lookup fails. It fails
-- because the key we used is not the same object
-- as the one used to store the original value. So
-- strings & numbers are more portable keys.

-- A one-table-param function call needs no parens:
function H(x)
  print(x.key1)
end

h{key1 = "Sonmi~451"}  --> "Sonmi~451"

-- There are two types of table iterators in Lua
-- pairs() returns key-value pairs and is mostly used for associative tables.
-- Attention: Key order is unspecified.
u = {}
u[1] = "a" -- Attention: Indices start at 1 in Lua!
u[3] = "b"
u[2] = "c"
u[4] = "d"
u["hello"] = "world"

for key, val in pairs(u) do
  print(key, val)
end
-- will print:
-- 1  a
-- 2  c
-- 3  b
-- 4  d
-- hello  world

-- ipairs() returns index-value pairs and is used for numeric tables.
-- Non numeric keys in an array are ignored, while the index order is in numeric order.
-- When you create tables without keys, ipairs behaves as a numeric array and therefore the same as pairs.
-- Attention: ipairs stops when it first encounters a gap.
for index, val in ipairs(u) do
  print(index, val)
end
-- will print:
-- 1  a
-- 2  c
-- 3  b
-- 4  d

-- _G is a special table of all globals.
print(_G["_G"] == _G)  --> "true"

-- Using tables as lists / arrays:

-- List literals implicitly set up int keys:
v = {"value1", "value2", 1.21, "gigawatts"}

for i = 1, #v do  -- #v is the size of v for lists.
  print(v[i])
end
-- A 'list' is not a real type. v is just a table
-- with consecutive integer keys, treated as a list.
```

### 3.1 Metatables and Metamethods

```lua
-- A table can have a metatable that gives the table
-- operator-overloadish behavior. Later we'll see
-- how metatables support js-prototypey behavior.

f1 = {a = 1, b = 2}  -- Represents the fraction a/b.
f2 = {a = 2, b = 3}

-- This would fail:
-- s = f1 + f2

metafraction = {}
function metafraction.__add(f1, f2)
  sum = {}
  sum.b = f1.b * f2.b
  sum.a = f1.a * f2.b + f2.a * f1.b
  return sum
end

setmetatable(f1, metafraction)
setmetatable(f2, metafraction)

s = f1 + f2  -- call __add(f1, f2) on f1's metatable

-- f1, f2 have no key for their metatable, unlike
-- prototypes in js, so you must retrieve it as in
-- getmetatable(f1). The metatable is a normal table
-- with keys that Lua knows about, like __add.

-- But the next line fails since s has no metatable:
-- t = s + s
-- Class-like patterns given below would fix this.

-- An __index on a metatable overloads dot lookups:
defaultFavs = {animal = "gru", food = "donuts"}
myFavs = {food = "pizza"}
setmetatable(myFavs, {__index = defaultFavs})
eatenBy = myFavs.animal  -- works! thanks, metatable

-- Direct table lookups that fail will retry using
-- the metatable's __index value, and this recurses.

-- An __index value can also be a function(tbl, key)
-- for more customized lookups.

-- Values of __index,add, .. are called metamethods.
-- Full list. Here a is a table with the metamethod.

-- __add(a, b)                     for a + b
-- __sub(a, b)                     for a - b
-- __mul(a, b)                     for a * b
-- __div(a, b)                     for a / b
-- __mod(a, b)                     for a % b
-- __pow(a, b)                     for a ^ b
-- __unm(a)                        for -a
-- __concat(a, b)                  for a .. b
-- __len(a)                        for #a
-- __eq(a, b)                      for a == b
-- __lt(a, b)                      for a < b
-- __le(a, b)                      for a <= b
-- __index(a, b)  <fn or a table>  for a.b
-- __newindex(a, b, c)             for a.b = c
-- __call(a, ...)                  for a(...)
```

### 3.2 Class-like Tables and Inheritance

```lua
-- Classes aren't built in but there are different ways
-- to make them using tables and metatables.

Dog = {}                                   -- 1.

function Dog:New()                         -- 2.
  newObj = {sound = "woof"}                -- 3.
  self.__index = self                      -- 4.
  return setmetatable(newObj, self)        -- 5.
end

function Dog:MakeSound()                   -- 6.
  print("I say " .. self.sound)
end

mrDog = Dog:New()                          -- 7.
mrDog:MakeSound()  --> "I say woof"        -- 8.

-- 1. Dog acts like a class; it's really a table.
-- 2. function tablename:fn(...) is the same as
--    function tablename.fn(self, ...)
--    The : just adds a first arg called self.
--    Read 7 & 8 below for how self gets its value.
-- 3. newObj will be an instance of class Dog.
-- 4. self = the class being instantiated. Often
--    self = Dog, but inheritance can change it.
--    newObj gets self's functions when we set both
--    newObj's metatable and self's __index to self.
-- 5. Reminder: setmetatable returns its first arg.
-- 6. The : works as in 2, but this time we expect
--    self to be an instance instead of a class.
-- 7. Same as Dog.New(Dog), so self = Dog in New().
-- 8. Same as mrDog.makeSound(mrDog); self = mrDog.

----------------------------------------------------

-- Inheritance example:

LoudDog = Dog:New()                           -- 1.

function LoudDog:MakeSound()
  s = self.sound .. " "                       -- 2.
  print(s .. s .. s)
end

seymour = LoudDog:New()                       -- 3.
seymour:MakeSound()  --> "woof woof woof"     -- 4.

-- 1. LoudDog gets Dog's methods and variables.
-- 2. self has a 'sound' key from New(), see 3.
-- 3. Same as LoudDog.New(LoudDog), and converted to
--    Dog.New(LoudDog) as LoudDog has no 'new' key,
--    but does have __index = Dog on its metatable.
--    Result: seymour's metatable is LoudDog, and
--    LoudDog.__index = LoudDog. So seymour.key will
--    = seymour.key, LoudDog.key, Dog.key, whichever
--    table is the first with the given key.
-- 4. The 'makeSound' key is found in LoudDog; this
--    is the same as LoudDog.makeSound(seymour).

-- If needed, a subclass's New() is like the base's:
function LoudDog:New()
  newObj = {}
  -- set up newObj
  self.__index = self
  return setmetatable(newObj, self)
end
```

## Modules

```lua
-- Suppose the file mod.lua looks like this:
local m = {}

local function SayMyName()
  print("Hrunkner")
end

function m.SayHello()
  print("Why hello there")
  SayMyName()
end

return m

-- Another file can use mod.lua's functionality:
local mod = require("mod")  -- Run the file mod.lua.

-- require is the standard way to include modules.
-- require acts like:     (if not cached; see below)
local mod = (function ()
  <contents of mod.lua>
end)()
-- It's like mod.lua is a function body, so that
-- locals inside mod.lua are invisible outside it.

-- This works because mod here = M in mod.lua:
mod.SayHello()  -- Says hello to Hrunkner.

-- This is wrong; SayMyName only exists in mod.lua:
mod.SayMyName()  -- error

-- require's return values are cached so a file is
-- run at most once, even when require'd many times.

-- Suppose mod2.lua contains "print('Hi!')".
local a = require("mod2")  --> "Hi!"
local b = require("mod2")  -- Doesn't print because a = b.

-- dofile is like require without caching:
dofile("mod2.lua")  --> "Hi!"
dofile("mod2.lua")  --> "Hi!" (runs it again)

-- loadfile loads a lua file but doesn't run it yet.
f = loadfile("mod2.lua")  -- Call f() to run it.

-- loadstring is loadfile for strings.
g = loadstring("print(343)")  -- Returns a function.
g()  --> "343" nothing printed before now.
```

If you're still really hungry for more info, more primers can be found here:

-   :fas fa-external-link-alt: [LuaTut](http://luatut.com/crash_course.html)
-   :fas fa-external-link-alt: [WingDB](http://www.wingdb.com/docs/pages/wg_lua_primer.htm)
-   :fas fa-external-link-alt: [Geeks3D](https://www.geeks3d.com/20130516/lua-primer-for-the-impatient/)
-   :fas fa-external-link-alt: [TylerNeylon](http://tylerneylon.com/a/learn-lua/)
