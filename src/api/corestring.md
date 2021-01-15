---
id: corestring
name: CoreString
title: CoreString
tags:
    - API
---

# CoreString

## Description

The CoreString namespace contains a set of string utility functions.

## API

### Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `CoreString.Join(string delimiter, [...])` | `string` | Concatenates the given values together, separated by `delimiter`.  If a given value is not a string, it is converted to one using `tostring()`. | None |
| `CoreString.Split(string s, [string delimiter], [table parameters])` | `...` | Splits the string `s` into substrings separated by `delimiter`.<br/>Optional parameters in the `parameters` table include:<br/>`removeEmptyResults (bool)`: If `true`, empty strings will be removed from the results. Defaults to `false`.<br/>`maxResults (integer)`: Limits the number of strings that will be returned. The last result will be any remaining unsplit portion of `s`.<br/>`delimiters (string or Array<string>)`:Allows splitting on multiple delimiters. If both this and the `delimiter` parameter are specified, the combined list is used. If neither is specified, default is to split on any whitespace characters.<br/>Note that this function does not return a table, it returns multiple strings. For example: `local myHello, myCore = CoreString.Split("Hello Core!")` If a table is desired, wrap the call to `Split()` in curly braces, eg: `local myTable = {CoreString.Split("Hello Core!")}` | None |
| `CoreString.Trim(string s, [...])` | `string` | Trims whitespace from the start and end of `s`, returning the result.  An optional list of strings may be provided to trim those strings from `s` instead of the default whitespace. For example, `CoreString.Trim("(==((Hello!))==)", "(==(", ")==)")` returns "(Hello!)". | None |
