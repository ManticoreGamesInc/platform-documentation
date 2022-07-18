---
id: blockchaintoken
name: BlockchainToken
title: BlockchainToken
tags:
    - API
    - Blockchain
---

# BlockchainToken

Metadata about a token stored on the blockchain.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `contractAddress` | `string` | The address of the contract this token belongs to. | Read-Only |
| `tokenId` | `string` | The ID of this token within its contract. | Read-Only |
| `name` | `string` | The name of the token, if it has one. | Read-Only |
| `description` | `string` | The description of the token, if it has one. | Read-Only |
| `rawMetadata` | `string` | The raw, unprocessed metadata value from the token. This could be anything, including a URL, JSON string, etc. | Read-Only |
| `ownerAddress` | `string` | The wallet address of the token's owner. | Read-Only |
| `creatorAddress` | `string` | The address of the token's creator. | Read-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetContract()` | [`BlockchainContract`](blockchaincontract.md) | Returns the contract this token belongs to. | None |
| `GetAttributes()` | `Array`<[`BlockchainTokenAttribute`](blockchaintokenattribute.md)> | Returns an array of this token's attributes. | None |
| `GetAttribute(string attributeName)` | [`BlockchainTokenAttribute`](blockchaintokenattribute.md) | Returns the attribute with the specified name. Returns nil if this token does not contain the desired attribute. | None |

## Examples

Example using:

### `GetAttribute`

### `GetAttributes`

Loot (for Adventurers) is a collection of 8,000 NFTs representing randomized adventurer gear, generated and stored on the Ethereum blockchain. In this example, we use the data from Loot to select five random loot bags. Players can then choose one of these bags as their items for the play session. By combining RandomStream with DateTime, we can offer the same five bags to all players, for the duration of the day. Also, each day the selection of bags will change at midnight UTC.

```lua
-- Address to the smart contract behind "Loot (for Adventurers)"
-- https://etherscan.io/address/0xff9c1b15b16263c61d017ee9f65c50e4ae0113d7
local SMART_CONTRACT_ADDRESS = "0xff9c1b15b16263c61d017ee9f65c50e4ae0113d7"
local COLLECTION_SIZE = 8000
local FREE_CHOICE_AMOUNT = 5

-- Prepare random number generator. Seed is based on the date
local today = DateTime.CurrentTime()
local rngSeed = today.year * today.month * today.day
local rng = RandomStream.New(rngSeed)

-- Choose random token IDs
local tokenIds = {}
for i = 1, FREE_CHOICE_AMOUNT do
    local id = tostring(rng:GetInteger(1, COLLECTION_SIZE))
    table.insert(tokenIds, id)
end

-- Fetch the NFTs
local freeChoiceTokens = {}
for _, id in ipairs(tokenIds) do
    local token = Blockchain.GetToken(SMART_CONTRACT_ADDRESS, id)
    table.insert(freeChoiceTokens, token)
end

-- Print results. Attributes arrive in random order
print("\nFree choices for today:\n")
for _, token in ipairs(freeChoiceTokens) do
    print("Loot Bag #" .. token.tokenId)

    local allAttributes = token:GetAttributes()
    for k, attribute in pairs(allAttributes) do
        print("  " .. attribute:GetValue())
    end
end

-- Alternate version, with attributes ordered based on original design
local sortedAttributeNames = {
    "weapon",
    "chest",
    "head",
    "waist",
    "foot",
    "hand",
    "neck",
    "ring",
}
print("\n(v2) Free choices for today:\n")
for _, token in ipairs(freeChoiceTokens) do
    print("Loot Bag #" .. token.tokenId)

    for _, attributeName in pairs(sortedAttributeNames) do
        local attribute = token:GetAttribute(attributeName)
        print("  " .. attribute:GetValue())
    end
end
```

See also: [Blockchain.GetTokens](blockchain.md) | [BlockchainTokenAttribute.GetValue](blockchaintokenattribute.md) | [DateTime.CurrentTime](datetime.md) | [RandomStream.New](randomstream.md)

---

Example using:

### `contractAddress`

In this example, we want to differentiate the gameplay experience dependant on the player owning NFTs from a specific collection. If a player owns an NFT they are assigned to team 2, whereas other players are assigned to team 1. This could be used, for example, in conjunction with a collider to create a VIP section on the map, accessible only to holders of the NFT. To demonstrate we use the BAYC contract address. Replace it with the address to any other NFT contract to specify the collection representative of VIP status in your game.

```lua
-- Address to the NFT contract for Bored Ape Yacht Club
-- https://etherscan.io/address/0xbc4ca0eda7647a8ab7c2061c2e118a18a936f13d
local NFT_CONTRACT_ADDRESS = "0xbc4ca0eda7647a8ab7c2061c2e118a18a936f13d"
local HOLDER_TEAM = 2
local NON_HOLDER_TEAM = 1

-- Given a player and an NFT collection, check if the player owns a token
function DoesPlayerOwnFromContract(player, contractAddress)
    local playerCollection = Blockchain.GetTokensForPlayer(player, { contractAddress = contractAddress })
    local tokens = playerCollection:GetResults()

    if #tokens > 0 then
        return true
    end

    return false
end

-- Is the given player considered VIP in our game?
function IsVIP(player)
    return DoesPlayerOwnFromContract(player, NFT_CONTRACT_ADDRESS)
end

-- A player joined. Set their team based on their VIP status
function OnPlayerJoined(player)
    if IsVIP(player) then
        player.team = HOLDER_TEAM
        print(player.name .. " is a holder and VIP member.")
    else
        player.team = NON_HOLDER_TEAM
        print(player.name .. " is not a holder.")
    end
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

See also: [Blockchain.GetTokensForPlayer](blockchain.md) | [BlockchainTokenCollection.GetResults](blockchaintokencollection.md) | [Game.playerJoinedEvent](game.md) | [Player.team](player.md)

---

Example using:

### `contractAddress`

### `creatorAddress`

### `description`

### `name`

### `ownerAddress`

### `rawMetadata`

### `tokenId`

MekaVerse is an NFT collection with 8,888 unique mechas. This example shows how to fetch all token data for Meka #1. Token properties are output to the Event Log.

```lua
-- Address to the NFT #1 in the MekaVerse collection
-- https://opensea.io/assets/ethereum/0x9a534628b4062e123ce7ee2222ec20b86e16ca8f/1
local NFT_CONTRACT_ADDRESS = "0x9a534628b4062e123ce7ee2222ec20b86e16ca8f"
local TOKEN_ID = "1"

local token = Blockchain.GetToken(NFT_CONTRACT_ADDRESS, TOKEN_ID)

print("contractAddress: " .. token.contractAddress)
print("creatorAddress: " .. token.creatorAddress)
print("description: " .. token.description)
print("name: " .. token.name)
print("ownerAddress: " .. token.ownerAddress)
print("rawMetadata: " .. token.rawMetadata)
print("tokenId: " .. token.tokenId)
```

See also: [Blockchain.GetToken](blockchain.md) | [CoreObject.parent](coreobject.md)

---

## Learn More

[Blockchain.GetToken()](blockchain.md)
