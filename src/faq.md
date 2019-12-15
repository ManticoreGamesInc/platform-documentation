---
name: FAQ
---

# Frequently Asked Questions

## Confidentiality

Please remember all information about the CORE Alpha is confidential and cannot be shared publicly! We do encourage you to share your screenshots, videos, and games on our own Discord!

## Getting Started with CORE

* Join the CORE Alpha :fab fa-discord: [Discord](https://discord.gg/85k8A7V)! - This will be the best place to get the latest updates, news, events, and help from both the CORE Alpha team and the community.
* Check out the [Getting Started](getting_started/editor_intro.md) section of the Creator Hub - Here you'll find an overview of the editor, a tutorial on making your first game, and how to share and use shared content within CORE.

## Alpha Access

> **Q:** So is the alpha something we're going to have perpetual access to now that we're in or is it planned that we're going to lose access at some point?

> **A:** There will likely be some down time between closed Alpha and closed Beta, but we aren't sure how much yet - it will partially depend on how stable the alpha is and if we need to make any major changes between alpha and beta.

## Platforms

> **Q:** What platforms are supported?

> **A:** PC first and then onto the rest.

---

> **Q:** Is there a system in place for making cinematics and cut-scenes?

> **A:** Not a specific tool, but you have so much control in CORE that you just need to set it up and record it.

## Editor

> **A:** What language are scripts written in?

> **Q:** We use [Lua](tutorials/gameplay/lua_reference.md).

---

> **Q:** Do you plan to support other languages in the future ? Like unity supports JavaScript and C#

> **A:** No plans at the current time.

---

> **Q:** Does CORE have something analogous to Unity Timelines, to make things like cutscenes and scripted events?

> **A:** No but an intern did write his own in Lua at one point this summer.

<!--
## COMMUNITY
> **Q:** What will be the community/social features available in CORE?

> **A:**
-->

## Chats & Coms

> **Q:** Will stuff like the built in chat be editable for users? like if someone wanted to change something about it for their specific game?

> **A:** In-game text chat will happen sometime during Alpha. More details on that as we get closer. We won't have voice chat to start but we can of course use [Discord](https://discord.gg/85k8A7V)!

## CORE Content

> **Q:** On the off chance that there isn't a sound that we need/want, is there a pipeline or process for requesting new sounds? Or new anything?

> **A:** Yes, use the feedback link in [Discord](https://discord.gg/85k8A7V) and at the top and bottom of every page on our documentation platform.

---

> **Q:** One thing I'm unclear on, are the things made in CORE meant to stay within the confines of the community content, or can it build to other platforms as well?

> **A:** Stuff made in CORE is meant to be used on the CORE platform, but 100% sharable across the platform if you so desire. Want the helicopters from Sniper Alley in Spellshock? Crtl-C, Ctrl-V, done!

---

> **Q:** Are maps the equivalent of scenes in unity?

> **A:** Sort of - I should actually say "Games" instead of "maps" - we don't have a separate scene concept yet.

> Scenes is definitely something we want to add in the future.

---

> **Q:** One of the demos I saw you could transition people to other maps, so I guess that could be a workaround if you wanted multiple levels?

> **A:** Yes, correct! You could even build an zone style 'MMO' that way if you really wanted to (well, not in Alpha, but eventually).

> We will have the portal technology in alpha, but no way to pass data from one game/zone to the other.

---

> **Q:** I really like the seamless game changing. Is that limited to maps that only the creator made? Or could i, for example, make a "hub" that has a curated list of games I like?

> **A:** You could indeed make a hub world that has portals to all the games you like!

> What's super cool about the Hub world is you'd be able to have all your friends join you and follow you from it into each game. Hopefully eventually creators team up to have links back to the most popular hubs etc and it all becomes one cool connected meta-verse.

---

> **Q:** Can you lock your content from not being shared?

> **A:** Yes you choose to share.

---

> **Q:** Is all the content/assets premade?

> **A:** At the very base level the answer is 'yes' - we provide all the base 3D objects, materials, sounds, vfx, etc. however - users can then 'kitbash' them together to make whatever they want and share that with each other if they choose via Community Content

---

> **Q:** Can we import custom assets?

> **A:** No, and there are a few reasons for that - the biggest one being: because all the content is built in to the client, when you share something with someone else, or copy/paste something from one game to another - we can guarantee that those assets are on the other persons computer already - so the only thing that gets shared is a small definition file of what assets are where, with what material, etc.

> In fact, entire games in CORE are a collection of these definition files, which means entire games are only a few hundred k which is why they load basically instantaneously.

> A lot of stuff in CORE is about finding new and creative ways to use things that are at first maybe "non-obvious" but once you get the hang of it, it becomes really really fun.

> Here is a prime example - this Palm Tree in the Pirate game is actually (as you can see in the hierarchy) 2 Ferns on top of 2 tear drop shapes.

![Palm Tree](https://cdn.discordapp.com/attachments/651152898113142807/653639807678939156/unknown.png)

> Here is a set of "retro" kitchen appliances our UI/UX guy was able to make in CORE - basically from primitives.

![Retro Kitchen Appliances](https://cdn.discordapp.com/attachments/651152898113142807/653641615490940928/unknown.png)

> And since he shared these in "Community Content" (a tab in the editor) - all creators have access to grab them and use them.

> Here is another example of something I just grabbed from community content.

![Marble Mausoleum](https://cdn.discordapp.com/attachments/651152898113142807/653642303872696320/unknown.png)

> A cool marble mausoleum - the gates open and everything.

> So not only is this a cool set-piece, it comes with the scripts needed to make it function.

> And don't worry - we have yet to find anything that cannot be made in CORE using this method even all our Guns in our shooter games are made from 'gun parts' so you can totally make your own weapons if you want to.

---

> **Q:** Oh there's community content? so anyone can create content - moderated by the CORE team?

> **A:** Yes, anyone can create content in CORE and share it with the community - it will be moderated by MantiCORE and voted on by users

---

> **Q:** Is it possible for custom environment objects like buildings?

> **A:** Yes, absolutely, using the primitives, smart objects, and templates.

## Lua

> **Q:** Does the Lua scripting system support use of external editors?

> **A:** Yes we support external editors for Lua. We also have a built-in stack frame debugger that allows you to set breakpoints, step into and over functions, and inspect variables. We even have autocomplete files for editors on our [Lua Dev Environment](extensions.md) page.

> Here is a screenshot of the built-in Lua debugger. I've paused execution and I am inspecting the script that handles zooming in my scope on the client - Don't worry if you are not a coder, you won't have to go this deep to make stuff in CORE - but if you want to, you can. That is what we mean by "opt-in complexity."

![CORE Lua Debugger](https://media.discordapp.net/attachments/651152898113142807/652728003985408000/unknown.png)

---

> **Q:** Does CORE support modules or classes for Lua?

> **A:** Yes via the require function. I used a free Lua JSON parser in my game by just including it with require.

## Marketing

> **Q:** Will CORE have built in analytics or will it use something like GameAnalytics?

> **A:** Will not be in for Alpha, but is on the roadmap. We will provide as much analytics as you need to create successful games, ramping up from Alpha.

## Control & Input

> **Q:** How much control do we have over keybindings?

> **A:** Currently, not all keys have keybinds. Remapping is possible

## Game Mechanics

> **Q:** Is there an implemented turn-based system, or a way to implement a combo system in an action game?

> **A:** You can definitely create those in Lua, and eventually we will make components / frameworks for those that we will share.

---

<!--
> **Q:** Is there persistence, ie can you handle a Farming sim?

> **A:** Yes? [NEED]

---
-->

> **Q:** Will we have NPCs?

> **A:** Not currently, but on the road map!

---

> **Q:** Will we be able to destroy things like structures and objects?

> **A:** Can be done with some work. We have a task a bit down the road to find a way to make that a lot simpler.

<!-- Stay tuned for [NEED] scheduled stream. -->

---

> **Q:** Does changing your avatar change its hitbox/hurtbox?

> **A:** A lot of focus was put into making sure that your avatar choice won’t have functional advantages/disadvantages.

---

> **Q:** Can you have mounts?

> **A:** Yes, you can even make gameplay focused on mounts, like a jousting game we'll show you in Alpha.

---

> **Q:** Can you make team based games?

> **A:** Yes absolutely. We have a Team Settings component which currently supports Free For All, Team Versus and Friendly. Some of our starting projects like Team Deathmatch and Capture and Hold and Battle Royale come with team settings as a default component

---

> **Q:** Do I have to use player CORE avatars?

> **A:** No. A player's avatar will be the default place character representation in game, but Creators can skin, modify, change or even hide the avatars in their game.

<!--
[NEED] ship example
-->

---

> **Q:** Can you attach things to your avatar?

> **A:** You can make full body costumes or change your avatar out for something you or someone else has built.

---

> **Q:** What if I don’t want my game to have mounts?

> **A:** You can disable mounts in your game as you want.

---

> **Q:** Restrictions on server size or load?

> **A:** Up to 32 players for Alpha.

## Performance

> **Q:** How does kit bashing work with performance?

> **A:** We provide a performance tool in the CORE Editor to help test your creations

<!--

> **Q:** Is there any limit to how many primitives/CORE created assets/scripts can be attached to any one "object."

> **A:** We’ve had 25,000 in game [NEED].
-->

## Art

> **Q:** Will there be a tutorial for making custom materials and textures?

> **A:** Yes, we already have tutorials for that already. Check out the [Custom Materials](tutorials/art/custom_materials.md) tutorial in our [Tutorials Section](generated/sitemap.md).

---

> **Q:** Can you make 2D games?

> **A:** Yes you can in a number of ways - we support orthographic camera, and some people have made 2D games in the UI system.

## UI

> **Q:** Are there ways to edit fonts in UI kind of like CSS?

> **A:** Yes, limited in alpha

<!--
## VFX

> **Q:** What kind of visual effects are available in CORE?

> **A:** [NEED]
-->

## Terrain & Sky

> **Q:** WIll CORE support terrain holes?

> **A:** Terrain is voxel based, so yes. Holes, caves, whatever you like.

---

> **Q:** There are a lot of details around the map such as foliage and rocks and whatnot. It looks great! But do all of those have to be hand placed, or is there a way to populate areas with details automatically?

> **A:** We have amazing object generator tool that will allow you to cover your entire map with full control over the randomness of the placement

## Audio

[CORE Audio Reference](tutorials/art/audio_reference.md)

> **Q:** Does the engine support real-time audio effects? For example, applying reverb to an audio listener when a character enters a large room.

> **A:** Matthew Pablo, our CORE Audio Designer, put together sampled and synthesized instruments, fully produced music tracks, and sound effect assets. All of these can be modified using our built-in audio editor. Most music tracks are kit-bashed and you can use them however you'd like. We will have more info, tutorials and guides on this in Alpha

> You can also dynamically adjust lots of things on audio clips besides normal post-effects. Matthew even made Music Construction Kits so you can dynamically adjust music and build up your own tracks from his pieces

> Just like with our 3D objects and Materials, you can also 'kitbash' audio to do things it wasn't nesc. intended to do. For instance, to create a creaking windmill sound - we pitched a wooden door opening sound down about 3 octaves and looped it. It made a great creaky windmill.

---

> **Q:** Also, will there be a time when downloading CORE will be like 100gb? Seems difficult to scale - can't say for sure until I see how the editor actually works. seems limiting at first glance but maybe not

> **A:** Hopefully not that huge. Currently it's a few gigs.

---

> **Q:** Is there no option in games (as a player) to adjust the volume?

> **A:** There currently isn't, but it is on our shortlist! For an interim work around, you can lower the CORE Editor volume in the Windows Volume Mixer. Right click on the speaker icon in your system tray and choose 'Open volume mixer.'

## Monetization

> **Q:** How will monetization work in CORE?

> **A:** We aren't ready to talk monetization just yet, but it's super important to us.

## Collaboration

> **Q:** Can you use git to collaborate on CORE projects, or is there a another system used?

> **A:** Yes you can use git or svn or pretty much whatever you want. CORE projects are actually very small text files, so they work in git quite well and, if you make folders at the root of your scene hierarchy, those act as file partitions making collaboration even easier as it lessens the chance for collisions.

> NOTE: The one 'gotcha' right now is that you don't want your .git folder to be inside each individual map folder, as currently CORE doesn't ignore it and copies it everywhere, which gets big. So, you want to do one of two things.... make a repro of your entire maps folder, with each game as a subfolder -OR- make a repro for each game, and put the actual project 1 level deeper however, we will be fixing this during alpha

---

> **Q:** I’m assuming you don’t want us to have public repos while CORE is still in alpha?

> **A:** That is correct.

## System Requirements for CORE

At the beginning of Alpha, this minimal spec will allow you to check out CORE, though your mileage may vary when it comes to playing or developing complex projects. For Alpha, a modern gaming PC is recommended for the best early experience.

### **Minimum System Requirements**

* **CPU:** Intel Core i5-7400 or AMD equivalent
* **RAM:** 8 GB
* **GPU:** NVIDIA GeForce GTX 1050 Ti or AMD equivalent
* **OS:** Windows 10 64-bit

### **Recommended System Requirements**

* **CPU:** Intel Core i5-7400 or AMD equivalent
* **RAM:** 16 GB
* **GPU:** NVIDIA GeForce GTX 1660 Ti or AMD equivalent
* **OS:** Windows 10 64-bit

There are a number of planned optimizations during Alpha and beyond which will greatly improve performance on lower spec machines.

---

> **Q:** So i noticed in the system reqs it says you need a "NVIDIA GeForce GTX 1050 Ti or AMD equivalent" is it possible to use CORE without a fancy GPU like this?

> **A:** The specs for Alpha are likely higher than they will be for launch, as we haven't done all our optimizations yet our VFX artist was working on a 900 series card for most of the project.
