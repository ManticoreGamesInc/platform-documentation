---
id: uiprogressbar
name: UIProgressBar
title: UIProgressBar
tags:
    - API
---

# UIProgressBar

A UIControl that displays a filled rectangle which can be used for things such as a health indicator.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `progress` | `number` | From 0 to 1, how full the bar should be. | Read-Write |
| `fillType` | [`ProgressBarFillType`](enums.md#progressbarfilltype) | Controls the direction in which the progress bar fills. | Read-Write |
| `fillTileType` | [`ImageTileType`](enums.md#imagetiletype) | How the fill texture is tiled. | Read-Write |
| `backgroundTileType` | [`ImageTileType`](enums.md#imagetiletype) | How the background texture is tiled. | Read-Write |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetFillColor()` | [`Color`](color.md) | Returns the color of the fill. | None |
| `SetFillColor(Color)` | `None` | Sets the color of the fill. | None |
| `GetFillImage()` | `string` | Returns the asset ID of the image used for the progress bar fill. | None |
| `SetFillImage(string assetId)` | `None` | Sets the progress bar fill to use the image specified by the given asset ID. | None |
| `GetBackgroundColor()` | [`Color`](color.md) | Returns the color of the background. | None |
| `SetBackgroundColor(Color)` | `None` | Sets the color of the background. | None |
| `GetBackgroundImage()` | `string` | Returns the asset ID of the image used for the progress bar background. | None |
| `SetBackgroundImage(string assetId)` | `None` | Sets the progress bar background to use the image specified by the given asset ID. | None |

## Examples

Example using:

### `progress`

Progress bars can be found in almost every video game. They are a great way to help players visualize numbers. This example will demonstrate how you can make a healthbar that changes color by using the ``progress`` property and ``SetFillColor`` method of the progress bar.

```lua
-- Get the progress bar object that will show how much health the player has
local propUIProgressBar = script:GetCustomProperty("UIProgressBar"):WaitForObject()

-- Get the player that is connected to your computer
local player = Game.GetLocalPlayer()

-- Reset the fill of the progress bar to 100%
propUIProgressBar.progress = 1

function Tick(deltaTime)
    --====================================================================================================
    -- This section will calculate how full the progress bar should be based on the health of the player

    -- Get a percentage representing how much health the player currently has
    local healthPercent = player.hitPoints / player.maxHitPoints

    -- Update the fill of the progress bar 
    propUIProgressBar.progress = healthPercent

    --=======================================================================================================
    -- This section will calculate the color of the progress bar

    -- The variable "value" is subtracted from 1 so that as "value" increases, the value of "RedChannel" decreases
    -- The opposite is also true, as "value" decreases, the value of "RedChannel" increases
    local RedChannel = 1 - healthPercent

    -- Calculate the amount of green the progress bar's fill color should have
    local GreenChannel = healthPercent

    -- Create a new color using "RedChannel" and "GreenChannel"
    -- This is the color that the fill of the progress bar will have
    local fillColor = Color.New(RedChannel, GreenChannel, 0)

    -- Update the fill color of the progress bar
    propUIProgressBar:SetFillColor(fillColor)
end
```

See also: [CoreObject.GetCustomProperty](coreobject.md) | [Color.New](color.md)

---

Example using:

### `progress`

### `fillType`

### `SetFillColor`

### `SetFillColor`

The `fillType` property of a progress bar can be used to change the direction from which the progress bar fills. This example, changes the fill direction of the progress bar to make it appear as if it is bouncing from side to side as it fills up and empties.

The progress bar will start filling from left side to the right side. Then, after the progress bar has been filled, the fill direction will flip so that the progress bar fills from right to left. The progress bar will then begin to deplete. After the progress bar has emptied, it will fill up again. After the progress bar has been filled again, it will switch to the original fill direction (right to left). The progress bar will then empty and the progress bar filling animation will have been reset back to the starting state.

If the `fillType` property of the progress bar is set to `ProgressBarFillType.LEFT_TO_RIGHT`, the progress bar will expand from the left side to the right side. If the `fillType` property of the progress bar is set to `ProgressBarFillType.RIGHT_TO_LEFT`, the progress bar will expand from the right side to the left side.

```lua
-- Get the progress bar object
local propUIProgressBar = script:GetCustomProperty("UIProgressBar"):WaitForObject()

-- This variable will count the number of seconds that have passed
local secondCounter = 0

-- This variable will store the last value stored in "secondCounter"
local lastSecondCounter = 0

-- Set the fill color of the progress bar to an orange color
propUIProgressBar:SetFillColor(Color.New(0.8, 0.34, 0))

function Tick(deltaTime)
    -- Update the "secondCounter" to keep track of the number of seconds that have passed
    secondCounter = secondCounter + deltaTime

    -- Calculate the progress of the progress bar
    -- This sine function will have a period of 2 seconds
    local value = (math.sin(secondCounter * math.pi))

    -- Update the progress of the progress bar
    propUIProgressBar.progress = value

    -- This if statement will only activate once each time "secondCounter" passes 0.5
    -- If the value of "secondCounter" just passed 0.5 then flip the progress bar's fill direction
    if(secondCounter > 0.5 and lastSecondCounter <= 0.5) then
        if(propUIProgressBar.fillType == ProgressBarFillType.LEFT_TO_RIGHT) then
            -- Flip the fill direction of the "propUIProgressBar"
            propUIProgressBar.fillType = ProgressBarFillType.RIGHT_TO_LEFT
        elseif(propUIProgressBar.fillType == ProgressBarFillType.RIGHT_TO_LEFT) then
            -- Flip the fill direction of the "propUIProgressBar"
            propUIProgressBar.fillType = ProgressBarFillType.LEFT_TO_RIGHT
        end
    end

    -- Once the "value" variable dips below 0, reset the "secondCounter" variable to 0
    if(value < 0) then
        secondCounter = 0
    end

    -- Update "lastSecondCounter" with the current value of "secondCounter"
    lastSecondCounter = secondCounter
end
```

See also: [CoreObject.GetCustomProperty](coreobject.md) | [Color.New](color.md)

---

## Tutorials

[UI in Core](../references/ui.md)
