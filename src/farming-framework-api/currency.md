---
id: currency
name: Currency
title: Currency
---

# Currency

Currency is a drop in system that provides ready to go Player Currency management without any code required. It also provides a full API for creators with scripting knowledge to allow them to expand on or change how the Currency works.

Any amount of Currencies can be added to a game and you can use them for more than just visible currency amounts.
For example, a Currency could be used to track the scores in a game.

## Events

| Event Name | Return Type | Description | Tags |
| ---------- | ----------- | ----------- | ---- |
| `CurrencyAdded` | `Event<Player, currencyId, amountAdded>` | Sent each time an amount is added to a Currency for a Player. This event sends on the server as well as the | Server |
| `CurrencyLoaded` | `Event<Player, currencyId>` | Sent when an Currency is loaded on both server and the client for the Player that loaded the Currency. | Server |
| `CurrencyRegistered` | `Event<currencyId>` | Sent when an Currency is registered on the server. | Server |
| `CurrencyRemoved` | `Event<Player, currencyId, amountRemoved>` | Sent each time an amount is removed from a Currency for a Player. This event sends on the server as well as | Server |
| `CurrencySaved` | `Event<Player, currencyId>` | Sent on the server each time an Currency for a Player is saved. | Server |
| `CurrencySet` | `Event<Player, currencyId, amountSet>` | Sent each time a Currency is set to a specific amount for a Player. This event sends on the server as well as | Server |
| `CurrencyUnregistered` | `Event<currencyId>` | Sent when an Currency is unregistered on the server. | Server |

## Functions

| Class Function Name | Return Type | Description | Tags |
| ------------------- | ----------- | ----------- | ---- |
| `AddCurrencyAmount(Player, string, integer, boolean)` | `boolean` | Adds an amount to a Currency for a Player. Returns true if successful. | None |
| `GetCurrencies()` | `table` | Returns all registered Currencies. | None |
| `GetCurrencyAmount(Player, string)` | `integer` | Returns the amount of a Currency that a Player has. | None |
| `GetCurrencyIdFromKey(string)` | `string` | Returns the Currency id associated with a Currency key. | None |
| `GetCurrencyKey(string)` | `string` | Returns a key used for Storage and networking. | None |
| `GetSetting(string, CurrencySetting)` | `any` | Returns a setting value for a Currency, or a default value if the setting cannot be found. | None |
| `HasRoomForCurrencies(Player, table<string, integer>)` | `boolean` | Returns true if the list of Currencies and amounts can fit within their maximums. | None |
| `HasRoomForCurrency(Player, string, integer)` | `boolean` | Returns true if there is enough room in a Currency to add an amount to it. | None |
| `HasRoomForCurrencyFromDrops(Player, DropResults)` | `boolean` | Returns true if a set of Drops can be added to one or more Currencies. | None |
| `IsCurrencyKey(string)` | `boolean` | Returns true if the key is a Currency key. | None |
| `IsCurrencyLoaded(Player, string)` | `boolean` | Returns true if the Currency has been loaded for the Player. | None |
| `IsCurrencyRegistered(string)` | `boolean` | Returns true if a Currency is registered. | None |
| `RegisterCurrency(string)` | `None` | Server Only. Registers a currency. | None |
| `RemoveCurrencyAmount(Player, string, integer, boolean)` | `boolean` | Removes an amount from a Currency for a Player. Returns true if successful. | None |
| `SetCurrencyAmount(Player, string, integer, boolean)` | `boolean` | Sets a Currency to an amount for a Player. Returns true if successful. | None |
| `UnregisterCurrency(string)` | `None` | Server Only. Unregisters a Currency. | None |

## Examples

Example using:

### `SetCurrencyAmount`

### `GetCurrencyAmount`

### `HasRoomForCurrency`

### `CurrencyAdded`

In this example, the player's coins will be doubled when coins has been added.

```lua
-- Server script.
local CURRENCY = require(script:GetCustomProperty("APICurrency"))

local coinsMultiplier = 2
local currency = "coins"

local function OnCurrencyAdded(player, currencyId, amountAdded)
    if coinsMultiplier > 1 and currencyId == currency and CURRENCY.HasRoomForCurrency(player, currencyId, amountAdded) then
        local currentAmount = CURRENCY.GetCurrencyAmount(player, currencyId)

        CURRENCY.SetCurrencyAmount(player, currencyId, currentAmount + (amountAdded * coinsMultiplier))
    end
end

Events.Connect(CURRENCY.Events.CurrencyAdded, OnCurrencyAdded)
```
