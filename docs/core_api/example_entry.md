# Activate

###### [Classes](core_api/raw_source) > [Ability](core_api/raw_source)

### Description

Activates an ability directly by simulating a button press

### Notes
!!! info
    Client-context only

### Syntax

`:activate()`

### Example

[Live example]()

```lua
--[[ Main.lua ]]--

-- Set up the sprint ability
function createSprintAbility(player)
    local sprint = game:SpawnAbility()
    sprint.name = "Sprint"
    sprint.owner = player
    -- ability specifics (animation, cast duration, etc.) would go here
end

-- Whenever a player joins the game, give them the sprint ability
game:GetPlayerJoinedEvent():Connect(createSprintAbility)


--[[ ActivateSprint.lua (in a client context) ]]--

-- This script makes players always run if they are in a given area
local sprintAreaPosition = Position.New(500, 200, 1400)
local sprintAreaRadius = 35

-- We need to constantly check if players are in the defined area
function tick()
    -- Check for players in the area
    local players = game:findPlayersInCylinder(sprintAreaPosition, sprintAreaRadius)
    -- If we found any players, get their sprint ability and activate it
    for i = 1,#players do
        local abilities = players[i].abilities
        for i = 1,#abilities do
            if abilities[i] ~= nil and abilities[i].name == "Sprint" then
                abilities[i]:activate()
                break  -- We've activated the sprint ability already, so we don't need to keep looking for it
            end
        end
    end
    -- This isn't super vital to gameplay, so let's only check once a second for performance
    wait(1)
end
```

### See Also

* [Game.ClientContext]() 
* [Classes.Ability]()
