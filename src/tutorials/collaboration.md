---
id: collaboration
name: Collaboration & Source Control in CORE
title: Collaboration & Source Control in CORE
categories:
    - Tutorial
---

# Collaboration & Source Control in CORE

## Overview

Working on projects with multiple people can get complicated. Now we live in the future, where *souce control* exists.

**Source control** is a way to maintain history of your projects. You can save files and make changes, but if you soon realize something went very wrong and everything is broken in your more recent changes to the project, you can use source control to return to an earlier & working version of your project. This can save months of time, with big or complex projects--or even for a solo project!

Some of the most common platforms for source control are **Github** *(Git)* and **Perforce** *(P4V)*, and in this tutorial we'll go over the more straightforward and quickly accesible of the two--source control using Git.

!!! info "Whatever works, works!"
    There are many different kinds of source control--the term just means backing up your project as you save so that you can "go back in time" if you need to. Use whatever form of source control you feel comfortable with.

* **Completion Time:** 10 minutes
* **Knowledge Level:** No prior knowledge required
* **Skills you will learn:**
     * How to use Git with CORE

---

### Collaboration in CORE Only

If you're not too worried about making mistakes, or just want to share quick things, CORE has many ways to share content already built-in.

If you're working with multiple people, instead of using "formal" source control, you could just publish templates to **Community Content** and have your teammates access what you make that way.

You can also publish your games privately, so that only people you give the link to can play and view it.

To read more about how to do this, check out the [Templates](../../gameplay/collaboration_reference/) tutorial. Both tutorials and games could be published privately, so that you can control who may access them.

---

## Tutorial

Setting up source control can sound intimidating if you've never done it before--but it's easier than it sounds!

### Getting Started with Git

1. Go to [github.com](https://github.com/) and either log in or create a new account if you do not have one.

2. Create a New Project on Github.

     During CORE's closed alpha, you must set the project to **Private**  to maintain the Non-Disclosure Agreement.

3. Change any settings you might want--if you're starting from scratch you'll want to check the *"Initialize this repository with a README"* button.

4. Now you have a GitHub project repository! This is the web location where all your files will be saved each time you commit new changes to the project.

     Next is connecting a CORE project to Github by setting up the repository (often shortened to *repo*) on your computer.

5. There are many ways to clone a github repo onto your own computer. You could:

     - Use the console / command prompt to connect to github.
     - Use [Github Desktop](https://desktop.github.com/) as a visual program to pull the project and commit changes.

For beginners, using Github Desktop can be much easier.

### Initilizing the Repository

You won't want to just initialize git in your game's folder, because with the autosave feature in CORE, a game with many revisions may experience a ~5-10 seconds delay to start a preview as a large number of files are copied into the .git folder from the autosave copies.

For this reason, here are the recommended steps below:

1. Close CORE before starting this process.

2. Move your desired game a folder deeper in the file explorer, like so:

     ```C:\Users\User\Documents\My Games\Core\Saved\Maps\GameName\data\```

     *Note: "User" will be your CORE username, and you can name the last folder, called "data" in this case, whatever you want.*

3. Move all the game files into the folder you just created.

4. Initialize git just outside it.

It should appear the same in core, and then no worries about the autosave copies into .git slowing anything down.
