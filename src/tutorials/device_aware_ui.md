---
id: device_aware_ui_tutorial
name: Creating Device Aware UI
title: Creating Device Aware UI
tags:
    - Tutorial
---

# Creating Device Aware UI

## Overview

Core supports different input devices that can be used by players to play your game. Making your UI work with the different input devices can be a challenging problem. In this tutorial, you will learn a few methods of how to manage your UI for different input devices.

The input devices covered in this tutorial will be Touch and Keyboard/Mouse.

* **Completion Time:** ~20 minutes
* **Knowledge Level:** No knowledge required.
* **Skills you will learn:**
    * The different input devices supported.
    * Detecting when an input device has changed.
    * Creating data tables.
    * Modifying your UI at runtime based on the input device used.

## Input Devices

Core supports Keyboard & Mouse, Touch, and Controller [input devices](../api/enums.md#inputtype).

Any input device can be switched to one another, and your game can react to the device that it was changed too. This allows you to respond to the new input device the player is using. For example, touching the screen to play your game, and then plugging in a controller would allow you to respond when the device has changed.

### Touch Device

A touch device allows players to control the game by touching the screen, this input is most commonly found on Mobiles and Tablets. Touching the screen with your fingers will register input that you can respond to. For example, touching on a button to open an inventory.

### Keyboard and Mouse

A keyboard and mouse are 2 separate inputs but are usually working together. The keyboard would allow the player to press keys to perform actions in your game. For example, ++space++ to make the player character jump. Mouse input controls the screen's cursor and allows for mouse presses. For example, rotating the player's camera in-game, and pressing the left mouse button to shoot their weapon.

### Controller

A controller (also sometimes called a gamepad or joypad), is usually something that can be held with two hands, has multiple action buttons, and sometimes multiple control sticks. For example, the left control stick will move the player character, the right control stick will control the camera.

## Import Community Content

For this tutorial, Community Content will be used for the [UI](../references/ui.md) to show how easy it is to apply these methods to existing content.

1. Open up the **Community Content** window by going to the **Window** menu and selecting **Community Content**.
2. Search for `universal` to find the **Universal UI Kit** by **CardinalZebra**.
3. Click the **Import** button.

![!Community Content](../img/DeviceAwareUI/cc.png){: .center loading="lazy" }

### Add Template to Hierarchy

When you import community content, you will see a list of all the templates that come with the content. For this tutorial, the **HUD Example RPG 2** template will be used.

1. Add a [**Client Context**](../references/networking.md) in the **Hierarchy** and rename it to `Client`.
2. Drag the **HUD Example RPG 2** template into the **Client** folder.

![!HUD Template](../img/DeviceAwareUI/hud_template.png){: .center loading="lazy" }

## Review the UI

Before anything else is done, you need to review the UI for Keyboard/Mouse and Touch to see what changes might be needed.

Core provides a tool called [**Mobile Device Preview**](../references/mobile_device_preview.md) that allows you to test how your game will look and feel for Touch input. This allows you to quickly iterate on your UI by switching between the 2 different input devices.

### Keyboard/Mouse UI Review

Let us start by reviewing the UI for Keyboard/Mouse to see if there are changes that need to be done.

Looking at the various UI components in the image below, you can see that it looks fine while testing this using Keyboard/Mouse. The UI is a little tight to the edge of the screen, but this may be the design the content creator wanted.

![!Review](../img/DeviceAwareUI/kbm_review.png){: .center loading="lazy" }

### Mobile UI Review

Let us now review the same UI using the [**Mobile Device Preview**](../references/mobile_device_preview.md). Make sure to have the options **Device Frame** and **Show Safe Zone** enabled.

Take a look at the image below and see where there are issues. Try flipping the notch as well when testing to check both sides of the device. This will give you an approximation of how the UI will look on a mobile device.

1. The player information panel is a little close to the top edge of the screen.
2. The quest panel has the top right cut off by the device frame.
3. The panel that shows how many players are in the game is a little close to the bottom of the screen.
4. The ability panel has information on which key to press to activate an ability.
5. The panel with various buttons is cut off to the bottom right by the device frame.

You will also see that the mobile controls and some UI panels are overlapping. This is something that could also be addressed later using an automated approach to handle UI changes based on the player's input device.

![!Review](../img/DeviceAwareUI/mobile_review.png){: .center loading="lazy" }

## Update the UI

So you can see the problems that need to be addressed. Let us go over the possible solutions that could be used to handle different player input devices.

### Catch-All Solution

The catch-all solution would be the easiest solution to apply to your UI because it only involves moving the UI to a new location on the screen. Since the mobile preview contains all the problems, you can enable device preview and move around the UI until it is in the best position on the screen.

#### Player Panel Example

For the player panel, you can set the **Y** to `150`. This will move the panel far enough down the screen so that it is under the mobile buttons. The problem with this solution is that it will also be moved down for Keyboard/Mouse, meaning it will have all that extra space above the panel. This is not an ideal solution, but it is the easiest to do with no Lua script.

![Mobile](../img/DeviceAwareUI/player_ui_mobile.png)
![PC](../img/DeviceAwareUI/player_ui_pc.png)
_Mobile (left) vs. PC (right)_
{: .image-cluster}

#### Applying Changes to all UI

If you apply the solution to all the UI components, then you can see how the final look would be. There is a lot of spacing when using Keyboard/Mouse. While this is the easiest solution, there is a better method we will look at in the next section that will require a little Lua scripting.

The downside of this solution is that certain UI elements are still showing up for each device. For example, the ability panel that has the numbered keys will show up for Touch input devices.

<p class="image-cluster lightgallery">
    <a href="../../img/DeviceAwareUI/player_ui_mobile.png">
        <img alt="Mobile" src="../../img/DeviceAwareUI/mobile_ui_changed.png">
    </a>
    <a href="../../img/DeviceAwareUI/player_ui_pc.png">
        <img alt="PC" src="../../img/DeviceAwareUI/pc_ui_changed.png">
    </a>
    <em>Mobile (left) vs. PC (right)</em>
</p>

### Dynamic Solution

The dynamic solution will provide a UI that suits the input device being used. It will watch what input device is connected, and adjust the UI to match the device based on rules in a data table. The data table will hold references to the various UI components and options to adjust those UI components for different input devices.

#### Revert HUD Example RPG 2 Template

In the **Hierarchy** right-click on the **HUD Example RPG 2** template and select **Revert Template Object**. This will revert the template back to its original state when you imported it into your project.

![!Revert Template](../img/DeviceAwareUI/revert_template.png){: .center loading="lazy" }

#### Create a Data Table

The [data table](../references/data_tables.md) is going to hold all the information about which UI components should be shown, and where their location should be on the screen. We will start with 1 row for now and address the other UI components later.

1. In **My Tables** found in **Project Content**, right-click select **Create Data Table**.
2. Name the Data Table `Device Aware Settings`.
3. Enter `6` for the total **Columns** to add.
4. Enter `1` for the total **Rows** to add.

![!Data Table](../img/DeviceAwareUI/create_data_table.png){: .center loading="lazy" }

##### Edit Data Table Columns

The columns in the data table will need to be edited with a name and a type. Click on the warning sign in the column header to open up the Column Settings window.

1. For the first column, set the **Column Name** to `ui` and the **Column Type** to **Core Object Reference**.
2. For the second column, set the **Column Name** to `pc` and the **Column Type** to **Bool**.
3. For the third column, set the **Column Name** to `mobile` and the **Column Type** to **Bool**.
4. For the fourth column, set the **Column Name** to `pcOffset` and the **Column Type** to **Vector2**.
5. For the fifth column, set the **Column Name** to `mobileOffset` and the **Column Type** to **Vector2**.
6. For the sixth column, set the **Column Name** to `useOffset` and the **Column Type** to **Bool**.

![!Set Columns](../img/DeviceAwareUI/set_columns.png){: .center loading="lazy" }

##### Add Row

Add a new row to the data table. This row will focus on the player panel that appears top left of the screen. This panel needs to be displayed on PC and Mobile devices and also be moved down in the **Y** position when the mobile buttons are displayed for Touch input.

1. In the **Hierarchy** drag the **Player Panel Variant 2** panel onto the **ui** column for row 1.
2. Enable **pc** and **mobile** so they are checked (enabled).
3. For the **pcOffset** column you can use the current position of the panel which is **X** `4` and **Y** `4`.
4. For the **mobileOffset** column the **X** needs a small amount of `30`, and the **Y** needs to be `150`.
5. Enable **useOffset** so that the offset columns are applied to the UI. Some UI may not need the position changed.

![!Row 1](../img/DeviceAwareUI/row1.png){: .center loading="lazy" }

#### Create DeviceAwareClient Script

Create a new script called `DeviceAwareClient` and place it into a Client Context in the **Hierarchy**. This script will be responsible for adjusting the UI when the input type has changed. It will show or hide the UI components depending on the settings for the row.

![!Script](../img/DeviceAwareUI/create_script.png){: .center loading="lazy" }

##### Create Data Table Custom Property

The script will need a reference to the data table you created earlier for the script to know what UI components to modify.

Add the **Device Aware Settings** data table as a custom property on the script, and name it `DeviceAwareSettings`.

![!Property](../img/DeviceAwareUI/custom_property.png){: .center loading="lazy" }

##### Require the Data Table

Open up the **DeviceAwareClient** script and add a reference to the data table custom property. This data table will be required in the script using the `require` function.

```lua
local DEVICE_AWARE_SETTINGS = require(script:GetCustomProperty("DeviceAwareSettings"))
```

##### Create OnInputChanged Function

Create a function called `OnInputChanged`. This function will be called anytime the player's input type has changed. It will loop through all the rows of the data table and check if the UI for that row should be shown for the input device. The visibility property of the UI object will be set based on the rules of the row, and the offset will be set using the values from the data table if the property `useOffset` is `true` (checked).

```lua
local function OnInputChanged(player, inputType)
    for index, row in ipairs(DEVICE_AWARE_SETTINGS) do
        local visibility = Visibility.FORCE_OFF
        local offset = Vector2.New()

        if row.mobile and inputType == InputType.TOUCH then
            visibility = Visibility.INHERIT
            offset = row.mobileOffset
        elseif row.pc and inputType == InputType.KEYBOARD_AND_MOUSE then
            visibility = Visibility.INHERIT
            offset = row.pcOffset
        end

        row.ui:GetObject().visibility = visibility

        if row.useOffset then
            row.ui:GetObject().x = offset.x
            row.ui:GetObject().y = offset.y
        end
    end
end
```

##### Connect inputTypeChangedEvent

To listen for when the input type has changed you can use the event `inputTypeChangedEvent`. Connect the `OnInputFunction` to the event.

```lua
Input.inputTypeChangedEvent:Connect(OnInputChanged)
```

##### Call OnInputChanged Function

A call to the `OnInputChanged` function needs to be done to make sure the UI is updated in case the last input type was Touch.

You can get the current input type by using the `GetCurrentInputType` function.

```lua
OnInputChanged(Game.GetLocalPlayer(), Input.GetCurrentInputType())
```

##### The DeviceAwareClient Script

??? "DeviceAwareClient"
    ```lua
    local DEVICE_AWARE_SETTINGS = require(script:GetCustomProperty("DeviceAwareSettings"))

    local function OnInputChanged(player, inputType)
        for index, row in ipairs(DEVICE_AWARE_SETTINGS) do
            local visibility = Visibility.FORCE_OFF
            local offset = Vector2.New()

            if row.mobile and inputType == InputType.TOUCH then
                visibility = Visibility.INHERIT
                offset = row.mobileOffset
            elseif row.pc and inputType == InputType.KEYBOARD_AND_MOUSE then
                visibility = Visibility.INHERIT
                offset = row.pcOffset
            end

            row.ui:GetObject().visibility = visibility

            if row.useOffset then
                row.ui:GetObject().x = offset.x
                row.ui:GetObject().y = offset.y
            end
        end
    end

    Input.inputTypeChangedEvent:Connect(OnInputChanged)

    OnInputChanged(Game.GetLocalPlayer(), Input.GetCurrentInputType())
    ```

#### Test the UI

Test the UI with the Mobile Device Preview enabled. Key an eye on the top left panel on the screen. You should notice that when the input type is Touch, then the UI panel is moved down and to the right. When the input type is Keyboard/Mouse, the panel will return to the default position.

<div class="mt-video" style="width:100%">
    <video autoplay muted playsinline controls loop class="center" style="width:100%">
        <source src="/img/DeviceAwareUI/input_change_preview.mp4" type="video/mp4" />
    </video>
</div>

#### Add Ability Key Number Rows

With the script setup, it is now easy to add UI to the data table, and it will just work. There is no more scripting that needs to be done which makes this a good solution for artists.

For the ability key numbers, it will require 2 UI components to be added to the table for each ability slot. In this case, no offset will be applied to the elements, and you only want to enable **usePC**.

1. **Key Number** inside the slot in the Hierarchy.
2. **Key Number Background** inside the **Frame** in the Hierarchy.

![!Key Numbers](../img/DeviceAwareUI/key_numbers.png){: .center loading="lazy" }

##### Test the UI

Test the UI and watch the key numbers and background frame when the input type has changed. You will notice the key numbers and the frame will be hidden when the input type is Touch, but appear when the input type is Keyboard/Mouse.

<div class="mt-video" style="width:100%">
    <video autoplay muted playsinline controls loop class="center" style="width:100%">
        <source src="/img/DeviceAwareUI/key_numbers.mp4" type="video/mp4" />
    </video>
</div>

#### Add Rules for all UI

Go through the UI and add rules for any that need to be moved.

![!Finished](../img/DeviceAwareUI/finished.png){: .center loading="lazy" }

#### Test the UI

One last test to check if the rest of the UI rules are working that you have in the data table.

<div class="mt-video" style="width:100%">
    <video autoplay muted playsinline controls loop class="center" style="width:100%">
        <source src="/img/DeviceAwareUI/complete.mp4" type="video/mp4" />
    </video>
</div>

## Summary

There are different solutions to solving the problem of how UI should be displayed on different devices. Some solutions require no code and would require you to rethink where on the screen your UI should be. Another solution could be spawning in a whole different set of UI depending on the input device. Each solution has there pros and cons. The advantage of the data table solution, is that it is friendly for artists to use once the script has been setup.

## Learn More

[Mobile Device Preview Reference](../references/mobile_device_preview.md) | [Converting to Mobile Tutorial](../tutorials/converting_to_mobile.md) | [UI Reference](../references/ui.md) | [Input API](../api/input.md) | [Input Type Enums](../api/enums.md#inputtype)
