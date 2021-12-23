---
id: bindingset
name: BindingSet
title: BindingSet
tags:
    - API
---

# BindingSet

BindingSet is a CoreObject which contains a set of actions a creator has defined for a game and the default key bindings to trigger those actions.

## Examples

Example using:

In this example, when the game starts we search for all binding sets that exist in the hierarchy and print their names to the Event Log window.

```lua
local bindingSets = World.FindObjectsByType("BindingSet")

if #bindingSets == 0 then
    print("No binding sets found in game.")
else
    print("Binding Sets found:")
    for _,bs in ipairs(bindingSets) do
        print("  " .. bs.name)
    end
end
```

See also: [World.FindObjectsByType](world.md) | [CoreObject.name](coreobject.md)

---
