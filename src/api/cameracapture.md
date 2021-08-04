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
