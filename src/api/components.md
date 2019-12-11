# CORE Game Components

## Basic Game State

### [Basic Game State Manager](#basic-game-state-manager)

Manages lobby and round game states and fires events to notify other game systems of state changes

Custom Properties:

```lua
- LobbyHasDuration (bool)
- LobbyDuration (float)
- RoundHasDuration (bool)
- RoundDuration (float)
- RoundEndHasDuration (bool)
- RoundEndDuration (float)
```

Events Sent:

```lua
- (Server/Client) GameStateChanged(oldState (int), newState (int), stateHasDuration (bool), stateEndTime (float))
- (Server/Client) Game.roundStartEvent
- (Server/Client) Game.roundEndEvent
```

The game starts in the “Lobby” state, then proceeds through “Round” and “Round End” states before returning to “Lobby”. This component can be configured to enable an automatic duration on each of the three states, as well as what those durations are.

APIBasicGameState.lua defines the various game states and a few functions that can be used to interact with the game state system.

#### Game State Display

Displays the current game state and the time remaining

Requires:

* [Basic Game State Manager](#basic-game-state-manager)

_HasEditableUI (UI Panel)_

Custom Properties:

```lua
- ShowStateName (bool)
- ShowDuringLobby (bool)
- ShowDuringRound (bool)
- ShowDuringRoundEnd (bool)
```

#### Game State Geometry

Manages visibility of certain world objects based on the current game state

Requires:

* [Basic Game State Manager](#basic-game-state-manager)

Custom Properties:

```lua
- Geometry (Core Object Reference)
- ExistsInLobby (bool)
- ExistsInRound (bool)
- ExistsInRoundEnd (bool)
```

This allows a creator to create geometry that only exists during certain game states. One example use is to have temporary walls that hold players in their spawn areas until the round begins.

### Lobby Start Behavior

#### Lobby Start Respawn Players

Respawns every player at the beginning of the “Lobby” game state

Requires:

* [Basic Game State Manager](#basic-game-state-manager)

Custom Properties:

```lua
- Period (int) : respawn time period for spreading out server cost of mass respawn
```

This can be used in games where players don’t respawn normally, but also functions alongside normal respawning. Living players will also be sent to a spawn point on starting the “Lobby” game state.

#### Lobby Start Reset KD

Resets every players’ kills and deaths at the start of the “Lobby” game state

Requires:

* [Basic Game State Manager](#basic-game-state-manager)

#### Lobby Start Reset Team Scores

Resets each teams’ score at the start of the “Lobby” game state

Requires:

* [Basic Game State Manager](#basic-game-state-manager)

### Round End Conditions

#### Round Survivor Victory

Ends the round when either a single player or a single team has living players, depending on the properties.

Requires:

* [Basic Game State Manager](#basic-game-state-manager)

Custom Properties:

```lua
- ByTeam (bool) : consider teams when deciding to end the round
```

Events Sent:

```lua
- (Server) PlayerVictory(winner (player))
- (Server) TeamVictory(winningTeam (int))
- (Server) TieVictory()
```

#### Round Team Score Limit

Ends the round when a team reaches the team score limit

Requires:

* [Basic Game State Manager](#basic-game-state-manager)

Custom Properties:

```lua
- TeamScoreLimit (int)
```

Events Sent:

```lua
- (Server) PlayerVictory(winner (player))
- (Server) TeamVictory(winningTeam (int))
- (Server) TieVictory()
```

#### Round Kill Limit

Ends the round when a player reaches the kill limit

Requires:

* [Basic Game State Manager](#basic-game-state-manager)

Custom Properties:

```lua
- KillLimit (int)
```

Events Sent:

```lua
- (Server) PlayerVictory(winner (player))
- (Server) TeamVictory(winningTeam (int))
- (Server) TieVictory()
```

### Round Start Conditions

#### Lobby Required Players

Starts the round start countdown when the required number of players connect

Requires:

* [Basic Game State Manager](#basic-game-state-manager)

Custom Properties:

```lua
- RequiredPlayers (int)
- CountdownTime (int) : optional countdown time before round start
```

### Round Start Behavior

#### Round Start Sky Dive

Spawns a plane on a fly-over path over a specified circular area that spawns players

Requires:

* [Basic Game State Manager](#basic-game-state-manager)

_HasEditableGeo_

Custom Properties:

```lua
- PlaneTemplate (Core Object reference) : template will be spawned to drop players into the world
- PlaneSpeed (float)
- OffCenterFactor (float)
- PreDropFactor (float) : distance as factor of radius to start path before entering the designated circle
- PostDropFactor (float) : distance as factor of radius to end path after leaving the designated circle
- JumpAbilityName (string) : name of ability attached to players to cause them to spawn and exit the plane
```

Events Sent:

```lua
- (Server) SkydivePlaneSpawned(plane (CoreObject))
- (Server) SkydivePlaneDespawned(plane (CoreObject))
- (Server) PlayerBeganSkydive(player (player))
- (Client) ClearPlaneCamera()
```

This spawns a battle-royale style plane (or any template) at the start of “Round”, which flies across the map on a random path within a circle. Players choose where to drop by activating an ability binding.

# Map

## Basic Door

Interactive door with several basic behaviors

_HasEditableGeo (Geo_StaticContext)_

Custom Properties:

```lua
- AutoOpen (bool) : open when player is nearby
- TimeOpen (float) : when using AutoOpen, duration with no nearby players before door automatically closes
- OpenLabel (string) : interaction trigger label when door is closed
- CloseLabel (string) : interaction trigger label when door is open
- Speed (float) : rotational speed
- ResetOnRoundStart (bool) : should reset on Game.onRoundStart
```

Events Sent:

```lua
- (Server) DoorOpened(door (Core Object Reference))
- (Server) DoorClosed(door (Core Object Reference))
```

This is a simple configurable door that can be set to open automatically when a player is near or require a prompt.

## Kill Zone

Volume that kills any player that touches it

_HasEditableGeo (KillTrigger)_

## Point Of Interest

Designates a location that may be noteworthy to a player

Custom Properties:

```lua
- Name (string)
- Icon (Asset Reference)
```

Other components (just Compass currently) will show UI or otherwise rely on points of interest. Points of interest may be spawned and removed during gameplay.

Creators can also make their own points of interest from lua by using functions defined in APIPointOfInterest.lua.

## Capture Points

Capture points are used to draw players together to focus the action.

APIBasicCapturePoint.lua defines a handful of functions that can be used to make more complex logic or tie things to capture point behavior. They also broadcast the following custom events:

```
CapturePointOwnerChanged(string id, int oldOwner, int newOwner)
CapturePointEnabledStateChanged(string id, bool oldEnabled, bool newEnabled)
```

### Capture Point Assault

Assault style capture point where one team defends and one team attacks

Requires**:**

```lua
- Game.onRoundStart
- Game.onRoundEnd
```

_HasEditableGeo (GeoVisual)_

_HasEditableCollision (GeoCollision)_

Custom Properties:

```lua
- Name (string)
- CaptureTime (float)
- DecaySpeed (float)
- MultiplyWithPlayers (bool) : scale capture time with number of players present in capture area
- ResetOnRoundEnd (bool)
- EnabledByDefault (bool) : capture point starts enabled onRoundStart
- ChangeColorWhenDisabled (bool)
- DisabledColor (Color)
- AttackingTeam (int)
- Order (int) : for creating capture point sequences, specify the order of this capture point relative to other capture points
```

Events Sent:

```lua
- (Server) CapturePointOwnerChanged(capturePointId (Core Object reference), owningTeam (int), newOwner (int))
- (Server) CapturePointEnabledStateChanged(capturePointId (Core Object reference), oldEnabled (bool), enabled (bool))
```

When the attackers capture the point, it becomes disabled (locked). Supports two teams.

### Capture Point Control

Control-style capture point that can be captured back and forth multiple times

Requires**:**

```lua
- Game.onRoundStart
- Game.onRoundEnd
```

_HasEditableGeo (GeoVisual)_

_HasEditableCollision (GeoCollision)_

Custom Properties:

```lua
- Name (string)
- CaptureThreshold (float) : ownership fraction required for capture
- CaptureTime (float)
- DecaySpeed (float)
- TeamScoreRate (float)
- MultiplyWithPlayers (bool) : scale capture time with number of players present in capture area
- ResetOnRoundEnd (bool)
- EnabledByDefault (bool) : capture point starts enabled onRoundStart
- ChangeColorWhenDisabled (bool)
- DisabledColor (Color)
- Order (int) : for creating capture point sequences, specify the order of this capture point relative to other capture points
```

Events Sent:

```lua
- (Server) CapturePointOwnerChanged(capturePointId (Core Object reference), owningTeam (int), newOwner (int))
- (Server) CapturePointEnabledStateChanged(capturePointId (Core Object reference), oldEnabled (bool), enabled (bool))
```

Capture point begins in a neutral state. Supports more than two teams.

### Local Capture Point Display

Shows the state of the capture point that the local player is currently standing on

Requires**
```lua
pt  * [re Point Assault/Control](#basic-game-state-manager)

_HasEditableUI (Panel)_

Custom Properties:

```lua
- ShowPointName (bool)
- ShowThresholdMarkers (bool)
- AlwaysShow (bool)
- ContestedMessage (string)
- FriendlyColor (Color)
- NeutralColor (Color)
- EnemyColor (Color)
```

Can be toggled to always show in a game that only features a single point.

### Global Capture Point Display

Shows the state of all capture points

Requires**
```lua
pt  * [re Point Assault/Control](#basic-game-state-manager)

_HasEditableUI (Panel)_

Custom Properties:

```lua
- ShowCapturePointNames (bool)
- HorizontalSpacing (float)
- NeutralColor (Color)
- DisabledColor (Color)
```

## Constricting Play Zones

### Constricting Play Zone

Battle royale-style play zone that shrinks and damages players outside the zone

Requires**:**

```lua
- Game.roundStartEvent
- Game.roundEndEvent
```

_HasEditableGeo (ZoneVisual)_

_HasEditableCollider (InitialZone)_

Custom Properties:

```lua
- PhaseCount (int) : number of zone phases, not including the final 0-size phase
- ZoneSizeRatio (float) : ratio of the zone's size from one phase to the last phase
- StaticTime (float) : time spent before shrinking to the next phase
- ClosingTime (float) : time spent actively shrinking between phases
- BaseDamageRate (float) : damage per second applied to players outside the zone during the first phase
- DamageMultiplier (float) : scales damage dealt per phase
- UseRoundTiming (bool) : Game.roundStartEvent and Game.roundEndEvent control the zone
- ActivationDelay (float) : delay after activation to begin first phase
```

### Constricting Play Zone UI

Tells the player what phase zone is currently active and the remaining phase time

Requires**
ua  * [- Constricting Play Zone](#basic-game-state-manager)

_HasEditableUI (ShrinkTimerCanvas)_

## Named Locations

This system allows a game maker to associate names to certain areas of the map. They can then be used for UI or other purposes. The following custom events are broadcast:

```
LocationEntered(Player player, table locationProperties)
LocationExited(Player player, table locationProperties)
```

### Named Location

Single location with an associated name

_HasEditableGeo (ZoneTrigger)_

Custom Properties:

```lua
- Name (string)
- TextColor (Color)
- BackgroundColor (Color)
```

Events Sent:

```lua
- (Client) LocationEntered(player, locationProperties (table))
locationProperties :
- name (string)
- textColor (Color)
- backgroundColor (Color)
- (Client) LocationExited(player, locationProperties (table))
locationProperties :
- name (string)
- textColor (Color)
- backgroundColor (Color)
```

This component can be used to drive other behavior when players are in certain locations within your game. It is used by Named Location UI.

### Named Location UI

Displays UI for a few seconds when the local player enters a named location

ires*   * [
```lua
- Named Location](#basic-game-state-manager)

_HasEditableUI (Canvas Control)_

Custom Properties:

```lua
- PopupTextDuration (float) : duration to display UI when local player enters named location
```

# UI

## Ability Binding Display

Displays information about a local player ability

* [uires**
```lua
- Ability](#basic-game-state-manager)

_HasEditableUI (Panel Control)_

Custom Properties:

```lua
- Binding (string) : name of the binding associated with the ability
- BindingHint (string)
- ShowAbilityName (bool)
```

Given a single binding string, this shows whenever the local player has an ability that uses that binding. It shows the cooldown when it is on cooldown, and that it is available otherwise.

## Compass

Displays a compass showing the facing of the local player

_HasEditableUI (Panel)_

Custom Properties:

```lua
- ShowPointsOfInterest (bool)
- ShowDistanceToPOIs (bool)
```

This shows a compass at the top of the players screen that tells them which direction they are facing. It also shows Points of Interest.

## Health Bar

Displays a fillable health bar showing the local player’s current health

_HasEditableUI (Canvas Control)_

Custom Properties:

```lua
- ShowNumber (bool) : display current health value number
- ShowMaximum (bool) : display maximum health value number
```

## Kill Feed

Displays a feed that reports player kills

_HasEditableUI (Canvas)_

_HasEditableUI (Helper_KillFeedLine)_

Custom Properties:

```lua
- ShowJoinAndLeave (bool) : optionally show player join and leave events
- NumLines (int)
- LineDuration (int)
- TextColor (Color)
- SelfTextColor (Color) : special color for kills involving local player
```

This shows a line announcing every time a player dies in the game. It optionally also shows when players join or leave the game.

## Message Banner

Displays temporary announcement messages

_HasEditableUI (BannerCanvas)_

Custom Properties:

```lua
- NameOfCustomProperty (type)
```

Events Received:

```lua
- (Client) BannerMessage(message (string))
- (Client) BannerMessage(message (string), duration (float))
```

This shows a temporary message to players, often in the center of their screen, in response to received “BannerMessage” events on the client.

## Nameplates

Displays health bars and optional names over player heads

_HasEditableUI (Helper_Nameplate)_

Custom Properties:

```lua
- ShowNames (bool)
- ShowHealthbars (bool)
- ShowOnSelf (bool)
- ShowOnTeammates (bool)
- MaxDistanceOnTeammates (float) : distance to teammate from local player view beyond which nameplates will be hidden
- ShowOnEnemies (bool)
- MaxDistanceOnEnemies (float) : distance to enemy from local player view beyond which nameplates will be hidden
- ShowOnDeadPlayers (bool)
- Scale (float)
- ShowNumbers (bool)
- AnimateChanges (bool)
- ChangeAnimationTime (float)
- FriendlyNameColor (Color)
- EnemyNameColor (Color)
- BorderColor (Color)
- BackgroundColor (Color)
- FriendlyHealthColor (Color)
- EnemyHealthColor (Color)
- DamageChangeColor (Color)
- HealChangeColor (Color)
- HealthNumbercolor (Color)
```

## Player Count Display

Displays count of living players

_HasEditableUI (Canvas Control)_

Custom Properties:

```lua
- ShowTotalPlayers (bool) : optionally display total player count
```

## Scoreboard

Displays a table of information about each player

_HasEditableUI (Canvas)_

Custom Properties:

```lua
- Binding (string) : input binding that opens the Scoreboard
- ShowAtRoundEnd (bool)
- RoundEndDuration (float)
```

This shows a simple name, kill, and death scoreboard when a binding is pressed. It optionally can be shown for a short time at the end of round as well.

## Team Score UI

Displays the team score of a single team

_HasEditableUI (TeamScoreCanvas)_

Custom Properties:

```lua
- Team (int)
- Label (string)
- ShowMaxScore (bool)
- MaxScore (int)
```

This shows how much score a single team has. A creator may want to put multiple of these in a game.

## Victory Announcer

Displays a victory message

ires*   * [
```lua
- Message Banner](#basic-game-state-manager)

_HasEditableUI_

Events Received:

```lua
- (Server) PlayerVictory(player (Player))
- (Server) TeamVictory(team (int))
- (Server) TieVictory()
```

Events Sent:

```lua
- (Client) BannerMessage(arg1 (type)[, arg2 (type), …])
```

This listens to custom events that the Round End Conditions components broadcast, and then broadcasts events for the Message Banner that report the winner.

# Utility

## Inventory

Basic Inventory takes care of managing multiple Equipment objects that want to attach to the same socket.

Requirements:

- Equipment must have empty PickupTrigger field
- Equipment Visibility and Collidability must not be modified by scripts

### Basic Inventory

Allows players to swap between equipment associated with a specific socket

Custom Properties:

```lua
- EquipmentSocket (string) : socket for equipment attachment
- InventorySize (int) : number of Equipment objects allowed by this inventory. Maximum value is 8.
- DestroyDroppedEquipment (bool) : should destroy equipment that is dropped from exceeding size
- NextAbilityName (string) : name of ability that equips next equipment
- PreviousAbilityName (string) : name of ability that equips previous equipment
```

This component manages a specific socket on all players. When it finds a player has multiple equipment in that slot, it unequips all but one of them, and leaves them in a table. Each player can swap which equipment they have active by pressing using the next and previous abilities. Whenever a player picks up a new piece of equipment, that new equipment becomes the active one. If they are now over the maximum inventory size, the previously equipped equipment is unequipped and dropped (or destroyed).

Note that if your equipment do not use the 'right_prop' socket, that you may wish to change the Animation of the next and previous abilities (empty is valid for no animation), as things may not line up nicely.

Note also that this component sets the player resource: BasicInventory*OrderKey*[SocketName]. This is used to reconstruct the same

inventory order on clients with minimal replication, to maintain a stable order and behavior that feels consistent. Inventories cannot be larger than 8 in order to keep this key in a single integer value.

### Basic Inventory UI

Displays UI for a player socket’s inventory

* [uires:

`Basic Inventory](#basic-game-state-manager)

_HasEditableUI (UI Panel)_

_HasEditableUI (Helper_BasicInventoryLine)_

Custom Properties:

```lua
- EquipmentSocket (string)
- ShowEquipmentName (bool)
- ActiveBackgroundColor (Color)
- InactiveBackgroundColor (Color)
```

This component displays the Equipment associated with a given socket name. The equipped state of each Equipment object will be indicated by the background colors.

## Kill Team Score

Updates team score when any player gets a kill

Custom Properties:

```lua
- ScorePerKill (int)
```

This adds score to the player’s team whenever a player gets a kill.

## Spectator Camera

Spectator camera that allows players to follow and spectate other players

Custom Properties:

```lua
- SpectatorDelay (float) : delay before a dead player automatically begins spectating
- CanSpectateEnemies (bool)
- NextTargetBinding (string) : binding to press to spectate the next target
- PreviousTargetBinding (string) : binding to press to spectate the previous target
```

Events Sent:

```lua
- (Client) SpectatingTargetChanged(oldTarget (Player), newTarget (Player))
- (Client) IsSpectatingChanged(isSpectating (bool))
```

## Static Player Equipment

Equips players with equipment when they join the game

Custom Properties:

```lua
- EquipmentTemplate (Asset Reference) : equipment to spawn
- Team (int) : if not zero, limit equipment to a specific team
- ReplaceOnEachRespawn (bool) : equip a new copy of the equipment when a player respawns
```

This gives every player (or optionally just players on a specific team) a certain piece of equipment.
