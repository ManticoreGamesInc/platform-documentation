---
id: persistent_storage
name: Persistent Data Storage in CORE
title: Persistent Data Storage in CORE
categories:
    - Tutorial
---

# Persistent Data Storage in CORE

## Overview

An amazing way to keep people coming back to your projects is if they can continue to progress more each time.

You might be familiar with this in many other games or projects you have played through; there are achievements, player levels, locked stages, the need to amass currency for certain items... the list can go on! Without persistent storage, each playthrough of a game starts completely from scratch and players do not get a sense of long-term accomplishment as easily as they could if their accomplishments were saved for them.

Here are just a few ideas on ways that persistent storage can be used:

* player high scores
* player level
* player equipment
* player resources
* object location
* map level for a player
* currency
* achievments
* & whatever else you can think of!

Really, anything that you might want to preserve for the next play session for that same player can be stored.

![Overview Shot](../../img/EditorManual/PersistentStorage/persistenceOverview.png){: .center}

* **Completion Time:** 10 minutes
* **Knowledge Level:** No knowledge *absolutely* required, but will be easier to understand with a grasp on **[Lua](lua_basics_lightbulb.md)** already.
* **Skills you will learn:**
     * How to store variables persistently between game sessions

---

*From Jishnu:*

**Persistent Player Storage** is live on dev and will be available in the next prod patch. To use the storage service it has to be enabled in the game settings object. It is available under a new namespace called **Storage**. The available lua calls are:

* table GetPlayerData(player) server-only

* errorCode, msg SetPlayerData(player, table) server-only
the items that can be stored in the table are the same as the ones that can be sent through networked events

* All successfully stored data in **preview mode can be viewed in /Maps/your_map_name/Storage/** . This data is just for debuging purposes and does not get uploaded.

* Each player table has a **maximum size limit of 16Kb**

NOTE:
If storage service is enabled in your game a player will be able to join only if that player has valid data, otherwise the player will get kicked from the server. This means as soon as the player joined event is fired all stored data for that player in that game should be available.

---

## Tutorial

This tutorial is going to go over some basic examples, as the Lua is simple but the possibilities are infinite.

To start, we are going to save an age-old class: high score.

1. Open a CORE project.

2. Create a Game Settings Object.

3. Enable persistent storage

4. Create a new script, called "score" or soemthing related to saving high score that isn't player inventory

5. Give this script a custom property, prolly enable something on that property itself

6. let's make a quick way to display this on screen as well as increase it (button press? pickup? Manticoin tutorial?)

7. Do a play sessionl, then a second play session to test that it works! (maybe publish the game for certainty)

8. Also do this for a resource on the player using the same method but in a different script maybe (depends on how different this feels)

9. It works!

note to self: publish working example on CC

---

### Extra Tips & Info

* Persistent storage data does not transfer between games nor can it be accessed between games.
* Overall, it works fairly similarly to using a networked property variable.

---

## Examples

* **Community Content** contains an example of this known as [name here]
