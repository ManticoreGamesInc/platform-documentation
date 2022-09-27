---
id: uiimage
name: UIImage
title: UIImage
tags:
    - API
    - UI
---

# UIImage

A UIControl for displaying an image. Inherits from [UIControl](uicontrol.md).

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `isTeamColorUsed` | `boolean` | If `true`, the image will be tinted blue if its team matches the Player, or red if not. | Read-Write |
| `team` | `integer` | the team of the image, used for `isTeamColorUsed`. | Read-Write |
| `shouldClipToSize` | `boolean` | Whether or not the image and its shadow should be clipped when exceeding the bounds of this control. | Read-Write |
| `isFlippedHorizontal` | `boolean` | Whether or not the image is flipped horizontally. | Read-Write |
| `isFlippedVertical` | `boolean` | Whether or not the image is flipped vertically. | Read-Write |
| `sourceImageAspectRatio` | `number` | The aspect ratio of the image. | Read-Only |
| `isHittable` | `boolean` | When set to `true`, this control can receive input from the cursor and blocks input to controls behind it. When set to `false`, the cursor ignores this control and can interact with controls behind it. | Read-Write |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetColor()` | [`Color`](color.md) | Returns the current color of the UIImage. | None |
| `SetColor(Color)` | `None` | Sets the UIImage to a color. | None |
| `GetShadowColor()` | [`Color`](color.md) | Returns the color of the image's drop shadow. | None |
| `SetShadowColor(Color)` | `None` | Sets the color of the image's drop shadow. | None |
| `GetShadowOffset()` | [`Vector2`](vector2.md) | Returns the offset of the image's drop shadow in UI space. | None |
| `GetSourceImageSize()` | [`Vector2`](vector2.md) | Returns the size of the image. | None |
| `SetShadowOffset(Vector2)` | `None` | Sets the offset of the image's drop shadow in UI space. | None |
| `GetImage()` | `string` | Returns the `imageId` assigned to this UIImage control. **Note:** As of 1.0.211, this function returns `nil` instead of `"0BADBADBADBADBAD"` when no image asset has been set. | **Breaking-Change** |
| `SetImage(string imageId)` | `None` | Sets the UIImage to a new image asset ID. You can get this ID from an Asset Reference. | None |
| `SetImage(Player)` | `None` | Downloads and sets a Player's profile picture as the texture for this UIImage control. | <abbr title='This API is deprecated and might be removed in a future version.'><strong>Deprecated</strong></abbr> |
| `SetPlayerProfile(Player)` | `None` | Downloads and sets a Player's profile picture as the texture for this UIImage control. | None |
| `SetPlayerProfile(CorePlayerProfile)` | `None` | Downloads and sets a player's profile picture as the texture for this UIImage control. | None |
| `SetPlayerProfile(CoreFriendCollectionEntry)` | `None` | Downloads and sets a player's profile picture as the texture for this UIImage control. | None |
| `SetPlayerProfile(string playerId)` | `None` | Downloads and sets a player's profile picture as the texture for this UIImage control. | None |
| `SetGameEvent(CoreGameEvent event)` | `None` | Downloads and sets a game event image as the texture for this UIImage control. | None |
| `SetGameScreenshot(string gameId, [integer screenshotIndex])` | `None` | Downloads and sets a game screenshot as the texture for this UIImage control. The screenshot may come from a different game. | None |
| `SetCameraCapture(CameraCapture)` | `None` | Sets the UIImage to display the given camera capture. If the given capture is not valid, it will be ignored. If the capture is released while in use, this UIImage will revert to its default image. | Client-Only |
| `SetBlockchainToken(BlockchainToken token)` | `None` | Downloads and sets a blockchain token image as the texture for this UIImage control. | None |
| `GetCurrentTouchIndex()` | `integer` | Returns the touch index currently interacting with this image. Returns `nil` if the image is not currently being interacted with. | Client-Only |

## Events

| Event Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `touchStartedEvent` | [`Event`](event.md)<[`UIImage`](uiimage.md), [`Vector2`](vector2.md) location, `integer` touchIndex> | Fired when the player starts touching the control on a touch input device. Parameters are the screen location of the touch and a touch index used to distinguish between separate touches on a multitouch device. | Client-Only |
| `touchStoppedEvent` | [`Event`](event.md)<[`UIImage`](uiimage.md), [`Vector2`](vector2.md) location, `integer` touchIndex> | Fired when the player stops touching the control on a touch input device. Parameters are the screen location from which the touch was released and a touch index used to distinguish between separate touches on a multitouch device. | Client-Only |
| `tappedEvent` | [`Event`](event.md)<[`UIImage`](uiimage.md), [`Vector2`](vector2.md) location, `integer` touchIndex> | Fired when the player taps the control on a touch input device. Parameters are the screen location of the tap and the touch index with which the tap was performed. | Client-Only |
| `flickedEvent` | [`Event`](event.md)<[`UIImage`](uiimage.md), `number` angle> | Fired when the player performs a quick flicking gesture on the control on a touch input device. The `angle` parameter indicates the direction of the flick. 0 indicates a flick to the right. Values increase in degrees counter-clockwise, so 90 indicates a flick straight up, 180 indicates a flick to the left, etc. | Client-Only |
| `pinchStartedEvent` | [`Event`](event.md)<[`UIImage`](uiimage.md)> | Fired when the player begins a pinching gesture on the control on a touch input device. `Input.GetPinchValue()` may be polled during the pinch gesture to determine how far the player has pinched. | Client-Only |
| `pinchStoppedEvent` | [`Event`](event.md)<[`UIImage`](uiimage.md)> | Fired when the player ends a pinching gesture on a touch input device. | Client-Only |
| `rotateStartedEvent` | [`Event`](event.md)<[`UIImage`](uiimage.md)> | Fired when the player begins a rotating gesture on the control on a touch input device. `Input.GetRotateValue()` may be polled during the rotate gesture to determine how far the player has rotated. | Client-Only |
| `rotateStoppedEvent` | [`Event`](event.md)<[`UIImage`](uiimage.md)> | Fired when the player ends a rotating gesture on a touch input device. | Client-Only |

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
-- Client Script as a child of the UI Text.
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

local function OnPinchStarted()
    isPinching = true
    startingWidth = UI_OBJECT.width
    startingHeight = UI_OBJECT.height
end

local function OnPinchStopped()
    isPinching = false
end

-- Detect pinch gesture start/end
UI_OBJECT.pinchStartedEvent:Connect(OnPinchStarted)
UI_OBJECT.pinchStoppedEvent:Connect(OnPinchStopped)

local function OnRotateStarted()
    isRotating = true
    startingAngle = UI_OBJECT.rotationAngle
end

local function OnRotateStopped()
    isRotating = false
end

-- Detect rotation gesture start/end
UI_OBJECT.rotateStartedEvent:Connect(OnRotateStarted)
UI_OBJECT.rotateStoppedEvent:Connect(OnRotateStopped)
```

See also: [UIControl.SetAbsolutePosition](uicontrol.md) | [UIImage.isHittable](uiimage.md) | [CoreObject.parent](coreobject.md) | [CoreMath.Round](coremath.md)

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

See also: [UI.PrintToScreen](ui.md) | [Event.Connect](event.md) | [UIImage.isHittable](uiimage.md)

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

See also: [UI.PrintToScreen](ui.md) | [Event.Connect](event.md) | [UIImage.isHittable](uiimage.md)

---

Example using:

### `SetBlockchainToken`

MekaVerse is an NFT collection with 8,888 unique mechas. The following example shows how to remotely load the image for Meka #1. The script sits in the hierarchy as a child of a `UI Image`, which is used for visualizing the NFT's artwork.

```lua
-- Address to the NFT #1 in the MekaVerse collection
-- https://opensea.io/assets/ethereum/0x9a534628b4062e123ce7ee2222ec20b86e16ca8f/1
local UI_IMAGE = script.parent
local NFT_CONTRACT_ADDRESS = "0x9a534628b4062e123ce7ee2222ec20b86e16ca8f"
local TOKEN_ID = "1"

local token = Blockchain.GetToken(NFT_CONTRACT_ADDRESS, TOKEN_ID)
UI_IMAGE:SetBlockchainToken(token)
```

See also: [Blockchain.GetToken](blockchain.md) | [CoreObject.parent](coreobject.md)

---

Example using:

### `SetGameScreenshot`

Similar to portals, it's possible to show screenshots from another game inside 2D UI. In this example, we have a UI Image added as a custom property of the script. The script asks Core for the list of featured games and scrolls through all the screenshots for those games. In the end, the image is cleared back to normal.

```lua
local IMAGE = script:GetCustomProperty("UIImage"):WaitForObject()

local featuredGames = CorePlatform.GetGameCollection("featured")

for _,entry in ipairs(featuredGames) do
    print("Showing screenshots for " .. entry.name)

    local gameInfo = CorePlatform.GetGameInfo(entry.id)
    local count = gameInfo.screenshotCount

    -- Show each of the game's screenshots
    for i = 1,count do
        IMAGE:SetGameScreenshot(entry.id, i)
        Task.Wait(1)
    end
end

-- Clear it
IMAGE:SetGameScreenshot("")
```

See also: [CorePlatform.GetGameCollection](coreplatform.md) | [CoreGameCollectionEntry.id](coregamecollectionentry.md) | [CoreGameInfo.screenshotCount](coregameinfo.md) | [Task.Wait](task.md)

---

Example using:

### `SetPlayerProfile`

Player icons are a staple among online games. Player icons allow players to identify themselves within a game. This example will show you how to display your Core profile picture in a UI Image object.

```lua
-- Get the UI Image object
local propUIImage = script:GetCustomProperty("UIImage"):WaitForObject()

-- Get the local player
local player = Game.GetLocalPlayer()

-- Replaces the UI Image with your Core profile picture
propUIImage:SetPlayerProfile(player)
```

See also: [Game.GetLocalPlayer()](game.md)

---

Example using:

### `SetPlayerProfile`

Often to identify players you will want to use their Core profile picture. This example will demonstrate how to display the Core profile pictures of your friends by using the `SetPlayerProfile` method of a UI Image.

```lua
-- Get the local player
local player = Game.GetLocalPlayer()

-- Get the UI Image object
local propUIImage = script:GetCustomProperty("UIImage"):WaitForObject()

-- Get an array of friends of the local player
local friends = CoreSocial.GetFriends(player):GetResults()

-- Stores the current index in the friend list that is being used (starts at 1)
local currentIndex = 1

-- Represents the number of seconds left until the UI Image is updated with the profile picture of the next friend
local timer = 0

function Tick(deltaTime)
    -- Decrement the "deltaTime" number of seconds from the "timer"
    timer = timer - deltaTime

    -- If 2 seconds have passed, show the profile picture of the next friend, and reset the "timer" to 2 seconds
    if(timer <= 0) then
        -- If you have no friends on your Core friend list, then the rest of the code will be skipped
        -- Doing this prevents the script from trying to read an empty Core friend list.
        if(#friends == 0) then
            -- Exit this function before updating UI Image
            return
        end

        -- Reset the "timer" to 2 seconds
        timer = 2

        -- Get the id of the friend at the current index of the array
        local friend_id = friends[currentIndex].id

        -- Update the image with the friend's profile picture
        propUIImage:SetPlayerProfile(friend_id)

        -- Increment the "currentIndex" to select the next friend from the list
        currentIndex = currentIndex + 1

        -- If the "currentIndex" has reached the end of the list, reset it back to the start of the friend list
        if(currentIndex > #friends) then
            currentIndex = 1
        end
    end
end
```

See also: [CoreSocial.GetFriends](coresocial.md) | [CoreObject.GetCustomProperty](coreobject.md) | [CoreFriendCollection.GetResults](corefriendcollection.md) | [Game.GetLocalPlayer](game.md) | [Player.id](player.md)

---

Example using:

### `SetShadowOffset`

### `SetShadowColor`

Shadows provide a great way to make your UI Image stand out. This example will show you how to change the position and color of the shadow of a UI Image by using the `SetShadowOffset` and `SetShadowColor` methods.

```lua
-- Get the UI Image object
local propUIImage = script:GetCustomProperty("UIImage"):WaitForObject()

-- Keep track of the number of seconds that have passed since the script began running
local timePassed = 0

-- The relative position of the center of the circle
local circleCenterPosition = Vector2.New(30, 30)

function Tick(deltaTime)
    -- Update the "timePassed" to keep track of the number of seconds that have passed
    timePassed = timePassed + deltaTime

    -- Store the x and y position of the shadow
    local offset = Vector2.New(0, 0)

    -- Calculate the x and y position based on the time that has passed
    offset.x = (math.sin(timePassed) * 20) + circleCenterPosition.x
    offset.y = (math.cos(timePassed) * 20) + circleCenterPosition.y

    -- Update the position of the shadow
    propUIImage:SetShadowOffset(offset)

    -- The color will be stored in this variable
    local shadowColor = Color.New(0, 0, 1)

    -- Calculate the amount of blue that the shadow color will have
    local BlueChannel = (math.sin(timePassed) * 0.5) + 0.5

    -- Update the amount of blue the color "shadowColor" should have
    shadowColor.b = BlueChannel

    -- Update the color of the shadow of the UI Image
    propUIImage:SetShadowColor(shadowColor)
end
```

See also: [CoreObject.GetCustomProperty](coreobject.md)

---

## Tutorials

[UI in Core](../references/ui.md)
