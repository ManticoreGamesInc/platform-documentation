# GetValue(string)

###### [Classes](/core_api/raw_source) > [Replicators](/core_api/classes/replicators/GetValue)

### Description

Returns the named custom parameter and whether or not the parameter was found.

### Notes
!!! info
    This replicator function returns an Object and a boolean.

### Syntax

`:GetValue(string)`

### Example

- *Example client usage:*
```lua
local function OnChanged(rep, key)
	local value = rep:GetValue(key)
	print_to_screen("K:" .. key .. " V:" .. tostring(value))
end

local replicator = script:GetCustomProperty(“MyReplicator”):WaitForObject()
replicator.valueChangedEvent:Connect(OnChanged)
```

### See Also

* [Classes.Replicators](/core_api/classes/replicators/)
* [SetValue](/core_api/classes/replicators/SetValue)
