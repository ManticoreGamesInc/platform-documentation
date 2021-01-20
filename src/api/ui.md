---
id: ui
name: UI
title: UI
tags:
    - API
---

# API: UI

## Description

The UI namespace contains a set of class functions allowing you to get information about a Player's display and push information to their HUD. Most functions require the script to be inside a ClientContext and execute for the local Player.

## API

### Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `UI.ShowFlyUpText(string message, Vector3 worldPosition, [table parameters])` | `None` | Shows a quick text on screen that tracks its position relative to a world position. The last parameter is an optional table containing additional parameters: duration (Number) - How long the text should remain on the screen. Default duration is 0.5 seconds; color (Color) - The color of the Text. Default is white; isBig (boolean) - When true, larger text is used. | Client-Only |
| `UI.ShowDamageDirection(Vector3 worldPosition)` | `None` | Local player sees an arrow pointing towards some damage source. Lasts for 5 seconds. | Client-Only |
| `UI.ShowDamageDirection(CoreObject source)` | `None` | Local player sees an arrow pointing towards some CoreObject. Multiple calls with the same CoreObject reuse the same UI indicator, but refreshes its duration. | Client-Only |
| `UI.ShowDamageDirection(Player source)` | `None` | Local player sees an arrow pointing towards some other Player. Multiple calls with the same Player reuse the same UI indicator, but refreshes its duration. The arrow points to where the source was at the moment `ShowDamageDirection` is called and does not track the source Player's movements. | Client-Only |
| `UI.GetCursorPosition()` | `Vector2` | Returns a Vector2 with the `x`, `y` coordinates of the mouse cursor on the screen. Only gives results from a client context. May return `nil` if the cursor position cannot be determined. | None |
| `UI.GetScreenPosition(Vector3 worldPosition)` | `Vector2` | Calculates the location that worldPosition appears on the screen. Returns a Vector2 with the `x`, `y` coordinates, or `nil` if worldPosition is behind the camera. Only gives results from a client context. | None |
| `UI.GetScreenSize()` | `Vector2` | Returns a Vector2 with the size of the Player's screen in the `x`, `y` coordinates. Only gives results from a client context. May return `nil` if the screen size cannot be determined. | None |
| `UI.PrintToScreen(string message, [Color])` | `None` | Draws a message on the corner of the screen. Second optional Color parameter can change the color from the default white. | Client-Only |
| `UI.IsCursorVisible()` | `bool` | Returns whether the cursor is visible. | Client-Only |
| `UI.SetCursorVisible(bool isVisible)` | `None` | Sets whether the cursor is visible. | Client-Only |
| `UI.IsCursorLockedToViewport()` | `bool` | Returns whether to lock cursor in viewport. | Client-Only |
| `UI.SetCursorLockedToViewport(bool isLocked)` | `None` | Sets whether to lock cursor in viewport. | Client-Only |
| `UI.CanCursorInteractWithUI()` | `bool` | Returns whether the cursor can interact with UI elements like buttons. | Client-Only |
| `UI.SetCanCursorInteractWithUI(bool)` | `None` | Sets whether the cursor can interact with UI elements like buttons. | Client-Only |
| `UI.IsReticleVisible()` | `bool` | Check if reticle is visible. | Client-Only |
| `UI.SetReticleVisible(bool show)` | `None` | Shows or hides the reticle for the Player. | Client-Only |
| `UI.GetCursorHitResult()` | `HitResult` | Return hit result from local client's view in direction of the Projected cursor position. Meant for client-side use only, for Ability cast, please use `ability:GetTargetData():GetHitPosition()`, which would contain cursor hit position at time of cast, when in top-down camera mode. | Client-Only |
| `UI.GetCursorPlaneIntersection(Vector3 pointOnPlane, [Vector3 planeNormal])` | `Vector3` | Return intersection from local client's camera direction to given plane, specified by point on plane and optionally its normal. Meant for client-side use only. Example usage: `local hitPos = UI.GetCursorPlaneIntersection(Vector3.New(0, 0, 0))`. | Client-Only |

## Tutorials

[UI in Core](../tutorials/ui_reference.md)
