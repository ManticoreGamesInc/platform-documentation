---
id: coregamecollectionentry
name: CoreGameCollectionEntry
title: CoreGameCollectionEntry
tags:
    - API
---

# CoreGameCollectionEntry

Metadata about a published game in a collection on the Core platform. Additional metadata is available via [CorePlatform.GetGameInfo()](coreplatform.md).

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `id` | `string` | The ID of the game. | Read-Only |
| `parentGameId` | `string` | The ID of this game's parent game if there is one, or else `nil`. | Read-Only |
| `name` | `string` | The name of the game. | Read-Only |
| `ownerId` | `string` | The player ID of the creator who published the game. | Read-Only |
| `ownerName` | `string` | The player name of the creator who published the game. | Read-Only |
| `isPromoted` | `bool` | Whether or not this game is promoted. | Read-Only |

## Examples

Example using:

### `id`

### `parentGameId`

### `name`

### `ownerId`

### `ownerName`

### `isPromoted`

In this example we print to the event log information about all featured games.

```lua
local collection = CorePlatform.GetGameCollection("featured")

print("FEATURED GAMES\n")
for _,entry in ipairs(collection) do
    print(entry.name.."\n"..
          "  id: "..entry.id.."\n"..
          "  parentGameId: "..tostring(entry.parentGameId).."\n"..
          "  ownerName: "..entry.ownerName.."\n"..
          "  ownerId: "..entry.ownerId.."\n"..
          "  isPromoted: "..tostring(entry.isPromoted).."\n"
    )
end
```

See also: [CorePlatform.GetGameCollection](coreplatform.md)

---

## Learn More

[CorePlatform.GetGameCollection()](coreplatform.md)
