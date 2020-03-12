---
id: first_multiplayer_game
name: My First Multiplayer Game
title: My First Multiplayer Game
categories:
    - Tutorial
---

# Build Your First Game In Core

<!-- !!! warning
    Flagged for Review.
    Incomplete or outdated information may be present.

## Overview

Welcome to Core! We're excited to have you in Closed Alpha and can't wait to see what you create. To get you started, we're going to walk you through creating your first multiplayer game in Core... in 10 minutes!

![NewWeapon](../img/MyFirstMultiplayer/NewWeapon.png){: .center}

* **Completion Time:** 10 minutes
* **Knowledge Level:** Beginner! No experience necessary!
* **Skills you will learn:**
    * Editor Basics
    * Core Content (Props & Materials)
    * Player Movement Settings
    * Community Content
    * Publishing -->

## Start a New Project

To get started, use the **Create** menu to make a new project

### Click **Create New**

![Create New](../img/MyFirstMultiplayer/CreateNew.png){: .center}

1. With Core open, click the **Create** Tab on the left side menu.
2. Click **Create New Game**.

### Select the **Deathmatch** framework

![Deathmatch](../img/MyFirstMultiplayer/Deathmatch.png){: .center}

<!-- ### Create a new Project

![Name](../img/MyFirstMultiplayer/MyFirstMultiplayerGame.png){: .center} -->

1. Click **View Frameworks** in the **Core Game Frameworks** option.
2. Click **Deathmatch**.
3. Name your project. `MyFirstGame` works well, but choose any name you like.
4. Click **Create**.

## Explore the Project

The Deathmatch framework gives you a complete game arena and shooter functionality out of the box.

![Whitebox](../img/MyFirstMultiplayer/WhiteboxMapMarked.png){: .center}

### Test Player Movement

- Press ![Play](../img/EditorManual/icons/Icon_Play.png) or <kbd>=</kbd> to experience your project as a player.
  {: .image-inline-text .image-background}
- Press <kbd>Tab</kbd> to pause the preview.
- You can![Stop](../img/EditorManual/icons/Icon_Stop.png) or <kbd>=</kbd> to stop the preview.
 {: .image-inline-text .image-background}

As in any Core game project, you already have a working character controller.

- Move the character with the <kbd>W</kbd>, <kbd>A</kbd>, <kbd>S</kbd>, and <kbd>D</kbd> keys
- Jump with <kbd>Space</kbd>
- Crouch with <kbd>C</kbd>
- Ride a mount with <kbd>G</kbd>

### Test Shooter Mechanics

Besides player movement, **Deathmatch** also gives each player a gun to shoot, and the ability to open and close doors.

- Shoot the default gun with the left mouse button.
- Open and close a door with <kbd>F</kbd>.

![PlayMode](../img/MyFirstMultiplayer/PlayMode.png){: .center}

### Test Multiplayer Gameplay

Core projects also include multiplayer networking by default. Because this is a crucial component of this game, it is important to test using **Multiplayer Preview Mode** as much as possible.
![TwoPlayers](../img/MyFirstMultiplayer/TwoPlayers.png){: .center}

1. Click ![Multiplayer Preview Mode](../img/EditorManual/icons/Icon_MultiplayerTest.png) to switch the Preview Mode to Multiplayer.
    {: .image-inline-text .image-background}
2. Press ![Play](../img/EditorManual/icons/Icon_Play.png) to start the preview. This will open a separate game window for each player.
    {: .image-inline-text .image-background}

    ![MPPreview](../img/MyFirstMultiplayer/MultiplayerPreviewPlay.png){: .center}

!!! tip
     You can use <kbd>Alt</kbd> + <kbd>Enter</kbd> to toggle between fullscreen and windowed mode. You can also use <kbd>Win</kbd> + <kbd>Arrow</kbd> to dock the screens side by side like above!

## Customize the Arena

### Explore Core Content

Core gives you a massive library of 3D assets, materials, sounds, and components for making games, which can be found in the **Core Content** Window.

!!! note
    You can reopen the "Core Content" window by going to **View** > **Core Content** in the top menu bar.

1. Click **Core Content**.
2. Drop down the **3D Objects** menu to see the props and objects that can be added to the scene.
3. Click on the **Nature** subcategory.
4. Choose a bush and some other props to drag into the scene.

![DragDrop](../img/MyFirstMultiplayer/DragDropBushes.gif){: .center}

### Create Hiding Places

You can move, turn, and resize objects.

- ![Transform Position](../img/EditorManual/icons/Icon_TransformPosition.png )
 or <kbd>W</kbd> activates Translation Mode.
{: .image-inline-text .image-background}
- ![Rotate Tool](../img/EditorManual/icons/Icon_TransformRotation.png)  or <kbd>E</kbd> activates Rotation Mode.
{: .image-inline-text .image-background}
- ![Snap Position](../img/EditorManual/icons/Icon_SnapPosition.png) or <kbd>G</kbd> activates Scale Mode.
{: .image-inline-text .image-background}

1. Click on the bush and press <kbd>G</kbd> to move it.
2. Use the arrows to move it into a good hiding place for a player.
3. Press <kbd>W</kbd> to change the size of the bush.
4. Click and drag the white box at the center of the bush to resize it proportionately.
5. Move, rotate, and scale the rest of the objects to enhance the scene.
6. Press play to

    ![Move](../img/MyFirstMultiplayer/MoveBushes.gif){: .center}

    <!-- ![Stuck](../img/MyFirstMultiplayer/StuckInBushes.png){: .center} -->

7. Bushes are great as environmental props to hide players, but it'd be great to let players push past them to surprise enemies in this game! Let's click on a Bush and check out the Properties window. By default, this Bush is "Collideable" but with a simple click, we can turn that off.

    ![Collison](../img/MyFirstMultiplayer/NoCollisonBush.gif){: .center}

!!! note
    If you can't find the "Properties" window or accidentally close it, you can reopen the window by going to View > Properties in the toolbar at the top of the editor.

### Designing Your Level

Let's take this time to build out our own game! We're going to apply materials to whiteboxed scene, add more props, and add a sky to finish off the scenery.

1. Let's check out the Materials library within **Core Content**! It's fast and easy to drag and drop any material onto an object to apply it.

    ![WallObjects](../img/MyFirstMultiplayer/MaterialExample.gif){: .center}

2. But there's a really fast way to apply materials to all the objects in our game! To the right of the editor, game objects are listed in the "Hierarchy." Let's use the search bar to find all the "Wall" objects. Then, click the "Select" button to the right.

    ![WallObjects](../img/MyFirstMultiplayer/SelectWalls.gif){: .center}

3. Search for "Bark Oak 01" (or choose any material you like!) and drag it back into the hierarchy where all the selected walls are currently highlighted.

    ![WallObjects](../img/MyFirstMultiplayer/WoodWalls.gif){: .center}

4. Looking good! Let's practice some more. Try searching the Hierarchy for "windows", using the Select button, and applying the same material.

    ![WoodLevel](../img/MyFirstMultiplayer/WoodLevel.png){: .center}

5. Let's switch out this whitebox floor! Search the hierarchy for "floor", use the "Select" button to select all floor pieces, and drag and drop the material "Grass Clumps" onto the selected floor.

    ![WoodFloor](../img/MyFirstMultiplayer/WoodFloor.png){: .center}

6. Now, it's your turn! Apply a material to the stairs and add more props to your game! Remember you can scale, rotate, and transform objects as well as explore an object's Properties!

    ![FinishArt](../img/MyFirstMultiplayer/FinishArt.png){: .center}

    !!! info "How do I make my own material?"
        If you want to learn more about customizing materials, check out our [Custom Material tutorial](custom_materials.md).

7. Awesome! This scene looks rather dark though. Let's make it more vibrant with some better lighting! In "Core Content," search for sky. Then, drag and drop "Sky Whimsical Sunny Saturation."

    ![VibrantLevel](../img/MyFirstMultiplayer/VibrantLevel.png){: .center}

!!! tip
    In Core, you even have tons of customizable post process effects and VFX. Search for "Advanced Bloom Post Process" in Core Content and try it out!

### Customizing the Gameplay

The map's in good shape now! Let's change up the gameplay itself now. There are lot of props on the map now, so let's give the player more power to hop over them.

1. Find the "Player Settings" in the "Game Settings" folder or search the Hierarchy for it.

    ![PlayerSettings](../img/MyFirstMultiplayer/PlayerSettings.png){: .center}

2. In the Properties window of "Player Settings," change the Jump Max Count to 2 so all players have a double jump! Press Play and try it out with <kbd>Space</kbd>.

    ![DoubleJump](../img/MyFirstMultiplayer/DoubleJump.png){: .center}

3. Great! Now, let's make this game have shorter rounds since 10 Kills may take a while. Let's go into the "Gameplay Settings" folder and select "Round Kill Limit."

    ![RoundKillLimit](../img/MyFirstMultiplayer/RoundKillLimit.png){: .center}

4. In the Properties window, change the "KillLimit" custom property to 3. Now, if you playtest, the winner will be whoever gets 3 kills first!

    ![ChangedKillLimit](../img/MyFirstMultiplayer/ChangedKillLimit.png){: .center}

5. Game rounds now end at 3 kills, but in the upper-left corner of the screen it still says "First to kill 10 enemies wins!". Let's change that UI text to match the Round Kill Limit. In "UI Settings", find "Game Instructions" and click on the "UI Text Box." In Properties, change the Text field to 3.

    ![ChangedGameInstructions](../img/MyFirstMultiplayer/ChangedGameInstructions.png){: .center}

6. Let's move the "Player Start" where players spawn to be further apart. Press `V` to toggle gizmo visibility-- you can now see the camera, spawn points, and trigger boxes.

    ![PlayerSpawn](../img/MyFirstMultiplayer/PlayerSpawn.png){: .center}

!!! tip
    With the shortcut key `0`, you can create a spawn point at your cursor's location. Check out more editor shortcuts [here](editor_keybindings.md)!

### Choose Your Weapon from Community Content

1. Navigate to **Community Content**, where creators can publish and share their creations with the community! Let's search for a weapon and then click on the `Import` button to download the template into your local project. In this example, the "Tree Gun" by Buckmonster will be imported.

    ![CCSearch](../img/MyFirstMultiplayer/CCSearchMarked.png){: .center}

    !!! note
        If you can't find the "Community Content" window or accidentally close it, you can reopen the window by going to View > Community Content in the toolbar at the top of the editor.

2. Locate your imported weapon in **Core Content** under the "Imported" category.

    ![LocateImport](../img/MyFirstMultiplayer/LocateImportedWeapon.png){: .center}

3. Now, in the "Gameplay Settings" folder in the hierarchy, locate the "Starting Weapon" folder. In Properties, there is an "EquipmentTemplate" custom property which currently is the "Basic Rifle".

    ![BasicRifle](../img/MyFirstMultiplayer/BasicRifle.png){: .center}

4. To swap out the starting weapon, drag and drop your imported gun's template into the "EquipmentTemplate" field.

    ![SwapWeapons](../img/MyFirstMultiplayer/SwapWeapons.gif){: .center}

5. Press Play and test our your awesome new gun... that shoots tree!

    ![TreeShot](../img/MyFirstMultiplayer/TreeShot.gif){: .center}

!!! info "That's too cool. How do I make my own weapon?"
    It's easy! Check out our [Basic Weapons Tutorial](weapons.md).

## Publishing Your Game

Almost there! Now to make your game live for the world.

1. Locate the `Publish` button in the top right of the editor and press it.

    ![PublishButton](../img/MyFirstMultiplayer/PublishButtonMarked.png){: .center}

2. Fill out all the relevant information! Give your game a name, write up a description blurb, add relevant tags, and take a screenshot for your game! For your game's screenshots, you can either take snapshots in-editor with the camera button or select an image file from your directory via the folder button.

    ![PublishWindow](../img/MyFirstMultiplayer/PublishWindow.png){: .center}

3. Click "Publish" in the bottom right corner. Anytime you're republishing the game with changes or updates, you can follow the exact same flow, except with a "Review & Update" button instead. When your game has been successfully published, a new window will pop up!

    ![PublishSuccess](../img/MyFirstMultiplayer/PublishSuccess.png){: .center}

4. Your game's now live! Visit your game's page and press play to try it out online.

    ![GamePage](../img/MyFirstMultiplayer/GamePage.png){: .center}

## Next Steps

Congrats! You've made your first multiplayer game! 🎉

Now's the best part: playtesting! Come invite people to join you in-game in the #playtest channel on :fab fa-discord: [Discord](https://discordapp.com/invite/3H4j3YJ). Manticore devs will be hanging out there too, and we can't wait to see what you create! If you need any help or have questions, there'll be live support there too.

Excited? Check out these tutorials to build out your game:

* Sculpt your own world! Check the [Terrain Tutorial](environmental_art.md).
* Create your own Weapon! Try out the [Basic Weapon Tutorial](weapons.md).
* Learn how to add player Abilities! Let players celebrate and [Dance Dance Dance](abilities.md)!
