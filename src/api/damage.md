---
id: damage
name: Damage
title: Damage
tags:
    - API
---

# API: Damage

## Description

To damage a Player, you can simply write e.g.: `whichPlayer:ApplyDamage(Damage.New(10))`. Alternatively, create a Damage object and populate it with all the following properties to get full use out of the system:

## API

### Constructors

| Constructor Name | Return Type | Description | Tags |
| ----------- | ----------- | ----------- | ---- |
| `Damage.New([Number amount])` | `Damage` | Constructs a damage object with the given number, defaults to 0. | None |

### Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `amount` | `Number` | The numeric amount of damage to inflict. | Read-Write |
| `reason` | `DamageReason` | What is the context for this Damage? DamageReason.UNKNOWN (default value), DamageReason.COMBAT, DamageReason.FRIENDLY_FIRE, DamageReason.MAP, DamageReason.NPC. | Read-Write |
| `sourceAbility` | `Ability` | Reference to the Ability which caused the Damage. Setting this allows other systems to react to the damage event, e.g. a kill feed can show what killed a Player. | Read-Write |
| `sourcePlayer` | `Player` | Reference to the Player who caused the Damage. Setting this allows other systems to react to the damage event, e.g. a kill feed can show who killed a Player. | Read-Write |

### Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetHitResult()` | `HitResult` | Get the HitResult information if this damage was caused by a Projectile impact. | None |
| `SetHitResult(HitResult)` | `None` | Forward the HitResult information if this damage was caused by a Projectile impact. | None |

## Examples

### `New`

In this example players take 50 damage whenever they press 'D'.

```lua
function OnBindingPressed(player, action)
    if action == "ability_extra_32" then --The 'D' key
        local dmg = Damage.New(50)
        player:ApplyDamage(dmg)
    end
end

function OnPlayerJoined(player)
    player.bindingPressedEvent:Connect(OnBindingPressed)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

### `GetHitResult`

This example listens to the player's damagedEvent and takes a closer look at the HitResult object. This object is most commonly generated as a result of shooting a player with a weapon.

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

### `SetHitResult`

This example spawns a custom Projectile and is not a result of using a Weapon. When the projectile impacts a player, a custom damage is created, including copying over the Projectile's HitResult.

```lua
local projectileBodyTemplate = script:GetCustomProperty("ProjectileTemplate")

function OnProjectileImpact(projectile, other, hitResult)
    if other and other:IsA("Player") then
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
    if shieldAmount > 0 and dmg.amount > 0 then
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

The damage reason can be used to specify the source of the damage and is useful, for example, when attributing score based on kills. In this example, players take 1 damage per second when they are within 20 meters of the center of the map. If another part of the game listens to the Player's diedEvent, it would be able to tell the difference between players being killed by the environment as opposed to killed by another player.

```lua
function Tick()
    Task.Wait(1)
    for _, player in ipairs(Game.GetPlayers()) do
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
        if magicResist > 0 then
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
