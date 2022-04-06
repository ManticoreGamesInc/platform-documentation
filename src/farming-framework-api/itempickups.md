---
id: item pickups
name: Item Pickups
title: Item Pickups
---

# Item Pickups

## Functions

| Class Function Name | Return Type | Description | Tags |
| ------------------- | ----------- | ----------- | ---- |
| `CanCollectItemPickup(Player, integer)` | `boolean` | Returns true if the Item Pickup can be collected. | None |
| `CollectItemPickups(Player, integer, integer[])` | `None` | Collects the Item Pickup. | None |
| `CreateItemPickup(Player|nil, string, Vector3, Vector3, integer, integer, string, integer, boolean, boolean, number)` | `None` | Creates an Item Pickup for one or all Players. | None |
| `CreateItemPickups(Player|nil, string, Vector3, number, PickupData[], boolean, boolean, number)` | `None` | Creates one or more Item Pickups for one or all Players. | None |
| `CreateItemPickupsForDrops(Player|nil, DropResults, string, Vector3, number, number, boolean, boolean, number, integer)` | `None` | Creates one or more Item Pickups for a set of DropResults for one or all Players. | None |
| `CreatePickupData(integer, integer, string, integer, number)` | `PickupData` | Returns a table formatted to work with CreateItemPickups(). | None |
