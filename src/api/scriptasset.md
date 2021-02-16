---
id: scriptasset
name: ScriptAsset
title: ScriptAsset
tags:
    - API
---

# ScriptAsset

ScriptAsset is an Object representing a script asset in Project Content. When a script is executed from a call to `require()`, it can access the script asset using the `script` variable.

This can be used to read custom properties from the script asset.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `name` | `string` | The name of the script in Project Content. | Read-Only |
| `id` | `string` | The script asset's MUID. | Read-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetCustomProperties()` | `table` | Returns a table containing the names and values of all custom properties on the script asset. | None |
| `GetCustomProperty(string propertyName)` | `value, bool` | Gets an individual custom property from the script asset. Returns the value, which can be an Integer, Number, bool, string, Vector3, Rotator, Color, a MUID string, or nil if not found. Second return value is a bool, true if found and false if not. | None |
