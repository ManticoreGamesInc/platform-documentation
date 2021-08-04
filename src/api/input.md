---
id: input
name: Input
title: Input
tags:
    - API
---

# Input

The Input namespace contains functions and hooks for responding to player input.

## Hooks

| Hook Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `escapeHook` | `Hook<`[`Player`](player.md) player, table parameters`>` | Hook called when the local player presses the Escape key. The `parameters` table contains a `boolean` named "openPauseMenu", which may be set to `false` to prevent the pause menu from being opened. Players may press `Shift-Esc` to force the pause menu to open without calling this hook. | Client-Only |
