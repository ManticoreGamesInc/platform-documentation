---
id: uiimage
name: UIImage
title: UIImage
tags:
    - API
---

# UIImage

A UIControl for displaying an image.

## Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `isTeamColorUsed` | `boolean` | If `true`, the image will be tinted blue if its team matches the Player, or red if not. | Read-Write |
| `team` | `integer` | the team of the image, used for `isTeamColorUsed`. | Read-Write |
| `shouldClipToSize` | `boolean` | Whether or not the image and its shadow should be clipped when exceeding the bounds of this control. | Read-Write |

## Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetColor()` | [`Color`](color.md) | Returns the current color of the UIImage. | None |
| `SetColor(Color)` | `None` | Sets the UIImage to a color. | None |
| `GetShadowColor()` | [`Color`](color.md) | Returns the color of the image's drop shadow. | None |
| `SetShadowColor(Color)` | `None` | Sets the color of the image's drop shadow. | None |
| `GetShadowOffset()` | [`Vector2`](vector2.md) | Returns the offset of the image's drop shadow in UI space. | None |
| `SetShadowOffset(Vector2)` | `None` | Sets the offset of the image's drop shadow in UI space. | None |
| `GetImage()` | `string` | Returns the imageId assigned to this UIImage control. | None |
| `SetImage(MUID imageId)` | `None` | Sets the UIImage to a new MUID. You can get this MUID from an Asset Reference. | None |
| `SetImage(Player)` | `None` | Downloads and sets a Player's profile picture as the texture for this UIImage control. | **Deprecated** |
| `SetPlayerProfile(Player)` | `None` | Downloads and sets a Player's profile picture as the texture for this UIImage control. | None |
| `SetPlayerProfile(CorePlayerProfile)` | `None` | Downloads and sets a player's profile picture as the texture for this UIImage control. | None |
| `SetPlayerProfile(CoreFriendCollectionEntry)` | `None` | Downloads and sets a player's profile picture as the texture for this UIImage control. | None |
| `SetPlayerProfile(string playerId)` | `None` | Downloads and sets a player's profile picture as the texture for this UIImage control. | None |

## Tutorials

[UI in Core](../tutorials/ui_reference.md)
