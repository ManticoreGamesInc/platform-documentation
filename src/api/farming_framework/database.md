---
id: database
name: Database
title: Database
---

# Database

These Databases can be added anywhere in the hierarchy (In Default Context) and they will automatically parse any folders, groups, scripts and their children into a set of nested data. This data can then be accessed though the APIDatabase.

You can have as many of these in your scene as you want. They will all merge their data together where you can access it easily in scripts.

## Functions

| Class Function Name | Return Type | Description | Tags |
| ------------------- | ----------- | ----------- | ---- |
| `AppendData(table)` | `None` | Appends a set of data to the Database. Will merge data in without overwriting nested structures. | None |
| `ParseCoreObject(CoreObject, boolean, boolean)` | `table` | Iterates over a CoreObject and its children and converts the hierarchy and custom properties into a set of nested data. Data can optionally be added to the database. | None |
| `PrintData()` | `None` | Prints all data into the Event Log. | None |
| `RegisterDataChangeHandler(function, string|nil)` | `integer` | Registers a callback that will fire each time data is added to the Database. If a root is specified, the callback will only fire if data is added to that root. A handle id is returned that can be used to unregister the callback later. | None |
| `UnregisterDataChangeHandler(integer)` | `None` | Unregisters a callback using the supplied handle id. | None |
