# Alpha

## December 19th

#### Changes

- Interactable triggers that are in a static or default context now fire an interacted event on both client and server. An interactable trigger in a client context will fire interacted event on the client only. Interactable triggers will no work under a server context and will throw a warning.
- Improved Decal performance.
- All Effects should now properly respect the auto-play flag when effect elements are in a mixed state.

#### New Features

- Added auto-indent to the script editor. Can be disabled in the options screen.
- Added Rocket Launcher, Grenade Launcher and Grenades. Updated all weapons to new tunings.
- The events `Event:Connect()`, `Events.Connect()`, and `Events.ConnectForPlayer` now accept any number of additional arguments after the listener function. When that listener is called, those additional arguments will be provided after the event's own parameters.

Example:

```lua
local function HandleOverlap(trigger, other, extraArg)
    print(extraArg)
end
script.parent.beginOverlapEvent:Connect(HandleOverlap, "Hello")
script.parent.endOverlapEvent:Connect(HandleOverlap, "World!")
```

#### Fixes

- Explosion effect now properly makes use of color parameter.
- Fixed a bug in the selection system that was sometimes making the "audio preview" button not show up after testing a map.
- Track #21 "Subtle House Club" in "Electronic Music Score Set" did not play the correct track.
- Updated effects to properly handle auto-play flag when emitters are being enabled or disabled.
- Fix crash when passing `nil` as Player to `Equip()`.
- Fix for destorying objects that are spawned on the same frame and client context object spawning afterwards
- Fix for the crash that happened when you used portals between games.
