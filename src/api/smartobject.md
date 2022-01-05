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
| `GetSmartProperty(string)` | `value`, `boolean` | Given a property name, returns the current value of that property on a SmartObject. Returns the value, which can be an integer, number, boolean, string, Vector3, Rotator, Color, or nil if not found. Second return value is a boolean, true if the property was found and false if not. | None |
| `SetSmartProperty(string, value)` | `boolean` | Sets the value of an exposed property. Value can be of type number, boolean, string, Vector3, Rotation or Color, but must match the type of the property. Returns true if the property was set successfully and false if not. | None |

## Examples

Example using:

### `GetSmartProperties`

In this example, a script is placed as the child of a `SmartObject` in the hierarchy. If the object has any smart properties, those are printed out to the Event Log.

```lua
local SMART_OBJECT = script.parent

if SMART_OBJECT:IsA("SmartObject") then
    print("Smart properties for " .. SMART_OBJECT.name)
    local properties = SMART_OBJECT:GetSmartProperties()
    for key,value in pairs(properties) do
        print(key .. " = " .. tostring(value))
    end
else
    print(SMART_OBJECT.name .. " is not a Smart Object.")
end
```

See also: [CoreObject.parent](coreobject.md) | [Other.IsA](other.md)

---

Example using:

### `GetSmartProperty`

### `SetSmartProperty`

In this example, we control the "Sun Light" object in the hierarchy to implement a sort of day/night cycle. We achieve this by rotating the sun object, but it's also necessary to modify the sun's color and light intensity over time.

```lua
local SUN = script.parent
local SUNRISE_COLOR = Color.PURPLE
local SPEED = 10

local defaultSunColor = SUN:GetSmartProperty("Light Color")
local degrees = 30

function Tick(deltaTime)
    degrees = degrees + deltaTime * SPEED
    if degrees > 360 then
        degrees = degrees - 360
    elseif degrees < 0 then
        degrees = degrees + 360
    end

    -- 0 at midday, 1 at both horizons
    local cycle = (math.cos(math.rad((degrees+90) * 2)) * 0.5) + 0.5

    local quat = Quaternion.New(Vector3.New(0,1,0), degrees)
    SUN:SetWorldRotation(quat:GetRotation())
    SUN:SetSmartProperty("Light Color", Color.Lerp(SUNRISE_COLOR, defaultSunColor, cycle))
    SUN:SetSmartProperty("Intensity", 2 + (1.2 * cycle))
end
```

See also: [CoreObject.parent](coreobject.md) | [Color.PURPLE](color.md) | [Quaternion.New](quaternion.md) | [Vector3.New](vector3.md)

---
