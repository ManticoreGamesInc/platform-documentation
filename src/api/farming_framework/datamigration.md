---
id: data migration
name: Data Migration
title: Data Migration
---

# Data Migration

Data Migration is something that you need to do if you change a game setting (like an Item ID) that is referenced in Player's saved datas. Changing something like that will break Player saves because they now refer to an old ID that doesn't exist in the game any more.

To deal with this potential problem, we have a basic Data Migration system that will let you fix Player save data if you do make changes to things it references.

## Functions

| Class Function Name | Return Type | Description | Tags |
| ------------------- | ----------- | ----------- | ---- |
| `GetCurrentVersion()` | `None` | None | None |
| `MigrateCurrencyData(Player, table, string)` | `boolean` | Migrates Currency data between versions if needed. | None |
| `MigrateInventoryData(Player, table, string)` | `boolean` | Migrates Inventory data between versions if needed. | None |
| `MigratePlaceableData(table, string, table, table)` | `boolean` | Migrates Placeable data between versions if needed. | None |
| `MigrateUpgradeData()` | `None` | None | None |
| `SetCurrencyAPI()` | `None` | None | None |
| `SetInventoryAPI()` | `None` | None | None |
