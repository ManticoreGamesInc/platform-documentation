---
id: uitext
name: UIText
title: UIText
tags:
    - API
---

# UIText

A UIControl which displays a basic text label.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `text` | `string` | The actual text string to show. | Read-Write |
| `fontSize` | `integer` | The font size of the UIText control. | Read-Write |
| `outlineSize` | `integer` | The thickness of the outline around text in this control. A value of 0 means no outline. | Read-Write |
| `justification` | [`TextJustify`](enums.md#textjustify) | Determines the alignment of `text`. Possible values are: TextJustify.LEFT, TextJustify.RIGHT, and TextJustify.CENTER. | Read-Write |
| `shouldWrapText` | `boolean` | Whether or not text should be wrapped within the bounds of this control. | Read-Write |
| `shouldClipText` | `boolean` | Whether or not text should be clipped when exceeding the bounds of this control. | Read-Write |
| `shouldScaleToFit` | `boolean` | Whether or not text should scale down to fit within the bounds of this control. | Read-Write |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetColor()` | [`Color`](color.md) | Returns the color of the Text. | None |
| `SetColor(Color)` | `None` | Sets the color of the Text. | None |
| `GetOutlineColor()` | [`Color`](color.md) | Returns the color of the text's outline. | None |
| `SetOutlineColor(Color)` | `None` | Sets the color of the text's outline. | None |
| `GetShadowColor()` | [`Color`](color.md) | Returns the color of the text's drop shadow. | None |
| `SetShadowColor(Color)` | `None` | Sets the color of the text's drop shadow. | None |
| `GetShadowOffset()` | [`Vector2`](vector2.md) | Returns the offset of the text's drop shadow in UI space. | None |
| `SetShadowOffset(Vector2)` | `None` | Sets the offset of the text's drop shadow in UI space. | None |
| `ComputeApproximateSize()` | [`Vector2`](vector2.md) | Attempts to determine the size of the rendered block of text. This may return `nil` if the size cannot be determined, for example because the underlying widget has not been fully initialized yet. | None |
| `SetFont(string fontId)` | `None` | Sets the text to use the specified font asset. | None |

## Examples

Example using:

### `SetShadowOffset`

### `SetShadowColor`

Adding shadows to UI components is a great way to draw a player's attention to that UI component. This example will show you how to position UI Text shadows and change the color of UI Text shadows. This script will cause the shadow of a UI Text object to blink on and off.

```lua
-- Grab the text object
local propUIText = script:GetCustomProperty("UIText"):WaitForObject()

-- Slightly offset the text's shadow so that you can see the shadow
propUIText:SetShadowOffset(Vector2.New(20, 20))

-- This variable will store the number of seconds that have passed
local secondCounter = 0

-- Give the shadow a black color
local shadowBlackColor = Color.BLACK

-- This color will not be visibile because the alpha value is 0
local shadowInvisibleColor = Color.New(0, 1, 0, 0)

function Tick(deltaTime)
    -- Update the "secondCounter" to keep track of the number of seconds that have passed
    secondCounter = secondCounter + deltaTime

    -- Once 1 second has passed, toggle the visibility of the shadow
    Task.Wait(1)
    
    -- If the current color of the text shadow is black, make the shadow invisbile using "shadowInvisibleColor"
    if(propUIText:GetShadowColor() == shadowBlackColor) then
        -- Set the color of the text shadow to black
        propUIText:SetShadowColor(shadowInvisibleColor)
    -- If the current color of the text shadow is invisible, make the shadow visbile using "shadowBlackColor"
    elseif (propUIText:GetShadowColor() == shadowInvisibleColor) then
        -- Set the color of the text shadow to an invisible color
        propUIText:SetShadowColor(shadowBlackColor)
    end
end
```

See also: [CoreObject.GetCustomProperty](coreobject.md) | [Vector2.New](vector2.md) | [Color.New](color.md)

---

Example using:

### `outlineSize`

### `SetOutlineColor`

Text outlines are often used to draw a player's attention towards a specific word or phrase. This example will demonstrate how you can change the color and size of UI Text outlines. This script will cause the outline of the UI Text object to repeatedly increase and decrease in size.

```lua
-- Grab the text object
local propUIText = script:GetCustomProperty("UIText"):WaitForObject()

-- Change the outline color of the text to green
propUIText:SetOutlineColor(Color.GREEN)

-- This variable will store the number of seconds that have passed since the start of the game
local timePassed = 0

-- This variable will store the current size of the text outline
local textOutlineSize = 0

-- This variable determins how large the text outline will be
local outlineScale = 5

-- Determines how often the text outline changes size
-- The current value will change the size 2 times per second
local frequency = 2 * (2 * math.pi)

function Tick(deltaTime)
    -- Update the "timePassed" to keep track of the number of seconds that have passed
    timePassed = timePassed + deltaTime

    -- The "timePassed" variable will be passed into a sine wave function to smoothly change the text outline size
    -- This sine wave function will have a frequency of 2 hertz, and an amplitude of 5 units
    textOutlineSize = (math.sin(timePassed * frequency) * outlineScale) + outlineScale

    -- the "floor" function is used to convert "textOutlineSize" from a number with decimals (known as a "floating point number")
    -- to a number without a decimal point (known as an "integer")
    textOutlineSize = math.floor(textOutlineSize)

    -- Update the outline size of the text
    propUIText.outlineSize = textOutlineSize
end
```

See also: [CoreObject.GetCustomProperty](coreobject.md)

---

Example using:

### `text`

Being able to modify text is extremely valuable. This example will show you how to use the `text` property of a UI Text object to modify text displayed during runtime.

```lua
-- Grab the text object
local propUIText = script:GetCustomProperty("UIText"):WaitForObject()

-- This variable will store the number of seconds that have passed since the start of this script
local timePassed = 0

function Tick(deltaTime)
    -- Update the "timePassed" to keep track of the number of seconds that have passed
    timePassed = timePassed + deltaTime

    -- Convert the "timePassed" variable into a string format
    -- the "floor" function was used to remove the extra decimal points from the "timePassed" number
    local timePassedString = tostring(math.floor(timePassed))

    -- Update the UI text object to display the number of seconds that have passed
    propUIText.text = timePassedString
end
```

See also: [CoreObject.GetCustomProperty](coreobject.md)

---

## Tutorials

[UI in Core](../tutorials/ui_reference.md)
