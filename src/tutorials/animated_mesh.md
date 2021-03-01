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

Animated meshes will require custom scripts to do more than animate in place or move to a specific location. To learn all the methods, parameters, and events associated with animated meshes, see the [Animated Mesh API](../api/animatedmesh.md).

### Non Player Characters

The Animated Mesh objects on their own are not Non Player Characters (NPC's). To animate these objects, they will need to be in the **Client Context**, similar to visual effects.

Creating collision objects and NPC behavior is possible, and there are a Community Content pieces that implement different AI behaviors.

## Finding the Animated Meshes

Animated Mesh objects can be found in **Core Content** window in the **Art Objects** section.

### Add an Animated Mesh to a Project

Non-humanoid animated meshes can be added like a 3D object by dragging and dropping into a the **Main Viewport** or the **Hierarchy**

## Humanoid Animated Meshes (Skinned Meshes)

Humanoid animated meshes have multiple parts that can be attached to a body to create a wide variety of unique, customizable characters.

### Add a New Humanoid Animated Mesh to the Project

1. Select either the **Humanoid 1** or **Humanoid 2** categories in the **Animated Mesh** section of **Core Content**.
2. Find the **Body** section, and drag one of the bodies into the scene to select it as a **Skeletal Rig**.

### Add Gear to the Skeletal Rig

Each animated mesh has four gear slots to which the Animated Mesh gear can be added. Gear will automatically be attached to the correct point in the mesh, and the slots do not represent any particular socket.

1. Select the **Gear** section for the same Humanoid animation mesh type as the body.
2. Drag the gear directly onto the body of the animated mesh.
3. In the menu that pops up on screen, select one of the available **Mesh Slots**.

## Materials

Materials can be added to non-humanoid animated meshes like any 3D object, to create a single uniform color, and can be added to the skeletal rig and individual gear like normal static meshes.

To change the individual colors that are part of an animated mesh material, create a new custom material from the material that the mesh begins with. To learn more about using custom materials, see the [custom materials](custom_materials.md) reference.

## Animations

Animated meshes include sequences of movement for different game scenarios, that are automatically blended to move from one to the next seamlessly. The animations for the human meshes are very similar to player animations, sometimes the classification is different for animated meshes and stances.

See the [Animated Mesh](../api/animatedmesh.md) section of the Core Lua API Reference to learn more about scripting animations.

### Animation Stance

Animation stances are states of movement that the mesh will continue until a new animation stance is set.

### Animations

Other animations are intended to be used once, and then let the mesh return to the animation state.

## Attaching Core Objects

Animated meshes cannot use actually **Equipment** objects the way players are, but the objects can be attached to different sockets on an animated mesh the same way equipment is attached to players.

The **Bind Pose** animation stance is designed to make it easy to determine where objects should be positioned relative to the mesh.

To attach objects to the appropriate mesh, you can use a script and the `AttachCoreObject` method. For more specific examples, see the [Core API](../api/animatedmesh.md).

```YourMeshName.AttachCoreObject(object, socketname)```

## Learn More

[Example Code](../api/animatedmesh.md) | [Player Animations](../api/animations.md) | [Custom Materials](custom_materials.md)
