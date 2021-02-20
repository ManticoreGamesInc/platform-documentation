---
id: game
name: Game
title: Game
tags:
    - API
---

# Game

Game is a collection of functions and events related to players in the game, rounds of a game, and team scoring.

## Class Functions

| Class Function Name | Return Type | Description | Tags |
| -------------- | ----------- | ----------- | ---- |
| `Game.GetLocalPlayer()` | [`Player`](player.md) | Returns the local player. | Client-Only |
| `Game.GetPlayers([table parameters])` | `Array<Player>` | Returns a table containing the players currently in the game. An optional table may be provided containing parameters to filter the list of players returned: ignoreDead(boolean), ignoreLiving(boolean), ignoreTeams(Integer or table of Integer), includeTeams(Integer or table of Integer), ignorePlayers(Player or table of Player), E.g.: `Game.GetPlayers({ignoreDead = true, ignorePlayers = Game.GetLocalPlayer()})`. | None |
| `Game.FindNearestPlayer(Vector3 position, [table parameters])` | [`Player`](player.md) | Returns the Player that is nearest to the given position. An optional table may be provided containing parameters to filter the list of players considered. This supports the same list of parameters as GetPlayers(). | None |
| `Game.FindPlayersInCylinder(Vector3 position, Number radius, [table parameters])` | `Array<Player>` | Returns a table with all Players that are in the given area. Position's `z` is ignored with the cylindrical area always upright. An optional table may be provided containing parameters to filter the list of players considered. This supports the same list of parameters as GetPlayers(). | None |
| `Game.FindPlayersInSphere(Vector3 position, Number radius, [table parameters])` | `Array<Player>` | Returns a table with all Players that are in the given spherical area. An optional table may be provided containing parameters to filter the list of players considered. This supports the same list of parameters as GetPlayers(). | None |
| `Game.StartRound()` | `None` | Fire all events attached to roundStartEvent. | Server-Only |
| `Game.EndRound()` | `None` | Fire all events attached to roundEndEvent. | Server-Only |
| `Game.GetTeamScore(Integer team)` | `Integer` | Returns the current score for the specified team. Only teams 0 - 4 are valid. | None |
| `Game.SetTeamScore(Integer team, Integer score)` | `None` | Sets one team's score. | Server-Only |
| `Game.IncreaseTeamScore(Integer team, Integer scoreChange)` | `None` | Increases one team's score. | Server-Only |
| `Game.DecreaseTeamScore(Integer team, Integer scoreChange)` | `None` | Decreases one team's score. | Server-Only |
| `Game.ResetTeamScores()` | `None` | Sets all teams' scores to 0. | Server-Only |
| `Game.StopAcceptingPlayers()` | `None` | Sets the current server instance to stop accepting new players. Note that players already in the process of joining the server will still be accepted, and `Game.playerJoinedEvent` may still fire for a short period of time after a call to this function returns. Other new players will be directed to a different instance of the game. | Server-Only |
| `Game.IsAcceptingPlayers()` | `bool` | Returns `true` if the current server instance is still accepting new players. Returns `false` if the server has stopped accepting new players due to a call to `Game.StopAcceptingPlayers()`. | None |
| `Game.TransferAllPlayersToGame(string gameId)` | `None` | Similar to `Player:TransferToGame()`, transfers all players to the game specified by the passed in game ID. Does not work in preview mode or in games played locally. | Server-Only |

## Events

| Event Name | Return Type | Description | Tags |
| ----- | ----------- | ----------- | ---- |
| `Game.playerJoinedEvent` | `Event<Player>` | Fired when a player has joined the game and their character is ready. When used in client context it will fire off for each player already connected to the server. | None |
| `Game.playerLeftEvent` | `Event<Player>` | Fired when a player has disconnected from the game or their character has been destroyed. This event fires before the player has been removed, so functions such as `Game.GetPlayers()` will still include the player that is about to leave unless using the `ignorePlayers` filter within the parameters. | None |
| `Game.roundStartEvent` | [`Event`](event.md) | Fired when StartRound is called on game. | None |
| `Game.roundEndEvent` | [`Event`](event.md) | Fired when EndRound is called on game. | None |
| `Game.teamScoreChangedEvent` | `Event<Integer team>` | Fired whenever any team's score changes. This is fired once per team who's score changes. | None |

## Examples

Using:

- `FindNearestPlayer`

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

See also: [Game.GetPlayers](game.md) | [CoreObject.GetWorldPosition](coreobject.md) | [Player.SetWorldScale](player.md) | [Vector3.ONE](vector3.md) | [CoreLua.Tick](coreluafunctions.md) | [Task.Wait](task.md)

---

Using:

- `FindPlayersInCylinder`

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

See also: [CoreObject.GetWorldPosition](coreobject.md) | [Player.GetVelocity](player.md) | [Vector3.UP](vector3.md) | [CoreLua.Tick](coreluafunctions.md) | [Task.Wait](task.md)

---

Using:

- `FindPlayersInSphere`

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

See also: [CoreObject.GetWorldPosition](coreobject.md) | [Player.GetVelocity](player.md) | [Vector3.UP](vector3.md) | [CoreLua.Tick](coreluafunctions.md) | [Task.Wait](task.md)

---

Using:

- `GetLocalPlayer`

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

See also: [Game.GetPlayers](game.md) | [UI.PrintToScreen](ui.md) | [Player.name](player.md) | [Color.GREEN](color.md) | [Task.Wait](task.md)

---

Using:

- `GetPlayers`

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

See also: [Game.roundEndEvent](game.md) | [CoreLua.print](coreluafunctions.md) | [Event.Connect](event.md)

---

Using:

- `GetTeamScore`

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

See also: [UI.PrintToScreen](ui.md) | [Task.Wait](task.md) | [CoreLua.Tick](coreluafunctions.md)

---

Using:

- `ResetTeamScores`

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

See also: [Game.GetTeamScore](game.md) | [CoreLua.print](coreluafunctions.md) | [Event.Connect](event.md)

---

Using:

- `SetTeamScore`

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

See also: [Game.FindPlayersInCylinder](game.md) | [CoreObject.GetWorldPosition](coreobject.md) | [CoreLua.Tick](coreluafunctions.md) | [Task.Wait](task.md)

---

Using:

- `StartRound`
- `EndRound`

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

See also: [Game.GetTeamScore](game.md) | [Event.Connect](event.md) | [Task.Wait](task.md) | [CoreLua.print](coreluafunctions.md)

---

Using:

- `playerJoinedEvent`
- `playerLeftEvent`

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

See also: [Player.team](player.md) | [Game.GetPlayers](game.md) | [Event.Connect](event.md)

---

Using:

- `roundEndEvent`

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

See also: [Game.EndRound](game.md) | [Player.Respawn](player.md) | [CoreLua.print](coreluafunctions.md) | [Task.Wait](task.md) | [Event.Connect](event.md)

---

Using:

- `roundStartEvent`

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

See also: [Game.StartRound](game.md) | [CoreLua.print](coreluafunctions.md) | [Event.Connect](event.md)

---

Using:

- `teamScoreChangedEvent`
- `IncreaseTeamScore`
- `DecreaseTeamScore`

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

See also: [Game.GetTeamScore](game.md) | [Player.isJumping](player.md) | [CoreLua.print](coreluafunctions.md)

---
