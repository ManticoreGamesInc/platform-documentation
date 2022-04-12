---
id: mobile_preview
name: Mobile Device Preview
title: Mobile Device Preview
tags:
  - Reference
---

# Mobile Device Preview

The **Device Preview** is a feature in the **Core Editor** that simulates how certain aspects of a game will appear on a mobile device. It will give creators an approximate look and feel to simulate the mobile experience for players.

![!Device Preview](../img/MobileDevicePreview/devicepreview.png){: .center loading="lazy" }

## Device Preview

In the editor toolbar creators will find the **Device Preview** button that when clicked on will open up the device preview options.

![!Device Preview Button](../img/MobileDevicePreview/previewdevicebutton.png){: .center loading="lazy" }

### Device Preview Menu

The **Device Preview** menu will allow creators to enable and disable device preview in preview and edit modes, along with other options to customize the preview display. This allows creators to quickly iterate on UI and games systems that rely on camera view and screen dimensions.

During preview mode, mouse, keyboard, touch, and controller input will change based on the preview mode chosen.

!!! warning "Multiplayer Preview Mode & Portrait Mode"
    The device preview only works in editor and local preview mode. Multiplayer preview mode is currently not supported.

    Only landscape mode is supported for now.

![!Device Preview Options](../img/MobileDevicePreview/options.png){: .center loading="lazy" }

#### Device frame

When enabling the **Device Frame** option, the preview area will disable the device frame. In addition to simulating the dimensions of mobile devices, it will also reflect the notch on the display if supported by the device selected.

![Device Frame](../img/MobileDevicePreview/withframe.png)
![Device Frame](../img/MobileDevicePreview/noframe.png)
*Device Frame Enabled (left), Device Frame Disabled (right)*
{: .image-cluster}

#### Flip Notch

Using the **Flip Notch** option will toggle the notch between the left and the right side of the mobile device. Not all mobile devices have this notch, but it is important to test and ensure parts of the UI are not obstructed by the notch.

![!Notch](../img/MobileDevicePreview/notch.png){: .center loading="lazy" }

#### Show Safe Zone

By enabling the **Safe Zone** option, the safe zone of the selected device will have the safe zone area displayed where all UI elements will be visible.

![!Safe Zone](../img/MobileDevicePreview/safezone.png){: .center loading="lazy" }

#### Devices

The **Devices** dropdown allows creators to select a specific device to preview.

![!Devices](../img/MobileDevicePreview/devices.png){: .center loading="lazy" }

## Device Preview UI

The device preview UI changes depending on where the player touches the screen. For example, when the player touches the left half of the screen, a virtual joystick will appear. The right half of the screen controls the camera's movement when touched.

![!Enabled](../img/MobileDevicePreview/enabled.png){: .center loading="lazy" }

### Default Mobile UI

The default mobile UI has controls that give a player quick access to things such as Mounts, Emotes, and Settings.

| Mobile UI Icon | Description |
| -------------- | ----------- |
| ![Core Menu](../img/MobileDevicePreview/UI/Core.png) | Minimizes the current game and brings up the Core game browser. |
| ![Player Emotes](../img/MobileDevicePreview/UI/Emotes.png) | Opens the emote window for the player to select an emote to play. |
| ![Player Mounts](../img/MobileDevicePreview/UI/Mounts.png) | Opens the mount window for the player to select a mount to ride. |
| ![Settings](../img/MobileDevicePreview/UI/Settings.png) | Opens up the settings window for the player. |

## Performance Limits

Performance limits track the objects in the project Hierarchy and show the limit numbers for the object count, networked object, and terrain complexity. Creators should try to keep all bars below the limits to give players the best game performance. Reaching any limit will result in a warning, but currently does not block you from publishing.

There are 5 options to choose from that will adjust the object count and limits based on the specified platform and the detail quality level.

![High](../img/MobileDevicePreview/high.png)
![Low](../img/MobileDevicePreview/low.png)
*High - 30,000 max objects (left), Low - 10,000 max objects (right)*
{: .image-cluster}

### Detail Relevance

Objects in a **Client Context** will render only if the player's **Detail Level** is equal to or above this setting. **Low+** will ensure that the objects in this context will always render. For example, having a much lower VFX particle density for mobile will give better performance, compared to PC having a higher VFX particle density.

![!Detail](../img/MobileDevicePreview/detail.png){: .center loading="lazy" }

## Learn More

[Binding Sets](../references/binding_sets.md)
