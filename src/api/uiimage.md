---
id: uiimage
name: UIImage
title: UIImage
tags:
    - API
---

# UIImage

A UIControl for displaying an image.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `isTeamColorUsed` | `boolean` | If `true`, the image will be tinted blue if its team matches the Player, or red if not. | Read-Write |
| `team` | `integer` | the team of the image, used for `isTeamColorUsed`. | Read-Write |
| `shouldClipToSize` | `boolean` | Whether or not the image and its shadow should be clipped when exceeding the bounds of this control. | Read-Write |
| `isFlippedHorizontal` | `boolean` | Whether or not the image is flipped horizontally. | Read-Write |
| `isFlippedVertical` | `boolean` | Whether or not the image is flipped vertically. | Read-Write |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetColor()` | [`Color`](color.md) | Returns the current color of the UIImage. | None |
| `SetColor(Color)` | `None` | Sets the UIImage to a color. | None |
| `GetShadowColor()` | [`Color`](color.md) | Returns the color of the image's drop shadow. | None |
| `SetShadowColor(Color)` | `None` | Sets the color of the image's drop shadow. | None |
| `GetShadowOffset()` | [`Vector2`](vector2.md) | Returns the offset of the image's drop shadow in UI space. | None |
| `SetShadowOffset(Vector2)` | `None` | Sets the offset of the image's drop shadow in UI space. | None |
| `GetImage()` | `string` | Returns the imageId assigned to this UIImage control. | None |
| `SetImage(string imageId)` | `None` | Sets the UIImage to a new image asset ID. You can get this ID from an Asset Reference. | None |
| `SetImage(Player)` | `None` | Downloads and sets a Player's profile picture as the texture for this UIImage control. | **Deprecated** |
| `SetPlayerProfile(Player)` | `None` | Downloads and sets a Player's profile picture as the texture for this UIImage control. | None |
| `SetPlayerProfile(CorePlayerProfile)` | `None` | Downloads and sets a player's profile picture as the texture for this UIImage control. | None |
| `SetPlayerProfile(CoreFriendCollectionEntry)` | `None` | Downloads and sets a player's profile picture as the texture for this UIImage control. | None |
| `SetPlayerProfile(string playerId)` | `None` | Downloads and sets a player's profile picture as the texture for this UIImage control. | None |

## Examples

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

[UI in Core](../tutorials/ui_reference.md)
