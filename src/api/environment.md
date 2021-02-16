---
id: environment
name: Environment
title: Environment
tags:
    - API
---

# Environment

The Environment namespace contains a set of functions for determining where a script is running. Some of these functions are paired together. For example, a script will return `true` for one of `Environment.IsServer()` or `Environment.IsClient()`, but never for both. Similarly, either `Environment.IsLocalGame()` or `Environment.IsHostedGame()` will return `true`, but not both.

## Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `Environment.IsServer()` | `bool` | Returns `true` if the script is running in a server environment. Note that this can include scripts running in the editor in preview mode (where the editor acts as server for the game) or for the "Play Locally" option in the Main Menu. This will always return `false` for scripts in a Client Context. | None |
| `Environment.IsClient()` | `bool` | Returns `true` if the script is running in a client environment. This includes scripts that are in a Client Context, as well as scripts in a Static Context on a multiplayer preview client or a client playing a hosted game. Note that single-player preview and the "Play Locally" option only execute Static Context scripts once, and that is in a server environment. | None |
| `Environment.IsHostedGame()` | `bool` | Returns `true` if running in a published online game, for both clients and servers. | None |
| `Environment.IsLocalGame()` | `bool` | Returns `true` if running in a local game on the player's computer. This includes preview mode, as well as the "Play Locally" option in the Main Menu. | None |
| `Environment.IsPreview()` | `bool` | Returns `true` if running in preview mode. | None |
| `Environment.IsMultiplayerPreview()` | `bool` | Returns `true` if running in multiplayer preview mode. | None |
| `Environment.IsSinglePlayerPreview()` | `bool` | Returns `true` if running in single-player preview mode. | None |
