---
id: physics_objects
name: Physics Objects Reference
title: Physics Objects Reference
tags:
    - Reference
---

# Physics Objects

## Overview

The **Physics Object** is a **Core Object** that implements the **Damageable** interface. It has simulated physics to interact with gravity, players, and other objects. Similar to a **Damageable Object**, it has properties, events, and functions for objects which can take damage and die. See more info at [PhysicsObject API](../api/physicsobject.md).

The **Physics Object** uses a shape to track collision and damage. The shape can either be a sphere, cube, and capsule.

## Use Cases

<div class="mt-video" style="width:100%">
    <video autoplay muted playsinline controls loop class="center" style="width:100%">
        <source src="/img/DamageableObjects/demo.mp4" type="video/mp4" />
    </video>
</div>

![!Project Content](../img/DamageableObjects/project_content.png){: .center loading="lazy" }

## Learn More

[DamageableObject](../api/damageableobject.md) | [Damageable](../api/damageable.md) | [Damage](../api/damage.md) | [AIActivity](../api/aiactivity.md) | [AIActivityHandler](../api/aiactivityhandler.md) | [Vehicles](../references/vehicles.md)
