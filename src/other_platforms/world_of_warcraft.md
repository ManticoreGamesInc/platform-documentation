---
id: world_of_warcraft
name: Coming to Core from World of Warcraft
title: Coming to Core from World of Warcraft
tags:
    - Reference
---

# Coming to Core from World of Warcraft

## Overview

The purpose of this page is to let experienced game developers get started using the unique features of the Core platform.

- For a general introduction to creating with Core, see [Intro to the Core Editor](editor_intro.md)
- For a complete technical overview, see the [Core API Documentation](../api/index.md).

## World of Warcraft

Ref: <https://www.townlong-yak.com/framexml/live/>

Instead of 5.1 as in WoW, Core uses Lua 5.3.6. There have not been that many changes in the language itself but do note that many of the additions Blizzard made will be missing here.

- Trigonometry functions: As with Blizzard's versions, Core's work with degrees. Lua's standard math library works with radians.
- Events: The most obvious change when coming from WoW, is the event system in Core. Instead of hooking your events up to your frames, you register functions onto the events of objects.

As an example:

```lua
groupFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
groupFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
groupFrame:SetScript("OnEvent", function(self, event)
  GroupRosterUpdate()
end)
```

Would look something like this in Core:

```lua
groupFrame.GROUP_ROSTER_UPDATE:Connect(GroupRosterUpdate)
groupFrame.PLAYER_ENTERING_WORLD:Connect(GroupRosterUpdate)
```

Every object has a specific set of events available, but there are also custom events that you can fire via `Broadcast()` and register on the `Event` namespace:

```lua
local function Foo(arg_1, arg_2)
 -- do something
end

Events.Connect("MyEvent", Foo)
```

You can find more examples for events in our [API documentation](../api/events.md) section.

- The often (miss)used `OnUpdate` event equivalent is the global `Tick()` function. It is totally fine to overwrite it with your own.
- Instead of frames, you will mostly work with objects in Core. Those can be destroyed completely instead of just be hidden like frames in WoW.
- Core does have `print` but it prints to the Event Log instead of the chat frame. There is no `dump` for tables.
- Core does not include the `bitlib` library but since it is Lua 5.3 it has native support for [bitwise operators](http://lua-users.org/wiki/BitwiseOperators).
