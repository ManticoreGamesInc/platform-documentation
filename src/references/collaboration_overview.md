---
id: collaboration_in_core
name: Collaboration in Core
title: Collaboration in Core
tags:
    - Reference
---

# Collaboration in Core

## Introduction

Core is an ecosystem of games with creator tools designed to allow players to jump quickly through many different games. Each game's success helps other games, so the Core community is very collaborative and helpful to new creators, and there are resources within the Core Editor to make collaboration on projects easy.

This document will discuss ways to structure projects to work with a team as collaborators, and detail the tools, in and out of Core, that will let you succeed in creating successful projects with a team.

### You Can Do It All

Teams are a part of traditional game development, but Core also makes it possible for an individual to do every part of a project, from the art to programming to post-publication promotion! Whether you build as an individual or a team is entirely up to you!

### Core Project Files are Saved Locally

All of your Core projects, called **Maps** are files saved on your computer, so they can be zipped and distributed the same way you would any file. Project files are very small, so they are easy to send through e-mail and chat programs, especially when compressed to a ``.zip`` file.

#### Making a Zipped Map

1. Find your Core Maps by opening **Documents** > **My Games** > **Core** > **Saved** > **Maps**
2. Here you will find a folder for each of the Core projects that has been created on your machine.
3. Right-click the folder you want to compress, scroll down to **Send to** and select **Compressed (zipped) folder**.
4. This will create a zipped folder in the same directory, with the same name.

!!! note
    You can always find the directory of your project Map from the Core Editor by clicking **File** > **Show Project in Explorer**.

#### Opening a Zipped Map in Core

1. Find your Core Maps by opening **Documents** > **My Games** > **Core** > **Saved** > **Maps**.
2. Move the **.zip** folder that you want to open into this folder.
3. Right-click the folder and select **Extract all**.
4. Save the extracted folder in the same place, with the same name as the extract file.
5. In the Core Launcher, open the **Create** tab, and you should find a project by the same name there.

## Collaboration with the Core Community

### Using Community-Created Content

Core creators have made a vast array of models, utilities, and even complete games that are freely available for you to use in your own projects. **Community Content** can be imported from within the Core Editor, and allows you to gather assets and utilities in your game, as well as share things you make with other creators. See the [Community Content](community_content.md) reference to learn more about how to import art and utilities made by other creators into your projects.

The **Community Projects** are games made by creators that have been shared so that others can use and remix them. You can share your own games as Community Projects as well. See the [Publishing Guide](publishing.md) to learn more.

1. Open the **Create** menu from the Core Launcher.
2. Select **Community Projects**, instead of a New Empty Project or a Gameplay Framework.
3. Search and select the project that you would like to remix.

These maps can be used as the basis of a new project, or for exporting specific parts of the game as templates to use in another context.

### Getting Support from the Community

The Core Community is, in general, collaborative and frequently producing utilities for others to use in their games. The [Core Hub Discord Server](https://discord.com/invite/core-creators) is the best place to find collaborators, get help on work, and find playtesters for a game project.

The Core Hub **#bountyboard** channel, in particular, is a place where creators can make requests for assets and utilities that would help them make their games, and other creators are free to help each with these challenges.

## Working with Teams

### Project Roles

Games are made using a wide variety of different skills, and one of the greatest benefits of collaborating with a team is allowing each member to focus on a specific skill set. On a Core project, people generally do more than one role, but this list can be used to divide up the work of maintaining a project over time.

### Management

- **Project Managers** keep track of all the work that needs to be done to get the project to the next stage, usually setting deadlines and leading meetings where team members sync up about the current status of their individual tasks.
- **Community Managers** handle social media and communicates with players to keep hype about upcoming updates to a game, and keep track of player feedback.

### Programming

There are many programming challenges involved in making a game, and how you divide them up depends on the size and interests of your team. Programmers can work on the whole structure of a game, creating the **Core Game Loop**, or individual features that can be programmed as packages, like a unique weapon or procedurally generated map.

### Design

- **Game Designers** take a game idea, and develop it into a complete plan, focusing on player progression, defining an **Minimum Viable Product**, and understanding how the artistic vision works together with the player experience.
- **Level Designers** use the tools and pieces that make up a game and creates sequences of play, focusing on balancing and sequencing challenges so that they increase in difficulty but can be learned easily by players.
- **Narrative Designer / Writers** create the underlying story in the game. This can be explicitly told through writing and embedded in the world, or designed and subtly told through clues in the environment.
- **UI Designers** design the interfaces that players will use to get information about the game, like menus, HP bars, or any other essential information that they will need.

### Art

- **Environment Artists** creates the spaces that players move through, often focusing on how the space supports the story created by the Narrative Designer, and the artistic direction defined by the Game Designer.
- **Lighting Artists** create the lighting and post-processing effects that set the mood of the world, with a focus on drawing player attention to the important details and keeping them from being distracted by irrelevant elements.
- **Asset Artists** creates the 3D model templates that are needed both by the Environment Artist, and other parts of gameplay, like tools, weapons, or even tilesets for creating new buildings.
- **Graphic Designers** work with the UI designer to create a consistent aesthetic for the user interfaces, as well as creating the screenshots and title overlays to help promote the game in Core and through social media.

### Useful Tools

#### Discord

The Core Creator Discord is a useful resource, but you can also create your own Discord server for a game development team. This allows you to create channels dedicated to specific topics, to help keep discussions focused and relevant, as well as creating voice channels for teammates to have open conversations and share ideas as work on their screens.

#### Kanban Boards

[Kanban boards](https://en.wikipedia.org/wiki/Kanban_board) are a system of defining needed features in small chunks and tracking them through stages of development, classically with sticky notes on a whiteboard. There are a massive number of online tools that allow you to keep this in a virtual space accessible by all team members, and better track the progress of the development of your game.

- [Trello](https://trello.com/)
- [GitHub Project Boards](https://docs.github.com/en/github/managing-your-work-on-github/about-project-boards)

## Methods of Collaboration

Although it is not possible for creators to be working on the same project in the same space together. This section will detail the different techniques used by Core creators.

### Templates and Community Content

Templates are a way to package things you have created in Core. They can be used to turn a kitbashed model into a spawnable asset, or create several copies of a prop in your game that can be updated all at once. They are also extremely useful for passing assets between games, either by publishing them to community content, or sharing them as files. To learn more about how to do this, see the [template reference](template_reference.md).

### GitHub

**Git** is a system for managing software projects with multiple contributors, and [GitHub](https://github.com/) is just one of many available systems. To learn more about setting up a project on GitHub, see the [GitHub tutorial](github.md)

!!! tip
    Did you know that all of Core Documentation is hosted on GitHub for editing by the Core Creator Community? Click the pencil icon in the top right corner of any page to help improve documentation!

#### Branches

There are many different ways to structure a project's Git branches, but this structure can work as a guideline to set up a project to maintain over multiple publishing cycles.

- **publish**: This branch gets updated when you publish the game, and not updated again until you republish. This way you can always change your project back to match the published version or compare to it to see everything that will change with the next one.
- **main**: This is your main branch. It is the most recent but fully stable version of your game. This is the version you will publish next.
- **feature-name branches**: Every time you or your team mates want to start working on a new feature, make a new branch for each of them, so that you can feel free to experiment with new ideas that might break your project, but without actually breaking it!

#### Folders

The **Tree.pbt** file in your project is a master file that keeps track of all the assets in the project, and the the transforms and properties of all the objects that are in the scene. If two creators move the same object to different locations, git will no longer be able to determine which position an object should be in.

To avoid this problem, the best practice is to create **Folders** in Core that separate the assets. You can use the **Lock** icon when working on a project to ensure no changes to any of the objects in folders that you are not working on.

### Cloud Drives

Because Core maps are fairly small and easy to compress and send, they can easily be shared in cloud drives like [Dropbox](https://www.dropbox.com/), [OneDrive](https://www.microsoft.com/en-us/microsoft-365/onedrive/online-cloud-storage) or [Google Drive](https://drive.google.com/drive). The challenge with this is making sure that creators are always working on the most recent version of the project, as well as not overwriting other people's changes, but for a small team, this can be one of the easiest solutions. Just make sure that you and your partners are not trying to write to the same files at the same time. It is not recommended to have your Core project directory set to a folder inside of a shared cloud drive, and write to it directly from Core, as it is difficult or impossible to guarantee that edits will not collide.

### VSCode Liveshare

Some code editors have an option to create a shared version of program files, that will allow creators to always keep their work synchronized. You can use [VSCode Live Share](https://code.visualstudio.com/blogs/2017/11/15/live-share) to set this up for a project. See the [lesson on setting up Core to use VSCode](https://learn.coregames.com/lessons/setting-up-your-coding-environment/) from the [Core Academy Intro to Lua Course](https://learn.coregames.com/courses/intro-to-lua/) to get started with this option.

## Learn More

[Community Content](community_content.md) | [Template Reference](template_reference.md) | [GitHub Tutorial](github.md) | [Publishing Guide](publishing.md)
