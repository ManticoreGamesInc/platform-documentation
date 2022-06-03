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
| `isHittable` | `boolean` | When set to `true`, this control can receive input from the cursor and blocks input to controls behind it. When set to `false`, the cursor ignores this control and can interact with controls behind it. | Read-Write |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetCurrentTouchIndex()` | `integer` | Returns the touch index currently interacting with this button. Returns `nil` if the button is not currently being interacted with. | Client-Only |

## Events

| Event Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `clickedEvent` | [`Event`](event.md)<[`UIEventRSVPButton`](uieventrsvpbutton.md)> | Fired when button is clicked. This triggers on mouse-button up, if both button-down and button-up events happen inside the button hitbox. | None |
| `pressedEvent` | [`Event`](event.md)<[`UIEventRSVPButton`](uieventrsvpbutton.md)> | Fired when button is pressed. (mouse button down) | None |
| `releasedEvent` | [`Event`](event.md)<[`UIEventRSVPButton`](uieventrsvpbutton.md)> | Fired when button is released. (mouse button up) | None |
| `hoveredEvent` | [`Event`](event.md)<[`UIEventRSVPButton`](uieventrsvpbutton.md)> | Fired when button is hovered. | None |
| `unhoveredEvent` | [`Event`](event.md)<[`UIEventRSVPButton`](uieventrsvpbutton.md)> | Fired when button is unhovered. | None |
| `touchStartedEvent` | [`Event`](event.md)<[`UIEventRSVPButton`](uieventrsvpbutton.md), [`Vector2`](vector2.md) location, `integer` touchIndex> | Fired when the player starts touching the control on a touch input device. Parameters are the screen location of the touch and a touch index used to distinguish between separate touches on a multitouch device. | Client-Only |
| `touchStoppedEvent` | [`Event`](event.md)<[`UIEventRSVPButton`](uieventrsvpbutton.md), [`Vector2`](vector2.md) location, `integer` touchIndex> | Fired when the player stops touching the control on a touch input device. Parameters are the screen location from which the touch was released and a touch index used to distinguish between separate touches on a multitouch device. | Client-Only |
| `tappedEvent` | [`Event`](event.md)<[`UIEventRSVPButton`](uieventrsvpbutton.md), [`Vector2`](vector2.md) location, `integer` touchIndex> | Fired when the player taps the control on a touch input device. Parameters are the screen location of the tap and the touch index with which the tap was performed. | Client-Only |
| `flickedEvent` | [`Event`](event.md)<[`UIEventRSVPButton`](uieventrsvpbutton.md), `number` angle> | Fired when the player performs a quick flicking gesture on the control on a touch input device. The `angle` parameter indicates the direction of the flick. 0 indicates a flick to the right. Values increase in degrees counter-clockwise, so 90 indicates a flick straight up, 180 indicates a flick to the left, etc. | Client-Only |
| `pinchStartedEvent` | [`Event`](event.md)<[`UIEventRSVPButton`](uieventrsvpbutton.md)> | Fired when the player begins a pinching gesture on the control on a touch input device. `Input.GetPinchValue()` may be polled during the pinch gesture to determine how far the player has pinched. | Client-Only |
| `pinchStoppedEvent` | [`Event`](event.md)<[`UIEventRSVPButton`](uieventrsvpbutton.md)> | Fired when the player ends a pinching gesture on a touch input device. | Client-Only |
| `rotateStartedEvent` | [`Event`](event.md)<[`UIEventRSVPButton`](uieventrsvpbutton.md)> | Fired when the player begins a rotating gesture on the control on a touch input device. `Input.GetRotateValue()` may be polled during the rotate gesture to determine how far the player has rotated. | Client-Only |
| `rotateStoppedEvent` | [`Event`](event.md)<[`UIEventRSVPButton`](uieventrsvpbutton.md)> | Fired when the player ends a rotating gesture on a touch input device. | Client-Only |

## Examples

Example using:

### `GetTouchPosition`

### `GetPinchValue`

### `GetRotateValue`

### `pinchStartedEvent`

### `pinchStoppedEvent`

### `rotateStartedEvent`

### `rotateStoppedEvent`

In this example we manipulate a UI object with a multi-touch pinching gesture. The pinch gesture is used to move, scale and rotate a the UI Text on screen.

```lua
-- Client Script as a child of the UI object.
local UI_OBJECT = script.parent

-- Make the UI Control hittable
UI_OBJECT.isHittable = true

local isPinching = false
local isRotating = false
local startingWidth
local startingHeight
local startingAngle

function Tick()
-- Position
local touch1 = Input.GetTouchPosition(1)
local touch2 = Input.GetTouchPosition(2)

if touch1 ~= nil and touch2 ~= nil then
    local position = (touch1 + touch2) / 2

    UI_OBJECT:SetAbsolutePosition(position)
end

-- Scale
if isPinching then
    local pinchPercent = Input.GetPinchValue()

    UI_OBJECT.width = CoreMath.Round(startingWidth * pinchPercent)
    UI_OBJECT.height = CoreMath.Round(startingHeight * pinchPercent)
end

-- Rotate
if isRotating then
    local angle = Input.GetRotateValue()

    UI_OBJECT.rotationAngle = startingAngle + angle
end
end

-- Detect pinch gesture start/end
UI_OBJECT.pinchStartedEvent:Connect(function()
isPinching = true
startingWidth = UI_OBJECT.width
startingHeight = UI_OBJECT.height
end)

UI_OBJECT.pinchStoppedEvent:Connect(function()
isPinching = false
end)

-- Detect rotation gesture start/end
UI_OBJECT.rotateStartedEvent:Connect(function()
isRotating = true
startingAngle = UI_OBJECT.rotationAngle
end)

UI_OBJECT.rotateStoppedEvent:Connect(function()
isRotating = false
end)
```

See also: [UIControl.SetAbsolutePosition](uicontrol.md) | [UIEventRSVPButton.isHittable](uieventrsvpbutton.md) | [CoreObject.parent](coreobject.md) | [CoreMath.Round](coremath.md)

---

Example using:

### `tappedEvent`

### `flickedEvent`

In this example we listen for the tapped and flicked touch gestures on the UI object. When one of those events is triggered, the pertinent information is printed to the screen.

```lua
-- Client Script as a child of the UI object.
local UI_OBJECT = script.parent

-- Make the UI Control hittable
UI_OBJECT.isHittable = true

function OnTappedEvent(control, location, touchIndex)
UI.PrintToScreen("Tap ".. touchIndex ..": ".. tostring(location))
end

function OnFlickedEvent(control, angle)
UI.PrintToScreen("Flick: " .. angle)
end

UI_OBJECT.tappedEvent:Connect(OnTappedEvent)
UI_OBJECT.flickedEvent:Connect(OnFlickedEvent)
```

See also: [UI.PrintToScreen](ui.md) | [Event.Connect](event.md) | [UIEventRSVPButton.isHittable](uieventrsvpbutton.md)

---

Example using:

### `touchStartedEvent`

### `touchStoppedEvent`

In this example, the touch inputs on the UI object are tracked in two different ways, with a counter and with a table. Each time the amount of touches change a summary of the touch information is printed to screen.

```lua
-- Client Script as a child of the UI object.
local UI_OBJECT = script.parent

-- Make the UI Control hittable
UI_OBJECT.isHittable = true

local touchCount = 0
local activeTouches = {}

function PrintTouchInfo()
local str = touchCount .. ": ["
local addComma = false

for id,_ in pairs(activeTouches) do
    if addComma then
        str = str .. ", "
    end

    addComma = true
    str = str .. id
end

str = str .. "]"

UI.PrintToScreen(str)
end

local function OnTouchStarted(control, location, touchId)
touchCount = touchCount + 1
activeTouches[touchId] = true

PrintTouchInfo()
end

local function OnTouchStopped(control, location, touchId)
touchCount = touchCount - 1
activeTouches[touchId] = nil

PrintTouchInfo()
end

UI_OBJECT.touchStartedEvent:Connect(OnTouchStarted)
UI_OBJECT.touchStoppedEvent:Connect(OnTouchStopped)
```

See also: [UI.PrintToScreen](ui.md) | [Event.Connect](event.md) | [UIEventRSVPButton.isHittable](uieventrsvpbutton.md)

---

Example using:

### `eventId`

In this example, a client script controls a UI that prompts players to join (RSVP) an upcoming game event. In case the player has already registered for the event, then the UI does not show. The UI is populated with information about the event, such as name and description. Also, the RSVP Button must be given the game event's `id` in order to connect correctly with the platform service. The UI becomes hidden when the RSVP or Close buttons are clicked.

```lua
local GAME_ID = "a3040c7ff0ca4a148d98191c701afe9a"

local UI_ROOT = script:GetCustomProperty("UIContainer"):WaitForObject()
local CLOSE_BUTTON = script:GetCustomProperty("UIButton"):WaitForObject()
local UI_EVENT_NAME = script:GetCustomProperty("UITextBox"):WaitForObject()
local UI_EVENT_DESCRIPTION = script:GetCustomProperty("UITextBox_1"):WaitForObject()
local RSVP_BUTTON = script:GetCustomProperty("UIEventRSVPButton"):WaitForObject()

local player = Game.GetLocalPlayer()

function ShowUI()
UI_ROOT.visibility = Visibility.INHERIT
end

function HideUI()
UI_ROOT.visibility = Visibility.FORCE_OFF
end

function UpdateContents(eventData)
UI_EVENT_NAME.text = eventData.name
UI_EVENT_DESCRIPTION.text = eventData.description
RSVP_BUTTON.eventId = eventData.id
end

function EvaluateUpcomingEvent()
local collection = CorePlatform.GetGameEventsForGame(GAME_ID)
for i, eventData in ipairs(collection:GetResults()) do
    if eventData.state == CoreGameEventState.SCHEDULED
    and not CorePlatform.IsPlayerRegisteredForGameEvent(player, eventData) then
        UpdateContents(eventData)
        ShowUI()
        return
    end
end
end

CLOSE_BUTTON.clickedEvent:Connect(HideUI)
RSVP_BUTTON.clickedEvent:Connect(HideUI)

EvaluateUpcomingEvent()
```

See also: [CoreGameEventCollection.GetResults](coregameeventcollection.md) | [CorePlatform.GetGameEventsForGame](coreplatform.md) | [CoreGameEvent.state](coregameevent.md) | [CoreGameEventState](enums.md#coregameeventstate) | [UIButton.clickedEvent](uibutton.md) | [UIText.text](uitext.md) | [CoreObject.GetCustomProperty](coreobject.md)

---

## Tutorials

[UI in Core](../references/ui.md)
