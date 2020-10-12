---
id: examples
name: Examples and Snippets
title: Examples and Snippets
tags:
    - Misc
---

# Examples and Snippets

## Ability

### <a id="event:Ability.castEvent"></a>Ability.castEvent

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

### <a id="event:Ability.cooldownEvent"></a>Ability.cooldownEvent

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

### <a id="event:Ability.executeEvent"></a>Ability.executeEvent

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

### <a id="event:Ability.interruptedEvent"></a>Ability.interruptedEvent

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

### <a id="event:Ability.readyEvent"></a>Ability.readyEvent

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

### <a id="event:Ability.recoveryEvent"></a>Ability.recoveryEvent

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

### <a id="event:Ability.tickEvent"></a>Ability.tickEvent

Abilities fire the `tickEvent` while they are active or on cooldown (not on Ready state). In this example, a piece of equipment carries several abilities, but we want to do a common update logic on all of them. Note: `Ability.tickEvent` works somewhat differently from a `Tick()` function - `tickEvent` is an actual event that just happens to fire once per tick. Each invocation of the callback runs on its own task. This means that, unlike `Tick()`, there is no guarantee that it will wait for the previous `tickEvent` to finish before starting the next one. This means you can't use things like `Task.Wait()` to add time between ticks!

```lua
local equipment = script.parent
local allAbilities = equipment:GetAbilities()

function OnTick(ability, deltaTime)
    print("Updating ability " .. ability.name)
end

for _,ability in ipairs(allAbilities) do
    ability.tickEvent:Connect(OnTick)
end
```

### <a id="method:Ability.Activate"></a>Ability.Activate

The Ability `Activate()` function is client-only, behaving as if the player had pressed the key binding. In order for a server gameplay decision to result in an ability activation, it must be communicated over the network somehow. In this example, a trigger overlap is representative of an arbitrary gameplay decision on the server. A broadcast message is sent to the client, who receives the event and activates the ability.

Server script:

```lua
local trigger = script.parent

trigger.beginOverlapEvent(function(trigger, other)
    if other:IsA("Player") then
        Events.BroadcastToPlayer(other, "SteppedOnObject")
    end
end)
```

Client context script under the ability:

```lua
local ability = script:FindAncestorByType("Ability")

function OnPlayAnimation()
    if ability.owner and ability.owner == Game.GetLocalPlayer() then
        ability:Activate()
    end
end

Events.Connect("SteppedOnObject", OnPlayAnimation)
```

### <a id="method:Ability.GetCurrentPhase"></a>Ability.GetCurrentPhase

### <a id="method:Ability.GetPhaseTimeRemaining"></a>Ability.GetPhaseTimeRemaining

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

### <a id="method:Ability.GetTargetData"></a>Ability.GetTargetData

### <a id="method:Ability.SetTargetData"></a>Ability.SetTargetData

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

### <a id="method:Ability.Interrupt"></a>Ability.Interrupt

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

### <a id="property:Ability.animation"></a>Ability.animation

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

### <a id="property:Ability.canActivateWhileDead"></a>Ability.canActivateWhileDead

Some games may have abilities that can be used while the player is dead. In this example, we have abilities that can **only** be activated while dead. If not dead, then it's interrupted.

```lua
local ability = script:FindAncestorByType("Ability")

function OnCast(ability)
    if ability.canActivateWhileDead and not ability.owner.isDead then
        ability:Interrupt()
    end
end

ability.castEvent:Connect(OnCast)
```

On the client context, a user interface component that displays ability details is hidden until the player dies:

```lua
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

### <a id="property:Ability.canBePrevented"></a>Ability.canBePrevented

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

### <a id="property:Ability.castPhaseSettings"></a>Ability.castPhaseSettings

### <a id="property:Ability.executePhaseSettings"></a>Ability.executePhaseSettings

### <a id="property:Ability.recoveryPhaseSettings"></a>Ability.recoveryPhaseSettings

### <a id="property:Ability.cooldownPhaseSettings"></a>Ability.cooldownPhaseSettings

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

### <a id="property:Ability.isEnabled"></a>Ability.isEnabled

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

### <a id="property:Ability.name"></a>Ability.name

### <a id="property:Ability.actionBinding"></a>Ability.actionBinding

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

### <a id="property:Ability.owner"></a>Ability.owner

Usually, abilities are presented as part of an equipment, but that isn't a requirement. In this example, when new players join the game they are assigned an ability through the use of the `owner` property.

```lua
local abilityTemplate = script:GetCustomProperty("AbilityTemplate")

function OnPlayerJoined(player)
    local ability = World.SpawnAsset(abilityTemplate)
    ability.owner = player
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

## AbilityTarget

### <a id="constructor:AbilityTarget.New"></a>AbilityTarget.New

The ability's targeting data can be generated programatically, for specific results. In this example, We create a target that is always at the world origin (Vector3.ZERO). If added to a rifle's Shoot ability, all shots will go to (0,0,0). For this to work the script should be placed in a client context under the ability. The ability should also have the option "Is Target Data Update" turned off for the Execute phase, otherwise any data set programatically will be overwritten when the phase changes.

```lua
local abilityTarget = AbilityTarget.New()
abilityTarget:SetHitPosition(Vector3.ZERO)

local ability = script:FindAncestorByType("Ability")

function OnCast(ability)
    ability:SetTargetData(abilityTarget)
end

ability.castEvent:Connect(OnCast)
```

### <a id="method:AbilityTarget.GetAimPosition"></a>AbilityTarget.GetAimPosition

### <a id="method:AbilityTarget.GetAimDirection"></a>AbilityTarget.GetAimDirection

In this example, a non-weapon ability needs to know where the player is aiming in order to spawn the effect correctly. It creates an effect that moves down the center of where the camera is aiming. However, if the effect were to begin at the camera's position that could be weird in a third-person game. Instead, the player's position is projected onto the camera's vector to determine a more suitable starting point.

```lua
local ability = script:FindAncestorByType("Ability")

function ProjectPointOnLine(p, linePoint, lineDirection)
    local lineToP = p - linePoint
    return linePoint + (lineToP..lineDirection) / (lineDirection..lineDirection) * lineDirection
end

function OnExecute(ability)
    local targetData = ability:GetTargetData()

    -- Project the player's position onto the camera vector, to get a starting point for the effect
    local playerPos = ability.owner:GetWorldPosition()
    local aimPosition = targetData:GetAimPosition()
    local aimDirection = targetData:GetAimDirection()
    local playerProjection = ProjectPointOnLine(playerPos, aimPosition, aimDirection)

    -- Placeholder for some ability effect. Draw a red line 9 meters long
    local params = {duration = 3, color = Color.RED, thickness = 3}
    CoreDebug.DrawLine(playerProjection, playerProjection + aimDirection * 900, params)
end

ability.executeEvent:Connect(OnExecute)
```

### <a id="method:AbilityTarget.GetHitPosition"></a>AbilityTarget.GetHitPosition

### <a id="method:AbilityTarget.SetHitPosition"></a>AbilityTarget.SetHitPosition

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

### <a id="method:AbilityTarget.GetHitResult"></a>AbilityTarget.GetHitResult

At any phase of an ability's activation, you can get data about what is under the cursor and would be hit.

This code snippet prints out the name of whatever was under the cursor when the player executes this ability!

```lua
local ability = script:FindAncestorByType("Ability")

function OnExecute(ability)
    local hr = ability:GetTargetData():GetHitResult()
    if hr.other then
        print("You shot " .. hr.other.name)
    else
        print("You didn't hit anything...")
    end
end
ability.executeEvent:Connect(OnExecute)
```

### <a id="property:AbilityTarget.hitObject"></a>AbilityTarget.hitObject

### <a id="property:AbilityTarget.hitPlayer"></a>AbilityTarget.hitPlayer

In this example, an ability casts a magical area of effect (AOE) in front of the player. In case the player was aiming at another player or object that position is used instead.

```lua
local ability = script:FindAncestorByType("Ability")
local AOE_ASSET = script:GetCustomProperty("AOEAsset")

function OnExecute(ability)
    -- The default position to spawn at
    local ownerForwardVect = ability.owner:GetWorldTransform():GetForwardVector()
    local spawnPos = ability.owner:GetWorldPosition() + ownerForwardVect * 600 - Vector3.UP * 50

    -- Consider alternate positions based on the ability's targeting information
    local targetData = ability:GetTargetData()
    if targetData.hitPlayer then
        spawnPos = targetData.hitPlayer:GetWorldPosition()

    elseif targetData.hitObject then
        spawnPos = targetData:GetHitPosition()
    end

    -- Spawn the AOE object
    local instance = World.SpawnAsset(AOE_ASSET, {position = spawnPos})
    -- Give the AOE object a reference back to this ability. E.g. if the AOE kills an enemy,
    -- then it has enough information to correctly attribute a score increase.
    instance.serverUserData.sourceAbility = ability
end

ability.executeEvent:Connect(OnExecute)
```

## AnimatedMesh

### <a id="event:AnimatedMesh.animationEvent"></a>AnimatedMesh.animationEvent

Some animations have events that fire when certain parts of the animations are reached. This allows you to sync up hit effects with animations. Important note! This event is only fired client side. The server cannot directly respond to animation events!

```lua
local propDragonMob = script:GetCustomProperty("DragonMob")
local dragonMesh = World.SpawnAsset(propDragonMob)

function AnimEventListener(mesh, eventName)
    print("Animated Mesh " .. mesh.name .. " just hit event " .. eventName .. "!")
    -- Normally we'd spawn a "Swipe" effect here, and possibly check if we hit a player!
end

dragonMesh.animationEvent:Connect(AnimEventListener)
dragonMesh:PlayAnimation("unarmed_claw")
```

### <a id="function:AnimatedMesh.AttachCoreObject"></a>AnimatedMesh.AttachCoreObject

Attaches the specified object to the specified socket on the mesh if they exist.

In this example, we want to attach multiple objects to an animated mesh to create a costume, such as equipment on a skeleton enemy or horns on the head of a raptor. For it to work, setup the animated mesh in its "binding" stance and without any animations playing at the start. Place this script along with any costume parts to be attached as children of the animated mesh. Position and rotate the costume parts to align them with their destinations on the mesh. The costume parts are expected to be groups/folders with their names matching the socket names they are destined to. When the script runs, it searches through all the mesh's children and attaches them to the sockets.

```lua
local MESH = script.parent

local allObjects = MESH:GetChildren()

for _, obj in ipairs(allObjects) do
    if obj:IsA("Folder") then
        local socketName = obj.name
        local pos = obj:GetWorldPosition()
        local rot = obj:GetWorldRotation()

        MESH:AttachCoreObject(obj, socketName)

        obj:SetWorldPosition(pos)
        obj:SetWorldRotation(rot)
    end
end
```

### <a id="function:AnimatedMesh.GetAnimationNames"></a>AnimatedMesh.GetAnimationNames

### <a id="function:AnimatedMesh.GetAnimationStanceNames"></a>AnimatedMesh.GetAnimationStanceNames

### <a id="function:AnimatedMesh.GetSocketNames"></a>AnimatedMesh.GetSocketNames

### <a id="function:AnimatedMesh.GetAnimationEventNames"></a>AnimatedMesh.GetAnimationEventNames

### <a id="function:AnimatedMesh.GetAnimationDuration"></a>AnimatedMesh.GetAnimationDuration

You can find out most of the interesting data about an Animated Mesh at runtime, using several handy functions.

```lua
local propDragonMob = script:GetCustomProperty("DragonMob")

-- This function prints out all of the animations, sockets, stances, and events associated
-- with an animated mesh!
function PrintAnimatedMeshData(mesh)
    print("Animation names:")
    for _, v in ipairs(mesh:GetAnimationNames()) do
        print("    " .. v .. "(" .. tostring(mesh:GetAnimationDuration(v)) .. ")")
        -- Print out any events that are associated with this animation:
        for _,e in ipairs(mesh:GetAnimationEventNames(v)) do
            print("        Event: " .. e)
        end
    end
    print("\nAnimation stance names:")
    for _, v in ipairs(mesh:GetAnimationStanceNames()) do
        print("    " .. v)
    end
    print("\nSocket names:")
    for _, v in ipairs(mesh:GetSocketNames()) do
        print("    " .. v)
    end
end

local dragonMesh = World.SpawnAsset(propDragonMob)
PrintAnimatedMeshData(dragonMesh)
```

### <a id="function:AnimatedMesh.PlayAnimation"></a>AnimatedMesh.PlayAnimation

### <a id="property:AnimatedMesh.playbackRateMultiplier"></a>AnimatedMesh.playbackRateMultiplier

Plays an animation on the animated mesh. Optional parameters can be provided to control the animation playback: `playbackRate (Number)`: Controls how fast the animation plays. `shouldLoop (bool)`: If `true`, the animation will keep playing in a loop. If `false` the animation will stop playing once completed.

In this example, a humanoid animated mesh has its laughing and death animations controlled by pressing the primary and secondary action bindings (PC default is mouse left-click and right-click respectively).

```lua
local MESH = script.parent

function PlayAttack()
    MESH:PlayAnimation("unarmed_laugh")
    MESH.playbackRateMultiplier = 1
end

function PlayDeath()
    MESH:PlayAnimation("unarmed_death")
    Task.Wait(1.96)
    -- Prevents the animation from looping or returning to stance
    MESH.playbackRateMultiplier = 0
end

function OnBindingPressed(player, action)
    if action == "ability_primary" then
        PlayAttack()

    elseif action == "ability_secondary" then
        PlayDeath()
    end
end

Game.playerJoinedEvent:Connect(function(player)
    player.bindingPressedEvent:Connect(OnBindingPressed)
end)
```

### <a id="function:AnimatedMesh.StopAnimations"></a>AnimatedMesh.StopAnimations

You can stop whatever animation is currently playing via `StopAnimations()`.

```lua
local propDragonMob = script:GetCustomProperty("DragonMob")
local dragonMesh = World.SpawnAsset(propDragonMob)

dragonMesh:PlayAnimation("unarmed_slash")
Task.Wait(0.25)
dragonMesh:StopAnimations()
```

### <a id="property:AnimatedMesh.animationStance"></a>AnimatedMesh.animationStance

### <a id="property:AnimatedMesh.animationStancePlaybackRate"></a>AnimatedMesh.animationStancePlaybackRate

### <a id="property:AnimatedMesh.animationStanceShouldLoop"></a>AnimatedMesh.animationStanceShouldLoop

The stance the animated mesh plays.

This example demonstrates how to dynamically control the walking stances and to vary their playback speed by how fast the character is moving. This script itself does not move the mesh--that is expected to happen in another script such as an AI or simple `MoveTo()`.

```lua
local MESH = script.parent

-- 0.9 is an approximate scale for the Fox mesh
-- 2 is an approximate for the Raptor and humanoids
local WALK_SCALE = 2

local RUN_BASE = 0.5
local RUN_SCALE = 0.002

-- Thresholds of speed (cm/s) that define which stance to use
local WALKING_SPEED = 15
local RUNNING_SPEED = 300

local lastPos = MESH:GetWorldPosition()

function Tick(deltaTime)
    if deltaTime <= 0 then return end

    local pos = MESH:GetWorldPosition()
    local direction = pos - lastPos
    local speed = direction.size / deltaTime

    -- We can make sure the animation stance loops. If we wanted it to only
    -- play once, we would set it to false here.
    MESH.animationStanceShouldLoop = true

    lastPos = pos

    if speed < WALKING_SPEED then
        MESH.animationStance = "unarmed_idle_ready"

    elseif speed < RUNNING_SPEED then
        MESH.animationStance = "unarmed_walk_forward"
        MESH.animationStancePlaybackRate = WALK_SCALE * (speed - WALKING_SPEED) / (RUNNING_SPEED - WALKING_SPEED)
    else
        MESH.animationStance = "unarmed_run_forward"
        MESH.animationStancePlaybackRate = RUN_BASE + (speed - RUNNING_SPEED) * RUN_SCALE
    end
end
```

## Camera

### <a id="method:Camera.GetPositionOffset"></a>Camera.GetPositionOffset

### <a id="method:Camera.SetPositionOffset"></a>Camera.SetPositionOffset

The following example implements a camera shake based on movement of the camera's z-axis. This script should be placed as a child of the game's camera. The shake script doesn't know "when" to shake--that decision comes from elsewhere in the project, where the event `Events.BroadcastToPlayer(player, "CameraShake")` should be called to initiate the effect.

```lua
local CAMERA = script.parent

-- ShakePower, Frequency, and DecaySpeed can be customized with custom properties
local SHAKE_POWER = script:GetCustomProperty("ShakePower") or 40
local FREQUENCY = script:GetCustomProperty("Frequency") or 90
local DECAY_SPEED = script:GetCustomProperty("DecaySpeed") or 12

local amplitude = 0
local startPositionOffset = Vector3.New()

function Tick(deltaTime)
    if (amplitude > 0) then
        amplitude = CoreMath.Lerp(amplitude, 0, deltaTime * DECAY_SPEED)

        -- Shake on the Z-axis (position)
        local z = math.sin(time() * FREQUENCY) * amplitude
        local pos = Vector3.New(0, 0, z)
        CAMERA:SetPositionOffset(pos + startPositionOffset)
    end
end

function StartShake(multiplier)
    amplitude = SHAKE_POWER

    if multiplier then
        amplitude = amplitude * multiplier
    end

    startPositionOffset = CAMERA:GetPositionOffset()
end

-- To initiate a shake, call the "CameraShake" event elsewhere in the game
Events.Connect("CameraShake", StartShake)
```

### <a id="method:Camera.GetRotationOffset"></a>Camera.GetRotationOffset

### <a id="method:Camera.SetRotationOffset"></a>Camera.SetRotationOffset

The following example implements a camera shake based on rotation of the camera's pitch. This script should be placed as a child of the game's camera. The shake script doesn't know "when" to shake--that decision comes from elsewhere in the project, where the event `Events.BroadcastToPlayer(player, "CameraShake")` should be called to initiate the effect.

```lua
local CAMERA = script.parent

-- ShakePower, Frequency, and DecaySpeed can be customized with custom properties
local SHAKE_POWER = script:GetCustomProperty("ShakePower") or 10
local FREQUENCY = script:GetCustomProperty("Frequency") or 90
local DECAY_SPEED = script:GetCustomProperty("DecaySpeed") or 12

local amplitude = 0
local startRotationOffset = Rotation.New()

function Tick(deltaTime)
    if (amplitude > 0) then
        amplitude = CoreMath.Lerp(amplitude, 0, deltaTime * DECAY_SPEED)

        -- Shake on the pitch axis (rotation)
        local pitch = math.sin(time() * FREQUENCY) * amplitude
        local rot = Rotation.New(0, pitch, 0)
        CAMERA:SetRotationOffset(rot + startRotationOffset)
    end
end

function StartShake(multiplier)
    amplitude = SHAKE_POWER

    if multiplier then
        amplitude = amplitude * multiplier
    end

    startRotationOffset = CAMERA:GetRotationOffset()
end

-- To initiate a shake, call the "CameraShake" event elsewhere in the game
Events.Connect("CameraShake", StartShake)
```

### <a id="property:Camera.currentPitch"></a>Camera.currentPitch

### <a id="property:Camera.currentYaw"></a>Camera.currentYaw

This sample explores the parallel between the player's rotation, the camera's rotation and the camera's view angles expressed in the `currentPitch` and `currentYaw` properties. The camera's "free control" and "rotation mode" are adjusted so the view angle properties give useful information--that's because if "free control" is disabled the view angles always return zero. This script expects to be in a client context. Results will vary depending on player settings (e.g. Facing Mode) as well as other camera settings.

```lua
function Tick()
    local player = Game.GetLocalPlayer()
    local rot = player:GetWorldRotation()

    UI.PrintToScreen("Player:")
    UI.PrintToScreen("pitch = " .. rot.y)
    UI.PrintToScreen("yaw = " .. rot.z)
    UI.PrintToScreen("")

    local camera = World.FindObjectsByType("Camera")[1]
    camRot = camera:GetWorldRotation()
    camera.rotationMode = RotationMode.CAMERA
    camera.hasFreeControl = true

    UI.PrintToScreen("Camera:")
    UI.PrintToScreen("pitch = " .. camRot.y)
    UI.PrintToScreen("yaw = " .. camRot.z)
    UI.PrintToScreen("")

    UI.PrintToScreen("View Angles:")
    UI.PrintToScreen("pitch = " .. camera.currentPitch)
    UI.PrintToScreen("yaw = " .. camera.currentYaw)

    UI.PrintToScreen("")
    UI.PrintToScreen("(view angle yaw) - (player yaw) = " .. (camera.currentYaw - rot.z))

    Task.Wait(3)
end
```

### <a id="property:Camera.fieldOfView"></a>Camera.fieldOfView

### <a id="property:Camera.isOrthographic"></a>Camera.isOrthographic

### <a id="property:Camera.currentDistance"></a>Camera.currentDistance

### <a id="property:Camera.isDistanceAdjustable"></a>Camera.isDistanceAdjustable

The following example implements a zoom/scoping effect that activates by holding the secondary action (right mouse button, by default). The effect smoothly interpolates a few camera properties, in addition to making the player invisible to the local view, so they don't obstruct the camera during the zoom. This kind of mechanic is generally attached to a weapon, but in this case the script expects to be a child of the camera directly--no equipment is involved in this example.

```lua
local CAMERA = script.parent

-- This script only works for non-orthographics cameras
if CAMERA.isOrthographic then return end

-- These could be added as custom properties
local TARGET_FOV = script:GetCustomProperty("TargetFOV") or 10
local LERP_SPEED = script:GetCustomProperty("LerpSpeed") or 20

local startFov = CAMERA.fieldOfView
local startPositionOffset = CAMERA:GetPositionOffset()
local startIsDistanceAdjustable = CAMERA.isDistanceAdjustable
local pressedDistance = 0

local player = Game.GetLocalPlayer()

local isPressing = false

function Tick(deltaTime)
    -- Interpolate FOV, Position and Distance
    local fov = CAMERA.fieldOfView
    local pos = CAMERA:GetPositionOffset()

    local t = deltaTime * LERP_SPEED

    if isPressing then
        fov = CoreMath.Lerp(fov, TARGET_FOV, t)
        pos = Vector3.Lerp(pos, Vector3.ZERO, t)

        if pos.size < 4 then
            -- As the camera approaches the destination, turn off the player
            player.isVisibleToSelf = false
        end
    else
        fov = CoreMath.Lerp(fov, startFov, t)
        pos = Vector3.Lerp(pos, startPositionOffset, t)
        -- Turn the player back on
        player.isVisibleToSelf = true
    end

    CAMERA.fieldOfView = fov
    CAMERA:SetPositionOffset(pos)

    -- Interpolate distance
    local distance = CAMERA.currentDistance

    if isPressing then
        distance = CoreMath.Lerp(distance, 0, t)
    else
        if not CAMERA.isDistanceAdjustable then
            if math.abs(distance - pressedDistance) < 1 then
                distance = pressedDistance
                CAMERA.isDistanceAdjustable = startIsDistanceAdjustable
            else
                distance = CoreMath.Lerp(distance, pressedDistance, t)
            end
        end
    end

    CAMERA.currentDistance = distance
end

function OnBindingPressed(player, action)
    if action == "ability_secondary" then
        isPressing = true

        CAMERA.isDistanceAdjustable = false
        pressedDistance = CAMERA.currentDistance
    end
end

function OnBindingReleased(player, action)
    if action == "ability_secondary" then
        isPressing = false
    end
end

player.bindingPressedEvent:Connect(OnBindingPressed)
player.bindingReleasedEvent:Connect(OnBindingReleased)
```

### <a id="property:Camera.followPlayer"></a>Camera.followPlayer

In this example, players can change their view to look at another player by pressing the secondary action (default is right mouse button). The script expects to be a child of the game's camera, which is usually in a client context.

```lua
local CAMERA = script.parent

function NextPlayer()
    local allPlayers = Game.GetPlayers()

    if CAMERA.followPlayer == nil then
        CAMERA.followPlayer = allPlayers[1]
    else
        for index,player in ipairs(allPlayers) do
            if CAMERA.followPlayer == player then
                local selectedPlayer
                if index == #allPlayers then
                    selectedPlayer = allPlayers[1]
                else
                    selectedPlayer = allPlayers[index + 1]
                end

                if selectedPlayer == Game.GetLocalPlayer() then
                    CAMERA:Detach()
                    CAMERA.followPlayer = selectedPlayer
                else
                    CAMERA.followPlayer = nil
                    CAMERA:AttachToPlayer(selectedPlayer, "root")
                    CAMERA:SetPosition(Vector3.New(0,0,200))
                end
                return
            end
        end
    end
end

function OnBindingPressed(player, action)
    if action == "ability_secondary" then
        NextPlayer()
    end
end

Game.GetLocalPlayer().bindingPressedEvent:Connect(OnBindingPressed)
```

### <a id="property:Camera.rotationMode"></a>Camera.rotationMode

### <a id="property:Camera.hasFreeControl"></a>Camera.hasFreeControl

### <a id="property:Camera.minPitch"></a>Camera.minPitch

### <a id="property:Camera.maxPitch"></a>Camera.maxPitch

### <a id="property:Camera.isYawLimited"></a>Camera.isYawLimited

### <a id="property:Camera.minYaw"></a>Camera.minYaw

### <a id="property:Camera.maxYaw"></a>Camera.maxYaw

### <a id="property:Camera.minDistance"></a>Camera.minDistance

### <a id="property:Camera.maxDistance"></a>Camera.maxDistance

In this example of an advanced spectator implementation, suitable for a third-person game, players are able to look through the view of others by pressing the secondary action (default is right mouse button). This example demonstrates how the spectator can be constrained (or not) to the look angle of the player they are following. If the `CONSTRAIN_SPECTATOR_LOOK` constant is set to true, then players will not be able to rotate the camera freely while they are spectating.

```lua
local CAMERA = script.parent

local CONSTRAIN_SPECTATOR_LOOK = false
local PITCH_CONSTRAINED_ANGLE = 15
local YAW_CONTRAINED_ANGLE = 15

local defaultMinPitch = CAMERA.minPitch
local defaultMaxPitch = CAMERA.maxPitch
local defaultIsYawLimited = CAMERA.isYawLimited
local defaultMinYaw = CAMERA.minYaw
local defaultMaxYaw = CAMERA.maxYaw
local defaultDistance = CAMERA.currentDistance
local defaultIsDistanceAdjustable = CAMERA.isDistanceAdjustable
local defaultMinDistance = CAMERA.minDistance
local defaultMaxDistance = CAMERA.maxDistance

local followedPlayer = Game.GetLocalPlayer()

function SpectatePlayer(player)
    if player == Game.GetLocalPlayer() then
        -- Attach back to the local player
        CAMERA:Detach()
        CAMERA.followPlayer = player
        CAMERA.rotationMode = RotationMode.LOOK_ANGLE
        -- We could set 'hasFreeControl' back to its original value, but we
        -- don't have to, as it has no effect when 'followPlayer' is set.

        -- Revert spectator constraints
        CAMERA.minPitch = defaultMinPitch
        CAMERA.maxPitch = defaultMaxPitch
        CAMERA.isYawLimited = defaultIsYawLimited
        CAMERA.minYaw = defaultMinYaw
        CAMERA.maxYaw = defaultMaxYaw
        CAMERA.minDistance = defaultMinDistance
        CAMERA.maxDistance = defaultMaxDistance
        CAMERA.isDistanceAdjustable = defaultIsDistanceAdjustable
    else
        -- Attach to another player
        CAMERA.followPlayer = nil
        CAMERA:AttachToPlayer(player, "root")
        CAMERA:SetPosition(Vector3.New(0,0,179))
        CAMERA.rotationMode = RotationMode.CAMERA
        CAMERA.hasFreeControl = true

        -- Apply spectator constraints if desired
        if CONSTRAIN_SPECTATOR_LOOK then
            CAMERA.minPitch = -PITCH_CONSTRAINED_ANGLE
            CAMERA.maxPitch = PITCH_CONSTRAINED_ANGLE
            CAMERA.isYawLimited = true
            CAMERA.minYaw = -YAW_CONTRAINED_ANGLE
            CAMERA.maxYaw = YAW_CONTRAINED_ANGLE
            CAMERA.currentDistance = defaultDistance
            CAMERA.minDistance = defaultDistance
            CAMERA.maxDistance = defaultDistance
        end
    end
end

function NextPlayer()
    local allPlayers = Game.GetPlayers()

    if followedPlayer == nil then
        CAMERA.followPlayer = allPlayers[1]
    else
        for index,player in ipairs(allPlayers) do
            if followedPlayer == player then
                -- Select who the next player is
                local selectedPlayer
                if index == #allPlayers then
                    selectedPlayer = allPlayers[1]
                else
                    selectedPlayer = allPlayers[index + 1]
                end

                followedPlayer = selectedPlayer

                SpectatePlayer(selectedPlayer)
                return
            end
        end
    end
end

function OnBindingPressed(player, action)
    if action == "ability_secondary" then
        NextPlayer()
    end
end
Game.GetLocalPlayer().bindingPressedEvent:Connect(OnBindingPressed)
```

### <a id="property:Camera.useCameraSocket"></a>Camera.useCameraSocket

The following client script allows players in a first-person game to turn on/off the head-bob effect that is associated with the camera being attached to the camera socket. To toggle the head-bob press 0.

```lua
function OnBindingPressed(player, action)
    if action == "ability_extra_0" then
        local camera = player:GetActiveCamera()
        camera.useCameraSocket = not camera.useCameraSocket
    end
end

local localPlayer = Game.GetLocalPlayer()
localPlayer.bindingPressedEvent:Connect(OnBindingPressed)
```

### <a id="property:Camera.viewWidth"></a>Camera.viewWidth

In this example, designed to work with a top-down orthographic camera, the view is zoomed in when the secondary action is pressed (default is right mouse button). Works best in a client context.

```lua
local CAMERA = script.parent

-- This script only works for orthographics cameras
CAMERA.isOrthographic = true

-- These could be added as custom properties
local TARGET_VIEW_WIDTH = script:GetCustomProperty("TargetViewWidth") or 300
local LERP_SPEED = script:GetCustomProperty("LerpSpeed") or 20

local startViewWidth = CAMERA.viewWidth

local player = Game.GetLocalPlayer()

local isPressing = false

function Tick(deltaTime)
    -- Interpolate the View Width
    local viewWidth = CAMERA.viewWidth

    local t = deltaTime * LERP_SPEED

    if isPressing then
        viewWidth = CoreMath.Lerp(viewWidth, TARGET_VIEW_WIDTH, t)
    else
        viewWidth = CoreMath.Lerp(viewWidth, startViewWidth, t)
    end

    CAMERA.viewWidth = viewWidth
end

function OnBindingPressed(player, action)
    if action == "ability_secondary" then
        isPressing = true
    end
end

function OnBindingReleased(player, action)
    if action == "ability_secondary" then
        isPressing = false
    end
end

player.bindingPressedEvent:Connect(OnBindingPressed)
player.bindingReleasedEvent:Connect(OnBindingReleased)
```

## Color

### <a id="classfunction:Color.Lerp"></a>Color.Lerp

This utility function calculates a color useful for a health bar.

```lua
function GetHitPointsColor(currentHitPoints, maxHitPoints)
    -- 3 point gradient color, from red to yellow then green
    local percent = 1

    if maxHitPoints > 0 then
        percent = currentHitPoints / maxHitPoints
        percent = CoreMath.Clamp(percent, 0, 1)
    end

    local c

    if percent < 0.5 then
        c = Color.Lerp(Color.RED, Color.YELLOW, percent * 2)
    else
        c = Color.Lerp(Color.YELLOW, Color.GREEN, percent * 2 - 1)
    end

    return c
end
```

## CoreDebug

### <a id="classfunction:CoreDebug.DrawLine"></a>CoreDebug.DrawLine

### <a id="classfunction:CoreDebug.DrawBox"></a>CoreDebug.DrawBox

### <a id="classfunction:CoreDebug.DrawSphere"></a>CoreDebug.DrawSphere

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

### <a id="classfunction:CoreDebug.GetTaskStackTrace"></a>CoreDebug.GetTaskStackTrace

### <a id="classfunction:CoreDebug.GetStackTrace"></a>CoreDebug.GetStackTrace

When debugging, it can often be useful to see exactly which code is executing, and which code called it. You a "stack trace" will give you this information. It is a list of every function on the call stack.

This sample shows how to get and print out the stack traces. They will be slightly different depending on which thread is examining them.

```lua
local taskStackTrace
local otherTaskStackTrace
local generalStackTrace

function Function_A()
    Function_B()
end

function Function_B()
    Function_C()
end

function Function_C()
    taskStackTrace = CoreDebug.GetTaskStackTrace()
    Task.Wait(1)
end

local otherTask = Task.Spawn(Function_A)
Task.Wait()

otherTaskStackTrace = CoreDebug.GetTaskStackTrace(otherTask)
generalStackTrace = CoreDebug.GetStackTrace()

Task.Wait(1)
print("Stack trace, as viewed from within the task:")
print(taskStackTrace)
print("Stack trace, as viewed from the main thread:")
print(otherTaskStackTrace)
print("General stack trace:")
print(generalStackTrace)
```

## CoreLuaFunctions

### <a id="corelua:CoreLua.print"></a>CoreLua.print

### <a id="corelua:CoreLua.warn"></a>CoreLua.warn

The common lua `print()` statement puts text into the Event Log. It can be used from anywhere, and is often extremely useful for debugging.

There is a similar function, `warn()`, which functions also prints to the event log, except as a warning message. (So it's bright and yellow and hard to miss.)

```lua
-- This will be printed to the event log normally.
print("Hello world!")

-- This will be printed in scary yellow letters, as a warning!
warn("Something is amiss!")
```

### <a id="corelua:CoreLua.time"></a>CoreLua.time

### <a id="corelua:CoreLua.Tick"></a>CoreLua.Tick

Functions named `Tick()` are special - if you have a script with a `Tick()` function, then that function will be called every frame of the game. This is not something you want to do often, because of performance costs, but can be used to set up animations. (Ideally inside of client contexts.)

The `time()` funcion is very useful for this sort of thing - it will return the number of seconds since the map started running on the server, which makes it very useful in creating animations based on time.

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")
local startTime = time()
local fadeDuration = 1.0
local currentColor = Color.RED
local nextColor = Color.BLUE
local cube = World.SpawnAsset(propCubeTemplate, {position = Vector3.FORWARD * 200})

function Tick()
    local currentTime = time()
    if currentTime > startTime + fadeDuration then
        startTime = currentTime
        local temp = currentColor
        currentColor = nextColor
        nextColor = temp
    end
    local progress = (currentTime - startTime) / fadeDuration
    cube:SetColor(Color.Lerp(currentColor, nextColor, progress))
end
```

## CoreMesh

### <a id="method:CoreMesh.GetColor"></a>CoreMesh.GetColor

### <a id="method:CoreMesh.SetColor"></a>CoreMesh.SetColor

### <a id="method:CoreMesh.ResetColor"></a>CoreMesh.ResetColor

You can set a color override for a mesh. Exactly what this means will depend on the material of the mesh, but in general, setting a mesh's color will make the mesh be tinted to match that color.

```lua
local cube = World.SpawnAsset(propCubeTemplate, {position = Vector3.New(1000, 0, 300) })

cube:SetColor(Color.WHITE)
for i = 1, 40 do
    local cubeColor = cube:GetColor()
    local newColor = Color.New(cubeColor.r * 0.95, cubeColor.g * 0.95, cubeColor.b * 0.95)
    cube:SetColor(newColor)
    Task.Wait(0.025)
end
cube:ResetColor()
```

### <a id="property:CoreMesh.meshAssetId"></a>CoreMesh.meshAssetId

You can check the asset ID of a static mesh. This will be the MUID of the Core Content object it was created from!

```lua
local cube = World.SpawnAsset(propCubeTemplate, {position = Vector3.New(1000, 0, 300) })
print("The asset ID is " .. cube.meshAssetId)
```

### <a id="property:CoreMesh.team"></a>CoreMesh.team

### <a id="property:CoreMesh.isTeamColorUsed"></a>CoreMesh.isTeamColorUsed

### <a id="property:CoreMesh.isTeamCollisionEnabled"></a>CoreMesh.isTeamCollisionEnabled

### <a id="property:CoreMesh.isEnemyCollisionEnabled"></a>CoreMesh.isEnemyCollisionEnabled

### <a id="property:CoreMesh.isCameraCollisionEnabled"></a>CoreMesh.isCameraCollisionEnabled

You can set a mesh to belong to a particular "team". These match the teams that players can be set to. (0-4)  There are also several properties that are keyed to what team an object is on.

This sample sets a mesh (and all of its children) to be on a particular team.

You can also control whether the camera is allowed to clip into a mesh or not.

```lua
function AssignMeshToTeam(mesh, team)
    local objects = mesh:FindDescendantsByType("CoreMesh")
    table.insert(objects, mesh)
    for k, mesh in ipairs(objects) do
        -- Set the team
        mesh.team = team
        -- Make the mesh tinted based on the color of the team it is on.
        mesh.isTeamColorUsed = true
        -- Enable collision for enemies, but not allies.
        mesh.isTeamCollisionEnabled = false
        mesh.isEnemyCollisionEnabled = true
        -- Set the camera to not collide with this mesh.
        mesh.isCameraCollisionEnabled = true
    end
end
AssignMeshToTeam(cube, 1)
```

## CoreObject

### <a id="event:CoreObject.childAddedEvent"></a>CoreObject.childAddedEvent

This event fires when something gets added as a direct child of an object.  (i. e. not a child of a child.)

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")
local obj = World.SpawnAsset(propCubeTemplate)

local function ChildAdded()
    -- This code will be executed every time a child is added to the object.
    UI.PrintToScreen("A child was added to the object!")
end

obj.childAddedEvent:Connect(ChildAdded)

-- This will cause ChildAdded to execute.
local obj2 = World.SpawnAsset(propCubeTemplate, {parent = obj})

-- This will NOT cause ChildAdded to execute, because obj3 is not a direct child of obj.
local obj3 = World.SpawnAsset(propCubeTemplate, {parent = obj2})
```

### <a id="event:CoreObject.childRemovedEvent"></a>CoreObject.childRemovedEvent

This event fires when a direct child of the object is removed.

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")
local obj = World.SpawnAsset(propCubeTemplate)

local function ChildRemoved()
    -- This code will be executed every time a child is removed from the object.
    UI.PrintToScreen("A child was removed from the object!")
end

obj.childRemovedEvent:Connect(ChildRemoved)

local obj2 = World.SpawnAsset(propCubeTemplate, {parent = obj})

-- This will cause ChildRemoved to fire, because we are removing a child from obj.
obj2:Destroy()
```

### <a id="event:CoreObject.descendantAddedEvent"></a>CoreObject.descendantAddedEvent

This event fires when something gets added as a direct child of an object.  (i. e. not a child of a child.)

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")
local obj = World.SpawnAsset(propCubeTemplate)

local function DescendantAdded()
    -- This code will be executed every time a child is added to the object, or one of its children.
    UI.PrintToScreen("A descendant was added to the object!")
end

obj.descendantAddedEvent:Connect(DescendantAdded)

-- This will cause DescendantAdded to execute.
local obj2 = World.SpawnAsset(propCubeTemplate, {parent = obj})

-- This will also cause DescendantAdded to execute, because obj3 is a descendant of obj.
local obj3 = World.SpawnAsset(propCubeTemplate, {parent = obj2})
```

### <a id="event:CoreObject.descendantRemovedEvent"></a>CoreObject.descendantRemovedEvent

This event fires when a descendant of the object is removed.  This is any object that has the object somewhere up the hierarchy tree as a parent.

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")
local obj = World.SpawnAsset(propCubeTemplate)

local function DescendantRemoved()
    -- This code will be executed every time a descendant is removed from the object.
    UI.PrintToScreen("A descendant was removed from the object!")
end

obj.descendantRemovedEvent:Connect(DescendantRemoved)

local obj2 = World.SpawnAsset(propCubeTemplate, {parent = obj})
local obj3 = World.SpawnAsset(propCubeTemplate, {parent = obj2})

-- This will cause DescendantRemoved to fire, because we are removing a descendant from obj.
obj3:Destroy()
-- This will also cause DescendantRemoved to fire, because we are removing a descendant from obj.
obj2:Destroy()
```

### <a id="event:CoreObject.destroyEvent"></a>CoreObject.destroyEvent

### <a id="function:CoreObject.Destroy"></a>CoreObject.Destroy

### <a id="property:CoreObject.lifeSpan"></a>CoreObject.lifeSpan

There are several ways of destroying coreobjects, and noticing when they are destroyed.

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")

function OnDestroyListener(obj)
    print(obj.name .. " has been destroyed!")
end

local template1 = World.SpawnAsset(propCubeTemplate)
local template2 = World.SpawnAsset(propCubeTemplate, {parent = template1})

-- You can destroy an object directly, via the Destroy() method.
-- Children are also automatically destroyed when their parent is destroyed.

template1.destroyEvent:Connect(OnDestroyListener)
template2.destroyEvent:Connect(OnDestroyListener)

template1.name = "Template 1"
template2.name = "Template 2"

template1:Destroy()

-- output:
-- Template 2 has been destroyed!
-- Template 1 has been destroyed!

-- You can also set the lifeSpan of objects. They will destroy themselves in
-- that many seconds.
local template3 = World.SpawnAsset(propCubeTemplate)
template3.name = "Template 3"
template3.destroyEvent:Connect(OnDestroyListener)
template3.lifeSpan = 1
Task.Wait(1.5)
-- Template 3 has been destroyed.


-- The timer for lifespans is set when the lifeSpan property is changed.
-- So even though the object has existed for 1 second already, setting the
-- lifeSpan to 0.5 does not immediately destroy it - instead, the object
-- is destroyed 0.5 seconds after the lifeSpan is set.
local template4 = World.SpawnAsset(propCubeTemplate)
template4.name = "Template 4"
template4.destroyEvent:Connect(OnDestroyListener)
Task.Wait(1)
template4.lifeSpan = 0.5
Task.Wait(1)
```

### <a id="function:CoreObject.AttachToPlayer"></a>CoreObject.AttachToPlayer

### <a id="function:CoreObject.AttachToLocalView"></a>CoreObject.AttachToLocalView

### <a id="function:CoreObject.Detach"></a>CoreObject.Detach

### <a id="function:CoreObject.GetAttachedToSocketName"></a>CoreObject.GetAttachedToSocketName

### <a id="function:Player.GetAttachedObjects"></a>Player.GetAttachedObjects

Whether you're building sticky-mines, or costumes, sometimes it is useful to be able to attach a `CoreObject` directly to a spot on a player.

When attaching an object to a player you need to specify the "socket" you want to attach it to. The list of legal sockets can be found on its own page in the documentation.

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")
local cube = World.SpawnAsset(propCubeTemplate)
cube.collision = Collision.FORCE_OFF

-- attach the cube to the player's head
cube:AttachToPlayer(player, "head")

-- We can also check what socket an object is attached to.
print(cube:GetAttachedToSocketName())   -- Head

-- Alternately, we can ask the player for a list of CoreObjects that
-- are attached to it:
print("Attached objects: ")
for _, v in ipairs(player:GetAttachedObjects()) do
    print(tostring(v.name))
end

cube:Detach()
```

It's also possible to attach objects to the local view on the client. Note that this only works from inside a client context:

```lua
cube:AttachToLocalView()
```

### <a id="function:CoreObject.Destroy"></a>CoreObject.Destroy

A simple example on how to destroy a CoreObject.

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")
-- This is the object you would like to destroy/remove:
local cube = World.SpawnAsset(propCubeTemplate)

cube:Destroy() -- This will destroy the object.
```

### <a id="function:CoreObject.Follow"></a>CoreObject.Follow

### <a id="function:CoreObject.LookAt"></a>CoreObject.LookAt

### <a id="function:CoreObject.LookAtContinuous"></a>CoreObject.LookAtContinuous

### <a id="function:CoreObject.LookAtLocalView"></a>CoreObject.LookAtLocalView

There are some handy convenience functions for animating certain kinds of behaviors. There is a `CoreObject:LookAt()` function, which forces a `CoreObject` to rotate itself to be facing a specific point in the world. There is a `CoreObject:Follow()` function, that tells a `CoreObject` to follow a set distance and speed behind another object. And there is a `CoreObject:LookAtContinuous()`, which tells a core object to rotate itself towards another `CoreObject` or `Player`, and keep looking at them until stopped.

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")
local movingCube = World.SpawnAsset(propCubeTemplate, {position = Vector3.New(500, -200, 100)})
local followingCube = World.SpawnAsset(propCubeTemplate, {position = Vector3.New(500, 0, 100)})
local watchingCube = World.SpawnAsset(propCubeTemplate, {position = Vector3.New(500, 200, 100)})

-- We can make an object turn to face any given point in the world:
watchingCube:LookAt(movingCube:GetWorldPosition())

-- We can also have an object keep facing a player or object, until we
-- call stopRotate. This example makes a cube move, while an other
-- cube watches it, while yet a third cube tries to follow it. (While
-- staying 200 units away.)
movingCube:MoveTo(movingCube:GetWorldPosition() + Vector3.UP * 1000, 5)
followingCube:Follow(movingCube, 500, 200)
watchingCube:LookAtContinuous(movingCube)
Task.Wait(5)
```

It's also possible to make an object always look at EVERY player. This obviously only works on objects that are in a client context, but the `LookAtLocalView` function causes a client-context object to always turn and face the local player.

```lua
    local watchingCube = World.SpawnAsset(propCubeTemplate, {position = Vector3.New(500, 200, 100)})
    watchingCube:LookAtLocalView() -- This only works in a client context!
```

### <a id="function:CoreObject.GetChildren"></a>CoreObject.GetChildren

### <a id="function:CoreObject.FindAncestorByName"></a>CoreObject.FindAncestorByName

### <a id="function:CoreObject.FindChildByName"></a>CoreObject.FindChildByName

### <a id="function:CoreObject.FindDescendantByName"></a>CoreObject.FindDescendantByName

### <a id="function:CoreObject.FindDescendantsByName"></a>CoreObject.FindDescendantsByName

### <a id="function:CoreObject.FindAncestorByType"></a>CoreObject.FindAncestorByType

### <a id="function:CoreObject.FindChildByType"></a>CoreObject.FindChildByType

### <a id="function:CoreObject.FindDescendantByType"></a>CoreObject.FindDescendantByType

### <a id="function:CoreObject.FindDescendantsByType"></a>CoreObject.FindDescendantsByType

### <a id="function:CoreObject.FindTemplateRoot"></a>CoreObject.FindTemplateRoot

### <a id="function:CoreObject.IsAncestorOf"></a>CoreObject.IsAncestorOf

### <a id="property:CoreObject.parent"></a>CoreObject.parent

You can inspect most of the hierarchy at runtime.

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")
local propSampleSoundFX = script:GetCustomProperty("SampleSoundFX")

local template1 = World.SpawnAsset(propCubeTemplate)
local template2 = World.SpawnAsset(propSampleSoundFX, {parent = template1})
local template3 = World.SpawnAsset(propCubeTemplate, {parent = template2})
local template4 = World.SpawnAsset(propSampleSoundFX, {parent = template2})

template1.name = "template1"
template2.name = "template2"
template3.name = "child"
template4.name = "child"

-- The hierarchy should now look like this:
--
-- template 1
--   +-template 2      -- Note that this one is an audio object!
--       +-template 3
--       +-template 4  -- This is also audio

-- We can get references to other things in the tree if we know their string name:
local ancestor = template4:FindAncestorByName("template1")

-- This one only looks at direct children.
local child = template1:FindChildByName("template2")

-- You can also get a list of all direct children:
local childList = template2:GetChildren()

-- CoreObjects are also aware of their own parents, if any:
print(template2.parent.name) -- template1


if ancestor:IsAncestorOf(child) then
    print("This is an ancestor!")
end

-- FindDescendantByName will return the *first* descendant that matches the name.
local descendant = template1:FindDescendantByName("child")
-- descendant now equals template3

-- FindDescendantsByName will return an array of ALL the descendants who match the name.
local descendantList = template1:FindDescendantsByName("child")
-- descendantList is an array that contains {template3, template4}

-- We can also search by object type. template2 is an Audio object, so we can search for it:
local audioDescendant = template1:FindDescendantByType("Audio")
local audioDescendantList = template1:FindDescendantsByType("Audio")
-- audioDescendantList is an array that contains {template2, template4}

-- FindChildByType will only look at direct children.
local child = template1:FindChildByType("Audio")
-- Should give us template2

-- We can search up the tree by type as well:
local ancestorByType = template3:FindAncestorByType("StaticMesh")
-- This one goes all the way up the tree and returns template 1, because template3's direct
-- parent is an Audio object and not a StaticMesh.

-- If we have a reference to an object in a template, we can also find the root of the template.
local templateRoot = template1:FindTemplateRoot()
-- this should just give us back Template1, because it is already the root.
```

### <a id="function:CoreObject.GetCustomProperties"></a>CoreObject.GetCustomProperties

### <a id="function:CoreObject.GetCustomProperty"></a>CoreObject.GetCustomProperty

Almost any object in the hierarchy can have "custom properties" associated with it. These are values that you can change in the editor, but that scripts can easily access. They're useful for making modular components that can be configured without needing to modify Lua code. You can specify the data type of a custom property, to tell the Core editor what sort of data you plan on storing in there.

In this example, we've added some custom properties onto the script, to demonstrate how to access them.

Specifically, we've added the following custom types to our script:

`BestFood` : String

`NumberOfCats` : Int

`FavoriteColor` : Color

```lua
-- We can read from custom properties directly, if we know their name:
-- When you add a custom property, code like this is auto-generated in the
-- inspector window, and can be easily cut-and-pasted into your script!
local propBestFood = script:GetCustomProperty("BestFood")
local propNumberOfCats = script:GetCustomProperty("NumberOfCats")
local propFavoriteColor = script:GetCustomProperty("FavoriteColor")

-- In some cases, a script might not know which custom properties exist.
-- We can request a list of ALL custom properties, in table form:

for propName, propValue in pairs(script:GetCustomProperties()) do
    print("Found property [" .. propName .. "] with value [" .. tostring(propValue) .. "]")
end
```

### <a id="function:CoreObject.GetTransform"></a>CoreObject.GetTransform

### <a id="function:CoreObject.SetTransform"></a>CoreObject.SetTransform

### <a id="function:CoreObject.GetPosition"></a>CoreObject.GetPosition

### <a id="function:CoreObject.SetPosition"></a>CoreObject.SetPosition

### <a id="function:CoreObject.GetRotation"></a>CoreObject.GetRotation

### <a id="function:CoreObject.SetRotation"></a>CoreObject.SetRotation

### <a id="function:CoreObject.GetScale"></a>CoreObject.GetScale

### <a id="function:CoreObject.SetScale"></a>CoreObject.SetScale

### <a id="function:CoreObject.GetWorldTransform"></a>CoreObject.GetWorldTransform

### <a id="function:CoreObject.SetWorldTransform"></a>CoreObject.SetWorldTransform

### <a id="function:CoreObject.GetWorldPosition"></a>CoreObject.GetWorldPosition

### <a id="function:CoreObject.SetWorldPosition"></a>CoreObject.SetWorldPosition

### <a id="function:CoreObject.GetWorldRotation"></a>CoreObject.GetWorldRotation

### <a id="function:CoreObject.SetWorldRotation"></a>CoreObject.SetWorldRotation

### <a id="function:CoreObject.GetWorldScale"></a>CoreObject.GetWorldScale

### <a id="function:CoreObject.SetWorldScale"></a>CoreObject.SetWorldScale

One of the most common basic thing you will want to do, is move things around in the world. All CoreObjects have a Transform, which represents where they are, which direction they are facing, and what size they are. You can read or write this, either as a whole `Transform` object, or by its components. (Scale, Rotation and Position)

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")
local cube1 = World.SpawnAsset(propCubeTemplate)
local cube2 = World.SpawnAsset(propCubeTemplate)

cube2.parent = cube1

cube1:SetWorldPosition(Vector3.New(0, 500, 100))
cube2:SetPosition(Vector3.New(0, 200, 0))
-- Cube 1 has been placed in the world, and cube2 has been placed, relative to cube1.

print("cube2 relative position: " .. tostring(cube2:GetPosition()))      -- X=0.000 Y=200.000 Z=0.000
print("cube2 world position:    " .. tostring(cube2:GetWorldPosition())) -- X=0.000 Y=700.000 Z=100.000

cube1:SetWorldRotation(cube1:GetWorldRotation() + Rotation.New(0, 0, 90))
cube2:SetRotation(cube2:GetRotation() + Rotation.New(0, 0, 90))
-- Both cubes have been rotated by 90 degrees, but cube2 gets the combined rotation
-- because it is the child of cube1.

print("cube2 relative rotation: " .. tostring(cube2:GetRotation()))      -- X=0.000 Y=0.000 Z=90.000
print("cube2 world rotation:    " .. tostring(cube2:GetWorldRotation())) -- X=0.000 Y=0.000 Z=180.000

cube1:SetWorldScale(cube1:GetWorldScale() * 2)
cube2:SetScale(cube2:GetScale() * 2)
-- Both cubes have been doubled in size. But again, the child cube (cube2) also takes the scale
-- of the parent. (cube1)
print("cube2 relative scale:    " .. tostring(cube2:GetScale()))      -- X=2.000 Y=2.000 Z=2.000
print("cube2 world scale:       " .. tostring(cube2:GetWorldScale())) -- X=4.000 Y=4.000 Z=4.000


-- It's also possible to read and write the entire transform at once!
local cube3 = World.SpawnAsset(propCubeTemplate)
local cube4 = World.SpawnAsset(propCubeTemplate)
cube4.parent = cube1

cube3:SetWorldTransform(cube1:GetWorldTransform())
cube4:SetTransform(cube2:GetTransform())

-- Cube1 and cube3 now have the same transforms, and cube2 and cube4 also match.
```

### <a id="function:CoreObject.GetVelocity"></a>CoreObject.GetVelocity

### <a id="function:CoreObject.SetVelocity"></a>CoreObject.SetVelocity

### <a id="function:CoreObject.GetAngularVelocity"></a>CoreObject.GetAngularVelocity

### <a id="function:CoreObject.SetAngularVelocity"></a>CoreObject.SetAngularVelocity

### <a id="function:CoreObject.SetLocalAngularVelocity"></a>CoreObject.SetLocalAngularVelocity

Some core objects are handled by the physics system. Anything that is marked as "debris physics" is such an object, as well as some special objects in the catalog, such as "Physics Sphere".

For objects like this, you can set their velocity and angular velocity directly.

```lua
local propPhysicsSphere = script:GetCustomProperty("PhysicsSphere")
local sphere = World.SpawnAsset(propPhysicsSphere, {position = Vector3.New(500, -200, 300)})

sphere:SetVelocity(Vector3.UP * 1000)
sphere:SetAngularVelocity(Vector3.UP * 1000)

Task.Wait(2)
-- Cut the velocity (and angular velocity) down to 25%
sphere:SetVelocity(sphere:GetVelocity() * 0.25)
sphere:SetAngularVelocity(sphere:GetAngularVelocity() * 0.25)


-- You can also set the angular velocity in local space, relative to the angular
-- velocity of its parent, if any:
sphere:SetLocalAngularVelocity(sphere:GetAngularVelocity() * 0.25)
```

### <a id="function:CoreObject.MoveTo"></a>CoreObject.MoveTo

### <a id="function:CoreObject.RotateTo"></a>CoreObject.RotateTo

### <a id="function:CoreObject.ScaleTo"></a>CoreObject.ScaleTo

### <a id="function:CoreObject.MoveContinuous"></a>CoreObject.MoveContinuous

### <a id="function:CoreObject.RotateContinuous"></a>CoreObject.RotateContinuous

### <a id="function:CoreObject.ScaleContinuous"></a>CoreObject.ScaleContinuous

### <a id="function:CoreObject.StopMove"></a>CoreObject.StopMove

### <a id="function:CoreObject.StopRotate"></a>CoreObject.StopRotate

### <a id="function:CoreObject.StopScale"></a>CoreObject.StopScale

There are quite a few functions that make it easy to animate `CoreObject`s in your game. Since most things are `CoreObject`s, this gives you a lot of flexibility in creating animations for a wide variety of objects!

`MoveTo()`, `RotateTo()` and `ScaleTo()` are the most basic, and they allow you to change a `CoreObject`'s position, rotation, or scale over time. The base version of these functions just takes a destination position/scale/rotation, and how much time it should take to get there.

There are also continuous versions of these functions, that cause a `CoreObject` to continuously change position/scale/rotation forever, or until told to stop.

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")
local movingCube = World.SpawnAsset(propCubeTemplate, {position = Vector3.New(500, -200, 100)})
local spinningCube = World.SpawnAsset(propCubeTemplate, {position = Vector3.New(500, 0, 100)})
local shrinkingCube = World.SpawnAsset(propCubeTemplate, {position = Vector3.New(500, 200, 100)})

local transitionTime = 5

-- These functions will make cubes rise, spin, and shrink, over the next 5 seconds.
movingCube:MoveTo(movingCube:GetWorldPosition() + Vector3.UP * 1000, transitionTime)
spinningCube:RotateTo(Rotation.New(0, 0, 179), transitionTime)
shrinkingCube:ScaleTo(Vector3.ZERO, transitionTime)

Task.Wait(transitionTime)

-- These functions will make the cubes fall, spin, and grow indefinitely, until stopped.
movingCube:MoveContinuous(Vector3.UP * -100)
spinningCube:RotateContinuous(Rotation.New(0, 0, 20))
shrinkingCube:ScaleContinuous(Vector3.New(0.2, 0.2, 0.2))

-- And here, 2 seconds later, we stop them!
Task.Wait(2)
movingCube:StopMove()
spinningCube:StopRotate()
shrinkingCube:StopScale()
```

### <a id="function:CoreObject.SetNetworkedCustomProperty"></a>CoreObject.SetNetworkedCustomProperty

### <a id="event:CoreObject.networkedPropertyChangedEvent"></a>CoreObject.networkedPropertyChangedEvent

### <a id="function:CoreObject.GetReference"></a>CoreObject.GetReference

Networked custom properties are a special kind of custom property that can be used to communicate with client contexts. (They're actually one of the few ways that the server can send data that a client context can respond to!)

To create a networked custom property, right click a custom property in the Core editor, and select "Enable Property Networking."

Once a custom property has been set to be networked, the server can change its value at runtime via `SetNetworkedCustomProperty()`, and the client can listen for changes to that property via `networkedPropertyChangedEvent`.

In this sample, it is assumed that the script has a custom networked property.

In a client context, we can set up listeners to tell us when a custom property changes, and what its current value is:

```lua
-- Client context:
script.networkedPropertyChangedEvent:Connect(function(coreObject, propertyName)
    print("The networked property [" .. coreObject.name .. "] just had its ["
            .. propertyName .. "] property changed.")

    local newValue = script:GetCustomProperty(propertyName)
    print("New value: " .. tostring(newValue))
end)
```

Now, if the server changes the custom property, the client is notified:

```lua

-- Server context:
script:SetNetworkedCustomProperty("NetworkedGreeting", "Buenos Dias")

-- The client should print out:
-- The networked property [test_CoreObject] just had its [NetworkedGreeting] property changed.
-- New value: Buenos Dias
```

In addition to basic types (strings, integers, colors, etc) you can also pass references to core objects via networked custom properties. This is really useful if you want to have a client-side script know about a particular networked object.

To do this, you need to first convert the `CoreObject` into a `CoreObjectReference`.

```lua
-- Server context:
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")
local cube = World.SpawnAsset(propCubeTemplate)
script:SetNetworkedCustomProperty("NetworkedCoreObjectReference", cube:GetReference())
```

### <a id="property:CoreObject.name"></a>CoreObject.name

### <a id="property:CoreObject.id"></a>CoreObject.id

### <a id="property:CoreObject.sourceTemplateId"></a>CoreObject.sourceTemplateId

### <a id="property:CoreObject.isStatic"></a>CoreObject.isStatic

### <a id="property:CoreObject.isClientOnly"></a>CoreObject.isClientOnly

### <a id="property:CoreObject.isServerOnly"></a>CoreObject.isServerOnly

### <a id="property:CoreObject.isNetworked"></a>CoreObject.isNetworked

You can find out a lot about an object via its CoreProperties.

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")

local template = World.SpawnAsset(propCubeTemplate)

-- The name of the object is its name in the hierarchy, or the name of the
-- template it was spawned from.
print("Name: " .. template.name)
-- The ID of the object is its core object reference. (A MUID)
print("Id: " .. template.id)
-- The source template id is the MUID of template it was spawned from.
-- (Or nil if it was just placed in the hierarchy at edit-time.)
print("sourceTemplateId: " .. template.sourceTemplateId)


-- You can also tell if an object is networked, and if it is in a static, client, or server context:
if template.isNetworked then
    print("It is networked!")
else
    print("It is not networked!")
end
if template.isClientOnly then print("It is Client only!") end
if template.isServerOnly then print("It is Server only!") end
if template.isStatic then print("It is Static") end

-- Output:
--    Name: GoldCube
--    Id: E355483D7F78F3B1:GoldCube
--    sourceTemplateId: AF4DDC200B982801
--    It is networked!
```

### <a id="property:CoreObject.visibility"></a>CoreObject.visibility

### <a id="property:CoreObject.collision"></a>CoreObject.collision

### <a id="property:CoreObject.isEnabled"></a>CoreObject.isEnabled

### <a id="function:CoreObject.IsVisibleInHierarchy"></a>CoreObject.IsVisibleInHierarchy

### <a id="function:CoreObject.IsCollidableInHierarchy"></a>CoreObject.IsCollidableInHierarchy

### <a id="function:CoreObject.IsEnabledInHierarchy"></a>CoreObject.IsEnabledInHierarchy

You can make objects appear and disappear in the world in several different ways.

By changing their `visibility` property, you can make them appear or disappear, but they will otherwise still exist. (Players can collide with them, etc.)

By changing their `collision` property, you can make the object something that players (and other objects) can no longer collide with. The object will still be visible though.

You can also completely disable an object, via the `isEnabled` property. Objects with `isEnabled` set to `false` cannot be seen or collided with, nor can any of their children.

Both collision and visibility have three possible values:  `FORCE_ON`, `FORCE_OFF` and `INHERIT`. By default, things are set to `INHERIT`, which means they will have whatever visibility or collision settings their parent object has. This makes it convenient to hide or remove collision from a whole group of things, by simply changing the settings of the root object.

`FORCE_ON` and `FORCE_OFF` override this, and force the object to be collidable or visible (or not) regardless of the state of their parents.

It is sometimes useful to know if an object is currently visible/collidable/enabled. Because this may depend on the state of its parents, there are several convenience functions that allow you to check, without having to climb the hierarchy yourself.

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")
local cube1 = World.SpawnAsset(propCubeTemplate)
local cube2 = World.SpawnAsset(propCubeTemplate)
cube2.parent = cube1


-- Cube2 is now the child of cube1.
-- By default they both off with Visibility.INHERIT and Collision.INHERIT
print("default state:")
print("cube2 visible?    " .. tostring(cube2:IsVisibleInHierarchy()))
print("cube2 collidable? " .. tostring(cube2:IsCollidableInHierarchy()))
print("cube2 enabled?    " .. tostring(cube2:IsEnabledInHierarchy()))
-- These should all be true when we start.

-- If we set cube1 to be disabled, then cube2 is no longer visible or collidable:
cube1.isEnabled = false
print("parent disabled:")
print("cube2 visible?    " .. tostring(cube2:IsVisibleInHierarchy()))
print("cube2 collidable? " .. tostring(cube2:IsCollidableInHierarchy()))
print("cube2 enabled?    " .. tostring(cube2:IsEnabledInHierarchy()))

-- Note that isEnabled overrides visibility/collision settings. So even
-- if we set cube2 to force its visibility and collision on, they are
-- still overridden as long as its parent is disabled:
print("parent disabled, but forcing things on:")
cube2.visibility = Visibility.FORCE_ON
cube2.collision = Collision.FORCE_ON
print("cube2 visible?    " .. tostring(cube2:IsVisibleInHierarchy()))
print("cube2 collidable? " .. tostring(cube2:IsCollidableInHierarchy()))
-- These are both false because the parent is still disabled.

-- On the other hand, if we set cube1 to enabled, but FORCE_OFF for
-- collision and visibility, cube2 is now visible and collidable, because
-- it is still FORCE_ON for both values, meaning it ignores its parent.
cube1.visibility = Visibility.FORCE_OFF
cube1.collision = Collision.FORCE_OFF
cube1.isEnabled = true
print("cube2 visible?    " .. tostring(cube2:IsVisibleInHierarchy()))
print("cube2 collidable? " .. tostring(cube2:IsCollidableInHierarchy()))
-- These are both true now because the parent is no longer disabled.
```

## CoreObjectReference

### <a id="function:CoreObjectReference.GetObject"></a>CoreObjectReference.GetObject

### <a id="function:CoreObjectReference.WaitForObject"></a>CoreObjectReference.WaitForObject

### <a id="property:CoreObjectReference.id"></a>CoreObjectReference.id

### <a id="property:CoreObjectReference.isAssigned"></a>CoreObjectReference.isAssigned

Sometimes you need to pass around a reference to a core object, instead of the actual object itself. This is most common when accessing custom properties - any core objects you have attached as custom properties are stored as `CoreObjectReferences`.

A `CoreObjectReference` is basically just a placeholder that you can use to access the original object. Except unlike the original object, the `CoreObjectReference` is small and light, and can be passed around via Networked Custom Properties and Events.

This sample assumes that the script has a custom property of type `CoreObjectReference`, which refers to the default floor in the scene.

```lua
-- The autogenerated code to access the custom property looks like this:
local propDefaultFloor = script:GetCustomProperty("DefaultFloor"):WaitForObject()
-- Since you usually don't care about the reference itself, and just want to
-- access the object, it normally appends WaitForObject(), to return the object
-- after waiting for it to load.

local floorObjectReference = script:GetCustomProperty("DefaultFloor")


-- If we didn't care about the object (possibly) not being loaded yet, we could
-- also just get the object directly:

local propDefaultFloor_noWaiting = floorObjectReference:GetObject()


-- We can also check things on the reference directly, such as if it has been
-- assigned to an object, and the MUID of the object it references:
if floorObjectReference.isAssigned then
    print("The MUD is: " .. floorObjectReference.id)
end
```

## Damage

### <a id="constructor:Damage.New"></a>Damage.New

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

### <a id="method:Damage.GetHitResult"></a>Damage.GetHitResult

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

### <a id="method:Damage.SetHitResult"></a>Damage.SetHitResult

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

### <a id="property:Damage.amount"></a>Damage.amount

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

### <a id="property:Damage.reason"></a>Damage.reason

The damage reason can be used to specify the source of the damage and is useful, for example, when attributing score based on kills. In this example, players take 1 damage per second when they are within 20 meters of the center of the map. If another part of the game listens to the Player's diedEvent, it would be able to tell the difference between players being killed by the environment as opposed to killed by another player.

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

### <a id="property:Damage.sourceAbility"></a>Damage.sourceAbility

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

### <a id="property:Damage.sourcePlayer"></a>Damage.sourcePlayer

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

### <a id="event:Equipment.equippedEvent"></a>Equipment.equippedEvent

### <a id="event:Equipment.unequippedEvent"></a>Equipment.unequippedEvent

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

### <a id="method:Equipment.AddAbility"></a>Equipment.AddAbility

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

for i, ability in ipairs(EQUIPMENT:GetAbilities()) do
    print("Ability " .. i .. " = " .. ability.name)
end
```

### <a id="method:Equipment.Equip"></a>Equipment.Equip

This example shows how players can be given default equipment when they join a game.

```lua
local EQUIPMENT_TEMPLATE = script:GetCustomProperty("EquipmentTemplate")

function OnPlayerJoined(player)
    local equipment = World.SpawnAsset(EQUIPMENT_TEMPLATE)
    equipment:Equip(player)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

### <a id="method:Equipment.GetAbilities"></a>Equipment.GetAbilities

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

### <a id="method:Equipment.Unequip"></a>Equipment.Unequip

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
        DropToGround(equipment)
    end
end

function OnPlayerJoined(player)
    player.diedEvent:Connect(OnPlayerDied)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

### <a id="property:Equipment.owner"></a>Equipment.owner

In this example, a weapon has a healing mechanic, where the player gains 2 hit points each time they shoot an enemy player.

```lua
local WEAPON = script:FindAncestorByType('Weapon')

function OnTargetImpactedEvent(weapon, impactData)
    if impactData.targetObject and impactData.targetObject:IsA("Player") then
        weapon.owner.hitPoints = weapon.owner.hitPoints + 2
    end
end

WEAPON.targetImpactedEvent:Connect(OnTargetImpactedEvent)
```

### <a id="property:Equipment.socket"></a>Equipment.socket

The socket is the attachment point on the player where the equipment will be placed. In this example, the socket property is used for comparing between the new equipment and any previous ones. If there's a competition for the same socket then the old equipment is dropped. This script expects to be placed as a child of the equipment and the equipment's default "Pickup Trigger" property should be cleared, as that behavior is re-implemented in the `OnInteracted()` function. Without re-implementing our own `interactedEvent`, by default the old equipment would be destroyed, instead of dropped, when there is competition for a socket.

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

## Event

### <a id="method:Event.Connect"></a>Event.Connect

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

### <a id="method:EventListener.Disconnect"></a>EventListener.Disconnect

### <a id="property:EventListener.isConnected"></a>EventListener.isConnected

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

### <a id="classfunction:Events.BroadcastToAllPlayers"></a>Events.BroadcastToAllPlayers

This event connection allows the server to send a message to all players. In this example, two scripts communicate over the network. The first one is on the server as child of a Trigger and the second one is in a Client Context. The server is authoritative over the state of the flag being captured and listens for overlaps on the Trigger. When a new team captures the flag a message is sent to all clients with information about who captured and what team they belong to.

Server script:

```lua
local teamHasFlag = 0

function OnBeginOverlap(trigger, other)
    if other and other:IsA("Player") and other.team ~= teamHasFlag then
        teamHasFlag = other.team

        local resultCode, errorMsg = Events.BroadcastToAllPlayers("FlagCaptured", other.name, other.team)
        print("Server sent FlagCaptured event. Result Code = " .. resultCode .. ", error message = " .. errorMsg)
    end
end

script.parent.beginOverlapEvent:Connect(OnBeginOverlap)
```

Client script:

```lua
function OnFlagCaptured(playerName, playerTeam)
    local message = playerName .. " captured the flag for team " .. playerTeam

    UI.PrintToScreen(message, Color.MAGENTA)
    print(message)
end

Events.Connect("FlagCaptured", OnFlagCaptured)
```

### <a id="classfunction:Events.BroadcastToPlayer"></a>Events.BroadcastToPlayer

If your script runs on a server, you can broadcast game-changing information to your players. In this example, the OnExecute function was connected to an ability object's executeEvent. This bandage healing ability depends on a few conditions, such as bandages being available in the inventory and the player having actually lost any hit points. If one of the conditions is not true, the broadcast function is used for delivering a user interface message that only that player will see.

```lua
local ABILITY

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

ABILITY.executeEvent:Connect(OnExecute)
```

### <a id="classfunction:Events.Connect"></a>Events.Connect

### <a id="classfunction:Events.Broadcast"></a>Events.Broadcast

The `Events` namespace allows two separate scripts to communicate without the need to reference each other directly. In this example, two scripts communicate through a custom "GameStateChanged" event. The first one has the beginnings of a state machine and broadcasts the event each time the state changes. The second script listens for that specific event. This is a non-networked message.

Primary script that drives the state machine:

```lua
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

A separate script that listens to event changes:

```lua
function OnStateChanged(newState)
    print("New State = " .. newState)
end
Events.Connect("GameStateChanged", OnStateChanged)
```

### <a id="classfunction:Events.ConnectForPlayer"></a>Events.ConnectForPlayer

### <a id="classfunction:Events.BroadcastToServer"></a>Events.BroadcastToServer

This event connection allows the server to listen for broadcasts that originate from clients. In this example, two scripts communicate over the network. The first one is in a Server Context and the second one is in a Client Context. The client can send input data to the server, in this case their cursor's position.

Server script:

```lua
function OnPlayerInputData(player, data)
    print("Player " .. player.name .. " sent  data = " .. tostring(data))
end

Events.ConnectForPlayer("CursorPosition", OnPlayerInputData)
```

Client script:

```lua
UI.SetCursorVisible(true)

function Tick(deltaTime)
    local cursorPos = UI.GetCursorPosition()
    Events.BroadcastToServer("CursorPosition", cursorPos)
    Task.Wait(0.25)
end
```

## Game

### <a id="classfunction:Game.FindNearestPlayer"></a>Game.FindNearestPlayer

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

### <a id="classfunction:Game.FindPlayersInCylinder"></a>Game.FindPlayersInCylinder

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

### <a id="classfunction:Game.FindPlayersInSphere"></a>Game.FindPlayersInSphere

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

### <a id="classfunction:Game.GetLocalPlayer"></a>Game.GetLocalPlayer

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

### <a id="classfunction:Game.GetPlayers"></a>Game.GetPlayers

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

### <a id="classfunction:Game.GetTeamScore"></a>Game.GetTeamScore

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

### <a id="classfunction:Game.ResetTeamScores"></a>Game.ResetTeamScores

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

    -- Prepare for the next round
    Game.ResetTeamScores()
end

Game.roundEndEvent:Connect(OnRoundEnd)
```

### <a id="classfunction:Game.SetTeamScore"></a>Game.SetTeamScore

Team scores don't have to represent things such as kills or points--they can be used for keeping track of and displaying abstract gameplay state. In this example, score for each team is used to represent how many players of that team are within 8 meters of the script.

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

### <a id="classfunction:Game.StartRound"></a>Game.StartRound

### <a id="classfunction:Game.EndRound"></a>Game.EndRound

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

### <a id="staticevent:Game.playerJoinedEvent"></a>Game.playerJoinedEvent

### <a id="staticevent:Game.playerLeftEvent"></a>Game.playerLeftEvent

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
    for _, p in ipairs(allPlayers) do
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

### <a id="staticevent:Game.roundEndEvent"></a>Game.roundEndEvent

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
    for _, player in ipairs(allPlayers) do
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

### <a id="staticevent:Game.roundStartEvent"></a>Game.roundStartEvent

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

### <a id="staticevent:Game.teamScoreChangedEvent"></a>Game.teamScoreChangedEvent

### <a id="classfunction:Game.IncreaseTeamScore"></a>Game.IncreaseTeamScore

### <a id="classfunction:Game.DecreaseTeamScore"></a>Game.DecreaseTeamScore

In this example, when a player jumps their team gains 1 point and when they crouch their team loses 1 point. The `OnTeamScoreChanged` function is connected to the event and prints the new score to the Event Log each time they change.

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

## HitResult

### <a id="method:HitResult.GetImpactPosition"></a>HitResult.GetImpactPosition

### <a id="method:HitResult.GetImpactNormal"></a>HitResult.GetImpactNormal

This example shows the power of `World.Raycast()` which returns data in the form of a `HitResult`. The physics calculation starts from the center of the camera and shoots forward. If the player is looking at something, then a reflection vector is calculated as if a shot ricocheted from the surface. Debug information is drawn about the ray, the impact point and the reflection. This script must be placed under a Client Context and works best if the scene has objects or terrain.

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

### <a id="method:HitResult.GetTransform"></a>HitResult.GetTransform

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

### <a id="property:HitResult.other"></a>HitResult.other

### <a id="property:HitResult.socketName"></a>HitResult.socketName

HitResult is used by Weapons to transmit data about the interaction. In this example, the `other` property is used in figuring out if the object hit was another player. If so, then the `socketName` property tells us exactly where on the player's body the hit occurred, allowing more detailed gameplay systems.

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

## ImpactData

### <a id="method:ImpactData.GetHitResult"></a>ImpactData.GetHitResult

HitResult is used by Weapons to transmit data about the interaction. In this example, the `socketName` property is used in determining how much damage to apply, depending on what part of the target's body was hit. For this to work, the weapon's default damage number should be set to zero, with all damage applied through this script.

```lua
local WEAPON = script:FindAncestorByType('Weapon')

local HEADSHOT_DAMAGE = WEAPON:GetCustomProperty("HeadshotDamage")
local NECK_DAMAGE = WEAPON:GetCustomProperty("NeckDamage")
local TORSO_DAMAGE = WEAPON:GetCustomProperty("TorsoDamage")
local LIMB_DAMAGE = WEAPON:GetCustomProperty("BaseDamage")

function OnTargetImpacted(weapon, impactData)
    local target = impactData.targetObject

    -- Apply damage to target only if it's a player
    if Object.IsValid(target) and target:IsA("Player") then
        local hitResult = impactData:GetHitResult()
        local socketName = hitResult.socketName

        -- Figure out how much damage this did
        local amount = LIMB_DAMAGE
        if impactData.isHeadshot then
            amount = HEADSHOT_DAMAGE

        elseif socketName == "neck"
        or socketName == "left_clavicle"
        or socketName == "right_clavicle" then
            amount = NECK_DAMAGE

        elseif socketName == "pelvis"
        or socketName == "lower_spine"
        or socketName == "upper_spine" then
            amount = TORSO_DAMAGE
        end

        -- Creating damage information
        local damageInfo = Damage.New(amount)
        damageInfo.reason = DamageReason.COMBAT
        damageInfo.sourceAbility = impactData.sourceAbility
        damageInfo.sourcePlayer = impactData.weaponOwner

        -- Apply damage to the enemy player
        target:ApplyDamage(damageInfo)
    end
end

WEAPON.targetImpactedEvent:Connect(OnTargetImpacted)
```

### <a id="method:ImpactData.GetHitResults"></a>ImpactData.GetHitResults

### <a id="property:ImpactData.targetObject"></a>ImpactData.targetObject

### <a id="property:ImpactData.weaponOwner"></a>ImpactData.weaponOwner

### <a id="property:ImpactData.isHeadshot"></a>ImpactData.isHeadshot

When it comes to weapons damaging players, there is a built-in damage value that works. However, additional mechanics can be layered on top, with scripts. In this example, some weapons can have multiple shots at once (e.g. Shotgun) and headshots are defined to have a different damage value. For this to work, the weapon's default damage number should be set to zero, with all damage applied through this script.

```lua
local WEAPON = script:FindAncestorByType('Weapon')

local BASE_DAMAGE = WEAPON:GetCustomProperty("BaseDamage")
local HEADSHOT_DAMAGE = WEAPON:GetCustomProperty("HeadshotDamage")

local function OnTargetImpacted(weapon, impactData)
    local target = impactData.targetObject

    -- Apply damage to target only if it's a player
    if Object.IsValid(target) and target:IsA("Player") then

        -- Figure out how much damage this did
        local amount = BASE_DAMAGE
        if impactData.isHeadshot then
            amount = HEADSHOT_DAMAGE
        end

        -- The GetHitResults() returns a table. The # symbol gives the size of the table
        local numberOfHits = #impactData:GetHitResults()

        -- Creating damage information
        local damageInfo = Damage.New(amount * numberOfHits)
        damageInfo.reason = DamageReason.COMBAT
        damageInfo.sourceAbility = impactData.sourceAbility
        damageInfo.sourcePlayer = impactData.weaponOwner

        -- Apply damage to the enemy player
        target:ApplyDamage(damageInfo)
    end
end

WEAPON.targetImpactedEvent:Connect(OnTargetImpacted)
```

### <a id="property:ImpactData.projectile"></a>ImpactData.projectile

Projectiles that are fired from weapons cannot be controlled in the same was as projectiles that are created with `Projectile.Spawn()`. That's because they are client-predicted, which is a tradeoff that usually leads to better gameplay fidelity. That said, there are still mechanics that can be explored with access to the `ImpactData`'s projectile object. In this example, the weapon is setup with a value on the `Projectile Pierces` property. This causes shots to go through objects. In this hypothetical game we want shots that hit player limbs to go through them and hit objects behind. If the impact happened on any other object or part of their body, then we destroy the projectile.

```lua
local WEAPON = script:FindAncestorByType('Weapon')

local function StringBeginsWith(str, start)
   return str:sub(1, #start) == start
end

local function OnTargetImpacted(weapon, impactData)
    local target = impactData.targetObject
    local projectile = impactData.projectile

    if Object.IsValid(target) and target:IsA("Player") then
        local hitResult = impactData:GetHitResult()
        local socketName = hitResult.socketName

        if not StringBeginsWith(socketName, "left")
        and not StringBeginsWith(socketName, "right") then
            -- The projectile hit a player, but not on a limb
            projectile:Destroy()
        end
    else
        -- The projectile hit a non-player object
        projectile:Destroy()
    end
end

WEAPON.targetImpactedEvent:Connect(OnTargetImpacted)
```

### <a id="property:ImpactData.sourceAbility"></a>ImpactData.sourceAbility

In this example, the shoot ability is manipulated as a result of the `targetImpactEvent`. If the shot was a headshot the ability continues as normal and will immediately refresh. However, if it was not a headshot there is an additional 1 second delay during which the player can't use the shoot ability.

```lua
local WEAPON = script:FindAncestorByType('Weapon')

local function OnTargetImpacted(weapon, impactData)
    local attackAbility = impactData.sourceAbility

    if Object.IsValid(attackAbility)
    and not impactData.isHeadshot then
        attackAbility.isEnabled = false

        Task.Wait(1)

        if Object.IsValid(attackAbility) then
            attackAbility.isEnabled = true
        end
    end
end

WEAPON.targetImpactedEvent:Connect(OnTargetImpacted)
```

### <a id="property:ImpactData.travelDistance"></a>ImpactData.travelDistance

The `travelDistance` property tells us the distance (in centimeters) between the origin of the shot and the impact point. In this example, we use that information to create a weapon that deals variable damage, depending on the distance. It could be configured to do either maximum damage at maximum range or minimum damage at the max range, all dependant upon custom property values. For this to work, the weapon's default damage number should be set to zero, with all damage applied through this script.

```lua
local WEAPON = script:FindAncestorByType('Weapon')

local DAMAGE_AT_MIN = WEAPON:GetCustomProperty("MinDamage")
local DAMAGE_AT_MAX = WEAPON:GetCustomProperty("MaxDamage")
local MIN_DAMAGE_RANGE = WEAPON:GetCustomProperty("MinDamageRange")
local MAX_DAMAGE_RANGE = WEAPON:GetCustomProperty("MaxDamageRange")

local function OnTargetImpacted(weapon, impactData)
    local target = impactData.targetObject

    -- Apply damage to target only if it's a player
    if Object.IsValid(target) and target:IsA("Player") then

        -- Figure out how much damage this did
        local percent = (impactData.travelDistance - MIN_DAMAGE_RANGE) / (MAX_DAMAGE_RANGE - MIN_DAMAGE_RANGE)
        percent = CoreMath.Clamp(percent)
        local amount = CoreMath.Lerp(DAMAGE_AT_MIN, DAMAGE_AT_MAX, percent)

        -- Creating damage information
        local damageInfo = Damage.New(amount)
        damageInfo.reason = DamageReason.COMBAT
        damageInfo.sourceAbility = impactData.sourceAbility
        damageInfo.sourcePlayer = impactData.weaponOwner

        -- Apply damage to the enemy player
        target:ApplyDamage(damageInfo)
    end
end

WEAPON.targetImpactedEvent:Connect(OnTargetImpacted)
```

### <a id="property:ImpactData.weapon"></a>ImpactData.weapon

While the `targetImpactedEvent` conveniently provides the weapon as the first parameter, the `ImpactData` that comes as the second parameter also contains a reference to the weapon. This is useful if we are forwarding the logic off to another script. In this case we only need to pass the `ImpactData` and the other script will have all the information it needs. In this example, a damage manager script is `required()` by the weapon and the combat decision is forwarded to the manager.

```lua
local WEAPON = script:FindAncestorByType('Weapon')
local COMBAT_MANAGER = require( WEAPON:GetCustomProperty("CombatManager") )

local function OnTargetImpacted(weapon, impactData)
    COMBAT_MANAGER.TargetImpacted(impactData)
end

WEAPON.targetImpactedEvent:Connect(OnTargetImpacted)
```

Combat manager script that is required by the weapon:

```lua
function TargetImpacted(impactData)
    local weapon = impactData.weapon
    local owner = impactData.sourcePlayer

    -- Life Steal mechanic
    if owner:GetResource("LifeSteal") > 0 then
        owner.hitPoints = owner.hitPoints + weapon.damage
        if owner.hitPoints > owner.maxHitPoints then
            owner.hitPoints = owner.maxHitPoints
        end
    end

    -- TODO : Other combat mechanics
    -- ...
end

-- return {
--     TargetImpacted = TargetImpacted
-- }
```

## Leaderboards

### <a id="classfunction:Leaderboards.HasLeaderboards"></a>Leaderboards.HasLeaderboards

### <a id="classfunction:Leaderboards.GetLeaderboard"></a>Leaderboards.GetLeaderboard

### <a id="classfunction:Leaderboards.SubmitPlayerScore"></a>Leaderboards.SubmitPlayerScore

### <a id="property:LeaderboardEntry.id"></a>LeaderboardEntry.id

### <a id="property:LeaderboardEntry.name"></a>LeaderboardEntry.name

### <a id="property:LeaderboardEntry.score"></a>LeaderboardEntry.score

### <a id="property:LeaderboardEntry.additionalData"></a>LeaderboardEntry.additionalData

The `Leaderboards` namespace contains a set of functions for retrieving and updating player leaderboard data.  This is a special kind of persistance that lets you save high scores for a game, with the data being associated with the game itself, rather than any particular player.

In order to use these functions, you must first create a Global Leaderboard in the Core editor.  (Select Global Leaderboards, under the View menu.)

```lua
function PrintLeaderboardEntry(entry)
    print(string.format("%s (%s): %d [%s]", entry.name, entry.id, entry.score, entry.additionalData))
end

-- To create this reference, create a custom property of type 'netreference',
-- and drag a leaderboard into it, from the Global Leaderboards tab:
local propLeaderboardRef = script:GetCustomProperty("LeaderboardRef")

-- Verify that we actually have leaderboard data to load:
if (Leaderboards.HasLeaderboards()) then
    -- Save a score to the leaderboard:
    Leaderboards.SubmitPlayerScore(propLeaderboardRef, player, math.random(0, 1000), "Xyzzy")

    -- Print out all the global scores on the leaderboard:
    print("Global scores:")
    local leaderboard = Leaderboards.GetLeaderboard(propLeaderboardRef, LeaderboardType.GLOBAL)
    for k,v in pairs(leaderboard) do
        PrintLeaderboardEntry(v)
    end

    -- Print out all the daily scores on the leaderboard:
    print("Daily scores:")
    local leaderboard = Leaderboards.GetLeaderboard(propLeaderboardRef, LeaderboardType.DAILY)
    for k,v in pairs(leaderboard) do
        PrintLeaderboardEntry(v)
    end
end
local leaderboard = Leaderboards.GetLeaderboard(propLeaderboardRef, LeaderboardType.MONTHLY)
local leaderboard = Leaderboards.GetLeaderboard(propLeaderboardRef, LeaderboardType.WEEKLY)
```

## Object

### <a id="classfunction:Object.IsValid"></a>Object.IsValid

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

### <a id="property:Object.clientUserData"></a>Object.clientUserData

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

### <a id="property:Object.serverUserData"></a>Object.serverUserData

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

        for _,player in ipairs(allConnectedPlayers) do
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

## Other

### <a id="other:IsA"></a>IsA

### <a id="other:type"></a>type

### <a id="other:type(property)"></a>type(property)

Sometimes you have a variable, but you don't know exactly what type it is. Fortunately, Lua offers several ways of checking the type at runtime, and Core expands those with a few more!

```lua
local number = 42
local text = "Example"
local cube = World.SpawnAsset(propCubeTemplate, {position = Vector3.New(1000, 0, 300) })
local player = Game.GetPlayers()[1]
local vector = Vector3.UP

-- Most types described in the Core API have a .type property, which
-- can be used to check their type. It returns a string of the typename.
print("the type of [cube] is " .. cube.type)     -- "StaticMesh"
print("the type of [player] is " .. player.type) -- "Player"
print("the type of [vector] is " .. vector.type) -- "Vector3"
-- (Note that base Lua  types (string, number, etc) do NOT have this property!)

-- These types also support the :IsA() method - it accepts a typename (as a string)
-- and returns true if the object is that type.
-- This is sometimes more useful than checking the .type directly, because :IsA()
-- returns true for parent classes of the type as well as exact matches:

print(cube:IsA("StaticMesh")) -- true
print(cube:IsA("CoreMesh"))   -- also true
print(cube:IsA("CoreObject")) -- still true!

-- You can also, of course, use the standard lua type() function, but for
-- anything other than basic lua types, it will return a type of "userdata".
print(type(cube)) -- userdata
print(type(vector)) -- also userdata
print(type(player)) -- still userdata!

-- It is useful for base lua types though!
print(type(text)) -- string
print(type(number)) -- number
```

## Player

### <a id="event:Player.bindingPressedEvent"></a>Player.bindingPressedEvent

### <a id="event:Player.bindingReleasedEvent"></a>Player.bindingReleasedEvent

### <a id="property:Player.maxWalkSpeed"></a>Player.maxWalkSpeed

### <a id="property:Player.maxSwimSpeed"></a>Player.maxSwimSpeed

Normally you can leave the Core engine to handle most of the player input. You don't need to explicitly listen to jump events, to make the player jump, for example. But sometimes it's useful to listen to keypress events directly, when creating more complicated interactions.

This sample uses the `bindingKeypressed` and `bindingKeyReleased` events to allow the player to sprint whenever the `ability_feet` keybind is held down. (Left-Shift by default)

```lua
local shiftKeyBinding = "ability_feet"

local baseSpeed = 640
local sprintingSpeed = 1280

function OnBindingPressed(player, bindingPressed)
    if bindingPressed == shiftKeyBinding then
        player.maxWalkSpeed = sprintingSpeed
    end
end

function OnBindingReleased(player, bindingReleased)
    if bindingReleased == shiftKeyBinding then
        player.maxWalkSpeed = baseSpeed
    end
end

function OnPlayerJoined(player)
    player.bindingPressedEvent:Connect(OnBindingPressed)
    player.bindingReleasedEvent:Connect(OnBindingReleased)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

### <a id="event:Player.damagedEvent"></a>Player.damagedEvent

### <a id="event:Player.diedEvent"></a>Player.diedEvent

### <a id="event:Player.respawnedEvent"></a>Player.respawnedEvent

### <a id="method:Player.ApplyDamage"></a>Player.ApplyDamage

### <a id="method:Player.Die"></a>Player.Die

### <a id="method:Player.Respawn"></a>Player.Respawn

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
    player:Respawn(Vector3.New(0, 0, 500), Rotation.New(0, 0, 45))
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
-- This will kill the player, because they only have 100 health by default.
player:ApplyDamage(Damage.New(100))
Task.Wait(2.1)
Task.Wait(2.1)
-- We can also kill the player directly, regardless of health
player:Die()
```

### <a id="event:Player.movementModeChangedEvent"></a>Player.movementModeChangedEvent

Whenever the player changes movement mode, (walking, jumping, swimming, flying), a listener is notified. We can register for that listener if we want to know whenever that happens.

This sample uses that callback to apply falling damage, whenever a player falls too far, and lands on the ground. (Which we test by checking when they transition into the jumping movement mode vs. walking.)

```lua
local jumpStartHeight = {}

local MAX_SAFE_FALL_HEIGHT = 500
local FALL_DAMAGE_MULTIPLIER = 1/10

-- Function for when the player changes mode.
function OnMovementModeChanged(player, mode)
    print("change!")
    if mode == MovementMode.FALLING then
        print("jump")
        jumpStartHeight[player] = player:GetWorldPosition().z
    elseif mode == MovementMode.WALKING then
        print("walk")
        if jumpStartHeight[player] ~= nil then
            local fallDistance = jumpStartHeight[player] - player:GetWorldPosition().z
            print("Fell " ..fallDistance)
            if fallDistance > MAX_SAFE_FALL_HEIGHT then
                local damageFromFalling = (fallDistance - MAX_SAFE_FALL_HEIGHT) * FALL_DAMAGE_MULTIPLIER
                print("Took " .. damageFromFalling .. " as fall damage!")
                player:ApplyDamage(Damage.New(damageFromFalling))
            end
        end
        jumpStartHeight[player] = nil
    else
        -- They started swimming or flying or something.
        jumpStartHeight[player] = nil
    end

end

-- Outfit all players with the movementModeChanged listener
function OnPlayerJoined(player)
    player.movementModeChangedEvent:Connect(OnMovementModeChanged)
end
Game.playerJoinedEvent:Connect(OnPlayerJoined)

-- Now we fling the player into the air for testing.
-- When they land they should take ~40 damage.
print("in the air")
player:SetWorldPosition(Vector3.New(0, 0, 1000))
print("done waiting")
```

### <a id="event:Player.resourceChangedEvent"></a>Player.resourceChangedEvent

### <a id="method:Player.ClearResources"></a>Player.ClearResources

### <a id="method:Player.GetResource"></a>Player.GetResource

### <a id="method:Player.GetResources"></a>Player.GetResources

### <a id="method:Player.SetResource"></a>Player.SetResource

### <a id="method:Player.AddResource"></a>Player.AddResource

### <a id="method:Player.RemoveResource"></a>Player.RemoveResource

While scripting, you can assign "resources" to players. These are just integer values, accessed via a string key, that are tied to a player. They are useful for storing values about game-specific resources a player might have, such as coins collected, mana remaining, levels completed, puppies pet, etc.

You can manipulate these values via several methods on the player class, as well as registering for an event when they are changed.

This sample registers a listener to ensure that values are in the 0-100 range, and demonstrates several examples of how to change the values.

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

### <a id="method:Player.ActivateFlying"></a>Player.ActivateFlying

### <a id="method:Player.ActivateWalking"></a>Player.ActivateWalking

You can set different movement modes for the player. `ActivateWalking()` will give the player normal walking physics. (They fall down, slide down slopes, etc.) `ActivateFlying`, on the other hand, makes them ignore gravity and fly around freely.

This sample allows the player to fly while holding down the shift key.

```lua
local shiftKeyBinding = "ability_feet"

function OnBindingPressed(player, bindingPressed)
    if bindingPressed == shiftKeyBinding then
        player:ActivateFlying()
    end
end

function OnBindingReleased(player, bindingReleased)
    if bindingReleased == shiftKeyBinding then
    --    player:ActivateWalking()
    end
end

function OnPlayerJoined(player)
    player.bindingPressedEvent:Connect(OnBindingPressed)
    player.bindingReleasedEvent:Connect(OnBindingReleased)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

### <a id="method:Player.AddImpulse"></a>Player.AddImpulse

### <a id="method:Player.GetVelocity"></a>Player.GetVelocity

### <a id="method:Player.SetVelocity"></a>Player.SetVelocity

### <a id="method:Player.ResetVelocity"></a>Player.ResetVelocity

### <a id="property:Player.mass"></a>Player.mass

If you want to fling a player using the physics system, it is possible to directly affect their velocity. You can either add a physics impulse to their current velocity, or just set the player's velocity directly. You can also zero out their velocity using `Player.ResetVelocity()`.

Note that when using impulses to apply force to a player, we need to scale it by the player's `mass` property!

```lua
-- Fling the player towards the heavens:
player:SetVelocity(Vector3.UP * 1000)


-- We can read the player's velocity in order to double it! Note that since we're adding
-- a physics impulse directly, we need to scale it by the mass of the player.
player:AddImpulse(player:GetVelocity() * player.mass)

-- Fling the player some more.
player:AddImpulse(Vector3.UP * player.mass * 1000)

Task.Wait(0.5)
-- Reset their velocity to zero.
player:ResetVelocity()
```

### <a id="method:Player.DisableRagdoll"></a>Player.DisableRagdoll

### <a id="method:Player.EnableRagdoll"></a>Player.EnableRagdoll

### <a id="property:Player.animationStance"></a>Player.animationStance

You can enable ragdoll on a player, and make their joints all floppy. This can be useful for various effects, such as indicating when a player has died, or otherwise  needs to be limp.

Alternately, you can set the player's animation stance to one of a number of premade animation stances, and the player will move while maintaining that stance. Check out the "Player Animations" page for a complete list.

```lua
-- Set the player's limbs to flop around, but leave the main spine
-- intact, so we drag them around like a marionette:
player:EnableRagdoll("lower_spine", .4)
player:EnableRagdoll("right_shoulder", .2)
player:EnableRagdoll("left_shoulder", .6)
player:EnableRagdoll("right_hip", .6)
player:EnableRagdoll("left_hip", .6)
Task.Wait(3)
-- Back to normal!
player:DisableRagdoll()

-- Okay now let's give them a weird stance:
player.animationStance = "unarmed_sit_car_low"
Task.Wait(3)
-- Put it back to normal
player.animationStance = "unarmed_stance"
```

### <a id="method:Player.GetAbilities"></a>Player.GetAbilities

### <a id="method:Player.GetEquipment"></a>Player.GetEquipment

Lots of things can end up attached to a player. `CoreObject` objects, stuck to sockets. `Ability` and `Equipment` objects granting them new powers. Etc.

It's possible to query the `Player` object to find out exactly what is attached to a given player.

```lua
local propBasicAssaultRifle = script:GetCustomProperty("BasicAssaultRifle")
rifle = World.SpawnAsset(propBasicAssaultRifle)
rifle:Equip(player)

for _, obj in ipairs(player:GetAbilities()) do
    print("Ability: " .. obj.name)
end
for k,v in pairs(player:GetAbilities()) do
    print(v.name)
end

for _, obj in ipairs(player:GetEquipment()) do
    print("Equipment: " .. obj.name)
end

for _, obj in ipairs(player:GetAttachedObjects()) do
    print("Attached object: " .. obj.name)
end
```

### <a id="method:Player.GetActiveCamera"></a>Player.GetActiveCamera

### <a id="method:Player.GetDefaultCamera"></a>Player.GetDefaultCamera

### <a id="method:Player.SetDefaultCamera"></a>Player.SetDefaultCamera

### <a id="method:Player.GetOverrideCamera"></a>Player.GetOverrideCamera

### <a id="method:Player.SetOverrideCamera"></a>Player.SetOverrideCamera

### <a id="method:Player.ClearOverrideCamera"></a>Player.ClearOverrideCamera

It's possible to change a player's view by modifying or swapping their camera. This is client side only, and won't have any effect if done from a server context!

```lua
local propTestCamera = script:GetCustomProperty("TestCamera")

-- We can set a default camera for a player, and then their viewport
-- is seen through that camera.
local player = Game.GetLocalPlayer()
local defaultCamera = World.SpawnAsset(propTestCamera,
        { position = Vector3.New(0, -1000, 1000) })
defaultCamera:LookAtContinuous(player)
print(player:GetDefaultCamera():GetWorldPosition()) -- 0, -1000, 1000
player:SetDefaultCamera(defaultCamera, 1)
Task.Wait(2)

-- Players also have an "overide camera", which has higher priority
-- than the default camera. It's usually used for moving the camera
-- somewhere briefly, before reverting to the default camera.
local overrideCamera = World.SpawnAsset(propTestCamera,
        { position = Vector3.New(0, 1000, 1000) })
overrideCamera:LookAtContinuous(player)
player:SetOverrideCamera(overrideCamera, 1)
print(player:GetOverrideCamera():GetWorldPosition()) -- 0, 1000, 1000
Task.Wait(2)
player:ClearOverrideCamera()
Task.Wait()
```

### <a id="method:Player.GetViewWorldPosition"></a>Player.GetViewWorldPosition

### <a id="method:Player.GetViewWorldRotation"></a>Player.GetViewWorldRotation

### <a id="method:Player.GetLookWorldRotation"></a>Player.GetLookWorldRotation

### <a id="method:Player.SetLookWorldRotation"></a>Player.SetLookWorldRotation

The direction and rotation that the player is looking can be both read and set through Lua scripts. Note that this will only work on scripts executing inside of a client context!

```lua
local player = Game.GetLocalPlayer()
-- Get the position and direction of the player's camera:
print("The player's view camera is at " .. tostring(player:GetViewWorldPosition()))
print("Its rotation is " .. tostring(player:GetViewWorldRotation()))

-- You can also directly set which direction they are looking.
-- This code snippet will force them to look 90 degrees to the right.
player:SetLookWorldRotation(player:GetLookWorldRotation() + Rotation.New(0, 0, 90))
```

### <a id="method:Player.GetWorldTransform"></a>Player.GetWorldTransform

### <a id="method:Player.SetWorldTransform"></a>Player.SetWorldTransform

### <a id="method:Player.GetWorldPosition"></a>Player.GetWorldPosition

### <a id="method:Player.SetWorldPosition"></a>Player.SetWorldPosition

### <a id="method:Player.GetWorldRotation"></a>Player.GetWorldRotation

### <a id="method:Player.SetWorldRotation"></a>Player.SetWorldRotation

It is possible to read and change the position of the player. You can either change the position or rotation directly, or change the entire transformation all at once.

```lua
-- Store off the transform of the player:
player:SetWorldTransform(Transform.IDENTITY)
local originalTransform = player:GetWorldTransform()

-- Move the player 1000 units in the air:
player:SetWorldPosition(player:GetWorldPosition() + Vector3.UP * 1000)

-- Look 90 degrees to the right
player:SetWorldRotation(player:GetWorldRotation() + Rotation.New(0, 0, 90))

-- Return the player to their original position and rotation:
player:SetWorldTransform(originalTransform)
```

### <a id="method:Player.SetVisibility"></a>Player.SetVisibility

### <a id="method:Player.GetVisibility"></a>Player.GetVisibility

You can make a player visible or invisible with `SetVisibility()`, and can check on their status with `GetVisibility()`. This sample gives the player the ability to turn invisible by pressing the shift key.

```lua
local shiftKeyBinding = "ability_feet"

function OnBindingPressed(player, bindingPressed)
    if bindingPressed == shiftKeyBinding and player:GetVisibility() == true then
        player:SetVisibility(false)
    end
end

function OnBindingReleased(player, bindingReleased)
    if bindingReleased == shiftKeyBinding and player:GetVisibility() == false then
        player:SetVisibility(true)
    end
end

function OnPlayerJoined(player)
    player.bindingPressedEvent:Connect(OnBindingPressed)
    player.bindingReleasedEvent:Connect(OnBindingReleased)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

### <a id="method:Player.SetWorldScale"></a>Player.SetWorldScale

### <a id="method:Player.GetWorldScale"></a>Player.GetWorldScale

You can scale the size of the player. This sample causes all players to slowly grow until they get too big, and then reset.

```lua
Task.Spawn(function()
    while true do
        for _, player in pairs(Game.GetPlayers()) do
            local currentScale = player:GetWorldScale()
            local newScale = currentScale * 1.01
            if newScale.x > 5 then newScale = Vector3.New(1.0) end

            player:SetWorldScale(newScale)
        end
        Task.Wait()
    end
end)
```

### <a id="method:Player.TransferToGame"></a>Player.TransferToGame

Sends a player to another game. The game ID can be obtained from the Core website, for example to transfer a player to Core Royale, we navigate to that game's page at `https://www.coregames.com/games/577d80/core-royale` and copy the last two parts of the URL `577d80/core-royale` as the game ID.

```lua
local trigger = script.parent

function OnBeginOverlap(theTrigger, player)
  -- The object's type must be checked because CoreObjects also overlap triggers
    if player and player:IsA("Player") then
        player:TransferToGame("577d80/core-royale")
    end
end

trigger.beginOverlapEvent:Connect(OnBeginOverlap)
```

### <a id="property:Player.currentFacingMode"></a>Player.currentFacingMode

### <a id="property:Player.desiredFacingMode"></a>Player.desiredFacingMode

There are several modes the game can use to decide which direction the player's avatar is facing, based on the camera look direction.

```lua

-- This will make the player turn to face whatever direction they are moving.
player.desiredFacingMode = FacingMode.FACE_MOVEMENT

-- This will make the player turn to face whatever direction they are aiming.
player.desiredFacingMode = FacingMode.FACE_AIM_ALWAYS

-- This will make the player turn to face whatever direction they
-- are moving or shooting.
player.desiredFacingMode = FacingMode.FACE_AIM_WHEN_ACTIVE
```

Note that this is the _desired_ facing mode. The actual facing mode is not always guaranteed to be this, as certain player states can override this. (When the player is swimming, for example.

You can check the actual current facing mode using the `currentFacingMode` property.

```lua

if (player.currentFacingMode == FacingMode.FACE_AIM_ALWAYS) then
    print("Player's facing mode is FacingMode.FACE_AIM_ALWAYS!")
end
```

### <a id="property:Player.hitPoints"></a>Player.hitPoints

### <a id="property:Player.maxHitPoints"></a>Player.maxHitPoints

### <a id="property:Player.kills"></a>Player.kills

### <a id="property:Player.deaths"></a>Player.deaths

You can get various vital statistics off of the player object, such as hit points, max hit points, kills and deaths. This sample shows how to read that data and populate a leaderboard. (The leaderboard is printed out to the event log in this sample, but it would be trivial to feed it into some kind of onscreen UI.)

```lua
-- Here's a function to print out various useful information about the player's current status
-- and score to the event log.
function PrintPlayerStats(player)
    print("[" .. player.name .. "]: Health: (".. player.hitPoints .. "/" .. player.maxHitPoints
            .. ") Kills: " .. player.kills
            .. "  Deaths: " .. player.deaths)
end

local playerList = Game.GetPlayers()
table.sort(playerList, function(a, b) return a.kills > b.kills end)
for i, p in ipairs(playerList) do
    PrintPlayerStats(p)
end
```

### <a id="property:Player.isAccelerating"></a>Player.isAccelerating

### <a id="property:Player.isCrouching"></a>Player.isCrouching

### <a id="property:Player.isFlying"></a>Player.isFlying

### <a id="property:Player.isGrounded"></a>Player.isGrounded

### <a id="property:Player.isJumping"></a>Player.isJumping

### <a id="property:Player.isMounted"></a>Player.isMounted

### <a id="property:Player.isSwimming"></a>Player.isSwimming

### <a id="property:Player.isWalking"></a>Player.isWalking

### <a id="property:Player.isDead"></a>Player.isDead

You can get a lot of useful information about the player's current movement, via a series of read-only boolean properties on the `Player` object.

```lua
-- Here's a function to print out various useful information about the player's current status
-- to the event log.
function CheckPlayerStatus(player)
    print("The player is ...")
    -- isAccelerating is true if the player is accelerating due to input.
    -- IMPORTANT NOTE: isAccelerating only cares about input. It won't turn true if they
    -- are falling, or otherwise accelerating from something other than player input.
    if player.isAccelerating then print("  - moving!") end

    if player.isCrouching    then print("  - crouched!") end
    if player.isFlying       then print("  - flying!") end
    if player.isGrounded     then print("  - touching the ground!") end
    if player.isJumping      then print("  - in mid air!") end
    if player.isMounted      then print("  - riding their mount!") end
    if player.isSwimming     then print("  - underwater!") end
    if player.isWalking      then print("  - moving via walking!") end
    if player.isDead         then print("  - deceased!") end
end

-- For the next 10 seconds, report on a player's status flags!
for i = 0, 10 do
    players = Game.GetPlayers()
    if #players > 0 then
        CheckPlayerStatus(players[1])
    end
    Task.Wait(1)
end
```

### <a id="property:Player.isVisibleToSelf"></a>Player.isVisibleToSelf

It's possible to hide the player's model from the player controlling it. This can be especially useful for first-person games. Note that this can only be set by scripts running in the client context!

```lua
-- The player can no longer see their own model. Other players' ability
-- to see this player is unaffected.
player.isVisibleToSelf = false
```

### <a id="property:Player.lookSensitivity"></a>Player.lookSensitivity

You can also make the player's input more or less sensitive, when aiming. This can be useful for aiming down sights, etc.

```lua
-- This will double the sensitivity:
player.lookSensitivity = 5
```

### <a id="property:Player.maxAcceleration"></a>Player.maxAcceleration

### <a id="property:Player.brakingDecelerationFalling"></a>Player.brakingDecelerationFalling

### <a id="property:Player.brakingDecelerationWalking"></a>Player.brakingDecelerationWalking

### <a id="property:Player.groundFriction"></a>Player.groundFriction

### <a id="property:Player.brakingFrictionFactor"></a>Player.brakingFrictionFactor

Through scripts, you can control the player's ability to accelerate their character.

```lua
-- The player accelerates more slowly.
player.maxAcceleration = 600

-- The player tends to fall straight down unless they specifically press a direction in mid-air now!
player.brakingDecelerationFalling = 1800

-- The player takes longer to come to rest while walking.
player.brakingDecelerationWalking = 200

-- Also they slide more!
player.groundFriction = 2

-- And more sliding - they have less grip on the ground when decelerating.
player.brakingFrictionFactor = 0.2
```

### <a id="property:Player.movementControlMode"></a>Player.movementControlMode

### <a id="property:Player.lookControlMode"></a>Player.lookControlMode

### <a id="property:Player.defaultRotationRate"></a>Player.defaultRotationRate

### <a id="property:Player.currentRotationRate"></a>Player.currentRotationRate

Player motion and facing can be set to several modes, depending on the gameplay needed.

```lua
-- The player's movement input is ignored. Player cannot move.
player.movementControlMode = MovementControlMode.NONE

-- Movement follows the player's current view direction. This is
-- the direction the camera is pointing.
player.movementControlMode = MovementControlMode.VIEW_RELATIVE

-- Movement follows the player's current look direction.
-- This is the direction the player's head is facing.
player.movementControlMode = MovementControlMode.LOOK_RELATIVE

-- Movement follows the player's current facing direction
-- This is the direction that the player's torso is facing.
player.movementControlMode = MovementControlMode.FACING_RELATIVE


player.defaultRotationRate = 200
```

You can also change how the player's look input is processed:

```lua
-- Player look input is ignored. The player cannot move their view.
player.lookControlMode = LookControlMode.NONE

-- The player controls the look direction. This is the default mode.
player.lookControlMode = LookControlMode.RELATIVE

-- The player always turns to face whatever the cursor is over, in the world.
-- This works best with a third person camera.
player.lookControlMode = LookControlMode.LOOK_AT_CURSOR
```

### <a id="property:Player.name"></a>Player.name

### <a id="property:Player.id"></a>Player.id

### <a id="property:Player.team"></a>Player.team

There is a lot of useful information you can get from the player object. Players have a `name` property, which is the text display name for the player. Players can set their own names though, so there is no guarantee that `name`s will be unique.

Players do, however, have a unique ID assigned to them. (Accessed via the `id` property.) It is guaranteed to be distinct from other players, and it is stable across sessions, so it won't change if they log out and log back in again.

This sample grabs the list of all current players, and prints out their name, ID, and what team they are on.

```lua
local players = Game.GetPlayers()
print("---There are currently " .. tostring(#players) .. " Player(s):")
for _, p in pairs(players) do
    print("Player [" .. p.name .. "]:")
    print("  - id:   " .. p.id)
    print("  - team: " .. p.team)
    print()
end
```

### <a id="property:Player.name"></a>Player.name

### <a id="property:Player.id"></a>Player.id

### <a id="property:Player.team"></a>Player.team

There is a lot of useful information you can get from the player object. Players have a `name` property, which is the text display name for the player. Players can set their own names though, so there is no guarantee that `name`s will be unique.

Players do, however, have a unique ID assigned to them. (Accessed via the `id` property.) It is guaranteed to be distinct from other players, and it is stable across sessions, so it won't change if they log out and log back in again.

This sample grabs the list of all current players, and prints out their name, ID, and what team they are on.

```lua
local players = Game.GetPlayers()
print("---There are currently " .. tostring(#players) .. " Player(s):")
for _, p in pairs(players) do
    print("Player [" .. p.name .. "]:")
    print("  - id:   " .. p.id)
    print("  - team: " .. p.team)
    print()
end
```

### <a id="property:Player.shouldDismountWhenDamaged"></a>Player.shouldDismountWhenDamaged

### <a id="method:Player.SetMounted"></a>Player.SetMounted

### <a id="property:Player.canMount"></a>Player.canMount

The player can mount or dismount. We can also force the player to mount or dismount via the `Player:SetMounted()` function. Also, if `Player.shouldDismountWhenDamaged` is set, they will automatically dismount whenever they take damage.

This sample demonstrates how to force the player to be mounted, and how to set them to dismount when hit.

```lua
player.shouldDismountWhenDamaged = true
player:SetMounted(true)
-- Player is now mounted!

-- If they take damage, they should dismount!

player:ApplyDamage(Damage.New(1))

-- We can also disable the player's ability to mount or dismount.
-- Note that this will NOT prevent us from calling SetMounted() -
-- this only affects the player's controls.
player.canMount = false
```

### <a id="property:Player.spreadModifier"></a>Player.spreadModifier

### <a id="property:Player.currentSpread"></a>Player.currentSpread

Players shooting weapons have a spread modifier applied to their accuracy. This can be used to simulate things like loss of aim after jumping, or other activities.

```lua
-- Whenever the player lands after a jump, they get more spread
-- on their shots for a second.
local jumpEndListener = player.movementModeChangedEvent:Connect(
    function(player, movementMode)
        if movementMode == MovementMode.WALKING then
            print("Worse aim!")
            player.spreadModifier = 2
            Task.Wait(1)
            print("better aim!")
            player.spreadModifier = 1
        end
    end)
```

You can also check the player's current (total) spread, although this only works from the client context.

```lua
    print(player.currentSpread)
```

### <a id="property:Player.stepHeight"></a>Player.stepHeight

### <a id="property:Player.walkableFloorAngle"></a>Player.walkableFloorAngle

### <a id="property:Player.maxJumpCount"></a>Player.maxJumpCount

### <a id="property:Player.jumpVelocity"></a>Player.jumpVelocity

### <a id="property:Player.gravityScale"></a>Player.gravityScale

### <a id="property:Player.buoyancy"></a>Player.buoyancy

### <a id="property:Player.isCrouchEnabled"></a>Player.isCrouchEnabled

Most of the aspects of a player's movement can be controlled at runtime via scripting!

```lua
-- Player can now step over 100cm ledges!
player.stepHeight = 100

-- And walk up 60-degree inclines!
player.walkableFloorAngle = 60

-- Player can now double-jump!
player.maxJumpCount = 2

-- And jump twice as high!
player.jumpVelocity = 1800

-- But gravity is twice as strong!
player.gravityScale = 3.8

-- But they are twice as buoyant in water!
player.buoyancy = 2

-- Also the player cannot crouch.
player.isCrouchEnabled = false
```

### <a id="property:Player.touchForceFactor"></a>Player.touchForceFactor

When the player runs into physics objects, they exert force. You can affect how much force with the `touchForceFactor` property.

```lua
-- Set the player to push five times as hard!
player.touchForceFactor = 5
```

## Projectile

### <a id="classfunction:Projectile.Spawn"></a>Projectile.Spawn

### <a id="event:Projectile.lifeSpanEndedEvent"></a>Projectile.lifeSpanEndedEvent

### <a id="event:Projectile.lifeSpan"></a>Projectile.lifeSpan

Like `CoreObjects`, Projectiles have a `lifeSpan` property, which is the maximum number of seconds a projectile can be kept around. Once that time is up, the projectile is automatically destroyed by the engine.

When projectiles reach the end of their lifespan, they trigger a `lifeSpanEndedEvent` event. This event fires _before_ the projectile is destroyed, so it is still valid to reference it in the event handler.

In this example, we fire a projectile straight up, so its lifeSpan runs out before it collides with anything. When it does, the `lifeSpanEndedEvent` fires.

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

### <a id="event:Projectile.homingFailedEvent"></a>Projectile.homingFailedEvent

If a projectile has its `homingTarget` set, and then the target disappears for some reason, it will fire a `HomingFailedEvent`. This is usually because the CoreObject that the projectile is following was `Destroy`ed, or the player it was following logged out.

In this example, we spawn an object, fire a projectile at it, (and set the `homingTarget` property) and then immediately remove the target, leaving the projectile to feel dejected and confused.

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

### <a id="event:Projectile.impactEvent"></a>Projectile.impactEvent

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
    if other and other:IsA("Player") then
        print("We hit player " .. other.name .. "!!!")
    end
end)
```

### <a id="method:Projectile.Destroy"></a>Projectile.Destroy

Sometimes you will want to remove a projectile from the game even if it hasn't hit any targets yet. When this is the case, the `Destroy()` function does what you need - it does exactly what the name implies - the projectile is immediately removed from the game and no events are generated.

We can test if an object still exists via the Object:IsValid() function. This can be useful because sometimes things other than program code can remove an object from our game. (Existing for longer than the `lifeSpan`, or colliding with an object, in the case of projectiles.)

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

### <a id="method:Projectile.GetWorldTransform"></a>Projectile.GetWorldTransform

### <a id="method:Projectile.GetWorldPosition"></a>Projectile.GetWorldPosition

### <a id="method:Projectile.GetVelocity"></a>Projectile.GetVelocity

### <a id="method:Projectile.SetVelocity"></a>Projectile.SetVelocity

We can get various information about a projectile's position and velocity via several functions. `GetWorldTransform()` and `GetWorldPosition()` functions can tell us where it is and where it is facing. `GetVelocity()` tells us where it is moving and how fast. And `SetVelocity()` allows us to change its direction in mid-flight.

In this sample, we'll fire some more projectiles at the player. But we'll also give them a magic shield that reflects any projectiles that get too close!

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
            -- if the projectile is within 200 units of the player...
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

### <a id="property:Projectile.capsuleLength"></a>Projectile.capsuleLength

### <a id="property:Projectile.capsuleRadius"></a>Projectile.capsuleRadius

When Core performs collision checks (to see if a projectile has hit anything) it assumes the projectile is a _capsule._  That is, a cylinder with a hemisphere on each flat end.

We can change the shape of this capsule by modifying the length and radius of the cylinder. A length of 0 means we have a sphere. (Because there is no space between the two hemispheres on the ends.)

This sample makes a few projectiles of varying shapes and sizes.

Note that this only changes the collision properties of the projectile! The visual representation on screen will be unchanged.

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

### <a id="property:Projectile.gravityScale"></a>Projectile.gravityScale

### <a id="property:Projectile.bouncesRemaining"></a>Projectile.bouncesRemaining

### <a id="property:Projectile.bounciness"></a>Projectile.bounciness

### <a id="property:Projectile.shouldBounceOnPlayers"></a>Projectile.shouldBounceOnPlayers

By default, projectiles are destroyed when they impact a surface. If you set their `bouncesRemaining` though, whenever they hit a surface, they will lose one `bouncesRemaining` and ricochet off in a new direction. This can be used to simulate grenades, super balls, bouncing lasers, or similar. The amount of energy they lose (or gain!) from impact is controlled via the `bounciness` property.

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

-- this projectile will just fire off in a straight line with no gravity. It should never bounce.
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

### <a id="property:Projectile.homingTarget"></a>Projectile.homingTarget

### <a id="property:Projectile.drag"></a>Projectile.drag

### <a id="property:Projectile.homingAcceleration"></a>Projectile.homingAcceleration

Projectiles can be set to home in on targets, via the `homingTarget` property. This can be either a player or a CoreObject.

This example spawns an object in the world, and then fires a projectile to home in on it.

The `drag` and `homingAcceleration` properties affect how fast the homing projectile can change direction, and how fast it loses velocity due to air resistance.

```lua
-- A template of a basic cube, attached to the script as a custom property:
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")

local objectInWorld = World.SpawnAsset(propCubeTemplate)
objectInWorld:SetWorldPosition(Vector3.New(1000, 0, 0))

local function ProjectileImpact(projectile, other, hitresult)
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

### <a id="property:Projectile.owner"></a>Projectile.owner

Projectiles have a property, `owner`, which stores data about who spawned the projectile. This is populated automatically, if the projectile is generated from a weapon interaction. Otherwise, we have to set it ourselves.

Projectiles will never impact their `owner`, or anyone on the `owner`'s team. They will just pass on through, and not trigger an `impactEvent`.

In this example, we fire several projectiles at the player, but set them to be owned by the player, so they are unhit.

```lua
-- A template of a basic cube, attached to the script as a custom property:
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")

function OnImpact(projectile, other, hitresult)
    --Count how many times each projectile hits the player:
    if other and other:IsA("Player") then
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
-- Player will not be hit (and the hit message will never be printed) because
-- the projectiles are all owned by the player.
```

### <a id="property:Projectile.piercesRemaining"></a>Projectile.piercesRemaining

### <a id="property:Projectile.shouldDieOnImpact"></a>Projectile.shouldDieOnImpact

Projectiles have the `piercesRemaining` property, which controls how many times they penetrate objects and keep going. In this sample, we spawn several walls and fire several projectiles at them, with different penetration numbers.

Projectiles also have a property that determines if they should be destroyed when they hit an object - `shouldDieOnImpact`. One of the projectiles we spawn here does not die on impact! So when it hits a wall, it simply stops and waits for its `lifeSpan` to run out.

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

-- this projectile will just fire off in a straight line with no gravity. It should never bounce.
local Pierce_x1 = FirePiercingProjectile(0)

-- This projectile will pierce the first wall and impact the second.
local Pierce_x2 = FirePiercingProjectile(1)

-- This projectile will pierce the first two walls, and impact the third.
local Pierce_x3 = FirePiercingProjectile(2)

-- This projectile will hit the first wall, and then stop, because it is set not to die on impact.
local DontDieOnImpact = FirePiercingProjectile(0)
DontDieOnImpact.shouldDieOnImpact = false
```

### <a id="property:Projectile.sourceAbility"></a>Projectile.sourceAbility

Projectiles have a field to report what ability spawned them. If the projectile is fired by a weapon, then the weapon automatically populates the sourceAbility property. If you spawn projectiles manually via spawnProjectile, then you are responsible for populating it yourself.

Here is an example of a weapon script that tests if the projectiles came from an ability called "FlameThrower." It is assumed that this is in a script that is a direct child of a weapon object.

```lua
function OnImpact(projectile, other, hitresult)
    if other and other:IsA("Player") then
        local damageScale = 1.0
        if projectile.sourceAbility ~= nil
                and projectile.sourceAbility.name == "FlameThrower" then
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

### <a id="property:Projectile.speed"></a>Projectile.speed

### <a id="property:Projectile.maxSpeed"></a>Projectile.maxSpeed

You can set the speed of a projectile directly, via the `speed` property. Note that this does not change the direction of a projectile - only how fast it is moving in whatever direction it is already pointing in.

You can also set a projectile's `maxSpeed` property, which clamps the speed to a given velocity. This can be useful in situations where the projectile is homing or affected by gravity - you can ensure that the speed never gets above a particular velocity, no matter how long it has been falling/accelerating.

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
-- The projectile is still going at 100 speed. Max Speed is only checked at the end of the frame.
print("This projectile's speed is " .. tostring(myProjectile.speed))

Task.Wait()    -- So if we wait one frame...
print("This projectile's speed is " .. tostring(myProjectile.speed))
-- It should now be clamped down to the maximum speed.
```

## Quaternion

### <a id="classfunction:Quaternion.Slerp"></a>Quaternion.Slerp

### <a id="method:Quaternion.GetRotation"></a>Quaternion.GetRotation

### <a id="method:Quaternion.GetRightVector"></a>Quaternion.GetRightVector

### <a id="method:Quaternion.GetUpVector"></a>Quaternion.GetUpVector

### <a id="method:Quaternion.GetForwardVector"></a>Quaternion.GetForwardVector

`Quaternion.Slerp` is a function for finding a quaternion that is part way between two other quaternions. Since quaternions represent rotations, this means a rotation that is part way between two other rotations. When combined with a tick function or loop, we can use it to smoothly animate something rotating.

`Quaternion.GetRotation` is useful if you need to convert a quaternion into a rotation variable. (For passing to functions like `CoreObject:SetWorldRotation()` for example.)

We can also access various unit vectors, as transformed by the quaternion, via `Quaternion:GetForwardVector`, `Quaternion:GetRightVector`, and`Quaternion:GetUpVector`.

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")
local myObject = World.SpawnAsset(propCubeTemplate,
    { position = Vector3.New(500, 0, 500)})

local startQuat = Quaternion.IDENTITY
local endQuat = Quaternion.New(Vector3.UP, 120)

local steps = 300
local objectPos = myObject:GetWorldPosition()
for i = 1, steps do
    -- Rotate this quaternion over time
    local currentQuat = Quaternion.Slerp(startQuat, endQuat, i/steps)
    myObject:SetWorldRotation(currentQuat:GetRotation())

    CoreDebug.DrawLine(objectPos, objectPos + currentQuat:GetForwardVector() * 1000,
        { thickness = 5, color = Color.RED })
    CoreDebug.DrawLine(objectPos, objectPos + currentQuat:GetRightVector() * 1000,
        { thickness = 5, color = Color.GREEN })
    CoreDebug.DrawLine(objectPos, objectPos + currentQuat:GetUpVector() * 1000,
        { thickness = 5, color = Color.BLUE })

    Task.Wait()
end


print("Tah dah!")
```

### <a id="constructor:Quaternion.New"></a>Quaternion.New

### <a id="constructor:Quaternion.IDENTITY"></a>Quaternion.IDENTITY

There are several different ways to create new Quaternions.

```lua
local sqrt2over2 = math.sqrt(2) / 2

-- Makes an identity Quaternion. (Rotates by 0 degrees.)
local identityQuat = Quaternion.New()

-- You can also access the identity quaternion via the static property:
local otherIdentityQuat = Quaternion.IDENTITY

-- Creates a quaternion from a rotation.
local rotationQuaternion = Quaternion.New(Rotation.New(Vector3.RIGHT, Vector3.UP))

-- Creates a quaternion from an axis and an angle.
local axisQuaternion = Quaternion.New(Vector3.UP, 90)

-- Creates a quaternion that rotates from one vector to another.
local fromToQuaternion = Quaternion.New(Vector3.FORWARD, Vector3.RIGHT)

-- Creates a quaternion that is a copy of an existing quaternion.
local copyQuaternion = Quaternion.New(rotationQuaternion)

-- You can also create a quaternion by directly assigning x, y, z, w values,
-- but this is not recommended unless you are VERY sure you understand
-- how quaternions represent rotations.
-- This rotation is identical to rotationQuaternion, above - 90 degrees around the z axis.
local directQuaternion = Quaternion.New(0, 0, sqrt2over2, sqrt2over2)
```

### <a id="operator:Quaternion*Quaternion"></a>Quaternion*Quaternion

### <a id="operator:Quaternion*Vector3"></a>Quaternion*Vector3

### <a id="operator:-Quaternion"></a>-Quaternion

Multiplying a vector (or another quaternion!) by a quaternion applies the quaternion to the vector/quaternion.

```lua
-- Multiplying two components will produce a quaternion that is the composite result.
local rotate90Degrees = Quaternion.New(Vector3.UP, 90)
local rotate180Degrees = rotate90Degrees * rotate90Degrees
local rotate360Degrees =  rotate180Degrees * rotate90Degrees * rotate90Degrees

-- Multiplying a vector by a quaternion will produce a vector that has been rotated by the quaternion.
local rotatedVector = rotate90Degrees * Vector3.FORWARD
-- rotatedVector is now equal to Vector3.RIGHT, because it has been rotated 90 degrees

-- You can also invert a quaternian using the minus-sign. Note that this is NOT the same
-- as inverting the components. This produces a reversed rotation instead.
-- This example rotates a vector by 90 degrees, and then back, leaving it unchanged.
local forwardVector = rotate90Degrees * -rotate90Degrees * Vector3.FORWARD
```

### <a id="property:Quaternion.x"></a>Quaternion.x

### <a id="property:Quaternion.y"></a>Quaternion.y

### <a id="property:Quaternion.z"></a>Quaternion.z

### <a id="property:Quaternion.w"></a>Quaternion.w

You can read or set the components of a quaternion directly, although this is not recommended unless you are extremely familiar with quaternions.

```lua
local myQuaternion = Quaternion.New()
myQuaternion.x = 0
myQuaternion.y = 0
myQuaternion.z = math.sqrt(2)/2
myQuaternion.w = math.sqrt(2)/2
-- myQuaternion is now a 90 degree rotation about the Z axis!
```

## Rotation

### <a id="constructor:Rotation.New"></a>Rotation.New

### <a id="constructor:Rotation.ZERO"></a>Rotation.ZERO

There are several different ways to create new Rotations.

```lua
-- Calling the constructor without arguments generates a zero rotation.
-- (Rotates by zero degrees, so no change.)
local zeroRotation = Rotation.New()

-- You can also describe a rotation by providing Euler angles:
-- This rotation will rotate something 90 degrees around the Z axis.
local rotation90z = Rotation.New(0, 0, 90)

-- Quaternions can be transformed into Rotations using constructors.
-- This will produce a 90 degree rotation. (From a 90 degree Quaternion)
local quatRotation = Rotation.New(Quaternion.New(Vector3.UP, 90))

-- You can also use the Rotation constructor to generate a rotation that would
-- transform Vector3.FORWARD (0, 1, 0) to point in the given direction.
-- (You also have to provide it with an up vector, to use as a reference.)
local vec1 = Vector3.New(3, 4, 5)
local vecRotation = Rotation.New(vec1, Vector3.UP)
local vec2 = vecRotation * Vector3.FORWARD
-- vec2 now points in the same direction as vec1.

-- The constructor can also be used to copy rotations:
local rotationCopy = Rotation.New(rotation90z)

-- Rotation.ZERO can be used to quickly generate a rotation of zero
-- degrees. (So it won't change anything.)
local newVec1 = Rotation.ZERO * vec1
-- newVec1 is still the same as vec1, because it hasn't rotated.
```

### <a id="operator:Rotation+Rotation"></a>Rotation+Rotation

### <a id="operator:Rotation-Rotation"></a>Rotation-Rotation

### <a id="operator:Rotation*Number"></a>Rotation*Number

### <a id="operator:-Rotation"></a>-Rotation

### <a id="operator:Rotation*Vector3"></a>Rotation*Vector3

You can add and subtract rotations from each other, scale them, and apply them to vectors via arithmetic operators.

```lua
local rotate90x = Rotation.New(90, 0, 0)
local rotate90y = Rotation.New(0, 90, 0)
local rotate90z = Rotation.New(0, 0, 90)

-- Add two rotations together to get their sum:
local rotate90xy = rotate90x + rotate90y
-- This is now (90, 90, 0)

-- Subtract a rotation from another to find the difference:
local new_rotate90x = rotate90xy - rotate90y
-- This is now (90, 0, 0)

-- You can scale a rotation by multiplying it by a number.
local rotate180x = rotate90x * 2
-- This is now (180, 0, 0)

-- Multiplying a rotation by a vector applies the rotation to the vector and returns
-- the rotated vector as a result.
local forwardVec = Vector3.New(10, 0, 0)
local rightVec = rotate90z * forwardVec
-- rightVec is now (0, 10, 0)

-- You can invert a rotation via the minus sign:
local rotate90x_negative = -rotate90x
-- This is now (-90, 0, 0)
```

### <a id="property:Rotation.x"></a>Rotation.x

### <a id="property:Rotation.y"></a>Rotation.y

### <a id="property:Rotation.z"></a>Rotation.z

The x, y, and z components of a rotation can be accessed directly. These numbers represent the number of degrees to rotate around their respective axis.

```lua
local newRotation = Rotation.New()
newRotation.x = 90
newRotation.y = 45
newRotation.z = 180
-- This creates a rotation of 90 degrees about the x axis, 45 degrees about the y axis, and
-- 180 degrees about the z axis.
```

## Script

### <a id="property:Script.context"></a>Script.context

With `context` two scripts can communicate directly by calling on each other's functions and properties. Notice that '.' is used instead of ':' when accessing context functions. In the following example, the first script is placed directly in the hierarchy and the second script is placed inside a template of some sort. When a new player joins, the first script spawns a copy of the template and tells it about the new player. The template then follows the player around as they move.

Script directly in hierarchy:

```lua
local followTemplate = script:GetCustomProperty("FollowTemplate")

Game.playerJoinedEvent:Connect(function(player)
    local obj = World.SpawnAsset(followTemplate)
    -- Locate the script inside
    local followScript = obj:FindDescendantByType("Script")
    -- Call the context function
    followScript.context.SetTarget(player)
end)
```

Script located inside a template. The 'targetPlayer' property and the 'SetTarget()' function can be accessed externally through the context.

```lua
targetPlayer = nil

function SetTarget(player)
    targetPlayer = player
    script:FindTemplateRoot():Follow(player, 400, 300)
end
```

## StaticMesh

### <a id="property:StaticMesh.isSimulatingDebrisPhysics"></a>StaticMesh.isSimulatingDebrisPhysics

The debris physics simulation is a client-only feature. The exact movement of simulated meshes is not expected to be the same across clients and should be used for visual effects, not for determining gameplay outcomes.

The following example takes several Static Meshes and explodes them randomly away from the epicenter. As written, it modifies only meshes that are children of the script object. When the player approaches the script at 3 meters or less then the function ExplodeChildren() is called, enabling the property `isSimulatingDebrisPhysics` for all the children, in addition to an impulse vector.

```lua
local DISTANCE_TO_EXPLODE = 300
local EXPLOSION_FORCE = 450
local hasExploded = false

function ExplodeChildren()
    local rng = RandomStream.New()

    local epicenter = script:GetWorldPosition()

    for _, child in ipairs(script:GetChildren()) do
        -- Enable client physics
        child.isSimulatingDebrisPhysics = true
        -- Impulse vector
        local direction = (child:GetWorldPosition() - epicenter):GetNormalized()
        child:SetVelocity((rng:GetVector3() + direction * 2) * EXPLOSION_FORCE)
    end
end

function Tick()
    -- Call the explosion function only once
    if hasExploded then return end

    -- Detect if the local player has gotten close to the objects
    local player = Game.GetLocalPlayer()
    local distance = (player:GetWorldPosition() - script:GetWorldPosition()).size

    if distance < DISTANCE_TO_EXPLODE then
        hasExploded = true
        ExplodeChildren()
    end
end
```

## Storage

### <a id="classfunction:Storage.GetPlayerData"></a>Storage.GetPlayerData

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

### <a id="classfunction:Storage.GetSharedPlayerData"></a>Storage.GetSharedPlayerData

This example shows how to read data that has been saved to Shared Storage. Because this is saved via shared-key persistence, the data may have been written by a different game. This allows you to have multiple games share the same set of player data.

For this example to work, there is some setup that needs to be done:

- Storage needs to be enabled in the Game Settings object.

- You have to create a shared key.

- The NetReference for the shared key needs to be added to the script as a custom property.

See the <a href="https://docs.coregames.com/tutorials/shared_storage/">Shared Storage</a> documentation for details on how to create shared keys.

```lua
local propSharedKey = script:GetCustomProperty("DocTestSharedKey")
local returnTable = Storage.GetSharedPlayerData(propSharedKey, player)

-- Print out the data we retrieved:
for k,v in pairs(returnTable) do
    print(k, v)
end
```

### <a id="classfunction:Storage.SetPlayerData"></a>Storage.SetPlayerData

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

### <a id="classfunction:Storage.SetSharedPlayerData"></a>Storage.SetSharedPlayerData

This example shows how to write data to the Shared Storage. With this, any maps that you enable with your shared key can all access the same data that is associated with a player. This means that you could have several games where reward, levels, or achievements carry over between them.

For this example to work, there is some setup th at needs to be done:

- Storage needs to be enabled in the Game Settings object.

- You have to create a shared key.

- The NetReference for the shared key needs to be added to the script as a custom property.

See the <a href="https://docs.coregames.com/tutorials/shared_storage/">Shared Storage</a> documentation for details on how to create shared keys.

```lua
local propSharedKey = script:GetCustomProperty("DocTestSharedKey")

local sampleData = {
    name = "Philip",
    points = 1000,
    favorite_color = Color.RED,
    skill_levels = {swordplay = 8, flying = 10, electromagnetism = 5, friendship = 30}
}
Storage.SetSharedPlayerData(propSharedKey, player, sampleData)
```

## Task

### <a id="classfunction:Task.Spawn"></a>Task.Spawn

### <a id="classfunction:Task.GetCurrent"></a>Task.GetCurrent

### <a id="property:Task.id"></a>Task.id

You can spawn new tasks via `Task.Spawn()`, and leave them to execute without blocking your main Lua script. This has a lot of potential uses, from animation, to code organization.

This is a fairly contrived example, but it demonstrates how even if spawned tasks yield via `Task.Wait()`, it doesn't block any other tasks.

```lua
local nameMap = {}
local debug_taskLog = ""

function SpawnCountdown(name)
    local newTask = Task.Spawn(function ()
        local currentTask = Task.GetCurrent()
        local myName = nameMap[currentTask.id]
        print(myName .. ": 3...")
        Task.Wait(1)
        print(myName .. ": 2...")
        Task.Wait(1)
        print(myName .. ": 1...")
        Task.Wait(1)
        print(myName .. ": LIFTOFF!!!")
    end)
    nameMap[newTask.id] = name
    return newTask
end

local task1 = SpawnCountdown("Fred")
Task.Wait(0.5)
local task2 = SpawnCountdown("Bob")
--[[Output is:
        Fred: 3...
        Bob: 3...
        Fred: 2...
        Bob: 2...
        Fred: 1...
        Bob: 1...
        Fred: LIFTOFF!!!
        Bob: LIFTOFF!!!
    ]]
```

### <a id="classfunction:Task.Wait"></a>Task.Wait

`Task.Wait()` is an extremely useful function that you can use to make your current Lua thread pause for an amount of time. If you provide a number as an argument, the task will yield for that many seconds. If no argument is provided, it yields until the next update frame.

It returns two numbers. The first number is how long the task was actually yielded. The second number is the requested delay when `Task.Wait()` was called.

```lua
print("Testing Task.Wait()")

local timeElapsed, timeRequested = Task.Wait(3)

print("timeElapsed = " .. timeElapsed)
print("timeRequested = " .. timeRequested)
```

### <a id="method:Task.Cancel"></a>Task.Cancel

### <a id="method:Task.GetStatus"></a>Task.GetStatus

Tasks started via `Task.Spawn()` continue until they are completed. But you can end them early, via their `Cancel()` method.

Tasks also have a `GetStatus()` method, which can be used to check on their current status - whether they are currently running, are scheduled to run in the future, or have already run to completion.

```lua
local counter = 0

-- This task will count the seconds forever.
local myTask = Task.Spawn(function()
    while true do
        print(tostring(counter) .. " seconds...")
        Task.Wait(1)
        counter = counter + 1
    end
end)

Task.Wait(4.5)
print("Current status is Scheduled? " .. tostring(myTask:GetStatus() == TaskStatus.SCHEDULED))
print(" -- Cancelling Task -- ")
myTask:Cancel()
print("Current status is Canceled? " .. tostring(myTask:GetStatus() == TaskStatus.CANCELED))
```

### <a id="property:Task.repeatCount"></a>Task.repeatCount

### <a id="property:Task.repeatInterval"></a>Task.repeatInterval

You can schedule tasks to run a specific number of times, and to wait a specific number of times between repeats. This sample creates a task that prints out "hello world", and then has it repeat itself thee times, once per second.

Note that the repeat count is the number of time the task will repeat. NOT the number of times it will execute! (It will execute one more time than it repeats.)

```lua
local counter = 0

local myTask = Task.Spawn(function()
    counter = counter + 1
    print("Hello world! x" .. tostring(counter))
end)

myTask.repeatCount = 3
myTask.repeatInterval = 1

--[[
Output:
    Hello world! x1
    Hello world! x2
    Hello world! x3
    Hello world! x4
]]
```

## Trigger

### <a id="event:Trigger.beginOverlapEvent"></a>Trigger.beginOverlapEvent

In this example, players die when they walk over the trigger. The script assumes to be a child of the trigger.

```lua
local trigger = script.parent

function OnBeginOverlap(theTrigger, player)
    -- The object's type must be checked because CoreObjects also overlap triggers, but we
    -- only call :Die() on players.
    if player and player:IsA("Player") then
        player:Die()
    end
end

trigger.beginOverlapEvent:Connect(OnBeginOverlap)
```

### <a id="event:Trigger.endOverlapEvent"></a>Trigger.endOverlapEvent

As players enter/exit the trigger the script keeps a table with all currently overlapping players. The script assumes to be a child of the trigger.

```lua
local trigger = script.parent
local activePlayers = {}

function OnBeginOverlap(theTrigger, player)
    if player and player:IsA("Player") then
        table.insert(activePlayers, player)
        print("The trigger contains " .. #activePlayers .. " players")
    end
end

function OnEndOverlap(theTrigger, player)
    if (not player or not player:IsA("Player")) then return end

    for i, p in ipairs(activePlayers) do
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

### <a id="event:Trigger.interactedEvent"></a>Trigger.interactedEvent

In this example, the trigger has the "Interactable" checkbox turned on. When the player walks up to the trigger and interacts with the F key they are propelled into the air. The script assumes to be a child of the trigger.

```lua
local trigger = script.parent
trigger.isInteractable = true

function OnInteracted(theTrigger, player)
    -- In this case there is no need to check the type with IsA("Player") because only
    -- players can trigger the interaction.
    player:SetVelocity(Vector3.New(0, 0, 10000))
end

trigger.interactedEvent:Connect(OnInteracted)
```

### <a id="method:Trigger.GetOverlappingObjects"></a>Trigger.GetOverlappingObjects

In this example, any objects that overlap with the trigger are pushed upwards until they no longer overlap. If the trigger overlaps with non-networked objects this will throw an error. The script assumes to be a child of the trigger.

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

### <a id="method:Trigger.IsOverlapping"></a>Trigger.IsOverlapping

In this example, a physics sphere is placed in the scene. Every second the sphere is in the trigger, team 1 scores a point. The script assumes to be a child of the trigger.

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

### <a id="method:Trigger.IsOverlapping"></a>Trigger.IsOverlapping

In this example, players score points for their teams for each second they are inside the trigger. The script assumes to be a child of the trigger.

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

### <a id="property:Trigger.interactionLabel"></a>Trigger.interactionLabel

In this example, the trigger moves left and right and changes its label dynamically. To use this as a sliding door place a door asset as a child of the trigger. The script assumes to be a child of the trigger.

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

### <a id="property:Trigger.isEnemyCollisionEnabled"></a>Trigger.isEnemyCollisionEnabled

In this example, when a player interacts with a trigger it joins their team and enemies can no longer interact with it. Each time they interact their team gains a point. When the last player to interact with the trigger is killed the trigger returns to it's original neutral form. The script assumes to be a child of the trigger.

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

### <a id="property:Trigger.isInteractable"></a>Trigger.isInteractable

In this example, the trigger has a 4 second "cooldown" after it is interacted. The script assumes to be a child of the trigger.

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

### <a id="property:Trigger.isTeamCollisionEnabled"></a>Trigger.isTeamCollisionEnabled

In this example, when a player interacts with a trigger it joins their team and they can no longer interact with it, but enemies can. The script assumes to be a child of the trigger.

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

### <a id="property:Trigger.team"></a>Trigger.team

In this example, players score points when they enter a trigger that belongs to the enemy team. The script assumes to be a child of the trigger.

```lua
local trigger = script.parent

function OnBeginOverlap(theTrigger, player)
    local teamToReward = player.team

    if (player and player:IsA("Player") and teamToReward ~= trigger.team) then
        Game.IncreaseTeamScore(teamToReward, 1)
        print("Team " .. teamToReward .. " score = " .. Game.GetTeamScore(teamToReward))
    end
end

trigger.beginOverlapEvent:Connect(OnBeginOverlap)
```

## Vector3

### <a id="classfunction:Vector3.Lerp"></a>Vector3.Lerp

Vector3.Lerp is a function for finding a spot part way between two vectors. When combined with a tick function or loop, we can use it to smoothly animate something moving between two points.

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")
local myObject = World.SpawnAsset(propCubeTemplate)

local startPosition = Vector3.New(500, -500, 500)
local endPosition = Vector3.New(500, 500, 500)

myObject:SetWorldPosition(startPosition)

-- Note: You generally would not want to call SetWorldPosition except in a client context. (Otherwise,
-- it would "jitter" due to network lag.)  If you want to do this kind of effect for objects on the server,
-- consider using CoreObject:MoveTo() and similar functions!
for i = 1, 30 do
    myObject:SetWorldPosition(Vector3.Lerp(startPosition, endPosition, i/300))
    Task.Wait()
end

print("Tah dah!")
```

### <a id="constructor:Vector3.New"></a>Vector3.New

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

### <a id="constructor:Vector3.ZERO"></a>Vector3.ZERO

### <a id="constructor:Vector3.ONE"></a>Vector3.ONE

### <a id="constructor:Vector3.FORWARD"></a>Vector3.FORWARD

### <a id="constructor:Vector3.UP"></a>Vector3.UP

### <a id="constructor:Vector3.RIGHT"></a>Vector3.RIGHT

The Vector3 namespace includes a small selection of constants, for commonly-used Vector3 values.

```lua
print(Vector3.ZERO)    -- (0, 0, 0)

print(Vector3.ONE)    -- (1, 1, 1)

print(Vector3.FORWARD)    -- (1, 0, 0)

print(Vector3.RIGHT)    -- (0, 1, 0)

print(Vector3.UP)    -- (0, 0, 1)
```

### <a id="operator:Vector3+Vector3"></a>Vector3+Vector3

### <a id="operator:Vector3+Number"></a>Vector3+Number

### <a id="operator:Vector3-Vector3"></a>Vector3-Vector3

### <a id="operator:Vector3-Number"></a>Vector3-Number

### <a id="operator:Vector3*Vector3"></a>Vector3*Vector3

### <a id="operator:Vector3*Number"></a>Vector3*Number

### <a id="operator:Number*Vector3"></a>Number*Vector3

### <a id="operator:Vector3/Vector3"></a>Vector3/Vector3

### <a id="operator:Vector3/Number"></a>Vector3/Number

### <a id="operator:-Vector3"></a>-Vector3

Most arithmetic operators will work on Vector3s in straightforward ways.

```lua
local a = Vector3.New(1, 2, 3)
local b = Vector3.New(4, 5, 6)

-- Adding and subtracting vectors is the same as adding or subtracting each of their components.
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

### <a id="operator:Vector3.GetNormalized()"></a>Vector3.GetNormalized()

### <a id="operator:Vector3..Vector3"></a>Vector3..Vector3

### <a id="operator:Vector3^Vector3"></a>Vector3^Vector3

A normalized vector is a vector who's magnitude (size) is equal to 1. Vector3 variables have a `GetNormalized()` function, which returns this value. Its equivalent to dividing the vector by its own size, and is useful in linear algebra.

Dot Product and Cross Product are two other common linear algebra operations, which can be represented in Lua byh the `..` and `^` operators respectively.

Here is a sample that uses these operations to determine if an object is aimed within 15 degrees of a player.

```lua
local propCubeTemplate = script:GetCustomProperty("CubeTemplate")
local myObject = World.SpawnAsset(propCubeTemplate, {
        position = Vector3.New(500, 0, 250)
    })

myObject:RotateContinuous(Rotation.New(0, 0, 40))

for i = 1, 10, 0.05 do
    local playerPos = player:GetWorldPosition()
    local objectPos = myObject:GetWorldPosition()
    local objectAim = myObject:GetWorldTransform():GetForwardVector()
    local objToPlayer = (playerPos - objectPos):GetNormalized()

    -- draw a line so we can see where it is "looking"
    CoreDebug.DrawLine(objectPos, objectPos + objectAim * 1000,
        {
            duration = 0.05,
            thickness = 5,
            color = Color.RED
        })

    -- Is the object facing the player?  (And not 180 degrees the opposite direction?)
    -- When the vectors are normalized, (which these are), the dot product is equal to
    -- the cosine of the angle between the vectors. Which means it will be positive,
    -- if the two vectors aren't more than 90 degrees apart. This makes it a great way to check
    -- if something is "generally facing" something else!
    if (objToPlayer .. objectAim > 0) then
        -- Here we check if the player is actually within 15 degrees of the aim.
        -- we can do this, because if the input vectors are normalized (which again, these are),
        -- then the output vector has a magnitude equal to the sin of the angle between them.
        -- So this makes it a really easy way to check if a vector is within a certain angle
        -- of another vector. (Especially if we combine it with the previous check to make sure
        -- they're facing the same direction!)
        if (objToPlayer ^ objectAim).size < math.sin(15) then
            print("I see you!")
        end
    end
    Task.Wait(0.05)
end
```

### <a id="property:Vector3.size"></a>Vector3.size

### <a id="property:Vector3.sizeSquared"></a>Vector3.sizeSquared

A lot of vector math requires knowing the magnitude of a vector - i. e. if you think of the vector as a point, how far away is it from (0, 0, 0)?

In Lua, you can get that value via the `size` property. There is also the `sizeSquared` property, which is sometimes useful as a CPU optimization. Typically `sizeSquared` is used instead of `size` in distance comparisons, because if `a.size < b.size`, then `a.sizeSquared < b.sizeSquared`.

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

        end
    end
    Task.Wait(0.2)
end
```

### <a id="property:Vector3.x"></a>Vector3.x

### <a id="property:Vector3.y"></a>Vector3.y

### <a id="property:Vector3.z"></a>Vector3.z

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

## Vfx

### <a id="method:Vfx.Play"></a>Vfx.Play

In this example, a script is placed as a child of a Visual Effect object (e.g. Spark Explosion VFX). The `Play()` function is called periodically, with a random delay between 2 and 4 seconds. VFXs work best when they are under a client context.

```lua
local VFX = script.parent

local MIN_DELAY = 2
local MAX_DELAY = 4

while true do
    local delay = math.random(MIN_DELAY, MAX_DELAY)
    Task.Wait(delay)

    VFX:Play()
end
```

### <a id="method:Vfx.Stop"></a>Vfx.Stop

In this example, a script detects when players enter and exit a trigger. If there are any players in the trigger, a looping visual effect is played (e.g. Fire Volume VFX). Once all players have left the trigger the VFX stops playing. The `Stop()` function is also called in the very beginning in case the VFX comes with "Auto Play" enabled and we are assuming no players begin inside the trigger.

```lua
local VFX = script.parent
local TRIGGER = script:GetCustomProperty("Trigger"):WaitForObject()

VFX:Stop()

local playerCount = 0

function OnBeginOverlap(trigger, other)
    if other:IsA("Player") then
        playerCount = playerCount + 1

        if playerCount == 1 then
            VFX:Play()
        end
    end
end

function OnEndOverlap(trigger, other)
    if other:IsA("Player") then
        playerCount = playerCount - 1

        if playerCount == 0 then
            VFX:Stop()
        end
    end
end

TRIGGER.beginOverlapEvent:Connect(OnBeginOverlap)
TRIGGER.endOverlapEvent:Connect(OnEndOverlap)
```

## Weapon

### <a id="event:Weapon.projectileSpawnedEvent"></a>Weapon.projectileSpawnedEvent

Although it is ineffective to modify a projectile that comes through the `projectileSpawnedEvent`, it's still a useful event for various gameplay mechanics. In this example, a weapon script adds recoil impulse in the opposite direction of shots.

```lua
local WEAPON = script:FindAncestorByType('Weapon')
local KNOCKBACK_SPEED = 1000

-- Adds impulse to the owner once the attack ability is executed
function OnProjectileSpawned(weapon, projectile)
    local player = weapon.owner

    local projectileDirection = projectile:GetWorldTransform():GetForwardVector()
    local knockbackVector = projectileDirection * player.mass * -KNOCKBACK_SPEED

    -- Push the player away from the spawned projectile
    player:AddImpulse(knockbackVector)
end

WEAPON.projectileSpawnedEvent:Connect(OnProjectileSpawned)
```

### <a id="event:Weapon.targetImpactedEvent"></a>Weapon.targetImpactedEvent

In this example, a weapon has a healing mechanic, where the player gains 2 hit points each time they shoot an enemy player.

```lua
local WEAPON = script:FindAncestorByType('Weapon')

function OnTargetImpactedEvent(weapon, impactData)
    if impactData.other and impactData.other:IsA("Player") then
        weapon.owner.hitPoints = weapon.owner.hitPoints + 2
    end
end

WEAPON.targetImpactedEvent:Connect(OnTargetImpactedEvent)
```

### <a id="method:Weapon.Attack"></a>Weapon.Attack

Generally, weapons are thought to be equipped on players. However, a weapon can be used on an NPC such as a vehicle or tower by calling the `Attack()` function. In this example, a weapon simply fires each second. Shots will go out straight in the direction the weapon is pointing.

```lua
local WEAPON = script:FindAncestorByType('Weapon')

function Tick()
    WEAPON:Attack()
    Task.Wait(1)
end
```

### <a id="method:Weapon.HasAmmo"></a>Weapon.HasAmmo

In this example, a custom sound is played when someone picks up a weapon that has no ammo in it. For this hypothetical game, weapons can be found without any ammo and it's an important mechanic. It should be displayed in the user interface. However, players hear sound effects much faster than they can read UI.

```lua
local WEAPON = script:FindAncestorByType('Weapon')
local EMPTY_PICKUP_SOUND = script:GetCustomProperty("EmptyPickupSound")

function OnEquipped(weapon, player)
    if (not weapon:HasAmmo()) then
        World.SpawnAsset(EMPTY_PICKUP_SOUND, {position = weapon:GetWorldPosition()})
    end
end

WEAPON.equippedEvent:Connect(OnEquipped)
```

### <a id="property:Weapon.ammoType"></a>Weapon.ammoType

In this simple auto-reload script, the weapon's current ammo is monitored. If it goes to zero and the player has ammo of the correct type, then the reload ability is activated. This script only works in a client-context and expects the Reload ability to be assigned as a custom property.

```lua
local WEAPON = script:FindAncestorByType('Weapon')
local RELOAD_ABILITY = script:GetCustomProperty("Reload"):WaitForObject()

local LOCAL_PLAYER = Game.GetLocalPlayer()

function Tick(deltaTime)
    if WEAPON.owner ~= LOCAL_PLAYER then return end

    if WEAPON.currentAmmo == 0 and
    (not WEAPON.isAmmoFinite or LOCAL_PLAYER:GetResource(WEAPON.ammoType) > 0) then

        RELOAD_ABILITY:Activate()

        Task.Wait(
            RELOAD_ABILITY.castPhaseSettings.duration +
            RELOAD_ABILITY.executePhaseSettings.duration +
            RELOAD_ABILITY.recoveryPhaseSettings.duration)
    end
end
```

### <a id="property:Weapon.animationStance"></a>Weapon.animationStance

A weapon's `animationStance` is assigned to the player automatically when the item is equipped. In this example, we add an additional stance to the weapon in the form of a defensive posture that players can trigger by holding down the secondary ability button (mouse right-click). The script alternates betwen the shield block stance and the weapon's default stance, as the secondary button is pressed/released.

```lua
local WEAPON = script:FindAncestorByType('Weapon')
local ACTION_BINDING = "ability_secondary"
local ACTIVE_STANCE = "1hand_melee_shield_block"

function EnableStance(player)
    if Object.IsValid(player) and player == WEAPON.owner then
        player.animationStance = ACTIVE_STANCE
    end
end

function DisableStance(player)
    if WEAPON and Object.IsValid(player) then
        player.animationStance = WEAPON.animationStance
    end
end

function OnBindingPressed(player, actionName)
    if actionName == ACTION_BINDING then
        EnableStance(player)
    end
end

function OnBindingReleased(player, actionName)
    if actionName == ACTION_BINDING then
        DisableStance(player)
    end
end

function OnPlayerDied(player, damage)
    DisableStance(player)
end

function OnEquipped(weapon, player)
    player.bindingPressedEvent:Connect(OnBindingPressed)
    player.bindingReleasedEvent:Connect(OnBindingReleased)
end

WEAPON.equippedEvent:Connect(OnEquipped)
```

### <a id="property:Weapon.attackCooldownDuration"></a>Weapon.attackCooldownDuration

### <a id="property:Weapon.multiShotCount"></a>Weapon.multiShotCount

### <a id="property:Weapon.burstCount"></a>Weapon.burstCount

### <a id="property:Weapon.shotsPerSecond"></a>Weapon.shotsPerSecond

The following function approximates a weapon's effective damage per second (DPS).

```lua
local WEAPON = script:FindAncestorByType("Weapon")

function ComputeDPS(weapon)
    local dps = 6.2
    while weapon.shotsPerSecond < dps do
        dps = dps / 2
    end

    local burst = math.max(1, weapon.burstCount)
    if burst < weapon.maxAmmo or weapon.maxAmmo <= 0 then
        local burstPeriod = (burst / dps + weapon.attackCooldownDuration)
        dps = burst / burstPeriod
    end

    return dps * weapon.damage * weapon.multiShotCount
end

print("DPS = " .. ComputeDPS(WEAPON))
```

### <a id="property:Weapon.currentAmmo"></a>Weapon.currentAmmo

### <a id="property:Weapon.maxAmmo"></a>Weapon.maxAmmo

This script plays audio to the weapon owner when the weapon reaches 20% amount of ammo. It works best if the script is in a client context under the weapon, that way the audio is heard only by the player who is using the weapon.

```lua
local WEAPON = script:FindAncestorByType('Weapon')
local SHOOT_ABILITY = script:GetCustomProperty("ShootAbility"):WaitForObject()
local LOW_AMMO_SOUND = WEAPON:GetCustomProperty("LowAmmoSound")
local LOW_AMMO_PERCENTAGE = 0.2

function OnShootExecute(ability)
    if Object.IsValid(WEAPON) and ability.owner == WEAPON.owner then
        if WEAPON.currentAmmo / WEAPON.maxAmmo <= LOW_AMMO_PERCENTAGE then
            if LOW_AMMO_SOUND then
                World.SpawnAsset(LOW_AMMO_SOUND, {position = WEAPON:GetWorldPosition()})
            end
        end
    end
end

SHOOT_ABILITY.executeEvent:Connect(OnShootExecute)
```

### <a id="property:Weapon.isAmmoFinite"></a>Weapon.isAmmoFinite

### <a id="property:Weapon.reloadSoundId"></a>Weapon.reloadSoundId

While various properties are read-only, they are still useful in determining what behavior should occur, leading to more general purpose scripts. In this example, a script controls auto-reloading of weapons. It expects to be in a client context, because the ability's `Activate()` function is client-only.

```lua
local WEAPON = script:FindAncestorByType('Weapon')

local RELOAD_ABILITY = nil
-- Grabs reload ability from the weapon. Keep trying in case the client hasn't loaded the object yet
while not Object.IsValid(RELOAD_ABILITY) do
    Task.Wait()
    RELOAD_ABILITY = WEAPON:GetAbilities()[2]
end
-- The client script can now keep going, after it has acquired a reference to the reload ability
-- The above could also have been implemented with a :GetCustomProperty(...):WaitForObject()

-- Manually spawn the reloading audio
function SpawnReloadingAudio()
    if WEAPON.reloadSoundId ~= nil then
        World.SpawnAsset(WEAPON.reloadSoundId, {position = WEAPON:GetWorldPosition()})
    end
end

function Tick(deltaTime)

    -- Makes sure that the weapon owner is the local player
    if not Object.IsValid(WEAPON) then return end
    if not WEAPON.owner == Game.GetLocalPlayer() then return end

    if not WEAPON.isAmmoFinite then
        -- Checks when the weapon has empty ammo to reload
        if WEAPON.currentAmmo == 0 then
            SpawnReloadingAudio()
            RELOAD_ABILITY:Activate()
            Task.Wait(RELOAD_ABILITY.castPhaseSettings.duration)
        end
    end
end
```

### <a id="property:Weapon.isHitscan"></a>Weapon.isHitscan

### <a id="property:Weapon.range"></a>Weapon.range

### <a id="property:Weapon.damage"></a>Weapon.damage

### <a id="property:Weapon.projectileTemplateId"></a>Weapon.projectileTemplateId

### <a id="property:Weapon.trailTemplateId"></a>Weapon.trailTemplateId

### <a id="property:Weapon.impactSurfaceTemplateId"></a>Weapon.impactSurfaceTemplateId

### <a id="property:Weapon.impactProjectileTemplateId"></a>Weapon.impactProjectileTemplateId

### <a id="property:Weapon.impactPlayerTemplateId"></a>Weapon.impactPlayerTemplateId

### <a id="property:Weapon.projectileSpeed"></a>Weapon.projectileSpeed

### <a id="property:Weapon.projectileLifeSpan"></a>Weapon.projectileLifeSpan

### <a id="property:Weapon.projectileGravity"></a>Weapon.projectileGravity

### <a id="property:Weapon.projectileLength"></a>Weapon.projectileLength

### <a id="property:Weapon.projectileRadius"></a>Weapon.projectileRadius

### <a id="property:Weapon.projectileDrag"></a>Weapon.projectileDrag

This script implements a Wall Bang mechanic, allowing shots to go through walls.

Configuring walls/objects to be penetrable: For each wall or object that should be penetrable, add to them the "WallBang" custom property (float). Only objects with this property will be penetrable. Higher values mean the wall reduces more damage from shots that go through them. Objects with a "WallBang" value of 0 will let shots through but will not affect the damage amount.

Configuring this script on a weapon: Set this script's "WallBang" property to affect the weapon's penetrability when it's compared against objects. A higher value means it penetrates tougher walls and takes less damage reduction. A weapon can further control how much of its damage is reduced by setting the "DamageReduction" property on this script (Between zero and 1).

```lua
local WEAPON = script:FindAncestorByType("Weapon")
local WALL_BANG = script:GetCustomProperty("WallBang") or 2
local DAMAGE_REDUCTION = script:GetCustomProperty("DamageReduction") or 1

if WALL_BANG <= 0 then return end

function OnTargetImpactedEvent(weapon, impactData)
    if not Object.IsValid(weapon) then return end

    local wall = impactData.targetObject
    if not wall or not wall:IsA("StaticMesh") then return end

    -- If the wall hasn't defined the WallBang property it's impenetrable
    local wallBangResistance = wall:GetCustomProperty("WallBang")
    if not wallBangResistance or wallBangResistance >= WALL_BANG then return end

    -- Calculate damage
    local damage = weapon.damage
    if DAMAGE_REDUCTION > 0 then
        local percent = (WALL_BANG - wallBangResistance) / WALL_BANG
        damage = CoreMath.Lerp(0, weapon.damage, percent)

        percent = CoreMath.Clamp(DAMAGE_REDUCTION)
        damage = CoreMath.Lerp(weapon.damage, damage, percent)
    end

    -- Gather info about position and direction of the shot
    local impactPos = impactData:GetHitResult():GetImpactPosition()
    local direction = impactPos - weapon:GetWorldPosition()
    local remainingTravel = weapon.range - impactData.travelDistance

    -- TODO : Perhaps do more if the weapon is of hitscan type
    if not weapon.isHitscan then
        if impactData.projectile then
            direction = impactData.projectile:GetVelocity()
        end
    end
    direction = direction:GetNormalized()

    -- Do a series of raycasts to figure out where is the bullet's exit point
    local rayStart = impactPos + direction * 5
    local rayEnd = rayStart + direction * remainingTravel
    local rayParams = {}

    if Object.IsValid(impactData.weaponOwner) and impactData.weaponOwner.team > 0 then
        rayParams.ignoreTeams = weapon.owner.team
    end

    local hit = World.Raycast(rayStart, rayEnd, rayParams)
    if hit then
        rayEnd = rayStart
        rayStart = hit:GetImpactPosition()
    else
        local swapValue = rayEnd
        rayEnd = rayStart
        rayStart = swapValue
    end
    -- The 'hitInverted' is the info about the bullet's exit point
    local hitInverted = World.Raycast(rayStart, rayEnd, rayParams)
    if not hitInverted then return end

    -- Spawn the surface impact VFX on the opposite side of the object
    if weapon.impactSurfaceTemplateId then
        local t = hitInverted:GetTransform()
        SpawnVfx(weapon.impactSurfaceTemplateId, t:GetPosition(), t:GetRotation())
    end

    -- Spawn a new projectile to continue on the trajectory
    local projLength = 5 + weapon.projectileLength + weapon.projectileRadius
    startPos = hitInverted:GetImpactPosition() + direction * projLength
    local projectile = Projectile.Spawn(weapon.projectileTemplateId, startPos, direction)
    -- Copy properties from the weapon to the new projectile
    projectile.owner = impactData.weaponOwner
    projectile.sourceAbility = impactData.sourceAbility
    projectile.speed = weapon.projectileSpeed
    projectile.gravityScale = weapon.projectileGravity
    projectile.drag = weapon.projectileDrag
    projectile.lifeSpan = weapon.projectileLifeSpan * remainingTravel / weapon.range
    projectile.capsuleLength = weapon.projectileLength
    projectile.capsuleRadius = weapon.projectileRadius
    -- If some weapon properties are needed later it's safer to stash them in serverUserData,
    -- because the weapon might be destroyed while the projectile is still in the air:
    projectile.serverUserData.impactSurfaceTemplateId = weapon.impactSurfaceTemplateId
    projectile.serverUserData.impactPlayerTemplateId = weapon.impactPlayerTemplateId
    projectile.serverUserData.impactProjectileTemplateId = weapon.impactProjectileTemplateId
    projectile.serverUserData.direction = direction
    -- Store damage calculation onto the projectile because there may be multiple ones
    projectile.serverUserData.damage = damage

    -- Listen for the impact, to spawn effects and apply damage
    projectile.impactEvent:Connect(OnProjectileImpacted)

    -- Spawn a trail to follow the projectile
    if weapon.trailTemplateId and projectile.speed > 0 then
        local pos = hitInverted:GetImpactPosition()
        local trailLifeSpan = (rayStart - pos).size / projectile.speed
        trailLifeSpan = math.min(projectile.lifeSpan, trailLifeSpan)
        if trailLifeSpan > 0 then
            local rot = Rotation.New(direction, Vector3.UP)
            local trail = World.SpawnAsset(weapon.trailTemplateId, {position = pos, rotation = rot})
            trail:MoveContinuous(direction * projectile.speed)
            trail.lifeSpan = trailLifeSpan
        end
    end
end

function OnProjectileImpacted(projectile, other, hitResult)
    if not Object.IsValid(projectile) then return end

    local impactTemplate = nil

    if other:IsA("Player") then
        -- Construct and apply damage to player
        local dmg = Damage.New(projectile.serverUserData.damage)
        dmg.reason = DamageReason.COMBAT
        dmg:SetHitResult(hitResult)
        dmg.sourceAbility = projectile.sourceAbility
        dmg.sourcePlayer = projectile.owner
        other:ApplyDamage(dmg)

        impactTemplate = projectile.serverUserData.impactPlayerTemplateId
    else
        impactTemplate = projectile.serverUserData.impactSurfaceTemplateId
       end

    -- Spawn impact VFX
    local t = hitResult:GetTransform()
    if impactTemplate then
        SpawnVfx(impactTemplate, t:GetPosition(), t:GetRotation())
    end

    impactTemplate = projectile.serverUserData.impactProjectileTemplateId
    if impactTemplate then
        local rot = Rotation.New(projectile.serverUserData.direction, Vector3.UP)
        SpawnVfx(impactTemplate, t:GetPosition(), rot)
    end
end

function SpawnVfx(template, pos, rot)
    local vfx = World.SpawnAsset(template, {position = pos, rotation = rot})
    if vfx.lifeSpan <= 0 then
        vfx.lifeSpan = 1.2
    end
end

WEAPON.targetImpactedEvent:Connect(OnTargetImpactedEvent)
```

### <a id="property:Weapon.muzzleFlashTemplateId"></a>Weapon.muzzleFlashTemplateId

This sample demonstrates several things. First, it creates a copy of the weapon's muzzle flash effect and attaches it to where the script is. Then, it shows how to traverse an object's hierarchy and create a custom table of objects to operate upon later--in this case it's trying to find smart objects that have both the `Stop()` and `Play()` functions. Finally, It shows how sound and VFX from a single spawned template can be played and stopped randomly--in other words, they are reused without having to spawn a new copy of the template each time.

```lua
local WEAPON = script:FindAncestorByType("Weapon")

if WEAPON.muzzleFlashTemplateId == nil then return end

local smartObjects = {}

local muzzleInstance = World.SpawnAsset(WEAPON.muzzleFlashTemplateId, {parent = script})

-- A utility function that runs the same operation on all nodes in an object's hierarchy
function ForEachChild(coreObj, functionToCall)
    functionToCall(coreObj)

    for _,child in ipairs(coreObj:GetChildren()) do
        ForEachChild(child, functionToCall)
    end
end

-- Find all the core objects in the template that have both the Play() and Stop() functions
ForEachChild(muzzleInstance, function(coreObj)
    if coreObj.Play and coreObj.Stop then
        table.insert(smartObjects, coreObj)

        coreObj:Stop()
    end
end)

while true do
    -- Wait between 0 and 1 second
    Task.Wait(math.random())

    -- Play all the effects
    for _,obj in ipairs(smartObjects) do
        obj:Play()
    end

    -- Wait between 0 and 0.3 seconds
    Task.Wait(math.random() * 0.3)

    -- Stop all the effects
    for _,obj in ipairs(smartObjects) do
        obj:Stop()
    end
    -- Repeat...
end
```

### <a id="property:Weapon.outOfAmmoSoundId"></a>Weapon.outOfAmmoSoundId

Weapons are also of type Equipment. In this example we listen to when a player equips the weapon. When they do, if the weapon is out of ammo then we play the "out of ammo" sound effect which normally only plays after trying to shoot while empty.

```lua
local WEAPON = script:FindAncestorByType('Weapon')

function OnEquipped(equipment, player)
    if WEAPON.currentAmmo == 0 and WEAPON.outOfAmmoSoundId then
        local pos = WEAPON:GetWorldPosition()
        World.SpawnAsset(WEAPON.outOfAmmoSoundId, {position = pos})
    end
end
WEAPON.equippedEvent:Connect(OnEquipped)
```

### <a id="property:Weapon.projectileBounceCount"></a>Weapon.projectileBounceCount

### <a id="property:Weapon.projectilePierceCount"></a>Weapon.projectilePierceCount

A weapon-viewing interface can show detailed specs about each weapon to players. In this example, the weapon's damage, as well as indicators if the shots bounce or pierce are setup for the player to view. This script would exist as part of a greater user interface, with various images and texts, and the ShowUI() function would be called depending on the game state (e.g. the player is browsing a shop).

```lua
local WEAPON_DETAILS_UI = script.parent
local DAMAGE_LABEL = script:GetCustomProperty("DamageLabel"):WaitForObject()
local BOUNCE_UI = script:GetCustomProperty("BounceGroup"):WaitForObject()
local PIERCE_UI = script:GetCustomProperty("PierceGroup"):WaitForObject()

function ShowUI(weapon)
    WEAPON_DETAILS_UI.visibility = Visibility.INHERIT

    -- Damage
    DAMAGE_LABEL.text = "Damage: " .. tostring(weapon.damage)

    -- Bounces? yes/no
    if weapon.projectileBounceCount > 0 then
        BOUNCE_UI.visibility = Visibility.INHERIT
    else
        BOUNCE_UI.visibility = Visibility.FORCE_OFF
    end

    -- Pierces? yes/no
    if weapon.projectilePierceCount > 0 then
        PIERCE_UI.visibility = Visibility.INHERIT
    else
        PIERCE_UI.visibility = Visibility.FORCE_OFF
    end
end

function HideUI()
    WEAPON_DETAILS_UI.visibility = Visibility.FORCE_OFF
end
```

### <a id="property:Weapon.shouldBurstStopOnRelease"></a>Weapon.shouldBurstStopOnRelease

The following function evaluates a weapon and returns the "type" of weapon it thinks it is, based on some of its properties.

```lua
WeaponClass.AutomaticRifle = 1
WeaponClass.BurstRifle = 2
WeaponClass.Sniper = 3
WeaponClass.Pistol = 4
WeaponClass.Shotgun = 5

function ClassifyWeapon(weapon)
    if weapon.burst > 1 then
        if weapon.shouldBurstStopOnRelease then
            return WeaponClass.AutomaticRifle
        else
            return WeaponClass.BurstRifle
        end
    else
        if weapon.multiShotCount > 1 then
            return WeaponClass.Shotgun

        elseif string.match(weapon:GetAbilities()[1].animation, "pistol") then
            return WeaponClass.Pistol
        else
            return WeaponClass.Sniper
        end
    end
end
```

### <a id="property:Weapon.spreadMin"></a>Weapon.spreadMin

### <a id="property:Weapon.spreadMax"></a>Weapon.spreadMax

### <a id="property:Weapon.spreadAperture"></a>Weapon.spreadAperture

### <a id="property:Weapon.spreadDecreaseSpeed"></a>Weapon.spreadDecreaseSpeed

### <a id="property:Weapon.spreadIncreasePerShot"></a>Weapon.spreadIncreasePerShot

### <a id="property:Weapon.spreadPenaltyPerShot"></a>Weapon.spreadPenaltyPerShot

It can be hard to understand the implications of spread on the efficacy of a weapon, especially as there is a complex relationship with firing rate. This example demonstrates a data-driven approach to studying gameplay. If this script is added to each weapon they will register their stats into a global table, which could then be analyzed to draw conclusions about the game's balance.

```lua
local WEAPON = script:FindAncestorByType("Weapon")

if _G.WeaponStudy == nil then
    _G.WeaponStudy = {}
    _G.WeaponStudy.samples = {}

    _G.WeaponStudy.AddSample = function(weapon)
        local key = weapon.name
        if _G.WeaponStudy.samples[key] then return end

        _G.WeaponStudy.samples[key] = {
            spreadMin = weapon.spreadMin,
            spreadMax = weapon.spreadMax,
            spreadAperture = weapon.spreadAperture,
            spreadDecreaseSpeed = weapon.spreadDecreaseSpeed,
            spreadPenaltyPerShot = weapon.spreadPenaltyPerShot,
            damageDealt = 0
        }
    end

    _G.WeaponStudy.ReportDamage = function(weapon, amount)
        local key = weapon.name
        local dmg = _G.WeaponStudy.samples[key].damageDealt
        _G.WeaponStudy.samples[key].damageDealt = dmg + amount
    end
end

_G.WeaponStudy.AddSample(WEAPON)

local GOOD = true
local BAD = false

function CalcStatRating(statName, compareTo, goodOrBad)
    local minValue
    local maxValue
    for weaponName,data in pairs(_G.WeaponStudy.samples) do
        local statValue = data[statName]
        if not minValue or statValue < minValue then
            minValue = statValue
        end
        if not maxValue or statValue > maxValue then
            maxValue = statValue
        end
    end
    if not minValue then
        error("Missing samples")
        return
    end

    local result
    if maxValue == minValue then
        -- Avoid division by zero
        result = 1
    else
        result = (compareTo - minValue) / (maxValue - minValue)
    end

    if goodOrBad == GOOD then
        return result
    end
    return 1 - result
end

function RateMyGun()
    local spreadMinRating = CalcStatRating("spreadMin", WEAPON.spreadMin, BAD)
    local spreadMaxRating = CalcStatRating("spreadMax", WEAPON.spreadMax, BAD)
    local spreadApertureRating = CalcStatRating("spreadAperture", WEAPON.spreadAperture, BAD)
    local spreadDecreaseSpeedRating = CalcStatRating("spreadDecreaseSpeed", WEAPON.spreadDecreaseSpeed, GOOD)
    local spreadPenaltyPerShotRating = CalcStatRating("spreadPenaltyPerShot", WEAPON.spreadPenaltyPerShot, BAD)
    print("")
    print("Rating - " .. WEAPON.name)
    print("  spreadMin: " .. tostring(spreadMinRating))
    print("  spreadMax: " .. tostring(spreadMaxRating))
    print("  spreadAperture: " .. tostring(spreadApertureRating))
    print("  spreadDecreaseSpeed: " .. tostring(spreadDecreaseSpeedRating))
    print("  spreadPenaltyPerShot: " .. tostring(spreadPenaltyPerShotRating))
end

-- We're keeping track of damage dealt here, but additional study is needed to draw conclusions.
-- Plus, this would need to be tested in multiplayer and the data accessed somehow.
function OnTargetImpacted(weapon, impactData)
    if impactData.other and impactData.other:IsA("Player") then
        -- The damage calculation may change per weapon. This is a generic example
        local damageAmount = weapon.damage

        _G.WeaponStudy.ReportDamage(WEAPON, damageAmount)
    end
end
WEAPON.targetImpactedEvent:Connect(OnTargetImpacted)

-- Rate each gun based on how it measures against all the other ones in the hierarchy.
-- Works best if there are several guns in the scene, with a varying spread of stats.
Task.Wait(1)
RateMyGun()
```

### <a id="property:Weapon.spreadMin"></a>Weapon.spreadMin

### <a id="property:Weapon.spreadMax"></a>Weapon.spreadMax

### <a id="property:Weapon.spreadDecreaseSpeed"></a>Weapon.spreadDecreaseSpeed

Often in shooting games, the weapon loses precision while moving. For weapons in Core this is achieved by modifying the player's `spreadModifier` property, and can be implemented in many different ways. In this example, a client-context script uses the weapon's configured `spreadMin` and `spreadMax` properties to determine the maximum penalty when the player is moving. The weapon's `spreadDecreaseSpeed` is then used as an interpolation coefficient to smoothly move the spread penalty up and down, non-linearly, as the player moves or stops moving.

```lua
local WEAPON = script:FindAncestorByType("Weapon")
local MOVING_THRESHOLD = 250

local wasMoving = false
local targetSpreadModifier = 0

function Tick()
    local player = WEAPON.owner
    if not Object.IsValid(player) then return end

    -- Evaluate if the player is moving right now
    local isMovingNow = false
    if player.isJumping then
        isMovingNow = true
    else
        local playerSpeed = player:GetVelocity().size
        if playerSpeed >= MOVING_THRESHOLD then
            isMovingNow = true
        end
    end

    -- Select target spread modifier based on current movement
    if isMovingNow ~= wasMoving then
        if isMovingNow then
            -- Moving
            targetSpreadModifier = WEAPON.spreadMax - WEAPON.spreadMin
        else
            -- Not moving
            targetSpreadModifier = 0
        end
    end
    wasMoving = isMovingNow

    -- Adjust the player spread modify gradually over time
    local t = WEAPON.spreadDecreaseSpeed / 100
    player.spreadModifier = CoreMath.Lerp(player.spreadModifier, targetSpreadModifier, t)
end
```

## World

### <a id="classfunction:World.FindObjectById"></a>World.FindObjectById

Finds an object in the hierarchy based on it's unique ID. To find an object's ID, right-click them in the hierarchy and select "Copy MUID". An object's ID can also be obtained at runtime through the `id` property. In this example we search for the default sky folder and print a warning if we find it.

```lua
local objectId = "8AD92A81CCE73D72:Default Sky"
local defaultSkyFolder = World.FindObjectById(objectId)
if defaultSkyFolder then
    warn(" The default sky is pretty good, but customizing the sky has a huge impact on your game's mood!")
end
```

### <a id="classfunction:World.FindObjectByName"></a>World.FindObjectByName

Returns only one object with the given name. This example searches the entire hierarchy for the default floor object and prints a warning if it's found.

```lua
local floorObject = World.FindObjectByName("Default Floor")
-- Protect against error if the floor is missing from the game
if floorObject then
    warn(" Don't forget to replace the default floor with something better!")
end
```

### <a id="classfunction:World.FindObjectsByName"></a>World.FindObjectsByName

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

### <a id="classfunction:World.FindObjectsByType"></a>World.FindObjectsByType

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

### <a id="classfunction:World.GetRootObject"></a>World.GetRootObject

There is a parent CoreObject for the entire hierarchy. Although not visible in the user interface, it's accessible with the World.GetRootObject() class function. This example walks the whole hierarchy tree (depth first) and prints the name+type of each Core Object.

```lua
function PrintAllNames(node)
    for _,child in ipairs(node:GetChildren()) do
        print(child.name .. " + " .. child.type)
        PrintAllNames(child)
    end
end
local worldRoot = World.GetRootObject()
PrintAllNames(worldRoot)
```

### <a id="classfunction:World.Raycast"></a>World.Raycast

This example causes all players in the game to fly when they step off a ledge or jump. It does thy by using the Raycast() function to measure each player's distance to the ground below them.

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

### <a id="classfunction:World.SpawnAsset"></a>World.SpawnAsset

In this example, whenever a player dies, an explosion VFX template is spawned  in their place and their body is flown upwards. The SpawnAsset() function also returns a reference to the new object, which allows us to do any number of adjustments to it--in this case a custom life span. This example assumes an explosion template exists in the project and it was added as a custom property onto the script object.

```lua
local EXPLOSION_TEMPLATE = script:GetCustomProperty("ExplosionVFX")

function OnPlayerDied(player, dmg)
    local playerPos = player:GetWorldPosition()
    local explosionObject = World.SpawnAsset(EXPLOSION_TEMPLATE, {position = playerPos})
    explosionObject.lifeSpan = 3

    player:AddImpulse(Vector3.UP * 1000 * player.mass)
end

function OnPlayerJoined(player)
    player.diedEvent:Connect(OnPlayerDied)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

## WorldText

### <a id="method:WorldText.GetColor"></a>WorldText.GetColor

### <a id="method:WorldText.SetColor"></a>WorldText.SetColor

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

### <a id="property:WorldText.text"></a>WorldText.text

Change the contents of a WorldText object with the `text` property. In this example, when a new player joins the game their name is written to the WorldText. It's also demonstrated that `<br>` can be used to insert line breaks. This script expects to be the child of a WorldText object that is placed in the scene.

```lua
local nameTextObject = script.parent

Game.playerJoinedEvent:Connect(function (player)
    nameTextObject.text = player.name .. "<br>has joined the game!<br>GLHF!"
end)
```

## Needed

- What isn't represented here? Let us know!
- To add more, enter the details in the form [here](https://forms.gle/br8ZjanQGU2LkBvPA).
