---
id: editor_intro
name: Introduction to the Core Editor
title: Introduction to the Core Editor
tags:
    - Reference
---

# Introduction to the Core Editor

![YOUTUBE](../assets/placeholder_720p.png "TKOtPN9ujEE")
{: .video-container }

## Creating a New Project

There are three options for starting a new project:

- **New Empty Project** creates a project with just the blank default elements.
- **Core Game Frameworks** include complete gameplay functionality to modify and customize.
- **Community Shared Games** are games by Core Creators that have been shared for others to customize or change completely.

## Editor Windows

The Core Editor is made up of different windows which can be resized and repositioned freely. All of the windows can be opened from the **Window** tab in the top menu bar. The Editor layout can be restored to its original form using the **Reset View to Default** option in the **Window** menu.

## Main Viewport

The Main Viewport is the window into all visual aspects of a project. It will appear with the name of the project as the title on the Window.

### Changing the View

- Hold the **right mouse button** to change the direction the view is facing.
    - ++W++, ++A++, ++S++, and ++D++ will move view position forward, left, right, and back.
    - ++Alt++ will orbit around a selected object.
- Use the **scroll wheel** to move the view closer or further away.
- Hold the **wheel button**  to slide the view left, right, up, or down.
- Press ++F++ with an object selected to move the view to focus on that object.

### Preview Mode

Preview Mode shows a project from a player perspective, allowing you to run through scenes and test features in person.

- ![Play](../img/EditorManual/icons/Icon_Play.png) or ++equal++ will start Preview Mode.
{: .image-inline-text .image-background}
- ++tab++ will pause the preview.
- ![Stop](../img/EditorManual/icons/Icon_Stop.png) or ++equal++ to stop the preview.
 {: .image-inline-text .image-background}

### Multiplayer Preview Mode

**Multiplayer Preview Mode** can be used to test how your project behaves in a networked context, with more than one player.

- ![Multiplayer Preview Mode](../img/EditorManual/icons/Icon_MultiplayerTest.png) to switch the Preview Mode to Multiplayer.
    {: .image-inline-text .image-background}
- Use the dropdown menu to select the number of players to test.
- ![Play](../img/EditorManual/icons/Icon_Play.png) will start the preview. This will open a separate game window for each player.
{: .image-inline-text .image-background}
- ![Stop](../img/EditorManual/icons/Icon_Stop.png) will end the preview and close all windows
{: .image-inline-text .image-background}

!!! tip
    **Multiplayer Preview Mode** is always the most accurate way to see how your game will appear over a network. You should use it often to test how your game.

## Hierarchy

The Hierarchy shows all the objects that are currently in the project. These objects can be reordered by dragging and dropping. Dragging an object on top of another will make it a **child** of that object.

**Child objects** are positioned relative to location in the scene of the **parent object** that they are nested under, and can access their parent object's properties in scripts.

## Content

### Core Content

The Core Content window contains all the art objects, sounds, textures, and game components that you need to build a game or scene. They can be found both through the different menu categories, as well as through the **Search** function.

### Community Content

Templates made by other Core Creators to be shared in the community can be found in the Core Content tab.

### Project Content

Objects and scripts that you create will be in this window, as well as those that you import from Community Content.

## Manipulating Objects

The Toolbar contains the different options for manipulating objects.

- ![Transform Position](../img/EditorManual/icons/Icon_TransformPosition.png )
 or ++W++ to **Transform Position**. It will show three arrows from the object's current position. Drag any of the arrows to move the object along that axis.
{: .image-inline-text .image-background}
- ![Snap Position](../img/EditorManual/icons/Icon_SnapPosition.png) or ++G++ to **Snap Position**. It will move the object in whole steps according to the selected size.
 {: .image-inline-text .image-background}
- ![Rotate Tool](../img/EditorManual/icons/Icon_TransformRotation.png)  or ++E++ to **Transform Rotation**. It will show three curves. Drag any of these to rotate the object along the direction of the curve.
 {: .image-inline-text .image-background}
- ![Snap Rotation](../img/EditorManual/icons/Icon_SnapRotation.png) or ++G++ to **Snap Rotation**, rotating the object in the selected degree interval.
{: .image-inline-text .image-background}
- ![Scale Tool](../img/EditorManual/icons/Icon_TransformScale.png) or ++R++ to **Transform Scale**. It will show three arms with cubes at the ends from the object's center. Drag any of the cubes to change the objects size along that dimension, or select the center cube to scale the entire object in proportion.
 {: .image-inline-text .image-background}
- ![Snap Scale](../img/EditorManual/icons/Icon_SnapScale.png) or ++G++ to **Transform Scale**. It will resize the object in whole units according to the selected size.
{: .image-inline-text .image-background}

!!! note
    All of the **Snap** tools appear in the same location, to the right of the Transform Tools. This icon will change appearance and function depending on which Transform Tool is selected, and can always be turned on with ++G++.

## Adding Scripts

Scripts allow you to program the behavior of different objects in the project. Core scripts are written in [Lua](https://www.lua.org/manual/5.3/) using the [Core Lua API](../api/index.md).

- ![Script](../img/EditorManual/icons/Icon_Script.png) will create a script that will appear in your **Project Content**.
{: .image-inline-text .image-background}
- Scripts can be dragged directly into the Hierarchy or onto objects that should be their parent.

### Event Log

The Event Log is where output from scripts, including errors, can be found. It is not open by default, but can be opened through the **Window** menu.

## Saving the Project

The Core Editor will automatically save your work periodically, but this can also be done manually through **File** > **Save** or ++ctrl+S++.

## Learn More

[Your First Game](my_first_multiplayer_game.md) | [Core Editor Keyboard Shortcuts](editor_keybindings.md)
