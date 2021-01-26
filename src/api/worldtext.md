---
id: worldtext
name: WorldText
title: WorldText
tags:
    - API
---

# API: WorldText

## Description

WorldText is an in-world text CoreObject.

## API

### Properties

| Property Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `text` | `string` | The text being displayed by this object. | Read-Write |

### Functions

| Function Name | Return Type | Description | Tags |
| -------- | ----------- | ----------- | ---- |
| `GetColor()` | `Color` | The color of the Text. | None |
| `SetColor(Color)` | `None` | The color of the Text. | None |

## Examples

- `GetColor`

- `SetColor`

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

---

- `text`

Change the contents of a WorldText object with the `text` property. In this example, when a new player joins the game their name is written to the WorldText. It's also demonstrated that `<br>` can be used to insert line breaks. This script expects to be the child of a WorldText object that is placed in the scene.

```lua
local nameTextObject = script.parent

Game.playerJoinedEvent:Connect(function (player)
    nameTextObject.text = player.name .. "<br>has joined the game!<br>GLHF!"
end)
```

---
