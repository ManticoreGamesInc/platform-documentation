# Alpha

## December 19th

### API

The events `Event:Connect()`, `Events.Connect()`, and `Events.ConnectForPlayer` now accept any number of additional arguments after the listener function. When that listener is called, those additional arguments will be provided after the event's own parameters.

Example:

```lua
local function HandleOverlap(trigger, other, extraArg)
    print(extraArg)
end
script.parent.beginOverlapEvent:Connect(HandleOverlap, "Hello")
script.parent.endOverlapEvent:Connect(HandleOverlap, "World!")
```

### Audio

#### Fixes

- Track #21 "Subtle House Club" in Electronic Music Score Set did not play the correct track.
