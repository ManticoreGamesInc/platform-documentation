---
id: converting_to_mobile
name: Converting to Mobile
title: Converting to Mobile
tags:
    - Tutorial
---

# Converting to Mobile

## Overview

Core is soon becoming available for **iOS devices**! In preparation, there are new features in the Core Editor that can help preview on different devices and manage mobile limitations. This tutorial will help guide creators to convert their existing games to become mobile-friendly.

* **Completion Time:** ~30 minutes
* **Knowledge Level:** Basic knowledge of the Core Editor.
* **Skills you will learn:**
    * Preview the game in the view of an iOS device.
    * Use Binding Set for players to interact with a touchscreen.
    * Update weapons and abilities to use action bindings.
    * Edit the UI to better fit smaller devices.
    * Improve object count performance by using Detail Relevance.

<div class="mt-video" style="width:100%">
    <video autoplay muted playsinline controls loop class="center" style="width:100%">
        <source src="/img/ConvertToMobile/Mobile-Final.mp4" type="video/mp4" />
    </video>
</div>

## Device Preview

The first step is to open the project and test the new [**Device Preview**](../references/mobile_device_preview.md).

### Open a Project

This tutorial will be using the **Deathmatch Framework** project as an example of converting for an iOS device. This tutorial can be incorporated for any other project.

![!New Project](../img/ConvertToMobile/Mobile-NewProject.png){: .center loading="lazy" }

### Enable Device Preview

Once the project is open, click the **Device Preview** button to open an options menu. Activate the **Enable** option and the Viewport window should now represent a small device.

![!Enable](../img/ConvertToMobile/Mobile-Enable.png){: .center loading="lazy" }

### Touch Screen Buttons and Controls

Preview the project by pressing the **Play** button. Test the new Touch Screen buttons and controls by using the left mouse button as the **Touch** input.

#### Movement and Camera View

Holding down and dragging the left mouse button will do two different actions based on the cursor position on the screen. If the cursor is on the left half of the screen, then holding and dragging the left mouse button will move the player. If the cursor is on the right half of the screen, then holding and dragging the left mouse button will rotate the camera view.

<div class="mt-video" style="width:100%">
    <video autoplay muted playsinline controls loop class="center" style="width:100%">
        <source src="/img/ConvertToMobile/Mobile-Enable.mp4" type="video/mp4" />
    </video>
</div>

#### Default Buttons

At the top of the device preview, there are four default buttons. Going from left to right, these buttons will close the current game, open the emote window, open the mount window, and open the settings window.

![!Top Buttons](../img/ConvertToMobile/Mobile-TopButtons.png){: .center loading="lazy" }

#### Control Buttons

Based on the **action bindings** (will be covered later on), there may be other buttons on the screen. There may be **bumpers** on the sides, a **D-pad** on the left side, and up to four buttons on the right side (**X, Y, A, B**).

![!Other Buttons](../img/ConvertToMobile/Mobile-OtherButtons.png){: .center loading="lazy" }

### Note any Missing Controls

When testing the game, take note of any controls that seem to be missing from the normal game. The next step will fix these problems.

In the **Deathmatch Framework** project, there is currently no way for the player to **shoot** or **reload** with the touch controls.

## Binding Set

A [**Binding Set**](../references/binding_sets.md) is a set of actions a creator has defined for the game. Each action can be given multiple bindings for keyboards, controllers, and mobile devices. This is incredibly useful to make a player's actions work across multiple devices.

### Open the Default Binding Set

New projects create a default binding set. Open the **Hierarchy** and expand the **Gameplay Settings** folder. Double left click the **Default Binding** object to open the **Bindings Manager** window.

![!Default Binding](../img/ConvertToMobile/Mobile-DefaultBinding.png){: .center loading="lazy" }

### Change a Binding

There are usually a bunch of default actions such as movement, jumping, and crouching.

For the **Mount** action, set the **Controller** property to be the **D-pad Left**. Then preview the game and press the D-pad Left button.

!!! note "The Controller property refers to the input for a physical game controller and the on-screen buttons for mobile devices."

<div class="mt-video" style="width:100%">
    <video autoplay muted playsinline controls loop class="center" style="width:100%">
        <source src="/img/ConvertToMobile/Mobile-MountAction.mp4" type="video/mp4" />
    </video>
</div>

### Add Bindings

Scroll down to the bottom of the **Bindings Manager** window and click the **Add Binding** button on the bottom right. Then select the **Add Basic Binding** option.

Set the **Action Name**, **Keyboard Primary**, and **Controller** property for the new binding. Add as many binding needed for the missing actions noted earlier.

![!Add Binding](../img/ConvertToMobile/Mobile-AddBinding.png){: .center loading="lazy" }

### Connect the Bindings

With the new bindings created, it is now time to connect the actions to their functionality. This could be activating a weapon's ability or a script that runs a certain function when an action occurs.

#### Binding an Ability

[Abilities](../tutorials/ability_tutorial.md) are easy to bind with actions because it simply requires changing a single property.

Select the **Ability** object and open the **Properties** window. Set the **Action Name** property to the same action name used when the binding was created.

In this example, the **Starting Weapon** template has an ability for shooting and reloading so they were both updated.

![!Ability](../img/ConvertToMobile/Mobile-Ability.png){: .center loading="lazy" }

#### Binding with Scripting

Some other actions may require scripting to accomplish the functionality. The [Input](../api/input.md) namespace has events for an action being pressed and released.

Here is a simple script that will show [Fly Up Text](../api/ui.md) above the player when the player presses the `Speak` action binding.

```lua
function OnActionPressed(player, action, value)
    if action == "Speak" then
        UI.ShowFlyUpText("Hello", player:GetWorldPosition() + Vector3.UP * 110, {isBig = true})
    end
end

Input.actionPressedEvent:Connect(OnActionPressed)
```

<div class="mt-video" style="width:100%">
    <video autoplay muted playsinline controls loop class="center" style="width:100%">
        <source src="/img/ConvertToMobile/Mobile-Speak.mp4" type="video/mp4" />
    </video>
</div>

## Mobile UI

Mobile devices will naturally have smaller screens than computers so it is important to keep UI within a certain area so all devices can see it.

### Safe Zone

The **Safe Zone** refers to an area where UI is is guaranteed to be visible on any device's screen.

Open the **Device Preview Option**s menu and activate the **Safe Zone** option. There should be an orange dotted rectangle on the preview screen representing the safe zone. Make sure all UI is within the safe zone.

![!Safe Zone](../img/ConvertToMobile/Mobile-SafeZone.png){: .center loading="lazy" }

!!! info
    **UI Containers** have a property named **Use Safe Zone**. This will help align UI components within the safe zone rather than the whole screen. This should be enabled by default.

    ![!Use Safe Zone](../img/ConvertToMobile/Mobile-UseSafeZone.png){: .center loading="lazy" }

### Flip Notch

Some devices have a **notch** for the camera and speaker that can cover up part of the screen. This can lead to hidden UI if the device is flipped upside down and the notch is now on the opposite side of the screen.

Creators can flip the notch by activating the **Flip Notch** option in the **Device Preview Options** menu. Make sure all UI is visible from both orientations of the notch.

<div class="mt-video" style="width:100%">
    <video autoplay muted playsinline controls loop class="center" style="width:100%">
        <source src="/img/ConvertToMobile/Mobile-FlipNotch.mp4" type="video/mp4" />
    </video>
</div>

## Performance Limits and Detail Relevance

Due to mobile devices having lower capacity for graphics and memory, there are limitations to Core games published for mobile devices.

The two big limitations for mobile devices are the **Object Count Limit** is reduced from 30,000 to 10,000 and the **Quality Preset** is forced to **Low**.

### Performance Limit

On the **top editor toolbar**, there is a **Performance Limits** dropdown menu. This will show the difference in **Object Count Limits** for mobile and non-mobile devices. It will also update the preview to show objects that are designated in the quality range.

![!Performance Limit](../img/ConvertToMobile/Mobile-PerformanceLimit.png){: .center loading="lazy" }

### Detail Relevance

There may be some groups of many objects that can severely impact the total object count for mobile games. **Detail Relevance** can help alleviate that problem by assigning a minimum quality for objects in a **Client Context** to be rendered.

#### Create a Client Context

Right click the **Hierarchy** and expand the **Create Network Context...** to select the **New Client Context** option. Place some objects as children to the **Client Context**.

![!Client Context](../img/ConvertToMobile/Mobile-ClientContext.png){: .center loading="lazy" }

#### Set Detail Relevance

With the Client Context selected, open the Properties window and enable the Advance Settings option. Change the Detail Relevance property to Medium+.

![!Detail Relevance](../img/ConvertToMobile/Mobile-DetailRelevance.png){: .center loading="lazy" }

#### Preview the Project in Different Qualities

Preview the project in different qualities by changing the Performance Limit option. The group of objects should be hidden in Low quality but appear for any quality higher up.

<div class="mt-video" style="width:100%">
    <video autoplay muted playsinline controls loop class="center" style="width:100%">
        <source src="/img/ConvertToMobile/Mobile-DetailRelevance.mp4" type="video/mp4" />
    </video>
</div>

## Summary

The Core Editor has some useful tools to assist creators in making their games mobile-friendly. Using a Binding Set will help connect an action to multiple types of device inputs. The Device Preview Options can help preview gameplay and UI on a variety of devices. There are also performance restrictions on smaller devices that may require some objects only being rendered based on the device quality.

## Learn More

[Mobile Device Preview Reference](../references/mobile_device_preview.md) | [Binding Set Reference](../references/binding_sets.md) | [Abilities Tutorial](../tutorials/ability_tutorial.md) | [Input API](../api/input.md)
