# Tutorial

## Prerequisites

Skim through the information in the [scripting](/scripting/overview) section before
continuing here.


## My First Script

### Creating the Script

1. Open up the editor and click the `+New Script` button
    * This will place a new script in the Asset Manifest
* Rename your script to `TutorialScript`
    * You can rename scripts by clicking on the name of the script in the Asset Manifest when it is selected (or by pressing `F2`)
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

---

## Functions

Let's change `TutorialScript` so the `print_to_screen` call is within a function. We'll call this function `init`, for simplicity.

```lua
-- Our first function!
function init()
    print_to_screen("Hello from a function!")
end
```

!!! note
    In case you've forgotten from the [Lua Primer](/scripting/lua_primer.md), putting `--` at the beginning of a line makes that line a comment, which is a line of code that isn't read by the computer. You don't have to include these lines, since they're just for leaving notes in your code for yourself and other humans.

If you save and run this code, nothing will happen. How utterly boring! This is because the function is never called in our code. To get our function to work, we can add a function call to the end of the script.

```lua
-- Calling the function
init()
```

You should now have the following:

```lua
-- Our first function!
function init()
    print_to_screen("Hello from a function!")
end

-- Calling the function
init()
```

***Now*** if you save and run this, you'll see your message appear on the screen! Excellent.

!!! note
    Lua prefers functions to be declared before they're called. In this tutorial, we'll make sure to keep all our function declarations at the top of files, like we did with `TutorialScript`.

If you are having issues, check to see if your `TutorialScript` looks like this in the Properties view:

![MyFirstScript](/img/scripting/MyFirstScript.png)

---

## Core API

The next step is to use the Core API to modify objects in the world. We'll start small, with a coin the player can pick up.

### Adding Manticoin

Luckily for you, the shared content houses many assets you can use in your own games to speed up production and cut down on the amount of work required by you. One of these assets is the `Manticoin`, which we'll use for this project, instead of making our own coin.

To add the `Manticoin` asset to your project, head over to the `Shared Content` tab inside the editor. Type "Manticoin" into the search bar, and click on the one by "max." All you have to do to add it to your project is to click the "Add to Project" button, which is a big plus (+).

!!! note
    The editor will prompt you to save before it adds it to your project.

Next, just like we did with TutorialScript, drag it from the Asset Manifest to the Hierarchy. Now that we have a coin in our world, our goal here is to get our coin to spin slowly in the air, rather than just sitting there being boring. The way to do this is, you guessed it, with a script.

### SpinCoin Script

Let's make a new script, call it `SpinCoin`, and put it one level below the main `Manticoin` object. Like before, delete the current contents, and add the following line of code:

```lua
script.parent:RotateContinuous(Rotation.New(200, 0, 0)) 
```

We'll explain what this line does in a moment, but for now, quickly make sure your `Manticoin` object looks similar to the following:

![SpinCoinLocation](/img/getting_started/SpinCoin.png)

Running this should continuously rotate the coin in the air. Shiny!

Okay, so what did we just do?

### Spin Breakdown

* `script` -> references the script object, i.e. the asset you dragged into the hierarchy
* `script.parent` -> references the script's parent object, i.e. the item one level above the script in the Hierarchy (in this case, the Manticoin object)
* `RotateContinuous()` -> Every **CoreObject** (things like Scripts, Objects, etc.) has methods available to it. `RotateContinuous` is one of these, and we invoke such a function with the `:` syntax. It requires a `Rotation` parameter to work
    * Methods are simply functions that belong to an object
* `Rotation.New(Number x, Number y, Number z)l)` -> Here, we create a vector to rotate the object on the x axis by 200, spinning the coin along the y axis by the requisite speed. `Rotation` is a **Core Class** that has the method `.New`, which takes in parameters for the x, y, and z. `.New` returns a `Rotation`, which is exactly what we need to pass in to `RotateContinuous()`. How convenient!

### Spin Cleanup

Writing all that in one line of code makes it a bit confusing, so let's rewrite it to be more clear and explicit.

```lua
-- Get the object one level above the script in the hierarchy, in this case our coin
local coin = script.parent
-- Create a rotation along the x axis
local spinRotation = Rotation.New(200, 0, 0)
-- Rotate the coin using our previously defined rotation
coin:RotateContinuous(spinRotation)
```

Yay, we've got it working! Now if only we could collect these coins...

---

## Picking Up Coins

### Adding a Trigger

1. Create a `Trigger` via Object -> Create Sphere Trigger
* Resize the trigger to match the coin's size 
    * Select the `Trigger` in the hierarchy and press `R` to change to scale mode. Drag the handles to adjust the scale
    * Press V to toggle gizmo visibility, including the `Trigger` hitbox
* Parent the Manticoin under the Sphere Trigger
    * Press W to change to Translation mode. Drag the upward handle to move the trigger (along with its children) higher together.

### Handling Triggers

Let's make a script called `PickupCoin` and place it as the child of the trigger. Delete the script's current code and add the following:

```lua
-- When a player hits the coin, increment a resource on the player and remove the coin
function handleOverlap(trigger, object)
	if (object ~= nil and object:IsA("Player")) then
        object:AddResource("Manticoin", 1)
        trigger:Destroy()
	end
end
```

This function takes in the `trigger` that was activated and the `object` that collided with it. We first check to make sure that the object is not `nil` and that it is a `Player`. If it is a `Player`, we add a `Resource` to it. A resource is simply a key-value structure to assign data to the player; in our case, we simply increase the amount of the "Manticoin" resources on the player by one. Finally, we use `:Destroy()` to remove the trigger (and all its children) from the game.

We still have one more line of code to assign `handleOverlap` to the trigger.

```lua
-- Whenever an object collides with the trigger, run this function
script.parent.beginOverlapEvent:Connect(handleOverlap)
```

`beginOverlapEvent` is an event that exists within Trigger objects. By using `:Connect()` in the code above, we are able to let the event know about the function to call, in this case `handleOverlap`, when the event gets executed.

Lastly, enable networking on the trigger (click yes on the dialogue box to enable networking on all the trigger's children). This enables interaction between the player on their client and the coin on the server.  
If you save and press Play, you'll notice that while the coin disappears now on contact! However, nothing else seems to happen. This is because we aren't displaying anything to the player.

### Displaying Coin Count

Let's modify `TutorialScript` to display this info. Add the following code:

```lua
-- Print out 'Player name: {coin count}' every 5 seconds
function Tick()
    Task.Wait(5)
    local players = game:GetPlayers()
    local numPlayers = #players
    for i = 1, numPlayers do
        local numCoins = players[i]:GetResource("Manticoin")
        print_to_screen(players[i].name..": "..tostring(numCoins or 0))
    end
end
```

!!! note
    You can delete what we previously had in `TutorialScript` if you'd like.

Now when you walk over the coin, you'll pick it up, and the amount will be displayed every 5 seconds. The `for` loop will show the score of each `Player`, since Core comes equipped with multiplayer functionality right out of the box.

Next up is to add a UI element to display this information instead of the bland `print_to_screen` call we have now.

---

## Using UI Objects

UI Objects are 2D elements that can be used to show Heads Up Displays (HUD), buttons, and messages to the player. We can leverage these instead of `print_to_screen` to have more control over what the user sees.

### Creating a UI Text

1. In order to use UI elements, we need a UI Canvas. This can be found in Object -> 2D UI... -> Create UI Canvas
* Right click in the Hierarchy, hover over 'Creat Network Context' and create a `Client Context`
* Make the `Client Context` a child of the UI Canvas
* Go to Object -> 2D UI... -> Create UI Text
* Move the Text Control in the Hierarchy so it's a child of the `Client Context`
* Rename the Text Control to  `Player Currency`

!!! info
    While visually similar in the Hierarchy, Client Context is different from a folder - the easiest way to think about it is that its contents will be unique to each player's client. In other words, the server doesn't care about it. 

### Updating UI Text

Create a new script called `DisplayCoins` and add the following code:

```lua
-- Display the player's coin amount

Task.Wait()  -- Wait a tick for players to connect
local player = game:GetLocalPlayer()

-- Every 0.1 seconds update the coin count display
function Tick()
    Task.Wait(0.1)
    local score = player:GetResource("Manticoin")
    local displayString = player.name..": "..tostring(score or 0)
    script.parent.text = displayString
end

--[
    Note: For performance we'd ideally write code that only updates the
    UI when the coin count changes, but this example favors simple code
    over robust systems
--]
```

!!! note
    Calling `Task.Wait()` without sending in an argument will default to a single tick

Now that we have the code to display it, let's add `DisplayCoins` as a child of the Text Control. The folder structure at this point should look like this:

![UIText](/img/getting_started/UIText.png)

Feel free to play around and customize how the Text Control looks. Using UI is a fantastic way to give your game a unique and professional feel.

Now let's make a simple map and populate it with coins.

---

## Map

So far, we've worked on Objects, Triggers, and UI. Let's switch gears and spice up our map a bit!

* Create the player's spawn point
    * From the navigation bar, try Object -> Gameplay -> Create Spawn Point
    * Alternatively, use the shortcut "0"!
    * Remember you can toggle gizmo visibility by pressing V.

* Add a Sky 
    * Search in Shared Content for any "Sky" 
    * Hit the plus button to add it to your project
    * Drag it from the Asset Manifest to the Hierarchy.

Alright, beautiful! 

## Win State

### Generating Coins

Okay, now to populate the map with coins. Right-click within the hierarchy to make a folder called `Coins` and add the `Manticoin` object as a child. 
Copy Manticoins to scatter them over the map (hint: the shortcut of CTRL + W to duplicate may be helpful).

Organization is important in your hierarchy. You can put objects together via folders or grouping!   

!!! note
    Folders and groups are very similar, but have one huge distinction: folders treat their children as independent objects, whereas a group will treat them as part of a larger whole. Trying to select a single object in a group will select the entire group, making _all_ items in the group be modified by any changes you make.

Now we will write a script to make the game round-based.

### Game Logic Script

Here we go! Create a script called `CoinGameLogic`. 

Let's also create a Replicator underneath that by right-clicking within the hierarchy.
Replicators let you communicate between the server and client. Think of them as containing universal variables, their values accessible anywhere.  

Next, create a boolean parameter called "gameOver" under the Replicator. Leave this unchecked, like default.  

* Create a Replicator
* Create a parameter for the Replicator
    * Select boolean as the parameter type
    * Name the parameter "gameOver"

Here's the entire hierarchy at this point:

![GameLogicHierarchy](/img/getting_started/GameLogicHierarchy.png)

!!! note
    The order of items in the Hierarchy is the order in which they'll be executed. Scripts dealing with game logic are best placed at the top!

Let's make a new script for game logic. Add the following code to `CoinGameLogic`:

```lua

-- Get the folder containing all the coin objects
local coinFolder = game:FindObjectByName("Coins")

-- Every second check for how many coins are left in the scene
function Tick()
	Task.Wait(1)
	local coinsLeft = #coinFolder:GetChildren()
    if (coinsLeft == 0) then 
	    game:FindObjectByName("Replicator"):SetValue("gameOver", true)
    end
end
```

`game:FindObjectByName()` searches the hierarchy for the object with the name passed in. The first time we use it to find `coinFolder`. We then look at how many coins are left by seeing how full the folder of coins in the hierarchy is (`:GetChildren()` returns the child elements, and `#` checks the length of the array, which is the number of objects the folder contains). 

When there are zero coins left, we find the replicator and set the value of "gameOver" to true. This way, all the players' clients will be able to know when the game is finished!   

### Victory UI

We are going to update the game when all the possible coins are picked up. First, we'll need a new Text Control which we'll name `VictoryUI` which will only show up when the game is over, alerting the player all coins have been collected. 
After designing the Victory UI, we'll want to hide it until it's the appropriate time. 

* Create a Text Control named 'VictoryUI' as child of the Canvas under 'Client Context'
* In the text field in the Properties window, type "All coins found!" 
* Toggle the visibility of the Victory UI under Properties, Scene > Visible
* Customize your font color, size, and justification!
    
Now, let's make a script called "DisplayUI" that makes the Victory UI visible at the end of the game!
We will parent this script underneath the "Victory UI".

Let's add a parameter to our newly created script "DisplayUI". 
This time, a CoreObject Reference so we can access our Replicator. Drag the Replicator from the hierarchy into the input field. 

```lua
ui = script.parent

local function OnChanged(rep, key)
	gameOver = rep:GetValue("gameOver")
    if (gameOver == true) then
	    ui.isVisible = true 
    else 
    	ui.isVisible = false 
    end
end

local rep = script:GetCustomProperty("Replicator"):WaitForObject()
rep.valueChangedEvent:Connect(OnChanged)
```

![Replicator](/img/getting_started/Replicator.png)

Your hierarchy should look like above now! 

If you press play and collect all the coins in the scene, your victory UI should now appear. 
Congrats on your first game! :)

## Reset

Lastly, let's add in the logic to reset the map (i.e. add the coins back) after they all have been picked up.

Currently we are deleting the coins when they are picked up. We could spawn in new coins at the old locations, but that would involve storing references to the old locations, which adds a bunch of boilerplate code. Sometimes you need to rewrite code as your game changes, and that's exactly what we're going to do!

An easier solution would be to just hide the coins from the map when they are picked up, and then un-hide them when resetting the map. Fortunately, this is not only a simple thing to do in Core, but is a very quick change.

### Resetting Coins

Open up the `PickupCoin` script, and change the line of `trigger:Destroy()` to `trigger.isEnabled = false`. This will make it so that when we collide, instead of destroying the `Manticoin`, it disables it. Disabling an object makes it basically not present in the scene. The two biggest things for us is that it disables the collision and visibility, so players won't be able to collide with it or see it after it's been collected.

Next, create a UI element to display information when the round resets. We'll call it `RoundUI` and make it a sibling of `CUI` (in other words, set it as a child of your `Client Context`). Like `CoinUI`, let's set the Text property to be blank by default (we'll add text to it later programatically).

The last step is to add the resetting logic to our main `CoinGameLogic` script.

Next we need to add the logic to reset the map, which for us simply means looping through all the coins and setting their `.enabled` property to be true. The logic will be quite similar to getting the coin count. Here it is as a function:

```lua
-- Set all coins to be enabled
function ResetMap()
	for _,coin in pairs(coinFolder:GetChildren()) do
		if coin ~= nil then
			coin.isEnabled = true
		end
	end
end
```

### Updating Coins Left Detection

You might notice that our old code for checking the number of coins left won't work anymore, as we are setting a property on each of the coins (`.isEnabled`) rather than deleting the object entirely. Add the following function to CoinGameLogic:

```lua
-- Get the amount of coins that are enabled in the scene
function GetCoinsLeft()
    local count = 0
    for _,coin in pairs(coinFolder:GetChildren()) do
        if coin ~= nil and coin.isEnabled then
            count = count + 1
        end
    end
    return count
end
```

This function will return how many coins are left. All that's left to do is to add these function calls to our main tick loop and update the UI, and we'll be done!

### Connecting all the Reset Code

```lua
-- Check the number of enabled coins
-- If the game should end, send a message through the replicator
-- Cue a new round to start
-- Reset the coins and UI 

function Tick()
	Task.Wait(1)
	local coinsLeft = GetCoinsLeft()
	if coinsLeft == 0 then
	    game:FindObjectByName("Replicator"):SetValue("gameOver", true)
		for i = 3,0,-1 do
			Task.Wait(1)
			print_to_screen("New round in "..tostring(i).." seconds")
		end
	    game:FindObjectByName("Replicator"):SetValue("gameOver", false)
		ResetMap()
	end
end
```

And there we go! We have a complete game!

## Conclusion

Finally, you can check out the game by going [here](https://staging.manticoreplatform.com/games/bb1a7a2d59f44215af1586007dae23d6) and clicking on 'edit' to download a copy of the game to play around with yourself!


