---
id: scripting_intermediate
name: Scripting in Core (Intermediate)
title: Scripting in Core (Intermediate)
tags:
    - Tutorial
---

# Lua Scripting Tutorial, Part 2

## Overview

In this tutorial, you will learn how to take an existing template created by another community member in Core and create a script that alters the template to perform an action upon player interaction. Hello jce!

Together, we will create something that brightens every room: a light switch!

When a player presses ++F++ while near the light switch, it will flip and either turn on or off the light. It will simulate an electric current to the bulb.

![Light Switch And Bulb](../img/LightBulb/updates/LightbulbMain.jpg){: .image-frame .center loading="lazy" }

---

## Setting Up the Template

### Download the Template

1. Open the **Community Content** window in the Core Editor.
2. In the search bar of the window, search `switch` and find **Lightbulb & Switch** by ***CoreAcademy***.
3. Click **Import** to download the template into your project.

![Lightbulb and Switch on Community Content](../img/LightBulb/updates/CCLightbulb.png){: .image-frame .center loading="lazy" }

### Open the Template

1. In the **Core Content** window, find the **Imported Content** section then find **Light Bulb & Switch** ![Package](../img/EditorManual/icons/AssetType_Bundle.png){: style="height:34px" }.
{ .image-inline-text .image-background }
2. Double-click the ![Package](../img/EditorManual/icons/AssetType_Bundle.png){: style="height:34px" } icon to open it. You should now see the green ![Template](../img/EditorManual/icons/TemplateIcon.png){: style="height:34px" } icon.
{ .image-inline-text .image-background }

![Open Light Switch Template](../img/LightBulb/updates/LuaLightbulb_OpenLightSwitchTemplate.png){: .image-frame .center loading="lazy" }

1. Click on the **Light Bulb & Switch** package and drag it into your game by dragging it into the **Main Viewport**.
2. Make sure **Group Selection Mode** is turned on to select the entire template. You can use the ++C++ key to switch between this and **Object Selection Mode**.
3. Reposition the wall and lightbulb where you want it using the transform tools in the top toolbar. To learn more about moving objects, check out the [Intro to the Editor](editor_intro.md).

![Well lit](../img/LightBulb/image6.png){: .image-frame .center loading="lazy" }

!!! note
    If you click on the wall, or part of the scene, this will not select the entire template. Click the **Lightbulb and Switch** folder in the **Hierarchy** to move, resize, or rotate it.

---

## Learn More

[Scripting in Core](scripting_intro.md) | [Core API](../api/index.md) | [Intro to Lua Course](https://learn.coregames.com/courses/intro-to-lua/)
