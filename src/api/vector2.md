---
id: vector2
name: Vector2
title: Vector2
tags:
    - API
---

# Vector2

A two-component vector that can represent a position or direction.

## Constructors

| Constructor Name | Return Type | Description | Tags |
| ----------- | ----------- | ----------- | ---- |
| `Vector2.New([number x, number y])` | [`Vector2`](vector2.md) | Constructs a Vector2 with the given `x`, `y` values, defaults to (0, 0). | None |
| `Vector2.New(number)` | [`Vector2`](vector2.md) | Constructs a Vector2 with `x`, `y` values both set to the given value. | None |
| `Vector2.New(Vector3 v)` | [`Vector2`](vector2.md) | Constructs a Vector2 with `x`, `y` values from the given Vector3. | None |
| `Vector2.New(Vector2 v)` | [`Vector2`](vector2.md) | Constructs a Vector2 with `x`, `y` values from the given Vector2. | None |

## Constants

| Constant Name | Return Type | Description | Tags |
| ----------- | ----------- | ----------- | ---- |
| `Vector2.ZERO` | [`Vector2`](vector2.md) | (0, 0) | None |
| `Vector2.ONE` | [`Vector2`](vector2.md) | (1, 1) | None |

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `x` | `number` | The `x` component of the Vector2. | Read-Write |
| `y` | `number` | The `y` component of the Vector2. | Read-Write |
| `size` | `number` | The magnitude of the Vector2. | Read-Only |
| `sizeSquared` | `number` | The squared magnitude of the Vector2. | Read-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetNormalized()` | [`Vector2`](vector2.md) | Returns a new Vector2 with size 1, but still pointing in the same direction. Returns (0, 0) if the vector is too small to be normalized. | None |
| `GetAbs()` | [`Vector2`](vector2.md) | Returns a new Vector2 with each component the absolute value of the component from this Vector2. | None |

## Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `Vector2.Lerp(Vector2 from, Vector2 to, number progress)` | [`Vector2`](vector2.md) | Linearly interpolates between two vectors by the specified progress amount and returns the resultant Vector2. | None |

## Operators

| Operator Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Vector2 + Vector2` | [`Vector2`](vector2.md) | Component-wise addition. | None |
| `Vector2 + number` | [`Vector2`](vector2.md) | Adds the right-side number to each of the components in the left side and returns the resulting Vector2. | None |
| `Vector2 - Vector2` | [`Vector2`](vector2.md) | Component-wise subtraction. | None |
| `Vector2 - number` | [`Vector2`](vector2.md) | Subtracts the right-side number from each of the components in the left side and returns the resulting Vector2. | None |
| `Vector2 * Vector2` | [`Vector2`](vector2.md) | Component-wise multiplication. | None |
| `Vector2 * number` | [`Vector2`](vector2.md) | Multiplies each component of the Vector2 by the right-side number. | None |
| `number * Vector2` | [`Vector2`](vector2.md) | Multiplies each component of the Vector2 by the left-side number. | None |
| `Vector2 / Vector2` | [`Vector2`](vector2.md) | Component-wise division. | None |
| `Vector2 / number` | [`Vector2`](vector2.md) | Divides each component of the Vector2 by the right-side number. | None |
| `-Vector2` | [`Vector2`](vector2.md) | Returns the negation of the Vector2. | None |
| `Vector2 .. Vector2` | `number` | Returns the dot product of the Vector2s. | None |
| `Vector2 ^ Vector2` | `number` | Returns the cross product of the Vector2s. | None |

## Examples

Example using:

### `New`

### `Lerp`

### `x`

### `y`

This client script demonstrates how to animate a `UI Panel` to make it enter and exit the screen smoothly. By calling either `Show()` or `Hide()` we set the panel's desired position. In the Tick function we use `Lerp()` to update the value, which gives the animation an "ease out" behavior.

```lua
local UI_PANEL = script:GetCustomProperty("UIPanel"):WaitForObject()
local LERP_SPEED = 12

local START_POS = Vector2.New(UI_PANEL.x, UI_PANEL.y)
local destination = START_POS

function Show()
    destination = START_POS
end

function Hide()
    destination.y = START_POS.y + 800
end

function Tick(deltaTime)
    local t = CoreMath.Clamp(deltaTime * LERP_SPEED)
    local pos = Vector2.New(UI_PANEL.x, UI_PANEL.y)
    pos = Vector2.Lerp(pos, destination, t)
    UI_PANEL.x = pos.x
    UI_PANEL.y = pos.y
end
```

See also: [CoreObject.GetCustomProperty](coreobject.md) | [CoreObjectReference.WaitForObject](coreobjectreference.md) | [UIControl.x](uicontrol.md)

---

Example using:

### `x`

### `y`

In this client script we listen for the player's primary action (for example Left mouse click) then print the position of their cursor to the event log.

```lua
function OnBindingPressed(player, action)
    if action == "ability_primary" then
        local cursorPos = Input.GetCursorPosition()
        if cursorPos then
            print("Clicked at: " .. cursorPos.x .. ", " .. cursorPos.y)
        else
            print("Clicked at an undefined position.")
        end
    end
end

local player = Game.GetLocalPlayer()
player.bindingPressedEvent:Connect(OnBindingPressed)
```

See also: [Input.GetCursorPosition](input.md) | [Game.GetLocalPlayer](game.md) | [Player.bindingPressedEvent](player.md)

---
