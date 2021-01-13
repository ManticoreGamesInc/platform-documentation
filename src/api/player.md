# Player

## Description

Player is an object representation of the state of a player connected to the game, as well as their avatar in the world.

## API

### Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `name` | `string` | The Player's name. | Read-Write |
| `id` | `string` | The unique id of the Player. Consistent across sessions. | Read-Only |
| `team` | `Integer` | The number of the team to which the Player is assigned. By default, this value is 255 in FFA mode. | Read-Write |
| `animationStance` | `string` | Which set of animations to use for this Player. See [Animation Stance Strings](../api/animations.md#animation-stance-strings) for possible values. | Read-Write |
| `currentFacingMode` | `FacingMode` | Current mode applied to player, including possible overrides. Possible values are FacingMode.FACE_AIM_WHEN_ACTIVE, FacingMode.FACE_AIM_ALWAYS, and FacingMode.FACE_MOVEMENT. See desiredFacingMode for details. | Read-Only |
| `desiredFacingMode` | `FacingMode` | (server only) -- Which controls mode to use for this Player. May be overridden by certain movement modes like MovementMode.SWIMMING or when mounted. Possible values are FacingMode.FACE_AIM_WHEN_ACTIVE, FacingMode.FACE_AIM_ALWAYS, and FacingMode.FACE_MOVEMENT. | Read-Write |
| `defaultRotationRate` | `Number` | (server only) -- Determines how quickly the Player turns to match the camera's look. Set to -1 for immediate rotation. Currently only supports rotation around the Z-axis. | Read-Write |
| `currentRotationRate` | `Number` | Reports the real rotation rate that results from any active mechanics/movement overrides. | Read-Only |
| `hitPoints` | `Number` | Current amount of hitpoints. | Read-Write |
| `maxHitPoints` | `Number` | Maximum amount of hitpoints. | Read-Write |
| `kills` | `Integer` | The number of times the player has killed another player. | Read-Write |
| `deaths` | `Integer` | The number of times the player has died. | Read-Write |
| `stepHeight` | `Number` | Maximum height in centimeters the Player can step up. Range is 0-100. Default = 45. | Read-Write |
| `maxWalkSpeed` | `Number` | Maximum speed while the player is on the ground. Clients can only read. Default = 640. | Read-Write |
| `maxAcceleration` | `Number` | Max Acceleration (rate of change of velocity). Clients can only read. Default = 1800. | Read-Write |
| `brakingDecelerationFalling` | `Number` | Deceleration when falling and not applying acceleration. Default = 0. | Read-Write |
| `brakingDecelerationWalking` | `Number` | Deceleration when walking and movement input has stopped. Default = 1000. | Read-Write |
| `groundFriction` | `Number` | Friction when walking on ground. Default = 8.0 | Read-Write |
| `brakingFrictionFactor` | `Number` | Multiplier for friction when braking. Default = 0.6. | Read-Write |
| `walkableFloorAngle` | `Number` | Max walkable floor angle, in degrees. Clients can only read. Default = 44. | Read-Write |
| `maxJumpCount` | `Integer` | Max number of jumps, to enable multiple jumps. Set to 0 to disable jumping. | Read-Write |
| `jumpVelocity` | `Number` | Vertical speed applied to Player when they jump. Default = 900. | Read-Write |
| `gravityScale` | `Number` | Multiplier on gravity applied. Default = 1.9. | Read-Write |
| `maxSwimSpeed` | `Number` | Maximum speed while the player is swimming. Default = 420. | Read-Write |
| `touchForceFactor` | `Number` | Force applied to physics objects when contacted with a Player. Default = 1. | Read-Write |
| `isCrouchEnabled` | `bool` | Turns crouching on/off for a Player. | Read-Write |
| `mass` | `Number` | Gets the mass of the Player. | Read-Only |
| `isAccelerating` | `bool` | True if the Player is accelerating, such as from input to move. | Read-Only |
| `isCrouching` | `bool` | True if the Player is crouching. | Read-Only |
| `isFlying` | `bool` | True if the Player is flying. | Read-Only |
| `isGrounded` | `bool` | True if the Player is on the ground with no upward velocity, otherwise false. | Read-Only |
| `isJumping` | `bool` | True if the Player is jumping. | Read-Only |
| `isMounted` | `bool` | True if the Player is mounted on another object. | Read-Only |
| `isSwimming` | `bool` | True if the Player is swimming in water. | Read-Only |
| `isWalking` | `bool` | True if the Player is in walking mode. | Read-Only |
| `isDead` | `bool` | True if the Player is dead, otherwise false. | Read-Only |
| `movementControlMode` | `MovementControlMode` | Specify how players control their movement. Clients can only read. Default: MovementControlMode.LOOK_RELATIVE. MovementControlMode.NONE: Movement input is ignored. MovementControlMode.LOOK_RELATIVE: Forward movement follows the current player's look direction. MovementControlMode.VIEW_RELATIVE: Forward movement follows the current view's look direction. MovementControlMode.FACING_RELATIVE: Forward movement follows the current player's facing direction. MovementControlMode.FIXED_AXES: Movement axis are fixed. | Read-Write |
| `lookControlMode` | `LookControlMode` | Specify how players control their look direction. Default: LookControlMode.RELATIVE. LookControlMode.NONE: Look input is ignored. LookControlMode.RELATIVE: Look input controls the current look direction. LookControlMode.LOOK_AT_CURSOR: Look input is ignored. The player's look direction is determined by drawing a line from the player to the cursor on the Cursor Plane. | Read-Write |
| `lookSensitivity` | `Number` | (client only) -- Multiplier on the Player look rotation speed relative to cursor movement. This is independent from user's preferences, both will be applied as multipliers together. Default = 1.0. | Read-Write |
| `spreadModifier` | `Number` | Modifier added to the Player's targeting spread. | Read-Write |
| `currentSpread` | `Number` | (client only) -- Gets the Player's current targeting spread. | Read-Only |
| `buoyancy` | `Number` | In water, buoyancy 1.0 is neutral (won't sink or float naturally). Less than 1 to sink, greater than 1 to float. | Read-Write |
| `canMount` | `bool` | (server only) -- Returns whether the Player can manually toggle on/off the mount. | Read-Write |
| `shouldDismountWhenDamaged` | `bool` | (server only) -- If `true`, and the Player is mounted they will dismount if they take damage. | Read-Write |
| `isVisibleToSelf` | `bool` | (client only) -- Set whether to hide the Player model on Player's own client, for sniper scope, etc. | Read-Write |

### Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetWorldTransform()` | `Transform` | The absolute Transform of this player. | None |
| `SetWorldTransform(Transform)` | `None` | The absolute Transform of this player. | Server-Only |
| `GetWorldPosition()` | `Vector3` | The absolute position of this player. | None |
| `SetWorldPosition(Vector3)` | `None` | The absolute position of this player. | Server-Only |
| `GetWorldRotation()` | `Rotation` | The absolute rotation of this player. | None |
| `SetWorldRotation(Rotation)` | `None` | The absolute rotation of this player. | Server-Only |
| `GetWorldScale()` | `Vector3` | The absolute scale of this player. | None |
| `SetWorldScale(Vector3)` | `None` | The absolute scale of this player (must be uniform). | Server-Only |
| `AddImpulse(Vector3)` | `None` | Adds an impulse force to the Player. | Server-Only |
| `GetVelocity()` | `Vector3` | Gets the current velocity of the Player. | None |
| `SetVelocity(Vector3)` | `None` | Sets the Player's velocity to the given amount. | Server-Only |
| `ResetVelocity()` | `None` | Resets the Player's velocity to zero. | Server-Only |
| `GetAbilities()` | `Array<Ability>` | Array of all Abilities assigned to this Player. | None |
| `GetEquipment()` | `Array<Equipment>` | Array of all Equipment assigned to this Player. | None |
| `ApplyDamage(Damage)` | `None` | Damages a Player. If their hit points go below 0 they die. | Server-Only |
| `Die([Damage])` | `None` | Kills the Player. They will ragdoll and ignore further Damage. The optional Damage parameter is a way to communicate cause of death. | Server-Only |
| `DisableRagdoll()` | `None` | Disables all ragdolls that have been set on the Player. | Server-Only |
| `SetVisibility(bool, [bool])` | `None` | Shows or hides the Player. The second parameter is optional, defaults to true, and determines if attachments to the Player are hidden as well as the Player. | Server-Only |
| `GetVisibility()` | `bool` | Returns whether or not the Player is hidden. | None |
| `EnableRagdoll([string socketName, Number weight])` | `None` | Enables ragdoll for the Player, starting on `socketName` weighted by `weight` (between 0.0 and 1.0). This can cause the Player capsule to detach from the mesh. All parameters are optional; `socketName` defaults to the root and `weight` defaults to 1.0. Multiple bones can have ragdoll enabled simultaneously. See [Socket Names](../api/animations.md#socket-names) for the list of possible values. | Server-Only |
| `Respawn([table parameters])` | `None` | Resurrects a dead Player based on respawn settings in the game (default in-place). An optional table may be provided to override the following parameters:<br>`position (Vector3)`: Respawn at this position. Defaults to the position of the spawn point selected based on the game's respawn settings, or the player's current position if no spawn point was selected.<br>`rotation (Rotation)`: Sets the player's rotation after respawning. Defaults to the rotation of the selected spawn point, or the player's current rotation if no spawn point was selected.<br>`scale (Vector3)`: Sets the player's scale after respawning. Defaults to the Player Scale Multiplier of the selected spawn point, or the player's current scale if no spawn point was selected. Player scale must be uniform. (All three components must be equal.) | Server-Only |
| `Respawn(Vector, Rotation)` | `None` | Resurrects a dead Player at a specific location and rotation. This form of `Player:Respawn()` may be removed at some point in the future. It is recommended to use the optional parameter table if position and rotation need to be specified.  For example: `player:Respawn({position = newPosition, rotation = newRotation})` | Server-Only, **Deprecated** |
| `GetViewWorldPosition()` | `Vector3` | Get position of the Player's camera view. | None |
| `GetViewWorldRotation()` | `Rotation` | Get rotation of the Player's camera view. | None |
| `GetLookWorldRotation()` | `Rotation` | Get the rotation for the direction the Player is facing. | None |
| `SetLookWorldRotation(Rotation)` | `None` | Set the rotation for the direction the Player is facing. | Client-Only |
| `ClearResources()` | `None` | Removes all resources from a player. | Server-Only |
| `GetResources()` | `Table<string, Integer>` | Returns a table containing the names and amounts of the player's resources. | None |
| `GetResource(string name)` | `Integer` | Returns the amount of a resource owned by a player. Returns 0 by default. | None |
| `SetResource(string name, Integer amount)` | `None` | Sets a specific amount of a resource on a player. | Server-Only |
| `AddResource(string name, Integer amount)` | `None` | Adds an amount of a resource to a player. | Server-Only |
| `RemoveResource(string name, Integer amount)` | `None` | Subtracts an amount of a resource from a player. Does not go below 0. | Server-Only |
| `TransferToGame(string)` | `None` | Does not work in preview mode or in games played locally. Transfers player to the game specified by the passed-in game ID. Example: The game ID for the URL `https://www.coregames.com/games/577d80/core-royale` is `577d80/core-royale`. | Server-Only |
| `GetAttachedObjects()` | `Array<CoreObject>` | Returns a table containing CoreObjects attached to this player. | None |
| `SetMounted(bool)` | `None` | Forces a player in or out of mounted state. | Server-Only |
| `GetActiveCamera()` | `Camera` | Returns whichever camera is currently active for the Player. | Client-Only |
| `GetDefaultCamera()` | `Camera` | Returns the default Camera object the Player is currently using. | Client-Only |
| `SetDefaultCamera(Camera, [Number lerpTime = 0.0])` | `None` | Sets the default Camera object for the Player. | Client-Only |
| `GetOverrideCamera()` | `Camera` | Returns the override Camera object the Player is currently using. | Client-Only |
| `SetOverrideCamera(Camera, [Number lerpTime = 0.0])` | `None` | Sets the override Camera object for the Player. | Client-Only |
| `ClearOverrideCamera([Number lerpTime = 0.0])` | `None` | Clears the override Camera object for the Player (to revert back to the default camera). | Client-Only |
| `ActivateFlying()` | `None` | Activates the Player flying mode. | Server-Only |
| `ActivateWalking()` | `None` | Activate the Player walking mode. | Server-Only |
| `IsBindingPressed(string bindingName)` | `bool` | Returns `true` if the player is currently pressing the named binding. Possible values of the bindings are listed on the [Ability binding](../api/key_bindings.md) page. Note that when called on a client, this function will only work for the local player. | None |
| `HasPerk(NetReference)` | `bool` | Returns `true` if the player has one or more of the specified perk. | None |
| `GetPerkCount(NetReference)` | `Integer` | Returns how many of the specified perk the player owns. For non-repeatable perks, returns `1` if the player owns the perk, or `0` if the player does not. | None |

### Events

| Event Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `damagedEvent` | `Event<Player, Damage>` | Fired when the Player takes damage. | Server-Only |
| `diedEvent` | `Event<Player, Damage>` | Fired when the Player dies. | Server-Only |
| `respawnedEvent` | `Event<Player>` | Fired when the Player respawns. | Server-Only |
| `bindingPressedEvent` | `Event<Player, string>` | Fired when an action binding is pressed. Second parameter tells you which binding. Possible values of the bindings are listed on the [Ability binding](../api/key_bindings.md) page. | None |
| `bindingReleasedEvent` | `Event<Player, string>` | Fired when an action binding is released. Second parameter tells you which binding. | None |
| `resourceChangedEvent` | `Event<Player, string, Integer>` | Fired when a resource changed, indicating the type of the resource and its new amount. | None |
| `perkChangedEvent` | `Event<Player, NetReference perkReference>` | Fired when a player's list of owned perks has changed, indicating which perk's amount has changed. Do not expect this event to fire for perks that a player already has when they join a game. Use the `HasPerk(NetReference)` or `GetPerkCount(NetReference)` function for any initial logic that needs to be handled when joining. Also, this event may not actively fire when a perk expires, but it may fire for an expired perk as a result of purchasing a different perk. | None |
| `movementModeChangedEvent` | `Event<Player, MovementMode, MovementMode>` | Fired when a Player's movement mode changes. The first parameter is the Player being changed. The second parameter is the "new" movement mode. The third parameter is the "previous" movement mode. Possible values for MovementMode are: MovementMode.NONE, MovementMode.WALKING, MovementMode.FALLING, MovementMode.SWIMMING, MovementMode.FLYING. | None |

## Examples

### Player.bindingPressedEvent

### Player.bindingReleasedEvent

### Player.maxWalkSpeed

### Player.maxSwimSpeed

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
    local l = -- UT_STRIP
    player.bindingPressedEvent:Connect(OnBindingPressed)
    listeners[l] = true -- UT_STRIP
    l = -- UT_STRIP
    player.bindingReleasedEvent:Connect(OnBindingReleased)
    listeners[l] = true -- UT_STRIP
end

local l = -- UT_STRIP
Game.playerJoinedEvent:Connect(OnPlayerJoined)
listeners[l] = true -- UT_STRIP
OnPlayerJoined(player) --UT_STRIP
```

### Player.damagedEvent

### Player.diedEvent

### Player.respawnedEvent

### Player.ApplyDamage

### Player.Die

### Player.Respawn

There are events that fire at most major points for a player during gameplay. This example shows how to receive an event for players being damaged, dying, and respawning, as well as how to make a player automatically respawn after dying.

One important thing to note - `player.damagedEvent` and `player.diedEvent` only execute on the server, so if you are writing a script that runs inside of a client context, it will not receive these events!

```lua
function OnPlayerDamage(player, damage)
    print("Player " .. player.name .. " just took " .. damage.amount .. " damage!")
    damageCount = damageCount + 1    -- UT_STRIP
    damageTotal = damageTotal + damage.amount -- UT_STRIP
end

function OnPlayerDied(player, damage)
    print("Player " .. player.name .. " has been killed!")

    -- Now, revive them after 2 seconds at a spawn point:
    Task.Wait(2)
    player:Respawn(Vector3.New(0, 0, 500), Rotation.New(0, 0, 45))
    ut.EXPECT_VEC_EQUAL(player:GetWorldPosition(), Vector3.New(0, 0, 500))
    ut.EXPECT_ROT_EQUAL(player:GetWorldRotation(), Rotation.New(0, 0, 45))
    deathTotal = deathTotal + 1 -- UT_STRIP
end

function OnPlayerRespawn(player)
    print("Player " .. player.name .. " is back!")
    respawnTotal = respawnTotal + 1 -- UT_STRIP
end

-- Set up listeners:
for _, p in pairs(Game.GetPlayers()) do
    damageListener  =    -- UT_STRIP
    p.damagedEvent:Connect(OnPlayerDamage)
    deathListener   =    -- UT_STRIP
    p.diedEvent:Connect(OnPlayerDied)
    respawnListener =    -- UT_STRIP
    p.respawnedEvent:Connect(OnPlayerRespawn)
    break -- UT_STRIP
end
player:ApplyDamage(Damage.New(25))
Task.Wait(1)
player:ApplyDamage(Damage.New(50))
Task.Wait(1)
ut.EXPECT_EQUAL(damageTotal, 75, "Damage check 1")
ut.EXPECT_EQUAL(deathTotal, 0, "death check 1")
-- This will kill the player, because they only have 100 health by default.
player:ApplyDamage(Damage.New(100))
ut.EXPECT_TRUE(player.isDead)
ut.EXPECT_EQUAL(respawnTotal, 0, "Respawn check 1")
Task.Wait(2.1)
ut.EXPECT_FALSE(player.isDead)
ut.EXPECT_EQUAL(deathTotal, 1, "deathCheck 2")
ut.EXPECT_EQUAL(damageTotal, 175, "Damage check 1")
ut.EXPECT_EQUAL(respawnTotal, 1, "Respawn check 2")
Task.Wait(2.1)
-- We can also kill the player directly, regardless of health
player:Die()
ut.EXPECT_TRUE(player.isDead)
```

### Player.movementModeChangedEvent

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
    local l = -- UT_STRIP
    player.movementModeChangedEvent:Connect(OnMovementModeChanged)
    listeners[l] = true -- UT_STRIP
end
OnPlayerJoined(player) -- UT_STRIP
local l = -- UT_STRIP
Game.playerJoinedEvent:Connect(OnPlayerJoined)
listeners[l] = true -- UT_STRIP

ut.EXPECT_EQUAL(player.hitPoints, 100, "starts at full hp")
-- Now we fling the player into the air for testing.
-- When they land they should take ~40 damage.
print("in the air")
player:SetWorldPosition(Vector3.New(0, 0, 1000))
Task.Wait(5)  -- UT_STRIP
print("done waiting")
ut.EXPECT_NEARLY_EQUAL(player.hitPoints, 60.227, "no longer at full hp", 15)
```

### Player.resourceChangedEvent

### Player.ClearResources

### Player.GetResource

### Player.GetResources

### Player.SetResource

### Player.AddResource

### Player.RemoveResource

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

local eventListener = --UT_STRIP
player.resourceChangedEvent:Connect(OnResourceChanged)

player:SetResource(resource1, 5)
ut.EXPECT_EQUAL(player:GetResource(resource1), 5, "resource check 1")
-- Player now has 5 "CoinsCollected"

player:AddResource(resource1, 15)
ut.EXPECT_EQUAL(player:GetResource(resource1), 20, "resource check 2")
-- Player now has 20 "CoinsCollected".

player:AddResource(resource1, 500)
ut.EXPECT_EQUAL(player:GetResource(resource1), 100, "resource check 3")
-- This should give us 520 "CoinsCollected", but our event listener limits it to 100.
print("Coins collected: " .. player:GetResource(resource1))

player:SetResource(resource2, 2)
ut.EXPECT_EQUAL(player:GetResource(resource2), 2, "resource check 4")
-- Player now has 2 "PuppiesSeen", as well as still having 100 "CoinsCollected"

player:RemoveResource(resource1, 10)
ut.EXPECT_EQUAL(player:GetResource(resource1), 90, "resource check 3")
-- Player now has 90 "CoinsCollected"

-- We can also get all the resources in one go as a table:
local total = 0 -- UT_STRIP
local resourceTable = player:GetResources()
for k, v in pairs(resourceTable) do
    print("Resource ["..k.."]: " .. v)
    total = total + 1 -- UT_STRIP
end
ut.EXPECT_EQUAL(total, 2, "there should be 2 resources in the table.")

player:ClearResources()
-- All resources have been removed from the player
print("Coins collected: " .. player:GetResource(resource1))
print("Puppies seen: " .. player:GetResource(resource2))
ut.EXPECT_EQUAL(player:GetResource(resource1), 0, "resource check 5")
ut.EXPECT_EQUAL(player:GetResource(resource2), 0, "resource check 6")
```

### Player.ActivateFlying

### Player.ActivateWalking

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
    local l = -- UT_STRIP
    player.bindingPressedEvent:Connect(OnBindingPressed)
    listeners[l] = true -- UT_STRIP
    l = -- UT_STRIP
    player.bindingReleasedEvent:Connect(OnBindingReleased)
    listeners[l] = true -- UT_STRIP
end

local l = -- UT_STRIP
Game.playerJoinedEvent:Connect(OnPlayerJoined)
listeners[l] = true -- UT_STRIP
OnPlayerJoined(player) --UT_STRIP
```

### Player.AddImpulse

### Player.GetVelocity

### Player.SetVelocity

### Player.ResetVelocity

### Player.mass

If you want to fling a player using the physics system, it is possible to directly affect their velocity. You can either add a physics impulse to their current velocity, or just set the player's velocity directly. You can also zero out their velocity using `Player.ResetVelocity()`.

Note that when using impulses to apply force to a player, we need to scale it by the player's `mass` property!

```lua
-- Fling the player towards the heavens:
player:SetVelocity(Vector3.UP * 1000)
Task.Wait() -- UT_STRIP
ut.EXPECT_VEC_EQUAL(player:GetVelocity(), Vector3.UP * 969.967, "Set Velocity", 10)

player:ResetVelocity() -- UT_STRIP
player:SetWorldPosition(Vector3.ZERO) -- UT_STRIP
Task.Wait() -- UT_STRIP
player:AddImpulse(Vector3.UP * 1000 * player.mass) -- UT_STRIP

-- We can read the player's velocity in order to double it! Note that since we're adding
-- a physics impulse directly, we need to scale it by the mass of the player.
player:AddImpulse(player:GetVelocity() * player.mass)
ut.EXPECT_VEC_EQUAL(player:GetVelocity(), Vector3.UP * 2000, "Velocity doubling")

-- Fling the player some more.
player:AddImpulse(Vector3.UP * player.mass * 1000)
ut.EXPECT_VEC_EQUAL(player:GetVelocity(), Vector3.UP * 3000, "add impulse")

Task.Wait(0.5)
-- Reset their velocity to zero.
player:ResetVelocity()
ut.EXPECT_VEC_EQUAL(player:GetVelocity(), Vector3.ZERO, "Reset velocity")
```

### Player.DisableRagdoll

### Player.EnableRagdoll

### Player.animationStance

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

### Player.GetAbilities

### Player.GetEquipment

Lots of things can end up attached to a player. `CoreObject` objects, stuck to sockets. `Ability` and `Equipment` objects granting them new powers. Etc.

It's possible to query the `Player` object to find out exactly what is attached to a given player.

```lua
local propBasicAssaultRifle = script:GetCustomProperty("BasicAssaultRifle")
rifle = World.SpawnAsset(propBasicAssaultRifle)
rifle:Equip(player)

for _, obj in ipairs(player:GetAbilities()) do
    print("Ability: " .. obj.name)
end
ut.EXPECT_EQUAL(#player:GetAbilities(), 2, "Rifle has 2 abilities")
for k,v in pairs(player:GetAbilities()) do
    print(v.name)
end

for _, obj in ipairs(player:GetEquipment()) do
    print("Equipment: " .. obj.name)
end
ut.EXPECT_EQUAL(#player:GetEquipment(), 1, "Rifle is 1 equipment")

for _, obj in ipairs(player:GetAttachedObjects()) do
    print("Attached object: " .. obj.name)
end
ut.EXPECT_EQUAL(#player:GetAttachedObjects(), 1, "Rifle is 1 attached object")
```

### Player.GetActiveCamera

### Player.GetDefaultCamera

### Player.SetDefaultCamera

### Player.GetOverrideCamera

### Player.SetOverrideCamera

### Player.ClearOverrideCamera

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
ut.EXPECT_EQUAL(player:GetDefaultCamera(), defaultCamera, "default camera")
Task.Wait(2)

-- Players also have an "overide camera", which has higher priority
-- than the default camera. It's usually used for moving the camera
-- somewhere briefly, before reverting to the default camera.
local overrideCamera = World.SpawnAsset(propTestCamera,
        { position = Vector3.New(0, 1000, 1000) })
overrideCamera:LookAtContinuous(player)
player:SetOverrideCamera(overrideCamera, 1)
print(player:GetOverrideCamera():GetWorldPosition()) -- 0, 1000, 1000
ut.EXPECT_EQUAL(player:GetOverrideCamera(), overrideCamera, "override camera")
ut.EXPECT_EQUAL(player:GetActiveCamera(), overrideCamera, "get active camera1")
ut.EXPECT_NOT_EQUAL(player:GetActiveCamera(), defaultCamera, "get active camera2")
Task.Wait(2)
player:ClearOverrideCamera()
Task.Wait()
ut.EXPECT_NOT_EQUAL(player:GetActiveCamera(), overrideCamera, "get active camera3")
ut.EXPECT_EQUAL(player:GetActiveCamera(), defaultCamera, "get active camera4")
```

### Player.GetViewWorldPosition

### Player.GetViewWorldRotation

### Player.GetLookWorldRotation

### Player.SetLookWorldRotation

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

### Player.GetWorldTransform

### Player.SetWorldTransform

### Player.GetWorldPosition

### Player.SetWorldPosition

### Player.GetWorldRotation

### Player.SetWorldRotation

It is possible to read and change the position of the player. You can either change the position or rotation directly, or change the entire transformation all at once.

```lua
-- Store off the transform of the player:
player:SetWorldTransform(Transform.IDENTITY)
local originalTransform = player:GetWorldTransform()

-- Move the player 1000 units in the air:
player:SetWorldPosition(player:GetWorldPosition() + Vector3.UP * 1000)
ut.EXPECT_EQUAL(player:GetWorldPosition().z, 1000, "1000 units in the air.")

-- Look 90 degrees to the right
player:SetWorldRotation(player:GetWorldRotation() + Rotation.New(0, 0, 90))
ut.EXPECT_NEARLY_EQUAL(player:GetWorldRotation().z, 90, "90 degree rotation")

-- Return the player to their original position and rotation:
player:SetWorldTransform(originalTransform)
ut.EXPECT_VEC_EQUAL(player:GetWorldPosition(), Vector3.ZERO, "Transform part 1")
ut.EXPECT_ROT_EQUAL(player:GetWorldRotation(), Rotation.ZERO, "Transform part 2")
ut.EXPECT_VEC_EQUAL(player:GetWorldScale(), Vector3.ONE, "Transform part 3")
```

### Player.SetVisibility

### Player.GetVisibility

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
    local l = -- UT_STRIP
    player.bindingPressedEvent:Connect(OnBindingPressed)
    listeners[l] = true -- UT_STRIP
    l = -- UT_STRIP
    player.bindingReleasedEvent:Connect(OnBindingReleased)
    listeners[l] = true -- UT_STRIP
end

local l = -- UT_STRIP
Game.playerJoinedEvent:Connect(OnPlayerJoined)
listeners[l] = true -- UT_STRIP
OnPlayerJoined(player) --UT_STRIP
```

### Player.SetWorldScale

### Player.GetWorldScale

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
        if functionOver then break end -- UT_STRIP
    end
end)
```

### Player.TransferToGame

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

### Player.currentFacingMode

### Player.desiredFacingMode

There are several modes the game can use to decide which direction the player's avatar is facing, based on the camera look direction.

```lua
ut.EXPECT_EQUAL(player.desiredFacingMode, FacingMode.FACE_AIM_WHEN_ACTIVE, "facing mode default")

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

### Player.hitPoints

### Player.maxHitPoints

### Player.kills

### Player.deaths

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

### Player.isAccelerating

### Player.isCrouching

### Player.isFlying

### Player.isGrounded

### Player.isJumping

### Player.isMounted

### Player.isSwimming

### Player.isWalking

### Player.isDead

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
    break -- UT_STRIP
    Task.Wait(1)
end
```

### Player.isVisibleToSelf

It's possible to hide the player's model from the player controlling it. This can be especially useful for first-person games. Note that this can only be set by scripts running in the client context!

```lua
ut.EXPECT_TRUE(player.isVisibleToSelf, "default visibletoself")
-- The player can no longer see their own model. Other players' ability
-- to see this player is unaffected.
player.isVisibleToSelf = false
```

### Player.lookSensitivity

You can also make the player's input more or less sensitive, when aiming. This can be useful for aiming down sights, etc.

```lua
ut.EXPECT_EQUAL(player.lookSensitivity, 1, "lookSensitivity default")
-- This will double the sensitivity:
player.lookSensitivity = 5
```

### Player.maxAcceleration

### Player.brakingDecelerationFalling

### Player.brakingDecelerationWalking

### Player.groundFriction

### Player.brakingFrictionFactor

Through scripts, you can control the player's ability to accelerate their character.

```lua
-- The player accelerates more slowly.
ut.EXPECT_EQUAL(player.maxAcceleration, 1800, "maxAcceleration default")
player.maxAcceleration = 600

-- The player tends to fall straight down unless they specifically press a direction in mid-air now!
ut.EXPECT_EQUAL(player.brakingDecelerationFalling, 0, "brakingDecelerationFalling default")
player.brakingDecelerationFalling = 1800

-- The player takes longer to come to rest while walking.
ut.EXPECT_EQUAL(player.brakingDecelerationWalking, 1800, "brakingDecelerationWalking default")
player.brakingDecelerationWalking = 200

-- Also they slide more!
ut.EXPECT_EQUAL(player.groundFriction, 8, "groundFriction default")
player.groundFriction = 2

-- And more sliding - they have less grip on the ground when decelerating.
ut.EXPECT_NEARLY_EQUAL(player.brakingFrictionFactor, 0.6, "brakingFrictionFactor default")
player.brakingFrictionFactor = 0.2
```

### Player.movementControlMode

### Player.lookControlMode

### Player.defaultRotationRate

### Player.currentRotationRate

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

ut.EXPECT_EQUAL(player.defaultRotationRate, 540.0, "default rotation rate")
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

### Player.name

### Player.id

### Player.team

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

### Player.shouldDismountWhenDamaged

### Player.SetMounted

### Player.canMount

The player can mount or dismount. We can also force the player to mount or dismount via the `Player:SetMounted()` function. Also, if `Player.shouldDismountWhenDamaged` is set, they will automatically dismount whenever they take damage.

This sample demonstrates how to force the player to be mounted, and how to set them to dismount when hit.

```lua
player.shouldDismountWhenDamaged = true
Task.Wait(1) -- UT_STRIP
player:SetMounted(true)
Task.Wait(1) -- UT_STRIP
-- Player is now mounted!
ut.EXPECT_TRUE(player.isMounted, "player is mounted")

-- If they take damage, they should dismount!

player:ApplyDamage(Damage.New(1))
ut.EXPECT_FALSE(player.isMounted, "player is dismounted")
Task.Wait() -- UT_STRIP

-- We can also disable the player's ability to mount or dismount.
-- Note that this will NOT prevent us from calling SetMounted() -
-- this only affects the player's controls.
player.canMount = false
```

### Player.spreadModifier

### Player.currentSpread

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
    --[[ UT_STRIP
    print(player.currentSpread)
    UT_STRIP ]]
```

### Player.stepHeight

### Player.walkableFloorAngle

### Player.maxJumpCount

### Player.jumpVelocity

### Player.gravityScale

### Player.buoyancy

### Player.isCrouchEnabled

Most of the aspects of a player's movement can be controlled at runtime via scripting!

```lua
ut.EXPECT_EQUAL(player.stepHeight, 45, "player.stepHeight default")
-- Player can now step over 100cm ledges!
player.stepHeight = 100

-- And walk up 60-degree inclines!
ut.EXPECT_EQUAL(player.walkableFloorAngle, 44, "player.stepHeight default")
player.walkableFloorAngle = 60

-- Player can now double-jump!
ut.EXPECT_EQUAL(player.maxJumpCount, 1, "player.maxJumpCount default")
player.maxJumpCount = 2

-- And jump twice as high!
ut.EXPECT_EQUAL(player.jumpVelocity, 900, "player.jumpVelocity default")
player.jumpVelocity = 1800

-- But gravity is twice as strong!
ut.EXPECT_NEARLY_EQUAL(player.gravityScale, 1.9, "player.jumpVelocity default")
player.gravityScale = 3.8

-- But they are twice as buoyant in water!
ut.EXPECT_NEARLY_EQUAL(player.buoyancy, 1, "player.buoyancy default")
player.buoyancy = 2

-- Also the player cannot crouch.
ut.EXPECT_TRUE(player.isCrouchEnabled, "player.isCrouchEnabled default")
player.isCrouchEnabled = false
```

### Player.touchForceFactor

When the player runs into physics objects, they exert force. You can affect how much force with the `touchForceFactor` property.

```lua
ut.EXPECT_EQUAL(player.touchForceFactor, 1, "touchForceFactor default")
-- Set the player to push five times as hard!
player.touchForceFactor = 5
```
