---
id: coregameinfo
name: CoreGameInfo
title: CoreGameInfo
tags:
    - API
---

# CoreGameInfo

Metadata about a published game on the Core platform.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `id` | `string` | The ID of the game. | Read-Only |
| `parentGameId` | `string` | The ID of this game's parent game if there is one, or else `nil`. | Read-Only |
| `name` | `string` | The name of the game. | Read-Only |
| `description` | `string` | The description of the game. | Read-Only |
| `ownerId` | `string` | The player ID of the creator who published the game. | Read-Only |
| `ownerName` | `string` | The player name of the creator who published the game. | Read-Only |
| `maxPlayers` | `integer` | The maximum number of players per game instance. | Read-Only |
| `screenshotCount` | `integer` | The number of screenshots published with the game. | Read-Only |
| `hasWorldCapture` | `boolean` | `true` if the game was published with a captured view of the world for use with portals. | Read-Only |
| `isQueueEnabled` | `boolean` | `true` if the game was published with queueing enabled. | Read-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetTags()` | `Array`<`string`> | Returns a list of the tags selected when this game was published. | None |

## Examples

Example using:

### `id`

### `parentGameId`

### `name`

### `description`

### `ownerId`

### `ownerName`

### `maxPlayers`

### `screenshotCount`

### `hasWorldCapture`

### `isQueueEnabled`

### `GetTags`

In this example we print to the event log information about the current game being played. This only works if the game has ever been published.

```lua
local gameId = Game.GetCurrentGameId()
local gameInfo = CorePlatform.GetGameInfo(gameId)

print("Currently playing: " ..gameInfo.name)
print("  id: "..gameInfo.id)
print("  parentGameId: "..tostring(gameInfo.parentGameId))
print("  ownerName: "..gameInfo.ownerName)
print("  ownerId: "..gameInfo.ownerId)
print("  maxPlayers: "..gameInfo.maxPlayers)
print("  screenshotCount: "..gameInfo.screenshotCount)
print("  hasWorldCapture: "..tostring(gameInfo.hasWorldCapture))
print("  isQueueEnabled: "..tostring(gameInfo.isQueueEnabled))
print("  description: "..gameInfo.description)
local tags = "["..
    CoreString.Join(", ", table.unpack(gameInfo:GetTags()))
.."]"
print("  tags: "..tags)
```

See also: [CorePlatform.GetGameInfo](coreplatform.md) | [Game.GetCurrentGameId](game.md) | [CoreString.Join](corestring.md)

---

## Learn More

[CorePlatform.GetGameInfo()](coreplatform.md)
