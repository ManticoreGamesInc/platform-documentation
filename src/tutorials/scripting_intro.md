---
id: scripting_intro
name: Intro to Scripting
title: Intro to Scripting
tags:
    - Reference
---

# Intro to Scripting

## Overview

The goal of this doc is to introduce the central ideas of what a script is and how they are used to make games in Core. If you have no experience with programming, or understand some code but not how it can be used for game development in Core, this is the ideal starting point. Developers with some experience will be better off starting with our [Intro to Lua](lua_basics_lightbulb.md) tutorial, or looking at [Example Code](examples.md).

## Scripting

### Scripting Definition

**Scripting**, also known as **coding** or **programming** is the way to write instructions for the execution of the game, using very specific language that can be understood by the computers that are responsible for running the game.

This is similar to rules for a board game, where the different procedures are explained - the order of turns and determining the first player, the steps of a turn, different options at a particular moment. The difference is that board game instructions are written to be understood by humans.

### What You Can Do with Scripts

Using Core frameworks, gameplay objects, and environment design tools, you can make complete game experiences in Core without code. Using scripts will allow you to create more specific gameplay options, program movement of different entities, and create sequences, or random events that allow players more options of ways to interact with your game.

### The Lua Programming Language

[**Lua**](https://www.lua.org/) is a language very popular in game development because it is both easy to learn, like [Python](https://www.python.org/), and powerful, like [C++](https://isocpp.org/). You will not need to rigorously study Lua in order to write scripts in Core, but if you are interested in an introduction to learning the language itself, [this Lua tutorial](http://luatut.com/crash_course.html) is a great starting point.

## Essential Concepts

### Variables

When a basic calculator does a computation, it can give you a result, but will not remember the numbers that you gave it. To keep track of a value, you would need to give it a name, so that you can talk about it later. A **variable** in programming lets you put a label to some information so that you can change and use it in a program.

You can create a variable using the keyword **local**. Variable names cannot include spaces

```lua
local myVariable = 54
```

### Data Types

Variables can be used to keep track of number values, but numbers are only one of the  **data types** that they can be used to keep track of. The three most useful data types to know about are **strings**, **numbers**, and **booleans**.

#### Strings

**Strings** are any collection of numbers, letters and punctuation. They need to be written in double quotes (``" "``) so that the computer does not mistake them for code.

```lua
local myId = "123456789:Tiger"
local quote = "Something inspirational"
```

#### Numbers

**Numbers** are both whole and decimal numbers. They can be written directly in the code and still get treated like data. This is true of mathematical **operators** like addition and multiplication as well.

- Addition: ``+``
- Subtraction: ``-``
- Multiplication: ``*``
- Division: ``/``
- Exponents: ``^``

```lua
local aNumber = 21
local anotherNumber = 7
local aThirdNumber = aNumber / anotherNumber
-- The variable aThirdNumber will be 3
```

#### Booleans

**Booleans** are a data type that is only ever **true** or **false.** They are most often used in **if-statements**, which allow you to write code that only happens if certain other things are true.

You can create a boolean variable using the keywords ``true`` and ``false``, but most often this is done by comparing different values.

- Check if two values are **equal**: ``==``
- Check if two values are **not equal**: ``~=``
- Check if a value is **less than** or **greater than** to another: ``<`` or ``>``
- Check if a value is **less than or equal** or **greater than or equal** to another: ``<=`` or ``>=``

Example:

```lua
local numberOfPlayers = 6

if numberOfPlayers >= 3 then
    -- do some code if there are at least 3 players
end
```

### Tables

Tables are a way to collect a list of variables. They are stored with labels like variables, but also in the same order, so you can find the first, third, or last thing in the list easily.

Most usefully, putting things in a table allows you to do the same operation to all of them.

To create a table you use curly brackets ```{ }``` and to put things in to it you use ```[ ]```.

#### Making a Table

```lua
local enemies = {"zombie", "skeleton"}
```

#### Finding Something in a Table

```lua
enemies[2] -- will be "skeleton"
```

#### Adding More to a Table

```lua
enemies[3] = "dragon"
```

### Functions

#### Function Definition

**Functions** are ways to group a sequence of code that does a specific task to use later.

#### Creating a Function

To create a function, you use the ```function``` keyword, along with the name for the function, and parentheses, ``( )``. Code that is part of the function is indented, and the ``end`` keyword finishes it.

Example:

```lua
function EndGame()
    print("Game Over") -- will display the text "Game Over"
end
```

#### Function Parameters

You can change the behavior of functions by giving them different inputs, called **parameters**. To create an input on a function, give it a name, like a variable, in the parentheses of the function. Then you can specify in the code what to do with the input using the name you created.

Example:

```lua
function DeclareWinner(winnerName)
    print(winnerName .. " wins!") -- will display whatever name is given in parentheses and say that they win.
end
```

#### Calling a Function

Writing a function is like writing down a recipe. To actually make the computer execute the code, the function needs to be told to execute by **calling** it. To call a function, use its name followed by parentheses and any inputs that it requires.

Example:

```lua
EndGame()
DeclareWinner("slinkous")
```

Output:

<pre><output>
Game Over
slinkous wins!
</output></pre>

## The Core API

### Scripts in Core

Scripts work like objects in Core, so they will show up in the **Project Content**, and can be dragged into the Hierarchy.

You can create a script with the **Create Script** button in the **Top Toolbar**. The **Script Generator** will also give you sample code for a couple of specific uses.

To see errors and outputs, you will also need to open the **Event Log**, which is where any ``print()`` will display text.

### Objects

Objects are more complex data types. They have **properties** which are aspects that change about them, and are usually different between different individual members of the object category, called **instances.**

For example, a **Player** is an object in Core that has properties like world position and name. Individual players will have different positions and names.

#### Using Core Objects in Scripts

To be able to talk about Core Objects in scripts, you need a way to make variables for them, called a **reference**.

The easiest way to refer to an object is to drag the script onto that object in the **Hierarchy**. The object is now a **parent** of the script, and you can reference it in code by using ```script.parent```.

Another way to use an object in a script, especially if it needs to be created by the script, is to select the script and open the **Properties** window. Drag the object onto the script properties, making a new **Custom Property**. This will also generate a line that you can copy and paste into your code to create a variable reference to the object.

### API Definition

**API** stands for Application Programming Interface, and is a set of functions made for other people to write code that uses a program without changing the program itself. You could compare it to the tools you have to drive a car, because you have a variety of options of how you want to drive, but they don't change how the car works.

The [Core API](core_api.md) document lists all the functions, properties and events that you can use in scripts, for every object type in Core.

## Learn More

[Lua Tutorial](lua_basics_lightbulb.md) | [Lua Style Guide](lua_style_guide.md) | [API Examples](examples.md)
