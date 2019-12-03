---
name: My First Multiplayer Game
categories:
    - Tutorial
---

# My First Multiplayer Game

!!! warning
    Flagged for Review.
    Incomplete or outdated information may be present.

## Overview

Welcome to CORE! We're excited to have you in Closed Alpha and can't wait to see what you create. To get you started, we're going to walk you through creating your first multiplayer game in CORE... in 10 minutes!

* **Completion Time:** 10 Minutes
* **Knowledge Level:** Beginner! No experience necessary!
* **Skills you will learn:**
    * Editor Basics
    * CORE Content (Props & Materials)
    * Player Movement Settings
    * Community Content
    * Publishing


## Create a New Game

To get started, we're going to create a new project.

1. Click on `Create New`.

    ![](../../img/EditorManual/MyFirstMultiplayer/CreateNew.png)

2. Select the `Deathmatch` framework!

    ![](../../img/EditorManual/MyFirstMultiplayer/Deathmatch.png)

3. Name your project `MyFirstMultiplayerGame` or whatever you like! Then, click Create.

    ![](../../img/EditorManual/MyFirstMultiplayer/MyFirstMultiplayerGame.png)


### Explore the Map

The Deathmatch framework gives a great starting point! Let's try it out ourselves.

1. Behold the magnificence of this whiteboxed, free-for-all game framework! Let's jump in by pressing Play.

    ![](../../img/EditorManual/MyFirstMultiplayer/WhiteboxMapMarked.png)

2. Out of the box, you have a character who can move and jump! Explore the map by moving your character with the `WASD` keys and jumping with `Space`. Shoot the default gun with your left mouse click and interact with the door with `F`.

    ![](../../img/EditorManual/MyFirstMultiplayer/PlayMode.png)

3. But we're all by ourselves. 😞 That's no fun, so let's test out the multiplayer experience by simulating two clients! Near the pause button, click on the `Multiplayer Preview Mode` button and select 2 Players.

    ![](../../img/EditorManual/MyFirstMultiplayer/TwoPlayers.png)

4. Let's press Play again! Two clients will launch now. You control whichever character is in your current active window.

    ![](../../img/EditorManual/MyFirstMultiplayer/MultiplayerPreviewPlay.png)

    !!! Note
        Note that you can use `Alt + Enter` to toggle between fullscreen and windowed mode if you're using Windows. You can also use `WindowsKey + Arrow Key` to dock the screens side by side like above!

## Make It Your Own!

So we've got a whitebox map now, and that's great and important in testing design! Let's customize the map now and make it our own.

1.  Navigate to the "CORE Content" window. You have access to this amazing, massive library of 3D assets for your game creation in CORE!

    ![](../../img/EditorManual/MyFirstMultiplayer/AddPropsMarked.png)

    !!! Note
        If you can't find the "CORE Content" window or accidentally close it, you can reopen the window by going to View > Core Content in the toolbar at the top of the editor.

2. Click on "3D Objects" and then drag and drop props into the editor viewport! In this example, we're going to place some bushes.

    ![](../../img/EditorManual/MyFirstMultiplayer/DragDropBushes.gif)

3. You can move, rotate, and scale all these objects! `W` activates Translation Mode to move objects; `E` activates Rotation mode; and `R` activates Scale Mode to resize objects. Let's try click on an arrow and dragging an object along an axis.

    ![](../../img/EditorManual/MyFirstMultiplayer/MoveBushes.gif)

4. Press Play. Currently, if you try to move through a bush, you'll be stopped once you collide with the object.

    ![](../../img/EditorManual/MyFirstMultiplayer/StuckInBushes.png)

5. Bushes are great as environmental props to hide players, but it'd be great to let players push past them to surprise enemies in this game! Let's click on a Bush and check out the Properties window. By default, this Bush is "Collideable" but with a simple click on the checkmarked box, we can turn that off.

    ![](../../img/EditorManual/MyFirstMultiplayer/NoCollisonBush.gif)

    !!! Note
        If you can't find the "Properties" window or accidentally close it, you can reopen the window by going to View > Properties in the toolbar at the top of the editor.

### Designing Your Level

1. Take this time to add more props. Feel free to move and delete objects too!

2. Drag and drop a material onto the whitebox walls.

3. Drag and drop a material onto the whitebox floor.

    ??? How do I make my own material?
        If you want to learn more about customizing materials, check out our [Custom Material tutorial](../../tutorials/art/custom_materials.md).

4. Add a Sky

    !!! Did You Know?
        We have some awesome post-processing effects. BLOOM BABY BLOOM

### Customizing the Gameplay

1. Use the searchbar in the Hierarchy to find the Player Movement Settings.

2. In the Player Movement Settings, let's add a double jump.

3. Let's change the Round Kill Limit to 3 instead of 10 for shorter rounds.

4. Change the UI text to match the Round Kill Limit.

5. Let's move the spawn points. Press `V` to toggle gizmo visibility-- you can now see the camera, spawn points, and trigger boxes.

    !!! Did You Know?
        With the shortcut key `0`, you can create a spawn point at your cursor's location. Check out more editor shortcuts [here](hi-folks)!

### Choose Your Weapon! from Community Content

1. Download the Weapons Pack from Community Content. This pack contains several example templates for different types of guns!

2. Click on the plus sign to import the template into your local project.

3. In the "Gameplay Settings" folder in the hierarchy, find the "Starting Weapon" folder.

4. Drag and drop a weapon you like from the Weapons Pack into the EquipmentTemplate custom property slot.

    !!! Did You Know?
        A custom property is an exposed blah blah blah.

    ??? How do I make my own weapon?
        If you want to learn more about customizing materials, check out our [Basic Weapons Tutorial](../../tutorials/gameplay/weapons.md).

### Publishing Your Game

Steps here. Flow is still in progress on the engine side.

### Next Steps

Playtest with Friends. But who?
Engage with community in #playtest in Discord

Encourage to post a screenshot of character/map/playtest in #showcase in Discord.
You're doing amazing!! Supportive encouragement here.


Check out these tutorials:

- Intro to Enviro Art (Terrain)  
- Weapons (Gun)    
- Abilities (Dodgeroll)   
