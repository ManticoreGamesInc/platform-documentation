---
id: editor_intro_new
name: Introduction to the Core Editor
title: Introduction to the Core Editor
categories:
    - Reference
---

# Introduction to the Core Editor

## Creating a New Project

There are three options for starting a new project:

- **New Empty Project** creates a project with just the blank default elements.
- **Core Game Frameworks** include different gameplay functionality built in which can be expanded and customized.
- **Community Shared Games** are projects by Core Creators that have been shared for others to use.

## Editor Windows

The Core Editor is made up of different windows which can be resized and repositioned freely. All of the windows can be opened from the **View** tab in the top menu bar. The Editor layout can be restored to its original form using the **Reset View to Default** option in the **View** menu.

## Main Viewport

The Main Viewport is the window into all visual aspects of a project. It will appear with the name of the project as the title on the Window. 

### Changing the View

- **Tilt** by holding the right mouse button.
- **Zoom** using the scroll wheel.
- **Pan**  by holding the wheel button.
- **Orbit** around a selected object by holding `Alt` and left mouse button
<!-- Need to choose a new style convention or make this a table -->

Alternatively, holding the left mouse button and pressing <kbd>W</kbd>, <kbd>A</kbd>, <kbd>S</kbd>, or <kbd>D</kbd> will move the vantage point forward, left, right, or back. 

### Preview Mode

Preview Mode shows a project from a player perspective, allowing you to run through scenes and test features in person. 

- Press ![Play]() in the Toolbar or <kdb>=</kbd> to start Preview Mode
- <kbd>Tab</kbd> will pause the preview. 
<!-- tip about screenshots? -->
- To exit, press ![Stop](), <kbd>=</kbd>, or <kbd>Esc</kbd>
- **Multiplayer Preview Mode** ![Multiplayer Icon]() can be used to test how your project behaves in a networked context, with more than one player.


## Hierarchy

The Hierarchy shows all the objects that are currently in the project. These objects can be reordered by dragging and dropping. Dragging an object on top of another will make it a **child** of that object. 

**Child objects** are positioned relative to the **parent object** that they are nested under, and can access their parent object's properties in scripts. 

<!-- Don't like "nested under": both too technical and  redundant-->

## Content


### Core Content

The Core Content window contains all the art objects, sounds, textures, and game components that you need to build a game or scene. They can be found both through the different menu categories, as well as through the **Search** function. 

### Community Content

Templates made by other Core Creators to be shared in the community can be found in the Core Content tab.

### Project Content

Objects and scripts that you create will be in this window, as well as those that you import from Community Content. 


## Manipulating Objects

The Toolbar contains the different options for manipulating objects.

- The **Move** button (![Move Tool]() or <kbd>W</kbd>) shows a gizmo with three arrows from the object's current position. Drag any of the arrows to move the object along that axis.
- The **Rotate** button (![Rotate Tool]() or <kbd>E</kbd>) shows a gizmo with three curves. Drag any of these to rotate the object along the direction of the curve. 
- The **Scale** button (![Scale Tool]() or <kbd>W</kbd>) shows a gizmo with arms. Drag any of the arms to change the objects size along that dimension. 
- The **Snap to Grid** tool (![Snap to Grid]() or <kbd>W</kbd>) confin

## Adding Scripts

Scripts allow you to program the behavior of different objects in the project. Core scripts are written in [Lua](https://www.lua.org/manual/5.3/) using the [Core Lua API](https://www.coregames.com/core_api). 

- Use the ![Script]() button to create a Script that will appear in your **Project Content**. Scripts can be dragged onto objects in the Hierarchy that should be their parent. 

### Event Log

The Event Log is not open by default, but can be opened through the **View** menu. This is where output from scripts, including errors, can be found.

## Saving 

The Core Editor will automatically save your work periodically, but this can also be done manually through **File** > **Save** or <kbd>Ctrl</kbd> + <kbd>S</kbd>