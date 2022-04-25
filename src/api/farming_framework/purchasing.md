---
id: purchasing
name: Purchasing
title: Purchasing
---

# Purchasing

## Functions

| Class Function Name | Return Type | Description | Tags |
| ------------------- | ----------- | ----------- | ---- |
| `CanAfford(Player, PurchaseableData, integer)` | `boolean` | Returns true if the Player can afford an amount of this purchasable | None |
| `CanSell(Player, SellableData, integer)` | `boolean` | Returns true if the Player has the required amount of materials to sell an amount of a sellable. | None |
| `ClearStoreSave(Player, string)` | `None` | Clears the save data for a player that's associated with a particular store. | None |
| `GetAvailableAmount(Player, PurchaseableData, string|nil)` | `integer` | Determines how much of a purchasable is available for purchase. This takes into account global purchase limits. Returns nil if purchases are unlimited. | None |
| `GetSellLimit(Player, SellableData)` | `integer` | Returns the maximum amount of a Sellable that a player is currently able to sell. | None |
| `GetStoreIdFromKey(string)` | `string` | Parses the Store ID from a purchasing key | None |
| `GetStores()` | `table` | Returns an array of all the available store IDs. | None |
| `IsPerkPurchase(PurchaseableData)` | `boolean` | Returns true if this Purchasable Data is associated with a Perk. | None |
| `IsPurchasingKey(string)` | `boolean` | Returns true if this key starts with the purchasing tag | None |
| `IsStoreLoaded(Player, string)` | `boolean` | Returns true if the Store has been loaded for a specific Player. | None |
| `IsStoreRegistered(string)` | `boolean` | Returns true if the Store has been registered. | None |
| `Purchase(Player, PurchaseableData, integer)` | `string`, `boolean` | Completes a purchase for a Player. | None |
| `RegisterStore(string, string|nil)` | `None` | Server Only. Registers and loads a Store's purchase history. | None |
| `Sell(Player, SellableData, integer)` | `string`, `boolean` | Completes a sale for a Player. | None |
| `SetPendingPerkPurchase(Player, PurchaseableData)` | `None` | Sets a pending Perk purchase. This is needed due to the Perk Window being separate from the Purchase UI. | None |

## Examples

Example using:

### `PurchaseComplete`

In this example, a message is printed to the Event Log display the quantity and item that was purchased from a store.

```lua
-- Client script.
local API_PURCHASING = require(script:GetCustomProperty("APIPurchasing"))

local function OnPurchaseComplete(drop)
    if drop.Items then
        for item, quantity in pairs(drop.Items) do
            print(string.format("You purchased %s %s.", quantity, item))
        end
    end
end

Events.Connect(API_PURCHASING.Events.PurchaseComplete, OnPurchaseComplete)
```
