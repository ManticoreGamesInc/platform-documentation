---
id: hooklistener
name: HookListener
title: HookListener
tags:
    - API
---

# HookListener

HookListeners are returned by Hooks when you connect a listener function to them.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `isConnected` | `bool` | Returns `true` if this listener is still connected to its hook, `false` if the hook owner was destroyed or if `Disconnect` was called. | Read-Only |
| `priority` | `Integer` | The priority of this listener. When a given hook is fired, listeners with a higher priority are called first. Default value is `100`. | Read-Write |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Disconnect()` | `None` | Disconnects this listener from its hook, so it will no longer be called when the hook is fired. | None |
