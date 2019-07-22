# SetValue(string, Object)

###### [Classes](/core_api/raw_source) > [Replicators](/core_api/classes/replicators/SetValue)

### Description

Sets the named custom parameter and returns whether or not it was set successfully. Reasons for failure include not being able to find the parameter or the Object parameter being the wrong type.


### Notes
!!! info
    This replicator function returns a boolean.

### Syntax

`:SetValue(string, Object)`

### Example

- *Example server usage:*
```lua
local replicator = script:GetCustomProperty(“MyReplicator”):WaitForObject()
replicator:SetValue("Key", value)
```

### See Also

* [Classes.Replicators](/core_api/classes/replicators/)
* [SetValue](/core_api/classes/replicators/SetValue)
