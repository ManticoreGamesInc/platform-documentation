---
id: folder
name: Folder
title: Folder
tags:
    - API
---

# Folder

Folder is a [CoreObject](coreobject.md) representing a folder containing other objects.

They have no properties or functions of their own, but inherit everything from [CoreObject](coreobject.md).

## Examples

Example using:

In this example, we search for the first ancestor of the script that is of type "Folder", then check if it's the root of the hierarchy.

```lua
local ROOT = script:FindAncestorByType("Folder")

print(tostring(ROOT))

if ROOT == World.GetRootObject() then
    print("Script is at the root of the hierarchy.")
end
```

See also: [CoreObject.FindAncestorByType](coreobject.md) | [World.GetRootObject](world.md)

---
