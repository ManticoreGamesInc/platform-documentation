# Best Practices

## Coding Conventions

Uses dots for static functions and class-level properties and colons for class methods

Tabs for indentation
"Double Quotes" unless you 'need to quote a "quote"'
And, for custom classes : is used for methods, . for properties (as a general rule . mimics static functions, : for methods of instantiated objects)

Use PascalCase names for class and enum-like objects.
Use camelCase names for local variables, member values, and functions.
Use LOUD_SNAKE_CASE names for local constants.
Prefix private members with an underscore, like _camelCase.
    Lua does not have visibility rules, but using a character like an underscore helps make private access stand out.
A File's name should match the name of the object it exports.
    If your module exports a single function named doSomething, the file should be named doSomething.lua.

MyScript.lua

local TIMER_CONSTANT = 4

local playerTable = {}