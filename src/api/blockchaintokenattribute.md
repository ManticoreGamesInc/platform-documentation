---
id: blockchaintokenattribute
name: BlockchainTokenAttribute
title: BlockchainTokenAttribute
tags:
    - API
---

# BlockchainTokenAttribute

A single attribute on a BlockchainToken.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `name` | `string` | The name of the attribute. | Read-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetValue()` | `string` | Returns the attribute's value as a string. | None |

## Examples

Example using:

### `GetValue`

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
for i = 1,FREE_CHOICE_AMOUNT do
    local id = tostring(rng:GetInteger(1, COLLECTION_SIZE))
    table.insert(tokenIds, id)
end

-- Fetch the NFTs
local params = {
    tokenIds = tokenIds
}
local freeChoiceTokens = Blockchain.GetTokens(SMART_CONTRACT_ADDRESS, params)
--[[ Alternate implementation to fetch the NFTs
local freeChoiceTokens = {}
for _, id in ipairs(tokenIds) do
    local token = Blockchain.GetToken(SMART_CONTRACT_ADDRESS, id)
    table.insert(freeChoiceTokens, token)
end
]]

-- Print results. Attributes arrive in random order
print("\nFree choices for today:\n")
for _,token in ipairs(freeChoiceTokens) do
    print("Loot Bag #" .. token.tokenId)

    local allAttributes = token:GetAttributes()
    for k, attribute in pairs(allAttributes) do
        print("  " .. attribute:GetValue())
    end
end

-- Alternate version, with attributes ordered based on original design
local sortedAttributeNames = {
    "weapon", "chest", "head", "waist", "foot", "hand", "neck", "ring"
}
print("\n(v2) Free choices for today:\n")
for _,token in ipairs(freeChoiceTokens) do
    print("Loot Bag #" .. token.tokenId)

    for _, attributeName in pairs(sortedAttributeNames) do
        local attribute = token:GetAttribute(attributeName)
        print("  " .. attribute:GetValue())
    end
end
```

See also: [BlockchainToken.GetAttribute](blockchaintoken.md) | [Blockchain.GetTokens](blockchain.md) | [DateTime.CurrentTime](datetime.md) | [RandomStream.New](randomstream.md)

---

## Learn More

[BlockchainToken:GetAttributes()](blockchaintoken.md)
