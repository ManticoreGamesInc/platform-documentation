---
id: ability
name: Ability
title: Ability
tags:
    - API
---

# Ability

Abilities are CoreObjects that can be added to Players and guide the Player's animation in sync with the Ability's state machine. Spawn an Ability with `World.SpawnAsset()` or add an Ability as a child of an Equipment/Weapon to have it be assigned to the Player automatically when that item is equipped.

Abilities can be activated by association with an Action Binding. Their internal state machine flows through the phases: Ready, Cast, Execute, Recovery and Cooldown. An Ability begins in the Ready state and transitions to Cast when its Binding (e.g. Left mouse click) is activated by the owning player. It then automatically flows from Cast to Execute, then Recovery and finally Cooldown. At each of these state transitions it fires a corresponding event.

Only one ability can be active at a time. By default, activating an ability will interrupt the currently active ability. The `canBePrevented` and `preventsOtherAbilities` properties can be used to customize interruption rules for competing abilities.

If an ability is interrupted during the Cast phase, it will immediately reset to the Ready state. If an ability is interrupted during the Execute or Recovery phase, the ability will immediately transition to the Cooldown phase.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `isEnabled` | `boolean` | Turns an Ability on/off. It stays on the Player but is interrupted if `isEnabled` is set to `false` during an active Ability. True by default. | Read-Write |
| `canActivateWhileDead` | `boolean` | Indicates if the Ability can be used while the owning Player is dead. False by default. | Read-Only |
| `name` | `string` | The name of the Ability. | Read-Only |
| `actionBinding` | `string` | Which action binding will cause the Ability to activate. Possible values of the bindings are listed on the [Ability binding](../api/key_bindings.md) page. | Read-Only |
| `owner` | [`Player`](player.md) | Assigning an owner applies the Ability to that Player. | Read-Write |
| `castPhaseSettings` | [`AbilityPhaseSettings`](abilityphasesettings.md) | Config data for the Cast phase (see below). | Read-Only |
| `executePhaseSettings` | [`AbilityPhaseSettings`](abilityphasesettings.md) | Config data for the Execute phase. | Read-Only |
| `recoveryPhaseSettings` | [`AbilityPhaseSettings`](abilityphasesettings.md) | Config data for the Recovery phase. | Read-Only |
| `cooldownPhaseSettings` | [`AbilityPhaseSettings`](abilityphasesettings.md) | Config data for the Cooldown phase. | Read-Only |
| `animation` | `string` | Name of the animation the Player will play when the Ability is activated. Possible values: See [Ability Animation](../api/animations.md) for strings and other info. | Read-Only |
| `canBePrevented` | `boolean` | Used in conjunction with the phase property `preventsOtherAbilities` so multiple abilities on the same Player can block each other during specific phases. True by default. | Read-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `Activate()` | `None` | Activates an Ability as if the button had been pressed. | None |
| `Interrupt()` | `None` | Changes an Ability from Cast phase to Ready phase. If the Ability is in either Execute or Recovery phases it instead goes to Cooldown phase. | None |
| `AdvancePhase()` | `None` | Advances a currently active Ability from its current phase to the next phase. For example, an ability in the Cast phase will begin the Execute phase, an ability on cooldown will become ready, etc. | None |
| `GetCurrentPhase()` | [`AbilityPhase`](enums.md#abilityphase) | The current AbilityPhase for this Ability. These are returned as one of: AbilityPhase.READY, AbilityPhase.CAST, AbilityPhase.EXECUTE, AbilityPhase.RECOVERY and AbilityPhase.COOLDOWN. | None |
| `GetPhaseTimeRemaining()` | `number` | Seconds left in the current phase. | None |
| `GetTargetData()` | [`AbilityTarget`](abilitytarget.md) | Returns information about what the Player has targeted this phase. | None |
| `SetTargetData(AbilityTarget)` | `None` | Updates information about what the Player has targeted this phase. This can affect the execution of the Ability. | None |

## Events

| Event Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `readyEvent` | `Event<`[`Ability`](ability.md)`>` | Fired when the Ability becomes ready. In this phase it is possible to activate it again. | None |
| `castEvent` | `Event<`[`Ability`](ability.md)`>` | Fired when the Ability enters the Cast phase. | None |
| `executeEvent` | `Event<`[`Ability`](ability.md)`>` | Fired when the Ability enters Execute phase. | None |
| `recoveryEvent` | `Event<`[`Ability`](ability.md)`>` | Fired when the Ability enters Recovery. | None |
| `cooldownEvent` | `Event<`[`Ability`](ability.md)`>` | Fired when the Ability enters Cooldown. | None |
| `interruptedEvent` | `Event<`[`Ability`](ability.md)`>` | Fired when the Ability is interrupted. | None |
| `tickEvent` | `Event<`[`Ability`](ability.md) ability, number deltaTime`>` | Fired every tick while the Ability is active (isEnabled = true and phase is not ready). | None |

## Examples

Example using:

### `castEvent`

The Cast phase begins as soon as an ability is activated. By checking if the player casting the ability `isGrounded` we can create an effect that propels you upwards, but it doesn't work if you are already jumping or flying. We detect this is the `castEvent`, which is early enough for an `Interrupt()` to reset the ability.

```lua
local ability = script.parent

function OnCast(ability)
    if ability.owner.isGrounded then
        ability.owner:SetVelocity(Vector3.UP * 2000)
    else
        ability:Interrupt()
    end
end

ability.castEvent:Connect(OnCast)
```

See also: [CoreObject.parent](coreobject.md) | [Ability.owner](ability.md) | [Player.isGrounded](player.md) | [Vector3.UP](vector3.md) | [Event.Connect](event.md)

---

Example using:

### `cooldownEvent`

In this example, a fighting game has an "invincible" mechanic where player attacks are not interrupted while they have this effect. Some powerful attacks make the player invincible during the entire active cycle of the ability. The effect is gained at the beginning of the cast phase and is removed at the end of the recovery phase, before the cooldown begins. The resource system is used in keeping track of the invincibility effect.

```lua
local ability = script.parent

function OnCast(ability)
    ability.owner:AddResource("invincible", 1)
end

function OnCooldown(ability)
    ability.owner:RemoveResource("invincible", 1)
end

ability.castEvent:Connect(OnCast)
ability.cooldownEvent:Connect(OnCooldown)
```

See also: [CoreObject.parent](coreobject.md) | [Player.owner](player.md) | [Ability.castEvent](ability.md) | [Event.Connect](event.md)

---

Example using:

### `executeEvent`

Weapons implement lots of built-in gameplay that doesn't require any scripting, such as attack and reload abilities. However, they can be augmented with additional mechanics. In this example, a special sound effect is played when a weapon shoots while low on ammunition. The script expects to be a child of a weapon's "Shoot" ability.

```lua
local ability = script.parent
local weapon = script:FindAncestorByType('Weapon')
local lowAmmoSound = script:GetCustomProperty("LowAmmoSound")

local LOW_AMMO_PERCENTAGE = 0.2

function OnExecute(ability)
    if weapon.currentAmmo / weapon.maxAmmo <= LOW_AMMO_PERCENTAGE then
        World.SpawnAsset(lowAmmoSound, {position = weapon:GetWorldPosition()})
    end
end

ability.executeEvent:Connect(OnExecute)
```

See also: [CoreObject.parent](coreobject.md) | [Weapon.currentAmmo](weapon.md) | [World.SpawnAsset](world.md) | [Ability.executeEvent](ability.md) | [Event.Connect](event.md)

---

Example using:

### `interruptedEvent`

The `interruptedEvent` fires when an ability is going through it's activation process and `Interrupt()` is called on it, or if it becomes disabled. In this example, interruption is a key part of the game design, so a visual effect is spawned at the player's position to help communicate the interaction between players.

```lua
local ability = script.parent
local interruptedVfx = script:GetCustomProperty("InterruptedVfx")

function OnInterrupted(ability)
    if Object.IsValid(ability.owner) then
        World.SpawnAsset(interruptedVfx, {position = ability.owner:GetWorldPosition()})
    end
end

ability.interruptedEvent:Connect(OnInterrupted)
```

See also: [CoreObject.parent](coreobject.md) | [Object.IsValid](object.md) | [Ability.owner](ability.md) | [World.SpawnAsset](world.md) | [Player.GetWorldPosition](player.md) | [Event.Connect](event.md)

---

Example using:

### `readyEvent`

The Ready phase begins when an ability comes off cooldown and is "ready" to be used again. In this example, we create an invisibility effect that takes advantage of the `readyEvent`, leveraging the cooldown duration of the ability as a clock to determine when to make the player visible again.

```lua
local ability = script.parent

function OnExecute(ability)
    -- Hide the player
    ability.owner:SetVisibility(false)
end

function OnReady(ability)
    -- Show the player
    ability.owner:SetVisibility(true)
end

ability.readyEvent:Connect(OnReady)
ability.executeEvent:Connect(OnExecute)
```

See also: [CoreObject.parent](coreobject.md) | [Ability.owner](ability.md) | [Player.SetVisibility](player.md) | [Event.Connect](event.md)

---

Example using:

### `recoveryEvent`

The `recoveryEvent` marks the end of an ability's Execute phase and the beginning of its Recovery phase. In this example, a melee punch ability has a trigger that causes damage to enemies who overlap it. For it to work the trigger is only enabled for a brief moment, during the Execute phase.

```lua
local ability = script.parent
local trigger = script:GetCustomProperty("ImpactTrigger"):WaitForObject()
trigger.collision = Collision.FORCE_OFF

local DAMAGE_AMOUNT = 10

function OnExecute(ability)
    trigger.collision = Collision.FORCE_ON
end

function OnRecovery(ability)
    trigger.collision = Collision.FORCE_OFF
end

ability.executeEvent:Connect(OnExecute)
ability.recoveryEvent:Connect(OnRecovery)

function OnBeginOverlap(trigger, other)
    -- Only damage enemy players
    if other:IsA("Player") and other.team ~= ability.owner.team then
        other:ApplyDamage(Damage.New(DAMAGE_AMOUNT))
    end
end

trigger.beginOverlapEvent:Connect(OnBeginOverlap)
```

See also: [CoreObject.parent](coreobject.md) | [CoreObjectReference.WaitForObject](coreobjectreference.md) | [Ability.executeEvent](ability.md) | [Event.Connect](event.md) | [other.IsA](other.md) | [Player.team](player.md) | [Damage.New](damage.md) | [Trigger.beginOverlapEvent](trigger.md)

---

Example using:

### `tickEvent`

Abilities fire the `tickEvent` while they are active or on cooldown (not on Ready state). In this example, a piece of equipment carries several abilities, but we want to do a common update logic on all of them. Note: `Ability.tickEvent` works somewhat differently from a `Tick()` function - `tickEvent` is an actual event that just happens to fire once per tick. Each invocation of the callback runs on its own task. This means that, unlike `Tick()`, there is no guarantee that it will wait for the previous `tickEvent` to finish before starting the next one. This means you can't use things like `Task.Wait()` to add time between ticks!

```lua
local equipment = script.parent
local allAbilities = equipment:GetAbilities()

function OnTick(ability, deltaTime)
    print("Updating ability " .. ability.name)
end

for _, ability in ipairs(allAbilities) do
    ability.tickEvent:Connect(OnTick)
end
```

See also: [CoreObject.parent](coreobject.md) | [Equipment.GetAbilities](equipment.md) | [Event.Connect](event.md) | [CoreLua.print](coreluafunctions.md)

---

Example using:

### `Activate`

The Ability `Activate()` function is client-only, behaving as if the player had pressed the key binding. In order for a server gameplay decision to result in an ability activation, it must be communicated over the network somehow. In this example, a trigger overlap is representative of an arbitrary gameplay decision on the server. A broadcast message is sent to the client, who receives the event and activates the ability.

Server script:

```lua
local trigger = script.parent

trigger.beginOverlapEvent(function(trigger, other)
    if other:IsA("Player") then
        Events.BroadcastToPlayer(other, "SteppedOnObject")
    end
end)

--[[#description
    Client context script under the ability:
]]
local ability = script:FindAncestorByType("Ability")

function OnPlayAnimation()
    if ability.owner and ability.owner == Game.GetLocalPlayer() then
        ability:Activate()
    end
end

Events.Connect("SteppedOnObject", OnPlayAnimation)
```

See also: [CoreObject.parent](coreobject.md) | [Trigger.beginOverlapEvent](trigger.md) | [other.IsA](other.md) | [Events.BroadcastToPlayer](events.md) | [Ability.owner](ability.md) | [Game.GetLocalPlayer()](game.md)

---

Example using:

### `GetCurrentPhase`

### `GetPhaseTimeRemaining`

In this example, while the ability is on cooldown the percent completion of the cooldown is calculated. This could be useful, for instance, in displaying user interface.

```lua
local ability = script:FindAncestorByType("Ability")

function Tick()
    if ability:GetCurrentPhase() == AbilityPhase.COOLDOWN then
        local duration = ability.cooldownPhaseSettings.duration
        local remaining = ability:GetPhaseTimeRemaining()
        local percent = 100 * (1 - remaining / duration)

        print("Cooldown remaining: %" .. string.format("%.2f",percent))
    end
end
```

See also: [CoreObject.FindAncestorByType](coreobject.md) | [Ability.GetCurrentPhase](ability.md) | [AbilityPhaseSettings.duration](abilityphasesettings.md) | [CoreLua.print](coreluafunctions.md)

---

Example using:

### `GetTargetData`

### `SetTargetData`

The ability's targeting data gives a lot of information about where and what the player is aiming at. If setup correctly, it can also be modified programatically. In this example, the Z position of the target is flattened horizontally. Useful, for example, in a top-down shooter. For this to work it should be placed in a client context under the ability. The ability should also have the option "Is Target Data Update" turned off for the Execute phase, otherwise any data set programatically will be overwritten when the phase changes.

```lua
local ability = script:FindAncestorByType("Ability")

function OnCast(ability)
    local abilityTarget = ability:GetTargetData()
    local pos = abilityTarget:GetHitPosition()

    pos.z = ability.owner:GetWorldPosition().z + 50

    abilityTarget:SetHitPosition(pos)
    ability:SetTargetData(abilityTarget)
end

ability.castEvent:Connect(OnCast)
```

See also: [CoreObject.FindAncestorByType](coreobject.md) | [AbilityTarget.GetHitPosition](abilitytarget.md) | [Ability.owner](ability.md) | [Player.GetWorldPosition](player.md) | [Event.Connect](event.md)

---

Example using:

### `Interrupt`

Interrupting an ability either sends it back into ready state (if it was still in the Cast phase) or puts it on cooldown. In this example, we have an ability that searches for all enemies in a 10 meter radius and interrupts their abilities.

```lua
local ability = script.parent
local RADIUS = 1000 -- 10 meters

function OnExecute(ability)
    local center = ability.owner:GetWorldPosition()
    -- Search for enemies
    local enemies = Game.FindPlayersInCylinder(center, RADIUS, {ignoreTeams = ability.owner.team})
    for _, enemy in ipairs(enemies) do
        -- Interrupt all their abilities
        local enemyAbilities = enemy:GetAbilities()
        for _,a in ipairs(enemyAbilities) do
            a:Interrupt()
        end
    end
end

ability.executeEvent:Connect(OnExecute)
```

See also: [CoreObject.parent](coreobject.md) | [Ability.owner](ability.md) | [Player.GetWorldPosition](player.md) | [Game.FindPlayersInCylinder](game.md) | [Event.Connect](event.md)

---

Example using:

### `animation`

In this example, the `ProcessAbilities()` function can be called once, such as at the beginning of a round, to take inventory of a player's abilities and classify them based on animation. This example also demonstrates how to disconnect event listeners so that we don't listen for the same event multiple times.

```lua
function OnMelee1HandCast(ability)
    print("One-handed melee attack")
end

function OnMelee2HandCast(ability)
    print("Two-handed melee attack")
end

local abilityEventListeners = {}

function CleanupListeners(player)
    -- If we have previously processed this player, cleanup all listeners
    if abilityEventListeners[player] then
        for i, eventListener in ipairs(abilityEventListeners[player]) do
            eventListener:Disconnect()
        end
        abilityEventListeners[player] = nil
    end
end

function ProcessAbilities(player)
    CleanupListeners(player)

    local allAbilities = player:GetAbilities()

    for _, ability in ipairs(allAbilities) do
        if string.match(ability.animation, "melee") then
            local eventListener
            if string.match(ability.animation, "1h") then
                eventListener = ability.castEvent:Connect(OnMelee1HandCast)
            else
                eventListener = ability.castEvent:Connect(OnMelee2HandCast)
            end
            table.insert(abilityEventListeners[player], eventListener)
        end
    end
end

-- Lets also cleanup when a player leaves the game, as perhaps their ability objects might stay in the game.
Game.playerLeftEvent:Connect(CleanupListeners)
```

See also: [EventListener.Disconnect](eventlistener.md) | [Player.GetAbilities](player.md) | [Ability.castEvent](ability.md) | [Event.Connect](event.md) | [Game.playerLeftEvent](game.md) | [CoreLua.print](coreluafunctions.md)

---

Example using:

### `canActivateWhileDead`

Some games may have abilities that can be used while the player is dead. In this example, we have abilities that can **only** be activated while dead. If not dead, then it's interrupted.

```lua
local ability = script:FindAncestorByType("Ability")

function OnCast(ability)
    if ability.canActivateWhileDead and not ability.owner.isDead then
        ability:Interrupt()
    end
end

ability.castEvent:Connect(OnCast)

--[[#description
    On the client context, a user interface component that displays ability details is hidden until the player dies:
]]
local abilityCanvas = script:GetCustomProperty("Canvas")
local BINDING = script:GetCustomProperty("Binding")

function Tick(deltaTime)
    local ability = GetLocalPlayerAbilityWithBinding()

    if ability
    and ability.isEnabled
    and ability.canActivateWhileDead
    and ability.owner
    and ability.owner.isDead then

        abilityCanvas.visibility = Visibility.INHERIT
    else
        abilityCanvas.visibility = Visibility.FORCE_OFF
    end
end

-- Searches the local player's abilities until one with a matching action binding is found
-- The BINDING search criteria should be set in the custom property
function GetLocalPlayerAbilityWithBinding()
    local abilities = Game.GetLocalPlayer():GetAbilities()
    for _, ability in pairs(abilities) do
        if ability.actionBinding == BINDING then
            return ability
        end
    end

    return nil
end
```

See also: [CoreObject.FindAncestorByType](coreobject.md) | [Ability.owner](ability.md) | [Player.isDead](player.md) | [Event.Connect](event.md) | [CoreLua.Tick](coreluafunctions.md)

---

Example using:

### `canBePrevented`

In this example, an ability recognizes that it has been interrupted by the activation of another, special ability, that is setup to serve for animation cancelling. The `canBePrevented` property is usually true in this game, but in this special case it has been configured as false so that it can be activated at any time. The player gains vertical impulse as result of the synergy and hears a small audio cue that helps communicate the mechanic.

```lua
local ability = script.parent
local cancelSound = script:GetCustomProperty("CancelSound")

function OnInterrupted(ability)
    local player = ability.owner
    if not Object.IsValid(player) then return end

    for _, a in ipairs(player:GetAbilities()) do
        if a:GetCurrentPhase() ~= AbilityPhase.READY and not a.canBePrevented then
            player:AddImpulse(Vector3.UP * 1000)
            World.SpawnAsset(cancelSound, {position = player:GetWorldPosition()})
            return
        end
    end
end

ability.interruptedEvent:Connect(OnInterrupted)
```

See also: [CoreObject.parent](coreobject.md) | [Ability.owner](ability.md) | [Object.IsValid](object.md) | [Player.GetAbilities](player.md) | [Vector3.UP](vector3.md) | [World.SpawnAsset](world.md) | [Event.Connect](event.md)

---

Example using:

### `castPhaseSettings`

### `executePhaseSettings`

### `recoveryPhaseSettings`

### `cooldownPhaseSettings`

In this example, a function in a client context script can be called to show the elapsed times for an ability. The UI Text it controls displays how many seconds are remaining in the current phase, and the color of the text blends from black to white to indicate the percentage of completion. Although the Execute and Recovery phases are actually separate, they are here presented to the player as a single phase.

```lua
local COUNTDOWN_TEXT = script:GetCustomProperty("CountdownText"):WaitForObject()

function UpdateForAbility(ability)
    local currentPhase = ability:GetCurrentPhase()

    local percent = 1
    local cooldownText = "Ready"

    if currentPhase ~= AbilityPhase.READY then
        local phaseDuration
        local timeRemaining = ability:GetPhaseTimeRemaining()

        if currentPhase == AbilityPhase.CAST then
            phaseDuration = ability.castPhaseSettings.duration
        elseif currentPhase == AbilityPhase.EXECUTE then
            -- In the case of Execute and Recovery phases, we can show those as a single one
            local recoveryD = ability.recoveryPhaseSettings.duration
            phaseDuration = ability.executePhaseSettings.duration + recoveryD
            timeRemaining = timeRemaining + recoveryD
        elseif currentPhase == AbilityPhase.RECOVERY then
            phaseDuration = ability.recoveryPhaseSettings.duration
        else --currentPhase == AbilityPhase.COOLDOWN
            phaseDuration = ability.cooldownPhaseSettings.duration
        end

        if phaseDuration > 0 then
            percent = 1 - timeRemaining / phaseDuration
        end
        cooldownText = string.format("%.1f", timeRemaining)
    end

    COUNTDOWN_TEXT.text = cooldownText

    local c = Color.Lerp(Color.BLACK, Color.WHITE, percent)
    COUNTDOWN_TEXT:SetColor(c)
end
```

See also: [CoreObject.GetCustomProperty](coreobject.md) | [CoreObjectReference.WaitForObject](coreobjectreference.md) | [Ability.GetCurrentPhase](ability.md) | [AbilityPhaseSettings.duration](abilityphasesettings.md) | [UIText.text](uitext.md) | [Color.Lerp](color.md)

---

Example using:

### `isEnabled`

In this example, an equipment is setup with multiple abilities that all use the same action binding. This script cycles through the abilities, making sure only one is enabled at a time. The `owner` property is cleared for the previous ability and set for the next one, as part of ensuring the correct one activates when the binding is pressed.

```lua
local equipment = script:FindAncestorByType("Equipment")
local abilities = {}
local abilityIndex = 1

function OnAbilityRecovery(ability)
    if (#abilities > 1) then
        abilities[abilityIndex].isEnabled = false
        abilities[abilityIndex].owner = nil

        abilityIndex = abilityIndex + 1
        if (abilityIndex > #abilities) then
            abilityIndex = 1
        end

        abilities[abilityIndex].isEnabled = true
        abilities[abilityIndex].owner = equipment.owner
    end
end

for _, child in pairs(equipment:FindDescendantsByType("Ability")) do
    table.insert(abilities, child)

    child.isEnabled = (#abilities == 1)

    child.recoveryEvent:Connect(OnAbilityRecovery)
end
```

See also: [CoreObject.FindAncestorByType](coreobject.md) | [Ability.owner](ability.md) | [Equipment.owner](equipment.md) | [Event.Connect](event.md)

---

Example using:

### `name`

### `actionBinding`

Even though some API properties are read-only, they are useful is solutions such as user interface. In this example, a client context script searches the local player's list of abilities to find one that matches the action binding (input) designated for this UI component. When it's found, the ability's name is written to the UI Text object.

```lua
local BINDING = script:GetCustomProperty("Binding")
local NAME_UI = script:GetCustomProperty("NameUIText"):WaitForObject()

function GetLocalPlayerAbilityWithBinding()
    local player = Game.GetLocalPlayer()
    local abilities = player:GetAbilities()

    for _, ability in pairs(abilities) do
        if ability.actionBinding == BINDING then
            return ability
        end
    end

    return nil
end

function Tick()
    local ability = GetLocalPlayerAbilityWithBinding()
    if ability then
        NAME_UI.text = ability.name
    end
end
```

See also: [CoreObject.GetCustomProperty](coreobject.md) | [CoreObjectReference.WaitForObject](coreobjectreference.md) | [Game.GetLocalPlayer](game.md) | [Player.GetAbilities](player.md) | [UIText.text](uitext.md)

---

Example using:

### `owner`

Usually, abilities are presented as part of an equipment, but that isn't a requirement. In this example, when new players join the game they are assigned an ability through the use of the `owner` property.

```lua
local abilityTemplate = script:GetCustomProperty("AbilityTemplate")

function OnPlayerJoined(player)
    local ability = World.SpawnAsset(abilityTemplate)
    ability.owner = player
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

See also: [CoreObject.GetCustomProperty](coreobject.md) | [World.SpawnAsset](world.md) | [Player.owner](player.md) | [Game.playerJoinedEvent](game.md) | [Event.Connect](event.md)

---

## Tutorials

[Abilities in Core](../tutorials/abilities.md)
