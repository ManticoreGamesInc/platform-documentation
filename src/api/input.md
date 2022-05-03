---
id: input
name: Input
title: Input
tags:
    - API
---

# Input

The Input namespace contains functions and hooks for responding to player input.

## Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `Input.GetActionValue(Player, string actionName)` | `value` | Returns the current input value associated with the specified action. This will return a `Vector2` for direction bindings, a `number` for basic and axis bindings, or `nil` for invalid bindings. `nil` may also be returned when called on the server with a non-networked action name or a networked action which simply hasn't been pressed yet. | None |
| `Input.IsActionHeld(Player, string actionName)` | `boolean` | Returns `true` if the specified action is currently being held by the player, otherwise returns `false`. | None |
| `Input.GetCurrentInputType()` | [`InputType`](enums.md#inputtype) | Returns the current active input type. | Client-Only |
| `Input.IsYAxisInverted(InputType)` | `boolean` | Returns `true` if the player has inverted the Y axis in their settings for the given input type, otherwise returns `false`. | Client-Only |
| `Input.GetActionDescription(string actionName)` | `string` | Returns the description set in the Bindings Manager for the specified action. Returns `nil` if given an invalid action name. | Client-Only |
| `Input.GetActions()` | `Array`<`string`> | Returns a list of the names of each action from currently active binding sets. Actions are included in this list regardless of whether the action is currently held or not. | Client-Only |
| `Input.GetActionInputLabel(string actionName, [table parameters])` | `string` | Returns a string label indicating the key or button assigned to the specified action. Returns `nil` if `actionName` is not a valid action or if an invalid `direction` parameter is specified for axis and direction bindings. Returns "None" for valid actions with no control bound. <br/>Supported parameters include: <br/>`direction (string)`: *Required* for axis and direction bindings, specifying "positive" or "negative" for axis bindings, or "up", "down", "left", or "right" for direction bindings. <br/>`inputType (InputType)`: Specifies whether to return a label for keyboard and mouse or controller. Defaults to the current active input type. <br/>`secondary (boolean)`: When `true` and returning a label for keyboard and mouse, returns a label for the secondary input. | Client-Only |
| `Input.IsInputTypeEnabled(InputType)` | `boolean` | Returns `true` when the current device supports the given input type. For example, `Input.IsInputEnabled(InputType.CONTROLLER)` will return `true` if a gamepad is connected. | Client-Only |
| `Input.IsActionEnabled(string actionName)` | `boolean` | Returns `true` if the specified action is enabled. Returns `false` if the action is disabled or does not exist. | Client-Only |
| `Input.EnableAction(string actionName)` | `None` | Enables the specified action, if the action exists. | Client-Only |
| `Input.DisableAction(string actionName)` | `None` | Disables the specified action, if the action exists. If the action is currently held, this will also release the action. | Client-Only |
| `Input.GetCursorPosition()` | [`Vector2`](vector2.md) | Returns a Vector2 with the `x`, `y` coordinates of the mouse cursor on the screen. May return `nil` if the cursor position cannot be determined. | Client-Only |
| `Input.GetTouchPosition([integer touchIndex])` | [`Vector2`](vector2.md) | Returns a Vector2 with the `x`, `y` coordinates of a touch input on the screen. An optional touch index may be provided to specify which touch to return on multitouch devices. If not specified, index 1 is used. Returns `nil` if the requested touch index is not currently active. | Client-Only |
| `Input.GetPointerPosition([integer touchIndex])` | [`Vector2`](vector2.md) | When the current input type is `InputType.TOUCH`, returns a Vector2 with the `x`, `y` coordinates of a touch input on the screen. When the current input type is not `InputType.TOUCH`, returns the cursor position. An optional touch index may be provided to specify which touch to return on multitouch devices. If not specified, index 1 is used. Returns `nil` if the requested touch index is not currently active. The touch index is ignored for other input types. | Client-Only |
| `Input.GetPinchValue()` | `number` | During a pinch gesture with touch input, returns a value indicating the relative progress of the pinch gesture. Pinch gestures start with a pinch value of 1 and approach 0 when pinching together, or increase past 1 when touches move apart from each other. Returns 0 if no pinch is in progress. | Client-Only |
| `Input.GetRotateValue()` | `number` | During a rotate gesture with touch input, returns a value indicating the angle of rotation from the start of the gesture. Returns 0 if no rotate is in progress. | Client-Only |
| `Input.EnableVirtualControls()` | `None` | Enables display of virtual controls on devices with touch input, or in preview mode if device emulation is enabled. Virtual controls default to enabled when using touch input. | Client-Only |
| `Input.DisableVirtualControls()` | `None` | Disables display of virtual controls on devices with touch input, or in preview mode with device emulation enabled. | Client-Only |

## Events

| Event Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `Input.actionPressedEvent` | [`Event`](event.md)<[`Player`](player.md) player, `string` actionName, `value` value> | Fired when a player starts an input action by pressing a key, button, or other input control. The third parameter, `value`, will be a `Vector2` for direction bindings, or a `number` for axis and basic bindings. | None |
| `Input.actionReleasedEvent` | [`Event`](event.md)<[`Player`](player.md) player, `string` actionName> | Fired when a player stops an input action by releasing a key, button, or other input control. | None |
| `Input.inputTypeChangedEvent` | [`Event`](event.md)<[`Player`](player.md) player, [`InputType`](enums.md#inputtype) inputType> | Fired when the active input device has changed to a new type of input. | None |
| `Input.touchStartedEvent` | [`Event`](event.md)<[`Vector2`](vector2.md) location, `integer` touchIndex> | Fired when the player starts touching the screen on a touch input device. Parameters are the screen location of the touch and a touch index used to distinguish between separate touches on a multitouch device. | Client-Only |
| `Input.touchStoppedEvent` | [`Event`](event.md)<[`Vector2`](vector2.md) location, `integer` touchIndex> | Fired when the player stops touching the screen on a touch input device. Parameters are the screen location from which the touch was released and a touch index used to distinguish between separate touches on a multitouch device. | Client-Only |
| `Input.tappedEvent` | [`Event`](event.md)<[`Vector2`](vector2.md) location, `integer` touchIndex> | Fired when the player taps on a touch input device. Parameters are the screen location of the tap and the touch index with which the tap was performed. | Client-Only |
| `Input.flickedEvent` | [`Event`](event.md)<`number` angle> | Fired when the player performs a quick flicking gesture on a touch input device. The `angle` parameter indicates the direction of the flick. 0 indicates a flick to the right. Values increase in degrees counter-clockwise, so 90 indicates a flick straight up, 180 indicates a flick to the left, etc. | Client-Only |
| `Input.pinchStartedEvent` | [`Event`](event.md) | Fired when the player begins a pinching gesture on a touch input device. `Input.GetPinchValue()` may be polled during the pinch gesture to determine how far the player has pinched. | Client-Only |
| `Input.pinchStoppedEvent` | [`Event`](event.md) | Fired when the player ends a pinching gesture on a touch input device. | Client-Only |
| `Input.rotateStartedEvent` | [`Event`](event.md) | Fired when the player begins a rotating gesture on a touch input device. `Input.GetRotateValue()` may be polled during the rotate gesture to determine how far the player has rotated. | Client-Only |
| `Input.rotateStoppedEvent` | [`Event`](event.md) | Fired when the player ends a rotating gesture on a touch input device. | Client-Only |
| `Input.pointerMovedEvent` | [`Event`](event.md)<[`Vector2`](vector2.md) delta, `integer` touchIndex> | Fired when the pointer (either the mouse or a touch input) has moved. Parameters include the change in position since the last time `pointerMovedEvent` was fired for the given pointer, and an optional touch index indicating which touch input moved. `touchIndex` will be `nil` when the mouse has moved. | Client-Only |
| `Input.mouseButtonPressedEvent` | [`Event`](event.md)<[`Vector2`](vector2.md) position, [`MouseButton`](enums.md#mousebutton)> | Fired when the user has pressed a mouse button. Parameters indicate the screen position of the cursor when the button was pressed, and an enum value indicating which mouse button was pressed. | Client-Only |
| `Input.mouseButtonReleasedEvent` | [`Event`](event.md)<[`Vector2`](vector2.md) position, [`MouseButton`](enums.md#mousebutton)> | Fired when the user has released a mouse button. Parameters indicate the screen position of the cursor when the button was released, and an enum value indicating which mouse button was released. | Client-Only |

## Hooks

| Hook Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `escapeHook` | [`Hook`](hook.md)<[`Player`](player.md) player, `table` parameters> | Hook called when the local player presses the Escape key. The `parameters` table contains a `boolean` named "openPauseMenu", which may be set to `false` to prevent the pause menu from being opened. Players may press `Shift-Esc` to force the pause menu to open without calling this hook. | Client-Only |
| `actionHook` | [`Hook`](hook.md)<[`Player`](player.md) player, `table` actionList> | Hook called each frame with a list of changes in action values since the previous frame. The `actionList` table is an array of tables with the structure {action = "actionName", value = `number` or `Vector2`} for each action whose value has changed since the last frame. If no values have changed, `actionList` will be empty, even if there are actions currently being held. Entries in the table can be added, removed, or changed and will affect whether pressed and released events fire. If a non-zero value is changed to zero then `Input.actionReleasedEvent` will fire for that action. If a zero value changes to non-zero then `Input.actionPressedEvent` will fire. | Client-Only |

## Examples

Example using:

### `DisableVirtualControls`

### `EnableVirtualControls`

In this example, a trigger is setup to display a UI dialog to any player who walks over it. When this happens, virtual touch controls are disabled. Simultaneously, we tell Core to enable cursor controls. This dual approach broadens the game's support for different types of devices. If the device doesn't support touch or a cursor the corresponding command has no effect. We also setup a UI button that can be used for closing the dialog. When the dialog is closed the touch/cursor controls are set back to normal.

```lua
local TRIGGER = script:GetCustomProperty("Trigger"):WaitForObject()
local UIPANEL = script:GetCustomProperty("UIPanel"):WaitForObject()
local CLOSE_BUTTON = script:GetCustomProperty("CloseButton"):WaitForObject()

UIPANEL.visibility = Visibility.FORCE_OFF

TRIGGER.beginOverlapEvent:Connect(function()
    Input.DisableVirtualControls()
    UI.SetCursorVisible(true)
    UI.SetCanCursorInteractWithUI(true)
    UIPANEL.visibility = Visibility.FORCE_ON
end)

CLOSE_BUTTON.clickedEvent:Connect(function()
    Input.EnableVirtualControls()
    UI.SetCursorVisible(false)
    UI.SetCanCursorInteractWithUI(false)
    UIPANEL.visibility = Visibility.FORCE_OFF
end)
```

See also: [Trigger.beginOverlapEvent](trigger.md) | [UIButton.clickedEvent](uibutton.md) | [UI.SetCursorVisible](ui.md) | [CoreObject.visibility](coreobject.md) | [CoreObjectReference.WaitForObject](coreobjectreference.md)

---

Example using:

### `GetCursorPosition`

In this client script we listen for the player's shoot action (left mouse click) then print the position of their cursor to the event log.

```lua
local function OnActionPressed(player, action)
    if action == "Shoot" then
        local cursorPos = Input.GetCursorPosition()
        if cursorPos then
            print("Clicked at: " .. cursorPos.x .. ", " .. cursorPos.y)
        else
            print("Clicked at an undefined position.")
        end
    end
end

Input.actionPressedEvent:Connect(OnActionPressed)
```

See also: [Game.GetLocalPlayer](game.md) | [Input.actionPressedEvent](input.md) | [Vector2.x](vector2.md)

---

Example using:

### `GetTouchPosition`

### `GetPinchValue`

### `GetRotateValue`

### `pinchStartedEvent`

### `pinchStoppedEvent`

### `rotateStartedEvent`

### `rotateStoppedEvent`

In this example we manipulate an image with a multi-touch pinching gesture. The pinch gesture is used to move, scale and roate a 2D image on screen.

```lua
local UIIMAGE = script:GetCustomProperty("UIImage"):WaitForObject()

UIIMAGE.anchor = UIPivot.MIDDLE_CENTER

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
        UIIMAGE:SetAbsolutePosition(position)
    end

    -- Scale
    if isPinching then
        local pinchPercent = Input.GetPinchValue()
        UIIMAGE.width = CoreMath.Round(startingWidth * pinchPercent)
        UIIMAGE.height = CoreMath.Round(startingHeight * pinchPercent)
    end

    -- Rotate
    if isRotating then
        local angle = Input.GetRotateValue()
        UIIMAGE.rotationAngle = startingAngle + angle
    end
end

-- Detect pinch gesture start/end
Input.pinchStartedEvent:Connect(function()
    isPinching = true
    startingWidth = UIIMAGE.width
    startingHeight = UIIMAGE.height
end)

Input.pinchStoppedEvent:Connect(function()
    isPinching = false
end)

-- Detect rotation gesture start/end
Input.rotateStartedEvent:Connect(function()
    isRotating = true
    startingAngle = UIIMAGE.rotationAngle
end)

Input.rotateStoppedEvent:Connect(function()
    isRotating = false
end)
```

See also: [UIControl.SetAbsolutePosition](uicontrol.md) | [CoreObject.GetCustomProperty](coreobject.md) | [CoreObjectReference.WaitForObject](coreobjectreference.md)

---

Example using:

### `tappedEvent`

### `flickedEvent`

In this example we listen for the tapped and flicked touch gestures. When one of those events is triggered, the pertinent information is printed to the screen.

```lua
function OnTappedEvent(location, touchIndex)
    UI.PrintToScreen("Tap ".. touchIndex ..": ".. tostring(location))
end

function OnFlickedEvent(angle)
    UI.PrintToScreen("Flick: " .. angle)
end

Input.tappedEvent:Connect(OnTappedEvent)
Input.flickedEvent:Connect(OnFlickedEvent)
```

See also: [UI.PrintToScreen](ui.md) | [Event.Connect](event.md)

---

Example using:

### `touchStartedEvent`

### `touchStoppedEvent`

In this example, touch inputs are tracked in two different ways, with a counter and with a table. Each time the amount of touches change a summary of the touch information is printed to screen.

```lua
local touchCount = 0
local activeTouches = {}

function OnTouchStarted(screenPosition, touchId)
    touchCount = touchCount + 1
    activeTouches[touchId] = true
    PrintTouchInfo()
end

function OnTouchStopped(screenPosition, touchId)
    touchCount = touchCount - 1
    activeTouches[touchId] = nil
    PrintTouchInfo()
end

Input.touchStartedEvent:Connect(OnTouchStarted)
Input.touchStoppedEvent:Connect(OnTouchStopped)

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
```

See also: [UI.PrintToScreen](ui.md) | [Event.Connect](event.md)

---

Example using:

### `actionHook`

In this example we override the jump action to make all players automatically jump every second.

```lua
local JUMP_PERIOD = 1
local nextJumpTime = 0

function OnAction(player, actionList)
    -- Verbose output of all actions to the Event Log
    for k,v in ipairs(actionList) do
        print(tostring(k), tostring(v.action), tostring(v.value))
    end

    -- Everyone periodically jumps automatically
    if time() > nextJumpTime then
        -- Jump
        nextJumpTime = time() + JUMP_PERIOD
        actionList[1] = {
            action = "Jump",
            value = 1.0
        }
    else
        -- No jump
        actionList[1] = {
            action = "Jump",
            value = 0.0
        }
    end
end

Input.actionHook:Connect(OnAction)
```

See also: [Hook.Connect](hook.md)

---

Example using:

### `IsActionEnabled`

### `EnableAction`

### `DisableAction`

In this example players are prevented from jumping while moving. Also, a UI element is toggled on/off to indicate when jump is available.

```lua
local JUMP_ICON = script:GetCustomProperty("JumpIcon"):WaitForObject()

function Tick()
    if Input.IsActionEnabled("Jump") then
        JUMP_ICON.visibility = Visibility.INHERIT
    else
        JUMP_ICON.visibility = Visibility.FORCE_OFF
    end
end

function OnAction(player, actionList)
    for k,v in ipairs(actionList) do
        -- Verbose output of all actions to the Event Log
        print(tostring(k), tostring(v.action), tostring(v.value))

        -- Toggle jump on/off, depending on movement
        if v.action == "Move" then
            if v.value == Vector2.ZERO then
                Input.EnableAction("Jump")
            else
                Input.DisableAction("Jump")
            end
        end
    end
end

Input.actionHook:Connect(OnAction)
```

See also: [CoreObject.visibility](coreobject.md) | [CoreObjectReference.WaitForObject](coreobjectreference.md) | [Hook.Connect](hook.md)

---

Example using:

### `GetActionInputLabel`

This client script shows how to get the "display name" for the jump action. It may usually say "Space Bar". However, the user could bind different keys to their inputs, or the value may differ due to localization. If you were to hardcode the words "Space Bar" into the user interface, it would be misleading for some users. Instead, call `Input.GetActionInputLabel()` and use the returned value to populate the UI.

```lua
local UI_TEXT = script:GetCustomProperty("UIText"):WaitForObject()

local label = Input.GetActionInputLabel("jump", {inputType = InputType.KEYBOARD_AND_MOUSE})
print(tostring(label))

UI_TEXT.text = label
```

---

Example using:

### `actionPressedEvent`

Hotbars in games are a useful way for players to access things such as abilities, weapons, or tools quickly. This example shows how the mouse wheel can be used to scroll through all the slots in a hotbar. It supports wrapping around when scrolling past the start or end of the hotbar.

```lua
-- Client script.

-- The container that holds the slots.
local SLOTS_CONTAINER = script:GetCustomProperty("SlotsContainer"):WaitForObject()

-- The color of the slot frame when it is active.
local ACTIVE_COLOR = script:GetCustomProperty("ActiveColor")

-- The color of the slot frame when it is inactive.
local INACTIVE_COLOR = script:GetCustomProperty("InactiveColor")

-- The current active slot index.
local currentSlotIndex = 1

-- All the slots in the container.
local slots = SLOTS_CONTAINER:GetChildren()

-- Total slots, just caching it here for use later.
local totalSlots = #slots

-- Sets a slot to become active based on the index passed in.
local function SetActiveSlot(index)
    slots[index]:FindChildByName("Frame"):SetColor(ACTIVE_COLOR)
end

-- Clears the last active slot based on the index passed in.
local function ClearActiveSlot(index)
    slots[index]:FindChildByName("Frame"):SetColor(INACTIVE_COLOR)
end

-- Listens for when an action is pressed.
Input.actionPressedEvent:Connect(function(player, action, value)
    -- Checks to see if the action is the Zoom action.
    -- This could be a custom action, doesn't need to be named "Zoom".
    if action == "Zoom" then
        -- Need to store the old slot to compare later on.
        local oldSlotIndex = currentSlotIndex

        -- Scroll wheel will either be -1 or 1.
        if value > 0 then
            currentSlotIndex = currentSlotIndex == totalSlots and 1 or (currentSlotIndex + 1)
        elseif value < 0 then
            currentSlotIndex = currentSlotIndex == 1 and totalSlots or (currentSlotIndex - 1)
        end

        -- If the slot has changed, clear the old one and set the new one.
        if oldSlotIndex ~= currentSlotIndex then
            ClearActiveSlot(oldSlotIndex)
            SetActiveSlot(currentSlotIndex)
        end
    end
end)

-- Set the active slot from the start (1 in this case).
SetActiveSlot(currentSlotIndex)
```

See also: [CoreObject.GetCustomProperty](coreobject.md) | [CoreObjectReference.WaitForObject](coreobjectreference.md) | [UIImage.SetColor](uiimage.md)

---

Example using:

### `actionPressedEvent`

### `actionReleasedEvent`

This client script demonstrates how to listen for all input actions being pressed/released. Results appear in the Event Log.

```lua
function OnActionPressed(player, action, value)
    print("Action: " .. action .. ", value: " .. tostring(value))
end

function OnActionReleased(player, action)
    print("Action: " .. action)
end

Input.actionPressedEvent:Connect(OnActionPressed)
Input.actionReleasedEvent:Connect(OnActionReleased)
```

---

Example using:

### `escapeHook`

Core has a default pause menu that appears when a player presses the ESC key. This client script demonstrates how to prevent Core's default pause from occurring and replace it with a custom menu. As a fallback in case your UI gets stuck, Shift + ESC allows you to access Core's default pause, even with the escape hook in place.

```lua
-- "MenuPanel" is a UI Panel assigned as a custom property to the script.
local CUSTOM_MENU = script:GetCustomProperty("MenuPanel"):WaitForObject()
-- "ExitButton" is a UI Button within that panel. Also assigned as a custom property.
local EXIT_BUTTON = script:GetCustomProperty("ExitButton"):WaitForObject()

CUSTOM_MENU.visibility = Visibility.FORCE_OFF
local isShowingMenu = false

function ShowMenu()
    -- Show our custom menu and enable mouse control
    isShowingMenu = true
    CUSTOM_MENU.visibility = Visibility.INHERIT
    UI.SetCanCursorInteractWithUI(true)
    UI.SetCursorVisible(true)
end

function HideMenu()
    -- Hide our custom menu and disable mouse control
    isShowingMenu = false
    CUSTOM_MENU.visibility = Visibility.FORCE_OFF
    UI.SetCanCursorInteractWithUI(false)
    UI.SetCursorVisible(false)
end

function OnEscape(localPlayer, params)
    -- Prevents Core's default pause from appearing
    params.openPauseMenu = false

    -- Toggle the custom menu on/off
    if isShowingMenu then
        HideMenu()
    else
        ShowMenu()
    end
end

-- Intercept the ESC key being pressed
Input.escapeHook:Connect(OnEscape)

-- Send players to Core World when they press the custom "Exit" button
EXIT_BUTTON.clickedEvent:Connect(function()
    Game.GetLocalPlayer():TransferToGame("e39f3e/core-world")
end)
```

See also: [Player.TransferToGame](player.md) | [UIButton.clickedEvent](uibutton.md) | [UI.SetCanCursorInteractWithUI](ui.md) | [Game.GetLocalPlayer](game.md)

---

Example using:

### `inputTypeChangedEvent`

In this example, the UI will update to show what input type the player is currently using, and will update the UI when the player changes the input type.

```lua
-- Client script.

-- UI image for mouse input.
local MOUSE_IMAGE = script:GetCustomProperty("MouseImage"):WaitForObject()

-- UI image for controller input.
local CONTROLLER_IMAGE = script:GetCustomProperty("ControllerImage"):WaitForObject()

-- Fired when the input has changed.
local function UpdateInputImage(player, changedInputType)
    -- Check the changed input type by comparing with the
    -- InputType enum.
    if changedInputType == InputType.KEYBOARD_AND_MOUSE then
        MOUSE_IMAGE.visibility = Visibility.FORCE_ON
        CONTROLLER_IMAGE.visibility = Visibility.FORCE_OFF
    elseif changedInputType == InputType.CONTROLLER then
        MOUSE_IMAGE.visibility = Visibility.FORCE_OFF
        CONTROLLER_IMAGE.visibility = Visibility.FORCE_ON
    end
end

Input.inputTypeChangedEvent:Connect(UpdateInputImage)

-- Update the input type image first time
UpdateInputImage(Game.GetLocalPlayer(), Input.GetCurrentInputType())
```

See also: [CoreObject.GetCustomProperty](coreobject.md) | [Game.GetLocalPlayer](game.md) | [CoreObjectReference.WaitForObject](coreobjectreference.md) | [Input.GetCurrentInputType](input.md) | [KEYBOARD_AND_MOUSE](enums.md#keyboard_and_mouse)

---
