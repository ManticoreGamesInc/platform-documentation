---
id: blockchain
name: Blockchain
title: Blockchain
tags:
    - API
    - Blockchain
---

# Blockchain

Blockchain is a collection of functions for looking up blockchain tokens, collections, and contracts.

## Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `Blockchain.GetToken(string contractAddress, string tokenId)` | <[`BlockchainToken`](blockchaintoken.md), [`BlockchainTokenResultCode`](enums.md#blockchaintokenresultcode), `string` error> | Looks up a single blockchain token given its contract address and token ID. This function may yield while fetching token data. May return nil if the requested token does not exist, or if an error occurs while fetching data. The status code in the second return value indicates whether the request succeeded or failed, with an optional error message in the third return value. | None |
| `Blockchain.GetTokensForPlayer(Player player, [table parameters])` | <[`BlockchainTokenCollection`](blockchaintokencollection.md), [`BlockchainTokenResultCode`](enums.md#blockchaintokenresultcode), `string` error> | *This function is deprecated. Please use Blockchain.GetWalletsForPlayer() and Blockchain.GetTokensForOwner() instead.* Searches for blockchain tokens owned by the specified player. This function may yield while fetching token data. May return nil if an error occurs while fetching data. The status code in the second return value indicates whether the request succeeded or failed, with an optional error message in the third return value. <br /> Optional parameters can be provided to filter the results: <br/> `contractAddress (string)`: Only return tokens with the specified contract address. <br/> `tokenIds (string or Array<string>)`: Only return tokens with the specified token IDs. | <abbr title='This API is deprecated and might be removed in a future version.'><strong>Deprecated</strong></abbr> |
| `Blockchain.GetTokensForOwner(string ownerAddress, [table parameters])` | <[`BlockchainTokenCollection`](blockchaintokencollection.md), [`BlockchainTokenResultCode`](enums.md#blockchaintokenresultcode), `string` error> | Searches for blockchain tokens owned by the specified wallet address. This function may yield while fetching token data. May return nil if an error occurs while fetching data. The status code in the second return value indicates whether the request succeeded or failed, with an optional error message in the third return value. <br /> Optional parameters can be provided to filter the results: <br/> `contractAddress (string)`: Only return tokens with the specified contract address. <br/> `tokenIds (string or Array<string>)`: Only return tokens with the specified token IDs. <br/> `openSeaSlug (string)`: Only return tokens with the specified slug. | None |
| `Blockchain.GetTokens(string contractAddress, [table parameters])` | <[`BlockchainTokenCollection`](blockchaintokencollection.md), [`BlockchainTokenResultCode`](enums.md#blockchaintokenresultcode), `string` error> | Searches for blockchain tokens belonging to the specified contract address. This function may yield while fetching token data. May return nil if an error occurs while fetching data. The status code in the second return value indicates whether the request succeeded or failed, with an optional error message in the third return value. <br /> Optional parameters can be provided to filter the results: <br/> `tokenIds (string or Array<string>)`: Only return tokens with the specified token IDs. <br/> `openSeaSlug (string)`: Only return tokens with the specified slug. | None |
| `Blockchain.GetContract(string contractAddress)` | <[`BlockchainContract`](blockchaincontract.md), [`BlockchainTokenResultCode`](enums.md#blockchaintokenresultcode), `string` error> | Looks up a blockchain contract given the contract address. This function may yield while fetching the contract data. May return nil if the requested contract does not exist, or if an error occurs while fetching data. The status code in the second return value indicates whether the request succeeded or failed, with an optional error message in the third return value. | None |
| `Blockchain.GetWalletsForPlayer(Player player)` | <[`BlockchainWalletCollection`](blockchainwalletcollection.md), [`BlockchainWalletResultCode`](enums.md#blockchainwalletresultcode), `string` error> | Looks up a list of blockchain wallets owned by the specified player. This function may yield while fetching wallet data. May return nil if an error occurs while fetching data. The status code in the second return value indicates whether the request succeeded or failed, with an optional error message in the third return value. | None |

## Examples

Example using:

### `GetContract`

MekaVerse is an NFT collection with 8,888 unique mechas. The following example shows how to fetch metadata on the MekaVerse NFT contract. The script sits in the hierarchy as a child of a `UI Text`, which it uses for setting the collection's description.

```lua
-- Address to the smart contract behind the MekaVerse NFT collection
-- https://etherscan.io/address/0x9a534628b4062e123ce7ee2222ec20b86e16ca8f
local UI_TEXT = script.parent
local SMART_CONTRACT_ADDRESS = "0x9a534628b4062e123ce7ee2222ec20b86e16ca8f"

local contract = Blockchain.GetContract(SMART_CONTRACT_ADDRESS)
UI_TEXT.text = contract.description
```

See also: [BlockchainContract.description](blockchaincontract.md) | [CoreObject.parent](coreobject.md) | [UIText.text](uitext.md)

---

Example using:

### `GetToken`

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

See also: [UIImage.SetBlockchainToken](uiimage.md) | [CoreObject.parent](coreobject.md)

---

Example using:

### `GetTokens`

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
local params = {
    tokenIds = tokenIds,
}
local freeChoiceTokens = Blockchain.GetTokens(SMART_CONTRACT_ADDRESS, params)

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

See also: [BlockchainToken.GetAttribute](blockchaintoken.md) | [BlockchainTokenAttribute.GetValue](blockchaintokenattribute.md) | [DateTime.CurrentTime](datetime.md) | [RandomStream.New](randomstream.md)

---
