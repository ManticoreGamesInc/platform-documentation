# valueChangedEvent(Event<Replicator, string parametername>)

###### [Classes](/core_api/raw_source) > [Replicators](/core_api/classes/replicators/SetValue)

### Description

An event that is fired whenever any of the parameters managed by the [Replicator](/core_api/classes/replicators) receives an update. The event is fired on the server and the client. Event payload is the Replicator object and the name of the parameter that just changed.

### Notes
!!! info
    This replicator event has a payload that is read-only.

### Syntax

`:SetValue(string, Object)`

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
