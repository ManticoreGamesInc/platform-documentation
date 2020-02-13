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

**Persistent Player Storage** is available under the namespace called **Storage**. The available lua calls are:

* table GetPlayerData(player) server-only

* errorCode, msg SetPlayerData(player, table) server-only
the items that can be stored in the table are the same as the ones that can be sent through networked events

* All successfully stored data in **preview mode can be viewed in /Maps/your_map_name/Storage/** . This data is just for debuging purposes and does not get uploaded.

* Each player table has a **maximum size limit of 16Kb**

NOTE:
If storage service is enabled in your game a player will be able to join only if that player has valid data, otherwise the player will get kicked from the server. This means as soon as the player joined event is fired all stored data for that player in that game should be available.

---

## Tutorial

This tutorial is going to go over some basic examples of using Storage, as the Lua is simple but the possibilities are infinite.

To start, we are going to save a video game classic: a player's high score.

### Setting Up Storage

1. Open a CORE project.

2. To turn on persistent game storage, we need a **Game Settings Object**. Navigate to the **CORE Content** window, and click the **Settings Objects** tab under the **GAME OBJECTS** section. Drag the Game Settings Object from this section into your project Hierarchy.

3. Now select the Game Settings object in your Hierarchy, and check out the **Properties** window. Check the box for **Enable Player Storage** on.

4. Create a new script, and while you can call it whatever you like, in this tutorial let's call it "AddHighScore".

5. We need somewhere to display the changes to our score, so let's create some World Text to edit while the game runs.

     1. In CORE Content, under the UI Elements section, drag two WorldText objects into your project Hierarchy.

     2. Name one of these PlayerName, and the other one PlayerScore.

     3. Feel free to change the color or text properties of these labels, or move them around in the world.

     ![WorldText](../../img/EditorManual/PersistentStorage/persistenceOverview.png){: .center}

6. Next we'll want to create custom property references to this on the AddHighScore script. Select the AddHighScore script in the Hierarchy, and with it still selected, drag each one of the WorldText objects into the Properties window for AddHighScore. This will automatically create a CORE Object Reference to the objects we are dragging in!

     ![WorldText](../../img/EditorManual/PersistentStorage/persistenceOverview.png){: .center}

7. Now on to the programming itself! Open the AddHighScore script to get started.

### Writing the Code

1. With our script open, we first need to access those references we added as custom properties. This code looks like:

     ```lua
     local PLAYERNAME_LABEL = script:GetCustomProperty("PlayerName_Label"):WaitForObject()
     local SCORE_LABEL = script:GetCustomProperty("PlayerScore_Label"):WaitForObject()
     ```

2. Next comes the function for causing the score to increase. In our super simple case, we'll just increase the player's score by +1 every time they press the 1 key. This code is:

     ```lua
     function OnBindingPressed(whichPlayer, binding)
         if (binding == "ability_extra_1") then
             local playerDataTable = Storage.GetPlayerData(whichPlayer)

             if playerDataTable.score then
                 playerDataTable.score = playerDataTable.score + 1
             else
                 playerDataTable.score = 0
             end

             local errorCode, errorMsg = Storage.SetPlayerData(whichPlayer, playerDataTable)
             if errorCode == StorageResultCode.SUCCESS then
                 SCORE_LABEL.text = tostring(playerDataTable.score)
             else
                 UI.PrintToScreen(errorMsg)
             end
         end
     end
     ```

     1. explain what this code is doing in parts

3. After that, the next function we need determines what to do when a player joins the game. This is where we can initialize the storage for that player, and set their score to 0 if they don't already have one. This code looks like:

     ```lua
     function OnPlayerJoined(player)
         local playerDataTable = Storage.GetPlayerData(player)

         if not playerDataTable.score then
             playerDataTable.score = 0
         end

         SCORE_LABEL.text = tostring(playerDataTable.score)
         PLAYERNAME_LABEL.text = player.name .. " Points:"

         player.bindingPressedEvent:Connect(OnBindingPressed)
     end
     ```

4. Finally, we've got to connect the function that we just wrote to the playerJoinedEvent in the Game namespace:

     ```lua
     Game.playerJoinedEvent:Connect(OnPlayerJoined)
     ```

5. Now jump in the game and test it out!

     It should work. wow

---

### Extra Tips & Info

* Persistent storage data does not transfer between games nor can it be accessed between games.
* Overall, it works fairly similarly to using a networked property variable.

---

## Examples

* **Community Content** contains an example of this known as [name here]
