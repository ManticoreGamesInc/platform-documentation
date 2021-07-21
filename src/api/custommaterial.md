---
id: custommaterial
name: CustomMaterial
title: CustomMaterial
tags:
    - API
---

# CustomMaterial

CustomMaterial objects represent a custom material made in core. They can have their properties changed from script.

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `SetProperty(string propertyName, value)` | `None` | Sets the given property of the material. | Client-Only |
| `GetProperty(string propertyName)` | `value` | Gets the value of a given property. | Client-Only |
| `GetPropertyNames()` | `Array<string>` | Returns an array of all property names on this CustomMaterial. | Client-Only |
| `GetBaseMaterialId()` | `string` | Returns the asset id of the material this CustomMaterial was based on. | Client-Only |

## Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `CustomMaterial.Find(string assetId)` | [`CustomMaterial`](custommaterial.md) | Returns a CustomMaterial with the given assetId. This function may yield while loading data. | Client-Only |
