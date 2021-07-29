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
</style>

# Publishing Checklist

> When deciding whether to publish a game, the question is not *is this game finished* but *is this game ready to be tested by the supportive members of the Core Creator community?*

If you are ready to jump in and [publish your game](publishing.md) right away, these are the minimum questions you should consider.

1. Will players understand how to play and what the goals are?
2. Does the game have an ending, and will players have a reason to play again?
3. Does everything work, look, and sound the way you expect?
4. Have you tested the game in **Multiplayer Preview Mode**
5. Do the description and screenshots help players find the game and understand what it is?

The goal of this checklist is to outline the essentials that you should check before you publish, then give you areas to continually check as you revise and republish your game. Not everything in this list will apply to all the possible Core creations, and there will be more to consider based on the unique aspects of your design.

## Reading the Checklist

| Key |
|---|
| **Bold items are for the first time you publish a game.** |
| Normal items are for continuing to improve. |
| *Italic items are for a complete, polished game.* |

## Game Design

### Game Cycles

- [x] **The game has an ending.**
- [x] The game restarts at the end of a round.
- [x] The game has a way to win
- [x] The game has a way to lose.
- [x] Players can tell if they won or lost.
- [x] *There is content to give players closure at the end.*

### Progress and Improvement

- [x] **Players have a way of knowing how they did in the game.**
- [x] **There is a way for players to improve if they play again.**
- [x] Players can compare their performances to other players.
- [x] Players can test different methods and see if they improve performance throughout the game.
- [x] *Players can see a comparison of their performance over time.*
- [x] *There are rewards to distinguish top players.*

## Gameplay

### Player Abilities

- [x] **Players have all the abilities they need to play when they connect to the game.**
- [x] Items that need to be picked up can be picked up.
- [x] Special player abilities are enabled or disabled at the correct times.
- [x] Players can or can not fly.
- [x] Players can or can not swim.
- [x] Players can or can not ride a mount.
- [x] *The game shows players what they should be able to do in an intuitive way.*
- [x] *Players can choose an alternative way to do extremely challenging movements.*

### Map

- [x] **Players can access every space they need to play the game**
- [x] **Players cannot go places that are not part of the game.**
- [x] **There are no parts of the map where players can accidentally get trapped.**
- [x] Players can clearly distinguish where they are able to go.
- [x] *Different areas of the map offer different experiences.*
- [x] *Places players cannot go still look interesting and support the feeling of the game*

## Multiplayer and Networking

### General Multiplayer

- [x] **The game has been tested using Multiplayer Preview Mode**
- [x] The game has been tested with different numbers of players.
- [x] The maximum number of allowed players can all play the game together easily.
- [x] *The maximum and minimum number or players are adjusted based on how many people are usually playing to allow games as often as possible.*

### Teams

- [x] **Players are divided evenly into teams.**
- [x] **Players can tell what team they are on.**
- [x] Players can tell which points on the map are assigned to each team.
- [x] *Score and User Interface information quickly identify the relevant team.*

### Networking

- [x] **Objects with associated scripts are networked.**
- [x] **Props and scenery that do not have interaction are not networked.**
- [x] Objects that players can interact with regardless of other players are in the **client context**.
- [x] Objects that can be interacted with by players in a way that affects other players are in the **server context**.

## User Interface

### Gameplay Information

- [x] **Players can see the goals of the game from the interface.**
- [x] Players can see the current status of the game.
- [x] Players can tell who each other are, using **nameplates** or other game-specific labels.

### Tutorial

- [x] Players can read about how to play the game.
- [x] *Players can refer back to tutorial information throughout the game.*
- [x] *There are hints for players who get stuck.*

### Accessibility

- [x] **Important information is given to players in more than one way.**
- [x] When colors are used to distinguish game elements, the colors have a different brightness.
- [x] Audio elements are supported with visual elements, and visual elements also have audio elements.
- [x] Text is big enough to read during gameplay.
- [x] There is enough contrast between text and the background to read it.

## Visuals and Audio

### Lighting

- [x] **The lighting allows players to see all the important elements of the game.**
- [x] The lighting draws players' attention to important parts of the game.
- [x] The lighting supports the mood of the game.

### Visual Effects

- [x] **Visual effects are working as expected.**
- [x] The visual effects make gameplay easier to understand.
- [x] There are no visual effects that are confusing or distracting except by design.

### Audio

- [x] **Audio works and is not too soft or too loud.**
- [x] Audio helps players understand what is happening.
- [x] Audio supports the feel of the game.

## Project Organization

### Hierarchy

- [x] Objects are renamed so that they are easy to search for later.
- [x] Basic shapes are grouped into the objects they make up.
- [x] Parts of the game are organized into folders.

### Code

- [x] Code follows the [Lua Style Guide](lua_style_guide.md).

## Creativity

### Uniqueness

- [x] **The game is different from a basic framework.**
- [x] The game is different from other games by Core Creators.

### Attribution

- [x] Other Core Creators who helped with the project are mentioned in the description.
- [x] Creators of content that was essential to the game can also be credited.

## Preview

### Description

- [x] **The summary gives players a clear idea of what the game will be like.**
- [x] The summary gives players an idea about what is unique or unusual about the game.
- [x] The summary matches the tone of the game.

### Screenshots

- [x] **The screenshots give a clear picture of what the game is like**
- [x] Screenshots hide the game's User Interface.
- [x] Screenshots capture the visual variety of the game.
- [x] Screenshots tell a story.
- [x] The first screenshot has a custom title logo.

## Promotion

- [x] **Announce your game on the Core Creator Hub Discord server in the Showcase channel**
- [x] Share your game on social media channels.
- [x] Make videos or hold live streams showcasing the game and its features.
- [x] Develop a way of gathering and saving feedback from users who test the game.
- [x] *Share major updates and patches as the game evolves.*

## Publish

With all these considerations in mind, [publish](publishing.md) your game, and get ready to watch new users play in new and unexpected ways.

## Learn More

[Publishing on Core](publishing.md) | [Sharing Content](community_content.md) | [UI Reference](../references/ui.md) | [Lua Style Guide](../tutorials/lua_style_guide.md) | [Collaboration with other Core Creators](../tutorials/github.md)
