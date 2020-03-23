---
id: publishing_checklist
name: Publishing Checklist
title: Publishing Checklist
tags:
    - Reference
---

<style>
article ul li{
  list-style-type:none;
}
article ul li:before {
    content:'🗹 ';
}
</style>

# Publishing Checklist

> When deciding whether to publish a game, the question is not *is this game finished* but *is this game ready to be tested by the supportive strangers of the Core Creator community?*

If you are ready to jump in and [publish your game](publishing.md) right away, these are the minium questions you should consider.

1. Will players understand how to play and what the goals are?
2. Does the game have an ending, and will players have a reason to play again?
3. Does everything work, look, and sound the way you expect?
4. Have you tested the game in **Multiplayer Preview Mode**
5. Do the description and screenshots help players find the game and understand what it is?

The goal of this checklist is to outline the essentials that you should check before you publish, then give you areas to continually check as you revise and republish your game. Not everything in this list will apply to all the possible Core creations, and there will more to consider based on the unique aspects of your design.

## Reading the Checklist

| Key |
|---|
| **Bold items are for the first time you publish a game.** |
| Normal items are for continuing to improve. |
| *Italic items are for a complete, polished game.* |

## Game Design

### Game Cycles

- **The game has an ending.**
- The game restarts at the end of a round.
- The game has a way to win
- The game has a way to lose.
- Players can tell if they won or lost.
- *There is content to give players closure at the end.*

### Progress and Improvement

- **Players have a way of knowing how they did in the game.**
- **There is a way for players to improve if they play again.**
- Players can compare their performances to other players.
- Players can test different methods and see if they improve performance throughout the game.
- *Players can see a comparison of their performance over time.*
- *There are rewards to distinguish top players.*

## Gameplay

### Player Abilities

- **Players have all the abilities they need to play when they connect to the game.**
- Items that need to be picked up can be picked up.
- Special player abilities are enabled or disabled at the correct times.
- Players can or can not fly.
- Players can or can not swim.
- Players can or can not ride a mount.
- *The game shows players what they should be able to do in an intuitive way.*
- *Players can choose an alternative way to do extremely challenging movements.*

### Map

- **Players can access every space they need to play the game**
- **Players cannot go places that are not part of the game.**
- **There are no parts of the map where players can accidentally get trapped.**
- Players can clearly distinguish where they are able to go.
- *Different areas of the map offer different experiences.*
- *Places players cannot go still look interesting and support the feeling of the game*

## Multiplayer and Networking

### General Multiplayer

- **The game has been tested using Multiplayer Preview Mode**
- The game has been tested with different numbers of players.
- The maximum number of allowed players can all play the game together easily.
- *The maximum and minimum number or players are adjusted based on how many people are usually playing to allow games as often as possible.*

### Teams

- **Players are divided evenly into teams.**
- **Players can tell what team they are on.**
- Players can tell which points on the map are assigned to each team.
- *Score and User Interface information quickly identify the relevant team.*

### Networking

- **Objects with associated scripts are networked.**
- **Props and scenery that do not have interaction are not networked.**
- Objects that players can interact with regardless of other players are in the **client context**.
- Objects that can be interacted with by players in a way that affects other players are in the **server context**.

## User Interface

### Gameplay Information

- **Players can see the goals of the game from the interface.**
- Players can see the current status of the game.
- Players can tell who each other are, using **nameplates** or other game-specific labels.

### Tutorial

- Players can read about how to play the game.
- *Players can refer back to tutorial information throughout the game.*
- *There are hints for players who get stuck.*

### Accessibility

- **Important information is given to players in more than one way.**
- When colors are used to distinguish game elements, the colors have a different brightness.
- Audio elements are supported with visual elements, and visual elements also have audio elements.
- Text is big enough to read during gameplay.
- There is enough contrast between text and the background to read it.

## Visuals and Audio

### Lighting

- **The lighting allows players to see all the important elements of the game.**
- The lighting draws players' attention to important parts of the game.
- The lighting supports the mood of the game.

### Visual Effects

- **Visual effects are working as expected.**
- The visual effects make gameplay easier to understand.
- There are no visual effects that are confusing or distracting except by design.

### Audio

- **Audio works and is not too soft or too loud.**
- Audio helps players understand what is happening.
- Audio supports the feel of the game.

## Project Organization

### Heirarchy

- Objects are renamed so that they are easy to search for later.
- Basic shapes are grouped into the objects they make up.
- Parts of the game are organized into folders.

### Code

- Code follows the [Lua Style Guide](../tutorials/gameplay/lua_style_guide.md).

## Creativity

### Uniqueness

- **The game is different from a basic framework.**
- The game is different from other games by Core Creators.

### Attribution

- Other Core Creators who helped with the project are mentioned in the description.
- Creators of content that was essential to the game can also be credited.

## Preview

### Description

- **The summary gives players a clear idea of what the game will be like.**
- The summary gives players an idea about what is unique or unusual about the game.
- The summary matches the tone of the game.

### Screenshots

- **The screenshots give a clear picture of what the game is like**
- Screenshots hide the game's User Interface.
- Screenshots capture the visual variety of the game.
- Screenshots tell a story.
- The first screenshot has a custom title logo.

## Promotion

- **Announce your game on the Core Creator Hub Discord server in the Showcase channel**
- Share your game on social media channels.
- Make videos or hold livestreams showcasing the game and its features.
- Develop a way of gathering and saving feedback from users who test the game.
- *Share major updates and patches as the game evolves.*

## Publish

With all these considerations in mind, [publish](publishing.md) your game, and get ready to watch new users play in new and unexpected ways.

## Learn More

[Publishing on Core](publishing.md) | [Sharing Content](community_content.md) | [UI Reference](ui_reference.md) | [Lua Style Guide](lua_style_guide) | [Collaboration with other Core Creators](collaboration_reference.md)