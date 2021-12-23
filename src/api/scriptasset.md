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
| `GetCustomProperty(string propertyName)` | `value`, `boolean` | Gets an individual custom property from the script asset. Returns the value, which can be an integer, number, boolean, string, Vector3, Rotator, Color, a MUID string, or nil if not found. Second return value is a boolean, true if found and false if not. | None |

## Examples

Example using:

### `name`

### `id`

### `GetCustomProperties`

### `GetCustomProperty`

In this example we have two scripts. The first one is only in project content and behaves as the `ScriptAsset`. The second script is placed in the hierarchy. To complete the setup, the first script is assigned as a custom property of the second script, so that `require()` may be called on it.

```lua
-- Contents of the first script that is in project content, but not in the hierarchy
print("Script Asset: " .. script.name .. ", " .. script.id)
local assetProperties = script:GetCustomProperties()

for k,v in pairs(assetProperties) do
    print(k, ":", v)
end

local FOO = script:GetCustomProperty("Foo")
if not FOO then
    print("The script asset does not have custom property 'Foo'")
end

-- Contents of the second script, that is in hierarchy and requires the script asset
require( script:GetCustomProperty("MyFirstScript") )
```

---
