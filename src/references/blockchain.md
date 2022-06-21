---
id: blockchain_reference
name: Blockchain
title: Blockchain
tags:
  - Reference
---

# Blockchain

## Overview

The [Blockchain API](../api/blockchain.md) in Core provides creators with methods to retrieve information about contracts, NFTs (Non-Fungible Tokens), and collections that can be used inside their game. This gives creators the ability to create new experiences for the players using NFTs.

## What can Creators do with the Blockchain API?

The Blockchain API allows creators to use NFTs in any way they wish. NFT in-game items combine aspects of utility and collectability for players. Below are some example use cases that could be done using the Blockchain API.

### Gallery

Artists that have published their own NFTs can display them inside of Core to create a virtual gallery of the items. Data about those items can be displayed to players, and who owns them.

### Loot Drops

Imagine players who own specific NFTs that give them a daily chance of a loot drop. This is a great way to reward players who own specific NFTs and can change the way a game is played depending on the loot being dropped.

### Membership

NFTs provide a great way to prove membership. By owning a membership NFT, players in the game would have access to benefits, for example, increased drops, daily rewards, and access to members-only areas.

### Procedural Content

NFTs can have properties that can be read using the Blockchain API. These are called various things like traits, or attributes. They are used to describe what makes up the item. These NFTs can be used to build up content in-game based on those attributes. For example, building a playable map with resource nodes from an NFT.

### Cosmetics

Cosmetics are very popular in games, and being able to own unique cosmetics is a great way for players to collect them and show off. Imagine cosmetic hats that players wear in-game, but the player owns the item they are wearing because they own the NFT for it. They would be the only player to own that hat because it is one of a kind. It is unique. The only way other players could own the hat would be to purchase it from the player who currently owns it.

## What is an NFT?

[NFTs](https://en.wikipedia.org/wiki/NFT) are unique blockchain tokens that are used to represent ownership of items and can only have one owner at a time. These items are digital assets listed on a decentralized platform called the **Blockchain**, and typically contain references to photos, audio, video, and text.

**Non-Fungible** means the item is not interchangeable with other items because they have unique properties. Whereas **Fungible** items can be exchanged because their value defines them rather than their unique properties. For example, $1 is exchangeable for another $1.

## What is a Blockchain?

A [blockchain](https://en.wikipedia.org/wiki/Blockchain) is a digital ledger of transactions maintained by a network of computers in a way that makes it difficult to hack or change. The technology offers a secure way for individuals to deal directly with each other, without an intermediary like a government, bank, or other third parties.

The growing list of records, called blocks, is linked together using cryptography. Each transaction is independently verified by peer-to-peer computer networks, time-stamped, and added to a growing chain of data. Once recorded, the data cannot be altered.

## What does Decentralized mean?

Most blockchains are decentralized, meaning it is maintained across many computers that are linked in a peer-to-peer network. With it being a decentralized system, it makes the information difficult or impossible to change. Whereas if the blockchain was centralized, then there is the central authority that governs and handles the network.

## What is a Wallet?

A [cryptocurrency wallet](https://en.wikipedia.org/wiki/Cryptocurrency_wallet) is a device, physical medium, program, or service which stores the public and/or private keys for cryptocurrency transactions. In addition to this basic function of storing the keys, a cryptocurrency wallet more often also offers the functionality of encrypting and/or signing information. Signing can for example result in executing a smart contract, a cryptocurrency transaction, identification, or legally signing a 'document'.

For creators to be able to fetch a player's owned NFTs, that player will need to link their wallet to their Core account on the [Link Accounts](https://www.coregames.com/settings/connections) page. The wallet supported is [MetaMask](https://metamask.io/).

MetaMask is a software cryptocurrency wallet used to interact with the Ethereum blockchain. It allows users to access their Ethereum wallet through a browser extension or mobile app, which can then be used to interact with decentralized applications.

## Using the Blockchain API

The Blockchain API provides various ways for creators to retrieve information about NFTs, contracts, and collections. For example, if creators want to retrieve the NFTs owned by the player to create a different experience based on that player's owned NFTs, then this can easily be done using the API.

### Fetching Player Owned NFTs

Below is an example of how easy it is to retrieve some of a player's tokens. The `GetTokensForPlayer` function requires the player to be passed in. It will then request one page of results and return them as an array. When a request is made, the script will yield until it has finished.

```lua
local tokens = Blockchain.GetTokensForPlayer(player)
local results = tokens:GetResults()

for index, token in ipairs(results) do
    print(token.name)
end
```

### Fetching a Collection of NFTs

A collection of NFTs could be a collection that creators have listed on the [OpenSea](https://opensea.io) marketplace themselves. For example, they could be collectibles that players can collect, and those that own them can display them in the game to other players.

Fetching a collection is very easy. Using the `GetTokens` function and passing in the contract address for the collection will return the first page of results. More results can be fetched using the API.

In the example below, a list of tokens from the [MekaVerse](https://opensea.io/collection/mekaverse) collection is used.

```lua
local tokens = Blockchain.GetTokens("0x9a534628b4062e123ce7ee2222ec20b86e16ca8f")
local results = tokens:GetResults()

for index, token in ipairs(results) do
    print(token.name)
end
```

## Learn More

[Blockchain API](../api/blockchain.md) | [NFT Inventory Loot Tutorial](../tutorials/nft_inventory_loot.md) | [NFT Slideshow Tutorial](../tutorials/slideshow.md) | [OpenSea](https://opensea.io)
