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
-- camelCase local variables, PascalCase for classes and static functions (called with a '.')
local car = Car.New()
-- camelCase properties (called with a '.'), and UPPER_CASE constants
car.color = Colors.GREEN
-- PascalCase member functions (called with a ':')
car:Drive()
```

Real example (short):

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

Real example (long):

```lua

```