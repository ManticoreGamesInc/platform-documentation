---
id: uiimage
name: UIImage
title: UIImage
tags:
    - API
---

# API: UIImage

## Description

A UIControl for displaying an image.

## API

### Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `isTeamColorUsed` | `bool` | If `true`, the image will be tinted blue if its team matches the Player, or red if not. | Read-Write |
| `team` | `Integer` | the team of the image, used for `isTeamColorUsed`. | Read-Write |

### Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetColor()` | `Color` | Returns the current color of the UIImage. | None |
| `SetColor(Color)` | `None` | Sets the UIImage to a color. | None |
| `GetImage()` | `string` | Returns the imageId assigned to this UIImage control. | None |
| `SetImage(MUID imageId)` | `None` | Sets the UIImage to a new MUID. You can get this MUID from an Asset Reference. | None |
| `SetImage(Player)` | `None` | Downloads and sets a Player's profile picture as the texture for this UIImage control. | None |

## Tutorials

[UI in Core](../tutorials/ui_reference.md)
