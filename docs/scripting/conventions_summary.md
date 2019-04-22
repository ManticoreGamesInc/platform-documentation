## Casing

Element | Styling
--- | ---
Classes | PascalCase
Functions | PascalCase
Enums | PascalCase
Properties | camelCase
Variables | camelCase
Constants | LOUD_SNAKE_CASE

### Casing Calls

Casing | Example | Dot or Colon
--- | --- | ---
PascalCase -> UPPER_CASE | Enum.ENUM_ENTRY | Dot
PascalCase -> PascalCase | Class.StaticFunction() | Dot
camelCase -> camelCase | instance.property | Dot
camelCase -> PascalCase | instance:MemberFunction() | Colon

Note: Properties are used instead of getters/setters only when that element has a getter _and_ setter.

## Examples

Generic Example:

```lua
--[[
    Files start with a descriptive multi-line comment
]]--

-- Imports go next
local DogClass = require('DogClass')

-- Function are PascalCase
function GiveDog(player)

    -- Local variables use camelCase, classes use PascalCase
    local doggo = DogClass.New()

    -- Properties are camelCase, constants are UPPER_CASE
    doggo.color = Colors.BROWN

    -- Member functions are called with a ':' (while static functions, see above, are called with a '.')
    doggo:AttachToPlayer(player, PlayerSockets.RIGHT_ANKLE)
end

-- Event subscriptions are located at the end of the file
Game.onPlayerJoined:Connect(GiveDog)
```

Real example:

```lua
--[[
    When a player collides with a coin, give them the coin as a resource and remove the coin from the world
]]

-- Handle picking up a coin
function HandleOverlap(trigger, player)
    -- Check that the object colliding with the trigger is a player
    if (player ~= nil and player:IsA("Player")) then
        -- If so, increment the 'Manticoin' resource count for that player
        player:AddResource("Manticoin", 1)
        -- Destroy the object in the scene so nobody else can pick it up
        trigger.parent:Destroy()
    end
end

-- Whenever an object collides with the coin's trigger, run this function
trigger.onBeginOverlap:Connect(HandleOverlap)
```