---
id: animated_mesh
name: Animated Mesh Reference
title: Animated Mesh Reference
tags:
    - Reference
---

# Animated Meshes in Core

## Overview

**Animated Meshes** are a fantastic resource for creating interactive elements in the game using objects that have customizable movement sequences.

### Interactive Example

To see the **Animated Mesh** objects firsthand before adding them to a project see the [Example Project](https://www.coregames.com/games/b31f83/animmeshpreviewer). Here you can see sample Animated Mesh objects and test their distinct animations.

### API Example Code

Animated meshes will require custom scripts to do more than animate in place or move to a specific location. To learn all the methods, parameters, and events associated with animated meshes, see the [Animated Mesh API](examples.md).

### Non Player Characters

The Animated Mesh objects on their own are not Non Player Characters (NPC's). To animate these objects, they will need to be in the **Client Context**, similar to visual effects.

Creating collision objects and NPC behavior is possible, and there are a Community Content pieces that implement different AI behaviors.

## Finding the Animated Meshes

Animated Mesh objects can be found in **Core Content** window in the **Art Objects** section.

### Add an Animated Mesh to a Project

Animated meshes can be added like a 3D object by dragging and dropping into a the **Main Viewport** or the **Hierarchy**

### Find Specific Animated Mesh Info

When you selected an Animated Mesh object in Core Content, you can open the **Properties** window to see more information about the mesh, including the available animations, and the sockets that represent the different parts of the mesh, similar to player models.

## Materials

Materials can be added to animated meshes like any 3D object, to create a single uniform color.

To change the individual colors that are part of an animated mesh, create a new custom material from the material that the mesh begins with. To learn more about using custom materials, see the [custom materials](custom_materials.md) reference.

## Animations

Animated meshes include sequences of movement for different game scenarios, that are automatically blended to move from one to the next seamlessly. The animations for the human meshes are very similar to player animations.

### Animation Stance

Animation stances are states of movement that the mesh will continue until a new animation stance is set.

### Animations

Other animations are intended to be used once, and then let the mesh return to the animation state.

## Equipment

Animated meshes cannot use actually **Equipment** objects the way players are, but the objects can be attached to different sockets on an animated mesh the same way equipment is attached to players.

The **Bind Pose** animation stance is designed to make it easy to determine where objects should be positioned relative to the mesh.

To attach objects to the appropriate mesh, you can use a script and the ```AttachCoreObject``` method. For more specific examples, see the [Core API](https://docs.coregames.com/core_api/#animatedmesh).

```YourMeshName.AttachCoreObject(object, socketname)```

## Learn More

[Example Code](examples.md) | [Player Animations](animations.md) | [Custom Materials](custom_materials.md)
