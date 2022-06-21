---
id: blockchaintokencollection
name: BlockchainTokenCollection
title: BlockchainTokenCollection
tags:
    - API
    - Blockchain
---

# BlockchainTokenCollection

Contains a set of results from [Blockchain.GetTokens()](blockchain.md) and related functions. Depending on how many tokens are available, results may be separated into multiple pages. The `.hasMoreResults` property may be checked to determine whether more tokens are available. Those results may be retrieved using the `:GetMoreResults()` function.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `hasMoreResults` | `boolean` | Returns `true` if there are more tokens available to be requested. | Read-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetResults()` | `Array`<[`BlockchainToken`](blockchaintoken.md)> | Returns the list of tokens contained in this set of results. This may return an empty table. | None |
| `GetMoreResults()` | `<BlockchainTokenCollection`, [`BlockchainTokenResultCode`](enums.md#blockchaintokenresultcode), `string` error | Requests the next set of results for this list of tokens and returns a new collection containing those results. This function may yield until a result is available. Returns `nil` if the `hasMoreResults` property is `false`, or if an error occurs while fetching data. The status code in the second return value indicates whether the request succeeded or failed, with an optional error message in the third return value. | None |

## Examples

Example using:

### `hasMoreResults`

### `GetResults`

### `GetMoreResults`

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

See also: [Blockchain.GetTokensForPlayer](blockchain.md) | [BlockchainToken.contractAddress](blockchaintoken.md) | [Game.playerJoinedEvent](game.md) | [Player.team](player.md)

---

## Learn More

[Blockchain.GetTokens()](blockchain.md)
