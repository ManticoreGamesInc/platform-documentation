---
id: light
name: Light
title: Light
tags:
    - API
---

# Light

Light is a light source that is a CoreObject. Generally a Light will be an instance of some subtype, such as PointLight or SpotLight.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `intensity` | `number` | The intensity of the light. For PointLights and SpotLights, this has two interpretations, depending on the value of the `hasNaturalFallOff` property. If `true`, the light's Intensity is in units of lumens, where 1700 lumens is a 100W lightbulb. If `false`, the light's Intensity is a brightness scale. | Read-Write |
| `attenuationRadius` | `number` | Bounds the light's visible influence. This clamping of the light's influence is not physically correct but very important for performance, larger lights cost more. | Read-Write |
| `isShadowCaster` | `boolean` | Does this light cast shadows? | Read-Write |
| `hasTemperature` | `boolean` | true: use temperature value as illuminant. false: use white (D65) as illuminant. | Read-Write |
| `temperature` | `number` | Color temperature in Kelvin of the blackbody illuminant. White (D65) is 6500K. | Read-Write |
| `team` | `integer` | Assigns the light to a team. Value range from 0 to 4. 0 is a neutral team. | Read-Write |
| `isTeamColorUsed` | `boolean` | If `true`, and the light has been assigned to a valid team, players on that team will see a blue light, while other players will see red. | Read-Write |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetColor()` | [`Color`](color.md) | The color of the light. | None |
| `SetColor(Color)` | `None` | The color of the light. | None |

## Examples

Example using:

### `GetColor`

### `SetColor`

In this example, the light will be changed by removing its red channel.

```lua
--Grab the light object (spotlight, point light, or light volume).
local LIGHT = script:GetCustomProperty("Light"):WaitForObject()

--Get the light's current color
local color = LIGHT:GetColor()

--Clear the red component of the color
color.r = 0

--Set the color back into the light to apply the change
LIGHT:SetColor(color)
```

See also: [Color.r](color.md) | [CoreObject.GetCustomProperty](coreobject.md)

---

Example using:

### `SetColor`

### `intensity`

In this example a light will repeatedly pulse and change color. This is done by passing the current time into a sine wave function. The output of this sine wave function is then used as the intensity of the light. This output of the sine wave is also used to control the red, green, and blue, intensities of the light's color.

```lua
--Grab the light object (spotlight, point light, or light volume) that is a parent of this script
local POINT_LIGHT = script.parent

--Changing this value changes the wavelength of the sine wave function
local TIME_SCALAR = 7

--This variable will keep track of the number of seconds that
--have passed since this script started
local timePassed = 0

--Amplitude of the sine wave function
local AMPLITUDE = 50

--Calculate one third of pi (60 degrees) The sine wave controlling the 
--green intensity will be horizontally offset by this amount.
local ONE_THIRD_PI = (1/3) * math.pi

--Calculate two thirds of pi (120 degrees). The sine wave controlling the 
--blue intensity will be horizontally offset by this amount.
local TWO_THIRD_PI = (2/3) * math.pi

function Tick(deltaTime)
    --Update the "timePassed" variable to keep track of the time that has
    --passed since this script ran
    timePassed = timePassed + deltaTime

    --Use a sine wave function to determine the current intensity of the light 
    local intensity = (math.sin(timePassed * TIME_SCALAR * 1.2) * AMPLITUDE) + AMPLITUDE

    --Update the intensity of the light
    POINT_LIGHT.intensity = intensity
    
    
    --Calculate the strength of the red hue of the light (ranges from 0 - 1)
    local RedChannel = (math.sin(timePassed * TIME_SCALAR) * 0.5) + 0.5 
    --Calculate the strength of the green hue of the light (ranges from 0 - 1)
    --Offset the "timePassed" by 1/3 pi units (60 degrees)
    local GreenChannel = (math.sin( (timePassed - ONE_THIRD_PI) * TIME_SCALAR * 0.3) * 0.5) + 0.5 
    --Calculate the strength of the blue hue of the light (ranges from 0 - 1)
    --Offset the "timePassed" by 2/3 pi units (120 degrees)
    local BlueChannel = (math.sin( (timePassed - TWO_THIRD_PI) * TIME_SCALAR) * 0.5) + 0.5 
    
    --Create a new color using the RGB (Red, Green, Blue) values calculated above
    local newColor = Color.New(RedChannel, GreenChannel, BlueChannel)
    
    --Update the color of the light's
    POINT_LIGHT:SetColor(newColor)
end
```

See also: [Color.New](color.md) | [CoreObject.parent](coreobject.md)

---

Example using:

### `intensity`

In this example a light will repeatedly pulse. This is done by passing the current time (in seconds) into a sine wave function. The output of this sine wave function is then used as the intensity of the light causing to it pulse.

```lua
--Get the light object (spotlight, point light, or light volume)
local LIGHT = script:GetCustomProperty("Light"):WaitForObject()

--Changing this value changes the wavelength of the sine wave function
local TIME_SCALAR = 8

--This variable will keep track of the number of seconds that
--have passed since this script started
local timePassed = 0

--Amplitude of the sine wave function
local AMPLITUDE = 50

function Tick(deltaTime)
    --Update the "timePassed" variable to keep track of the time that has
    --passed since this script began to run
    timePassed = timePassed + deltaTime

    --Use a sine wave function to determine the current intensity of the light 
    local intensity = (math.sin(timePassed * TIME_SCALAR) * AMPLITUDE)

    --Update the intensity of the light
    LIGHT.intensity = intensity
end
```

See also: [CoreObject.GetCustomProperty](coreobject.md)

---

Example using:

### `team`

### `isTeamColorUsed`

In this example, a light and a trigger work in conjunction. When a player enters the trigger, team coloring is enabled for the light. When a player leaves the trigger the light's team settings go back to default.

```lua
local TRIGGER = script:GetCustomProperty("Trigger"):WaitForObject()
local LIGHT = script:GetCustomProperty("Light"):WaitForObject()

function OnBeginOverlap(trigger, player)
    if not player:IsA("Player") then return end
    
    LIGHT.team = player.team
    LIGHT.isTeamColorUsed = true
end

function OnEndOverlap(trigger, player)
    if not player:IsA("Player") then return end
    
    LIGHT.team = 0
    LIGHT.isTeamColorUsed = false
end

TRIGGER.beginOverlapEvent:Connect(OnBeginOverlap)
TRIGGER.endOverlapEvent:Connect(OnEndOverlap)
```

See also: [Trigger.beginOverlapEvent](trigger.md) | [CoreObject.GetCustomProperty](coreobject.md) | [Other.IsA](other.md)

---
