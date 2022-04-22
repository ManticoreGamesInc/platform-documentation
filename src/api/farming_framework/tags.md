---
id: tags
name: Tags
title: Tags
---

# Tags

## Functions

| Class Function Name | Return Type | Description | Tags |
| ------------------- | ----------- | ----------- | ---- |
| `AnyMatch(table|string, table|string)` | `boolean` | Determines if there is at least one match between two sets of tags. | None |
| `FindMatchingData(string, table|string, boolean)` | `table` | Retrieves all data entries in a given data group from APIDatabase if their ids or tags match the provided tags. Returns a table of all the results indexed by data id by default. | None |
| `GetTagsString(string, string)` | `string` | Looks up the standardized Tags property on a data entry. | None |
| `SplitTagsString(string)` | `table` | Splits a standardized tag string into an array of tags. | None |
