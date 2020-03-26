---
id: examples
name: Examples and Snippets
title: Examples and Snippets
tags:
    - Misc
---

# Examples and Snippets

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

## Events

Core uses events for a variety of state changes that can happen in a game. Events appear as properties on several objects. By connecting a function to the desired event, scripts can listen and act on them. Events allow two separate scripts to communicate, without the need to reference each other directly and can also be used to communicate between scripts.

### `Connect()`

To hook up your function to an event, you have to call `Connect(function YourFunction, [...])` to register it. Now it will be called every time the event is fired.

Example:

```lua
function OnPlayerDamaged(player, dmg)
    print("Player " .. player.name .. " took " .. dmg.amount .. " damage. New health = " .. player.hitPoints)
end

function OnPlayerJoined(player)
    player.damagedEvent:Connect(OnPlayerDamaged)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

Connects the `OnPlayerDamaged` function to the `damagedEvent` event on all players who join the game. Now every time a player takes damage, `OnPlayerDamaged` will be called.

`Connect()` also returns an `EventListener` which can be used to disconnect from the event or check if the event is still connected via the `isConnected` property. It also accepts any number of additional arguments after the listener function, those arguments will be provided after the event's own parameters.

### `Disconnect()`

Pretty simple, you just call `Disconnect()` on the returned `EventListener` to disconnect a listener from its event, so it will no longer be called when the event is fired.

Example:

```lua
local damagedEventListener

function OnPlayerJoined(player)
    damagedEventListener = player.damagedEvent:Connect(OnPlayerDamaged)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)

function OnDestroyed(obj)
    if damagedEventListener then
        damagedEventListener:Disconnect()
        damagedEventListener = nil
    end
end

script.destroyEvent:Connect(OnDestroyed)
```

### `Broadcast()`

If your script runs on a server, you can broadcast game-changing information to your players. In this example the `OnExecute` function was connected to an ability objects `executeEvent`. It adds a few checks to using an ability, a bandage in this case.

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

Both error and success cases get communicated back to the client via `BroadcastToPlayer`. If you want to do the reverse, to update a server side stored value from a player script, you'd use `BroadcastToServer` instead.

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

## World

### `World.GetRootObject()`

There is a parent CoreObject for the entire hierarchy. Although not visible in the user interface, it's accessible with the World.GetRootObject() class function. This example walks the whole hierarchy tree (depth first) and prints the name+type of each Core Object.

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
    OBJECT_TO_HIDE.visibility = Visibility.FORCE_ON
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

## `Game`

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
    local playersInRange = Game.FindPlayersInCylinder(script:GetWorldPosition(), 500, {includeTeams = {1, 2, 3, 4}})

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

## Needed

* What isn't represented here? Let us know!
* To add more, enter the details in the form [here](https://forms.gle/br8ZjanQGU2LkBvPA).
