
# Interaction System

## Overview

The **Interaction System** allows games to have unique systems of reacting to player input, both in the 2D UI layer and in the 3D game space that go beyond the keyboard inputs, triggers, and UI Buttons that are built into Core. Custom interactions are created by adding the included scripts to the Hierarchy and designating UI and mesh objects that players should interact with through their Custom Properties.

The Interaction System contains 4 different types of interactions, the **Modules**, each of which has 13 potential events that creators can use to change the way interaction works and get input from players. All Interaction System modules work on the Client Side, but they can also broadcast an event to the server.

The sample **Components** included in the Interaction System allow creators to do simple interactions without requiring any scripting, like showing a tooltip on a UI button, spawning an object, or changing an object's color.

!!! note
    The **Interaction System** works only in a **Client Context**, which means any change made or object spawned will only be visible to the player doing the interaction. To learn more, see the [Networking](networking.md) reference.

<!-- TODO: Check that link -->

## Adding the Interaction System to a Project

### Add the Interaction System Package

1. In the **Core Content** window, open the **Game Components** section under **GAME OBJECTS**.
2. Open the **Interaction** category to find the **Interaction System Package** template.
3. Drag the **Interaction System Template** into the scene or **Hierarchy** to add the scripts and examples to the project.

### Access the Interaction System Modules and Components

In the **Project Content** window left-side navigation, open the **My Scripts** section and open the **Interaction System** folder that was added with the package.

- The **Components** folder contains examples of interactions which can be used as a way to create interaction without scripting.
- The **Examples** folder contains dependencies for the examples. The examples themselves can be found in the **My Templates** section, detailed below.
- The **Modules** folder contains the four different interaction modules.

!!! warning
    The **Interaction System** creates folders both in **My Scripts** and **My Templates**. The **My Templates** section contains the examples, and all the components and modules of the Interaction System are available in **My Scripts**.

### Find the Examples

Once the **Interaction System Package** has been added to your project, all the examples and component scripts can be found in the **Project Content** window.

1. Open the **Project Content** window and find the **My Templates** section in the left-side navigation.
2. Open the **Interaction System** folder in **My Templates**.
3. Select the **Examples** folder to find the four interaction examples.
4. Drag one of the examples into the game and press **Play** ![Play](../img/EditorManual/icons/Icon_Play.png) to test the interaction.
{ .image-inline-text .image-background }

!!! note
    For all the examples, ``ability_primary`` is the default keybinding, and are therefore activated by clicking. This can be changed by changing the **PressBinding** property on the component scripts.

## Interaction System Modules

### Cursor Interaction Module

The **Cursor Interaction Module** allows custom interactions with UI Buttons, including selecting multiple elements.

#### Example

- Hovering the mouse over the ``?`` icon reveals a tooltip using the **Toggle Tooltip Component**.
- Clicking and dragging on the outer part of the window will reposition it using the **Draggable Object Component**.
- Each of the white boxes will change color when clicked using the **Change Color Component**, and add themselves to a selection set using the **Selectable Component**.

<!-- TODO: Add video of interaction example -->

### Look

The **Look Interaction Example** checks if a player's reticle (or the center of the screen, regardless if there is a displayed reticle) is intersecting a specific object.

#### Example

- When the center of the screen is over the sphere, it should turn yellow using the **Change Color Component**, and show a ring on the floor using the **Toggle Visibility Component**.
- When clicked, the sphere should change color to Blue, also from the **Change Color Component**.
<!-- TODO: Add video of interaction example -->

### Pointer

Similar to the **Cursor Interaction Module**, the **Pointer Interaction Module** uses the position of the cursor, but for objects in the world, rather than UI. It has the added benefit of being able to detect the angle of intersection with the mouse and the surface of the target object.

#### Example

Drag the **Pointer Interaction Template** from **Project Content** into the scene, and start a preview. The cursor will be visible, and the sphere can be interacted by moving the cursor over it, and by clicking.

- Moving the mouse over the cube from any point should change its color using the **Change Color Component**.
- Clicking the sphere will also change its color using the **Change Color Component**, but also spawns VFX Muzzle Flash that is rotated to show the direction of collision between the pointer and the object, using the **Spawn Object Component** with the **UseInputNormal** and **UseInputPosition** properties enabled.

<!-- TODO: Add video of interaction example -->

### Trigger

The **Trigger Interaction Module** works much like a client-side interactable trigger, but allows for custom keybindings and has more events that can be accessed for that interaction.

!!! info
    This module will react to Trigger interactions by the local Player or all Players depending on the Input Settings. By default the Trigger module will only react to the local Player in order  to act like the other Input Modules. If the setting "TriggerLocally" is false then Trigger inputs from all Players will run. This can be a useful way to mimic networked play without using any actual networking but it could affect your interactions in unexpected ways.

<!-- TODO: Add video of interaction example -->

#### Example

Drag the **Trigger Interaction Template** from **Project Content** into the scene, and start a preview. You can interact with the cube by walking close enough to overlap its trigger, and then clicking.

## Module Events

The Interaction Modules each have several events that can be used as points to broadcast to server scripts, spawn VFX or sound, or anything else that supports individualized design of in-game interactions. SO

### Events for All Modules

- HoverBegin(position, normal)
- Hover(position, normal)
- HoverEnd(position, normal)
- PressBegin(binding, position, normal)
- PressEnd(binding, position, normal, wasDragging)
- Selected()
- Deselected()
- SetData(component, ...)

### Events Only for Cursor Interaction Module

- DragOverBegin()
- DragOverEnd()
- DragBegin(position, normal)
- DragEnd(position, normal)
- Dropped(position, normal, ...)

## Components

### Adding a Component

All components can be found in the **My Scripts** section of **Project Content**. Open the **Interaction System** folder and then the **Components** folder.

1. Place the objects that should be interacted with using the component in a group that will server as the ``ComponentRoot`` and place that group in a **Client Context** folder.
2. Drag the the component from **Project Content** into the **Client Context** folder.
3. Select the group created in step one, and drag it into the ``ComponentRoot`` custom property of the Component script in the Hierarchy.
4. In **Project Content**, find the **Modules** folder in the **Interaction System** folder under **My Scripts**. Choose the type of interaction, and drag the corresponding Module script into the ``APIInteractionModule`` custom property of the Component script.
5. If there are multiple objects that could potentially be interactable: multiple triggers, buttons or objects with collision, drag the one that should be used into the ``SubTarget`` custom property of the Component script.
6. Change the ``PressBinding`` custom property to a different keybinding to make the interaction happen with a key other than left click. [See the list of all available keybindings here.](../api/key_bindings.md)
7. Configuring the remaining custom properties, like Colors for the **Change Color Component** or a template for the **Spawn Template Component**.

### List of All Components and their Functions

| Component | Description | Notes |
| --- | --- | --- |
| BroadcastEventComponentClient | Broadcasts an event when configured interactions occur. Optional event data can be sent with the event through Custom Property configuration or through the lua API. |  |
| ChangeColorComponentClient | Changes the color of an object when configured interactions occur. |  |
| DraggableObjectComponentClient | Allows an UI element to be moved around by the player when the configured interactions occur. | Cursor Module only |
| DropTargetComponentClient | Designates a UI element where a UI element with the DraggableObjectComponentClient can be placed. | Cursor Module only |
| SelectableComponentClient | Adds or removes the object from a selection set when configured interactions occur. |  |
| SpawnObjectComponentClient | Spawns a template when configured interactions occur. |  |
| ToggleEffectsComponentClient | Plays or stops Audio or Vfx when configured interactions occur. |  |
| ToggleTooltipComponentClient | Shows a UI tooltip with specified text when configured interactions occur. |  |
| ToggleVisibilityComponentClient | Shows or hides the object when configured interactions occur. |  |

---

## Learn More

[Trigger Reference](trigger.md) | [UI Reference](ui.md) [**Game Components**](../api/components.md) | [Keybindings](../api/key_bindings.md)
