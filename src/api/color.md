---
id: color
name: Color
title: Color
tags:
    - API
---

# Color

An RGBA representation of a color. Color components have an effective range of `[0.0, 1.0]`, but values greater than 1 may be used.

## Constructors

| Constructor Name | Return Type | Description | Tags |
| ----------- | ----------- | ----------- | ---- |
| `Color.New()` | [`Color`](color.md) | Constructs a new Color. | None |
| `Color.New(number r, number g, number b, [number a])` | [`Color`](color.md) | Constructs a Color with the given values, alpha defaults to 1.0. | None |
| `Color.New(Vector3 v)` | [`Color`](color.md) | Constructs a Color using the vector's XYZ components as the color's RGB components, alpha defaults to 1.0. | None |
| `Color.New(Vector4 v)` | [`Color`](color.md) | Constructs a Color using the vector's XYZW components as the color's RGBA components. | None |
| `Color.New(Color c)` | [`Color`](color.md) | Makes a copy of the given color. | None |

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `r` | `number` | The Red component of the Color. | Read-Write |
| `g` | `number` | The Green component of the Color. | Read-Write |
| `b` | `number` | The Blue component of the Color. | Read-Write |
| `a` | `number` | The Alpha (transparency) component of the Color. | Read-Write |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetDesaturated(number desaturation)` | [`Color`](color.md) | Returns the desaturated version of the Color. 0 represents no desaturation and 1 represents full desaturation. | None |
| `ToStandardHex()` | `string` | Returns a hexadecimal sRGB representation of this color, in the format "#RRGGBBAA". Channel values outside the normal 0-1 range will be clamped, and some precision may be lost. | None |
| `ToLinearHex()` | `string` | Returns a hexadecimal linear RGB representation of this color, in the format "#RRGGBBAA". Channel values outside the normal 0-1 range will be clamped, and some precision may be lost. | None |

## Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `Color.Lerp(Color from, Color to, number progress)` | [`Color`](color.md) | Linearly interpolates between two colors in HSV space by the specified progress amount and returns the resultant Color. | None |
| `Color.Random()` | [`Color`](color.md) | Returns a new color with random RGB values and Alpha of 1.0. | None |
| `Color.FromStandardHex(string hexString)` | [`Color`](color.md) | Creates a Color from the given sRGB hexadecimal string. Supported formats include "#RGB", "#RGBA", "#RRGGBB", and "#RRGGBBAA", with or without the leading "#". | None |
| `Color.FromLinearHex(string hexString)` | [`Color`](color.md) | Creates a Color from the given linear RGB hexadecimal string. Supported formats include "#RGB", "#RGBA", "#RRGGBB", and "#RRGGBBAA", with or without the leading "#". | None |

## Operators

| Operator Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Color + Color` | [`Color`](color.md) | Component-wise addition. | None |
| `Color - Color` | [`Color`](color.md) | Component-wise subtraction | None |
| `Color * Color` | [`Color`](color.md) | Component-wise multiplication. | None |
| `Color * number` | [`Color`](color.md) | Multiplies each component of the Color by the right-side number. | None |
| `Color / Color` | [`Color`](color.md) | Component-wise division. | None |
| `Color / number` | [`Color`](color.md) | Divides each component of the Color by the right-side number. | None |

## Additional Info

### Predefined Colors

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

Example using:

### `Lerp`

### `RED`

### `GREEN`

### `YELLOW`

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

See also: [CoreMath.Clamp](coremath.md)

---

Example using:

### `Random`

### `ToStandardHex`

### `ToLinearHex`

### `r`

### `g`

### `b`

### `a`

In this example, 10 random colors are generated. Their values are printed out to the event log in three forms: standard hexadecimal, linear hexadecimal and RGBA float values.

```lua
function MakeRandomColor()
    local c = Color.Random()
    local sHex = c:ToStandardHex()
    local lHex = c:ToLinearHex()
    print("Random color. SHex = "..sHex..". LHex = "..lHex..". RBGA = ("
        ..c.r..","..c.g..","..c.b..","..c.a..")")
end

for i = 1,10 do
    MakeRandomColor()
end
```

---

Example using:

### `WHITE`

### `GRAY`

### `BLACK`

### `TRANSPARENT`

### `RED`

### `GREEN`

### `BLUE`

### `CYAN`

### `MAGENTA`

### `YELLOW`

### `ORANGE`

### `PURPLE`

### `BROWN`

### `PINK`

### `TAN`

### `RUBY`

### `EMERALD`

### `SAPPHIRE`

### `SILVER`

### `SMOKE`

In this example, the debug `DrawLine()` is used to draw all available color constants. Trigonometry is used for calculating a circle around the player and displaying all colors in a rotating shape.

```lua
local COLOR_CONSTANTS = {
    Color.WHITE,
    Color.GRAY,
    Color.BLACK,
    Color.TRANSPARENT,
    Color.RED,
    Color.GREEN,
    Color.BLUE,
    Color.CYAN,
    Color.MAGENTA,
    Color.YELLOW,
    Color.ORANGE,
    Color.PURPLE,
    Color.BROWN,
    Color.PINK,
    Color.TAN,
    Color.RUBY,
    Color.EMERALD,
    Color.SAPPHIRE,
    Color.SILVER,
    Color.SMOKE,
}

function Tick()
    local playerPos = Game.GetLocalPlayer():GetWorldPosition()
    local radius = 500
    local angle = math.rad(360) / #COLOR_CONSTANTS
    local params = { thickness = 10 }

    for i,c in ipairs(COLOR_CONSTANTS) do
        params.color = c
        local v = Vector3.ZERO
        local theta = angle * (i - 1) + time()
        v.x = math.cos(theta) * radius
        v.y = math.sin(theta) * radius
        CoreDebug.DrawLine(playerPos, playerPos + v, params)
    end
end
```

See also: [CoreDebug.DrawLine](coredebug.md) | [Game.GetLocalPlayer](game.md) | [Player.GetWorldPosition](player.md) | [Vector3.ZERO](vector3.md)

---

Example using:

### `New`

This example shows how to construct a new color object. The three parameters given to `New()` are the three primary colors of light: Red, Green, and Blue. Here, we create a magenta color by using the values Red = 1, Green = 0 and Blue = 0.5.

```lua
local color = Color.New(1, 0, 0.5)
UI.PrintToScreen("MAGENTA", color)
```

See also: [UI.PrintToScreen](ui.md)

---

Example using:

### `GetDesaturated`

In this example, the color of a UI text is slowly desaturated until it reaches grayscale.

```lua
local UI_TEXT = script:GetCustomProperty("UITextBox"):WaitForObject()
local START_COLOR = UI_TEXT:GetColor()
local SPEED = 0.2
local elapsedTime = 1

function Tick(deltaTime)
    elapsedTime = CoreMath.Clamp(elapsedTime - deltaTime * SPEED)
    local color = START_COLOR:GetDesaturated(elapsedTime)
    UI_TEXT:SetColor(color)
end
```

See also: [UIImage.GetColor](uiimage.md) | [CoreMath.Clamp](coremath.md) | [CoreObject.GetCustomProperty](coreobject.md) | [CoreObjectReference.WaitForObject](coreobjectreference.md)

---
