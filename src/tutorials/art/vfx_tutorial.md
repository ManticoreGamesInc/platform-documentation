---
id: vfx_tutorial
name: Visual Effects in CORE
title: Visual Effects in CORE
categories:
    - Tutorial
---

# Visual Effects in CORE

## Overview

A huge benefit to Core is the vast amount of visual effects that are built-in and easily editable. You get to start with high quality effects that already exist, and truly make them your own.

Our team at Manticore has built a huge level map that you can explore at any time to see just *some* of the ways that all of our different visual effects (often shorted to VFX) could be used.

To get a tour of what is possible with visual effects in Core, run around this map and then come back to this tutorial to learn how to make a couple of the effects found on this map!

**[Click here to go to the VFX level map page.](https://www.coregames.com/games/e38551f434b14eee989a08cd5f98c31d)**

While the map explains many useful things about how to use all the visual effects, this page includes tutorials on how to make wicked cool VFX in Core using Lua.

<div class="figure-block">
    <figure>
        <video autoplay loop muted playsinline poster="/img/EditorManual/Abilities/Gem.png">
            <source src="/img/VFXtutorial/vfxTrails.mp4" type="video/mp4" alt="Whispy Trail VFX"/>
        </video>
        <figcaption><em>Trail VFX in Core</em></figcaption>
    </figure>
</div>

## Dozens of Built-In Effects

Core comes with all sorts of visual effects built-in, all with different parameters for altering how they look and move.

To find all these visual effect objects, navigate to the Core Content tab and click on the **"Effects"** section.

This window can also be accessed via the dropdown menu "**View -> CORE Content**".

![Core Content](../../img/VFXtutorial/EffectsFolder.png "All visual effects are contained in this subsection."){: .center}

Currently, there are **7 different sections** that contain effects you can use right away:

- **Character**
    - These vfx are specifically human or character-focused.
- **Environmental**
    - Elemental effects, and effects that are more nature-oriented.
- **Explosions**
    - Definitely things that blow up!
- **Magic**
    - More ethereal and sparkly effects.
- **Misc**
    - Things that don't fit into the other categories--weird stuff!
- **Vehicles**
    - Effects designed to enhance movement and show physical power.
- **Weapons**
    - These effects were designed specifically with the weapon system, and to go along with attacks.

!!! tip
    Don't be afraid to use any effect for any purpose--don't let categories restrict your creativity!

These larger categories can be found by clicking the little drop down arrow on the left side of the Effects button label. Each of these categories also have subcategories, that can be opened the same way:

![Core Content Dropdowns](../../img/VFXtutorial/DropDownArrows.png "Core Content Dropdowns"){: .center}

To check out what any of these VFX objects do, drag one into your viewport or Hierarchy. In most cases it will start playing immediately, but for one-off animations, you'll probably want to reactivate them multiple times to see what they do.

All VFX have a ***Play*** button at the top of their **Properties** window, so to check out what an explosion looks like, drag it into your scene and hit the Properties' *Play* button!

### Special Effect Materials

Besides all of the more literal visual effects that Core includes, there is also a categorey of **Materials** that lend themselves nicely to VFX, the SpecialEffects materials:

![Special Effect Materials](../../img/VFXtutorial/SpecialEffectMaterials.png "You can get real creative with these."){: .center}

Use these in combination with the Effects objects to get even more variety out of what you can make.

### Post Processing Effects

Another category of effects that can make huge changes to your map are **post process effects**. As their name implies, these are applied on top of everything else in your game at the end, so they can be used to change everything visually about the game at once.

![Radioactive Post Process](../../img/VFXtutorial/crazyPostProcess.png "Using the Radioactive Trip Sky by Dracowolfie on CC."){: .center}
![Lens Flares](../../img/VFXtutorial/coolPostProcess.png "From Sniper Alley."){: .center}
![Magical Fantasy Sparkles](../../img/VFXtutorial/prettyPostProcess.png "Made by Sasha during her stream series."){: .center}

To find all our Post Process Effects, check out the Post Processing section of Core Content.

![Post Process Effects](../../img/VFXtutorial/postProcessEffects.png "All post process effects can be found here."){: .center}

You'll probably want to always use some combination of these--the amount they can level-up a map visually is huge!

---

## Tutorial Video

**Content to be added**

## Tutorials

While you can use the video above if that is your preference, we'll next go over different effects in a written tutorial.

### Post Processing Effects

Just like in the video, let's start with the most dramatic and easy of the visual effects you can use in Core: **Post Process Effects**!

Post process effects can make very dramatic changes to a map with very little work. You can use as many of them as you want in combinations, but this can eventually get tricky when you've got dozens. There are two main ways to use a post process effect: as an unbounded effect, or a bounded effect.

- **Unbounded** post process volumes are limitless in size, and encompass the entire map.
- **Bounded** post process volumes use a cube volume to determine what space that post processing effects in the world.

Several post processing effects have both a regular version and an **advanced** version. Use whichever suits your needs, but in this tutorial we'll go over the advanced versions of these effects.

#### Advanced Bloom Post Process

**Bloom** is, basically, a glow effect. It gives everything that emits light in your scene a sort of magical halo, as though the atmosphere has thickened.

The best way to test post process effects is on an already decorated map with some variety in it. For this tutorial, I grabbed some templates from Community Content. Almost all (if not truly all) of these templates were made by students at Cogswell College during Global Game Jam 2020.

*Those creator usernames are JaineRoss, mjcortes782, trimun, and TSMVayne.*

![Post Process Effects](../../img/VFXtutorial/ppe_before.png "My scene before any effects are added."){: .center}

1. Start by dragging the **Advanced Bloom Post Process** effect into the project Hierarchy. With default settings, it'll just make a subtle change.

    ![Post Process Effects](../../img/VFXtutorial/ppe_advBloom1.png "Default settings for Advanced Bloom."){: .center}

    The overall scene is darker and the contrast is higher. Even though it is called *bloom*, by default it seems to have decreased the bloom from our first scene.

2. Click on the **Advanced Bloom Post Process** effect in the Hierarchy, and check out the Properties window. We can mess with all sorts of values in here.

    To expose all the options we want to change, check the **Advanced Settings** box to make sure it is on.

    ![Post Process Effects](../../img/VFXtutorial/ppe_advBloom1_properties.png "Getting weird changing values."){: .center}

    Wiggle all those settings around to see what happens! Trying yourself can be the best way to understand what is happening.

3. I'll first show you the settings I chose, and then explain a bit about them. I chose these properties:

    ![Post Process Effects](../../img/VFXtutorial/ppe_advBloom2_properties.png "Getting weird changing values."){: .center}

    Which makes my map look like this:

    ![Post Process Effects](../../img/VFXtutorial/ppe_advBloom2.png "Getting weird changing values."){: .center}

    As you can see, you can go pretty intense with this effect. I went super dramatic to showcase just how much can change, but feel free to find the right balance for your project.

4. Each of the properties you can change has a tooltip to explain what it does. Hover over the name of the property to see the tooltip.

    In general though, **Blend Weight** is the strength of the entire effect on the scene. It is essentially a slider from *off* to *on*.

    That is different from **Intensity**, which controls the strength of the bloom itself. This has a cap on the slider, but you can type in any number you want to increase the intensity even more. While I was able to drag the slider to 15, I instead typed in a value of 100 to make things ridiculous and blown out. And it's fun--who knows, maybe you'll think of a cool place to use something like this!

    ![Post Process Effects](../../img/VFXtutorial/ppe_advBloom3.png "Getting weird changing values."){: .center}

    !!! tip
        There are a lot of properties in Core that can be *overdriven*. This means you can manually type in a number higher than what the slider allows. This usually works for properties that act as a multiplier, like the *Intensity* in this case.

    The other fun properties to change on this post process effect are the different **colors**. This can really change the mood of the entire scene, and is a fun way to affect temperature.

    Have fun experimenting with different settings! If you don't see a change immediately, try changing the number very dramatically to get an idea of what is happening.

#### Ambient Occlusion Post Process

**Ambient Occlusion** (often abbreviated to AO) can be generally reffered to as contact shadows. In the real world, when two objects are close together, less light is able to reach the cracks between them. So, to simulate this virutally, we use ambient occlusion!

I'm going to start visually from scratch with this one, so I am back to the first image:

![Post Process Effects](../../img/VFXtutorial/ppe_before.png "My scene before any effects are added."){: .center}

1. Drag the **Ambient Occlusion Post Process** into the project Hierarchy from Core Content to get started. The default settings give a subtle effect, but it still makes a difference.

    ![Post Process Effects](../../img/VFXtutorial/ppe_AO1.png "The default of AO is subtle but clear."){: .center}

    The main noticable part of the change in this image is underneath the roof close to the camera. It becomes darker, and the shadows of the beams on the ceiling are more dramatic.

2. In the Properties window, make sure to turn on the **Advanced Settings** button to have access to everything.

3. In this case, I want to make the AO dramatic for the scene, so I cranked up the settings. This creates really obvious contact shadows, which grounds everything together. It creates a feeling that things were built intentionally this way, which can help eliminate the feeling of kitbashing one might have in their scene.

    Notice the dark shadows under the roof beams, and the darker shadows on the rubble pile on the left.

    ![Post Process Effects](../../img/VFXtutorial/ppe_AO2.png "The default of AO is subtle but clear."){: .center}

    For this particular dramatic AO effect, I used these settings:

    ![Post Process Effects](../../img/VFXtutorial/ppe_AO2_properties.png "The default of AO is subtle but clear."){: .center}

    Adjust the settings to whatever feel best for your scene and mood.

#### Ambient Occlusion Recolor Post Process

Something particularly fun and weird you can do with the Ambient Occlusion we made is **recolor** it. This can create some really wacky effects, or in general set a specific color palette for a project.

We're going to continue with the end result of the Ambient Occlusion section, so that we have existing ambient occlusion to recolor! The Ambient Occlusion Recolor Post Process **only works in combination** with the Ambient Occlusion Post Process.

![Post Process Effects](../../img/VFXtutorial/ppe_AO2.png "The default of AO is subtle but clear."){: .center}
![Post Process Effects](../../img/VFXtutorial/ppe_AOrecolor1.png "The default of AO is subtle but clear."){: .center}

1. Drag the Ambient Occlusion Recolor Post Process into the Hierarchy. This should result in something like the second image above.

    By default it starts with the color brown, which gives a warm darkness to the whole scene. You can alter this to suit whatever helps your scene--perhaps a dark blue would help instead to balance an already warm scene.

These other two images below are a general explanation, and you don't need to do them for the tutorial. Knowing how to achieve these weird effects is good though!

![Post Process Effects](../../img/VFXtutorial/ppe_AOrecolor2.png "The default of AO is subtle but clear."){: .center}

Turning on the **Use Two Colors** option will give you a second color option, and using the Color Balance slider you can choose which color is more prominent in the scene. This gives you really strong control over the color palette, and lets you do particularly odd and unique things. Such as making weird radioactive shadows, if that's what makes you happy.

![Post Process Effects](../../img/VFXtutorial/ppe_AOrecolor3.png "The default of AO is subtle but clear."){: .center}

The other particularly interesting setting on the recolor post process is modifying **Blend Weight**. The lower this number is, the more intense this glow effect is. This could be used to showcase damage increasing on the player, or maybe a world on fire... whatever you can imagine!

#### Lensflare Post Process

![Lens Flare in Real Life](../../img/VFXtutorial/realLife_lensflare.png "Photo credit to Neil Nafus and Josh Tyler, respectively."){: .center}

In real life, a **lens flare** is a streak of light glare and sometimes a light shape floating in an image. This happens when light hits a camera lens and scatters around within all the parts that make up the lens. For some photographers, it can be annoying, but in general it is an unavoidable aspect of filming light.

In the virtual world, adding it in can make a scene feel more realistic and grand.

We'll start this section using two of the effects that we made earlier: the Advanced Bloom Post Process and the Ambient Occlusion Post Process **both turned on**.

![Post Process Effects](../../img/VFXtutorial/ppe_LensFlare0.png "The default of AO is subtle but clear."){: .center}
![Post Process Effects](../../img/VFXtutorial/ppe_LensFlare1.png "The default of AO is subtle but clear."){: .center}

1. Drag the **Lensflare Post Process** into your Hierarchy, and you should get something like the second photo above.

    For my scene at this particular angle, the lens flares were not very visible, so I turned the intensity up to 5. This made the shapes much more visible.

    ![Post Process Effects](../../img/VFXtutorial/ppe_lensflare_properties.png "The default of AO is subtle but clear."){: .center}

2. Try turning up different settings. The **Intensity**, **Bokeh Size**, and **Threshold** can all be *overdriven* to create the look you are going for.

3. The **Shape** property can be the most fun to change for the theming of your game. In particular, hearts are fun:

    ![Post Process Effects](../../img/VFXtutorial/ppe_LensFlare2.png "The default of AO is subtle but clear."){: .center}

    The above image also had increases to Intensity and the Bokeh Size.

Now you know how to control several different post process effects. Each one in Core Content has slightly different base settings and options, but now you have enough knowledge to understand how the others work too. Have fun experimenting!

---

### Visual Effects

- first we're going to make a cool floaty orb that uses scripting to move up and down and just in general looks cool and weird and uses multiple materials and effects
    - later we will make it interactable to explode maybe, that'd be cool

- creating a trigger walkthrough gate that causes fancy effects when walking through. Sort of like a save point, I'm thinking.

- okay perhaps following the flow of the video in opening a treasure chest/as in using the loot system at the same time.