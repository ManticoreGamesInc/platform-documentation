---
id: merged_models
name: Merged Models
title: Merged Models
tags:
    - Reference
---

# Merged Models

> Improve your game's performance by reducing the total number of non-networked objects!

!!! warning
    Merged models are a new feature that almost always improve game performance, but  there are even more improvements and refinements to this process coming in the future!

## Overview

**Merged Models** improve performance of a game by decreasing the time it takes to render a scene each frame. They do this through a process called **mesh merging**, which calculates which parts of a collection of objects are necessary to track for collision, and sends that data to the server.

## How Merged Models Improve Performance

<!-- A game's framerate (FPS) is determined by whichever of three threads takes the longest: the game thread, the rendering thread, and the graphics. In almost all Core games, the **rendering thread** is slowest, and responsible for taking game data and sending it to the graphics processor. -->

Merged models allow Core to run a process when your game first loads to simplify a Merged Model into just the sides that a player might collide with and sends that data to the server.

The graphics processor then visually renders the Merged Model entirely, instead of waiting on calculations for each object on whether or not they are close enough to a player to be rendered.

Once the game has loaded, the objects inside of a merged model are removed from the Hierarchy, and not counted in the total number non-networked objects in the game.

## Choosing Which Models to Merge

As mesh merging improves, games will improve performance just by putting groups into merge models. Merged Models inside of other merged models will just be merged into the outermost layer, so in general, **it is a good idea to put groups of objects into Merged Models as you work.**

!!! warning
    Currently, some special effects materials do not behave the same may when merged, so you may want to separate them from your Merged Model.

### Screen-Sized Chunks

Because Merged Models are sent as a whole to be rendered by the graphics processor, so the most ideal use would not have lots of objects that are very spaced apart in a single Merged Model.

The perfect size for a merged model would be the size of what fits on the player's screen. Depending on the world and scale, this is most likely about **the size of a single large building**.

In general, you can determine the size of your screen-sized chunk, and then develop a grid of about that scale to group objects into Merge Models. **Even if chunks are larger or smaller than what someone can see at a time, using Merged Models will still improve performance.**

### Only Default Context

Because Merged Models are only for non-networked objects, there are a number of objects in your game that they will not work with.

Objects in the **Client Context** do not have collision, and therefore do not have collision information to calculate. **Networked** objects can change through a game and need to be continuously tracked by the server and client, so also cannot be part of a Merged Model.

If a networked or client-side object is added to a merge model, it will be ignored in the merging process, and should still work normally.

Objects with different settings in the **Rendering** section, like **Disable Receiving Decals** or **Disable Casting Shadows** will also be excluded from the merge group to preserve their special properties.

### Aggressive Merge

The **Aggressive Merge** option is available as a checkbox in the **Properties** window of a Merged Model. It will remove custom rendering properties and disable networking on objects inside of the merge model instead of ignoring them.

To use Aggressive Merge, remove all networked and objects with custom rendering settings that you want to preserve from the Merged Model.

## Creating a Merged Model

Merged Models are created using the same method as groups and folders:

### Create an Empty Merged Model

1. Right click in the **Hierarchy**.
2. Select **New Merged Model**.

### Place Groups and Objects into a Merged Model

1. Select all the objects in the **Hierarchy**.
2. Right-click and select **New Model Containing This**.

---

## Learn More

[Modeling in Core](modeling.md) | [Network Contexts](networking.md)
