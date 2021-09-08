---
id: boss_tutorial
name: Creating a Boss Fight
title: Creating a Boss Fight
tags:
    - Tutorial
---

# Creating a Boss Fight

## Overview

In this tutorial you are going to create a multiplayer boss fight.

* **Completion Time:** ~?? hours
* **Knowledge Level:** It's recommended to have completed the [Scripting Beginner](lua_basics_helloworld.md) and [Scripting Intermediate](lua_basics_lightbulb.md) tutorials.
* **Skills you will learn:**
    * Using **Community Content**
    * Creating AI using **Activity Handlers**
    * Creating **Damageable Objects**
    * Creating **Projectiles**
    * Creating useable pickups
    * Creating **Curves** for animation
    * Changing custom material properties
    * Anything else???

## Create Project

Create a new project.

### Use Community Content

Get the tutorial map from CC with components.

## Add Player Weapon

Need to be able to damage floor tiles.

### Create Player Server Script

Add weapon property.
Explain code.

## Damageable Floor Tiles

Need a better title??
Explain that the tiles are already setup with damageable objects that spawn a new "hot" tile that
damages the player over time.

Maybe show the damage over time script (small and quite useful to know how to do)?

### Set Spawn Point

Set the spawn point at the starting area for the map, the perimeter trigger only detects begin and end overlap, so spawn point needs to be outside (do we explain this and why?)

### Test the Game

Check spawn is correct.
Shoot floor tiles to damage them.
Check if player takes damage, dies, and respawns.

## Create Boss

Something here

### Create Damageable Object

Setting up the damageable object (don't turn on start invulnerable until later (so player can test the fight without needing injectors turned off).

### Add Boss Template to Hierarchy

Add boss geo template. Deinstance it.

## Create AI Activity Handler

What is it? Brief info + reference link?

### Create Perimeter Trigger

For target detection.

### Create AI Brain Script

Maybe change title?

### Create Idle State

Explain code.

### Create Shoot State

No projectile code yet. This will be more about targetting a player that it will shoot at.

### Test the Game

Boss will target player when player enters perimeter trigger.
Boss will idle when player leaves trigger.

## Create Boss Projectile

Add template as custom property.

### Create Boss Projectile Code

Projectile function (uses new overlapping method, maybe link to API here?)

### Add Projectile Charge Up Effect

Small script that plays effect to give an effect of charging up.

### Create Boss Health Client Script

Feedback related, but it's for the boss. Updates the boss health bar. Small script. Remove?

### Test the Game

Boss will target player and shoot with random cool down.
Boss can damage floor tiles.
Boss can damage and kill player.

## Create Damage Client Script

It's feedback related, but ShowFlyUpText is a hidden gem that is simple to use. Script is small. Remove?

### Enable and Disable Player Weapon

Disable the weapon if the player is outside the boss perimeter to prevent cheese tactics.

### Test the Game

Boss health bar will go down.
Player can kill boss.

## Create Pickup Template

Creating the injector pickup to take down the shield generator.

### Add Pickup Template to Hierarchy

Deinstance it.

### Create Pickup Server Script

Go through code

### Update Pickup Template

Update the template ready for next section.

## Add Barrels Template to Hierarchy

This is a nested damageable object. Do we walk them through creating this from the ground up, or just explain why nesting damageable objects is being used here instead, and how it works?

I have made the barrels a little more simple that only contains 1 nested damageable object now.

### Add Pickup Template on Death

Pickup template spawns on death of the damageable.

Explain spawning object on death of the blue damageable object barrel (drops pickup).

### Update Barrels Template

Update it it, as 3 will be needed for the map

### Add 3 Barrel Templates to Map

1 per generator.

### Test the Game

Player can destroy barrels
Boss can destroy barrels
Only 1 Injector can be picked up
Injector icon in UI will show (do we want to a section for this?)

### Add Generator Template to Hierarchy

Explain what they will be used for.

There will be 3 of them, but setup 1 first, then create a template and place the other 2

### Add Interactable Trigger

For injector pickup to be used.

### Create Shield Generator Server Script

Explain code.

### Create Shield Generator Client Script

Explain code (handles changing a material property).

### Update Generator Template

Update it.

### Add 3 Generators to Map

Add them to the platforms.

### Move Generator Effect Target

Move the effect target to be at the boss location for all generators.

### Set Boss to Invulnerable at Start

So generators need to be turned off to hurt boss.

### Test the Game

Boss will be immune.
Pickup will turn off generator.
Material emissive will change to 0.
Effect will turn off.
All generators off, boss can be killed.

## Animate Player Health using Curves

Info. Pulsating heart when at 50% health.

### Create Simple Curve

Link to curve ref as well?

### Modify Player Client Script

Curve code.

## Test the Game

Player health 50%, heart will pulse.

## Send Game State for Players

Players joining late need to know about the game state.

### Update Player Client Script

Broadcasting to the server to say when client is ready. Lots of ways to do this, kept it super simple. Could have used networked custom properties, but for such a small state change (generator related), broadcasting is a simple solution in this case.

### Update Player Server Script

Send generator state to players. So if a generator is turn off, and a player joins, they need to know about it to turn off the effects. Simply solution, broadcast a compacted string of the generators turned off. Show off Core string split method.

### Test the Game

MP preview with 1 player.
Turn off 1 generator.
Launch a new client.
New client will get game state, generator will turn off.

## Polish

Some bits of polishing just to finish the fight.

### Add Boss Destroyed Template

Add to damageable object. Shows how easy it is to add sound and effects with no code to a destroyed object.

### Create Game Transition Screen using Curves

Create game transition screen using curve. Changes opacity of a panel from 1 to 0 at the start when player joins. I included this, as it's a way to hide what is happening when the client state needs update (in this case generator effects turned off).

## Additional Features Challenge

For the user to add as a challenge.

- Health regen for player
- Different weapons
- Loot dropped from boss (damageable objects make this easy :D)
- Scale difficulty based on amount of players
- Add weak points to boss (i.e back of boss takes more damage)
- Add critical chance to weapons
- Add more Boss attacks (i.e teleport, slam)

## Summary

Add summary.
