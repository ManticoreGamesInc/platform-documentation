---
id: nft_inventory_loot
name: NFT Inventory Loot
title: NFT Inventory Loot
tags:
    - Tutorial
---

# NFT Inventory Loot

<div class="mt-video" style="width:100%">
    <video autoplay muted playsinline controls loop class="center" style="width:100%">
        <source src="/img/NFTInventoryLootTutorial/preview.mp4" type="video/mp4" />
    </video>
</div>

## Overview

In this tutorial, you will learn how NFTs (Non-fungible Tokens) can be used as the loot that can be added to an inventory. You will learn how to read a player's wallet and a collection of your choice to build up a list of loot that will be compared against an inventory asset data table.

* **Completion Time:** ~30 minutes
* **Knowledge Level:** It is recommended to have completed the [Creating Inventories](../tutorials/creating_inventories.md) tutorial.
* **Skills you will learn:**
    * Reading a player's wallet using the Blockchain API.
    * Reading a collection using the Blockchain API.
    * Adding items to the player's inventory.

## Find Contract Address

You can find a contract address by accessing one of the NFTs in the collection you want to pull from. On [OpenSea](https://opensea.io) when viewing an item in a collection, the URL will show some information that is useful to know and use.

For example, take `Bag #6167` from the Loot collection. The URL contains the blockchain the token is on, the contract address, and the token ID.

`https://opensea.io/assets/ethereum/0xff9c1b15b16263c61d017ee9f65c50e4ae0113d7/6167`

This information can also be found in the **Details** section of the token page.

![!Info](../img/NFTInventoryLootTutorial/info.png){: .center loading="lazy" }

## Build Loot List

A loot list will be built in Lua that contains the items from the player's wallet and a collection. There are a few ways this can be done, but for simplicity, you will fetch one page of results from the player's wallet and one page of results from a collection.

The reason for the collection is if the player does not own any NFTs. Adding a page from the collection will make sure the player has a chance to receive something from the loot list.

### Create GivePlayerLootServer Script

Create a new script called `GivePlayerLootServer` and place it into the **Hierarchy**. This script will be responsible for fetching the NFTs from the player's wallet, and NFTs from a collection you can specify.

![!Script](../img/NFTInventoryLootTutorial/script.png){: .center loading="lazy" }

#### Add Variables

Add the following variables to the script. The `collectionTokens` table will hold all the tokens that were fetched from the collection. The tokens will be cached to this table to prevent fetching them again when another player joins the game. The `fetching` boolean will be set to true when the tokens for the collection are being fetched.

Set the `contractAddress` to either your own or from a collection online for testing.

```lua
local contractAddress = "" -- Your collection contract address to pull from.
local collectionTokens = {}
local fetching = false
```

#### Create FetchCollectionTokens Function

Create a function called `FetchCollectionTokens`. This function will fetch one page of tokens from the collection. Using [`GetTokens`](../api/blockchain.md) requires the `contractAddress` to be passed as the first argument.

Using [`GetResults`](../api/blockchaintokencollection.md) on the `tokens` will return a table of tokens from the contract address that can then be used.

!!! tip "When calling `GetTokens`, script execution will be halted while the tokens are being fetched."

```lua
local function FetchCollectionTokens()
    fetching = true

    local tokens = Blockchain.GetTokens(contractAddress)

    collectionTokens = tokens:GetResults()
    fetching = false
end
```

#### Create GivePlayerLoot Function

Create a function called `GivePlayerLoot`. This function will give the player a random item from the `lootList` that is passed in. If the `lootList` length is `0`, the function will return.

To give a random item to the player, `math.random` can be used by passing the total number of items in the `lootList` table as the argument. It will return a number between 1 and the total number of items in the `lootList` table. For example, if the number was `5`, then the `item` variable will hold a reference to entry 5 in the `lootList` table.

To show what loot the player could receive, it is printed out to the **Event log**.

```lua
function GivePlayerLoot(player, lootList)
    if #lootList == 0 then
        return
    end

    local item = lootList[math.random(#lootList)]

    print("Receiving loot item:", item.name)
end
```

#### Create OnPlayerJoined Function

Create a function called `OnPlayerJoined`. This function will check to see if there are any tokens in the `collectionTokens` table. If there are none, and the server is currently not in the process of fetching them, it will call `FetchCollectionTokens`. While the tokens are being fetched, the function will be halted until `fetching` is false.

The next step is to create a player `lootList` for the player's owned tokens. This can be done using the `GetWalletsForPlayer` and passing the player as the first argument. Once we have the players wallets, we get get the first page of results from each wallet and add each token to the `lootList` table.

Because the tokens need to be part of a single list, the items from the `collectionTokens` can be added to the `lootList`. This will be done for each player that joins the game, they get the collection tokens and their tokens if they own any.

Finally, the `GivePlayerLoot` function is called by passing the `player` and `lootList` as arguments.

```lua
    local function OnPlayerJoined(player)
        if #collectionTokens == 0 and not fetching then
            FetchCollectionTokens()
        end

        while fetching do
            Task.Wait()
        end

        local lootList = {}
        local wallets_result, wallets_status, wallets_err = Blockchain.GetWalletsForPlayer(player)

        if wallets_status == BlockchainTokenResultCode.SUCCESS then
            local wallets = wallets_result:GetResults()

            for wallet_index, wallet in ipairs(wallets) do
                print("Fetched player wallet:", wallet.address)

                local tokens_result, tokens_status, tokens_err = Blockchain.GetTokensForOwner(wallet.address)

                if tokens_status == BlockchainTokenResultCode.SUCCESS then
                    local tokens = tokens_result:GetResults()

                    for token_index, token in ipairs(tokens) do
                        lootList[#lootList + 1] = token
                    end
                end

                print("---------")
            end
        end

        for index, token in ipairs(collectionTokens) do
            lootList[#lootList + 1] = token
        end

        GivePlayerLoot(player, lootList)
    end
```

#### Connect playerJoinedEvent

Connect the `OnPlayerJoined` so that it is called each time a player joins the game, which will print out the loot the player would receive.

```lua
Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

#### The GivePlayerLootServer Script

??? "GivePlayerLootServer"
    ```lua
    local contractAddress = "" -- Your collection address to pull from.
    local collectionTokens = {}
    local fetching = false

    local function FetchCollectionTokens()
        fetching = true

        local tokens = Blockchain.GetTokens(contractAddress)

        collectionTokens = tokens:GetResults()
        fetching = false
    end

    function GivePlayerLoot(player, lootList)
        if #lootList == 0 then
            return
        end

        local item = lootList[math.random(#lootList)]

        print("Receiving loot item:", item.name)
    end

    local function OnPlayerJoined(player)
        if #collectionTokens == 0 and not fetching then
            FetchCollectionTokens()
        end

        while fetching do
            Task.Wait()
        end

        local lootList = {}
        local wallets_result, wallets_status, wallets_err = Blockchain.GetWalletsForPlayer(player)

        if wallets_status == BlockchainTokenResultCode.SUCCESS then
            local wallets = wallets_result:GetResults()

            for wallet_index, wallet in ipairs(wallets) do
                print("Fetched player wallet:", wallet.address)

                local tokens_result, tokens_status, tokens_err = Blockchain.GetTokensForOwner(wallet.address)

                if tokens_status == BlockchainTokenResultCode.SUCCESS then
                    local tokens = tokens_result:GetResults()

                    for token_index, token in ipairs(tokens) do
                        lootList[#lootList + 1] = token
                    end
                end

                print("---------")
            end
        end

        for index, token in ipairs(collectionTokens) do
            lootList[#lootList + 1] = token
        end

        GivePlayerLoot(player, lootList)
    end

    Game.playerJoinedEvent:Connect(OnPlayerJoined)
    ```

## Add Items to Inventory

Now that you know how to generate loot from the player's wallet or a collection, it would be useful to know how to connect the token to an inventory item. This will put the random loot into the player's inventory if there is space.

If you have finished the [Creating Inventories](../tutorials/creating_inventories.md) tutorial, then you can use the inventory created from that tutorial for the second part of this tutorial. If you are using a different inventory, then some extra work on your part may be needed.

### Connect Tokens to Inventory Items

When a random token is selected from the `lootList`, it needs to be verified that an item in the **Inventory Assets** is assigned to it.

#### Modify Inventory Assets Data Table

The **Inventory Assets** table will need a new column that contains the name of the token to match against.

1. Open up the **Inventory Assets** data table from **Project Content**.
2. Add a new column called `loot_name` which is a type of **string**.

![!Data Table](../img/NFTInventoryLootTutorial/data_table.png){: .center loading="lazy" }

#### Add Loot Names to Rows

The next step is to link a token to the inventory item in the data table. Enter the name of the token as it appears in the collection. This will be compared against when the player joins the game. If there is a match in the data table, the player will receive that inventory item in their inventory.

In the image below, the **loot_name** column is filled for each row with the name of the token as it appears in the collection.

![!Loot Name](../img/NFTInventoryLootTutorial/loot_name.png){: .center loading="lazy" }

### Update GivePlayerLootServer Script

The **GivePlayerLootServer** script needs to know about the **Inventory** API, so it can add an item to the player's inventory if there is a match.

In **My Scripts** in **Project Content**, find the **InventoryAPI** script and add it as a custom property to the **GivePlayerLootServer** script in the **Hierarchy**. Name the custom property `InventoryAPI`.

![!Property](../img/NFTInventoryLootTutorial/property.png){: .center loading="lazy" }

#### Require the Inventory API

To use the Inventory API it will need to be required into the **GivePlayerLootServer** script first.

```lua
local INVENTORY_API = require(script:GetCustomProperty("InventoryAPI"))
```

#### Modify GivePlayerLoot Function

The `GivePlayerLoot` function needs to be modified to call a new function that will be added to the **InventoryAPI** script shortly.

A call to `INVENTORY_API.AddLootItem` will attempt to add the item to the player's inventory.

```lua
function GivePlayerLoot(player, lootList)
    if #lootList == 0 then
        return
    end

    local item = lootList[math.random(#lootList)]

    print(item.name)

    INVENTORY_API.AddLootItem(player, item)
end
```

#### The GivePlayerLootServer Script

??? "GivePlayerLootServer"
    ```lua
    local INVENTORY_API = require(script:GetCustomProperty("InventoryAPI"))

    local contractAddress = "" -- Your collection address to pull from.
    local collectionTokens = {}
    local fetching = false

    local function FetchCollectionTokens()
        fetching = true

        local tokens = Blockchain.GetTokens(contractAddress)

        collectionTokens = tokens:GetResults()
        fetching = false
    end

    function GivePlayerLoot(player, lootList)
        if #lootList == 0 then
            return
        end

        local item = lootList[math.random(#lootList)]

        print(item.name)

        INVENTORY_API.AddLootItem(player, item)
    end

    local function OnPlayerJoined(player)
        if #collectionTokens == 0 and not fetching then
            FetchCollectionTokens()
        end

        while fetching do
            Task.Wait()
        end

        local lootList = {}
        local wallets_result, wallets_status, wallets_err = Blockchain.GetWalletsForPlayer(player)

        if wallets_status == BlockchainTokenResultCode.SUCCESS then
            local wallets = wallets_result:GetResults()

            for wallet_index, wallet in ipairs(wallets) do
                print("Fetched player wallet:", wallet.address)

                local tokens_result, tokens_status, tokens_err = Blockchain.GetTokensForOwner(wallet.address)

                if tokens_status == BlockchainTokenResultCode.SUCCESS then
                    local tokens = tokens_result:GetResults()

                    for token_index, token in ipairs(tokens) do
                        lootList[#lootList + 1] = token
                    end
                end

                print("---------")
            end
        end

        for index, token in ipairs(collectionTokens) do
            lootList[#lootList + 1] = token
        end

        GivePlayerLoot(player, lootList)
    end

    Game.playerJoinedEvent:Connect(OnPlayerJoined)
    ```

### Modify InventoryAPI Script

The **InventoryAPI** script needs to be modified. It will need a new function added that will fetch the current player's inventory and try to add the loot item passed into the function.

#### Add API.AddLootItem Function

Add a new function called `API.AddLootItem`. This function will check the player has an inventory and that the token passed in is not `nil`. It will then search through the `ASSETS` table to find an inventory item that matches the name of the token. If an item is found, then it will try to add the item to the player's inventory.

```lua
function API.AddLootItem(player, token)
    if API.PLAYERS[player.id] ~= nil and token == nil then
        return
    end

    local asset = nil
    local inventory = API.PLAYERS[player.id]

    for index, row in ipairs(ASSETS) do
        if row.loot_name == token.name then
            asset = row.asset
            break
        end
    end


    if asset ~= nil and inventory:CanAddItem(asset) then
        inventory:AddItem(asset)
    end
end
```

#### The InventoryAPI Script

??? "InventoryAPI"
    ```lua
    local ASSETS = require(script:GetCustomProperty("InventoryAssets"))
    local INVENTORY = script:GetCustomProperty("Inventory")

    local API = {}

    API.PLAYERS = {}
    API.INVENTORIES = {}
    API.ACTIVE = {

        slot = nil,
        slotIcon = nil,
        slotCount = nil,
        slotIndex = nil,
        inventory = nil,
        hasItem = false

    }

    -- Server

    function API.RegisterInventory(inventory)
        API.INVENTORIES[inventory.id] = inventory
    end

    function API.CreatePlayerInventory(player)
        local inventory = World.SpawnAsset(INVENTORY, { networkContext = NetworkContextType.NETWORKED })

        inventory:Assign(player)
        inventory.name = player.name

        API.PLAYERS[player.id] = inventory
        API.RegisterInventory(inventory)
    end

    function API.LoadPlayerInventory(player)
        local data = Storage.GetPlayerData(player)

        if data.inv ~= nil then
            for i, entry in ipairs(data.inv) do
                local item = API.FindLookupItemByKey(entry[1])

                if item ~= nil and API.PLAYERS[player.id]:CanAddItem(item.asset, { count = entry[2], slot = i }) then
                    API.PLAYERS[player.id]:AddItem(item.asset, { count = entry[2], slot = i })
                end
            end
        end
    end

    function API.SavePlayerInventory(player)
        local data = Storage.GetPlayerData(player)

        data.inv = {}

        for i = 1, API.PLAYERS[player.id].slotCount do
            local item = API.PLAYERS[player.id]:GetItem(i)
            local entry = {}

            if item then
                local lookupItem = API.FindLookupItemByAssetId(item)

                if lookupItem ~= nil then
                    entry = { lookupItem.key, item.count }
                end
            end

            table.insert(data.inv, entry)
        end

        Storage.SetPlayerData(player, data)
    end

    function API.RemovePlayerInventory(player)
        API.INVENTORIES[API.PLAYERS[player.id].id] = nil
        API.PLAYERS[player.id]:Destroy()
        API.PLAYERS[player.id] = nil
    end

    function API.MoveItemHandler(fromInventoryId, toInventoryId, fromSlotIndex, toSlotIndex)
        local fromInventory = API.INVENTORIES[fromInventoryId]
        local toInventory = API.INVENTORIES[toInventoryId]

        if fromInventory ~= nil and toInventory ~= nil then
            if fromInventory == toInventory then
                if fromInventory:CanMoveFromSlot(fromSlotIndex, toSlotIndex) then
                    fromInventory:MoveFromSlot(fromSlotIndex, toSlotIndex)
                end
            else
                local fromItem = fromInventory:GetItem(fromSlotIndex)
                local toItem = toInventory:GetItem(toSlotIndex)

                local fromItemAssetId = fromItem.itemAssetId
                local fromItemCount = fromItem.count

                if toItem ~= nil then
                    local toItemAssetId = toItem.itemAssetId
                    local toItemCount = toItem.count
                    local skipFromItem = false

                    if toItemAssetId == fromItemAssetId then
                        local total = toItemCount + fromItemCount

                        if total > toItem.maximumStackCount then
                            if toItemCount == toItem.maximumStackCount then
                                toItemCount = toItem.maximumStackCount
                                fromItemCount = total - toItem.maximumStackCount
                            else
                                toItemCount = total - toItem.maximumStackCount
                                fromItemCount = toItem.maximumStackCount
                            end
                        else
                            skipFromItem = true
                            fromItemCount = total
                        end
                    end

                    fromInventory:RemoveFromSlot(fromSlotIndex)
                    toInventory:RemoveFromSlot(toSlotIndex)

                    if not skipFromItem then
                        fromInventory:AddItem(toItemAssetId, { count = toItemCount, slot = fromSlotIndex })
                    end
                else
                    fromInventory:RemoveFromSlot(fromSlotIndex)
                end

                toInventory:AddItem(fromItemAssetId, { count = fromItemCount, slot = toSlotIndex })
            end
        end
    end

    function API.RemoveItemHandler(inventoryId, slotIndex)
        local inventory = API.INVENTORIES[inventoryId]

        if inventory ~= nil then
            if inventory:CanRemoveFromSlot(slotIndex) then
                inventory:RemoveFromSlot(slotIndex)
            end
        end
    end

    function API.AddLootItem(player, token)
        if API.PLAYERS[player.id] ~= nil and token == nil then
            return
        end

        local asset = nil
        local inventory = API.PLAYERS[player.id]

        for index, row in ipairs(ASSETS) do
            if row.loot_name == token.name then
                asset = row.asset
                break
            end
        end


        if asset ~= nil and inventory:CanAddItem(asset) then
            inventory:AddItem(asset)
        end
    end

    -- Client

    function API.ClearDraggedItem()
        API.ACTIVE.slot = nil
        API.ACTIVE.slotIcon = nil
        API.ACTIVE.slotCount = nil
        API.ACTIVE.slotIndex = nil
        API.ACTIVE.inventory = nil
        API.ACTIVE.hasItem = false
    end

    function API.SetDragProxy(proxy)
        API.PROXY = proxy
        API.PROXY_ICON = proxy:FindChildByName("Icon")
        API.PROXY_COUNT = API.PROXY_ICON:FindChildByName("Count")
    end

    function API.EnableCursor()
        UI.SetCanCursorInteractWithUI(true)
        UI.SetCursorVisible(true)
    end

    function API.DisableCursor()
        UI.SetCanCursorInteractWithUI(false)
        UI.SetCursorVisible(false)
    end

    function API.OnSlotPressedEvent(button, inventory, slot, slotIndex)
        local icon = slot:FindChildByName("Icon")
        local isHidden = icon.visibility == Visibility.FORCE_OFF and true or false
        local count = icon:FindChildByName("Count")

        -- Has item already.
        if API.ACTIVE.hasItem then

            -- No icon, so this is an empty slot, and dropping it into it.
            if isHidden then
                icon.visibility = Visibility.FORCE_ON
                icon:SetImage(API.PROXY_ICON:GetImage())
                API.ACTIVE.slot.opacity = 1
                API.ACTIVE.slotIcon.visibility = Visibility.FORCE_OFF
                count.text = API.ACTIVE.slotCount.text
                API.ACTIVE.slotCount.text = "0"

            -- Slot contains existing item
            else
                local item = API.ACTIVE.inventory:GetItem(API.ACTIVE.slotIndex)
                local toItem = inventory:GetItem(slotIndex)

                if(item ~= nil and toItem ~= nil and item.itemAssetId == toItem.itemAssetId and toItem.count == toItem.maximumStackCount) then
                    API.ACTIVE.slot.opacity = 1
                else
                    local tmpImg = icon:GetImage()
                    local tmpCount = count.text

                    icon:SetImage(API.ACTIVE.slotIcon:GetImage())
                    count.text = API.ACTIVE.slotCount.text
                    API.ACTIVE.slotIcon:SetImage(tmpImg)
                    API.ACTIVE.slotCount.text = tmpCount
                    API.ACTIVE.slot.opacity = 1

                    tmpCount = nil
                    tmpImg = nil
                end
            end

            Events.BroadcastToServer("inventory.moveitem", API.ACTIVE.inventory.id, inventory.id, API.ACTIVE.slotIndex, slotIndex)

            API.ClearDraggedItem()
            API.PROXY.visibility = Visibility.FORCE_OFF

        -- No item, pick up from clicked slot.
        elseif not isHidden then
            API.PROXY.visibility = Visibility.FORCE_ON
            API.ACTIVE.hasItem = true
            API.PROXY_ICON:SetImage(icon:GetImage())
            API.PROXY_COUNT.text = tostring(inventory:GetItem(slotIndex).count)
            slot.opacity = .6
            API.ACTIVE.slot = slot
            API.ACTIVE.slotIcon = icon
            API.ACTIVE.slotCount = count
            API.ACTIVE.slotIndex = slotIndex
            API.ACTIVE.inventory = inventory
        end
    end

    -- Shared

    function API.FindLookupItemByKey(key)
        for i, dataItem in pairs(ASSETS) do
            if key == dataItem.key then
                return dataItem
            end
        end
    end

    function API.FindLookupItemByAssetId(item)
        for i, dataItem in pairs(ASSETS) do
            local id = CoreString.Split(dataItem.asset, ":")

            if id == item.itemAssetId then
                return dataItem
            end
        end
    end

    function API.RemoveItemSlotPressed()
        if API.ACTIVE.hasItem and API.ACTIVE.inventory ~= nil then
            Events.BroadcastToServer("inventory.removeitem", API.ACTIVE.inventory.id, API.ACTIVE.slotIndex)
            API.ACTIVE.slot.opacity = 1
            API.ACTIVE.slotIcon.visibility = Visibility.FORCE_OFF
            API.ClearDraggedItem()
            API.PROXY.visibility = Visibility.FORCE_OFF
        end
    end

    -- Events

    if Environment.IsServer() then
        Events.Connect("inventory.moveitem", API.MoveItemHandler)
        Events.Connect("inventory.removeitem", API.RemoveItemHandler)
    end

    return API
    ```

### Test the Game

Test the game to see if a random item is added to the inventory. This could take quite a few tries depending on how many items are in the wallet and collection. The more items in the inventory asset table that are linked to a token, the more chance an item will be added to the inventory.

<div class="mt-video" style="width:100%">
    <video autoplay muted playsinline controls loop class="center" style="width:100%">
        <source src="/img/NFTInventoryLootTutorial/preview.mp4" type="video/mp4" />
    </video>
</div>

## Summary

The [Blockchain API](../api/blockchain.md) opens up new ideas for how your game can be played, and how players are rewarded. This tutorial shows you how easy it is to reward players with items from their Wallet. This could also be your own generated NFTs that players can purchase from your collection.

## Learn More

[Blockchain API](../api/blockchain.md) | [Inventories Reference](../references/inventory.md) | [Creating Inventories Tutorial](../tutorials/creating_inventories.md) | [Inventory API](../api/inventory.md)
