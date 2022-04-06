---
id: ui library
name: UI Library
title: UI Library
---

# UI Library

## Functions

| Class Function Name | Return Type | Description | Tags |
| ------------------- | ----------- | ----------- | ---- |
| `ClampToScreen(UIControl, Vector2|nil)` | `None` | Clamps the object to the inside of the screen area. | None |
| `FormatInputType(string)` | `string` | Returns a shortened version of an input for use in UI. | None |
| `FormatTime(number, TimeFormatStyle)` | `string` | None | None |
| `GetAbsolutePosition(UIControl)` | `number`, `number` | Returns the absolute position of an object. | None |
| `GetAbsolutePosition_R(UIControl, number, number)` | `number`, `number` | A recursive function that climbs the hierarchy to calculate an objects absolute position. | None |
| `GetTopLeftPosition(UIControl, number, number)` | `number`, `number` | Returns the x and y coordinates for the top left position of a UIControl. Takes UIScrollPanels into account. | None |
| `IsAboveUIControl(UIControl, UIControl)` | `boolean` | Returns true if the first element is higher than the second. | None |
| `IsBottom(UIPivot)` | `boolean` | Returns true if the UIPivot is a bottom aligned pivot. | None |
| `IsCenter(UIPivot)` | `boolean` | Returns true if the UIPivot is a center aligned pivot. | None |
| `IsCursorOver(UIControl, boolean)` | `boolean` | Returns true if the cursor is over an object. | None |
| `IsLeft(UIPivot)` | `boolean` | Returns true if the UIPivot is a left aligned pivot. | None |
| `IsMiddle(UIPivot)` | `boolean` | Returns true if the UIPivot is a middle aligned pivot. | None |
| `IsObjectVisible(UIControl)` | `boolean` | Returns true if the control is currently visible on screen. Takes UIScrollPanels into account. | None |
| `IsRight(UIPivot)` | `boolean` | Returns true if the UIPivot is a right aligned pivot. | None |
| `IsTop(UIPivot)` | `boolean` | Returns true if the UIPivot is a top aligned pivot. | None |
