---
id: real time
name: Real Time
title: Real Time
---

# Real Time

## Functions

| Class Function Name | Return Type | Description | Tags |
| ------------------- | ----------- | ----------- | ---- |
| `CompactTime()` | `None` | Handy function for networking | None |
| `ExpandTime()` | `None` | Handy function for networking | None |
| `GetRealTime()` |  | Gives you the epoch time, accurate to the millisecond based on the last sync. | None |
| `IsValid()` | `boolean` | If this is false GetRealTime() will still return a correct value it just wont be server authorized. | None |
| `SyncronizeEpoch()` | `None` | Call this on the server to refresh the difference between epoch time and time(). | None |
| `UpdateAllPlayersEpoch()` | `None` | Updates all the players with the current offset between epoch time and server time. | None |
| `UpdatePlayerEpoch(string|table)` | `None` | Update a player so they know the offset between epoch time and server time. | None |
