---
id: color
name: Color
title: Color
tags:
    - API
---

# API: Color

## Description

An RGBA representation of a color. Color components have an effective range of `[0.0, 1.0]`, but values greater than 1 may be used.

## API

### Constructors

| Constructor Name | Return Type | Description | Tags |
| ----------- | ----------- | ----------- | ---- |
| `Color.New(Number r, Number g, Number b, [Number a])` | `Color` | Constructs a Color with the given values, alpha defaults to 1.0. | None |
| `Color.New(Vector3 v)` | `Color` | Constructs a Color using the vector's XYZ components as the color's RGB components, alpha defaults to 1.0. | None |
| `Color.New(Vector4 v)` | `Color` | Constructs a Color using the vector's XYZW components as the color's RGBA components. | None |
| `Color.New(Color c)` | `Color` | Makes a copy of the given color. | None |

### Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `r` | `Number` | The Red component of the Color. | Read-Write |
| `g` | `Number` | The Green component of the Color. | Read-Write |
| `b` | `Number` | The Blue component of the Color. | Read-Write |
| `a` | `Number` | The Alpha (transparency) component of the Color. | Read-Write |

### Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetDesaturated(Number desaturation)` | `Color` | Returns the desaturated version of the Color. 0 represents no desaturation and 1 represents full desaturation. | None |
| `ToStandardHex()` | `string` | Returns a hexadecimal sRGB representation of this color, in the format "#RRGGBBAA". Channel values outside the normal 0-1 range will be clamped, and some precision may be lost. | None |
| `ToLinearHex()` | `string` | Returns a hexadecimal linear RGB representation of this color, in the format "#RRGGBBAA". Channel values outside the normal 0-1 range will be clamped, and some precision may be lost. | None |

### Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `Color.Lerp(Color from, Color to, Number progress)` | `Color` | Linearly interpolates between two colors in HSV space by the specified progress amount and returns the resultant Color. | None |
| `Color.Random()` | `Color` | Returns a new color with random RGB values and Alpha of 1.0. | None |
| `Color.FromStandardHex(string hexString)` | `Color` | Creates a Color from the given sRGB hexadecimal string. Supported formats include "#RGB", "#RGBA", "#RRGGBB", and "#RRGGBBAA", with or without the leading "#". | None |
| `Color.FromLinearHex(string hexString)` | `Color` | Creates a Color from the given linear RGB hexadecimal string. Supported formats include "#RGB", "#RGBA", "#RRGGBB", and "#RRGGBBAA", with or without the leading "#". | None |

### Operators

| Operator Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Color + Color` | `Color` | Component-wise addition. | None |
| `Color - Color` | `Color` | Component-wise subtraction | None |
| `Color * Color` | `Color` | Component-wise multiplication. | None |
| `Color * Number` | `Color` | Multiplies each component of the Color by the right-side Number. | None |
| `Color / Color` | `Color` | Component-wise division. | None |
| `Color / Number` | `Color` | Divides each component of the Color by the right-side Number. | None |

### Extra Data

#### Predefined Colors

| HEX Value | Enum Name | HEX Value | Enum Name |
| --------- | --------- | --------- | --------- |
| :fontawesome-solid-square:{: .Color_WHITE } `#ffffffff`       | Color.WHITE       | :fontawesome-solid-square:{: .Color_ORANGE } `#cc4c00ff`   | Color.ORANGE |
| :fontawesome-solid-square:{: .Color_GRAY } `#7f7f7fff`        | Color.GRAY        | :fontawesome-solid-square:{: .Color_PURPLE } `#4c0099ff`   | Color.PURPLE |
| :fontawesome-solid-square:{: .Color_BLACK } `#000000ff`       | Color.BLACK       | :fontawesome-solid-square:{: .Color_BROWN } `#721400ff`    | Color.BROWN |
| :fontawesome-solid-square:{: .Color_TRANSPARENT } `#ffffff00` | Color.TRANSPARENT | :fontawesome-solid-square:{: .Color_PINK } `#ff6666ff`     | Color.PINK |
| :fontawesome-solid-square:{: .Color_RED } `#ff0000ff`         | Color.RED         | :fontawesome-solid-square:{: .Color_TAN } `#e5bf4cff`      | Color.TAN |
| :fontawesome-solid-square:{: .Color_GREEN } `#00ff00ff`       | Color.GREEN       | :fontawesome-solid-square:{: .Color_RUBY } `#660101ff`     | Color.RUBY |
| :fontawesome-solid-square:{: .Color_BLUE } `#0000ffff`        | Color.BLUE        | :fontawesome-solid-square:{: .Color_EMERALD } `#0c660cff`  | Color.EMERALD |
| :fontawesome-solid-square:{: .Color_CYAN } `#00ffffff`        | Color.CYAN        | :fontawesome-solid-square:{: .Color_SAPPHIRE } `#02024cff` | Color.SAPPHIRE |
| :fontawesome-solid-square:{: .Color_MAGENTA} `#ff00ffff`      | Color.MAGENTA     | :fontawesome-solid-square:{: .Color_SILVER } `#b2b2b2ff`   | Color.SILVER |
| :fontawesome-solid-square:{: .Color_YELLOW } `#ffff00ff`      | Color.YELLOW      | :fontawesome-solid-square:{: .Color_SMOKE } `#191919ff`    | Color.SMOKE |

## Examples

### `Lerp`

This utility function calculates a color useful for a health bar.

```lua
function GetHitPointsColor(currentHitPoints, maxHitPoints)
    -- 3 point gradient color, from red to yellow then green
    local percent = 1

    if maxHitPoints > 0 then
        percent = currentHitPoints / maxHitPoints
        percent = CoreMath.Clamp(percent, 0, 1)
    end

    local c

    if percent < 0.5 then
        c = Color.Lerp(Color.RED, Color.YELLOW, percent * 2)
    else
        c = Color.Lerp(Color.YELLOW, Color.GREEN, percent * 2 - 1)
    end

    return c
end
```
