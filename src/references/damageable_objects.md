---
id: damageable_reference
name: Damageable Objects Reference
title: Damageable Objects Reference
tags:
    - Reference
---

# Damageable Objects

## Overview

The **Damageable Object** is a **Core Object** that implements the **Damageable** interface and has properties, events, and functions for objects which can take damage and die.

The **Damageable Object** streamlines damage and destroying objects. Children of a **Damageable Object** that are hit by a projectile (or another damage source), will look for an ancestor that is a **Damageable** and automatically deduct the damage from health of the **Damageable**. Creators can control what happens when the health of the **Damageable Object** reaches 0 through the [DamageableObject type in the Core Lua API](../api/damageableobject.md).

A benefit to **Damageable Objects**, is no scripting is needed to damage an object and destroy it. This can all be controlled from the custom properties, which makes it quick and easy to setup.

## Use Cases

There are many use cases for the **Damageable Object**. Here are a few examples of how the **Damageable Object** could be used in a game.

- Breakable Objects

    Some games have objects that can be broken and reveal loot for the player. For example, setting the property **Destroy on Death** to spawn breakable containers, like crates or pots.

- Dummy

    The dummy object that has the **Start Immortal** property enabled, can be used to return the amount of data the weapon or projectile does, without being destroyed.

- Enemy AI

    An enemy that is immune to damage until the shield has been destroyed. By using nested **Damageable Objects**, the parent **Damageable Object** has the property **Start Invulnerable** enabled, and then disabled after the child **Damageable Object** is destroyed.

Here is an example of an NPC (Non-Player Character) that has a drone blocking the damage. The **Damageable Object** for the NPC has the property **Start Invulnerable** enabled. After the drone **Damageable Object** is destroyed, the NPC **Damageable Object** has the `isInvulnerable` property set to `false`.

<div class="mt-video" style="width:100%">
    <video autoplay muted playsinline controls loop class="center" style="width:100%">
        <source src="/img/DamageableObjects/demo.mp4" type="video/mp4" />
    </video>
</div>

See the [Damageable Object](../api/damageableobject.md) API for further examples.

## Where to find Damageable Object

The **Damageable Object** can be found in **Core Content**, under the category **Gameplay Objects**.

![!Project Content](../img/DamageableObjects/project_content.png){: .center loading="lazy" }

## Networked Damageable Object

By default, a **Damageable Object** that is placed into your **Hierarchy** will be networked. This means it will have collision, and server side gameplay. In most cases, especially when creating AI Enemies that the player can damage, the **Damageable Object** will be networked.

## Client Only Damageable Object

A **Damageable Object** that is client only (i.e. placed into a **Client Context**), has no collision. Which means it cannot be hit by a weapon or projectile. Damage can still be applied to the **Damageable Object** from a client script.

!!! info "`ApplyDamage(Damage)` can also be used on the client to apply damage to the **Damageable Object**."

## The Damageable Properties

The **Damageable Object** uses the **Damageable** interface that unifies health, damage, and death behavior with players and some objects (i.e. Vehicles, Physics Shape). Below are the properties of the **Damageable** interface that can be found on a few different objects in **Project Content**.

| Property Name | Description |
| ------------- | ----------- |
| Max Hit Points | Maximum hit points of the object. Values less than or equal to 0 will be ignored. |
| Starting Hit Points | The hit points of the object when the object is spawned. Cannot be greater than **Max Hit Points** or less than 0. |
| Start Invulnerable | When true, the object cannot take damage. |
| Start Immortal | The object doesn't automatically die when the hit points is less than or equal to 0. |
| Destroy on Death | If true, when the object dies, destroy the object. |
| Destroy on Death Delay | Time, in seconds, after the object dies when it will be automatically destroyed if **Destroy on Death** is true. |
| Destroy on Death Client TemplateId | Spawns the template on the client at the location of the Damageable after the death delay. This is the most efficient for visual-only effects. |
| Destroy on Death Networked TemplateId | Spawns a networked template at the location of the Damageable after the death delay. This is useful for spawning gameplay from a destroyed Damageable. |

See [Damageable Object](api/damageableobject/) API for information and examples.

## Objects that Implement Damageable Interface

Some objects implement the **Damageable** interface that allows for it to receive health, damage, and death behaviour. **Damageable Objects** have `hitPoints` and `maxHitPoints` properties in the **Damageable** category of the object **Properties** panel.

![!Properties](../img/DamageableObjects/properties.png)
*Properties of a Vehicle*
{: .image-cluster}

Below is a list of some of the objects that implement the **Damageable** interface.

- [Vehicle Object](../api/vehicle.md)
- [Damageable Object](../api/damageableobject.md)
- [Physics Object](../api/physicsobject.md)
- [Player Object](../api/player.md)

!!! info "Vehicle and Physics Object will default to **Start Invulnerable**."

## Learn More

[DamageableObject](../api/damageableobject.md) | [Damageable](../api/damageable.md) | [Damage](../api/damage.md) | [AIActivity](../api/aiactivity.md) | [AIActivityHandler](../api/aiactivityhandler.md) | [Vehicles](../references/vehicles.md)
