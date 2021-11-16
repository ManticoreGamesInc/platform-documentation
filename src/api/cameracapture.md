---
id: cameracapture
name: CameraCapture
title: CameraCapture
tags:
    - API
---

# CameraCapture

CameraCapture represents an image rendered by a `Camera` to be used elsewhere in the game, for example in UI. Captures can be created using a fixed set of resolutions, and a finite number of captures are allowed at a time for each resolution. Creators may wish to explicitly release existing capture instances when they are no longer needed, so that they can create more elsewhere. A released capture is no longer valid, and should not be used thereafter.

Currently, creators are limited to the following:

* Up to 256 `VERY_SMALL` captures.
* In addition to Up to 64 `SMALL` capture.
* In addition to Up to 16 `MEDIUM` captures.
* In addition to Up to 4 `LARGE` captures.
* In addition to Up to 1 `VERY_LARGE` capture.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `resolution` | [`CameraCaptureResolution`](enums.md#cameracaptureresolution) | The resolution of this capture. | Read-Only |
| `camera` | [`Camera`](camera.md) | The Camera to capture from. | Read-Write |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `IsValid()` | `boolean` | Returns `true` if this capture instance has valid resources. | None |
| `Refresh()` | `None` | Recaptures the render using the current camera. | None |
| `Release()` | `None` | Releases the texture resources associated with this capture instance. This instance will become invalid and should no longer be used. | None |

## Examples

Example using:

### `Refresh`

This example uses the Camera's `Capture()` and `Refresh()` to implement a rear-view mirror that appears when the player is using a vehicle. For the UI image to look correct, it should have equal width and height, as well as `Flip Horizontal` enabled.

```lua
local CAMERA = script:GetCustomProperty("Camera"):WaitForObject()
local UI_ROOT = script:GetCustomProperty("Root"):WaitForObject()
local IMAGE = script:GetCustomProperty("UIImage"):WaitForObject()
local PLAYER = Game.GetLocalPlayer()

local OFFSET_UP = 150
local OFFSET_BACK = -310

local camCapture = nil

function Capture()
    if camCapture and camCapture:IsValid() then
        camCapture:Refresh()
    else
        camCapture = CAMERA:Capture(CameraCaptureResolution.MEDIUM)
        IMAGE:SetCameraCapture(camCapture)
    end
end

function Tick()
    if Object.IsValid(PLAYER.occupiedVehicle) then
        -- Rotate the camera so it's looking back
        local rot = PLAYER.occupiedVehicle:GetWorldRotation()
        local q = Quaternion.New(rot)
        local upVector = q:GetUpVector()
        local forwardVector = q:GetForwardVector()
        rot = Rotation.New(-forwardVector, upVector)
        CAMERA:SetWorldRotation(rot)
        -- Position the camera relative to the vehicle
        local pos = PLAYER.occupiedVehicle:GetWorldPosition()
        pos = pos + upVector * OFFSET_UP + forwardVector * OFFSET_BACK
        CAMERA:SetWorldPosition(pos)
        -- Update the image
        Capture()
        -- Player is in a vehicle, enable visibility of the mirror
        UI_ROOT.visibility = Visibility.INHERIT
    else
        -- Hide the rear-view mirror, as the player is not in a vehicle
        UI_ROOT.visibility = Visibility.FORCE_OFF
    end
end
```

See also: [Camera.Capture](camera.md) | [UIImage.SetCameraCapture](uiimage.md) | [Game.GetLocalPlayer](game.md) | [Player.occupiedVehicle](player.md) | [Quaternion.GetForwardVector](quaternion.md) | [CoreObject.visibility](coreobject.md)

---

Example using:

### `camera`

### `resolution`

### `IsValid`

### `Refresh`

### `Release`

This client script demonstrates how several in-game cameras can be displayed onto the 2D UI, one at a time, perhaps in a game with some kind of surveillance system. When a camera is selected to be displayed call the `Capture()` function, passing the camera as parameter.

```lua
local UI_IMAGE = script:GetCustomProperty("UIImage"):WaitForObject()

local camCapture = nil

function Capture(selectedCamera)    
    if selectedCamera then
        if not camCapture or not camCapture:IsValid() then
            camCapture = selectedCamera:Capture(CameraCaptureResolution.VERY_LARGE)
            UI_IMAGE:SetCameraCapture(camCapture)
        else
            camCapture.camera = selectedCamera
            camCapture:Refresh()
        end
    end
end

script.destroyEvent:Connect(function()
    if camCapture and camCapture:IsValid() then
        print("Release from memory a camera capture with resolution: " .. camCapture.resolution)
        camCapture:Release()
        camCapture = nil
    end
end)
```

See also: [Camera.Capture](camera.md) | [UIImage.SetCameraCapture](uiimage.md) | [CoreObject.GetCustomProperty](coreobject.md) | [CoreObjectReference.WaitForObject](coreobjectreference.md)

---
