---
id: player
name: Player
title: Player
tags:
    - API
---

# Player

Player is an object representation of the state of a player connected to the game, as well as their avatar in the world.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `name` | `string` | The Player's name. | Read-Write |
| `id` | `string` | The unique id of the Player. Consistent across sessions. | Read-Only |
| `team` | `integer` | The number of the team to which the Player is assigned. By default, this value is 255 in FFA mode. | Read-Write |
| `animationStance` | `string` | Which set of animations to use for this Player. See [Animation Stance Strings](../api/animations.md#animation-stance-strings) for possible values. | Read-Write |
| `currentFacingMode` | [`FacingMode`](enums.md#facingmode) | Current mode applied to player, including possible overrides. Possible values are FacingMode.FACE_AIM_WHEN_ACTIVE, FacingMode.FACE_AIM_ALWAYS, and FacingMode.FACE_MOVEMENT. See desiredFacingMode for details. | Read-Only |
| `desiredFacingMode` | [`FacingMode`](enums.md#facingmode) | Which controls mode to use for this Player. May be overridden by certain movement modes like MovementMode.SWIMMING or when mounted. Possible values are FacingMode.FACE_AIM_WHEN_ACTIVE, FacingMode.FACE_AIM_ALWAYS, and FacingMode.FACE_MOVEMENT. | Read-Write, Server-Only |
| `defaultRotationRate` | `number` | Determines how quickly the Player turns to match the camera's look. Set to -1 for immediate rotation. Currently only supports rotation around the Z-axis. | Read-Write, Server-Only |
| `currentRotationRate` | `number` | Reports the real rotation rate that results from any active mechanics/movement overrides. | Read-Only |
| `hitPoints` | `number` | Current amount of hitpoints. | Read-Write |
| `maxHitPoints` | `number` | Maximum amount of hitpoints. | Read-Write |
| `kills` | `integer` | The number of times the player has killed another player. | Read-Write |
| `deaths` | `integer` | The number of times the player has died. | Read-Write |
| `stepHeight` | `number` | Maximum height in centimeters the Player can step up. Range is 0-100. Default = 45. | Read-Write |
| `maxWalkSpeed` | `number` | Maximum speed while the player is on the ground. Clients can only read. Default = 640. | Read-Write |
| `maxAcceleration` | `number` | Max Acceleration (rate of change of velocity). Clients can only read. Default = 1800. | Read-Write |
| `brakingDecelerationFalling` | `number` | Deceleration when falling and not applying acceleration. Default = 0. | Read-Write |
| `brakingDecelerationWalking` | `number` | Deceleration when walking and movement input has stopped. Default = 1000. | Read-Write |
| `groundFriction` | `number` | Friction when walking on ground. Default = 8.0 | Read-Write |
| `brakingFrictionFactor` | `number` | Multiplier for friction when braking. Default = 0.6. | Read-Write |
| `walkableFloorAngle` | `number` | Max walkable floor angle, in degrees. Clients can only read. Default = 44. | Read-Write |
| `maxJumpCount` | `integer` | Max number of jumps, to enable multiple jumps. Set to 0 to disable jumping. | Read-Write |
| `jumpVelocity` | `number` | Vertical speed applied to Player when they jump. Default = 900. | Read-Write |
| `gravityScale` | `number` | Multiplier on gravity applied. Default = 1.9. | Read-Write |
| `maxSwimSpeed` | `number` | Maximum speed while the player is swimming. Default = 420. | Read-Write |
| `touchForceFactor` | `number` | Force applied to physics objects when contacted with a Player. Default = 1. | Read-Write |
| `isCrouchEnabled` | `boolean` | Turns crouching on/off for a Player. | Read-Write |
| `mass` | `number` | Gets the mass of the Player. | Read-Only |
| `isAccelerating` | `boolean` | True if the Player is accelerating, such as from input to move. | Read-Only |
| `isCrouching` | `boolean` | True if the Player is crouching. | Read-Only |
| `isFlying` | `boolean` | True if the Player is flying. | Read-Only |
| `isGrounded` | `boolean` | True if the Player is on the ground with no upward velocity, otherwise false. | Read-Only |
| `isJumping` | `boolean` | True if the Player is jumping. | Read-Only |
| `isMounted` | `boolean` | True if the Player is mounted on another object. | Read-Only |
| `isSwimming` | `boolean` | True if the Player is swimming in water. | Read-Only |
| `isWalking` | `boolean` | True if the Player is in walking mode. | Read-Only |
| `isDead` | `boolean` | True if the Player is dead, otherwise false. | Read-Only |
| `movementControlMode` | [`MovementControlMode`](enums.md#movementcontrolmode) | Specify how players control their movement. Clients can only read. Default: MovementControlMode.LOOK_RELATIVE. MovementControlMode.NONE: Movement input is ignored. MovementControlMode.LOOK_RELATIVE: Forward movement follows the current player's look direction. MovementControlMode.VIEW_RELATIVE: Forward movement follows the current view's look direction. MovementControlMode.FACING_RELATIVE: Forward movement follows the current player's facing direction. MovementControlMode.FIXED_AXES: Movement axis are fixed. | Read-Write |
| `lookControlMode` | [`LookControlMode`](enums.md#lookcontrolmode) | Specify how players control their look direction. Default: LookControlMode.RELATIVE. LookControlMode.NONE: Look input is ignored. LookControlMode.RELATIVE: Look input controls the current look direction. LookControlMode.LOOK_AT_CURSOR: Look input is ignored. The player's look direction is determined by drawing a line from the player to the cursor on the Cursor Plane. | Read-Write |
| `lookSensitivity` | `number` | Multiplier on the Player look rotation speed relative to cursor movement. This is independent from user's preferences, both will be applied as multipliers together. Default = 1.0. | Read-Write, Client-Only |
| `spreadModifier` | `number` | Modifier added to the Player's targeting spread. | Read-Write |
| `currentSpread` | `number` | Gets the Player's current targeting spread. | Read-Only, Client-Only |
| `buoyancy` | `number` | In water, buoyancy 1.0 is neutral (won't sink or float naturally). Less than 1 to sink, greater than 1 to float. | Read-Write |
| `canMount` | `boolean` | Returns whether the Player can manually toggle on/off the mount. | Read-Write, Server-Only |
| `shouldDismountWhenDamaged` | `boolean` | If `true`, and the Player is mounted they will dismount if they take damage. | Read-Write, Server-Only |
| `isVisibleToSelf` | `boolean` | Set whether to hide the Player model on Player's own client, for sniper scope, etc. | Read-Write, Client-Only |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetWorldTransform()` | [`Transform`](transform.md) | The absolute Transform of this player. | None |
| `SetWorldTransform(Transform)` | `None` | The absolute Transform of this player. | Server-Only |
| `GetWorldPosition()` | [`Vector3`](vector3.md) | The absolute position of this player. | None |
| `SetWorldPosition(Vector3)` | `None` | The absolute position of this player. | Server-Only |
| `GetWorldRotation()` | [`Rotation`](rotation.md) | The absolute rotation of this player. | None |
| `SetWorldRotation(Rotation)` | `None` | The absolute rotation of this player. | Server-Only |
| `GetWorldScale()` | [`Vector3`](vector3.md) | The absolute scale of this player. | None |
| `SetWorldScale(Vector3)` | `None` | The absolute scale of this player (must be uniform). | Server-Only |
| `AddImpulse(Vector3)` | `None` | Adds an impulse force to the Player. | Server-Only |
| `GetVelocity()` | [`Vector3`](vector3.md) | Gets the current velocity of the Player. | None |
| `SetVelocity(Vector3)` | `None` | Sets the Player's velocity to the given amount. | Server-Only |
| `ResetVelocity()` | `None` | Resets the Player's velocity to zero. | Server-Only |
| `GetAbilities()` | `Array<`[`Ability`](ability.md)`>` | Array of all Abilities assigned to this Player. | None |
| `GetEquipment()` | `Array<`[`Equipment`](equipment.md)`>` | Array of all Equipment assigned to this Player. | None |
| `ApplyDamage(Damage)` | `None` | Damages a Player. If their hit points go below 0 they die. | Server-Only |
| `Die([Damage])` | `None` | Kills the Player. They will ragdoll and ignore further Damage. The optional Damage parameter is a way to communicate cause of death. | Server-Only |
| `DisableRagdoll()` | `None` | Disables all ragdolls that have been set on the Player. | Server-Only |
| `SetVisibility(boolean, [boolean])` | `None` | Shows or hides the Player. The second parameter is optional, defaults to true, and determines if attachments to the Player are hidden as well as the Player. | Server-Only |
| `GetVisibility()` | `boolean` | Returns whether or not the Player is hidden. | None |
| `EnableRagdoll([string socketName, number weight])` | `None` | Enables ragdoll for the Player, starting on `socketName` weighted by `weight` (between 0.0 and 1.0). This can cause the Player capsule to detach from the mesh. All parameters are optional; `socketName` defaults to the root and `weight` defaults to 1.0. Multiple bones can have ragdoll enabled simultaneously. See [Socket Names](../api/animations.md#socket-names) for the list of possible values. | Server-Only |
| `Respawn([table parameters])` | `None` | Resurrects a dead Player based on respawn settings in the game (default in-place). An optional table may be provided to override the following parameters:<br>`position (Vector3)`: Respawn at this position. Defaults to the position of the spawn point selected based on the game's respawn settings, or the player's current position if no spawn point was selected.<br>`rotation (Rotation)`: Sets the player's rotation after respawning. Defaults to the rotation of the selected spawn point, or the player's current rotation if no spawn point was selected.<br>`scale (Vector3)`: Sets the player's scale after respawning. Defaults to the Player Scale Multiplier of the selected spawn point, or the player's current scale if no spawn point was selected. Player scale must be uniform. (All three components must be equal.) | Server-Only |
| `Respawn(Vector, Rotation)` | `None` | Resurrects a dead Player at a specific location and rotation. This form of `Player:Respawn()` may be removed at some point in the future. It is recommended to use the optional parameter table if position and rotation need to be specified. For example: `player:Respawn({position = newPosition, rotation = newRotation})` | Server-Only, **Deprecated** |
| `GetViewWorldPosition()` | [`Vector3`](vector3.md) | Get position of the Player's camera view. | None |
| `GetViewWorldRotation()` | [`Rotation`](rotation.md) | Get rotation of the Player's camera view. | None |
| `GetLookWorldRotation()` | [`Rotation`](rotation.md) | Get the rotation for the direction the Player is facing. | None |
| `SetLookWorldRotation(Rotation)` | `None` | Set the rotation for the direction the Player is facing. | Client-Only |
| `ClearResources()` | `None` | Removes all resources from a player. | Server-Only |
| `GetResources()` | `table<string, integer>` | Returns a table containing the names and amounts of the player's resources. | None |
| `GetResource(string name)` | `integer` | Returns the amount of a resource owned by a player. Returns 0 by default. | None |
| `SetResource(string name, integer amount)` | `None` | Sets a specific amount of a resource on a player. | Server-Only |
| `AddResource(string name, integer amount)` | `None` | Adds an amount of a resource to a player. | Server-Only |
| `RemoveResource(string name, integer amount)` | `None` | Subtracts an amount of a resource from a player. Does not go below 0. | Server-Only |
| `TransferToGame(string)` | `None` | Does not work in preview mode or in games played locally. Transfers player to the game specified by the passed-in game ID. Example: The game ID for the URL `https://www.coregames.com/games/577d80/core-royale` is `577d80/core-royale`. | Server-Only |
| `GetAttachedObjects()` | `Array<`[`CoreObject`](coreobject.md)`>` | Returns a table containing CoreObjects attached to this player. | None |
| `SetMounted(boolean)` | `None` | Forces a player in or out of mounted state. | Server-Only |
| `GetActiveCamera()` | [`Camera`](camera.md) | Returns whichever camera is currently active for the Player. | Client-Only |
| `GetDefaultCamera()` | [`Camera`](camera.md) | Returns the default Camera object the Player is currently using. | Client-Only |
| `SetDefaultCamera(Camera, [number lerpTime = 0.0])` | `None` | Sets the default Camera object for the Player. | Client-Only |
| `GetOverrideCamera()` | [`Camera`](camera.md) | Returns the override Camera object the Player is currently using. | Client-Only |
| `SetOverrideCamera(Camera, [number lerpTime = 0.0])` | `None` | Sets the override Camera object for the Player. | Client-Only |
| `ClearOverrideCamera([number lerpTime = 0.0])` | `None` | Clears the override Camera object for the Player (to revert back to the default camera). | Client-Only |
| `ActivateFlying()` | `None` | Activates the Player flying mode. | Server-Only |
| `ActivateWalking()` | `None` | Activate the Player walking mode. | Server-Only |
| `IsBindingPressed(string bindingName)` | `boolean` | Returns `true` if the player is currently pressing the named binding. Possible values of the bindings are listed on the [Ability binding](../api/key_bindings.md) page. Note that when called on a client, this function will only work for the local player. | None |
| `HasPerk(NetReference)` | `boolean` | Returns `true` if the player has one or more of the specified perk. | None |
| `GetPerkCount(NetReference)` | `integer` | Returns how many of the specified perk the player owns. For non-repeatable perks, returns `1` if the player owns the perk, or `0` if the player does not. | None |
| `GetPerkTimeRemaining(NetReference)` | `number` | Returns the amount of time remaining (in seconds) until a Limited Time Perk expires. Returns `0` if the player does not own the specified perk, or infinity for a permanent or repeatable perk that the player owns. | None |

## Events

| Event Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `damagedEvent` | `Event<`[`Player`](player.md), [`Damage`](damage.md)`>` | Fired when the Player takes damage. | Server-Only |
| `diedEvent` | `Event<`[`Player`](player.md), [`Damage`](damage.md)`>` | Fired when the Player dies. | Server-Only |
| `respawnedEvent` | `Event<`[`Player`](player.md)`>` | Fired when the Player respawns. | Server-Only |
| `bindingPressedEvent` | `Event<`[`Player`](player.md), string`>` | Fired when an action binding is pressed. Second parameter tells you which binding. Possible values of the bindings are listed on the [Ability binding](../api/key_bindings.md) page. | None |
| `bindingReleasedEvent` | `Event<`[`Player`](player.md), string`>` | Fired when an action binding is released. Second parameter tells you which binding. | None |
| `resourceChangedEvent` | `Event<`[`Player`](player.md), string, integer`>` | Fired when a resource changed, indicating the type of the resource and its new amount. | None |
| `perkChangedEvent` | `Event<`[`Player`](player.md), NetReference perkReference`>` | Fired when a player's list of owned perks has changed, indicating which perk's amount has changed. Do not expect this event to fire for perks that a player already has when they join a game. Use the `HasPerk(NetReference)` or `GetPerkCount(NetReference)` function for any initial logic that needs to be handled when joining. Also, this event may not actively fire when a perk expires, but it may fire for an expired perk as a result of purchasing a different perk. | None |
| `movementModeChangedEvent` | `Event<`[`Player`](player.md), MovementMode, MovementMode`>` | Fired when a Player's movement mode changes. The first parameter is the Player being changed. The second parameter is the "new" movement mode. The third parameter is the "previous" movement mode. Possible values for MovementMode are: MovementMode.NONE, MovementMode.WALKING, MovementMode.FALLING, MovementMode.SWIMMING, MovementMode.FLYING. | None |

## Hooks

| Hook Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `movementHook` | `Hook<`[`Player`](player.md), table parameters`>` | Hook called when processing a Player's movement. The `parameters` table contains a `Vector3` named "direction", indicating the direction the player will move. | Client-Only |

## Additional Info

Learn more about Hooks on the [Hook API](hook.md) page.

## Examples

Example using:

### `bindingPressedEvent`

### `bindingReleasedEvent`

### `maxWalkSpeed`

### `maxSwimSpeed`

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

See also: [Game.playerJoinedEvent](game.md) | [Event.Connect](event.md)

---

Example using:

### `damagedEvent`

### `diedEvent`

### `respawnedEvent`

### `ApplyDamage`

### `Die`

### `Respawn`

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

See also: [Player.name](player.md) | [Damage.New](damage.md) | [Task.Wait](task.md) | [CoreLua.print](coreluafunctions.md) | [Vector3.New](vector3.md) | [Rotation.New](rotation.md) | [Event.Connect](event.md)

---

Example using:

### `movementModeChangedEvent`

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

See also: [Player.GetWorldPosition](player.md) | [Damage.New](damage.md) | [Game.playerJoinedEvent](game.md) | [Vector3.z](vector3.md) | [Event.Connect](event.md) | [CoreLua.print](coreluafunctions.md)

---

Example using:

### `resourceChangedEvent`

### `ClearResources`

### `GetResource`

### `GetResources`

### `SetResource`

### `AddResource`

### `RemoveResource`

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

See also: [CoreLua.print](coreluafunctions.md) | [Event.Connect](event.md)

---

Example using:

### `ActivateFlying`

### `ActivateWalking`

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

See also: [Player.bindingPressedEvent](player.md) | [Game.playerJoinedEvent](game.md) | [Event.Connect](event.md)

---

Example using:

### `AddImpulse`

### `GetVelocity`

### `SetVelocity`

### `ResetVelocity`

### `mass`

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

See also: [Player.SetWorldPosition](player.md) | [Task.Wait](task.md) | [Vector3.ZERO](vector3.md)

---

Example using:

### `DisableRagdoll`

### `EnableRagdoll`

### `animationStance`

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

See also: [Game.playerJoinedEvent](game.md) | [Task.Wait](task.md)

---

Example using:

### `GetAbilities`

### `GetEquipment`

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

See also: [Player.GetAttachedObjects](player.md) | [CoreObject.GetCustomProperty](coreobject.md) | [World.SpawnAsset](world.md) | [Equipment.Equip](equipment.md) | [Ability.name](ability.md) | [CoreLua.print](coreluafunctions.md)

---

Example using:

### `GetActiveCamera`

### `GetDefaultCamera`

### `SetDefaultCamera`

### `GetOverrideCamera`

### `SetOverrideCamera`

### `ClearOverrideCamera`

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

See also: [CoreObject.GetCustomProperty](coreobject.md) | [Game.GetLocalPlayer](game.md) | [World.SpawnAsset](world.md) | [Vector3.New](vector3.md) | [Task.Wait](task.md) | [CoreLua.print](coreluafunctions.md)

---

Example using:

### `GetViewWorldPosition`

### `GetViewWorldRotation`

### `GetLookWorldRotation`

### `SetLookWorldRotation`

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

See also: [Game.GetLocalPlayer](game.md) | [CoreLua.print](coreluafunctions.md) | [Rotation.New](rotation.md)

---

Example using:

### `GetWorldTransform`

### `SetWorldTransform`

### `GetWorldPosition`

### `SetWorldPosition`

### `GetWorldRotation`

### `SetWorldRotation`

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

See also: [Rotation.New](rotation.md) | [Vector3.UP](vector3.md)

---

Example using:

### `SetVisibility`

### `GetVisibility`

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

See also: [Player.bindingPressedEvent](player.md) | [Game.playerJoinedEvent](game.md) | [Event.Connect](event.md)

---

Example using:

### `SetWorldScale`

### `GetWorldScale`

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

See also: [Task.Spawn](task.md) | [Game.GetPlayers](game.md) | [Vector3.New](vector3.md)

---

Example using:

### `TransferToGame`

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

See also: [CoreObject.parent](coreobject.md) | [Object.IsA](object.md) | [Trigger.beginOverlapEvent](trigger.md) | [Event.Connect](event.md)

---

Example using:

### `currentFacingMode`

### `desiredFacingMode`

There are several modes the game can use to decide which direction the player's avatar is facing, based on the camera look direction.

```lua

-- This will make the player turn to face whatever direction they are moving.
player.desiredFacingMode = FacingMode.FACE_MOVEMENT

-- This will make the player turn to face whatever direction they are aiming.
player.desiredFacingMode = FacingMode.FACE_AIM_ALWAYS

-- This will make the player turn to face whatever direction they
-- are moving or shooting.
player.desiredFacingMode = FacingMode.FACE_AIM_WHEN_ACTIVE

--[[#description
Note that this is the _desired_ facing mode. The actual facing mode is not
always guaranteed to be this, as certain player states can override this.
(When the player is swimming, for example.

You can check the actual current facing mode using the `currentFacingMode`
property.]]

if (player.currentFacingMode == FacingMode.FACE_AIM_ALWAYS) then
    print("Player's facing mode is FacingMode.FACE_AIM_ALWAYS!")
end
```

See also: [Game.playerJoinedEvent](game.md) | [CoreLua.print](coreluafunctions.md)

---

Example using:

### `hitPoints`

### `maxHitPoints`

### `kills`

### `deaths`

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

See also: [Player.name](player.md) | [Game.GetPlayers](game.md) | [CoreLua.print](coreluafunctions.md)

---

Example using:

### `isAccelerating`

### `isCrouching`

### `isFlying`

### `isGrounded`

### `isJumping`

### `isMounted`

### `isSwimming`

### `isWalking`

### `isDead`

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

See also: [Game.GetPlayers](game.md) | [CoreLua.print](coreluafunctions.md) | [Task.Wait](task.md)

---

Example using:

### `isVisibleToSelf`

It's possible to hide the player's model from the player controlling it. This can be especially useful for first-person games. Note that this can only be set by scripts running in the client context!

```lua
-- The player can no longer see their own model. Other players' ability
-- to see this player is unaffected.
player.isVisibleToSelf = false
```

See also: [Game.GetLocalPlayer](game.md)

---

Example using:

### `lookSensitivity`

You can also make the player's input more or less sensitive, when aiming. This can be useful for aiming down sights, etc.

```lua
-- This will double the sensitivity:
player.lookSensitivity = 5
```

See also: [Game.GetLocalPlayer](game.md)

---

Example using:

### `maxAcceleration`

### `brakingDecelerationFalling`

### `brakingDecelerationWalking`

### `groundFriction`

### `brakingFrictionFactor`

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

See also: [Game.playerJoinedEvent](game.md)

---

Example using:

### `movementControlMode`

### `lookControlMode`

### `defaultRotationRate`

### `currentRotationRate`

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

--[[#description
    You can also change how the player's look input is processed:
]]
-- Player look input is ignored. The player cannot move their view.
player.lookControlMode = LookControlMode.NONE

-- The player controls the look direction. This is the default mode.
player.lookControlMode = LookControlMode.RELATIVE

-- The player always turns to face whatever the cursor is over, in the world.
-- This works best with a third person camera.
player.lookControlMode = LookControlMode.LOOK_AT_CURSOR
```

See also: [Game.playerJoinedEvent](game.md)

---

Example using:

### `name`

### `id`

### `team`

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

See also: [Game.GetPlayers](game.md) | [CoreLua.print](coreluafunctions.md)

---

Example using:

### `shouldDismountWhenDamaged`

### `SetMounted`

### `canMount`

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

See also: [Player.ApplyDamage](player.md) | [Damage.New](damage.md) | [Task.Wait](task.md)

---

Example using:

### `spreadModifier`

### `currentSpread`

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
    --[[#description
        You can also check the player's current (total) spread,
        although this only works from the client context.
    ]]
    print(player.currentSpread)
```

See also: [Player.movementModeChangedEvent](player.md) | [Task.Wait](task.md) | [Event.Connect](event.md) | [CoreLua.print](coreluafunctions.md)

---

Example using:

### `stepHeight`

### `walkableFloorAngle`

### `maxJumpCount`

### `jumpVelocity`

### `gravityScale`

### `buoyancy`

### `isCrouchEnabled`

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

See also: [Game.playerJoinedEvent](game.md)

---

Example using:

### `touchForceFactor`

When the player runs into physics objects, they exert force. You can affect how much force with the `touchForceFactor` property.

```lua
-- Set the player to push five times as hard!
player.touchForceFactor = 5
```

See also: [CoreObject.SetVelocity](coreobject.md) | [StaticMesh.isSimulatingDebrisPhysics](staticmesh.md)

---

Example using:

### `perkChangedEvent`

### `GetPerkCount`

Perks are a system to create in-game purchases that allow players to support game creators and enable exclusive content.

Learn more about Perks [here](https://docs.coregames.com/perks/perks/).

Repeatable Perks - This type of Perk can be purchased any number of times by players. In this example, we implement the sale of in game currency through multiple bundles and track the purchases using storage and resources. This script will track each Perk bundle to grant users the currency/resource.

```lua
local RESOURCE_KEY = "Gem" -- Example currency, can be any resource

-- Perks, of type Net Reference, assigned by dragging from the Perks Manager window
local PERK_1 = script:GetCustomProperty("Perk1")
local PERK_2 = script:GetCustomProperty("Perk2")
local PERK_3 = script:GetCustomProperty("Perk3")

-- Reward amounts per bundle, of type Integer
local PERK_1_REWARD = script:GetCustomProperty("Perk1Reward")
local PERK_2_REWARD = script:GetCustomProperty("Perk2Reward")
local PERK_3_REWARD = script:GetCustomProperty("Perk3Reward")

-- Internal bundles data with bundle storage id and custom rewards per Perk.
-- These rewards can be changed after the game goes live.
local bundles = {}
table.insert(bundles, {perk = PERK_1, storageId = "GemBundle1", reward = PERK_1_REWARD})
table.insert(bundles, {perk = PERK_2, storageId = "GemBundle2", reward = PERK_2_REWARD})
table.insert(bundles, {perk = PERK_3, storageId = "GemBundle3", reward = PERK_3_REWARD})

-- Check if each storage bundle purchase count is different from Perk purchase count.
-- If yes, then grant currency as reward to the player.
function CheckPerkCountWithStorage(player)
    local data = Storage.GetPlayerData(player)

    for _, bundle in ipairs(bundles) do
        local perkCount = player:GetPerkCount(bundle.perk)
        local storageCount = data[RESOURCE_KEY][bundle.storageId]

        if perkCount ~= storageCount then
            data[RESOURCE_KEY][bundle.storageId] = perkCount
            Storage.SetPlayerData(player, data)

            if perkCount > storageCount then
                local resourceAmount = bundle.reward * (perkCount - storageCount)
                player:AddResource(RESOURCE_KEY, resourceAmount)
            end
        end
    end
end

-- Check and see if storage purchase value is different from Perk purchase count
function UpdateStorageBalance(player)
    local data = Storage.GetPlayerData(player)
    data[RESOURCE_KEY].amount = player:GetResource(RESOURCE_KEY)
    Storage.SetPlayerData(player, data)
end

-- If player spend and earns the currency resource, update the storage
function OnResourceChanged(player, resource)
    if resource == RESOURCE_KEY then
        UpdateStorageBalance(player)
    end
end

-- If player's doing in game transactions, check and update
-- the balance for current currency with storage bundle tracking
function OnPerksChanged(player)
    CheckPerkCountWithStorage(player)
    UpdateStorageBalance(player)
end

-- Sets player resource from storage and connects player events
function OnPlayerJoined(player)
    local data = Storage.GetPlayerData(player)

    -- Setup player resource and save it in a table
    if not data[RESOURCE_KEY] or not data[RESOURCE_KEY].amount then
        data[RESOURCE_KEY] = {}
        data[RESOURCE_KEY].amount = 0
    end

    -- Setup current Perk purchased count per bundle
    for _, bundle in ipairs(bundles) do
        if not data[RESOURCE_KEY][bundle.storageId] or Environment.IsLocalGame() then
            data[RESOURCE_KEY][bundle.storageId] = player:GetPerkCount(bundle.perk)
        end
    end

    Storage.SetPlayerData(player, data)

    -- Set currency resource for displaying balance to player on client side
    player:SetResource(RESOURCE_KEY, data[RESOURCE_KEY].amount)

    -- Connect events that updates currency balance for player
    player.resourceChangedEvent:Connect(OnResourceChanged)
    player.perkChangedEvent:Connect(OnPerksChanged)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

See also: [Storage.GetPlayerData](storage.md) | [Player.GetResource](player.md) | [Game.playerJoinedEvent](game.md) | [CoreObject.GetCustomProperty](coreobject.md) | [Event.Connect](event.md)

---

Example using:

### `perkChangedEvent`

### `HasPerk`

### `GetPerkCount`

### `GetPerkReference`

### `SetPerkReference`

Perks are a system to create in-game purchases that allow players to support game creators and enable exclusive content.

Learn more about Perks [here](https://docs.coregames.com/perks/perks/).

In the following example, a script is a child of a Perk Purchase Button, of type `UIPerkPurchaseButton`. The user interface container that has the button is in a client context. The specifics of the Perk come in through the custom property `MyPerk`, which is then assigned to the button with `SetPerkReference()`. When the player joins we connect to the `perkChangedEvent` and print out their existing perks with the LogPerks() function.

```lua
-- Perk Net Reference custom parameters
local MY_PERK = script:GetCustomProperty("MyPerk")
local TEST_LIMITED_TIME = script:GetCustomProperty("TestLimitedTime")
local TEST_PERMANENT = script:GetCustomProperty("TestPermanent")
local TEST_REPEATABLE = script:GetCustomProperty("TestRepeatable")

-- Mapping of PerkNetRefs to table of properties, in this case a name
local perkList = {}
perkList[TEST_LIMITED_TIME] = { name = "limited-time" }
perkList[TEST_PERMANENT] = { name = "permanent" }
perkList[TEST_REPEATABLE] = { name = "repeatable" }

-- Set purchase button's Perk to given custom property
script.parent:SetPerkReference(MY_PERK)

function DebugLog(msg)
    print(msg)
    UI.PrintToScreen(msg)
end

function OnPerkChanged(player, perkRef)
    DebugLog("on perks changed " .. player.name)

    if (perkList[perkRef] ~= nil) then
        DebugLog("perk changed: " .. perkList[perkRef].name)
    end

    LogPerks(player)
end

function LogPerks(player)
    -- Example of HasPerk() and GetPerkCount().
    -- For non-repeatable perks checking GetPerkCount() > 0
    -- is equivalent to HasPerk() == true
    for perkRef, prop in pairs(perkList) do
        DebugLog("-- perk: " .. prop.name)

        local hasPerkMsg = "    has perk?: " .. tostring(player:HasPerk(perkRef))
        local perkCountMsg = "    count: " .. tostring(player:GetPerkCount(perkRef))

        DebugLog(hasPerkMsg)
        DebugLog(perkCountMsg)

        -- Example of getting Perk reference of parent Perk button
        local parentPerkRef = script.parent:GetPerkReference()
        if (parentPerkRef.isAssigned and perkRef == parentPerkRef) then
            DebugLog("is parent perk ref")
        end
    end
end

function OnPlayerJoined(player)
    -- Connect perkChangedEvent
    player.perkChangedEvent:Connect(OnPerkChanged)

    -- Log perks player has initially on join
    LogPerks(player)
end

Game.playerJoinedEvent:Connect(OnPlayerJoined)
```

See also: [NetReference.isAssigned](netreference.md) | [Game.playerJoinedEvent](game.md) | [CoreObject.GetCustomProperty](coreobject.md) | [Player.name](player.md) | [CoreLua.print](coreluafunctions.md) | [UI.PrintToScreen](ui.md) | [Event.Connect](event.md)

---
