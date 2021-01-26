---
id: camera
name: Camera
title: Camera
tags:
    - API
---

# API: Camera

## Description

Camera is a CoreObject which is used both to configure Player Camera settings as well as to represent the position and rotation of the Camera in the world. Cameras can be configured in various ways, usually following a specific Player's view, but can also have a fixed orientation and/or position.

Each Player (on their client) can have a default Camera and an override Camera. If they have neither, camera behavior falls back to a basic third-person behavior. Default Cameras should be used for main gameplay while override Cameras are generally employed as a temporary view, such as a when the Player is sitting in a mounted turret.

## API

### Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `followPlayer` | `Player` | Which Player's view the camera should follow. Set to the local Player for a first or third person camera. Set to nil to detach. | Read-Write |
| `isOrthographic` | `bool` | Whether the camera uses an isometric (orthographic) view or perspective. | Read-Write |
| `fieldOfView` | `Number` | The field of view when using perspective view. Clamped between 1.0 and 170.0. | Read-Write |
| `viewWidth` | `Number` | The width of the view with an isometric view. Has a minimum value of 1.0. | Read-Write |
| `useCameraSocket` | `bool` | If you have a followPlayer, then use their camera socket. This is often preferable for first-person cameras, and gives a bit of view bob. | Read-Write |
| `currentDistance` | `Number` | (client only) -- The distance controlled by the Player with scroll wheel (by default). | Read-Write |
| `isDistanceAdjustable` | `bool` | Whether the Player can control their camera distance (with the mouse wheel by default). Creators can still access distance through currentDistance below, even if this value is false. | Read-Write |
| `minDistance` | `Number` | The minimum distance the Player can zoom in to. | Read-Write |
| `maxDistance` | `Number` | The maximum distance the Player can zoom out to. | Read-Write |
| `rotationMode` | `enum` | Which base rotation to use. Values: `RotationMode.CAMERA`, `RotationMode.NONE`, `RotationMode.LOOK_ANGLE`. | Read-Write |
| `hasFreeControl` | `bool` | Whether the Player can freely control their rotation (with mouse or thumbstick). Requires movement mode `RotationMode.CAMERA`. This has no effect if the camera is following a player. | Read-Write |
| `currentPitch` | `Number` | (client only) -- The current pitch of the Player's free control. | Read-Write |
| `minPitch` | `Number` | The minimum pitch for free control. | Read-Write |
| `maxPitch` | `Number` | The maximum pitch for free control. | Read-Write |
| `isYawLimited` | `bool` | Whether the Player's yaw has limits. If so, `maxYaw` must be at least `minYaw`, and should be outside the range `[0, 360]` if needed. | Read-Write |
| `currentYaw` | `Number` | (client only) -- The current yaw of the Player's free control. | Read-Write |
| `minYaw` | `Number` | The minimum yaw for free control. | Read-Write |
| `maxYaw` | `Number` | The maximum yaw for free control. | Read-Write |

### Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetPositionOffset()` | `Vector3` | An offset added to the camera or follow target's eye position to the Player's view. | None |
| `SetPositionOffset(Vector3)` | `None` | An offset added to the camera or follow target's eye position to the Player's view. | None |
| `GetRotationOffset()` | `Rotation` | A rotation added to the camera or follow target's eye position. | None |
| `SetRotationOffset(Rotation)` | `None` | A rotation added to the camera or follow target's eye position. | None |

## Examples

- `GetPositionOffset`

- `SetPositionOffset`

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
    if amplitude > 0 then
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

---

- `GetRotationOffset`

- `SetRotationOffset`

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
    if amplitude > 0 then
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

---

- `currentPitch`

- `currentYaw`

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

---

- `fieldOfView`

- `isOrthographic`

- `currentDistance`

- `isDistanceAdjustable`

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

---

- `followPlayer`

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

---

- `rotationMode`

- `hasFreeControl`

- `minPitch`

- `maxPitch`

- `isYawLimited`

- `minYaw`

- `maxYaw`

- `minDistance`

- `maxDistance`

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
        for index, player in ipairs(allPlayers) do
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

---

- `useCameraSocket`

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

---

- `viewWidth`

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

---
