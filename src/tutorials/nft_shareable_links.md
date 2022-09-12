---
id: nft_shareable_links
name: NFT Shareable Links
title: NFT Shareable Links
tags:
    - Tutorial
---

# NFT Shareable Links

<div class="mt-video" style="width:100%">
    <video autoplay muted playsinline controls loop class="center" style="width:100%">
        <source src="/img/NFTShareableLinks/preview.mp4" type="video/mp4" />
    </video>
</div>

## Overview

In this tutorial, you will learn how to use the Text Entry Box to display an NFT (Non-fungible Token) URL that players can copy which can then be used in their web browser.

Current solutions for linking players to an NFT require either them typing out the full URL that would be displayed in-game, or having a device so a QR code can be scanned. Using the [Text Entry Box](../references/ui_text_entry_box.md), players can easily copy the text contents directly from the game into their browser.

* **Skills you will learn:**
    * Displaying an NFT image.
    * Using a trigger to show UI.
    * Set the text of a Text Entry Box and focus it.

## Import Picture Frame Template

To display NFTs, a [picture frame template](../img/NFTShareableLinks/picture_frame_template.png) has been created that you can import into your project. The template contains a small bit of geometry along with some UI for the NFT image and NFT name. A trigger has also been added that will be will be connected in a Lua script later.

Save the image to your computer, then drag and drop it into the **Core Editor**. If done correctly, the template will show up in **Project Content**.

![!Info](../img/NFTShareableLinks/picture_frame_template.png){: .center loading="lazy" }

### Add Picture Frame to Hierarchy

The picture frame will be used to display the NFT image and name. This template will be updated to contain a script so that the frame can be placed anywhere, and can also be duplicated to have multiple instances of it.

1. Create a **Client Context** in the **Hierarchy**.
2. Add the **NFT Picture Frame** template to the client context folder.
3. Deinstance the template so it can be edited.
4. Place the picture frame where you want in the scene.

In the image below, 3 picture frames have been placed on a wall.

![!Frames](../img/NFTShareableLinks/picture_frames.png){: .center loading="lazy" }

## Create Link UI

When the player interacts with the trigger, some [UI](../references/ui.md) will pop up that contains a text entry box that will be focused so the text is highlighted automatically.

1. Create **UI Container** in the client context folder.
2. Create a **UI Panel** inside the **UI Container** and name it `Link Panel`.
3. Set the **Visibility** property on the **Link Panel** in the **Properties** window to **Force Off**.
4. Create a **Text Entry Box** inside the **Link Panel** and name it `URL Text Entry`.

Feel free to design the UI how you like.

![!UI](../img/NFTShareableLinks/url_ui.png){: .center loading="lazy" }

## Create NFTShareableLinkClient Script

Create a new script called `NFTShareableLinkClient`. This script needs to be placed inside the **NFT Picture Frame** folder in the **Hierarchy**. This is because it will allow you to update the template later so it can be used elsewhere in the scene.

![!Create Script](../img/NFTShareableLinks/create_script.png){: .center loading="lazy" }

### Create Custom properties

The **NFTShareableLinkClient** script needs references to a few different things so they can be accessed via the Lua script.

1. Add a **string** custom property called `ContractAddress`.
2. Add a **string** custom property called `TokenID`.
3. Add the **Trigger** object as a custom property called `Trigger`.
4. Add the **Info** UI Text object as a custom property called `Info`.
5. Add the **Picture** UI Image object as a custom property called `Picture`.
6. Add the **Link Panel** object as a custom property called `LinkPanel`.
7. Add the **Text Entry** object as a custom property called `TextEntry`.

![!Properties](../img/NFTShareableLinks/properties.png){: .center loading="lazy" }

### Create Property References

Open up the **NFTShareableLinkClient** script and add the variables to the properties so you have references for each one.

```lua
local CONTRACT_ADDRESS = script:GetCustomProperty("ContractAddress")
local TOKEN_ID = script:GetCustomProperty("TokenID")
local TRIGGER = script:GetCustomProperty("Trigger"):WaitForObject()
local INFO = script:GetCustomProperty("Info"):WaitForObject()
local PICTURE = script:GetCustomProperty("Picture"):WaitForObject()
local LINK_PANEL = script:GetCustomProperty("LinkPanel"):WaitForObject()
local TEXT_ENTRY = script:GetCustomProperty("TextEntry"):WaitForObject()
```

### Create Variable

A reference to the local player is needed. This can be done by storing the returned value from `Game.GetLocalPlayer()` in a variable.

```lua
local LOCAL_PLAYER = Game.GetLocalPlayer()
```

### Load NFT Token

The first thing to do is load the NFT token for the picture frame. When loading an NFT from the blockchain, it is recommended to check if it was a success. When calling `GetToken`, it will yield the script while it attempts to retrieve the token data. It's best to always check the status code when making blockchain calls so you can display an error to the player.

If the token data is successfully retrieved, then the `INFO` text is set to the `token.name` value. The `PICTURE` also has the image set by using the `SetBlockchainToken` function while passing in the `token` as an argument.

Notice that the `TRIGGER` is now set to be interactable. This is done after the data has been retrieved successfully so that the player can open up the UI.

```lua
local token, success, err = Blockchain.GetToken(CONTRACT_ADDRESS, TOKEN_ID)

if success == BlockchainTokenResultCode.SUCCESS then
    INFO.text = token.name
    PICTURE:SetBlockchainToken(token)
    TRIGGER.isInteractable = true
else
    print(err)
end
```

### Create OnTriggerInteracted Function

Create a function called `OnTriggerInteracted`. This function will be called when the player interacts with the `TRIGGER`. It will enable the cursor, and display the `LINK_PANEL` UI. At the same time, the text for the `TEXT_ENTRY` is updated to point to the NFT page on OpenSea by concatenating the `CONTRACT_ADDRESS` and `TOKEN_ID` together to form a valid URL.

When the player interacts with the trigger that will open the UI, the `TEXT_ENTRY` needs to be focused so the player can copy and paste it right away. This can be done by using the `Focus` function.

```lua
local function OnTriggerInteracted(trigger, other)
    if other == LOCAL_PLAYER then
        UI.SetCanCursorInteractWithUI(true)
        UI.SetCursorVisible(true)

        trigger.isInteractable = false
        LINK_PANEL.visibility = Visibility.FORCE_ON
        TEXT_ENTRY.text = "https://opensea.io/assets/ethereum/" .. CONTRACT_ADDRESS .. "/" .. TOKEN_ID
        TEXT_ENTRY:Focus()
    end
end
```

### Create OnTriggerExit Function

Create a function called `OnTriggerExit`. This function will disable the cursor, turn off the visibility of the `LINK_PANEL`, and also set the trigger to be interactable again. This is so the label is shown to the player.

```lua
local function OnTriggerExit(trigger, other)
    if other == LOCAL_PLAYER then
        UI.SetCanCursorInteractWithUI(false)
        UI.SetCursorVisible(false)

        LINK_PANEL.visibility = Visibility.FORCE_OFF
        trigger.isInteractable = true
    end
end
```

### Connect Trigger Events

Connect up the 2 events for the trigger so that they call the connected functions.

```lua
TRIGGER.interactedEvent:Connect(OnTriggerInteracted)
TRIGGER.endOverlapEvent:Connect(OnTriggerExit)
```

### The NFTShareableLinkClient Script

??? "NFTShareableLinkClient"
    ```lua
    local CONTRACT_ADDRESS = script:GetCustomProperty("ContractAddress")
    local TOKEN_ID = script:GetCustomProperty("TokenID")
    local TRIGGER = script:GetCustomProperty("Trigger"):WaitForObject()
    local INFO = script:GetCustomProperty("Info"):WaitForObject()
    local PICTURE = script:GetCustomProperty("Picture"):WaitForObject()
    local LINK_PANEL = script:GetCustomProperty("LinkPanel"):WaitForObject()
    local TEXT_ENTRY = script:GetCustomProperty("TextEntry"):WaitForObject()

    local LOCAL_PLAYER = Game.GetLocalPlayer()
    local token, success, err = Blockchain.GetToken(CONTRACT_ADDRESS, TOKEN_ID)

    if success == BlockchainTokenResultCode.SUCCESS then
        INFO.text = token.name
        PICTURE:SetBlockchainToken(token)
        TRIGGER.isInteractable = true
    else
        print(err)
    end

    local function OnTriggerInteracted(trigger, other)
        if other == LOCAL_PLAYER then
            UI.SetCanCursorInteractWithUI(true)
            UI.SetCursorVisible(true)

            trigger.isInteractable = false
            LINK_PANEL.visibility = Visibility.FORCE_ON
            TEXT_ENTRY.text = "https://opensea.io/assets/ethereum/" .. CONTRACT_ADDRESS .. "/" .. TOKEN_ID
            TEXT_ENTRY:Focus()
        end
    end

    local function OnTriggerExit(trigger, other)
        if other == LOCAL_PLAYER then
            UI.SetCanCursorInteractWithUI(false)
            UI.SetCursorVisible(false)

            LINK_PANEL.visibility = Visibility.FORCE_OFF
            trigger.isInteractable = true
        end
    end

    TRIGGER.interactedEvent:Connect(OnTriggerInteracted)
    TRIGGER.endOverlapEvent:Connect(OnTriggerExit)
    ```

### Test the Game

Test the game by entering a contract address and token ID into the custom properties on the `NFTShareableLinkClient` script. After a few seconds, an NFT image should load, along with the name. The trigger will then become interactable, which will open up the UI to copy the URL.

<div class="mt-video" style="width:100%">
    <video autoplay muted playsinline controls loop class="center" style="width:100%">
        <source src="/img/NFTShareableLinks/client_finished.mp4" type="video/mp4" />
    </video>
</div>

## Create NFTShareableLinkServer Script

You may have noticed that when you attempt to copy the text from the text entry box, it forces the player into crouching. You can solve this by creating a server script that will listen for a broadcast to disable crouching for the player when they interact with the trigger. When the player leaves the trigger, it will allow them to crouch again.

Create a new script called `NFTShareableLinkServer` and place it in a Server Context in the Hierarchy.

### Create DisableCrouch Function

Create a function called `DisableCrouch`. This function will set the property `isCrouchEnabled` to false to prevent the player from crouching.

```lua
local function DisableCrouch(player)
    player.isCrouchEnabled = false
end
```

### Create EnableCrouch Function

Create a function called `EnableCrouch`. This function will set the property `isCrouchEnabled` to true to allow the player to crouch.

```lua
local function EnableCrouch(player)
    player.isCrouchEnabled = true
end
```

### Connect Events

Connect up the events.

```lua
Events.ConnectForPlayer("DisableCrouch", DisableCrouch)
Events.ConnectForPlayer("EnableCrouch", EnableCrouch)
```

### The NFTShareableLinkServer Script

??? "NFTShareableLinkServer"
    ```lua
    local function DisableCrouch(player)
        player.isCrouchEnabled = false
    end

    local function EnableCrouch(player)
        player.isCrouchEnabled = true
    end

    Events.ConnectForPlayer("DisableCrouch", DisableCrouch)
    Events.ConnectForPlayer("EnableCrouch", EnableCrouch)
    ```

## Edit NFTShareableLinkClient Script

The **NFTShareableLinkClient** script needs to be modified so it can broadcast to the server at certain points.

### Modify OnTriggerInteracted Function

Modify the **OnTriggerInteracted** function so that it broadcasts to the server to disable the player's crouch.

```lua hl_lines="3"
local function OnTriggerInteracted(trigger, other)
    if other == LOCAL_PLAYER then
        Events.BroadcastToServer("DisableCrouch")

        UI.SetCanCursorInteractWithUI(true)
        UI.SetCursorVisible(true)

        trigger.isInteractable = false
        LINK_PANEL.visibility = Visibility.FORCE_ON
        TEXT_ENTRY.text = "https://opensea.io/assets/ethereum/" .. CONTRACT_ADDRESS .. "/" .. TOKEN_ID
        TEXT_ENTRY:Focus()
    end
end
```

### Modify OnTriggerExit Function

Modify the **OnTriggerExit** function so that it broadcasts to the server to enable the player's crouch.

```lua hl_lines="3"
local function OnTriggerExit(trigger, other)
    if other == LOCAL_PLAYER then
        Events.BroadcastToServer("EnableCrouch")

        UI.SetCanCursorInteractWithUI(false)
        UI.SetCursorVisible(false)

        LINK_PANEL.visibility = Visibility.FORCE_OFF
        trigger.isInteractable = true
    end
end
```

### The NFTShareableLinkClient Script

??? "NFTShareableLinkClient"
    ```lua
    local CONTRACT_ADDRESS = script:GetCustomProperty("ContractAddress")
    local TOKEN_ID = script:GetCustomProperty("TokenID")
    local TRIGGER = script:GetCustomProperty("Trigger"):WaitForObject()
    local INFO = script:GetCustomProperty("Info"):WaitForObject()
    local PICTURE = script:GetCustomProperty("Picture"):WaitForObject()
    local LINK_PANEL = script:GetCustomProperty("LinkPanel"):WaitForObject()
    local TEXT_ENTRY = script:GetCustomProperty("TextEntry"):WaitForObject()

    local LOCAL_PLAYER = Game.GetLocalPlayer()
    local token, success, err = Blockchain.GetToken(CONTRACT_ADDRESS, TOKEN_ID)

    if success == BlockchainTokenResultCode.SUCCESS then
        INFO.text = token.name
        PICTURE:SetBlockchainToken(token)
        TRIGGER.isInteractable = true
    else
        print(err)
    end

    local function OnTriggerInteracted(trigger, other)
        if other == LOCAL_PLAYER then
            Events.BroadcastToServer("DisableCrouch")

            UI.SetCanCursorInteractWithUI(true)
            UI.SetCursorVisible(true)

            trigger.isInteractable = false
            LINK_PANEL.visibility = Visibility.FORCE_ON
            TEXT_ENTRY.text = "https://opensea.io/assets/ethereum/" .. CONTRACT_ADDRESS .. "/" .. TOKEN_ID
            TEXT_ENTRY:Focus()
        end
    end

    local function OnTriggerExit(trigger, other)
        if other == LOCAL_PLAYER then
            Events.BroadcastToServer("EnableCrouch")

            UI.SetCanCursorInteractWithUI(false)
            UI.SetCursorVisible(false)

            LINK_PANEL.visibility = Visibility.FORCE_OFF
            trigger.isInteractable = true
        end
    end

    TRIGGER.interactedEvent:Connect(OnTriggerInteracted)
    TRIGGER.endOverlapEvent:Connect(OnTriggerExit)
    ```

### Test the Game

Test the game to make sure when copying the text from the text entry box, the player doesn't crouch. When leaving the trigger area, the crouch will be enabled for the player.

<div class="mt-video" style="width:100%">
    <video autoplay muted playsinline controls loop class="center" style="width:100%">
        <source src="/img/NFTShareableLinks/finished.mp4" type="video/mp4" />
    </video>
</div>

## Learn More

[Text Entry Box](../references/ui_text_entry_box.md) | [Pet Namer Tutorial](../tutorials/pet_namer.md) | [Text Entry Validation Tutorial](../tutorials/text_entry_validation.md) | [Blockchain API](../api/blockchain.md) | [Text Entry Box API](../api/uitextentry.md)
