---
id: collaboration
name: Collaboration & Source Control in Core
title: Collaboration & Source Control in Core
tags:
    - Tutorial
---

# Back Up Your Project Using GitHub

## Overview

Core projects are saved locally on your computer, and therefore if you
want to move them between computers, or share the project file with someone else, you will need a way to upload them.

Core project files are actually quite small, so it is possible to just upload them to any cloud server. What using **GitHub** will allow you to do is synchronize changes to an online version, and keep a history of the changes. You can go back to an older version, back up your project, and collaborate with others on the same project.

## The Core Project File

Core project files, called **Maps** are stored in a different place from the Core Editor and Launcher.

There are two ways to find your project folder: the normal way you would find any file saved on your computer using the **File Explorer**, and directly from the **Core Editor** itself.

### Open the Project File using the File Explorer

1. Open **My Documents**
2. Find and open the folder called **My Games**
3. Inside, you should find a folder called **Core** (it may be **CORE**).
4. Open the **Saved** folder
5. Open the **Maps** folder
6. In this folder, you should one folder for each saved project in the Core Editor.

#### Open the Project File from the Core Editor

1. Open your project in the Core Editor.
2. Click **File** in the top menu bar.
3. Select **Show Project in Explorer**

## GitHub Desktop

GitHub Desktop is a program that allows you to easily using Git and GitHub for saving changes to a project. It is not the only way to do so, but the most straight-forward to start out with.

### Install GitHub Desktop

You can install GitHub Desktop using [the link to download on their website](https://desktop.github.com/).

### Create a GitHub Account

Once GitHub Desktop has installed, it will prompt you to create an account. This redirects to the GitHub web page again, and then will log you on to GitHub desktop.

Once you have entered your GitHub credentials, you will also be asked to give a name and e-mail. The login is to check if you are the person who gets to change the file, and this second name and e-mail step is just to display who made the changes, and can be your name or something generic.

You can log in to a GitHub account, and change the name by clicking **File** and selecting **Options**.

## Adding the Project

Projects saved using **Git** are called **repositories**.

### Add the Project as a Repository

Click **File** and select **New repository...**.

1. Give it a name. This can match your project name, but will need to be different from your other repositories.
2. In the **Local path** field, click **Choose** and navigate to your project folder.
3. Make sure the **Git ignore** field is set to **None**.

You can add a license, which determines the ways other people are allowed to use your project, but this will only matter if you choose to make it public when it is uploaded. [You can learn more about liscensing your repository on GitHub's website](https://help.github.com/en/github/creating-cloning-and-archiving-repositories/licensing-a-repository).

## Saving and Uploading

In the next step, we will talk about how to save (**commit**) your changes and upload (**push**) the changes to an online version of the project, a **remote repository**.

### Ignoring Files

The Core Editor does not need every file in the folder to open a project. Some are generated when the project opens, so you can save time and space by not uploading those files. This is what a **.gitignore** file does.

It is literally just a list of file and folder names that Git does not need to keep track of.

1. In the top toolbar, select **Repository** and then **Repository settings...**.
2. In the menu that pops up, select the **Ignore files** tab.
3. Copy and paste the text below into the text box:

    ```sh
    # Exports folder is entirely generated
    Exports/

    # User settings are per user
    UserSettings/

    # Local storage for testing persistent storage
    Storage/
    ```

## Downloading the Project

## Using Git for Collaboration

### Using Templates

## Version Control Vocabulary

- Git
- GitHub
- Repository
- Local Repository
- Remote Repository
- .gitignore
- Commit
- Push
- Pull
- Merge
- Merge Conflict