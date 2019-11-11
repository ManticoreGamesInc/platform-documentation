# Replicators

###### [Classes](/core_api/raw_source) > [Replicators](/core_api/classes/replicators/ReplicatorsOverview)

### Description

Replicators are [CoreObjects](/core_api/classes/coreobject) used to broadcast data from the server to clients. To use them, add custom parameters to a replicator and assign them default values. These parameters will be readable on all clients, and read/write on the server. In short, replicator values are accessible in any context but can only be written over on the server.

Replicators can be used directly to manage variables for a networked state machine, with a controller script on the server setting variable values - and a listener script on every client that responds and controls local client behavior.

### Notes
!!! info
    Replicators are automatically networked. To replicate data to specific players, see also: [PerPlayerReplicator](/core_api/classes/perplayerreplicator).

### Examples
- *Example client usage:*
```lua
local function OnChanged(rep, key)
	local value = rep:GetValue(key)
	print_to_screen("K:" .. key .. " V:" .. tostring(value))
end

local replicator = script:GetCustomProperty(“MyReplicator”):WaitForObject()
replicator.valueChangedEvent:Connect(OnChanged)
```

- *Example server usage:*
```lua
local replicator = script:GetCustomProperty("MyReplicator"):WaitForObject()
replicator:SetValue("Key", value)
```

Note: This example uses a custom property `CoreObjectReference` to point to the replicator. Another valid way of doing this is via the hierarchy (script.parent), or by using the [Tick](/core_api/classes/CORE_Lua_Functions/Tick) function.

### Functions

* [GetValue](/core_api/classes/replicators/functions/GetValue)
* [SetValue](/core_api/classes/replicators/functions/SetValue)


### Events

* [valueChangedEvent](/core_api/classes/replicators/events/valueChangedEvent)
