---
id: fortnitecreative
name: Coming to Core from Fortnite Creative
title: Coming to Core from Fortnite Creative
tags:
    - Reference
---

# Coming to Core from Fortnite Creative

## Overview

Core is a complete game development and publishing platform that keeps the benefit of having thousands of assets at your fingertips while giving you more freedom to build customized and unique game experiences.

- For a general introduction to creating with Core, see [Intro to the Core Editor](editor_intro.md).
- For a complete technical overview, see the [Core API Documentation](../api/index.md).

### Editor and Preview

Games are built in the **Core Editor**, a workspace that allows you to see both the organization of your project in the **Hierarchy**, and to see what the actual scene you are building looks like, in the **Main Viewport**. When you are editing a game you can move freely through the space with right click and the ++W++ ++A++ ++S++ ++D++ keys, but you will only have a character and be able to walk around the space when you start a **Preview**.

**Preview** mode allows you to press **Play** and experience the space with your Core character to see the game logic in action. This also includes a **Multiplayer Preview Mode** that will allow you to start multiple instances of the game and play them each individually as a character.

### Creating Props

Core comes with a huge number of built in assets that can be used in creating your game, from small props to complete themed tilesets that allow you to build the walls, floors, and complete spaces. You can find all the assets that are included with core in the **Core Content** window.

Every asset can be customized by resizing, rotating, and all of the **Materials** can be replaced with dramatically different textures, including animated special effects textures. You can find all the base materials in the **Materials** section of **Core Content**.

The technique used in Core to create your own props and models is called [**kitbashing**](art.md), and essentially involves grouping the existing Core models together so that they can be treated as a single object. You can create a new type of asset to create copies or spawn in game by turning a group into a **Template**.

One of the biggest advantages of using **Templates** is that they can be easily shared with other creators, and there is a huge collection of shared templates available which you can find in the **Community Content** window.

### Terrain

Core has a fully editable terrain system that will allow you to sculpt and paint terrain, as well as import it from height maps. Use the **Terrain** button at the top of the Editor to generate a terrain based on some preset height maps, and then sculpt it to fit your game. Check out the [terrain tutorial](https://www.youtube.com/watch?v=KFYlOzx7wm0) video series to see it in action!

### Game Components and Devices

Core also has drag-and-drop components that will create logic for your game, like round timers and scoreboards. These can be found in the **Game Components** section of **Core Content**, and creators have made their own in **Community Content**, like the NPC AI kit.

Some of the familiar components that you will find are **spawn points**, **teleporters**, **kill zones**, and portals to transport players to other games.

#### Triggers

**Triggers** are an extremely useful Core object with a variety of in-game uses. In Core these are invisible objects (you can press ++V++ to change whether they are visible in the Editor, that are cubes by default, but can also be changed to sphere or capsule shape. Triggers allow you to write scripts for what happens when a player enters the area, leaves the area, and if the trigger is **interactable**, you can also design a label to pop up for players to press a key and trigger code.

For the best introduction to scripting and using triggers in Core, try out our [Lightbulb Tutorial](lua_basics_lightbulb.md).

### Scripting

**Scripting** in **Lua** is one of the biggest differences in Core from Fortnite Creative. It is entirely possible to build games without scripts, especially using the **Core Game Frameworks**, which will allow you to build anything from a team shooter to an RPG.

Scripts allow you to fully customize your gameplay logic, allowing infinite possibilities for different games. The [Core API](../api/index.md) creates programming names that you can use to reference Core objects and script their behavior.

To get started programming, check out any of these resources:

- [Learn Lua quickly with no coding experience necessary - YouTube](https://www.youtube.com/watch?v=TAjh6AXLk-Y&t=119s)
- [Scripting Introduction](scripting_intro.md)
- [Intro to Lua Course on Core Academy](https://learn.coregames.com/courses/intro-to-lua/)

#### Events and Channels

The primary way that scripts can start behavior around your game is through **Events**. These are similar to Channels because they pass a signal through the game. Some of the events are built in, like when players join the game, but you can also create events, which are given names rather than numbers, and there is not a fixed limit of how many of these events you can have.

### Collaboration

Some of the best games in Core are made by teams, but the collaboration style is a bit different from Fornite Creative because creators cannot actually work in the same space at the same time. The easiest way to collaborate on games is to have one creator make [Templates](templates.md) that can be imported into the main project.

You can also use **version control** tools like GitHub. See the [complete guide to setting up GitHub desktop with Core](github.md) to learn more.

To learn about creating teams and organizing projects, see the [Core Collaboration Guide](collaboration.md).

## Terminology

|  **Fortnite Creative** | **Core** |
| :--- | :--- |
|  **Galleries** | **Core Content** |
|  **Wall Gallery/Floor Gallery** | **Tile Sets** |
|  **Your Island** | **Core Editor** |
|  **Hotbar** | **My Project Content** |
|  **Start Game** | **Preview** |
|  **Spawn Pad** | **Spawn Point** |
|  **Device** | **Game Component** |
|  **Channel** | **Event** |

## Learn More

### FNC Videos

<lite-youtube videoid="99gf9fuLAFI" playlabel="TILTED TOWERS RETURNS.... IN CORE?!"></lite-youtube>
{: .video-container }

### Recommended Tutorials

- [Scripting Tutorial](lua_basics_lightbulb.md)
- [Abilities Tutorial](ability_tutorial.md)

### References

[Modeling Props](art.md) | [Templates](templates.md) | [Core Collaboration Guide](collaboration.md) | [Core API](../api/index.md)
