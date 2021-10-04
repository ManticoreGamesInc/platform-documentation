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

## Examples

Example using:

### `CurrentTime`

### `ToIsoString`

In this example, we take the local time and print it to the Event Log in two different ways. By using `tostring()` we are able to see the local interpretation of the `DateTime`. By using `ToIsoString()` we see the time converted to UTC and formatted according to the ISO 8601 standard.

```lua
local now = DateTime.CurrentTime({isLocal = true})
print(tostring(now))
print(now:ToIsoString())
```

---

Example using:

### `CurrentTime`

### `ToIsoString`

### `FromIsoString`

### `secondsSinceEpoch`

In some games it may be important to know if a player is new and, if they are not, how much time has passed since they were last playing. In this example, we catch the moment players join and leave. Using storage, we save the timestamp when they leave and use that information the next time they join. By comparing the timestamps of leaving and joining we know how many seconds elapsed.

```lua
Game.playerLeftEvent:Connect(function(player)
    local data = Storage.GetPlayerData(player)

    local now = DateTime.CurrentTime()
    data.leftDateTime = now:ToIsoString()

    Storage.SetPlayerData(player, data)
end)

Game.playerJoinedEvent:Connect(function(player)
    local data = Storage.GetPlayerData(player)

    if data.leftDateTime then
        local leftAt = DateTime.FromIsoString(data.leftDateTime)
        local now = DateTime.CurrentTime()
        local secondsElapsed = now.secondsSinceEpoch - leftAt.secondsSinceEpoch
        print("player ".. player.name .." was away for "..secondsElapsed.." seconds.")
    else
        print("New player ".. player.name ..". First time playing.")
    end
end)
```

See also: [Storage.GetPlayerData](storage.md) | [Game.playerLeftEvent](game.md) | [Player.name](player.md)

---

Example using:

### `CurrentTime`

### `hour`

### `minute`

### `second`

In this example, a client-context script displays to the player their local clock. This appears in the form hh:mm:ss. The value is written to a `UI Text Box` that is assigned as a custom property.

```lua
local UI_TEXT = script:GetCustomProperty("UITextBox"):WaitForObject()

function FormatDigitalTime(dateTime)
    -- Hour
    local str = dateTime.hour .. ":"
    -- Minutes
    if dateTime.minute < 10 then
        str = str .. "0"
    end
    str = str .. dateTime.minute .. ":"
    -- Seconds
    if dateTime.second < 10 then
        str = str .. "0"
    end
    str = str .. dateTime.second
    return str
end

function Tick()
    local now = DateTime.CurrentTime({isLocal = true})
    UI_TEXT.text = FormatDigitalTime(now)

    Task.Wait(1)
end
```

See also: [UIText.text](uitext.md) | [CoreObject.GetCustomProperty](coreobject.md) | [CoreObjectReference.WaitForObject](coreobjectreference.md) | [Task.Wait](task.md)

---

Example using:

### `New`

### `CurrentTime`

### `FromSecondsSinceEpoch`

### `secondsSinceEpoch`

### `year`

### `month`

### `day`

It can be really useful to know how much time remains until an upcoming event. Perhaps there is a global countdown for all players until a new piece of content is revealed. In this example, we calculate when is the next midnight and how many seconds remain until that threshold arrives. We then take that remaining time and format it in a way that would be appropriate to show to a casual player. Example output: "Time until midnight: 10h 23m". This type of operation could be done every second and displayed in a `World Text` or `UI Text`.

```lua
local SECONDS_IN_DAY = 60 * 60 * 24

-- This function takes a number of remaining seconds and formats it into a string
function FormatCasualTimespan(totalSeconds)
    local seconds = totalSeconds
    local minutes = math.floor(seconds / 60)
    seconds = seconds - minutes*60

    if minutes > 0 then
        local hours = math.floor(minutes / 60)
        minutes = minutes - hours*60

        if hours > 0 then
            local days = math.floor(hours / 24)
            hours = hours - days*24

            if days > 0 then
                if hours > 0 then
                    return days.."d " .. hours.."h"
                end
                return days.."d"

            elseif (minutes > 0) then
                return hours.."h " .. minutes.."m"
            end
            return hours.."h"
        end
        return minutes.."m " .. seconds.."s"
    end
    return seconds.."s"
end

-- Calculate when is the next midnight
local now = DateTime.CurrentTime()
local tomorrow = DateTime.FromSecondsSinceEpoch(now.secondsSinceEpoch + SECONDS_IN_DAY)
local nextMidnight = DateTime.New({
    year = tomorrow.year,
    month = tomorrow.month,
    day = tomorrow.day,
    hour = 0
})
-- Print to the Event Log how much time remains until midnight
local secondsUntilMidnight = nextMidnight.secondsSinceEpoch - now.secondsSinceEpoch
print("Time until midnight: " .. FormatCasualTimespan(secondsUntilMidnight))
```

---
