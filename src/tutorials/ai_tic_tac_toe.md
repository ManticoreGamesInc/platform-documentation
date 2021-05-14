---
id: ai_tic_tac_toe
name: AI in Core (Tic Tac Toe)
title: AI in Core (Tic Tac Toe)
tags:
    - Tutorial
---

# AI in Core (Tic Tac Toe)

## Overview

The **AI Activity System** is a way to define different activities that an AI can do and then control which activity is chosen by increasing and decreasing the priorities of each activity. The highest priority activity acts and the rest wait for their priority to increase.

**AI Activity Systems** can be built to create independent AI, like a turret that searches for a target and shoots at it after one is found or to control game flow, such as a manager that monitors resources and combat conditions to deploy workers and combat troops in an RTS.

- Completion Time: TBD
- Knowledge Level: Basic Lua Understanding
- Skills you will learn:
    - Adding AI Activity Handlers to your level
    - How to add activities
    - How to control priorities of activities
    - How to setup different functions for when an Activity is active

## Adding the Template to Your Project

Setting up an **AI Activity System** only takes a few steps. We’ll go over how to setup activities that create an AI to play tic tac toe with.

First, let’s create a new level and download the basic game logic. Then we’ll add an AI activity system to make the AI work.

The template contains:

- 9 Triggers (with supporting artwork) in a 3x3 grid.
- GameManager: a script containing the game state API initialization, testing for end of game, the current player’s turn capturing a board position, with validation, world location of each board position
- AI TicTacToe Strategy: a script with helper functions to: test the board for either a win or block choose which board position might be strategically best.

!!! note
    This tutorial is not about the game of Tic Tac Toe itself, but how to add an AI entity to use the game state and strategy API, as a live opponent.

### Download the Template

1. Open the **Community Content** window in the Core Editor.
2. Use the search bar to search for **TicTacToe Game** *(by !!NO IDEA WHO MADE IT YET!!)*
3. Click **Import** to download the template.

### Open the Template

1. In the **Core Content** window, find the **Imported Content** section and then find **TicTacToe Game** ![Package](../img/EditorManual/icons/AssetType_Bundle.png){: style="height:34px" }.
{ .image-inline-text .image-background }
2. Double-click the ![Package](../img/EditorManual/icons/AssetType_Bundle.png){: style="height:34px" } icon to open it. You should now see the green ![Template](../img/EditorManual/icons/TemplateIcon.png){: style="height:34px" } icon.
{ .image-inline-text .image-background }
3. Hold left-click on the **TicTacToe Game** package icon and drag it into your project by either dragging it into the **Main Viewport** somewhere in your world or by dragging it into your **Hierarchy**.
4. Change the position of the template and its components where you want it using the transform tools in the top toolbar. To learn more about moving objects, check out the [Intro to the Editor](editor_intro.md) tutorial.

!!! note
    It is important that the entire template does no overlap the **Spawn Point** to ensure all the triggers detect properly.

## Creating an AI Activity Handler

1. Deinstance the **TicTacToe Game** template
2. Right-click on the template and choose **Create...** -> **Create Gameplay Object** -> **Create AI Activity Handler**
3. Right-click on the **AI Activity Handler** you just created, and choose **Create...** -> **Create Script** -> **Create New Script**
4. Name the script whatever you want; we will be using `AI_TicTacToe`
5. Double-click your new script to edit it.

!!! note
    You can also drag an AI Activity Handler into the scene from the **Gameplay Objects** category in the **Core Content** window.
