# Tutorial

## My First Script

* Open up the editor, click `+New Script`
* Open up the script
  * By default this happens via our inbuilt editor
  * You can also configure scripts to open in an external editor by default by going to `edit -> preferences --> external script editor`
    * Atom, VSCode, and ZeroBrane all have auto-complete support
* Delete everything in the script
* Type `print_to_screen("Hello World!")`
* Save the script (Ctr+S) and drag it to the top of the hierarchy
* Press `Run` at the top of the editor, and see your message appear on screen!

Okay, so what happened?

* We made a script
* We populated with code:
  * The inbuilt function `print_to_screen(string s)` prints the parameter `s` to the viewport
* We put the script into the hierarchy so it could run when the game did

Now let's add our own function

```lua
function init()
    print_to_screen("Hello from a function!")
end
```

If you save and run that code...nothing happens. Well that's because the function is never called. Add a function call to the end of the script (Lua prefers function definitions at the top).

You should now have the following:

```lua
function init()
    print_to_screen("Hello from a function!")
end

init()
```

Save and run that, and you'll see your message appear on the screen! Excellent. 

If you have issues, make sure you have something like this: ![MyFirstScript](../../img/scripting/MyFirstScript.png)

---

## Core API

The next step is to use the Core API to modify objects in the world. We'll start small, with a coin the player can pick up,

First the coin. The mesh for it can be found on the marketplace as `Manticoin`. 
Note: Alternatively, you can create it yourself with three cylinders, one textured gold for the coin, and the other slightly smaller ones for decal textures on each side. Make sure to make it a template after.

Okay, we want our coin to spin slowly in the air, rather than just sitting there and being boring. The way to do this is, you guessed it, with a script.

First make a script, and call it `SpinCoin`, and put it one level below the main Manticoin object. Add the following line of code:
`script.parent:rotate_continuous(Rotation.new(200, 0, 0))`

You should have the following: ![SpinCoinLocation](../../img/scripting/SpinCoin.png)

Running this should continuously rotate the coin in the air, fantastic!

Okay, so what did we just do?

### Spin Breakdown

* `script` -> references the script object, i.e. the thing you dragged into the hierarchy
* `script.parent` -> references the script's parent object, i.e. the item one level above the script (in this case the Manticoin object)
* `script.parent:rotate_continuous()` -> Every _CoreObject_ (things like Scripts, Objects, etc.) has methods available to it. `rotate_continuous` is one of these, and we invoke it with the `:` syntax. It requires a `Rotation` parameter to work
* `script.parent:rotate_continuous(Rotate.new(200, 0, 0))` -> Here we create a rotation vector to rotate by a pitch of 200, spinning the coin along the y axis by the requisite speed. Rotate is a _Core Class_ that has the method `.new`, which takes in parameters for the pitch, yaw, and roll. Since `.new` returns a `Rotation` (exactly what we need to pass in to `rotate_continuous`, it works out well.)

The above is a bit confusing, so let's rewrite it to be more clear

```lua
local coin = script.parent
local spin_rotation = Rotate.new(200, 0, 0)
coin:rotate_continuous(spin_rotation)
```

Yay, we've got it working!

Next, let's add an inventory system so you can pick up the coins. Then we'll spawn them all over the map, and will have a timer to pick them up in a limited time, making a game.

---

## Pick Up Coins

### Goal

Use the Trigger object to pick up the coin, and display the total of coins on the screen.

* Create a `Trigger` via Object -> Trigger
* Put that trigger as a child of the coin and adjust the hitbox via the scale so it is slightly larger than the coin
* Make a script called `PickupCoin` and put it as the child of the trigger
* Add the following to the script:

```lua
function handleOverlap(trigger, object)
	if (object ~= nil and object:is_a("Player")) then
        object:add_resource("Manticoin", 1)
        trigger.parent:destroy()
	end
end

script.parent.on_begin_overlap:connect(handleOverlap)
```

If you save and press play, you'll notice nothing seems to happen. Well that's because we have no output of the data. Let's modify TutorialScript to display this. Add the following code:

```lua
--print out 'Player name: Coin count' every 5 seconds
function tick()
	wait(5)

    local players = game:get_players()
    print_to_screen("Coins")
	for i = 1,#players do
		print_to_screen(players[i].name..": "..tostring(players[i]:get_resource("Manticoin") or 0))
	end

end
```

Now when you walk over the coin and away from it, you'll pick it up, and the amount will be displayed every 5 seconds.

Next up is to add a UI element instead of the messy `print_to_screen` we have now.

Go to Object -> UI Text Control. Put the Text Control object in a `Client Context` folder

!!! info
Client context simply means it will be unique to each client, the server doesn't care about it

Create a new script called `Display Coins` and add the following code

```lua
--Display the player's coin amounts

wait() --wait a tick for players to connect
local player = game:get_local_player()
ui.show_screen(player, "ProxyUI") --enable the UI elements

--every 0.1 seconds update the coin count
function tick()
    wait(0.1)

    local displayString = player.name..": "..tostring(player:get_resource("Manticoin") or 0)
    script.parent.text = displayString

end)
```

For reference, the folder structure should look like this: ![UIText](../../img/scripting/UIText.png)

Now let's make a simple map and populate it with coins, and add in the main gameplay loop of rounds.

## Map

Add your objects, put it in a static group (group allows you to grab one object and move all of them). Add a sky. Done.

## Game

Okay, now to populate the map with coins.

There are two main ways to go about this.

1) Manually populate
2) Write a script to automatically place items

For now we're going with #1, but know that #2 is an option too.

So make a folder called `Coins` and copy Manticoins to scatter them over the map (the shortcut of Ctr+W to duplicate may be helpful for this)

Now we will write a script to make the game round-based.

Create a script called `CoinGameLogic` and put it into the top of the scene. Here's the entire hierarchy at this point ![GameLogicHierarchy](../../img/scripting/GameLogicHierarchy.png)

