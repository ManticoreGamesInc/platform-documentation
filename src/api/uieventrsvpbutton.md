---
id: uieventrsvpbutton
name: UIEventRSVPButton
title: UIEventRSVPButton
tags:
    - API
---

# UIEventRSVPButton

A UIControl for a button which allows players to register for an event within a game. Similar to `UIButton`, but designed to present a consistent experience for players across all games. Inherits from [UIControl](uicontrol.md).

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `isInteractable` | `boolean` | Returns whether the button can interact with the cursor (click, hover, etc). | Read-Write |
| `eventId` | `string` | Returns the ID of the event for which this button is currently configured. This ID can be found in the creator dashboard or using the `CoreGameEvent.id` property of an event returned from various `CorePlatform` functions. | Read-Write |

## Events

| Event Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `clickedEvent` | [`Event`](event.md)<[`UIEventRSVPButton`](uieventrsvpbutton.md)> | Fired when button is clicked. This triggers on mouse-button up, if both button-down and button-up events happen inside the button hitbox. | None |
| `pressedEvent` | [`Event`](event.md)<[`UIEventRSVPButton`](uieventrsvpbutton.md)> | Fired when button is pressed. (mouse button down) | None |
| `releasedEvent` | [`Event`](event.md)<[`UIEventRSVPButton`](uieventrsvpbutton.md)> | Fired when button is released. (mouse button up) | None |
| `hoveredEvent` | [`Event`](event.md)<[`UIEventRSVPButton`](uieventrsvpbutton.md)> | Fired when button is hovered. | None |
| `unhoveredEvent` | [`Event`](event.md)<[`UIEventRSVPButton`](uieventrsvpbutton.md)> | Fired when button is unhovered. | None |

## Tutorials

[UI in Core](../references/ui.md)
