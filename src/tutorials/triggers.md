---
id: triggers
name: Trigger Reference
title: Trigger Reference
tags:
    - Reference
---

# Triggers

## Overview

Triggers are CoreObjects that detect collision with a player without actually preventing players from walking through them. Instead, they fire events that can be used to create changes to the game when a player enters a certain area.

A number of Core **Game Components** use triggers, like the **Teleporter**, **Player Launcher**, **Named Location**, and all **Equipment**. See the [**Game Components**](../api/components.md) reference for more information.

### Making Triggers Visible

Triggers are not always visible in the project **Main Viewport**, like **Spawn Points** and the bounding boxes for **Decals**.

Press the ++V++ key to make Triggers visible or invisible.

## Trigger Events

Triggers can fire up to three events: One for when a player enters the trigger area, another when a player leaves the trigger area, and an optional third one for when a player presses the **Interact** key (++F++ by default) while inside a trigger area.

You can see examples of using these three events in the [Trigger](../api/trigger.md) object section of the Core Lua API Reference.

### Interactable Triggers

Triggers can be marked **Interactable**, when players should have the option to trigger a new event, rather than having it happen automatically.

To make a trigger Interactable:

1. Select it in the **Hierarchy** and open the **Properties** window.
2. In the **Gameplay** section, the box next to the **Interactable** property.
3. Select the **Interaction Label** property to enter the text that will display when the player enters the trigger.

Both the **Interactable** property and the **Interaction Label** can be changed through scripts. See the [Trigger](../api/trigger.md) API reference for more information.

### Overlapping with Core Objects

Currently, new objects do not automatically trigger a begin overlap and end overlap event with triggers.

To make objects able to activate Trigger events:

1. Select the objects in the **Hierarchy** and open the **Properties Window**.
2. In the **Gameplay** section, check the box for **Interacts with Triggers**

### Disabling Trigger Interaction for All Objects in Older Projects

Trigger interaction was previously enabled for all static meshes, so older Core projects will have this enabled for all static meshes.

To make a project more performant and remove collision for all static meshes:

1. In the **Hierarchy's Search Bar** click the funnel and mouse over the **Filter by Object Type** menu.
2. Select `/staticMesh` and press ++Enter++ in the search bar to select every static mesh in the project.
3. Open the **Properties** window, and uncheck the box next to **Interacts with Triggers**.

Once you have done this, you can manually re-enable trigger collision for objects that do need this for gameplay.

## Creating a Trigger Script Using the Script Generator

The **Script Generator** window in the Core Editor has a number of sample scripts that can be used for common patterns, including one that includes all three of the Trigger events.

1. Open the Script Generator through the **Script** button, or by selecting **Window** and **Script Generator**.
2. In the first drop down option, select **Event: Trigger Overlap**.
3. Select **Create New Script** and give the script a name.
4. Find the script by name in the **My Scripts** section of the **Project Content** window.
5. Drag the script onto the trigger in the **Hierarchy** to make the script a child of the trigger.

---

## Learn More

[**Trigger** type in the Core API Reference](../api/trigger.md) | [**Game Components**](../api/components.md)
