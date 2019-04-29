# Tutorial

Now that you've completed the [Lua Primer](lua_primer.md), it's time to get scripting in Core!

## My First Script


### Creating the Script

1. Open up the editor and click the `+New Script` button
    * This will place a new script in the Asset Manifest
* Rename your script to `TutorialScript`
    * You can rename scripts by clicking on the script in the Asset Manifest and pressing `F2`
* Open up the script by double clicking on it
    * By default this happens via our inbuilt editor
    * You can also configure scripts to open in an external editor by default by
    going to `Edit -> Preferences --> External Script Editor`
        * Atom, VSCode, and ZeroBrane all have auto-complete support

### Writing the Script

1. Delete everything in the script. We don't need any of the placeholder code
* Type `print_to_screen("Hello World!")`
* Save the script (`CTRL+S`)

### Running the Script

1. To add your script to the game, drag it from the Asset Manifest to the top of the Hierarchy
* Press `Play` at the top of the editor, and see your message appear on screen!

### Hello World Breakdown

* We made a script
* We populated it with code
    * The function `print_to_screen(string s)` prints the parameter `s` to the viewport. This is one of many of the built-in Core API functions
* We placed the script into the Hierarchy so that it executes when the game runs

Now let's add our own function!

```lua
-- Our first function!
function init()
    print_to_screen("Hello from a function!")
end
```

If you save and run that code...nothing happens. Well that's because the
function is never called. Add a function call to the end of the script (Lua
prefers function definitions at the top).

You should now have the following:

```lua
-- Our first function!
function init()
    print_to_screen("Hello from a function!")
end

-- Calling the function
init()
```

Save and run that, and you'll see your message appear on the screen! Excellent.

If you have issues, make sure you have something like this: ![MyFirstScript](../img/scripting/MyFirstScript.png)

---

## Core API

The next step is to use the Core API to modify objects in the world. We'll start
small, with a coin the player can pick up,

First the coin. The mesh for it can be found on the marketplace as `Manticoin`.
Note: Alternatively, you can create it yourself with three cylinders, one
textured  gold for the coin, and the other slightly smaller ones for decal
textures on each side. Make sure to make it a template after.

Okay, we want our coin to spin slowly in the air, rather than just sitting there
and being boring. The way to do this is, you guessed it, with a script.

First make a script, and call it `SpinCoin`, and put it one level below the main
Manticoin object. Add the following line of code:
`script.parent:rotate_continuous(Rotation.new(200, 0, 0))`

You should have the following: ![SpinCoinLocation](../img/scripting/SpinCoin.png)

Running this should continuously rotate the coin in the air, fantastic!

Okay, so what did we just do?

### Spin Breakdown

* `script` -> references the script object, i.e. the thing you dragged into the hierarchy
* `script.parent` -> references the script's parent object, i.e. the item one
  level above the script (in this case the Manticoin object)
* `script.parent:rotate_continuous()` -> Every _CoreObject_ (things like
  Scripts, Objects, etc.) has methods available to it. `rotate_continuous` is
  one of these, and we invoke it with the `:` syntax. It requires a `Rotation`
  parameter to work
* `script.parent:rotate_continuous(Rotate.new(200, 0, 0))` -> Here we create a
  rotation vector to rotate by a pitch of 200, spinning the coin along the y
  axis by the requisite speed. Rotate is a _Core Class_ that has the method
  `.new`, which takes in parameters for the pitch, yaw, and roll. Since `.new`
  returns a `Rotation` (exactly what we need to pass in to `rotate_continuous`,
  it works out well.)

The above is a bit confusing, so let's rewrite it to be more clear

```lua
-- Get the object one level above the script in the hierarchy, in this case our coin
local coin = script.parent
-- Create a rotation along the x axis
local spin_rotation = Rotate.new(200, 0, 0)
-- Rotate the coin using our previously defined rotation
coin:rotate_continuous(spin_rotation)
```

Yay, we've got it working!

Next, let's add a resource collection system so you can pick up the coins. Then
we'll spawn them all over the map, and will have a timer to pick them up in a
limited time, making a game.

---

## Pick Up Coins

### Goal

Use the Trigger object to pick up the coin, and display the total of coins on
the screen.

* Create a `Trigger` via Object -> Trigger
* Put that trigger as a child of the coin and adjust the hitbox via the scale so
  it is slightly larger than the coin
* Make a script called `PickupCoin` and put it as the child of the trigger
* Add the following to the script:

```lua
-- When a player hits the coin, increment a resource on the player and remove the coin
function handleOverlap(trigger, object)
	if (object ~= nil and object:is_a("Player")) then
        object:add_resource("Manticoin", 1)
        trigger.parent:destroy()
	end
end

-- Whenever an object collides with the trigger, run this function
script.parent.on_begin_overlap:connect(handleOverlap)
```

If you save and press play, you'll notice nothing seems to happen. Well that's
because we have no output of the data. Let's modify TutorialScript to display
this. Add the following code:

```lua
-- Print out 'Player name: {coin count}' every 5 seconds
function tick()
    wait(5)
    local players = game:get_players()
    for i = 1,#players do
        print_to_screen(players[i].name..": "..tostring(players[i]:get_resource("Manticoin") or 0))
    end
end
```

Now when you walk over the coin and away from it, you'll pick it up, and the
amount will be displayed every 5 seconds.

Next up is to add a UI element instead of the messy `print_to_screen` we have now.

Go to Object -> UI Text Control. Put the Text Control object in a `Client
Context` folder

!!! info
    Client context simply means it will be unique to each client, the server
    doesn't care about it

Create a new script called `Display Coins` and add the following code

```lua
-- Display the player's coin amount

wait()  -- Wait a tick for players to connect
local player = game:get_local_player()

-- Every 0.1 seconds update the coin count display
function tick()
    wait(0.1)
    local displayString = player.name..": "..tostring(player:get_resource("Manticoin") or 0)
    script.parent.text = displayString
end

-- Note: For performance we'd ideally only update the UI when the coin count changes, but this example favors simple code
```

For reference, the folder structure should look like this: ![UIText](../img/scripting/UIText.png)

Now let's make a simple map and populate it with coins, and add in the main
gameplay loop of rounds.

## Map

Add your objects, put it in a static group (group allows you to grab one object
and move all of them). Add a sky. Done.

## Game

Okay, now to populate the map with coins.

There are two main ways to go about this.

1) Manually populate
2) Write a script to automatically place items

For now we're going with #1, but know that #2 is an option too.

So make a folder called `Coins` and copy Manticoins to scatter them over the map
(the shortcut of Ctr+W to duplicate may be helpful for this)

Now we will write a script to make the game round-based.

Create a script called `CoinGameLogic` and put it into the top of the scene.
Here's the entire hierarchy at this point

![GameLogicHierarchy](../img/scripting/GameLogicHierarchy.png)

We are going to update the game when the player has picked up all the possible
coins. To do so, add the following code to `CoinGameLogic`

```lua
-- Get the folder containing all the coin objects
local coinFolder = game:find_object_by_name("Coins")

-- Every second check for how many coins are left in the scene
function tick()
	wait(1)
	local coinsLeft = #coinFolder.children
	if coinsLeft == 0 then
		game:find_object_by_name("CoinUI").text = "All Coins Found!"
	end
end
```

We are looking at how many coins are left by seeing how full the folder of coins
in the hierarchy is (`.children` gets the child elements, and `#` checks the
length of the array, or how many there are). `game:find_object_by_name()`
searches the hierarchy for the object with the name passed in, and then we get
that UI element and set it to be the string we want!

### Reset

Lastly, let's add in the logic to reset the map (i.e. add the coins back) after
they all have been picked up.

Currently we are deleting the coins when they are picked up. We could spawn in
new coins at the old locations, but that would involve storing references tot he
old locations and a bunch of boilerplate code. An easier solution would be to
just hide the coins from the map when they are picked up, and then re-enable
them when resetting the map. Fortunately, this is not only possible in Core, but
is a very quick change.

Go to `PickupCoin` in the Asset Manifest, and change the line of
`trigger.parent:destroy()` to `trigger.parent.enabled = false`. That will
disable the collision and visibility of the object, making it basically not
present in the scene.

Next, create a UI element to display information on the round resetting. Make it
a sibling of CoinUI, I called it RoundUI and positioned it right below CoinUI.
Set the label of it to be an empty string/blank by default (we'll add text to it
later programatically).

The last step is to add the resetting logic to our main `CoinGameLogic` script.

You'll note that our old code for checking the number of coins left won't work
anymore, as we are setting a property on each of the coins (`.enabled`) rather
than deleting the object entirely. Add the following function:

```lua
-- Get the amount of coins that are enabled in the scene
function GetCoinsLeft()
	local count = 0
	for _,coin in pairs(coinFolder.children) do
		if coin ~= nil and coin.enabled	then
			count = count + 1
		end
	end
	return count
end
```

This will return how many coins are left, which we can use in our main `tick`
loop later.

Next we need to add the logic to reset the map, which for us simply means
looping through all the coins and setting their `.enabled` property to be true.
The logic will be quite similar to getting the coin count. Here it is as a function:

```lua
-- Set all coins to be enabled
function ResetMap()
	for _,coin in pairs(coinFolder.children) do
		if coin ~= nil then
			coin.enabled = true
		end
	end
end
```

Then we need to add these function calls to our main tick loop and update the
UI, and we'll be done! Here's the code for it:

```lua
-- Check for the round end by looking for the amount of coins left
-- If the game should end, display a UI element, countdown, then reset the map
function tick()
	local players = game:get_players()
	local coinsLeft = GetCoinsLeft()

	if coinsLeft == 0 then
		local uiText = game:find_object_by_name("RoundUI")
		uiText.text = "All Coins Found!"
		wait(3)
		for i = 3,0,-1 do
			wait(1)
			uiText.text = "New round in "..tostring(i).." seconds"
		end
		ResetMap()
		uiText.text = ""
	end
end
```

## Conclusion

Finally, you can check out the game by going
[here](https://staging.manticoreplatform.com/games/b8efe9e824994eae963d618cdbcabbd1)
and clicking on 'edit' to download a copy of the game to play around with
yourself!