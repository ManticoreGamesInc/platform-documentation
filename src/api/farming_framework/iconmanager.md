---
id: icon manager
name: Icon Manager
title: Icon Manager
---

# Icon Manager

## Functions

| Class Function Name | Return Type | Description | Tags |
| ------------------- | ----------- | ----------- | ---- |
| `ClearIcon(UIImage)` | `boolean` | This only needs to be called in special cases where you want to clear an icon outside of the cases it would automatically be cleared. This is called automatically when an image is reused or destroyed. | None |
| `GetStatus(boolean)` | `number` | Prints the current usage into the console and returns a percent (0 - 1) to use elsewhere. | None |
| `IsCameraRegistered(string)` | `boolean` | Returns true if the camera id has been registered. | None |
| `RegisterCamera(string, Camera, table)` | `None` | Registers a camera to use to capture icon images. | None |
| `SetIcon(UIImage, string, string, CameraCaptureResolution)` | `boolean` | Makes a UIImage display a generated icon. This will generate the icon if it is not yet generated. Returns true if the icon is successfully set. | None |
