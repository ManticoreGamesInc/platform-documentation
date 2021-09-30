---
id: datetime
name: DateTime
title: DateTime
tags:
    - API
---

# DateTime

An immutable representation of a date and time, which may be either local time or UTC.

## Constructors

| Constructor Name | Return Type | Description | Tags |
| ----------- | ----------- | ----------- | ---- |
| `DateTime.New(table parameters)` | [`DateTime`](datetime.md) | Constructs a new DateTime instance, defaulting to midnight on January 1, 1970, UTC. The `parameters` table may contain the following values to specify the date and time:<br/>`year (integer)`: Specifies the year. <br/>`month (integer)`: Specifies the month, from 1 to 12. <br/>`day (integer)`: Specifies the day of the month, from 1 to the last day of the specified month. <br/>`hour (integer)`: Specifies the hour of the day, from 0 to 23. <br/>`minute (integer)`: Specifies the minute, from 0 to 59. <br/>`second (integer)`: Specifies the second, from 0 to 59. <br/>`millisecond (integer)`: Specifies the millisecond, from 0 to 999. <br/>`isLocal (boolean)`: If true, the new DateTime will be in local time. Defaults to false for UTC. <br/>Values outside of the supported range for each field will be clamped, and a warning will be logged. | None |

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `year` | `integer` | The year component of this DateTime. | Read-Only |
| `month` | `integer` | The month component of this DateTime, from 1 to 12. | Read-Only |
| `day` | `integer` | The day component of this DateTime, from 1 to 31. | Read-Only |
| `hour` | `integer` | The hour component of this DateTime, from 0 to 23. | Read-Only |
| `minute` | `integer` | The minute component of this DateTime, from 0 to 59. | Read-Only |
| `second` | `integer` | The second component of this DateTime, from 0 to 59. | Read-Only |
| `millisecond` | `integer` | The millisecond component of this DateTime, from 0 to 999. | Read-Only |
| `isLocal` | `boolean` | True if this DateTime is in the local time zone, false if it's UTC. | Read-Only |
| `secondsSinceEpoch` | `integer` | Returns the number of seconds since midnight, January 1, 1970, UTC. Note that this ignores the millisecond component of this DateTime. | Read-Only |
| `millisecondsSinceEpoch` | `integer` | Returns the number of milliseconds since midnight, January 1, 1970, UTC. | Read-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `ToLocalTime()` | [`DateTime`](datetime.md) | Returns a copy of this DateTime adjusted to local time. If this DateTime is already in local time, simply returns a copy of this DateTime. | None |
| `ToUtcTime()` | [`DateTime`](datetime.md) | Returns a copy of this DateTime adjusted to UTC. If this DateTime is already in UTC, simply returns a copy of this DateTime. | None |
| `ToIsoString()` | `string` | Returns this date and time, adjusted to UTC, formatted as an ISO 8601 string (`YYYY-mm-ddTHH:MM:SS.sssZ`) | None |

## Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `DateTime.CurrentTime([table optionalParameters])` | [`DateTime`](datetime.md) | Returns the current date and time in UTC. The `optionalParameters` table may contain the following values to change the date and time returned: <br/>`isLocal (boolean)`: If true, the current local time will be returned instead of UTC. | None |
| `DateTime.FromSecondsSinceEpoch(integer secondsSinceEpoch)` | [`DateTime`](datetime.md) | Returns the date and time that is `secondsSinceEpoch` seconds since midnight, January 1, 1970, UTC. | None |
| `DateTime.FromMillisecondsSinceEpoch(integer millisecondsSinceEpoch)` | [`DateTime`](datetime.md) | Returns the date and time that is `millisecondsSinceEpoch` milliseconds since midnight, January 1, 1970, UTC. | None |
| `DateTime.FromIsoString(string)` | [`DateTime`](datetime.md) | Parses the given string as an ISO 8601 formatted date (`YYYY-MM-DD`) or date and time (`YYYY-mm-ddTHH:MM:SS(.sss)(Z/+hh:mm/+hhmm/-hh:mm/-hhmm)`). Returns the parsed UTC DateTime, or `nil` if the string was an invalid format. | None |
