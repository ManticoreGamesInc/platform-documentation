---
id: nft_cosmetics
name: NFT Cosmetics
title: NFT Cosmetics
tags:
    - Tutorial
---
<!-- vale Google.Acronyms = NO -->
# NFT Cosmetics

<div class="mt-video" style="width:100%">
    <video autoplay muted playsinline controls loop class="center" style="width:100%">
        <source src="/img/NFTCosmetics/preview.mp4" type="video/mp4" />
    </video>
</div>

## Overview

In this tutorial, you will learn how to use NFTs (Non-fungible Tokens) as cosmetics. You will create a system that allows players to walk into a trigger and get a random cosmetic attached to them. You will be using an NFT cosmetics collection that has already been created, however, creating your own can also be done and used for this tutorial.

- **Skills you will learn:**
    - Reading NFTs using the Blockchain API.
    - Attaching objects to a socket on a player.
    - Changing the colors of a static mesh.
    - Creating a 3D progress bar.

## Using an Existing NFT Collection

This tutorial will use an existing NFT collection that uses the cardboard boxes from **Core Content**. For example, looking at NFT #3 in the collection, we can see it has attributes for **Box** and **Color**. The **Box** attribute is the row index from the data table of templates. This could be your data table of templates that make up how the cosmetic looks.

[https://opensea.io/collection/core-box-cosmetic](https://opensea.io/collection/core-box-cosmetic)

![!Properties](../img/NFTCosmetics/props.png){: .center loading="lazy" }

### NFT Token Data Table

Because the NFTs in the collection are lazily minted, there isn't a way to get all NFTs from a collection due to the contract address being a global address for lazy minted NFTs. This means if you try to retrieve NFTs using the contract address, it may return a random NFT created by someone else. The solution to this would be to put your NFTs on the blockchain, but this costs gas.

Another way we can solve this is by having a data table with the collection of NFT Token IDs, and we randomly pick a Token ID from the data table.

#### Create Cosmetic Tokens Data Table

Create a new data table called `Cosmetic Tokens`. This table will have 1 column called `TokenID` which is a string type.

Add as many tokens from the [collection](https://opensea.io/collection/core-box-cosmetic) by either copying the token ID from the URL or the **Details** section on the NFT page.

![!Cosmetic Tokens](../img/NFTCosmetics/tokens.png){: .center loading="lazy" }

## Create Cosmetics Data Table

We need a data table that will hold the templates that link to each **Box** attribute.

Create a data table called `Cosmetics` and add 1 column called `Template` that is an **Asset Reference** type.

![!Cosmetics](../img/NFTCosmetics/cosmetics.png){: .center loading="lazy" }

### Create Templates

Create some cosmetic templates that will be spawned and attached to the player when they walk through the trigger. For this tutorial, we are using the cardboard boxes from **Core Content**.

![!Box](../img/NFTCosmetics/box.png){: .center loading="lazy" }

### Add Templates to Data Table

When you have created your templates for the boxes, they need to be added to the Cosmetics data table.

![!Rows](../img/NFTCosmetics/cosmetic_rows.png){: .center loading="lazy" }

## Create Trigger

To apply a random cosmetic to the player, you will need to set up an area that has a trigger so that players can enter it and receive a cosmetic. In this case, we will make it so it applies a random one to the player.

1. Create a Client Context.
2. Create a trigger and scale it up so that players can enter it easily.
3. Add some geo so players know where to go to use and change their cosmetics.
4. Turn off the collision on the trigger.

![!Trigger](../img/NFTCosmetics/trigger.png){: .center loading="lazy" }

## Create Loading Bar

NFTs can take a little while to load. Having a progress bar to show the player will be a good idea so they know something is happening.

There are a few ways a loading bar could be done. In this section, we will create a 3D loading bar that will update as NFTs are loaded.

1. Create a group called `Loading`.
2. Adding 3D text objects that make up the word `Loading`.
3. Add a bar below the Loading text by setting the **Z** position to `-50`.
4. Set the scale of the bar to **X** `4`, **Y** `0.35`, **Z** `0.35`.
5. Duplicate the bar and rename it to `Progress Bar`.
6. Set position **Y** to `200`.
7. Set the rotation **Y** to `-90`.
8. Set the scale **X** to `0.35`, **Y** to `0.35`, and **Z** to `0`.

![!Bar](../img/NFTCosmetics/bar.png){: .center loading="lazy" }

![!Progress Bar](../img/NFTCosmetics/progress_bar.png){: .center loading="lazy" }

## Create NFTRandomCosmeticClient Script

Create a new script called `NFTRandomCosmeticClient` and place it into a Client Context. This script will update the progress bar when the NFTs are loading, and send off a broadcast to the server when the player enters the trigger so a random cosmetic is attached to them.

The script will need some custom properties set.

1. Add the **Trigger** as a custom property called `Trigger`.
2. Add the **Loading** group that holds all the text letters and the progress bar as a custom property called `Loading`.
3. Add the **Cosmetic Tokens** data table as a custom property called `CosmeticTokens`.
4. Add the **Progress Bar** as a custom property called `ProgressBar`.

![!Client](../img/NFTCosmetics/client_script.png){: .center loading="lazy" }

### Create Variables

Add the following variables so you have references to the custom properties. The `tokens` variable will hold the loaded tokens so we can access how many have loaded, and if needed do more with this later as the tokens will be cached into the table.

```lua
local COSMETIC_TOKENS = require(script:GetCustomProperty("CosmeticTokens"))

local TRIGGER = script:GetCustomProperty("Trigger"):WaitForObject()
local LOADING = script:GetCustomProperty("Loading"):WaitForObject()
local PROGRESS_BAR = script:GetCustomProperty("ProgressBar"):WaitForObject()

local LOCAL_PLAYER = Game.GetLocalPlayer()
local tokens = {}
```

### Rotate Group

Rotating the group that contains the loading letters and progress bar so it faces the player would be nice. We can do this easily with the `LookAtContinuous` function. We pass `true` in as the second argument to lock the pitch.

```lua
LOADING:LookAtContinuous(LOCAL_PLAYER, true)
```

### Create OnTriggerEnter Function

Create a function called `OnTriggerEnter`. When the player enters the trigger, a broadcast to the server will be done that will attach a random cosmetic to the player.

```lua
local function OnTriggerEnter(trigger, other)
    if other == LOCAL_PLAYER then
        Events.BroadcastToServer("Cosmetic.Attach")
    end
end
```

### Fetch NFT Tokens

You need to fetch the NFTs using the Blockchain API. Because all of the NFTs being used are lazily minted, we have to use the contract address from OpenSea which is the same for everyone else who has lazily minted NFTs. It would be recommended to put your NFTs onto the blockchain, but it costs Gas which can be expensive. So this alternative will work for now.

When a token is successfully retrieved, the scale of the `PROGRESS_BAR` is increased based on the total tokens loaded. For each iteration, a wait of 1.6 seconds is done to prevent hitting the rate limits for OpenSea.

```lua
for index, row in ipairs(COSMETIC_TOKENS) do
    local token, success, msg = Blockchain.GetToken("0x495f947276749ce646f68ac8c248420045cb7b5e", tostring(row.TokenID))

    if success == BlockchainTokenResultCode.SUCCESS then
        tokens[#tokens + 1] = token

        local scale = PROGRESS_BAR:GetScale()

        scale.z = (4 / #COSMETIC_TOKENS) * #tokens
        PROGRESS_BAR:SetScale(scale)
    else
        warn(msg)
    end

    Task.Wait(1.6)
end
```

### Clean Up

After the looping of the tokens has finished, you can stop the loading group from rotating, and turn the visibility off. The collision for the `TRIGGER` can be turned on to allow players to enter and get a random cosmetic equipped.

```lua
LOADING:StopRotate()
LOADING.visibility = Visibility.FORCE_OFF
TRIGGER.collision = Collision.FORCE_ON
```

### Connect Trigger Event

Finally, connect up the `TRIGGER` so that the `OnTriggerEnter` function is called when the player enters the trigger.

```lua
TRIGGER.beginOverlapEvent:Connect(OnTriggerEnter)
```

### The NFTRandomCosmeticClient Script

??? "NFTRandomCosmeticClient"
    ```lua
    local COSMETIC_TOKENS = require(script:GetCustomProperty("CosmeticTokens"))

    local TRIGGER = script:GetCustomProperty("Trigger"):WaitForObject()
    local LOADING = script:GetCustomProperty("Loading"):WaitForObject()
    local PROGRESS_BAR = script:GetCustomProperty("ProgressBar"):WaitForObject()

    local LOCAL_PLAYER = Game.GetLocalPlayer()
    local tokens = {}

    LOADING:LookAtContinuous(LOCAL_PLAYER, true)

    local function OnTriggerEnter(trigger, other)
        if other == LOCAL_PLAYER then
            Events.BroadcastToServer("Cosmetic.Attach")
        end
    end

    for index, row in ipairs(COSMETIC_TOKENS) do
        local token, success, msg = Blockchain.GetToken("0x495f947276749ce646f68ac8c248420045cb7b5e", tostring(row.TokenID))

        if success == BlockchainTokenResultCode.SUCCESS then
            tokens[#tokens + 1] = token

            local scale = PROGRESS_BAR:GetScale()

            scale.z = (4 / #COSMETIC_TOKENS) * #tokens
            PROGRESS_BAR:SetScale(scale)
        else
            warn(msg)
        end

        Task.Wait(1.6)
    end

    LOADING:StopRotate()
    LOADING.visibility = Visibility.FORCE_OFF
    TRIGGER.collision = Collision.FORCE_ON

    TRIGGER.beginOverlapEvent:Connect(OnTriggerEnter)
    ```

## Create NFTRandomCosmeticServer Script

Create a new script called `NFTRandomCosmeticServer` script and place it into a Server Context. This script will handle attaching a cosmetic to the player when they enter the trigger.

The script will need the 2 data tables added as custom properties.

1. Add the **Cosmetics** data table as a custom property called `Cosmetics`.
2. Add the **Cosmetic Tokens** data table as a custom property called `CosmeticTokens`.

![!Server](../img/NFTCosmetics/server.png){: .center loading="lazy" }

### Create Variables

Add the following variables so you have references to the custom properties. The `tokens` variable will hold the loaded tokens so they are only loaded once. The `players` table will keep track of what cosmetic players have equipped so it can be removed when switched or when they leave the game.

```lua
local COSMETICS = require(script:GetCustomProperty("Cosmetics"))
local COSMETIC_TOKENS = require(script:GetCustomProperty("CosmeticTokens"))

local players = {}
local tokens = {}
```

### Create AttachCosmetic Function

Create a function called `AttachCosmetic`. This function will attach a random cosmetic to the player's head. It will destroy an existing cosmetic if one is already attached by looking at the `players` table.

A random token is picked from the `tokens` table. Each token has 2 attributes. One for the color of the box, and one for the box template that the NFT uses. The first child of the item that is spawned has the color set.

The item is then attached to the player's head socket by using the `AttachToPlayer` function.

```lua
local function AttachCosmetic(player)
    if players[player] then
        players[player]:Destroy()
    end

    local token = tokens[math.random(#tokens)]

    local color = { CoreString.Split(token:GetAttribute("Color"):GetValue(), ", ") }
    local item = World.SpawnAsset(COSMETICS[tonumber(token:GetAttribute("Box"):GetValue())].Template, { networkContext = NetworkContextType.NETWORKED })

    item:GetChildren()[1]:SetColor(Color.New(color[1], color[2], color[3], 1))
    item:AttachToPlayer(player, "head")
    players[player] = item
end
```

### Create OnPlayerLeft Function

Create a function called `OnPlayerLef`. This function will clean up the cosmetic a player may have equipped by looking at the `players` table. If an entry for that player who is leaving the game exist, then the object is destroyed.

```lua
local function OnPlayerLeft(player)
    if players[player] then
        players[player]:Destroy()
        players[player] = nil
    end
end
```

### Fetch NFTs

Loop through the cosmetic tokens and load each token. Each token is put into the `tokens` table for later use so you don't need to load them each time. The contract address that is passed to `GetToken` is where the tokens are stored. Because they are lazily minted tokens on OpenSea, the this address will be the same for others, so we need to grab the token by passing in the token id as well.

```lua
for index, row in ipairs(COSMETIC_TOKENS) do
    local token, success, msg = Blockchain.GetToken("0x495f947276749ce646f68ac8c248420045cb7b5e", tostring(row.TokenID))

    if success == BlockchainTokenResultCode.SUCCESS then
        tokens[#tokens + 1] = token
    end

    Task.Wait(1.6)
end
```

### Connect Events

Connect up the events so that when the trigger event is fired, it tells the server to attach a cosmetic to the player who entered the trigger.

```lua
Events.ConnectForPlayer("Cosmetic.Attach", AttachCosmetic)
Game.playerLeftEvent:Connect(OnPlayerLeft)
```

### The NFTRandomCosmeticServer Script

??? "NFTRandomCosmeticServer"
    ```lua
    local COSMETICS = require(script:GetCustomProperty("Cosmetics"))
    local COSMETIC_TOKENS = require(script:GetCustomProperty("CosmeticTokens"))

    local players = {}
    local tokens = {}

    local function AttachCosmetic(player)
        if players[player] then
            players[player]:Destroy()
        end

        local token = tokens[math.random(#tokens)]

        local color = { CoreString.Split(token:GetAttribute("Color"):GetValue(), ", ") }
        local item = World.SpawnAsset(COSMETICS[tonumber(token:GetAttribute("Box"):GetValue())].Template, { networkContext = NetworkContextType.NETWORKED })


        item:GetChildren()[1]:SetColor(Color.New(color[1], color[2], color[3], 1))
        item:AttachToPlayer(player, "head")
        players[player] = item
    end

    local function OnPlayerLeft(player)
        if players[player] then
            players[player]:Destroy()
            players[player] = nil
        end
    end

    for index, row in ipairs(COSMETIC_TOKENS) do
        local token, success, msg = Blockchain.GetToken("0x495f947276749ce646f68ac8c248420045cb7b5e", tostring(row.TokenID))

        if success == BlockchainTokenResultCode.SUCCESS then
            tokens[#tokens + 1] = token
        end

        Task.Wait(1.6)
    end

    Events.ConnectForPlayer("Cosmetic.Attach", AttachCosmetic)
    Game.playerLeftEvent:Connect(OnPlayerLeft)
    ```

## Test the Game

Test the game to make sure the NFTs are loaded. The progress bar will grow as each NFT is loaded. Once all the NFTs have loaded, the player can enter the trigger to equip a random cosmetic.

<div class="mt-video" style="width:100%">
    <video autoplay muted playsinline controls loop class="center" style="width:100%">
        <source src="/img/NFTCosmetics/finished.mp4" type="video/mp4" />
    </video>
</div>

## Learn More

[Blockchain API](../api/blockchain.md) | [NFT Slideshow Tutorial](../tutorials/slideshow.md) | [NFT Inventory Loot Tutorial](../tutorials/nft_inventory_loot.md)
