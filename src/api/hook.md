---
id: hook
name: Hook
title: Hook
tags:
    - API
---

# Hook

## Description

Hooks appear as properties on several objects. Similar to Events, functions may be registered that will be called whenever that hook is fired, but Hooks allow those functions to modify the parameters given to them. E.g. `player.movementHook:Connect(OnPlayerMovement)` calls the function `OnPlayerMovement` each tick, which may modify the direction in which a player will move.

## API

### Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Connect(function hookListener, [...])` | `HookListener` | Registers the given function which will be called every time the hook is fired. Returns a HookListener which can be used to disconnect from the hook or change the listener's priority. Accepts any number of additional arguments after the listener function, those arguments will be provided after the hook's own parameters. | None |
