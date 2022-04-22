---
id: active core objects
name: Active Core Objects
title: Active Core Objects
---

# Active Core Objects

## Functions

| Class Function Name | Return Type | Description | Tags |
| ------------------- | ----------- | ----------- | ---- |
| `ConnectToActivationChange(CoreObject, func<CoreObject, boolean>)` | `EventHandler @A handler` | Allows you to connect a function to be trigger when core objects activation has changed. This will be called if any of its parents have had their activation changed. | None |
| `IsActive(CoreObject)` | `boolean` | Check if any core object is active by looping upwards through the parents and seeing how its ancestors are marked. | None |
| `SetActive(CoreObject, integer|boolean)` | `None` | Marks a core object as being active as FORCE_ON, FORCE_OFF, INHERIT. Or you can use a bool. | None |
