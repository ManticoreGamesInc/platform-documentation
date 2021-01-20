---
id: object
name: Object
title: Object
tags:
    - API
---

# API: Object

## Description

At a high level, Core Lua types can be divided into two groups: data structures and Objects. Data structures are owned by Lua, while Objects are owned by the engine and could be destroyed while still referenced by Lua. Any such object will inherit from this type. These include CoreObject, Player and Projectile.

## API

### Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `serverUserData` | `table` | (server only) -- Table in which users can store any data they want on the server. | Read-Write |
| `clientUserData` | `table` | (client only) -- Table in which users can store any data they want on the client. | Read-Write |

### Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `Object.IsValid(Object object)` | `bool` | Returns true if object is still a valid Object, or false if it has been destroyed. Also returns false if passed a nil value or something that's not an Object, such as a Vector3 or a string. | None |

## Examples

### `IsValid`

The example below shows the importance of using `Object.IsValid()` instead of a simple nil check (i.e. `if object then`). An object can be in a situation where it's invalid, but not yet nil. This can happen if a script is retaining a reference to it or it began the destroy process but hasn't completed it yet.

In this example, the script has a cube child that it finds with the `GetChildren()` call. It then prints information about the cube as it progresses through the steps of being destroyed and its variable reference cleared.

```lua
local CUBE = script:GetChildren()[1]

function PrintCubeInfo()
    print(".:.:. Information about CUBE object .:.:.")

    if CUBE then
        print("CUBE is NOT nil")
    else
        print("CUBE is nil")
    end

    if Object.IsValid(CUBE) then
        print("CUBE is valid")
    else
        print("CUBE is NOT valid")
    end

    local childrenCount = #script:GetChildren()
    print("Number of children of this script: " .. tostring(childrenCount))
    print("")
end

PrintCubeInfo()

-- The cube is destroyed, but we still have a variable pointing to it.
CUBE:Destroy()

PrintCubeInfo()

-- Variable reference is cleared, releasing the cube.
CUBE = nil

PrintCubeInfo()
```

### `clientUserData`

In this example, multiple copies of the same script are placed into the scene. At startup, they search for each other and build a follow chain. The last script that can't find another script to follow is set to follow the local player. As the player moves around the chain of objects follows along in a smooth motion. The `clientUserData` property is leveraged in building the chain of object references.

For this to work all scripts should be in a client context. In order to visualize the effect, objects (e.g. a Cubes) can be added as children of the scripts.

As the name implies, `clientUserData` is a non-networked property on the client only.

```lua
local allScripts = World.FindObjectsByName(script.name)

for _, otherScript in ipairs(allScripts) do
    if otherScript ~= script
    and otherScript.clientUserData.target == nil then
        script.clientUserData.target = otherScript
        break
    end
end

if script.clientUserData.target == nil then
    script.clientUserData.target = Game.GetLocalPlayer()
end

local velocity = Vector3.ZERO
local DRAG = 0.96
local ACCELERATION = 0.5

function Tick()
    if not script.clientUserData.target then return end

    local myPos = script:GetWorldPosition()

    myPos = myPos + velocity
    velocity = velocity * DRAG

    local targetPos = script.clientUserData.target:GetWorldPosition()
    local direction = (targetPos - myPos):GetNormalized()
    velocity = velocity + direction * ACCELERATION

    script:SetWorldPosition(myPos)
end
```

### `serverUserData`

In this example we are trying to figure out which player was the first to join the game and promote them with some gameplay advantage. That's easy for the first player joining, but because players can join and leave at any moment, the first player to join might leave, at which point we need to promote the next (oldest) player. To accomplish this, we keep count of how many players have joined and save that number onto each player's `serverUserData`--a kind of waiting list.

As the name implies, `serverUserData` is a non-networked property on the server only.

```lua
local primaryPlayer = nil
local joinCounter = 0

function OnPlayerJoined(player)
    joinCounter = joinCounter + 1
    -- Save the waiting number onto the player itself
    player.serverUserData.joinNumber = joinCounter
end

function PromotePlayer(player)
    -- TODO: Give some gameplay advantage or leadership ability
    print("PROMOTING: " .. player.name)
end

function Tick()
    if (not Object.IsValid(primaryPlayer)) then
        -- Find the oldest player
        local oldestPlayer = nil
        local oldestJoinNumber = 999999

        local allConnectedPlayers = Game.GetPlayers()

        for _, player in ipairs(allConnectedPlayers) do
            local joinNumber = player.serverUserData.joinNumber
            if joinNumber < oldestJoinNumber then
                oldestJoinNumber = joinNumber
                oldestPlayer = player
            end
        end

        -- If we found a player, promote them
        if oldestPlayer then
            primaryPlayer = oldestPlayer

            PromotePlayer(oldestPlayer)
        end
    end
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```
