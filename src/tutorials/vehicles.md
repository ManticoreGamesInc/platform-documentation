---
id: vehicles
name: Vehicle Reference
title: Vehicle Reference
tags:
    - Reference
---

# Vehicle Reference

## Overview

**Vehicles** allow game creators to easily implement physics for tanks and automobiles. Previously, the only option was to attach a model of a vehicle to a player and use **Player Settings** to adjust some quick physics. The introduction of vehicles streamlines the process of creating a car, truck, or even a tank with easy customization of its physics and interaction with the world.

## Types of Vehicles

### Four-Wheeled Vehicles

**Four-Wheeled Vehicles** provide everything you need to build 4WD cars, ATVs, and more. This vehicle object includes properties to define the shape of the vehicle, the location and size of the four wheels, physics properties such as mass and center of mass, and driving properties such as max speed, acceleration, and turn radius. The four-wheeled drive model simulates the rotation of the 4 tires on the driving surface.

### Treaded Vehicles

**Treaded Vehicles** can be used to build tanks. Like **Four-Wheeled Vehicles**, you can define the shape of the collision box, mass, center of mass, and acceleration. The driving model for **Treaded Vehicles** simulates two tracks that turn independently as the vehicle moves and turns. **Treaded Vehicles** have 2 treads instead of 4 wheels. Treads are defined by a tread radius, tread width, and tread position. **Treaded Vehicles** replace turn radius with a turn speed property that controls how quickly the tank can turn..

## Vehicle Properties

<!-- TODO: This could be a table, a bunch of h3 sections, or a ul. Whatever makes it easy to find the specific info you want quickly but leaves enough space for the explanation -->

| Property                                 | Description |
| ---------------------------------------- | ----------- |
| Max Speed                                | The maximum potential speed of a vehicle on flat terrain. It is an approximation because the slope of the ground, the acceleration, the friction, mass, and other properties all impact the actual performance of the vehicle. A player should be able to achieve close to the speed set (in `cm/sec`) with this value.<br /><br />Helpful tip: Multiply `MPH` by `44.704` and `KMH` by `27.778` to get `CM/sec`. |
| Acceleration                             | The amount of power the engine exerts to get up to max speed. This property is also an estimate since it is also affected by friction, mass, and max speed. This property is closely related to `cm/sec^2`.<br /><br />Helpful tip: If you are trying to match a car's `0-60 `speed, you can use the formula: `desired speed / seconds`. For example, a Lamborghini can reach `0-60` in `2.5` seconds. That would be approximately `60 * 44.704` (to convert from `MPH` to `CM/Sec`) `/ 2.5`... or an acceleration value of approximately `1,073`. |
| Friction                                 | The amount of friction tires or treads have on the ground. The lower the friction, the more the vehicle will slide. The friction of the vehicle also interacts with the friction of the material the vehicle is driving on.<br /><br />Helpful tip: A friction below `1` is very slippery. A friction above `5` is extremely sticky. |
| Brake Strength                           | The maximum deceleration of the vehicle when stopping. This force is applied every tick until the vehicle is stopped. |
| Mass                                     | The resistance of the vehicle to changes in speed in `kg`. Heavier vehicles require more max speed and acceleration to get going and are affected less by other physics objects and slopes when they have momentum. Lighter vehicles might spin out faster but can get going much faster. |
| Center of Mass Offset                    | The average position of the mass, offset from the vehicle's position. A low center of mass makes a vehicle stable and hard to flip. A more forward or backwards center of mass can improve handling. Vehicles will flip and rotate around their center of mass. The center of mass is displayed when the vehicle is selected by the sphere helper object. |
| Body Offset and Scale                    | The collision box of the vehicle. The size of the box should be set with the scale offset and the position relative to the vehicle's pivot. |
| Turn Radius (**Four-Wheeled Vehicles** Only) | The radius, in `cm`, measured by the inner wheels of the vehicle while making a complete turn. The lower the turn radius, the tighter the turn. The lower the turn radius, the more the wheels are able to turn and the tighter the turn radius. |
| Turn Speed (**Treaded Vehicles** Only)       | The tank's turn speed in `degrees/second` while moving or the approximate speed while turning in place. **Treaded Vehicles** turn differently whether they're turning in place or with momentum. When turning in place, the **Treaded Vehicle** rotates the treads in opposite directions. While moving forward or backwards, the treads will rotate at unequal speeds based on the amount of turning desired. The system blends between these methods based on the amount of speed being applied to the tank at the time. |

<!-- TODO: Warnings about properties that will appear to break your vehicle would be great -->

!!! info
    **Max Speed** divided by **Acceleration** is an estimate of how long it takes to get to full speed.

## Driver Properties

| Property                   | Description |
| -------------------------- | ----------- |
| Enter Trigger              | The trigger that a player interacts with to drive the vehicle. |
| Exit Binding               | The key binding that a player presses to exit the vehicle. By default, the input assigned is ++F++. |
| Attach Driver              | If `true`, attaches the player to the vehicle when driving. |
| Animation Stance           | The animation applied to a player when the player is driving. By default, **Four-Wheeled Vehicles** use `unarmed_sit_car_low`. If the driver isn't attached, the stance has no impact on the driver. |
| Hide Driver                | If `true`, sets the driver visibility off when driving. If the driver isn't attached, this property has no effect. |
| Position & Rotation Offset | When attached, this adds a position and rotation to the driver relative to the vehicle origin. The blue capsule shows where the driver will be placed. Generally, stances work best when the bottom of the capsule is where the bottom of the character would be when the character is in the stance. |
| Handbrake Binding          | The action binding that will activate the handbrake. By default, the handbrake is set to ++SPACE++.<br /><br />The handbrake only causes the rear wheels to brake. Normal braking is done by pressing ++S++ and when there is momentum, this will cause all 4 wheels to brake. |
| Camera                     | The camera that is activated when the vehicle is driven. The camera is disabled when the player exits the vehicle. |

## Adding a Vehicle to a Project

<!-- TODO: Each step is an h3, and explanation. Pictures as much as possible -->

---

## Learn More

<!-- TODO: Any other doc that you link to, copy here as well. Can't think of good other references right now, but this will include the Racing Framework Tutorial once we publish that -->
