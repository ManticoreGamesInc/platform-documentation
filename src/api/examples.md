---
id: examples
name: Examples and Snippets
title: Examples and Snippets
tags:
    - Misc
---

# Examples and Snippets

## Contexts

In Core, contexts are like folders and exist in one of two states: networked and non-networked. You can nest multiple contexts but only the outermost one has any effect. Inside of it, every child context acts like a folder.

When a script spawns an object, it inherits the script's context, even if it is somewhere else in the hierarchy. This means that a script in a server context can never spawn objects that clients can see or interact with.

There are five types of contexts, **Client Context**, **Non-Networked**, **Static Context**, **Server Context** and **Networked**.

### Overview

|                    | **Default (Non-Networked)** | **Networked**        | **Client Context** | **Server Context** | **Static Context** |
| ------------------ | ----------------------------| ---------------------| -------------------| -------------------| -------------------|
| Objects can change | No                          | Yes (only by server) | Yes                | Yes                | No                 |
| Collision          | Yes                         | Yes                  | No                 | No                 | Yes                |
| Objects exist on   | Client and Server           | Client and Server    | Client             | Server             | Client and Server  |
| Scripts run on     | Server                      | Server               | Client             | Server             | Client and Server  |

### Default (Non-Networked)

- Cannot change.
- Can have collision.
- Seen by server and client.
- Scripts run on the server only.

### Networked

- Can be changed by the server.
- Clients will see those changes.
- Scripts run on the server only.

### Client Context

- Objects can change.
- Objects will block any cameras unless explicitly set otherwise.
- Scripts can access "Default" or "Networked" scripts because they occupy a place in the hierarchy.
- Scripts run on the client only.

### Server Context

- Objects do not have collision.
- Objects inside get removed from the client-side copy of the game sent to players.
- Provides a safeguard for creators if they want to conceal game logic.
- Scripts run on the server only.

### Static Context

- Almost like the default state (non-networked).
- Scripts can spawn objects inside a static context.
- Scripts run on both the server and the client.
- Useful for things reproduced easily on the client and server with minimal data (procedurally generated maps).
    - Send a single networked value to synchronize the server and clientsâ€™ random number generators.
    - Saves hundreds of transforms being sent from the server to every client.

!!! warning "Beware of desync issues!"
    Performing any operations from a static context that might diverge during server/client execution of a script will almost certainly cause desync issues.
    Static scripts are run independently on the server and all clients so you should avoid performing any script actions that can exhibit different behavior depending on the machine. Specifically, avoid any logic that is conditional on:
    - Server-only or client-only objects.
    - Random number generators with different seeds.
    - Logic based around local `time()`.

## CoreDebug

### Class Functions

- **CoreDebug.DrawLine**
- **CoreDebug.DrawBox**
- **CoreDebug.DrawSphere**

Core contains several useful functions for drawing in the 3d world, that are intended for use when debugging. If you are trying to visualize values in a 3d world,

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")

local myProjectile = Projectile.Spawn(propCubeTemplate,
    Vector3.New(500, 0, 200), -- starting position
    Vector3.New(0, 1, 1))     -- direction
myProjectile.speed = 500
myProjectile.lifeSpan = 3
myProjectile.gravityScale = 0.25


-- This function will draw some debug graphics around the projectile ever 1/10 second:
Task.Spawn(function()
    while Object.IsValid(myProjectile) do
        local pos = myProjectile:GetWorldPosition();
        CoreDebug.DrawSphere(pos , 50, {
            duration = 2,
            color = Color.GREEN
        })

        CoreDebug.DrawLine(pos, pos  + myProjectile:GetWorldTransform():GetForwardVector() * 50, {
            duration = 2,
            color = Color.WHITE,
            thickness = 3
        })

        CoreDebug.DrawBox(pos, Vector3.New(50), {
            duration = 2,
            color = Color.BLUE,
            thickness = 3
        })

        Task.Wait(0.1)
    end
end)
```

## Damage

### `Damage.New([Number amount])`

In this example players take 50 damage whenever they press 'D'.

```lua
function OnBindingPressed(player, action)
    if (action == "ability_extra_32") then --The 'D' key
        local dmg = Damage.New(50)
        player:ApplyDamage(dmg)
    end
end

function OnPlayerJoined(player)
    player.bindingPressedEvent:Connect(OnBindingPressed)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

### `GetHitResult()`

This example listens to the player's `damagedEvent` and takes a closer look at the [link]HitResult object. This object is most commonly generated as a result of shooting a player with a weapon.

```lua
function OnPlayerDamaged(player, dmg)
    local hitResult = dmg:GetHitResult()
    if hitResult then
        print(player.name .. " was hit on the " .. hitResult.socketName)
    end
end

function OnPlayerJoined(player)
    player.damagedEvent:Connect(OnPlayerDamaged)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

### `SetHitResult(HitResult)`

This example spawns a custom [link]Projectile and is not a result of using a Weapon. When the projectile impacts a player, a custom damage is created, including copying over the Projectile's HitResult.

```lua
local projectileBodyTemplate = script:GetCustomProperty("ProjectileTemplate")

function OnProjectileImpact(projectile, other, hitResult)
    if other:IsA("Player") then
        local dmg = Damage.New(25)
        dmg:SetHitResult(hitResult)
        dmg.reason = DamageReason.NPC
        other:ApplyDamage(dmg)
    end
end

function ShootAtPlayer(player)
    local startPos = script:GetWorldPosition()
    local playerPos = player:GetWorldPosition()
    local direction = playerPos - startPos
    local projectile = Projectile.Spawn(projectileBodyTemplate, startPos, direction)
    projectile.speed = 4000
    projectile.impactEvent:Connect(OnProjectileImpact)
end
```

### `amount`

While Damage amount can be set when constructing the Damage object (e.g. Damage.New(10)), you may want to create filtering functions that modify the damage depending on game conditions. In this example, players have a shield resource that prevents damage until the shield runs out. Instead of calling player:ApplyDamage() directly, the DamagePlayerAdvanced() function is called.

```lua
function DamagePlayerAdvanced(player, dmg)
    local shieldAmount = player:GetResource("Shield")
    if (shieldAmount > 0 and dmg.amount > 0) then
        if shieldAmount >= dmg.amount then
            player:RemoveResource("Shield", CoreMath.Round(dmg.amount))
            dmg.amount = 0

        elseif dmg.amount > shieldAmount then
            player:SetResource("Shield", 0)
            dmg.amount = dmg.amount - shieldAmount
        end
    end
    player:ApplyDamage(dmg)
end
```

### `reason`

The damage `reason` can be used to specify the source of the damage and is useful, for example, when attributing score based on kills. In this example, players take 1 damage per second when they are within 20 meters of the center of the map. If another part of the game listens to the Player's diedEvent, it would be able to tell the difference between players being killed by the environment as opposed to killed by another player.

```lua
function Tick()
    Task.Wait(1)
    for _,player in ipairs(Game.GetPlayers()) do
        local position = player:GetWorldPosition()
        if position.size <= 2000 then
            local dmg = Damage.New(1)
            dmg.reason = DamageReason.MAP
            player:ApplyDamage(dmg)
        end
    end
end

function OnPlayerDied(player, dmg)
    if dmg.reason == DamageReason.MAP then
        print("Player " .. player.name .. " was killed by the environment.")
    end
end

function OnPlayerJoined(player)
    player.diedEvent:Connect(OnPlayerDied)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

### `sourceAbility`

In this example, knowing the source of the damage was an ability allows complex rules, such as magic resistance.

```lua
function OnPlayerDamaged(player, dmg)
    if Object.IsValid(dmg.sourceAbility) then
        local magicResist = player:GetResource("MagicResist")
        if (magicResist > 0) then
            local amount = dmg.amount
            local newDmgAmount = amount / magicResist
            -- Heal back some of the lost hitPoints due to magic resist
            local newHitPoints = player.hitPoints + (amount - newDmgAmount)
            newHitPoints = CoreMath.Clamp(newHitPoints, 0, player.maxHitPoints)
            player.hitPoints = newHitPoints
        end
    end
end

function OnPlayerJoined(player)
    player.damagedEvent:Connect(OnPlayerDamaged)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

### `sourcePlayer`

In this example, the source player scores a point for their team each time they get a kill.

```lua
function OnPlayerDied(player, dmg)
    if Object.IsValid(dmg.sourcePlayer) then
        print(player.name .. " was killed by " .. dmg.sourcePlayer.name)

        Game.IncreaseTeamScore(dmg.sourcePlayer.team, 1)
    else
        print(player.name .. " died from an unknown source")
    end
end

function OnPlayerJoined(player)
    player.diedEvent:Connect(OnPlayerDied)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

## Equipment

### `equippedEvent` / `unequippedEvent`

Usually equipment are attached one at a time. However, in some cases you may want multiple equipment to behave as a single unit, such as a pair of boxing gloves. This example shows how to have a secondary equipment piece that attaches and detaches alongside a primary piece. It's not enough to listen only to the `equippedEvent`, the `unequippedEvent` must also be mirrored because in some games the equipment may be dropped or put away in the inventory. This script expects to be the child of the primary equipment, with the secondary equipment as its sibling.

```lua
local primaryEquipment = script.parent
local secondaryEquipment = primaryEquipment:FindDescendantByType("Equipment")
local secondaryDefaultTransform = secondaryEquipment:GetTransform()

function OnEquipped(equipment, player)
    secondaryEquipment:Equip(player)
end

function OnUnequipped(equipment, player)
    secondaryEquipment:Unequip()
    secondaryEquipment.parent = primaryEquipment
    secondaryEquipment:SetTransform(secondaryDefaultTransform)
end

primaryEquipment.equippedEvent:Connect(OnEquipped)
primaryEquipment.unequippedEvent:Connect(OnUnequipped)

```

### `Equip(Player)`

This example shows how players can be given default equipment when they join a game.

```lua
local EQUIPMENT_TEMPLATE = script:GetCustomProperty("EquipmentTemplate")

function OnPlayerJoined(player)
    local equipment = World.SpawnAsset(EQUIPMENT_TEMPLATE)
    equipment:Equip(player)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

### `Unequip()`

In this example, when a player dies all equipment they have is unequipped and dropped to the ground.

```lua
function DropToGround(equipment)
    equipment:Unequip()
    -- The pickup trigger needs to be re-enabled (if there is one)
    local pickupTrigger = equipment:FindDescendantByType("Trigger")

    if pickupTrigger then
        pickupTrigger.collision = Collision.FORCE_ON
    end
    -- Move it to the ground
    local rayStart = equipment:GetWorldPosition()
    local rayEnd = rayStart + Vector3.UP * -500
    local hitResult = World.Raycast(rayStart, rayEnd, {ignorePlayers = true})

    if hitResult then
        local dropPos = hitResult:GetImpactPosition() + Vector3.UP * 40
        equipment:SetWorldPosition(dropPos)
    end
end

function OnPlayerDied(player)
    for _, equipment in ipairs(player:GetEquipment()) do
        DropToGround()
    end
end

function OnPlayerJoined(player)
    player.diedEvent:Connect(OnPlayerDied)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

### `AddAbility(Ability)`

One of the primary roles of equipment is to contain several abilities. Those abilities are automatically added/removed from the player when they equip/unequip the item. This example shows how an equipment can be spawned and then procedurally assembled with different abilities depending on RNG.

```lua
local EQUIPMENT = script.parent
local ABILITY_TEMPLATE_1 = script:GetCustomProperty("Ability1")
local ABILITY_TEMPLATE_2 = script:GetCustomProperty("Ability2")
local ABILITY_TEMPLATE_3 = script:GetCustomProperty("Ability3")

function Add(abilityTemplate)
    local newAbility = World.SpawnAsset(abilityTemplate, {parent = EQUIPMENT})
    EQUIPMENT:AddAbility(newAbility)
end

local permutation = math.random(3)

if permutation == 1 then
    Add(ABILITY_TEMPLATE_1)
    Add(ABILITY_TEMPLATE_2)
elseif permutation == 2 then
    Add(ABILITY_TEMPLATE_1)
    Add(ABILITY_TEMPLATE_3)
else
    Add(ABILITY_TEMPLATE_2)
    Add(ABILITY_TEMPLATE_3)
end

for i,ability in ipairs(EQUIPMENT:GetAbilities()) do
    print("Ability " .. i .. " = " .. ability.name)
end
```

### `GetAbilities()`

Weapons are a specialized type of Equipment that have lots of built-in functionality, including two abilities that are usually included: One for attacking and the second one for reloading. In this example, a cosmetic part of a weapon is hidden after the attack happens and is enabled again after it reloads. This could be used, for instance, in a rocket launcher or a crossbow. The script should be a descendant of a `Weapon`. It works best if under a Client Context and the "ObjectToHide" custom property must be hooked up.

```lua
local WEAPON = script:FindAncestorByType('Weapon')
local ATTACK_ABILITY = WEAPON:GetAbilities()[1]
local RELOAD_ABILITY = WEAPON:GetAbilities()[2]
local OBJECT_TO_HIDE = script:GetCustomProperty("ObjectToHide"):WaitForObject()

function onExecuteAttack()
    OBJECT_TO_HIDE.visibility = Visibility.FORCE_OFF
end

ATTACK_ABILITY.executeEvent:Connect(onExecuteAttack)

function onExecuteReload()
    OBJECT_TO_HIDE.visibility = Visibility.INHERIT
end

RELOAD_ABILITY.executeEvent:Connect(onExecuteReload)
```

### `socket`

The socket is the attachment point on the player where the equipment will be placed. In this example, the socket property is used for comparing between the new equipment and any previous ones. If there's a competition for the same socket then the old equipment is dropped. This script expects to be placed as a child of the equipment and the equipment's default "Pickup Trigger" property should be cleared, as that behavior is re-implemented in the `OnInteracted()` function.

```lua
local EQUIPMENT = script.parent
local TRIGGER = script.parent:FindDescendantByType("Trigger")

function Drop(equipment)
    equipment:Unequip()
    -- The pickup trigger needs to be re-enabled (if there is one)
    local pickupTrigger = equipment:FindDescendantByType("Trigger")

    if pickupTrigger then
        pickupTrigger.collision = Collision.FORCE_ON
    end
end

function OnEquipped(equipment, player)
    for _, e in ipairs(player:GetEquipment()) do
        if e ~= equipment and e.socket == equipment.socket then
            Drop(e)
        end
    end
end

function OnInteracted(trigger, player)
    TRIGGER.collision = Collision.FORCE_OFF
    EQUIPMENT:Equip(player)
end

EQUIPMENT.equippedEvent:Connect(OnEquipped)
TRIGGER.interactedEvent:Connect(OnInteracted)
```

### `owner`

In this example, a weapon has a healing mechanic, where the player gains 2 hit points each time they shoot an enemy player.

```lua
function OnTargetImpactedEvent(weapon, impactData)
    if impactData.other and impactData.other:IsA("Player") then
        weapon.owner.hitPoints = weapon.owner.hitPoints + 2
    end
end

script.parent.targetImpactedEvent:Connect(OnTargetImpactedEvent)
```

## Event

### `Connect(function eventListener, [...])`

Core uses events for a variety of built-in state changes that can happen in a game. Events appear as properties on several objects. By connecting a function to the desired event, scripts can listen and act on them. In this example, both `Game.playerJoinedEvent` and `player.damagedEvent` are connected to. The `OnPlayerDamaged()` function will be called each time a player takes damage. Any number of extra parameters can be added when connecting and those values will be passed back to the listening function.

```lua
function OnPlayerDamaged(player, dmg, joinTime)
    local elapsedTime = time() - joinTime
    print("Player " .. player.name .. " took " .. dmg.amount .. " damage after joining the game for " .. elapsedTime .. " seconds.")
end

function OnPlayerJoined(player)
    -- Passing extra float parameter
    player.damagedEvent:Connect(OnPlayerDamaged, time())
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

## EventListener

### `Disconnect()` / `isConnected`

When `Connect()` is called, an `EventListener` structure is returned. In some situations it's good to save the listener in order to disconnect from the event later. In the following example, we are listening for the local player gaining or losing resources. However, if this script is destroyed for some reason, then it will be hanging in memory due to the event connection. In this case it's important to `Disconnect()` or a small memory leak is created. This script presumes to be in a Client Context.

```lua
function OnResourceChanged(player, resName, resValue)
    print("Resource " .. resName .. " = " .. resValue)
end

local resourceChangedListener = nil

function OnPlayerJoined(player)
    if player == Game.GetLocalPlayer() then
        resourceChangedListener = player.resourceChangedEvent:Connect(OnResourceChanged)
    end
end

if Game.GetLocalPlayer() then
    OnPlayerJoined(Game.GetLocalPlayer())
else
    Game.playerJoinedEvent:Connect(OnPlayerJoined)
end

function OnDestroyed(obj)
    if resourceChangedListener and resourceChangedListener.isConnected then
        resourceChangedListener:Disconnect()
        resourceChangedListener = nil
    end
end

script.destroyEvent:Connect(OnDestroyed)
```

## Events

### `Events.Connect(string eventName, function eventListener, [...])` / `Events.Broadcast(string eventName, [...])`

The `Events` namespace allows two separate scripts to communicate without the need to reference each other directly. In this example, two scripts communicate through a custom "GameStateChanged" event. The first one has the beginnings of a state machine and broadcasts the event each time the state changes. The second script listens for that specific event. This is a non-networked message.

```lua
-- Primary script that drives the state machine
local currentState = ""

function SetState(newState)
    currentState = newState
    Events.Broadcast("GameStateChanged", newState)
end

function Tick(deltaTime)
    SetState("Lobby")
    Task.Wait(1)
    SetState("Playing")
    Task.Wait(3)
end
```

```lua
-- A separate script that listens to event changes
function OnStateChanged(newState)
    print("New State = " .. newState)
end

Events.Connect("GameStateChanged", OnStateChanged)
```

### `Events.ConnectForPlayer(string eventName, function eventListener, [...])` / `Events.BroadcastToServer(string eventName, [...])`

This event connection allows the server to listen for broadcasts that originate from clients. In this example, two scripts communicate over the network. The first one is in a Server Context and the second one is in a Client Context. The client cand send input data to the server, in this case their cursor's position.

```lua
-- Server script
function OnPlayerInputData(player, data)
    print("Player " .. player.name .. " sent  data = " .. tostring(data))
end

Events.ConnectForPlayer("CursorPosition", OnPlayerInputData)
```

```lua
-- Client script
UI.SetCursorVisible(true)

function Tick(deltaTime)
    local cursorPos = UI.GetCursorPosition()
    Events.BroadcastToServer("CursorPosition", cursorPos)
    Task.Wait(0.25)
end
```

### `Events.BroadcastToAllPlayers(string eventName, [...])`

This event connection allows the server to send a message to all players. In this example, two scripts communicate over the network. The first one is on the server as child of a Trigger and the second one is in a Client Context. The server is authoritative over the state of the flag being captured and listens for overlaps on the Trigger. When a new team captures the flag a message is sent to all clients with information about who captured and what team they belong to.

```lua
-- Server script
local teamHasFlag = 0

function OnBeginOverlap(trigger, other)
    if other:IsA("Player") and other.team ~= teamHasFlag then
        teamHasFlag = other.team

        local resultCode, errorMsg = Events.BroadcastToAllPlayers("FlagCaptured", other.name, other.team)
        print("Server sent FlagCaptured event. Result Code = " .. resultCode .. ", error message = " .. errorMsg)
    end
end

script.parent.beginOverlapEvent:Connect(OnBeginOverlap)
```

```lua
-- Client script
function OnFlagCaptured(playerName, playerTeam)
    local message = playerName .. " captured the flag for team " .. playerTeam

    UI.PrintToScreen(message, Color.MAGENTA)
    print(message)
end

Events.Connect("FlagCaptured", OnFlagCaptured)
```

Events.BroadcastToPlayer(Player player, string eventName, [...])

If your script runs on a server, you can broadcast game-changing information to your players. In this example, the OnExecute function was connected to an ability object's executeEvent. This bandage healing ability depends on a few conditions, such as bandages being available in the inventory and the player having actually lost any hit points. If one of the conditions is not true, the broadcast function is used for delivering a user interface message that only that player will see.

```lua
function OnExecute(ability)
    if ability.owner:GetResource("Bandages") <= 0 then
        Events.BroadcastToPlayer(ability.owner, "BannerSubMessage", "No Bandages to Apply")
        return
    end

    if ability.owner.hitPoints < ability.owner.maxHitPoints then
        ability.owner:ApplyDamage(Damage.New(-30))
        ability.owner:RemoveResource("Bandages", 1)
    else
        Events.BroadcastToPlayer(ability.owner, "BannerSubMessage", "Full Health")
    end
end

myAbility.executeEvent:Connect(OnExecute)
```

## Game

### `Game.playerJoinedEvent` / `Game.playerLeftEvent`

Events that fire when players join or leave the game. Both server and client scripts detect these events. In the following example teams are kept balanced at a ratio of 1 to 2. E.g. if there are 6 players two of them will be on team 1 and the other four will be on team 2.

```lua
local BALANCE_RATIO = 1 / 2
local playerCount = 0
local team1Count = 0
local team2Count = 0

function OnPlayerJoined(player)
    player.team = NextTeam()
end

function OnPlayerLeft(player)
    playerCount = 0
    team1Count = 0
    team2Count = 0

    local allPlayers = Game.GetPlayers()
    for _,p in ipairs(allPlayers) do
        if p ~= player then
            p.team = NextTeam()
        end
    end
end

function NextTeam()
    local team = 1

    if playerCount == 0 then
        team1Count = 1
    elseif team2Count == 0 then
        team2Count = 1
        team = 2
    else
        local ratio = team1Count / team2Count
        if ratio < BALANCE_RATIO then
            team1Count = team1Count + 1
        else
            team2Count = team2Count + 1
            team = 2
        end
    end

    playerCount = playerCount + 1
    return team
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
Game.playerLeftEvent:Connect(OnPlayerLeft)
```

### `Game.roundStartEvent`

Several functions and events in the `Game` namespace are convenient for controlling the flow of a game. In this example, the game requires two players to join. It begins in a lobby state and transitions to a playing state when there are enough players.

```lua
local gameState = "LOBBY"

print("Waiting for 2 players to join...")

function OnRoundStart()
    gameState = "PLAYING"
    print("New round starting...")
end

Game.roundStartEvent:Connect(OnRoundStart)

function Tick()
    if gameState == "LOBBY" then
        -- The condition for starting a round
        local playerCount = #Game.GetPlayers()

        if playerCount >= 2 then
            Game.StartRound()
        end
    end
end
```

### `Game.roundEndEvent`

Several operations need to be made when rounds start and end. In this example, when the game ends it transitions to a "round ended" state for three seconds, then respawns all players to spawn points. The advantage of using events is that the different scripts can be separated from each other to improve organization of the project. The condition for ending the round is set here as one team reaching 5 points and can be located in one script. Meanwhile the various outcomes/cleanups can be broken up into different scripts in a way that makes the most sense per game, all listening to the `roundEndEvent`.

```lua
local gameState = "PLAYING"

function OnRoundEnd()
    gameState = "END"

    print("Round ended. Team " .. winningTeam .. " won!")

    -- Waits for 3 seconds then continues
    Task.Wait(3)

    -- Respawn all the players
    local allPlayers = Game.GetPlayers()

    for _,player in ipairs(allPlayers) do
        player:Respawn()
    end

    Game.ResetTeamScores()
    gameState = "LOBBY"
end

Game.roundEndEvent:Connect(OnRoundEnd)

function Tick()
    if gameState == "PLAYING" then
        local scoreObjective = 5

        if Game.GetTeamScore(1) == scoreObjective then
            winningTeam = 1
            Game.EndRound()
        elseif Game.GetTeamScore(2) == scoreObjective then
            winningTeam = 2
            Game.EndRound()
        end
    end
end
```

### `Game.teamScoreChangedEvent`

In this example, when a player jumps their team gains 1 point and when they crouch their team loses 1 point. The `OnTeamScoreChanged` function is connected to the event and prints the new score to the Event Log each time they change. We're going to use `Game.IncreaseTeamScore(Integer team, Integer scoreChange)` and `Game.DecreaseTeamScore(Integer team, Integer scoreChange)` to manipulate the scores.

```lua
function OnTeamScoreChanged(team)
    local score = Game.GetTeamScore(team)
    print("Score changed for team " .. team .. ", new value = " .. score)
end

Game.teamScoreChangedEvent:Connect(OnTeamScoreChanged)

function HandlePlayerJumped(player)
    Game.IncreaseTeamScore(player.team, 1)
end

function HandlePlayerCrouched(player)
    Game.DecreaseTeamScore(player.team, 1)
end

local playersJumping = {}
local playersCrouching = {}

function Tick()
    local allPlayers = Game.GetPlayers()
    for _, player in ipairs(allPlayers) do
        -- Jump
        if player.isJumping and player.isJumping ~= playersJumping[player] then
            HandlePlayerJumped(player)
        end
        playersJumping[player] = player.isJumping

        -- Crouch
        if player.isCrouching and not player.isJumping and player.isCrouching ~= playersCrouching[player] then
            HandlePlayerCrouched(player)
        end
        playersCrouching[player] = player.isCrouching
    end
end
```

### `Game.GetLocalPlayer()`

This function can only be called in a client script, as the server does not have a local player. This example prints the names of all players to the upper-left corner of the screen. The local player appears in green, while other player names appear blue. To test this example, place the script under a Client Context. From the point of view of each player, name colors appear different. That's because on each computer the local player is different.

```lua
function Tick()
    local allPlayers = Game.GetPlayers()
    for _, player in ipairs(allPlayers) do
        if player == Game.GetLocalPlayer() then
            UI.PrintToScreen(player.name, Color.GREEN)
        else
            UI.PrintToScreen(player.name, Color.BLUE)
        end
    end
    Task.Wait(3)
end
```

### `Game.GetPlayers([table parameters])`

This function is commonly used without any options. However, it can be very powerful and computationally efficient to pass a table of optional parameters, getting exactly the list of players that are needed for a certain condition. In this example, when the round ends it prints the number of alive players on team 1, as well as the number of dead players on team 2.

```lua
function OnRoundEnd()
    local playersAlive = Game.GetPlayers({ignoreDead = true, includeTeams = 1})
    local playersDead = Game.GetPlayers({ignoreLiving = true, includeTeams = 2})

    print(#playersAlive .. " players on team 1 are still alive.")
    print(#playersDead .. " players on team 2 are dead.")
end

Game.roundEndEvent:Connect(OnRoundEnd)
```

### `Game.FindNearestPlayer(Vector3 position, [table parameters])`

In this example, the player who is closest to the script's position is made twice as big. All other players are set to regular size.

```lua
function Tick()
    local allPlayers = Game.GetPlayers()
    local nearestPlayer = Game.FindNearestPlayer(script:GetWorldPosition(), {ignoreDead = true})

    for _, player in ipairs(allPlayers) do
        if player == nearestPlayer then
            player:SetWorldScale(Vector3.ONE * 2)
        else
            player:SetWorldScale(Vector3.ONE)
        end
    end
    Task.Wait(1)
end
```

### `Game.FindPlayersInCylinder(Vector3 position, Number radius, [table parameters])`

Searches for players in a vertically-infinite cylindrical volume. In this example, all players 5 meters away from the script object are pushed upwards. The search is setup to affect players on teams 1, 2, 3 and 4.

```lua
function Tick()
    local pos = script:GetWorldPosition()
    local playersInRange = Game.FindPlayersInCylinder(pos, 500, {includeTeams = {1, 2, 3, 4}})

    for _, player in ipairs(playersInRange) do
        local vel = player:GetVelocity()
        vel = vel + Vector3.UP * 250
        player:SetVelocity(vel)
    end
    Task.Wait(0.1)
end
```

### `Game.FindPlayersInSphere(Vector3 position, Number radius, [table parameters])`

Similar to `FindPlayersInCylinder()`, but the volume of a sphere is considered in the search instead. Also note that the player's center is at the pelvis. The moment that point exits the sphere area the effect ends, as the extent of their collision capsules is not taken into account for these searches.

```lua
function Tick()
    local playersInRange = Game.FindPlayersInSphere(script:GetWorldPosition(), 500)

    for _, player in ipairs(playersInRange) do
        local vel = player:GetVelocity()
        vel = vel + Vector3.UP * 250
        player:SetVelocity(vel)
    end
    Task.Wait(0.1)
end
```

### `Game.StartRound()` / `Game.EndRound()`

In this example, when one of the teams reaches a score of 10 they win the round. Five seconds later a new round starts.

```lua
local roundCount = 1
local roundRestarting = false

function OnTeamScoreChanged(team)
    local score = Game.GetTeamScore(team)

    if score >= 10 and not roundRestarting then
        Game.EndRound()
        print("Team " .. team .. " wins!")

        roundRestarting = true
        print("5...")
        Task.Wait(1)
        print("4...")
        Task.Wait(1)
        print("3...")
        Task.Wait(1)
        print("2...")
        Task.Wait(1)
        print("1...")
        Task.Wait(1)
        Game.ResetTeamScores()
        Game.StartRound()
        roundCount = roundCount + 1
        roundRestarting = false
        print("Starting new round")
    end
end

Game.teamScoreChangedEvent:Connect(OnTeamScoreChanged)
```

### `Game.GetTeamScore(Integer team)`

This example checks the score for all four teams and prints them to the screen. Note: Other than in preview mode, the scores will only appear on screen if the script is placed inside a Client Context.

```lua
function Tick()
    local teamA = Game.GetTeamScore(1)
    local teamB = Game.GetTeamScore(2)
    local teamC = Game.GetTeamScore(3)
    local teamD = Game.GetTeamScore(4)
    UI.PrintToScreen("Team A: " .. teamA)
    UI.PrintToScreen("Team B: " .. teamB)
    UI.PrintToScreen("Team C: " .. teamC)
    UI.PrintToScreen("Team D: " .. teamD)
    Task.Wait(2.98)
end
```

### `Game.SetTeamScore(Integer team, Integer score)`

Team scores don't have to represent things such as kills or points -- they can be used for keeping track of and displaying abstract gameplay state. In this example, score for each team is used to represent how many players of that team are within 8 meters of the script.

```lua
function Tick()
    local pos = script:GetWorldPosition()

    for team = 1, 4 do
        local teamPlayers = Game.FindPlayersInCylinder(pos, 800, {includeTeams = team})
        Game.SetTeamScore(team, #teamPlayers)
    end

    Task.Wait(0.25)
end
```

### `Game.ResetTeamScores()`

In this example, when the round ends team scores are evaluated to figure out which one is the highest, then all scores are reset.

```lua
function OnRoundEnd()
    -- Figure out which team has the best score
    local winningTeam = 0
    local bestScore = -1
    for i = 1, 4 do
        local score = Game.GetTeamScore(i)
        if score > bestScore then
            winningTeam = i
            bestScore = score
        end
    end

    print("Round ended. Team " .. winningTeam .." Resetting scores.")
    Game.ResetTeamScores()
end

Game.roundEndEvent:Connect(OnRoundEnd)
```

## HitResult

### `GetImpactPosition()` / `GetImpactNormal()`

This example shows the power of `World.Raycast()` which returns data in the form of a `HitResult`. The physics calculation starts from the center of the camera and shoots forward. If the player is looking at something, then a reflection vector is calculated as if a shot rococheted from the surface. Debug information is drawn about the ray, the impact point and the reflection. This script must be placed under a Client Context and works best if the scene has objects or terrain.

```lua
function Tick()
    local player = Game.GetLocalPlayer()

    local rayStart = player:GetViewWorldPosition()
    local cameraForward = player:GetViewWorldRotation() * Vector3.FORWARD
    local rayEnd = rayStart + cameraForward * 10000

    local hitResult = World.Raycast(rayStart, rayEnd, {ignorePlayers = true})

    if hitResult then
        local hitPos = hitResult:GetImpactPosition()
        local normal = hitResult:GetImpactNormal()
        local mirror = cameraForward - 2 * (cameraForward .. normal) * normal
        -- The green line is the impact normal
        CoreDebug.DrawLine(hitPos, hitPos + normal * 100, {thickness = 3, color = Color.GREEN, duration = 0.03})
        -- The blue line connects the camera to the impact point
        CoreDebug.DrawLine(rayStart, hitPos, {thickness = 2, color = Color.BLUE, duration = 0.03})
        -- The magenta line represents the reflection off the surface
        CoreDebug.DrawLine(hitPos, hitPos + mirror * 1000, {thickness = 2, color = Color.MAGENTA, duration = 0.03})
    end
end
```

### `GetTransform()`

HitResult is used by Weapons when attacks hit something. In this example, a custom template is spawned at the point of impact. The rotation of the new object is conveniently taken from the HitResult's transform data. This example assumes the script is placed as a child of a Weapon.

```lua
local impactTemplate = script:GetCustomProperty("ImpactObject")
local weapon = script.parent

function OnTargetImpacted(_, impactData)
    local hitResult = impactData:GetHitResult()

    if hitResult then
        local hitT = hitResult:GetTransform()
        World.SpawnAsset(impactTemplate, {position = hitT:GetPosition(), rotation = hitT:GetRotation()})
    end
end

weapon.targetImpactedEvent:Connect(OnTargetImpacted)
```

### `other` / `socketName`

HitResult is used by Weapons transmit data about the interaction. In this example, the `other` property is used in figuring out if the object hit was another player. If so, then the `socketName` property tells us exactly where on the player's body the hit occurred, allowing more detailed gameplay systems.

```lua
local weapon = script.parent

function OnTargetImpacted(_, impactData)
    local hitResult = impactData:GetHitResult()

    if hitResult and hitResult.other and hitResult.other:IsA("Player") then
        local playerName = hitResult.other.name
        local socketName = hitResult.socketName
        print("Player " .. playerName .. " was hit in the " .. socketName)
    end
end

weapon.targetImpactedEvent:Connect(OnTargetImpacted)
```

## Player

### `TransferToGame(string)`

Sends a player to another game. The game ID can be obtained from the Core website, for example to transfer a player to Core Royale, we navigate to that game's page at `https://www.coregames.com/games/577d80/core-royale` and copy the last two parts of the URL `577d80/core-royale` as the game ID.

```lua
local trigger = script.parent

function OnBeginOverlap(theTrigger, player)
  -- The object's type must be checked because CoreObjects also overlap triggers
    if player:IsA("Player") then
        player:TransferToGame("577d80/core-royale")
    end
end

trigger.beginOverlapEvent:Connect(OnBeginOverlap)
```

### Events

#### `damagedEvent` / `diedEvent` / `respawnedEvent`

There are events that fire at most major points for a player during gameplay. This example shows how to receive an event for players being damaged, dying, and respawning, as well as how to make a player automatically respawn after dying.

One important thing to note - `player.damagedEvent` and `player.diedEvent` only execute on the server, so if you are writing a script that runs inside of a client context, it will not receive these events!

```lua
function OnPlayerDamage(player, damage)
    print("Player " .. player.name .. " just took " .. damage.amount .. " damage!")
end

function OnPlayerDied(player, damage)
    print("Player " .. player.name .. " has been killed!")

    -- Now, revive them after 2 seconds at a spawn point:
    Task.Wait(2)
    player:Respawn()
end

function OnPlayerRespawn(player)
    print("Player " .. player.name .. " is back!")
end

-- Set up listeners:
for _, p in pairs(Game.GetPlayers()) do
    p.damagedEvent:Connect(OnPlayerDamage)
    p.diedEvent:Connect(OnPlayerDied)
    p.respawnedEvent:Connect(OnPlayerRespawn)
end

player:ApplyDamage(Damage.New(25))
Task.Wait(1)
player:ApplyDamage(Damage.New(50))
Task.Wait(1)
player:ApplyDamage(Damage.New(100))
Task.Wait(2.1)
```

#### `bindingPressedEvent` / `bindingReleasedEvent`

Normally you can leave the Core engine to handle most of the player input. You don't need to explicitly listen to jump events, to make the player jump, for example. But sometimes it's useful to listen to keypress events directly, when creating more complicated interactions.

This sample uses the `bindingKeypressed` and `bindingKeyReleased` events to allow the player to sprint whenever the `"ability_extra_12"` keybind is held down. (Left-Shift by default)

```lua
local shiftKeyBinding = "ability_extra_12"
local baseSpeed = 640
local sprintingSpeed = 1280

function OnShiftPressed(player, bindingPressed)
    if bindingPressed == shiftKeyBinding then
        player.maxWalkSpeed = sprintingSpeed
    end
end

function OnShiftReleased(player, bindingReleased)
    if bindingReleased == shiftKeyBinding then
        player.maxWalkSpeed = baseSpeed
    end
end

function OnPlayerRespawn(player)
    print("Player " .. player.name .. " is back!")
end

-- Set up listeners:
for _,p in pairs(Game.GetPlayers()) do
    p.bindingPressedEvent:Connect(OnShiftPressed)
    p.bindingReleasedEvent:Connect(OnShiftReleased)
end
```

#### `resourceChangedEvent`

While scripting, you can assign "resources" to players. These are just integer values, accessed via a string key, that are tied to a player. They are useful for storing values about game-specific resources a player might have, such as coins collected, mana remaining, levels completed, puppies pet, etc.

You can manipulate these values via several methods on the player class, as well as registering for an event when they are changed.

This sample registeres a listener to ensure that values are in the [0-100] range, and demonstrates several examples of how to change the values.

```lua
local resource2 = "CoinsCollected"
local resource1 = "PuppiesSeen"

-- Make sure that resources never go outside the [0, 100] range:
function OnResourceChanged(player, resourceId, newValue)
    if newValue > 100 then player:SetResource(resourceId, 100) end
    if newValue < 0 then player:SetResource(resourceId, 0) end
end

player.resourceChangedEvent:Connect(OnResourceChanged)

player:SetResource(resource1, 5)
-- Player now has 5 "CoinsCollected"

player:AddResource(resource1, 15)
-- Player now has 20 "CoinsCollected".

player:AddResource(resource1, 500)
-- This should give us 520 "CoinsCollected", but our event listener limits it to 100.
print("Coins collected: " .. player:GetResource(resource1))

player:SetResource(resource2, 2)
-- Player now has 2 "PuppiesSeen", as well as still having 100 "CoinsCollected"

player:RemoveResource(resource1, 10)
-- Player now has 90 "CoinsCollected"

-- We can also get all the resources in one go as a table:
local resourceTable = player:GetResources()
for k, v in pairs(resourceTable) do
    print("Resource ["..k.."]: " .. v)
end

player:ClearResources()
-- All resources have been removed from the player
print("Coins collected: " .. player:GetResource(resource1))
print("Puppies seen: " .. player:GetResource(resource2))
```

## Projectile

### `Projectile.Spawn` / `Projectile.lifeSpanEndedEvent` / `Projectile.lifeSpan`

Like `CoreObjects`, Projectiles have a `lifeSpan` property, which is the maximum number of seconds a projectile can be kept around. Once that time is up, the projectile is automatically destroyed by the engine.

When projectiles reach the end of their lifespan, they trigger a `lifeSpanEndedEvent` event.  This event fires _before_ the projectile is destroyed, so it is still valid to reference it in the event handler.

In this example, we fire a projectile straight up, so its lifeSpan runs out before it collides with anything.  When it does, the lifeSpanEndedEvent fires.

```lua
-- A template of a basic cube, attached to the script as a custom property:
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")

-- Fire this projectile straight up so it doesn't hit anything:
local mySlowProjectile = Projectile.Spawn(propCubeTemplate,
Vector3.New(1000, 0, 200), -- starting position
Vector3.UP)                -- direction

mySlowProjectile.lifeSpan = 1
mySlowProjectile.lifeSpanEndedEvent:Connect(function(projectile)
    print("Projectile lifespan over")
end)

mySlowProjectile:SetVelocity(Vector3.New(0, 0, 1000))
```

### `Projectile.impactEvent`

When a projectile hits a surface, it triggers an `impactEvent`, which is given various information about exactly what collided with what, and where.

Specifically, the event receives a reference to the projectile that did the impacting, a reference to whatever object or player it hit, and a `hitResult` object that can be used to determine things like the position and angle of the collision.

A very common pattern is to use the `Object:IsA("Player")` function to determine if the projectile has hit a player or not.

In this example, the projectile will hit something and print out information about what it hit.

```lua
-- A template of a basic cube, attached to the script as a custom property:
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")

-- Fire this projectile straight down so it hits the ground:
local myProjectile = Projectile.Spawn(propCubeTemplate,
Vector3.New(1000, 0, 200), -- starting position
Vector3.New(0, 0, -1))     -- direction

myProjectile.impactEvent:Connect(function(projectile, other, hitresult)
    print("Hit object: " .. other.name .. " with an impact normal of " .. tostring(hitresult:GetImpactNormal()))
    if other:IsA("Player") then
        print("We hit player " .. other.name .. "!!!")
    end
end)
```

### `Projectile.homingTarget` / `Projectile.drag` / `Projectile.homingAcceleration`

Projectiles can be set to home in on targets, via the `homingTarget` property. This can be either a player or a CoreObject.

This example spawns an object in the world, and then fires a projectile to home in on it.

The `drag` and `homingAcceleration` properties affect how fast the homing projectile can change direction, and how fast it loses velocity due to air resistance.

```lua
-- A template of a basic cube, attached to the script as a custom property:
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")

local objectInWorld = World.SpawnAsset(propCubeTemplate)
objectInWorld:SetWorldPosition(Vector3.New(1000, 0, 0))


function ProjectileImpact(projectile, other, hitresult)
    print("Hit something! " .. other.name)
end

local objectHomingProjectile = Projectile.Spawn(propCubeTemplate,
    Vector3.New(1000, 1000, 1000), -- starting position
    Vector3.New(0, 0, 0))          -- direction
objectHomingProjectile.speed = 0
objectHomingProjectile.gravityScale = 0
objectHomingProjectile.homingTarget = objectInWorld
objectHomingProjectile.drag = 5
objectHomingProjectile.homingAcceleration = 5000
objectHomingProjectile.impactEvent:Connect(function(projectile, other, hitresult)
print("Hit something! " .. other.name)
end)
-- The projectile will hit home towards the target object, and print out a message when it hits.
```

### `Projectile.homingFailedEvent`

If a projectile has its `homingTarget` set, and then the target disappears for some reason, it will fire a `HomingFailedEvent`. This is usually because the CoreObject that the projectile is following was `Destroy`ed, or the player it was following logged out.

In this example, we spawn an object, fire a projectile at it, (and set the `homingTarget` property) and then immedietely remove the target, leaving the projectile to feel dejected and confused.

```lua
-- A template of a basic cube, attached to the script as a custom property:
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")

local objectInWorld = World.SpawnAsset(propCubeTemplate)
objectInWorld:SetWorldPosition(Vector3.New(1000, 0, 0))

local objectHomingProjectile = Projectile.Spawn(propCubeTemplate,
    Vector3.New(1000, 1000, 1000), -- starting position
    Vector3.New(0, 0, 0))          -- direction
objectHomingProjectile.speed = 0
objectHomingProjectile.gravityScale = 0
objectHomingProjectile.homingTarget = objectInWorld
objectHomingProjectile.drag = 5
objectHomingProjectile.homingAcceleration = 5000
objectHomingProjectile.homingFailedEvent:Connect(function (projectile)
print("Target lost!")
end)

Task.Wait(0.5)
objectInWorld:Destroy()
-- The event should fire now and the "target lost" message should be displayed.
```

### `Projectile.Destroy`

Sometimes you will want to remove a projectile from the game even if it hasn't hit any targets yet.  When this is the case, the `Destroy()` function does what you need - it does exactly what the name implies - the projectile is immedietely removed from the game and no events are generated.

We can test if an object still exists via the Object:IsValid() function. This can be useful because sometimes things other than program code can remove an object from our game.  (Existing for longer than the `lifeSpan`, or colliding with an object, in the case of projectiles.)

```lua
-- A template of a basic cube, attached to the script as a custom property:
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")

-- Fire this projectile straight up, so it will be in the air for a while.
local myProjectile = Projectile.Spawn(propCubeTemplate,
    Vector3.New(1000, 0, 200), -- starting position
    Vector3.UP)      -- direction
myProjectile.speed = 50
myProjectile.gravityScale = 0
Task.Wait(1)
print("Is the projectile still around?  " .. tostring(Object.IsValid(myProjectile)))
-- The projectile is still there.
myProjectile:Destroy()
print("How about now?  " .. tostring(Object.IsValid(myProjectile)))
-- The projectile is no longer in the game.
```

### `Projectile.speed` / `Projectile.maxSpeed`

You can set the speed of a projectile directly, via the `speed` property. Note that this does not change the direction of a projectile - only how fast it is moving in whatever direction it is already pointing in.

You can also set a projectile's `maxSpeed` property, which clamps the speed to a given velocity.  This can be useful in situations where the projectile is homing or affected by gravity - you can ensure that the speed never gets above a particular velocity, no matter how long it has been falling/accelerating.

One important thing to note, is that `maxSpeed` is only checked at the END of the frame, so if you manually set the speed to something large, it will only be clamped after your script has executed and the game has updated with a new 'tick'.

```lua
-- A template of a basic cube, attached to the script as a custom property:
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")

-- Fire this projectile straight up, so it will be in the air for a while.
local myProjectile = Projectile.Spawn(propCubeTemplate,
Vector3.New(1000, 0, 200), -- starting position
Vector3.UP)                -- direction
myProjectile.speed = 100
myProjectile.maxSpeed = 50
myProjectile.gravityScale = 0
-- The projectile is still going at 100 speed.  Max Speed is only checked at the end of the frame.
print("This projectile's speed is " .. tostring(myProjectile.speed))

Task.Wait() -- So if we wait one frame...
print("This projectile's speed is " .. tostring(myProjectile.speed))
-- It should now be clamped down to the maximum speed.
```

### `Projectile.gravityScale` / `Projectile.bouncesRemaining` / `Projectile.bounciness` / `Projectile.shouldBounceOnPlayers`

By default, projectiles are destroyed when they impact a surface. If you set their `bouncesRemaining` though, whenever they hit a surface, they will lose one `bouncesRemaining` and ricochet off in a new direction. This can be used to simulate grenades, super balls, bouncing lasers, or similar. The amount of energy they lose (or gain!) from impact is controled via the `bounciness` property.

`gravityScale` can be used to change the trajectory of projectiles in flight. Setting it to 0 means that the projectiles are unaffected by gravity, and will simply fly in a straight line until they hit something. Setting it to greater than zero means that the projectile will arc downwards like a normal thrown object. And setting it to less than zero means the projectile will arc upwards like a helium balloon.

In this example, we fire several projectiles, with various properties.

```lua
-- A template of a basic cube, attached to the script as a custom property:
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")

function fireProjectile()
    local myProjectile = Projectile.Spawn(propCubeTemplate,
    Vector3.New(500, 0, 200), -- starting position
    Vector3.New(0, 1, 0))     -- direction
    myProjectile.speed = 500
    myProjectile.lifeSpan = 3
    return myProjectile
end

-- this projectile will just fire off in a straight line with no gravity.  It should never bounce.
local standardProjectile = fireProjectile()
standardProjectile.gravityScale = 0

-- this projectile will arc and hit the ground.
local arcingProjectile = fireProjectile()
arcingProjectile.gravityScale = 1

-- this projectile will arc upwards and fly off into the sky.
local floatingProjectile = fireProjectile()
floatingProjectile.gravityScale = -1

-- this projectile will arc further, because it has less gravity.
local furtherArcingProjectile = fireProjectile()
furtherArcingProjectile.gravityScale = 0.5

-- this projectile will arc and bounce up to three times.
local bouncingProjectile = fireProjectile()
bouncingProjectile.gravityScale = 0.5
bouncingProjectile.bouncesRemaining = 3

-- this projectile will bounce more times, but with less energy per bounce.
local lessBouncyProjectile = fireProjectile()
lessBouncyProjectile.gravityScale = 0.5
lessBouncyProjectile.bouncesRemaining = 5
lessBouncyProjectile.bounciness = 0.2
```

### `Projectile.piercesRemaining` / `Projectile.shouldDieOnImpact`

Projectiles have the `piercesRemaining` property, which controls how many times they penetrate objects and keep going.  In this sample, we spawn several walls and fire several projectiles at them, with different penetration numbers.

Projectiles also have a property that determines if they should be destroyed when they hit an object - `shouldDieOnImpact`.  One of the projectiles we spawn here does not die on impact!  So when it hits a wall, it simply stops and waits for its `lifeSpan` to run out.

```lua
-- A template of a basic cube, attached to the script as a custom property:
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")

function FirePiercingProjectile(pierceCount)
    local myProjectile = Projectile.Spawn(propCubeTemplate,
    Vector3.New(500, 0, 150 + pierceCount * 100), -- starting position
    Vector3.New(1, 0, 0))     -- direction
    myProjectile.speed = 1000
    myProjectile.lifeSpan = 3
    myProjectile.gravityScale = 0
    myProjectile.piercesRemaining = pierceCount
    return myProjectile
end

-- Make some walls for our projectiles to run into:
for i = 1, 8 do
    walls[i] = World.SpawnAsset(propCubeTemplate, {
    position = Vector3.New(500 + i * 500, 0, 250),
    scale = Vector3.New(1, 5, 5)
    })
end

-- this projectile will just fire off in a straight line with no gravity.  It should never bounce.
local Pierce_x1 = FirePiercingProjectile(0)

-- This projectile will pierce the first wall and impact the second.
local Pierce_x2 = FirePiercingProjectile(1)

-- This projectile will pierce the first two walls, and impact the third.
local Pierce_x3 = FirePiercingProjectile(2)

-- This projectile will hit the first wall, and then stop, because it is set not to die on impact.
local DontDieOnImpact = FirePiercingProjectile(0)
DontDieOnImpact.shouldDieOnImpact = false
```

### `Projectile.owner`

Projectiles have a property, `owner`, which stores data about who spawned the projectile.  This is populated automatically, if the projectile is generated from a weapon interaction.  Otherwise, we have to set it ourselves.

Projectiles will never impact their `owner`, or anyone on the `owner`'s team. They will just pass on through, and not trigger an `impactEvent`.

In this example, we fire several projectiles at the player, but set them to be owned by the player, so they are unhit.

```lua
-- A template of a basic cube, attached to the script as a custom property:
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")

function OnImpact(projectile, other, hitresult)
    --Count how many times each projectile hits the player:
    if other:IsA("Player") then
        print("Urk! I've been shot!")
    end
end

-- utility function for spawning projectiles aimed at the player
function FireAtPlayer(startPos, player)
    local direction = (player:GetWorldPosition() - startPos):GetNormalized()
    local myProjectile = Projectile.Spawn(propCubeTemplate,
    startPos,
    direction)
    myProjectile.speed = 1000
    myProjectile.impactEvent:Connect(OnImpact)
    myProjectile.gravityScale = 0
    myProjectile.owner = player
end

-- Fire the barrage!
for i = -4, 4 do
    FireAtPlayer(Vector3.New(1000, 250 * i, 500), targetPlayer)
end

-- Player will not be hit (and the hit messaage will never be printed) because
-- the projectiles are all owned by the player.
```

### `Projectile.GetWorldTransform` / `Projectile.GetWorldPosition` / `Projectile.GetVelocity` / `Projectile.SetVelocity`

We can get various information about a projectile's position and velocity via several functions. `GetWorldTransform()` and `GetWorldPosition()` functions can tell us where it is and where it is facing. `GetVelocity()` tells us where it is moving and how fast. And `SetVelocity()` allows us to change its direction in mid-flight.

In this sample, we'll fire some more projectiles at the player.  But we'll also give them a magic shield that reflects any projectiles that get too close!

```lua
-- A template of a basic cube, attached to the script as a custom property:
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")

-- utility function for spawning projectiles aimed at the player
function FireAtPlayer(startPos, player)
    local direction = (player:GetWorldPosition() - startPos):GetNormalized()
    local myProjectile = Projectile.Spawn(propCubeTemplate,
    startPos,
    direction)
    myProjectile.speed = 2000
    myProjectile.gravityScale = 0
    return myProjectile
end

local projectileList = {}
-- Fire the barrage!
for i = -4, 4 do
    projectileList[i] = FireAtPlayer(Vector3.New(1000, 250 * i, 500), targetPlayer)
end

local MagicShieldTask = Task.Spawn(function()
    while true do
        for k, projectile in pairs(projectileList) do
            local projectileToPlayer = targetPlayer:GetWorldPosition() - projectile:GetWorldPosition()
            -- if the projectile is within 500 units of the player...
            if projectileToPlayer.size < 200 then
                local t = projectile:GetWorldTransform()
                -- ... and is generally facing the player ...
                if projectileToPlayer .. t:GetForwardVector() > 0 then
                    -- then shoot it back where it came!
                    projectile:SetVelocity(projectile:GetVelocity() * -0.8)
                end
            end
            return
        end
        Task.Wait()
    end
end)
```

### `Projectile.capsuleLength` / `Projectile.capsuleRadius`

When Core performs collision checks (to see if a projectile has hit anything) it assumes the projectile is a _capsule._  That is, a cylinder with a hemisphere on each flat end.

We can change the shape of this capsule by modifying the length and radius of the cylinder. A length of 0 means we have a sphere.  (Because there is no space between the two hemispheres on the ends.)

This sample makes a few projectiles of varying shapes and sizes.

Note that this only changes the collision properties of the projectile!  The visual representation on screen will be unchanged.

By default, projectiles have a radius of 22, and length of 44.

```lua
-- A template of a basic cube, attached to the script as a custom property:
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")

-- Fire this projectile straight up, so it will be in the air for a while.
function FireProjectile()
    local myProjectile = Projectile.Spawn(propCubeTemplate,
        Vector3.New(1000, 0, 200), -- starting position
        Vector3.UP)                -- direction
    myProjectile.speed = 100
    myProjectile.gravityScale = 0
    return myProjectile
end

-- The default projectile is radius 22, and length 44.
local defaultProjectile = FireProjectile()

-- This projectile is very long but narrow.
local longThinProjectile = FireProjectile()
longThinProjectile.capsuleRadius = 10
longThinProjectile.capsuleLength = 100

-- This projectile is short and fat.
local shortFatProjectile = FireProjectile()
shortFatProjectile.capsuleRadius = 50
shortFatProjectile.capsuleLength = 20

-- This projectile's collision volume is a sphere.
local sphereProjectile = FireProjectile()
sphereProjectile.capsuleRadius = 40
sphereProjectile.capsuleLength = 0
```

### `Projectile.sourceAbility`

Projectiles have a field to report what ability spawned them. If the projectile is fired by a weapon, then the weapon automatically populates the sourceAbility property.  If you spawn projectiles manually via spawnProjectile, then you are responsible for populating it yourself.

Here is an example of a weapon script that tests if the projectiles came from an ability called "FlameThrower."  It is assumed that this is in a script that is a direct child of a weapon object.

```lua
function OnImpact(projectile, other, hitresult)
    if other:IsA("Player") then
        local damageScale = 1.0
        if projectile.sourceAbility ~= nil and projectile.sourceAbility.name == "FlameThrower" then
            local fireResistance = other:GetResource("fireResist")
            damageScale = damageScale * (1.0 - fireResistance)
            if (fireResistance > 0) then
                print("Damage reduced by fire resistance!")
            end
        end
        other:ApplyDamage(Damage.New(10 * damageScale))
    end
end

--Tell each projectile fired what to do when it hits something:
local weapon = script.parent
weapon.projectileSpawnedEvent:Connect(function(weapon, projectile)
    projectile.impactEvent:Connect(OnImpact)
end)
```

## Script

### `context`

With `context` two scripts can communicate directly by calling on each other's functions and properties. Notice that '.' is used instead of ':' when accessing context functions. In the following example, the first script is placed directly in the hierarchy and the second script is placed inside a template of some sort. When a new player joins, the first script spawns a copy of the template and tells it about the new player. The template then follows the player around as they move.

```lua
-- Script directly in hierarchy
local followTemplate = script:GetCustomProperty("FollowTemplate")

Game.playerJoinedEvent:Connect(function(player)
    local obj = World.SpawnAsset(followTemplate)
    -- Locate the script inside
    local followScript = obj:FindDescendantByType("Script")
    -- Call the context function
    followScript.context.SetTarget(player)
end)
```

```lua
-- Script located inside a template. The 'targetPlayer' property and the 'SetTarget()' function can be accessed externally through the context.
targetPlayer = nil

function SetTarget(player)
    targetPlayer = player
    script:FindTemplateRoot():Follow(player, 400, 300)
end
```

## Storage

The following examples assume the hierarchy has a GameSettings object with **"Enable Player Storage**" turned on.

### `Storage.GetPlayerData(Player)`

This example detects when a player joins the game and fetches their XP and level from storage. Those properties are moved to the player's resources for use by other gameplay systems.

```lua
function OnPlayerJoined(player)
    local data = Storage.GetPlayerData(player)
    -- In case it's the first time for this player we use default values 0 and 1
    local xp = data["xp"] or 0
    local level = data["level"] or 1
    -- Each time they join they gain 1 XP. Stop and play the game again to test that this value keeps going up
    xp = xp + 1
    player:SetResource("xp", xp)
    player:SetResource("level", level)
    print("Player " .. player.name .. " joined with Level " .. level .. " and XP " .. xp)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

### `Storage.SetPlayerData(Player, table)`

This example detects when a player gains XP or level and saves the new values to storage.

```lua
function OnResourceChanged(player, resName, resValue)
    if (resName == "xp" or resName == "level") then
        local data = Storage.GetPlayerData(player)
        data[resName] = resValue
        local resultCode,errorMessage = Storage.SetPlayerData(player, data)
    end
end

function OnPlayerJoined(player)
    player.resourceChangedEvent:Connect(OnResourceChanged)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

## Triggers

In the following examples it's assumed the script is placed as a child of a trigger in the hierarchy.

### `beginOverlapEvent`

In this example, players die when they walk over the trigger.

```lua
local trigger = script.parent

function OnBeginOverlap(theTrigger, player)
    -- The object's type must be checked because CoreObjects also overlap triggers, but we only call :Die() on players.
    if player:IsA("Player") then
        player:Die()
    end
end

trigger.beginOverlapEvent:Connect(OnBeginOverlap)
```

### `endOverlapEvent`

As players enter/exit the trigger the script keeps a table with all currently overlapping players.

```lua
local trigger = script.parent
local activePlayers = {}

function OnBeginOverlap(theTrigger, player)
    if player:IsA("Player") then
        table.insert(activePlayers, player)
        print("The trigger contains " .. #activePlayers .. " players")
    end
end

function OnEndOverlap(theTrigger, player)
    if (not player:IsA("Player")) then return end

    for i,p in ipairs(activePlayers) do
        if (p == player) then
            table.remove(activePlayers, i)
            break
        end
    end
    print("The trigger contains " .. #activePlayers .. " players")
end

trigger.beginOverlapEvent:Connect(OnBeginOverlap)
trigger.endOverlapEvent:Connect(OnEndOverlap)
```

### `interactedEvent`

In this example, the trigger has the "Interactable" checkbox turned on. When the player walks up to the trigger and interacts with the <kbd>F</kbd> key they are propelled into the air.

```lua
local trigger = script.parent
trigger.isInteractable = true

function OnInteracted(theTrigger, player)
    -- In this case there is no need to check the type with IsA("Player") because only players can trigger the interaction.
    player:SetVelocity(Vector3.New(0, 0, 10000))
end

trigger.interactedEvent:Connect(OnInteracted)
```

### `IsOverlapping(CoreObject)`

In this example, a physics sphere is placed in the scene. Every second the sphere is in the trigger, team 1 scores a point.

```lua
local trigger = script.parent
local sphere = World.FindObjectByName("PhysicsSphere")
local teamToReward = 1

while true do
    Task.Wait(1)
    if (sphere and trigger:IsOverlapping(sphere)) then
        Game.IncreaseTeamScore(teamToReward, 1)
        print("Team " .. teamToReward .. " score = " .. Game.GetTeamScore(teamToReward))
    end
end
```

### `IsOverlapping(Player)`

In this example, players score points for their teams for each second they are inside the trigger.

```lua
local trigger = script.parent

while true do
    Task.Wait(1)
    local allPlayers = Game.GetPlayers()

    for _, player in ipairs(allPlayers) do
        if (trigger:IsOverlapping(player)) then
            local teamToReward = player.team
            Game.IncreaseTeamScore(teamToReward, 1)
            print("Team " .. teamToReward .. " score = " .. Game.GetTeamScore(teamToReward))
        end
    end
end
```

### `GetOverlappingObjects()`

In this example, any objects that overlap with the trigger are pushed upwards until they no longer overlap. If the trigger overlaps with non-networked objects this will throw an error.

```lua
local trigger = script.parent

function Tick()
    local objects = trigger:GetOverlappingObjects()

    for _, obj in pairs(objects) do
        local pos = obj:GetWorldPosition()
        pos = pos + Vector3.New(0, 0, 10)
        obj:SetWorldPosition(pos)
    end
end
```

### `isInteractable`

In this example, the trigger has a 4 second "cooldown" after it is interacted.

```lua
local trigger = script.parent
trigger.isInteractable = true

function OnInteracted(theTrigger, player)
    print("INTERACTED!")
    trigger.isInteractable = false
    Task.Wait(4)
    trigger.isInteractable = true
end

trigger.interactedEvent:Connect(OnInteracted)
```

### `interactionLabel`

In this example, the trigger moves left and right and changes its label dynamically. To use this as a sliding door place a door asset as a child of the trigger.

```lua
local trigger = script.parent
local slideDuration = 2
local startPos = trigger:GetWorldPosition()
local isOpen = false

trigger.isInteractable = true

function SetState(newState)
    isOpen = newState

    if isOpen then
        trigger.interactionLabel = "Close"
        trigger:MoveTo(startPos, slideDuration)
    else
        trigger.interactionLabel = "Open"
        trigger:MoveTo(startPos + Vector3.New(0, 150, 0), slideDuration)
    end
end

SetState(true)

function OnInteracted(theTrigger, player)
    SetState(not isOpen)
end

trigger.interactedEvent:Connect(OnInteracted)
```

### `team`

In this example, players score points when they enter a trigger that belongs to the enemy team.

```lua
local trigger = script.parent

function OnBeginOverlap(theTrigger, player)
    local teamToReward = player.team

    if (player:IsA("Player") and teamToReward ~= trigger.team) then
        Game.IncreaseTeamScore(teamToReward, 1)
        print("Team " .. teamToReward .. " score = " .. Game.GetTeamScore(teamToReward))
    end
end

trigger.beginOverlapEvent:Connect(OnBeginOverlap)
```

### `isTeamCollisionEnabled`

In this example, when a player interacts with a trigger it joins their team and they can no longer interact with it, but enemies can.

```lua
local trigger = script.parent
trigger.isInteractable = true

function OnInteracted(theTrigger, player)
    trigger.team = player.team
    trigger.isTeamCollisionEnabled = false
    print("The objective now belongs to team " .. player.team)
end

trigger.interactedEvent:Connect(OnInteracted)
```

### `isEnemyCollisionEnabled`

In this example, when a player interacts with a trigger it joins their team and enemies can no longer interact with it. Each time they interact their team gains a point. When the last player to interact with the trigger is killed the trigger returns to it's original neutral form.

```lua
local trigger = script.parent
trigger.isInteractable = true
trigger.team = 0
local onDiedListener = nil

function OnPlayerDied(player, dmg)
    onDiedListener:Disconnect()
    trigger.team = 0
    trigger.isEnemyCollisionEnabled = true
    print("The objective is neutral again.")
end

function OnInteracted(theTrigger, player)
    local teamToReward = player.team

    if (teamToReward == trigger.team) then
        Game.IncreaseTeamScore(teamToReward, 1)
        print("Team " .. teamToReward .. " score = " .. Game.GetTeamScore(teamToReward))
    else
        trigger.team = teamToReward
        trigger.isEnemyCollisionEnabled = false
        print("The objective now belongs to team " .. player.team)
    end

    if onDiedListener then
        onDiedListener:Disconnect()
    end

    onDiedListener = player.diedEvent:Connect(OnPlayerDied)
end

trigger.interactedEvent:Connect(OnInteracted)
```

## Vector3

### `Vector3.Lerp`

Vector3.Lerp is a function for finding a spot part way between two vectors. When combined with a tick function or loop, we can use it to smoothly animate something moving between two points.

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")
local myObject = World.SpawnAsset(propCubeTemplate)

local startPosition = Vector3.New(500, -500, 500)
local endPosition = Vector3.New(500, 500, 500)

myObject:SetWorldPosition(startPosition)

for i = 1, 30 do
    myObject:SetWorldPosition(Vector3.Lerp(startPosition, endPosition, i/300))
    ut.EXPECT_VEC3_EQUAL(Vector3.Lerp(startPosition, endPosition, i/300), (endPosition - startPosition) * i / 300 + startPosition, "LERP should equal our hand-calculated value")
    Task.Wait()
end

print("Tah dah!")
```

### `Vector3.New`

There are several different ways to create Vector3s. You can directly specify the x, y, z coordinates, or you can feed it a Vector2 or Vector4 to pull coordinates from, or you can just give it a single number to apply to x y and z.

```lua
-- Makes a vector3 where x=1, y=2, z=3:
local myVector3_0 = Vector3.New(1, 2, 3)

-- Another way of making a vector3 where x=1, y=2, z=3:
local myVec2 = Vector2.New(1, 2)
local myVector3_1 = Vector3.New(myVec2, 3)

-- Yet another way of making a vector3 where x=1, y=2, z=3:
local myVec4 = Vector4.New(1, 2, 3, 4)
local myVector3_2 = Vector3.New(myVec4)

-- Makes a vector3 where x=6, y=6, z=6:
local myVector3_3 = Vector3.New(6)

-- We can also make new Vector3s based on existing ones:
local copyOfVector3_3 = Vector3.New(myVector3_3)
```

### `Vector3.x` / `Vector3.y` / `Vector3.z`

After creating a `Vector3`, we can read or write to its x, y, z components directly.

```lua
local myVector3 = Vector3.New(1, 2, 3)

print(myVector3.x) -- 1
print(myVector3.y) -- 2
print(myVector3.z) -- 3

-- We can also modify them directly, to create a new vector:
myVector3.x = 4
myVector3.y = 5
myVector3.z = 6

print(myVector3)
-- myVector3 now equals (4, 5, 6)
```

### `Vector3.size` / `Vector3.sizeSquared`

A lot of vector math requires knowing the magntude of a vector - i. e. if you think of the vector as a point, how far away is it from (0, 0, 0)?

In Lua, you can get that value via the `size` property.  There is also the `sizeSquared` property, which is sometimes useful as a slightly faster option.  (Typically used in distance comparisons, since if `a.size < b.size`, then `a.sizeSquared < b.sizeSquared`.)

This sample creates a healing aura around an object, that heals the player more, the closer they are to it.

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")
local healNode = World.SpawnAsset(propCubeTemplate, {
    position = Vector3.New(500, 0, 0)
})

local healRadius = 1000

-- The heal node will pulse 50 times, 5 times per second:
for i = 1, 50 do
    for k, player in pairs(Game.GetPlayers()) do
        local p = player:GetWorldPosition()
        local n = healNode:GetWorldPosition()
        local distanceSquared = (p - n).sizeSquared
        if distanceSquared < healRadius * healRadius then
            local distance = (p - n).size
            -- Apply a negative damage to heal the player:
            local healAmount = 5 * (1 - distance / healRadius)
            player:ApplyDamage(Damage.New(-healAmount))
            print("Player is being healed for " .. tostring(healAmount))

            ut.EXPECT_NEARLY_EQUAL(healAmount, 2.4482, "Heal amount should be about right")
            ut.EXPECT_NEARLY_EQUAL(distance, math.sqrt(distanceSquared), "distance squared")
        end
    end
    Task.Wait(0.2)
end
```

### `Vector3.ZERO` / `Vector3.ONE` / `Vector3.FORWARD` / `Vector3.UP` / `Vector3.RIGHT`

The Vector3 namespace includes a small selection of constants, for commonly-used Vector3 values.

```lua
print(Vector3.ZERO) -- (0, 0, 0)

print(Vector3.ONE) -- (1, 1, 1)

print(Vector3.FORWARD) -- (1, 0, 0)

print(Vector3.RIGHT) -- (0, 1, 0)

print(Vector3.UP) -- (0, 0, 1)
```

### `Vector3+Vector3` / `Vector3+Number` / `Vector3-Vector3` / `Vector3-Number` / `Vector3*Vector3` / `Vector3*Number` / `Number*Vector3` / `Vector3/Vector3` / `Vector3/Number` / `-Vector3`

Most arithmatic operators will work on Vector3s in straightforward ways.

```lua
local a = Vector3.New(1, 2, 3)
local b = Vector3.New(4, 5, 6)

-- Adding and subtracting vectors is the same as adding or subtracting each of their compoents.
print(a + b) -- (5, 7, 9)
print(b - a) -- (3, 3, 3)

-- You can also add or subtract a number and a vector - it will just add or subtract that
-- number from each component.
print(a + 2) -- 3, 4, 5

print(b - 2) -- 2, 3, 4

-- Multiplication and Division work the same way:
print (a * b) -- 4, 10, 18
print (a * 2) -- 2, 4, 6
print (2 * a) -- 2, 4, 6

print(a / b) -- (0.25, 0.4, 0.3)
print(b / 4) -- (1, 1.25, 1.5)

-- You can also just negate a vector:

print(-a) -- -1, -2, -3
```

### `Vector3.GetNormalized()` / `Vector3(..)` / `Vector3(^)`

A Normalized vector is a vector who's magnitude (size) is equal to 1.0.  Vector3 variables have a `GetNormalized()` function, which returns this vaule.  It is equivalent to dividing the vector by its own size, and is useful in linear algebra.

Dot Proudct and Cross Product are two other common linear algebra operations, which can be represented in Lua byh the `..` and `^` operators respectively.

Here is a sample that uses these operations to determine if an object is aimed within 15 degrees of a player.

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")
local myObject = World.SpawnAsset(propCubeTemplate, {
    position = Vector3.New(500, 0, 250)
})

fred = Quaternion.New(Vector3.UP, 360)
    myObject:RotateContinuous(Rotation.New(0, 0, 40))

    for i = 1, 10, 0.05 do
        local playerPos = player:GetWorldPosition()
        local objectPos = myObject:GetWorldPosition()
        local objectAim = myObject:GetWorldTransform():GetForwardVector()
        local objToPlayer = (playerPos - objectPos):GetNormalized()

        -- draw a line so we can see where it is "looking"
        CoreDebug.DrawLine(objectPos, objectPos + objectAim * 1000, {duration = 0.05, thickness = 5, color = Color.Red })

        -- Is the object facing the player?  (And not 180 degrees the opposite direction?)
        -- When the vectors are normalized, (which these are), the dot product is equal to
        -- the cosin of the angle between the vectors.  Which means it will be positive,
        -- if the two vectors aren't more than 90 degrees apart.  This makes it a great way to check
        -- if something is "generally facing" something else!
        if (objToPlayer .. objectAim > 0) then
        -- Here we check if the player is actually within 15 degrees of the aim.
        -- we can do this, because if the input vectors are normalized (which again, these are),
        -- then the output vector has a magnitude equal to the sin of the angle between them.
        -- So this makes it a really easy way to check if a vector is within a certain angle
        -- of another vector.  (Especially if we combine it with the previous check to make sure
        -- they're facing the same direction!)
        if (objToPlayer ^ objectAim).size < math.sin(15) then
            print("I see you!")
        end
    end
    Task.Wait(0.05)
end
```

## World

### `World.GetRootObject()`

There is a parent CoreObject for the entire hierarchy. Although not visible in the user interface, it's accessible with the `World.GetRootObject()` class function. This example walks the whole hierarchy tree (depth first) and prints the name+type of each Core Object.

```lua
local worldRoot = World.GetRootObject()

function PrintAllNames(node)
    for _, child in ipairs(node:GetChildren()) do
        print(child.name .. " + " .. child.type)
        PrintAllNames(child)
    end
end

PrintAllNames(worldRoot)
```

### `World.FindObjectsByName(string)`

This example counts all the spawn points in the game for teams 1, 2 and 3, then prints how many belong to each team.

```lua
local team1Count = 0
local team2Count = 0
local team3Count = 0
local allSpawnPoints = World.FindObjectsByName("Spawn Point")

for _, point in ipairs(allSpawnPoints) do
    if point.team == 1 then
        team1Count = team1Count + 1
    elseif point.team == 2 then
        team2Count = team2Count + 1
    elseif point.team == 3 then
        team3Count = team3Count + 1
    end
end

print("Team 1 has " .. team1Count .. " spawn points.")
print("Team 2 has " .. team2Count .. " spawn points.")
print("Team 3 has " .. team2Count .. " spawn points.")
```

### `World.FindObjectsByType(string)`

This example searches the hierarchy for all UI Containers and hides them when the player presses the 'U' key. Useful when capturing video! For this to work, setup the script in a Client context.

```lua
function OnBindingPressed(player, binding)
    if binding == "ability_extra_26" then
        local containers = World.FindObjectsByType("UIContainer")
        for _, c in pairs(containers) do
            c.visibility = Visibility.FORCE_OFF
        end
    end
end

function OnPlayerJoined(player)
    player.bindingPressedEvent:Connect(OnBindingPressed)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

### `World.FindObjectByName(string)`

Returns only one object with the given name. This example searches the entire hierarchy for the default floor object and prints a warning if it's found.

```lua
local floorObject = World.FindObjectByName("Default Floor")
-- Protect against error if the floor is missing from the game
if floorObject then
    warn(" Don't forget to replace the default floor with something better!")
end
```

### `World.FindObjectById(string)`

Finds an object in the hierarchy based on it's unique ID. To find an object's ID, right-click them in the hierarchy and select "Copy MUID". An object's ID can also be obtained at runtime through the .id property. In this example we search for the default sky folder and print a warning if we find it.

```lua
local objectId = "8AD92A81CCE73D72:Default Sky"
local defaultSkyFolder = World.FindObjectById(objectId)

if defaultSkyFolder then
    warn(" The default sky is pretty good, but customizing the sky has a huge impact on your game's mood!")
end
```

### `World.SpawnAsset(string, [optional parameters])`

In this example, whenever a player dies, an explosion VFX template is spawned  in their place and their body is flown upwards. The SpawnAsset() function also returns a reference to the new object, which allows us to do any number of adjustments to it--in this case a custom life span. This example assumes an explosion template exists in the project and it was added as a custom property onto the script object.

```lua
local EXPLOSION_TEMPLATE = script:GetCustomProperty("ExplosionVFX")

function OnPlayerDied(player, dmg)
    local playerPos = player:GetWorldPosition()
    local explosionObject = World.SpawnAsset(EXPLOSION_TEMPLATE, {position = playerPos})
    explosionObject.lifeSpan = 3
    player:AddImpulse(Vector3.UP * 1000)
end

function OnPlayerJoined(player)
    player.diedEvent:Connect(OnPlayerDied)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

### `World.Raycast(Vector3 start, Vector3 end, [optional parameters])`

This example causes all players in the game to fly when they step off a ledge or jump. It does this by using the `Raycast()` function to measure each player's distance to the ground below them.

```lua
local GROUND_DISTANCE = script:GetCustomProperty("GroundDistance") or 200
local downV = Vector3.New(0, 0, -GROUND_DISTANCE - 103)

function Tick()
    for _, player in pairs(Game.GetPlayers()) do
        local playerPos = player:GetWorldPosition()
        local hitResult = World.Raycast(playerPos, playerPos + downV, {ignorePlayers = true})

        if (player.isFlying and hitResult) then
            player:ActivateWalking()
        elseif (not player.isFlying and not hitResult) then
            player:ActivateFlying()
        end
    end
    Task.Wait(0.1)
end
```

## WorldText

### `GetColor() / SetColor(Color)`

In this example, a WorldText object that is placed in the scene changes color gradually from white to black. The script expects to be a child of the WorldText. Notice that if you run this in multiplayer mode, the color changes will not be as smooth as in single-player preview. To fix that place the WorldText + Script hierarchy under a Client Context.

```lua
local nameTextObject = script.parent

function Tick(deltaTime)
    local c = nameTextObject:GetColor()

    if c.r < 0.03 then
        -- Start over from white (x3 so it stays on white for a bit longer)
        c = Color.WHITE * 3
    else
        c = Color.Lerp(c, Color.BLACK, deltaTime * 2)
    end

    nameTextObject:SetColor(c)
end
```

### `text`

Change the contents of a WorldText object with the `text` property. In this example, when a new player joins the game their name is written to the WorldText. It's also demonstrated that `<br>` can be used to insert line breaks. This script expects to be the child of a WorldText object that is placed in the scene.

```lua
local nameTextObject = script.parent

Game.playerJoinedEvent:Connect(function (player)
    nameTextObject.text = player.name .. "<br>has joined the game!<br>GLHF!"
end)
```

## Needed

* What isn't represented here? Let us know!
* To add more, enter the details in the form [here](https://forms.gle/br8ZjanQGU2LkBvPA).
