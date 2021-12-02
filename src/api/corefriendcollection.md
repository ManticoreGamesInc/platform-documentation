---
id: corefriendcollection
name: CoreFriendCollection
title: CoreFriendCollection
tags:
    - API
---

# CoreFriendCollection

Contains a set of results from [CoreSocial.GetFriends()](coresocial.md). Depending on how many friends a player has, results may be separated into multiple pages. The `.hasMoreResults` property may be checked to determine whether more friends are available. Those results may be retrieved using the `:GetMoreResults()` function.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `hasMoreResults` | `boolean` | Returns `true` if there are more friends available to be requested. | Read-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetResults()` | `Array`<[`CoreFriendCollectionEntry`](corefriendcollectionentry.md)> | Returns the list of friends contained in this set of results. This may return an empty table for players who have no friends. | None |
| `GetMoreResults()` | [`CoreFriendCollection`](corefriendcollection.md) | Requests the next set of results for this list of friends and returns a new collection containing those results. Returns `nil` if the `hasMoreResults` property is `false`. This function may yield until a result is available, and may raise an error if an error occurs retrieving the information. | None |

## Examples

Example using:

### `hasMoreResults`

### `GetResults`

### `GetMoreResults`

A player's list of friends is split into multiple pages of data. In this example, we implement a set of useful functions, not only for loading the pages, but for moving forward and backwards through the collection.

```lua
local friendCollection = nil

local pages = {}
local pageIndex = 0

function Setup(player)
    friendCollection = CoreSocial.GetFriends(player)
    local firstPage = friendCollection:GetResults()
    pages = { firstPage }
    pageIndex = 1
end

function GetCurrentPage()
    return pages[pageIndex]
end

function HasPreviousPage()
    return pageIndex > 1
end

function HasNextPage()
    return pageIndex < #pages or friendCollection.hasMoreResults
end

function PreviousPage()
    pageIndex = pageIndex - 1
    if pageIndex < 1 then
        pageIndex = 1
    end
    return GetCurrentPage()
end

function NextPage()
    pageIndex = pageIndex + 1
    if pageIndex > #pages then
        if friendCollection.hasMoreResults then
            friendCollection = friendCollection:GetMoreResults()
            local newPage = friendCollection:GetResults()
            table.insert(pages, newPage)
        else
            pageIndex = #pages
        end
    end
    return GetCurrentPage()
end

function PrintPage(pageData)
    for _,entry in ipairs(pageData) do
        print(entry.name .. ":" .. entry.id)
    end
end
```

See also: [CoreSocial.GetFriends](coresocial.md) | [CoreFriendCollectionEntry.name](corefriendcollectionentry.md)

---

## Learn More

[CoreSocial.GetFriends()](coresocial.md)
