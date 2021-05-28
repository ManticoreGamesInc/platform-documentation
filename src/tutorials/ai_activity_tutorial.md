---
id: ai_activity_tutorial
name: AI Activity Tutorial
title: AI Activity Tutorial
tags:
    - Tutorial
---

# AI Activity Tutorial

## Overview

The **AI Activity System** is a way to define different activities that an AI can do and then control which activity is chosen by increasing and decreasing the priorities of each activity. The highest priority activity acts and the rest wait for their priority to increase.

**AI Activity Systems** can be built to create independent AI, like a turret that searches for a target and shoots at it after one is found or to control game flow, such as a manager that monitors resources and combat conditions to deploy workers and combat troops in an RTS.

- Completion Time: ~5 minutes
- Knowledge Level: Basic Lua Understanding
- Skills you will learn:
    - How to add an **AI Activity Handler** to your project.
    - How to add **AI Activities** to the **AI Activity Handler**.
    - How to control priorities of **AI Activities**.
    - How to setup different functions for when an **AI Activity** is active.

## Adding the Template to Your Project

Setting up an **AI Activity System** only takes a few steps. We'll go over how to setup activities that create an AI to play tic tac toe with.

First, let's create a new level and download the basic game logic. Then we'll add an AI activity system to make the AI work.

The template contains:

- 9 Triggers (with supporting artwork) in a 3x3 grid.
- GameManager: a script containing the game state API initialization, testing for end of game, the current player's turn capturing a board position, with validation, world location of each board position.
- AI TicTacToe Strategy: a script with helper functions to: test the board for either a win or block choose which board position might be strategically best.

!!! note
    This tutorial is not about the game of Tic Tac Toe itself, but how to add an AI entity to use the game state and strategy API, as a live opponent.

### Download the Template

1. Open the **Community Content** window in the Core Editor.
2. Use the search bar to search for **TicTacToe Game**.
3. Click **Import** to download the template.

### Open the Template

1. In the **Core Content** window, find the **Imported Content** section and then find **TicTacToe Tutorial** ![Package](../img/EditorManual/icons/AssetType_Bundle.png){: style="height:34px" }.
{ .image-inline-text .image-background }
2. Double-click the ![Package](../img/EditorManual/icons/AssetType_Bundle.png){: style="height:34px" } icon to open it. You should now see the green ![Template](../img/EditorManual/icons/TemplateIcon.png){: style="height:34px" } icon.
{ .image-inline-text .image-background }
3. Hold left-click on the **TicTacToe Game** package icon and drag it into your project by either dragging it into the **Main Viewport** somewhere in your world or by dragging it into your **Hierarchy**.
4. Change the position of the template and its components where you want it using the transform tools in the top toolbar. To learn more about moving objects, check out the [Intro to the Editor](editor_intro.md) tutorial.

!!! note
    It is important that the entire template does no overlap the **Spawn Point** to ensure all the triggers detect properly.

## How Tic Tac Toe AI Works

There are only two behaviors needed for an AI opponent in playing Tic Tac Toe:

- `Idle`: the AI needs to wait until its turn
- `Capture`: when it's the AI's turn, the AI needs to intelligently determine which board position to capture

Each behavior is an instance of an **AIActivity**, a **Core** class providing support to connect Lua functions with four purposes:

- `function tick(activity, deltaTime)` - Every **AIActivity** will have its `tick` method called every update, passing `deltaTime` to reveal how much time has elapsed since the last update.
    - The `tick` should calculate and set the `activity.priority` (a `number` value), so we can determine which **AIActivity** has the highest priority.
- `function tickHighestPriority(activity, deltaTime)` - As suggested, once all **AIActivity** priorities have been assigned, the one with the highest value will have this member executed.
- `function start(activity)` - A convenience (initialization) function executed when the activity first becomes the highest priority.
- `function stop(activity)` - Executed member of the highest priority activity on the frame it gives way to a new highest priority activity.

We want to implement these functions for the **Idle** and **Capture** activities to create a responsive AI opponent.

### What is the AI Activity Handler

The **AIActivityHandler** is a **Core** class that contains the **AIActivity** instances added. It "handles" them by performing the following steps (on each update):

1. It loops through every **AIActivity** and calls that activity’s **tick()** method.
2. Once it has called the `tick` function of each activity, it looks at the `activity.priority` property and determines which activity is the highest.
3. If a new **AIActivity** is determined highest priority, it will call `activity.stop()` on the previous, and `activity.start()` on the new one.
4. Finally, for the one activity that has the highest priority, it will call `activity.tickHighestPriority()` every frame.

## Creating an AI Activity Handler

1. Deinstance the **TicTacToe Game** template.
2. Right-click on the template and choose **Create...** -> **Create Gameplay Object** -> **Create AI Activity Handler**.
3. Right-click on the **AI Activity Handler** you just created, and choose **Create...** -> **Create Script** -> **Create New Script**.
4. Name the script whatever you want; we will be using `AI_TicTacToe`.
5. Double-click your new script to edit it.

!!! note
    You can also drag an AI Activity Handler into the scene from the **Gameplay Objects** category in the **Core Content** window.

### Add the Idle AI Activity

For convenience, an activity code snipping has been provided in the **Script Generator**.

1. From the **Core Toolbar**, select **Window** -> **Script Generator**.
2. From the **Script Generator** window, select **AI Activity** in the drop down
3. Set the name of the **AI Activity** to "IdleActivity".
4. Click the **Copy To Clipboard** button.
5. In your `AI_TicTacToe` script, paste the new snippet.

In the context of TicTacToe, the only thing Idle needs to do is... wait your turn.

!!! note
    The code snippet contains a stubbed implementation for each of the four methods of the AI Activity class, as members of a `local IdleActivity = {}` Lua table.

!!! note
    The function `IdleActivity.tick()` implementation sets the priority to a default of 100.

### Add the Capture AI Activity

1. Perform the steps above in pasting another activity code snippet into the bottom of your script, except name your new activity "CaptureActivity".
2. Remove the second duplicate of `local aiActivityHandler = script.parent`.

The script should now look like this:

```lua
-- AI Activity Handler
-- Assume this script is a child of an AIActivityHandler
local aiActivityHandler = script.parent

-- Parameter table for defining the tick, tickHighestPriority, start, stop functions
local IdleActivity = {}

-- Called every frame for all activities, usually used to set the priority
function IdleActivity.tick(activity, deltaTime)
    activity.priority = 100
end

-- Called after all activities have tick'd, but only for the activity with the highest priority
function IdleActivity.tickHighestPriority(activity, deltaTime)

end

-- Called when this activity first becomes the highest priority
function IdleActivity.start(activity)

end

-- Called when this was the highest priority, and a different activity has just taken over
function IdleActivity.stop(activity)

end

-- Instantiates and returns an AIActivity managed by the aiActivityHandler
local IdleActivityInstance = aiActivityHandler:AddActivity("Idle", IdleActivity)

-- Parameter table for defining the tick, tickHighestPriority, start, stop functions
local CaptureActivity = {}

-- Called every frame for all activities, usually used to set the priority
function CaptureActivity.tick(activity, deltaTime)
    activity.priority = 100
end

-- Called after all activities have tick'd, but only for the activity with the highest priority
function CaptureActivity.tickHighestPriority(activity, deltaTime)

end

-- Called when this was the highest priority, and a different activity has just taken over
function CaptureActivity.start(activity)

end

-- Called when this was the highest priority, and a different activity has just taken over
function CaptureActivity.stop(activity)

end

-- Instantiates and returns an AIActivity managed by the AiActivityHandler
local CaptureActivityInstance = aiActivityHandler:AddActivity("Capture", CaptureActivity)
```

## Implementing the Capture AI Activity

Now we need to implement the Capture AI Activity to function. There are three steps to this activity:

- Set the priority: high when it is the AI's turn and low after the AI has captured a position or it is the player's turn.
- Determine the board position that should strategically be captured.
- Use the Game API to capture the board position; the game implementation itself will now switch whose turn it is so we do not have to worry about that.

### Tick Implementation

As stated above, the priority is high (above 100, relative to the Idle activity) when it is our turn and low if the game is over or its not our turn.

1. Delete the line `activity.priority = 100` from the `tick()` function of your **Capture Activity**.
2. Modify the `tick()` function of the **Capture Activity** to use the game API, and add three sections:

If the game is over, set the priority to `0` and exit early.

```lua
-- The game is over so there is nothing for the AI to do
-- Return early as there is nothing to do after we set the priority to 0
local gameOver, winnerIsX = _G.isGameOver()
if gameOver then
    activity.priority = 0
    return
end
```

If the player has not made their turn yet then there is nothing for the AI to do so we can set the priority to `0` and do exit early.

```lua
-- Waiting on the player to make a turn so there is nothing for the AI to do
-- Return early as there is nothing to do after we set the priority to 0
local isPlayerTurn = _G.isHumansTurn()
if isPlayerTurn then
    activity.priority = 0
    return
end
```

Finally, select and verify there is a valid board position to capture.

```lua
-- If the AI has not chosen a board position, it is time to do that now

-- serverUserData contains extra information about the activity
-- that is user-defined and accessible to the server
local activityData = activity.serverUserData

-- If there is no valid capture position then we need to attempt a capture
-- Otherwise, keep it above Idle priority
if not activityData.capturePosition or activityData.capturePosition < 0 then
    activityData.capturePosition = _G.chooseBoardPosition()

    -- If there is no valid move, set the priority to 0
    -- Otherwise, set it higher than Idle priority
    if activityData.capturePosition < 0 then
        activity.priority = 0
    else
        activity.priority = 200
    end
else
    activity.priority = 200
end
```

This concludes our `tick()` implementation: we set a "higher than idle" priority if the game is not over, if it is the AI's turn, and if a board position has been successfully determined; otherwise the priority is set to `0`, indicating that there is no actions to make.

### TickHighestPriority Implementation

This method is only executed when the **Capture Activity** has the highest priority, meaning its priority is higher than the **Idle Activity** priority (`100`). All there is to be done here is activate the trigger for the game board position. For aesthetics, it is nice to wait a second or two so it feels like the AI is responding at a comfortable pace.

Add the following to the **Capture Activity** `tickHighestPriority()`:

```lua
-- serverUserData contains extra information about the activity
-- that is user-defined and accessible to the server
local activityData = activity.serverUserData

-- Get the amount of time that has passed since the board position has been chosen
local elapsedTime = activity.elapsedTime

-- If the elapsed time is greater than 2 seconds,
-- activate the trigger and set the capturePosition to be negative
if elapsedTime > 2.0 then
    _G.forceTrigger(false, activityData.capturePosition)
    activityData.capturePosition = -1
end
```

We are checking how much time has passed since this activity has been the highest priority and once (in this case) `2` seconds has elapsed, we want to use the game API to activate the trigger for the board position; the same value that was set in the `tick` function of the **Capture Activity**.

## Cleaning and Removing Excess Code

Now that everything is implemented, it is time to clean up the code.

Since the purpose of the **Idle Activity** is only to keep the `priority` set to `100`, we can remove the `tickHighestPriority()`, `start()`, and `stop()` functions.

For the **Capture Activity**, there was no implementation for the `start()` and `stop()` functions, we we can remove those too.

## Final Code

```lua
-- AI Activity Handler

-- Assume this script is a child of an AIActivityHandler
local aiActivityHandler = script.parent

-- Parameter table for defining the tick, tickHighestPriority, start, stop functions
local IdleActivity = {}

-- Called every frame for all activities, usually used to set the priority
function IdleActivity.tick(activity, deltaTime)
    activity.priority = 100
end

-- Instantiates and returns an AIActivity managed by the aiActivityHandler
local IdleActivityInstance = aiActivityHandler:AddActivity("Idle", IdleActivity)

-- Parameter table for defining the tick, tickHighestPriority, start, stop functions
local CaptureActivity = {}

-- Called every frame for all activities, usually used to set the priority
function CaptureActivity.tick(activity, deltaTime)
    -- The game is over so there is nothing for the AI to do
    -- Return early as there is nothing to do after we set the priority to 0
    local gameOver, winnerIsX = _G.isGameOver()
    if gameOver then
        activity.priority = 0
        return
    end

    -- Waiting on the player to make a turn so there is nothing for the AI to do
    -- Return early as there is nothing to do after we set the priority to 0
    local isPlayerTurn = _G.isHumansTurn()
    if isPlayerTurn then
        activity.priority = 0
        return
    end

    -- If the AI has not chosen a board position, it is time to do that now

    -- serverUserData contains extra information about the activity
    -- that is user-defined and accessible to the server
    local activityData = activity.serverUserData

    -- If there is no valid capture position then we need to attempt a capture
    -- Otherwise, keep it above Idle priority
    if not activityData.capturePosition or activityData.capturePosition < 0 then
        activityData.capturePosition = _G.chooseBoardPosition()

        -- If there is no valid move, set the priority to 0.
        -- Otherwise, set it higher than Idle priority.
        if activityData.capturePosition < 0 then
            activity.priority = 0
        else
            activity.priority = 200
        end
    else
        activity.priority = 200
    end
end

-- Called after all activities have tick'd, but only for the activity with the highest priority
function CaptureActivity.tickHighestPriority(activity, deltaTime)
    -- serverUserData contains extra information about the activity
    -- that is user-defined and accessible to the server
    local activityData = activity.serverUserData

    -- Get the amount of time that has passed since the board position has been chosen
    local elapsedTime = activity.elapsedTime

    -- If the elapsed time is greater than 2 seconds,
    -- activate the trigger and set the capturePosition to be negative
    if elapsedTime > 2.0 then
        _G.forceTrigger(false, activityData.capturePosition)
        activityData.capturePosition = -1
    end
end

-- Instantiates and returns an AIActivity managed by the AiActivityHandler
local CaptureActivityInstance = aiActivityHandler:AddActivity("Capture", CaptureActivity)
```

## Play the Game

1. Press **Play** in the Core editor to begin the game.
2. The player always gets to move first; walk your character to the board position you wish to capture and activate the trigger using ++F++.
3. A bright blue marker will appear on the board; this is your move, the `X`.
4. After two seconds a bright yellow marker will appear on the board; this is the AI's move, the `O`.
5. Repeat until either you or the AI has won or there are no move available board positions to take, resulting in a tie.

Good luck!
