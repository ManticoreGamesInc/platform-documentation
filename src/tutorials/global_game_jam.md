---
id: global_game_jam
name: Core for Global Game Jam
title: Learn Core for Global Game Jam
tags:
    - Reference
---

# Learn Core for Global Game Jam

## Welcome to Core

<lite-youtube videoid="fL6HMs9frgw" playlabel="GGJ Online (2021) Keynote and Theme Reveal Video"></lite-youtube>
{: .video-container }

Welcome Global Game Jammers!

Core is a complete game development, publishing, and multiplayer hosting platform that combines ease of use with professional polish. In this document, you will find an essential outline of the systems in Core and directions to the tutorials and tools that will get you creating right away.

This year, Manticore Games sponsored a [Global Game Jam Diversifier](https://globalgamejam.org/news/ggj-online-diversifiers) to make a game in Core that incorporates Community Content by another Global Game Jammer. Here you can learn where to start, what Community Content is, and all the ways you can leverage Core to quickly iterate through your game idea.

### Coming from Other Platforms

This documentation has a collection of introductions intended to specifically orient creators coming from game engines, like [Unity](unity.md), and other User Generated Content platforms, like [Roblox](roblox.md) and [Fortnite](fortnite_creative.md).

!!! note
    If you have experience from an engine or platform that is not included here you can submit a pull request or create an issue on the [Core Documentation GitHub](https://github.com/ManticoreGamesInc/platform-documentation) to share your knowledge!

### Collaboration

Core games are locally stored files, and collaboration within games usually happens with [GitHub](github.md). The template system and Community Content system are another way for creators to build pieces to integrate into projects.

## Building with Frameworks

Core Frameworks allow you to start a project with functioning game logic, and to focus on the level design and world-building aspects. These tutorials will walk you through a few of the available game types.

- [Deathmatch](my_first_multiplayer_game.md)
- [Dungeon](first_game_rpg.md)

### Community Open Games

Beyond Core Frameworks, there are hundreds of Community Games that have been marked "Open for Editing" by their creators that can be used as a base. A few examples are listed below:

![Community Games](../img/GGJ/GGJ_CommunityGames.png){: .center loading="lazy" }

- The [Survival Jam Kit](survival_kit.md) was created for a previous game jam, and includes features like inventory and crafting systems, as well as thorough documentation and a [tutorial](survival_tutorial.md).

- Most games made by [Manticore Games](https://www.coregames.com/user/37edf67a267b45bd8b93be513218b428) and by [Core's Team META](https://www.coregames.com/user/901b7628983c4c8db4282f24afeda57a) are open for editing. These can be more complex to use and tackle, but also exemplify some of the more challenging genres to create in Core.

- **Tower of Terror** is an obstacle course game where players leap up a tower with randomized levels that get progressively harder, made by [NicholasForeman](https://medium.com/core-games/climbing-the-tower-90f9429f73e5). It is an excellent example of how to spawn distinct levels using the template system.

- **Murder Mansion** by [standardcombo](https://www.coregames.com/user/b4c6e32137e54571814b5e8f27aa2fcd) is a betrayal game set in an ominous mansion where players collect clues to survive attack by a randomly-assigned murderer. You can use it as a framework for a hidden identity game, or just use the mansion environment, as seen in games like [Spider Bite](https://www.coregames.com/games/bb231b/spider-bite).

- **Tycoon Framework** created by [Aphrim](https://medium.com/core-games/a-rising-star-4db15f8709f4), the Tycoon Framework is the basis of several successful Core games where economic prosperity is the goal.

- **Race to the Finish Template** or **Mount Racer - Test Track** by [WaveParadigm](https://medium.com/core-games/know-when-to-roll-em-6a71a0d3be1b) provide the basic architecture of a racing game, including one that uses player's custom mounts found in the Core **My Collection** menu.

## Core Fundamentals

### Abilities

[Abilities](abilities.md) are the primary way to make player interactions and animations. They have several different phase events and can return data about where the player was targeting when used. You can also find a complete list of the available [Animations and Animation Stances](../api/animations.md).

### Terrain

The Terrain system in Core allows you to generate terrain from height maps or sculpt terrain from the ground up, and includes the ability to paint with materials and generate foliage.

### Modeling

Creating [Art in Core](art_reference.md) is done primarily through **kitbashing**. There are no imports, so new models are created using the primitives in Core. After that, structures like **Groups** and **Templates** allow you to treat these as a single object.

### Weapons

[Weapons](weapons.md) in Core can be used for a variety of tools, and allow you to spawn VFX and audio templates, VFX trails, projectiles, and decals for where those projectiles impact. There are a number of weapons templates in **Core Content** and even more custom weapons available on **Community Content**.

### Core Components

![Game Components](../img/GGJ/GGJ_GameComponents.png){: .center loading="lazy" }

The [Game Components](../api/components.md) found in **Core Content** include lots of completely coded systems to bring more functionality to your game, including scoreboards, nameplates for players, and resource pickups.

### Lua

Core uses a Lua API to script games. While it is possible to build games entirely using all the components made by Core and other Core creators, being able to read and write some scripts is extremely useful for building unique experiences.

- [The Lua Lightbulb Tutorial](lua_basics_lightbulb.md) is a complete tutorial that introduces Lua, and the way scripts and objects interact in Core.
- [The Lua Style Guide](lua_style_guide.md) will give a more experienced coder a quick overview of how lua is implemented in Core.

There are also a number of videos currently available on the [CoreGames YouTube Channel](https://www.youtube.com/channel/UCBPqo7cK1bktfRfMGAAqnbQ) which can show how to tackle challenges at any experience level.

## Community Content

[**Community Content**](../getting_started/community_content.md) is a massive collection of props, scripts, costumes, weapons, and complete game systems created and shared by creators for others to use. Core is designed to easily incorporate these different pieces into games, and facilitates easy collaboration between artists and programmers through the [Template](template_reference.md) system.

![Instruments on Community Content](../img/GGJ/GGJ_CommunityContentInstruments.png){: .center loading="lazy" }

### Example: Building a Bustling Town with Virtually No Scripting

One example of how you can use Community Content is for creating an area full of NPCs that can be interacted with or are just going about their business. There are two components of Community Content that can allow you to build this:

- **Choreographer by Chris** allows you to drag scripts into folders to create sequences of animations that can loop and trigger events.
- **Dialogue System with NPCs by Hani** created for the CoreHaven game by ManticoreGames, this robust dialogue system will allow you to create dialogues with animations and attach them to NPCs. Find the script called **DialogsLibrary_Conversations** to follow the format of the example conversation and build your own.

### Other Key Community Content

- The **NPC AI Kit by standardcombo** is the most downloaded Community Content template, and the most popular way of creating enemy NPCs which can spawn when players are nearby, pursue players across NavMesh areas defined by visible plains, and take and give damage in combat.
    - A related and equally useful tool is the **NPC Costume Script by standardcombo**, that allows you to create customized NPCs by attaching objects to their sockets. The chicken in [Farmer's Market](https://www.coregames.com/games/67442e/farmers-market), for example, was actually made by connecting objects to the Raptor Animated Mesh.

    ![Chicken in Farmer's Market](../img/GGJ/GGJ_FarmersMarketChicken.png){: .center loading="lazy" }

- **EaseUI & Ease3D by NicholasForeman** are a library of Easing Functions that can be applied to create smooth movement clientside for 2D UI elements and 3D objects.
- **Team META** has created a collection of useful creator tools, from leaderboards to inventory systems to victory screens.

    ![Team META on Community Content](../img/GGJ/GGJ_METACC.png){: .center loading="lazy" }

- **Day Night Sky by Rasm** will allow you to add a day-night cycle to your project with no extra effort, adding life and polish to a project instantly.

- **Universal Object Spawner by standardcombo** will allow you to continually spawn copies of objects, so players never run out of a resource, equipment, or weapon.
