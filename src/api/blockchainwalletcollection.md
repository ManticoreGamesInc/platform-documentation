---
id: blockchainwalletcollection
name: BlockchainWalletCollection
title: BlockchainWalletCollection
tags:
    - API
    - Blockchain
---

# BlockchainWalletCollection

Contains a set of results from [Blockchain.GetWalletsForPlayer()](blockchain.md). Depending on how many wallets are available, results may be separated into multiple pages. The `.hasMoreResults` property may be checked to determine whether more wallets are available. Those results may be retrieved using the `:GetMoreResults()` function.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `hasMoreResults` | `boolean` | Returns `true` if there are more wallets available to be requested. | Read-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetResults()` | `Array`<[`BlockchainWallet`](blockchainwallet.md)> | Returns the list of wallets contained in this set of results. This may return an empty table. | None |
| `GetMoreResults()` | `<BlockchainWalletCollection`, [`BlockchainWalletResultCode`](enums.md#blockchainwalletresultcode), `string` error | Requests the next set of results for this list of wallets and returns a new collection containing those results. This function may yield until a result is available. Returns `nil` if the `hasMoreResults` property is `false`, or if an error occurs while fetching data. The status code in the second return value indicates whether the request succeeded or failed, with an optional error message in the third return value. | None |

## Learn More

[Blockchain.GetWalletsForPlayer()](blockchain.md)
