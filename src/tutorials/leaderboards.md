---
id: leaderboards_reference
name: Leaderboards Reference
title: Leaderboards Reference
tags:
    - Reference
---

# Leaderboards

## Overview

<!-- ### Setting Up a Timer

Template will have both triggers, and the basic timing functions, as well as an empty UI

1. Add the Template
2. Create a Script and Add the Triggers as Custom Properties
3. Print time at both start and finish
4. Calculate time with simple variables
5. Explain a Player Time Table
    - Need diagram here for expanding table
    - The need to create empty tables
6. Start Timing and Stop Timing Functions

### Setting Up the UI

1. Create UI & Clip text
2. Broadcast Run Time to UI
3. Create update functions on UI & Event functions to update
4. Round Times
5. Count Up Timer on Client Side
6. Notice difference in Client/Server calculations, and override to server

### Saving Best Time

1. Make a function to set to best time if there is none, or compare a new time to update
2. Broadcast best time to UI
3. Notice that this resets each time
4. Send best time to Player Storage
5. Setup Best and Start on player Join

### Get World Record Time

1. Open Leaderboard Window
2. Configure Leaderboard to Start Tracking
3. Submit a Time OnJoin and at New Best Time
4. Get Leaderboard Results
5. Send World record to UI -->

## Set Up the Template

### Tutorial Template and Triggers

To record player run times, all you need is two triggers to track when a player leaves one point and arrives at the other, named **Start Line** and **Finish Line**.

However, to make the start and stop clear, there is a template on Community Content called **Start/Finish Line** which will be used in this tutorial.

### Download Start/Finish Line from Community Content

To begin, search for the **Start Finish Line** template pack in Community Content.

![Start/Finish Line on CC]()

1. Click **Import** to download the templates to your project.
2. In **Project Content**, double click the bundle to open it and show the **Start/Finish Line** template and the **Time Display** template.
3. Drag the **Start/Finish** line into your project, and reposition it to fit into the floor.
4. If you do not see the triggers at the start and finish, press ++V++ to toggle visibility.

![Start Line Trigger]()

### Create a Script that References Both Triggers

Next we will create a script with a reference to **both** triggers, so that it can calculate the time it takes a player to get from one to the other.

1. Click the ![Create Script Button](../img/EditorManual/icons/Icon_Script.png)  icon in the top toolbar and select **Create New Script** { .image-inline-text .image-background }
2. Name the script **`TimerServer`** and select **Create Script**
3. Drag the script into the Hierarchy, and open the **Properties** window with it selected.
4. Drag the Start Line and Finish Line triggers onto the Script's custom properties

![Hovering Finish Line on Script Custom Properties]()

!!! note
    This script is named **TimerServer** because it is responsible for the server-side calculations of player position. It will still be in the **Default** context in the Hierarchy. To learn more, see the [Network Contexts reference](networking.md)

### The time() Function

The function, **``time()``** will give you the number of seconds that have passed since the server started whenever you call it, which is how you will calculate the number of seconds between start and finish.

Read more about **``time()``** in [the API documentation](https://docs.coregames.com/core_api/#coreluafunctions).

### Create a Start Function

In the **Timer Server Script**, you will create a function for when player leaves the **Start Line** trigger, and connect it to the **Start Line** trigger's EndTriggerOverlap function.

Open the **Timer Server Script** and add the following code below the ``propStartLine`` and ``propFinishLine`` variables.

```lua

-- track the time when the player leaves the start
function OnEndOverlap(trigger, player)
    -- save the server time
    local startTime = time()
end

-- connect to the trigger's EndOverlap event
propStartLine.endOverlapEvent:Connect(OnEndOverlap)

```

### Challenge: Create the Finish Line Functions

The next step is to create a similar event function for the Finish Line. This will look like the code you just created, with a couple of key differences:

- This function will happen as soon as you enter the trigger, so it should be called ``OnBeginOverlap``
- It will make a variable called ``endTime`` that also saves the time
- It will connect to the ``propFinishLine``.
- It uses the **beginOverlapEvent** to connect the function.

Try coding this on your own, and you will be able to check your work in the next step.

### Print the Time At Start and Finish

Before you can test the code, add print statements to both of the functions so that you can see what information they are getting.

```lua
local propStartLine = script:GetCustomProperty("StartLine"):WaitForObject()
local propFinishLine = script:GetCustomProperty("FinishLine"):WaitForObject()

-- track the time when the player leaves the start
function OnEndOverlap(trigger, player)
    -- save the server time
    local startTime = time()
    print(startTime) -- <-- Add this!
end

-- connect to the trigger's End Overlap event
propStartLine.endOverlapEvent:Connect(OnEndOverlap)

-- track the time when the player enters the finish
function OnBeginOverlap(trigger, player)
    -- save the server time
    local endTime = time()
    print(endTime) -- <-- Add this!

end

-- connect to the trigger's Begin Overlap event
propFinishLine.beginOverlapEvent:Connect(OnEndOverlap)
```

### Test the Start and Finish

To test the start and finish, make sure you have the **Event Log** window open, and start a **Preview**.

Make your character run across the start line to the finish. You should see two different decimal values printed in the **Event Log**

![Start Time and Finish Line Printed]()

### Create a Time Data Table

To figure out how much time has passed between start and finish, all you will need to do is subtract the start time from the finish time. **However**, right now, both the ``startTime`` and ``endTime`` variables are created inside of functions, which means you cannot reference them outside of those functions.

To begin fixing this, you will create a player called ``playerTimes`` that can save both of these values in one place.

|  playerData |  |
| --- | --- |
|  "startTime" | 1800.5555 |
|  "stopTime" | 1805.9332 |

Add this to the top of the code to create the table:

```lua
local playerTimes = {}
```

###

### Find the Time Elapsed

- Reveals answer to setup for End Overlap
- Subtracts times to get time ellapsed

## Saving Times for Each Player

Not sure if we should just skip straight to the table or not..?

### Making a Table of Values for the Player

``playerOneTable``

- demonstrate that you can add any key to a table just assigning it
- but you can't do it if the table doesn't exist yet

![Diagram of Table Data with Script References]()

|  playerData |  |
| --- | --- |
|  "startTime" | 1800.5555 |
|  "stopTime" | 1805.9332 |
|  "runTime" | 5.3777 |

### Making a Table of all Player Values

## Display Times to Each Player

### Add The UI element and get Text Box reference

- Drag and Drop from Project Content
- Create a Script
- Drag and Drop each of the three Text areas onto script custom properties

### Create a Function to Change the Current Time

- Create a function called DisplayCurrentTime()
- Have it take a time as an input
- Concats Time with a display Text
- Test Callign it with an empty time: ``0.00``

![UI with Display Time updated]()

<!-- ### Broadcast an Event from the Server Script

### Connect to the Event on the Client Script -->

### Counting Up a Client-Side Timer

- timeStarted boolean and startTime number
- start time function that switches it to true
- stop time function that switches it to false
- Tick function to display time the entire time

### The server-client discrepancy

- Note the difference between the time on screen now, and the time still

## Find Player's Best Time

### Add a property to the Player data table

-- Challenge to try it based on implementation of run time, answers in next step.

### Make a Function to Compare the Time

### Add the Best Time to the UI

- challenge to implement

## Store the Player's Best time

### Enable Player Storage

### Add to Player Storage in Best Time Calculator

### Check Best time On Player Join

### Update Start Time to Zero

    - Task.Spawn to set up a timed reset?

## Create a Leaderboard

### Open Global Leaderboards Window

### Create a New Leaderboard

1. Give it a Name
2. 10 entries is minimum
3. Mark Lower is Better
4. Don't need to worry about daily, weekly, monthly for our purposes.

### Reference the New Leaderboard in Your Script

1. Drag the Leaderboard Reference onto the Script's Custom properties
2. Copy the variable

### Submit a Score to the Leaderboard

### Submit a Player's best score onPlayerJoin

### Display the World Record Score

## What Next

- Nicholas' CC
- Persistent Storage Tutorial
