---
id: blockchaincontract
name: BlockchainContract
title: BlockchainContract
tags:
    - API
    - Blockchain
---

# BlockchainContract

Metadata about a smart contract on the blockchain.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `address` | `string` | The address of the contract. | Read-Only |
| `name` | `string` | The name of the contract, if it has one. | Read-Only |
| `description` | `string` | The description of the contract, if it has one. | Read-Only |
| `symbol` | `string` | An abbreviated name for the contract. | Read-Only |
| `count` | `integer` | The number of tokens contained in the contract, if available. | Read-Only |

## Examples

Example using:

### `address`

### `count`

### `description`

### `name`

### `symbol`

MekaVerse is an NFT collection with 8,888 unique mechas. The following example shows how to fetch metadata on the MekaVerse NFT contract. The script sits in the hierarchy as a child of a `UI Text`, which it uses for setting the collection's description. Other contract properties are output to the Event Log.

```lua
-- Address to the smart contract behind the MekaVerse NFT collection
-- https://etherscan.io/address/0x9a534628b4062e123ce7ee2222ec20b86e16ca8f
local UI_TEXT = script.parent
local SMART_CONTRACT_ADDRESS = "0x9a534628b4062e123ce7ee2222ec20b86e16ca8f"

local contract = Blockchain.GetContract(SMART_CONTRACT_ADDRESS)
UI_TEXT.text = contract.description

print("address: " .. contract.address)
print("count: " .. contract.count)
print("name: " .. contract.name)
print("symbol: " .. contract.symbol)
print("description: " .. contract.description)
```

See also: [Blockchain.GetContract](blockchain.md) | [CoreObject.parent](coreobject.md) | [UIText.text](uitext.md)

---

## Learn More

[Blockchain.GetContract()](blockchain.md)
