---
id: smartobject
name: SmartObject
title: SmartObject
tags:
    - API
---

# SmartObject

SmartObject is a top-level container for some complex objects and inherits everything from CoreObject. Note that some properties, such as `collision` or `visibility`, may not be respected by a SmartObject.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `team` | `integer` | Assigns the SmartObject to a team. Value range from 0 to 4. 0 is neutral team. | Read-Write |
| `isTeamColorUsed` | `boolean` | If `true`, and the SmartObject has been assigned to a valid team, players on that team will see one color, while other players will see another color. Requires a SmartObject that supports team colors. | Read-Write |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetSmartProperties()` | `table` | Returns a table containing the names and values of all smart properties on a SmartObject. | None |
| `GetSmartProperty(string)` | `value, boolean` | Given a property name, returns the current value of that property on a SmartObject. Returns the value, which can be an integer, number, boolean, string, Vector3, Rotator, Color, or nil if not found. Second return value is a boolean, true if the property was found and false if not. | None |
| `SetSmartProperty(string, value)` | `boolean` | Sets the value of an exposed property. Value can be of type number, boolean, string, Vector3, Rotation or Color, but must match the type of the property. Returns true if the property was set successfully and false if not. | None |
