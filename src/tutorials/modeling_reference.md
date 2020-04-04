---
id: modeling_reference
name: Modeling Complex Objects
title: Modeling Complex Objects
tags:
    - Reference
---

# Modeling Complex Objects in Core

<div class="mt-video">
    <video autoplay loop muted playsinline poster="/img/EditorManual/Abilities/Gem.png">
        <source src="/img/EditorManual/Art/BugShip.webm" type="video/webm" />
        <source src="/img/EditorManual/Art/BugShip.mp4" type="video/mp4" />
    </video>
</div>

## Introduction

Assets in Core are downloaded with the installation of the Core Launcher and Editor, and all unique 3D objects made for games are created out of this content. This allows for extremely fast loading of any Core project, for both players and creators. See the [Modeling Basics tutorial](modeling_basics) for a hands-on introduction.

### Community Content

The **Community Content** window in the Core Editor includes examples of the what users have created using Core Content as the fundamental components. All of the templates in Community Content can be imported to use and edit in any project. To learn more about using user-generated content, see the [Community Content guide](community_content.md).

### Manipulating Objects

Creating new 3D models in Core can be done by positioning, scaling, and rotating existing props and Basic Shapes. To learn more about adding Core Content to a project and manipulating objects, see the [Introduction to the Editor](editor_intro.md).

### Customizing Materials

Materials can be added by dragging and dropping them onto an object, and customized through the **Properties** window. To learn more about Materials and customization, see the [Custom Materials reference](custom_materials.md).

## Combining Objects

There are different ways to combine objects into units that can be manipulated together, and doing so allows you to handle the different pieces together in a convenient way.

### Folders

Folders can be used to organize projects according to your individual preferences. They are the best option for putting objects with similar purposes or in similar areas together without defining them as a single object.

![Folder Example](../img/ComplexModels/ComplexModels_FolderExample.png){.center}

#### Creating a Folder

1. Select the **Hierarchy** window.
2. Press <kbd>Ctrl</kbd> + <kbd>N</kbd> or right click and select **New Folder**.
3. Type a name for the folder and press <kbd>Enter</kbd>.

#### Adding Objects to a Folder

To add an object, to a folder, drag it onto the folder name until it is highlighted with a blue box around it. Toggling the arrow on the left side of the folder name will open it to display the folder contents, or close it to hide them.

![Highlighted Folder](../img/ComplexModels/ComplexModels_HighlightedFolder.png){.center}

#### Creating a Folder with Existing Objects

1. Select the objects to be added to the folder in the **Hierarchy** window using <kbd>Ctrl</kbd> + left click.
2. Press <kbd>Ctrl</kbd> + <kbd>N</kbd> or right click and select **New Folder Containing These**.
3. Type a name for the folder and press <kbd>Enter</kbd>.

### Groups

Creating a group allows you to unite a collection of 3D objects into a single entity, that you can copy and manipulate in one piece. With **Group Selection Mode** enabled, you will always select the whole group when you click on any object that is part of it.

#### Creating a Group from Existing Objects

1. Select the objects to be added to the group in the **Hierarchy** window using <kbd>Ctrl</kbd> + left click.
2. Right click one of the select objects and click **New Group Containing These**.
3. Type a name for the group and press <kbd>Enter</kbd>.

#### Switching between Group and Object Selection Mode

1. Find the ![Group Mode](../img/EditorManual/icons/Icon_GroupMode.png) or ![Object Mode](../img/EditorManual/icons/Icon_ObjectMode.png) icons in the **Toolbar**
{: .image-inline-text .image-background}
2. Select the drop down arrow next to the mode.
3. Select **Object Mode** to select individual objects within the group when clicked.
4. Select **Group Mode** to select the entire group when any object within the group is clicked.

### Parenting

Folders and groups can be added to other folders and groups. This allows for cleaner project organization, and will make a **child** object that is inside of another object (its **parent**) define its position relative to the parent object.

### Templates

Templates can be used to save grouped objects, collections of created objects, scripts, and scripted objects. Templates can also be used to share your creations on Community Content. See the [Template tutorial](collaboration_reference.md) to learn more.

## Best Practices with Models

### Renaming

Renaming custom objects and parts of complex objects makes future editing quicker, as well as making it possible to search for parts easily in the Hierarchy. Select an object and press <kbd>F2</kbd> to rename it.

### Collision

To simplify collision on complex objects, it is often helpful to add a larger invisible object that represents the edges for the purpose of deciding if another game object is touching it.

#### Creating a Collision Object

1. Select all the objects in the group, and in their **Properties** menu, set **Collision** to **Force Off**
2. Add a 3D Shape to the object group, and resize it to fit the collision area of the object. Larger collision volumes bump into players and other objects more easily, while smaller volumes are easier to avoid.
3. Open the collision object's **Properties** menu, and set **Visibility** to **Force Off**.
4. Set the object's **Collision** property to **Force On**

## Learn More

[Community Content](community_content.md) | [Template Tutorial](collaboration_reference.md) | [Modeling Tutorial](modeling_basics) | [Introduction to the Editor](editor_intro.md) | [Custom Materials](custom_materials.md)
