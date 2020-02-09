---
id: collaboration
name: Collaboration & Source Control in CORE
title: Collaboration & Source Control in CORE
categories:
    - Tutorial
---

# Collaboration & Source Control in CORE

## Overview

Working on projects with multiple people can get complicated. Now we live in the future, where *source control* exists.

Using a source control system, you are able to maintain a history of your projects and every change you ever made to them. You can save files and make changes, but if you soon realize something went very wrong and everything is broken you can quickly revert back to an earlier & working version of your project. This can save months of time, with big or complex projects--or even for a solo project!

!!! info What even is Source Control?
    Source control (or version control) is the practice of tracking and managing changes to code. Source control management (SCM) systems provide a running history of code development and help to resolve conflicts when merging contributions from multiple sources. Whichever SCM system you use really comes down to personal preference.

In this tutorial we'll teach you how to use **Git**, the most commonly used and recommended SCM solution, and how to leaverage **GitHub** for hosting your repository.

* **Completion Time:** 10 minutes
* **Knowledge Level:** No prior knowledge required
* **Skills you will learn:**
    * How to use Git with CORE

---

### Collaboration in CORE Itself

If you're not too worried about making mistakes, or just want to share quick things, CORE has many ways to share content already built-in.

If you're working with multiple people, instead of using "formal" source control, you could just publish templates to **Community Content** and have your teammates access what you make that way.

You can also publish your games privately, so that only people you give the link to can play and view it.

To read more about how to do this, check out the [Templates](../../gameplay/collaboration_reference/) tutorial. Both templates and games can be published privately, so that you can control who may access them.

---

## Tutorial

Setting up source control can sound intimidating if you've never done it before--but it's easier than it sounds!

### Getting Started with Git

1. Go to [GitHub.com](https://github.com/) and either log in or create a new account if you do not have one yet.

2. Create a New Project on GitHub.

    !!! warning CORE NDA
        During CORE's closed alpha, you must set the project to **Private** to maintain the Non-Disclosure Agreement.

3. Change any settings you might want, if you're starting from scratch you'll want to check the **"Initialize this repository with a README"** button.

4. Now you have a GitHub project repository! This is the web location where all your files will be saved each time you commit new changes to the project.

    Next is connecting a CORE project to GitHub by setting up the repository (often shortened to *"repo"*) on your computer.

5. There are two ways to interact with Git. You could either use the console / command prompt or a graphical client, like [GitHub Desktop](https://desktop.github.com/).

    For beginners, using GitHub Desktop can be much easier and we'll assume you are using it for the remainder of this tutorial.

### Initilizing the Repository

We first need to choose a location to clone the repostory to, and this will work as you might expect--we're going to create it within the folder where your game is located.

You won't want to just initialize your repository inside your game's folder though, because with the autosave feature in CORE, a game with many revisions may experience a ~5-10 second delay to start a preview as a large number of files are copied into the `.git` folder from the autosave copies.

For this reason, here are the recommended steps below:

1. Close CORE before starting this process.

2. Create a new folder inside of your game's folder, like so:

    `C:\Users\User\Documents\My Games\Core\Saved\Maps\GameName\temp\`

    *Note: "User" will be your CORE username, and you can name the last folder, called "temp" in this case, whatever you want.*

    Usually, all game files are directly in the folder with the project's name, but Git can only clone a repository in an empty folder, so we have to do inside of `temp` and then move the files back into the game's folder.

3. Open GitHub Desktop, and click **File** > **Clone Repository** to choose where to setup your project. Navigate to the `temp` folder inside of your chosen game folder, and clone your project into that it.

4. Now, in the file explorer, you will see that there is a new folder inside of `temp` that is named after your GitHub project. Open it up and drag its contents two levels upwards, into your game's folder. To confirm that you've done everything correctly, you should verify that there now is a `.git` folder inside of your game's one.

    `C:\Users\User\Documents\My Games\Core\Saved\Maps\GameName\.git`

5. Return to GitHub Desktop and open up your moved repository via **File** > **Open Repository**. Now you'll see a bunch of changes show up, Git has recognized all your game's files now that the repository resides within your game folder!

    Add a commit message in the bottom left corner that describes what you did--something like "Adding the first version of my game!". Then commit the changes to your project using the blue button, and click "Push" in the top right of the window. Now your project is officially committed safely to GitHub!

6. Next time you make a change to the game within CORE, Git will pick up the changed files for you. Each time you're done working or want to commit a big change, come back to GitHub Desktop and commit them with a clear message!

Congrats on getting set up, and happy committing!

## Tips on Using CORE with Git

A CORE project will work best with Git when the **Project Hierarchy is very efficiently organized**.

This usually means separating parts into different folders. For example, you might keep all the scripts and gameplay objects in one folder, and all art models in another separate folder.

With this split, you could have one team member work on scripting a game, while the other team member works on art. As long as they stay completely within their own Hierarchy folders, they will be able to work from their own computers and commit to the same project.

Here's an example of a project Hierarchy with that basic split of Art / Gameplay:

![CORE Project Hierarchy](../img/EditorManual/gitProjectHierarchy.png){: .center}
