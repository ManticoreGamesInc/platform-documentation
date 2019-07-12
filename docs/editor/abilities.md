### Abstract

An ability is anything that the player can do themselves. 

Anytime that a player can do something more than just jump and crouch that should be added to a Core project as an ability. Abilities are how a creator can add functions that a player can activate, and these abilities can be anything. 

An ability could be to sprint, a dance emote, the opening of a hidden menu; an ability can be anything that ought to happen on a button press or at a certain moment, repeatedly.

!!! info
    Comparing with Unreal and other game engines, an ability is basically a fancier keyboard input. "Fancier" because it has events built-in that can be set at each phase of execution.

### The 4 Phases of an Ability

In Core, an ability is treated as 4 separate steps that happen immediately one right after another. This allows for distinctly different things to be programmed by a creator in each phase, creating a more complex overall ability.

The 4 different phases of an ability are:

- **Cast**
    - The wind-up time--this is the prep phase before the ability actually happens.

- **Execute**
    - The actual ability.
    - Whatever the ability is going to do, it happens at this moment.

- **Recovery**
    - Additional ability actions that aren’t part of the main action.

- **Cooldown**
    - The rest period after an ability is finished being cast, and cannot be cast again.


!!! info "Example"
    Try thinking of it like the casting of a magical spell:
    Cast: The witch charges up her spell, twirling her wand in the air in preparation.
    Execute: The witch flicks her wand, launching magic sparks at her enemy.
    Recovery: Out of breath from the power, the witch lowers her arm.
    Cooldown: The witch waits for her magic powers to return to her.

Once an ability is triggered to start, it cycles through Cast > Execute > Recovery > Cooldown. The amount of time that each phase lasts can be set in the code. These timings would be very different depending on the type of ability being created.

![Gabe's Graphic](/img/EditorManual/Abilities/Ability States.png)

To tie functionality to the different phases of an ability, Core uses Events. Each phase has an event that is activated at the very beginning of that phase. 

A created function can be connected to these events, using `:Connect(ability_name)`

Connecting functions to events in an ability is the main task to be done when creating an ability, and is what makes each one different and infinitely customizable.

!!! info "Possible Differences between Abilities"
    A magical spell might have a long cast time, whereas a punch would have a very short if not instant cast time.

### Tutorial

Adding an ability to a game does take a little bit of coding.


While most all of the coding is already done for you to cause an ability to happen, this code needs to be copied into your project so that you can make whatever custom changes you would like!


In this tutorial, we will be making a simple sprint ability that will use all 4 phases, but is very quick to create.

1. With Core open to a project, click on View > Script Generator to open the script generator.

2. The default should already be Ability, but if it is not, select Ability from the drop-down menu on the top right. You should see this fancy window:

![Script Generator](/img/EditorManual/Abilities/scriptGenerator.PNG)

3. We’re going to change some of the options at the top of this window.
    1. Change the **Ability Name** in the first box to ‘Sprint’. Notice how all the code in the window updates to say ‘Sprint’ instead of ‘MyAbility’.

    2. The **Input Binding** is which button this ability is tied to. This works on both keyboards and game controllers! In this case, change the drop-down menu to ‘`ability_feet`’.

    3. When making a simple running sprint, we don’t need to change the animation, but an animation can be chosen to play when an ability is executed.

    4. We’re going to make a fancy sprint that uses all 4 phases, but we still won’t need **On Interrupted** or **On Ready** for this case. Uncheck those boxes. 

4. Click the button ‘Create New Script’ to create a new script with all of this code.

!!! info "Example"
    Not all code from within the script generator is needed in every case, and Event Connects that you are not using do not need to be copied into your ability script.

5. Now we make our changes, but first is removing unneeded parts!

    1. Since we aren’t using an animation, the first thing we want to change is to remove the line that says ‘`ability.animation = “1hand_melee_slash_left”`’.


    2. To allow the player to always sprint when they activate this ability, we must change `ability.canBePrevented` to false.


    3. Towards the bottom, within `OnExecute_Sprint(ability)`, remove all 3 lines relating to `target_data`, as we won’t need this for sprinting.
        - This is how to access the hit or contacted object when creating an ability that affects the world or other players.



6. Now we have removed unnecessary parts of the code, and we need to change what happens in the functions at the bottom. These are what happens in each phase.

    1. Add the line ‘`ability.owner.walkSpeed = .5`’ to the OnCast_Sprint function. This will lower the speed of the player in the time before they start sprinting, to simulate building up energy.

    2. Add the line ‘`ability.owner.walkSpeed = 4`’ to the OnExecute_Sprint function. This will speed them up massively.

    3. Add the line ‘`ability.owner.walkSpeed = .5`’ to the OnRecovery_Sprint function. This simulates the player “catching their breath” after the run.

    4. Add the line ‘`ability.owner.walkSpeed = 1`’ to the OnCooldown_Sprint function to reset player speed back to normal.

!!! info "the print_to_screen lines"
    The functions for each phase come with a print_to_screen line for game testing and debugging purposes, and they can be useful, but feel free to remove them!

7. To change how long each phase lasts, change the durations to this:

```
ability.castPhaseSettings.duration = .7
ability.executePhaseSettings.duration = 3
ability.recoveryPhaseSettings.duration = 1
ability.cooldownPhaseSettings.duration = 2
```

8. We have nearly everything set up now--the only thing left is to actually assign the ability to a player.

There are many ways to do this (granting a new ability when an item is picked up) but in this case, we are going to give the player the ability as soon as the game starts so that they always have it.

Beneath all code this ability script so far, add this line:

`game.playerJoinedEvent:Connect(CreateAndGiveToPlayer_Sprint)`

This will connect the function that we made to the moment when a player joins the game, giving them the ability to sprint!

9. Make sure this new script is dragged into the Hierarchy, and hit play! Test out that crazy running speed.

This works great, but using print statements to tell which phase is active isn’t helpful. Luckily there is a UI element built exactly for abilities!

### UI Ability Button

Core has a UI element already built in that visually shows the transitions between each ability phase. 

![Ability Button](/img/EditorManual/Abilities/UnActivatedAbility.PNG)![Ability Button](/img/EditorManual/Abilities/CastAbility.PNG)![Ability Button](/img/EditorManual/Abilities/UnActivatedAbility.PNG)

To get this to work correctly, there are only three steps:

1. Drag an ability control from the View > UI Editor onto a canvas and rename that control to AbilityUI.
Or any name you like.

2. In the ability script that where the ability is created, get a reference to that ability control button.

`local abilityControl = game:FindObjectByName('AbilityUI')`

3. Within the `MakeAbility_Sprint()` function, add a line above the return statement to set the ability of the ability button.

`abilityControl.ability = ability`

This will automatically change the button displayed to what was assigned when the ability was created.


*Now the UI element will update automatically when the ability is cast!*

### Networking

Abilities themselves work in multiplayer games perfectly. What doesn't happen automatically is the updating of the UI--for this to work, the UI relating to the player's abilities must be placed in a Client Context folder. 

!!! info "Client Context"
    Generally speaking, all UI related to the player should be in a Client Context folder. For more info on how networking works, visit the [related page].

To get the job done, here is how to get Ability UI to display correctly in multiplayer games:

1. Within the UI Canvas, right click in the Hierarchy and create a New Client Context.

2. Create a new script, and drag this script into the Client Context folder.

4. Copy this code within the script:

```
local sprintUIControl = game:FindObjectByName('AbilityUI')

local playerAbilitiesAssigned = false

function Tick(deltaSeconds)
	local player = game:GetLocalPlayer()
	if (is_valid(player)) then
		if (not playerAbilitiesAssigned) then
			assign_abilities(player)
		end
	end
end

function assign_abilities(player)
	for _,ability in pairs(player:GetAbilities()) do
		if (ability.binding == "ability_feet") then
			sprintUIControl.ability = ability
		end
	end
end
```

Now the ability AND the ability's UI work in multiplayer games!

### Examples

*FAA_GameMode* includes functioning abilities. 
