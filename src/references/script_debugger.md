---
id: script_debugger
name: Script Debugger Reference
title: Script Debugger Reference
tags:
    - Reference
---

# Script Debugger

## Overview

Sometimes when writing code, it doesn't always behave as expected. Those unexpected results can lead to parts of your game being broken for your players, and potentially ruin the experience. Spending time looking for those errors in a script can be very time consuming. This is where the **Script Debugger** in **Core** can help narrow down where in the script the error occurred.

## What is a Script Debugger?

The **Script Debugger** in **Core** is a tool used to examine the state of a game while it is running. The **Script Debugger** can be set to pause the game at specific points in a script by setting **breakpoints**, so that values of variables and objects can be inspected. Using the **Script Debugger**, allows you to step through your scripts slowly to determine where an issue may be in a game.

There are different ways that a game can be debugged to find issues (also know as **Bugs**). A common way is to use the `print` function to print out to the **Event Log**, however, this can be a slow process when more complex errors occur in a game, so using a debugger could save a lot of time.

## Opening the Script Debugger

From the **Window** menu, select **Script Debugger** to open up the **Script Debugger** window.

!!! info "Script Debugger and External Editors"
    The **Script Debugger** only works with the **Script Editor** in **Core**, and not external editors.

![Opening](../img/ScriptDebugger/opening_script_debugger.png)
![Window](../img/ScriptDebugger/script_debugger_window.png)
{: .image-cluster}

## Enabling the Script Debugger

The **Script Debugger** needs to be enabled so any breakpoints added, will pause the execution of the game. This allows areas of interest in a script to be inspected that may contain an issue.

Clicking on the ![Disabled](../img/ScriptDebugger/script_debugger_disabled.png)icon will enable the **Script Debugger**. When enabled, the icon will turn red ![Enabled](../img/ScriptDebugger/script_debugger_enabled.png), indicating the **Script Debugger** is turned on. With the **Script Debugger** now turned on, any breakpoints added will pause execution of the game.
{: .image-inline-text .image-background }

!!! info "When disabling the **Script Debugger**, all breakpoints will also be disabled. This is useful, because all breakpoints don't need to be removed. Next time the **Script Debugger** is enabled, the breakpoints will also be enabled."

## Enabling Pause on Error

The **Script Debugger** has the option to automatically pause the game when an error has occurred. This can be useful to have enabled when scripts in a game are causing an error. Clicking on the ![Disabled](../img/ScriptDebugger/pause_on_error_disabled.png) icon will change to red ![Enabled](../img/ScriptDebugger/pause_on_error_enabled.png), indicating that the **Script Debugger** will pause on error.
{: .image-inline-text .image-background }

## Adding and Removing Breakpoints

A breakpoint is a marker that can set for a specific line in a script. More than one marker can be set in a script, but only one can be set for each line. Markers can be set by left clicking with the mouse in the far left margin of the **Script Editor**.

### Adding a Breakpoint

A breakpoint can be added so the **Script Debugger** knows where to pause execution. Adding a breakpoint can be done by left clicking with the mouse in the far left margin of the **Script Editor**. On clicking in the margin, a red circle will be added to the margin, indicating that line has a breakpoint.

![!Add Breakpoint](../img/ScriptDebugger/add_breakpoint.png){: .center loading="lazy" }

### Removing a Breakpoint

Removing a breakpoint works the same as adding a breakpoint. Clicking on the red circle in the far left margin of **Script Editor** will remove the breakpoint. When the game is played, the **Script Debugger** will not pause execution if no breakpoints are present.

## Stepping Through a Script

Stepping through a script is an important part of debugging, it allows creators to walk through each line of the script to inspect the variables and objects to see what is contained in them.

### Step Into

**Step Into** ![Step Into](../img/ScriptDebugger/step_into_icon.png)will be frequently used to step through a script line by line. This also includes functions. If a function is about to be called, and the code needs to be debugged in that function, then the next step is to go into that function and debug it line by line by using **Step Into**.
{: .image-inline-text .image-background }

### Step Over

**Step Over** ![Step Over](../img/ScriptDebugger/step_over_icon.png)will execute as one complete step. For example, if the current line is a function, then stepping over that function will move to the next line instead of stepping through each line of that function.
{: .image-inline-text .image-background }

### Step Out

**Step Out** ![Step Out](../img/ScriptDebugger/step_out_icon.png)is used to step out of a function. For example, when only part of a function needs to be debugged, stepping out will tell the **Script Debugger** to run the rest of that function.
{: .image-inline-text .image-background }

## Select a Script Task

When a project gets bigger, more scripts are created to handle different parts of the game. Breakpoints can be added to different scripts, and the **Script Debugger** will pause execution for whichever script is running first that has a breakpoint set. Scripts that have not been completed can be stepped through. This can be done from **Script Task** drop down in the **Script Debugger** window.

The **Script Task** drop down will list all the scripts, and also indicate which one is currently running, scheduled, and which have completed.

![!Task List](../img/ScriptDebugger/task_list.png){: .center loading="lazy" }

??? Warning "Script Execution Order"
    Do not rely on the script execution order in preview to be the same for the live version of your game. In some cases, scripts may not be in the order as you expect, especially with networked contexts.

## Stack Frames

The **Stack Frames** panel in the **Script Debugger** window, shows the function calls that are currently on the stack for the current running script task. The **Stack Frames** panel shows the order in which the functions are getting called, which is a good way to see the execution flow of the script for the current task.

For example, in the picture below, you can see the execution flow for the current running script.

![!Stack Frames](../img/ScriptDebugger/stack_frames.png){: .center loading="lazy" }

## Learn More

[Intro to Scripting](../tutorials/scripting_intro.md) | [Lua Scripting Tutorial](../tutorials/lua_basics_helloworld.md) | [Lua Scripting Tutorial, Part 2](../tutorials/lua_basics_lightbulb.md) | [Advanced Scripting in Core](../tutorials/race_timer.md)
