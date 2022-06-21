---
id: cameras_reference
name: Cameras Reference
title: Cameras Reference
tags:
    - Reference
---

# Cameras and Settings

## Summary

**Cameras** capture and display the world, they are the eye of the player and can be set up in many ways. **Cameras** can be placed in the world to capture specific points of interest (for example, a security camera), capture, and render to UI, or simply be the eye for the player when looking down their gun.

When a new project is created, **Core** will automatically add a **Third Person Camera** to the **Hierarchy** under **Game Settings**. This will be the default camera which can be modified, or removed.

## Adding a Camera

In the **Core Content** tab, under **Game Components**, drag the **Camera** component into the **Scene** or **Hierarchy**.

!!! tip "Press ++v++ to enable or disable the camera volume box in the **Scene** view."

![!Camera Component](/img/Camera/core_content_camera.png){: .center loading="lazy" }

### Fixed Camera

By default, a camera will have the properties **Set to Default**, **Attach to Local Player** enabled, and **Base Rotation Mode** set to **Look**. If a camera needs to be fixed (that is a CCTV camera in a room), the following properties can be changed.

- Change **Set to Default** to be disabled.
- Change **Attach to Local Player** to be disabled.
- Change **Based Rotation Mode** to **Camera**.

### Solo a Camera

Adding a new **Camera** to the **Hierarchy** may appear that nothing happens when entering **Preview** mode. This is because an existing camera is in the **Hierarchy** and has **Set to Default**, and **Attach to Local Player** enabled. To solo a camera in the **Hierarchy**, that camera will need to be **Set to Default**, and other cameras will need the following properties disabled.

- **Set to Default**
- **Attach to Local Player**

## Properties

Some properties can be adjusted on the **Camera** that can change the way the player views the game.

### Transform

**Cameras** can be positioned and rotated in the world by modifying the **Position** and **Rotation** properties.

For the rotation to take effect on a camera, the property **Base Rotation Mode** needs to be set to **Camera** under **Rotation** in the camera properties. Otherwise, the **Rotation Offset** can be used.

![!Transform](/img/Camera/transform_properties.png){: .center loading="lazy" }

### Camera

| Name | Description |
| ---- | ----------- |
| Use as Default | This camera will be used initially as each player's default camera. |
| Field of View | Number of degrees across the player's view. |

![!Camera](/img/Camera/camera_properties.png){: .center loading="lazy" }

### Position

| Name | Description |
| ---- | ----------- |
| Attach to Local Player | Whether this camera starts attached to the local player. |
| Use Camera Socket | Whether to use the camera socket instead of the character's position. This adds a slight view bob and is often preferable for first-person cameras. |
| Position Offset | Offset in local space. |
| Position Offset Springs | Whether the position offset is part of the spring that gets compressed when the camera is pushed against a wall. |
| Initial Distance | Initial view distance of this camera.
| Adjustable Distance | Whether players can manually adjust the distance. |
| Minimum Distance | Minimum distance if distance is adjustable. |
| Maximum Distance | Maximum distance if distance is adjustable. |

![!Position](/img/Camera/position_properties.png){: .center loading="lazy" }

### Rotation

| Name | Description |
| ---- | ----------- |
| Base Rotation Mode | Which base rotation should this camera use. Camera: the camera object itself. None: zero rotation. Look Angle: the follow player's look angle. |
| Rotation Offset | Rotation offset. |
| Free Control | Whether the player's rotation input (mouse or right stick by default) adds a rotation to this camera. This has no effect if rotation mode is Look Angle. |
| Initial Pitch | Initial pitch of the free control rotation. Requires Free Control. |
| Minimum Pitch | Minimum pitch. Requires Free Control. |
| Maximum Pitch | Maximum Pitch. Requires Free Control. |
| Initial Yaw | Initial yaw of the free control rotation. Requires Free Control. |
| Limited Yaw | Whether the free control's yaw component is limited. Request Free Control. |
| Minimum Yaw | Minimum yaw. Requires Limited Yaw. |
| Minimum Yaw | Maximum yaw. Requires Limited Yaw. |

![!Rotation](/img/Camera/rotation_properties.png){: .center loading="lazy" }

### Audio

| Name | Description |
| ---- | ----------- |
| Use As Audio Listener | Whether this camera will be used as the listener location for audio while active (the default behavior is to use the player). |
| Audio Listener Offset | An offset for where the listener will be relative to the camera, if the camera is a listener (see Use As Audio Listener). |

![!Audio](/img/Camera/audio_properties.png){: .center loading="lazy" }

### Scene

| Name | Description |
| ---- | ----------- |
| Editor Indicator Visibility | Controls when the object's volume indicator is shown in the editor. |
| Is Advanced | Any descendents that are marked as Is Advanced will be hidden from the hierarchy. |

![!Scene](/img/Camera/scene_properties.png){: .center loading="lazy" }

## Overriding a Camera

A **Camera** can be used to override other cameras in the **Hierarchy**. This can useful for a few reasons, for example, a cinematic shot of the player entering a new area. Or a CCTV camera the player can use to view another area of the map that is under surveillance.

In a Lua script, the `SetOverrideCamera` function can be used by passing in the **Camera** as an argument that will be used to override other cameras in the **Hierarchy**. Clearing an override camera can be done by using the `ClearOverrideCamera`.

```lua
local CAMERA = script:GetCustomProperty("Camera"):WaitForObject()
local localPlayer = Game.GetLocalPlayer()

localPlayer:SetOverrideCamera(CAMERA)
```

See the [Camera API](/api/camera.md) and [Player API](/api/player.md) for more information.

<div class="mt-video" style="width:100%">
    <video autoplay muted playsinline controls loop class="center" style="width:100%">
        <source src="/img/Camera/cctv_example.mp4" type="video/mp4" />
    </video>
</div>

## Camera Capture to Image

A **Camera** has the ability to capture the view from the camera to an image at different resolutions. These captured images can be used elsewhere, for example, capturing an object in the world and using it as an item in a UI inventory system.

To capture images from a camera, the `Capture` function can be used in a Lua script.

See the [Camera API](/api/camera.md) and [CameraCapture API](/api/cameracapture.md) for more information.

<div class="mt-video" style="width:100%">
    <video autoplay muted playsinline controls loop class="center" style="width:100%">
        <source src="/img/Camera/photo_mode_example.mp4" type="video/mp4" />
    </video>
</div>

## Camera Templates

**Core** comes with some templates for a few different camera setups for different game genres. These can be found in **Camera**, under **Game Components**, in **Core Content**.

![!Templates](/img/Camera/camera_templates.png){: .center loading="lazy" }

### First Person Camera

The first-person camera shows what a player is looking at from the viewpoint of the player's character. This type of camera can be used in first-person shooter (FPS) games.

![!First-Person](/img/Camera/first_person_camera.png){: .center loading="lazy" }

### Third Person Camera

The third-person camera view will show the player's character to the player. Sometimes the camera is offset from the character to give it a feeling of appearing over the shoulder. This type of camera can be used in third-person shooters (TPS) and adventure games.

![!Third-Person](/img/Camera/third_person_camera.png){: .center loading="lazy" }

### Top-Down Camera

The top-down camera view will show an overhead view of the gameplay. This type of camera can be used in a real-time strategy (RTS), and simulation games.

![!Top-Down](/img/Camera/top_down_camera.png){: .center loading="lazy" }

### Isometric Camera

The isometric camera view is pointed at a fixed angle (that is 45 degrees) toward the player's character. This type of camera can be used in real-time strategy and role-playing games.

![!Isometric](/img/Camera/isometric_camera.png){: .center loading="lazy" }

### Side Scroller Camera

A side-scroller camera is a viewpoint from a side view angle, and usually, the player's character moves left and right, and the screen scrolls with the character. This type of camera can be used for 2D games.

![!Side-Scroller](/img/Camera/side_scroller_camera.png){: .center loading="lazy" }

## Player Settings

The player settings object has properties that handle player movement control and camera control.

### Ability Aim Mode

This setting controls where the aim is calculated from. For example, in a third-person camera, the aim is usually calculated from the camera view (view relative), but in a side-scroller view, the aim would be calculated based on the eye position (look relative) of the player's character.

| Mode | Description |
| ---- | ----------- |
| View Relative | Ability aim is calculated from the camera origin along the camera forward direction. |
| Look Relative | Ability aim is calculated from the players eye position along the player look direction. |

See the video below to see the difference when using a side-scroller camera. The **Ability Aim Mode** is set to **Look Relative**, then changed to **View Relative**. Watch the bullet trail to see the difference between the 2 settings.

<div class="mt-video" style="width:100%">
    <video autoplay muted playsinline controls loop class="center" style="width:100%">
        <source src="/img/Camera/ability_aim_mode.mp4" type="video/mp4" />
    </video>
</div>

### Controls

The **Control** category in the **Properties** window has properties to control how the player's character moves and rotates.

| Property | Description |
| -------- | ----------- |
| Can Move Forward | If true, the player will be able to move in the forward direction. If false, the player won't be able to more in the forward direction. |
| Can Move Backward | If true, the player will be able to move in the backward direction. If false, the player won't be able to more in the backward direction. |
| Can Move Left | If true, the player will be able to move in the left direction. If false, the player won't be able to more in the left direction. |
| Can Move Right | If true, the player will be able to move in the right direction. If false, the player won't be able to more in the right direction. |
| Can Move up (Swimming / Flying) | If true, the player will be able to move up while swimming or in flying mode. |
| Can Move Down (Swimming / Flying) | If true, the player will be able to move down while swimming or in flying mode. |

#### Movement Control Mode

Can be used to specify how players control their movement.

| Property | Description |
| -------- | ----------- |
| None | Movement input is ignored. |
| Look Relative | Forward movement follows the current player's look direction. |
| View Relative | Forward movement follows the current view's look direction. |
| Facing Relative | Forward movement follows the current player's facing direction. |
| Fixed Axes | Movement axes are fixed. |

With **Fixed Axes**, the forward and back are fixed on the Y direction, and the left and right are fixed on the X direction

<div class="mt-video" style="width:100%">
    <video autoplay muted playsinline controls loop class="center" style="width:100%">
        <source src="/img/Camera/fixed_axes.mp4" type="video/mp4" />
    </video>
</div>

#### Look Control Mode

Can be used to specify how players control their look direction.

| Property | Description |
| -------- | ----------- |
| None | Look input is ignored. |
| Relative | Look input controls the current look direction. |
| Look at Cursor | Look input is ignored. The player's look direction is determined by drawing a line from the player to the cursor on the Cursor Player. |

If the option **Look at Cursor** is selected, then 3 properties will appear after the **Look Control Mode** property.

##### Cursor Plane

In Look Control Mode: Look at Cursor, a cursor position is mapped into the world using this plane.

##### Cursor Plane Anchor

| Property | Description |
| -------- | ----------- |
| Player Position | The cursor plane is centered on the Player. |
| World Origin | The cursor plane is centered at the world origin (0, 0, 0). |

##### Cursor Plane Offset

The distance the cursor plane is offset along the plane's normal.

#### Facing Mode

Can be used to specify what controls a player's facing direction.

| Property | Description |
| -------- | ----------- |
| Face Aim When Action | The player faces their look direction while moving. |
| Face Aim Always | The player will always face their look direction. |
| Face Movement | The player face the direction of their movement. |

In this video, the difference can be seen when moving the player's character around.

<div class="mt-video" style="width:100%">
    <video autoplay muted playsinline controls loop class="center" style="width:100%">
        <source src="/img/Camera/facing_mode.mp4" type="video/mp4" />
    </video>
</div>

## Camera Collision

Cameras by default will collide with objects that have **Camera Collision** enabled. When the property `isCameraCollisionEnabled` is set to false, the camera will not collide with any objects. This defaults to true. Creators will find this useful for easier development of games with a fixed camera angle which would not typically need to collide with any geometry.

Using a Lua script, the `isCameraCollisionEnabled` can be toggled on or off. For example, in the code below, the camera collision is turned off for the `CAMERA`.

```lua
local CAMERA = script:GetCustomProperty("Camera"):WaitForObject()

CAMERA.isCameraCollisionEnabled = false -- Turn off collision for this camera.
```

## Learn More

[Player API](/api/player.md) | [Camera API](/api/camera.md) | [CameraCapture API](/api/cameracapture.md)
