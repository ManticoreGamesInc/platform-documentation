## Abstract

An ability is anything that the player can do themselves. 

Anytime that a player can do something more than just jump and crouch, that should be added to a Core project as an ability. Abilities are how a creator can add functions that a player can activate, and these abilities can be anything. 

An ability could be to sprint, a dance emote, the opening of a hidden menu; an ability can be anything that ought to happen on a button press or at a certain moment, repeatedly.

!!! info
    Comparing with Unreal and other game engines, an ability is basically a fancier keyboard input. "Fancier" because it has events built-in that can be set at each phase of execution.

![Dodge Roll](/src/img/EditorManual/Abilities/dodgeRoll.GIF)

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


!!! info "A More Natural Example"
    Try thinking of it like the casting of a magical spell:  
    Cast: The witch charges up her spell, twirling her wand in the air in preparation.  
    Execute: The witch flicks her wand, launching magic sparks at her enemy.  
    Recovery: Out of breath from the power, the witch lowers her arm.  
    Cooldown: The witch waits for her magic powers to return to her.  

Once an ability is triggered to start, it cycles through **Cast** > **Execute** > **Recovery** > **Cooldown**. The amount of time that each phase lasts can be set in the code. These timings would be very different depending on the type of ability being created.

![Ability States](/src/img/EditorManual/Abilities/Ability States.png)

To tie functionality to the different phases of an ability, Core uses **Events**. Each phase has an event that is activated at the very beginning of that phase. 

A created function can be connected to these events, using `:Connect(ability_name)` within a script.

Connecting functions to events in an ability is the main task to be done when creating an ability, and is what makes each one different and infinitely customizable.

!!! info "Customize Your Ability"
    A magical spell might have a long cast time, whereas a punch would have a very short if not instant cast time.

## Tutorial

Adding an ability to a game does take a little bit of coding. It's easier than you might think!

While most all of the coding is already done for you to cause an ability to happen, this code needs to be copied into your project so that you can make whatever custom changes you would like.

In this tutorial, we are going to make a super simple dodge roll!

### Generating the Script

1. With Core open to a project, click on View > Script Generator in the top menu bar to open the **Script Generator**.

2. The default selected script type should already be Ability, but if it is not, select Ability from the drop-down menu on the top left. You should see this fancy window:  
 ![Script Generator](/src/img/EditorManual/Abilities/scriptGenerator.PNG)

3. We’re going to change some of the options at the top of this window.
    1. Change the **Ability Name** in the first box to ‘Dodge’. Notice how all the code in the window updates to say ‘Dodge’ instead of ‘MyAbility’.

    2. The **Input Binding** is which button this ability is tied to. This works on both keyboards and game controllers! In this case, change the drop-down menu to "`ability_feet`".  
     For keyboards, this is the **shift** key.

    3. There is an animation already built-in for the player to dodge roll. Set the **Anim Names** drop-down menu to "`unarmed_roll`"

    4. Since we're making a simple dodge roll ability, we won’t need **On Interrupted** or **On Ready** for this case. Uncheck those boxes.  

         On Interrupted determines what happens when an ability is interupted by something in-game, and On Ready determines what happens when the ability finishes the cooldown phase and is ready to be activated again.  

         **Your Script Generator should now look like this:**

         ![Script Generator Set-UP](/src/img/EditorManual/Abilities/scriptGeneratorCorrect.PNG)

4. Click the button **Create New Script** to create a new script with all of this code. Name the script `AbilityScript`.

!!! info "Script Generator Calls"
    Not all code from within the script generator is needed in every case, and Event Connects that you are not using do not need to be copied into your ability script.

### Customizing the Code

1. Now we make our changes, but first is **removing unneeded parts**!

    2. Towards the bottom, within `OnExecute_Dodge(ability)`, remove all these lines relating to `target_data`, as we won’t need this for dodging:  
    ```python
    -- if requires_target_data is set on phase, can access target_data 
	-- for properties in target_data, see comment block below
	local targetData = ability:GetTargetData()
    ```  
     This is how to access the hit or contacted object when creating an ability that affects the world or other players.

    3. To allow the player to always be able to dodge roll when they activate this ability, we must change `ability.canBePrevented` to false.

    4. Since the dodge roll animation itself handles all movement, we don't need any code happening in the `OnCast_Dodge(ability)`, `OnExecute_Dodge(ability)`, `OnRecovery_Dodge(ability)`, or `OnCooldown_Dodge(ability)` functions.  

        You can remove all print statements from within these functions, or comment them out using `--`. Leaving these in can be helpful for seeing on-screen which phase you are in while the ability is active.

2. To **change how long each phase lasts**, change the durations to this:  
```
ability.castPhaseSettings.duration = .1
ability.executePhaseSettings.duration = 1
ability.recoveryPhaseSettings.duration = .1
ability.cooldownPhaseSettings.duration = 3
```

3. We have nearly everything set up now--the only thing left is to actually **assign the ability to a player**.  

    There are many ways to do this *(such as granting a new ability when an item is picked up)* but in this case, we are going to give the player the ability as soon as the game starts so that they always have it.  

    Beneath all code in this ability script so far, add this line:  

    `game.playerJoinedEvent:Connect(CreateAndGiveToPlayer_Dodge)`  

    This will connect the function that we made to the moment when a player joins the game, giving them the ability to dodge roll!

4. Make sure this **new script is dragged into the Hierarchy**, and hit play! Test out that mad rollin' action.  
 Remember that the **shift** key is what activates this ability since it uses the `ability_feet` input binding.

This works great, but using print statements to tell which phase is active isn’t great game design. Luckily there is a UI element we can use built exactly for abilities!

### CORE Component: Ability Display

A crucial part of a video game is the feedback it gives--players need to know that they're using an ability.

While you can make a User Interface *(often abbreviated to UI)* element yourself, there is a pre-made template on **Community Content** that we can use to very quickly set up simple UI for our new ability!

When the ability is in the Cooldown phase, it will darken the ability button and show the seconds remaining until the ability is usable again.

![Ability Display](/src/img/EditorManual/Abilities/abilityDisplay.GIF)

To get this to work correctly with the ability we made above, there are only a few steps steps:

1. In Community Content, search for the **CORE_Component_AbilityDisplay** template by jishnugirish, and add this to your project by clicking the blue plus icon.  
  ![Ability Control](/src/img/EditorManual/Abilities/CORE_Component_Ability.PNG)

2. Navigate through your **Project Content** to the **Imported Content** section, and drag the **green** component called **CORE_Component_AbilityBindingDisplay** into your Hierarchy.  

3. If you now click this template from in the hierarchy, the **Properties** tab will show a few custom properties that we need to change to set up the ability display.
  ![Ability Control](/src/img/EditorManual/Abilities/AbilityButtonProperties.PNG)  
      1. Change the **Binding** property from `ability_primary` to `ability_feet`. 

      2. Change the **Text** field to `LS`, to stand for Left Shift. 

      3. Uncheck the **HideName** property, so that "Dodge" will display over the button.  

      What is really the key here is the Binding property--this connects whatever ability is currently bound to that binding to the Ability Display.

4. To **change the icon that displays** from a fork & knife to something more relevant for our ability, navigate through the AbilityBindingDisplay folders in the Hierarchy to the two Icon objects. Change the **Image** property on these to whatever you would like!  
 ![Hierarchy](/src/img/EditorManual/Abilities/ComponentHierarchy.PNG)  
     I chose the **Icon Stamina** for this case. 

Now the UI element will update automatically once the ability is cast.

Congrats on creating your first ability! You are well on your way to making anything you can imagine a reality.

### Networking for Multiplayer Games

Abilities themselves work in multiplayer games perfectly without any extra programming effort. If you made your own ablity UI icon and did not use the Community Content template above, the UI will not update properly in multiplayer games. For the UI to update as the ability happens, the UI relating to the player's abilities must be placed in a Client Context folder. 

This has already been done for us in the Community Content template, so no action is needed!

!!! info "Client Context"
    Generally speaking, all UI related to the player should be in a Client Context folder. For more info on how networking works, visit the [related Networking page].

## Altering Properties the Easy Way: The Ability Object

As you may have noticed while doing the tutorial, there are all sorts of fun settings for you to customize in an ability. While some of this is handled in code, many of the options--also known as properties or parameters--can be changed from within one object that is kept in your project hierarchy.

This way you won't have to open a script to edit how your ability works!

An Ability Object can basically be thought of as a data structure, and in general is a way to keep track of how the ability works. It contains all the main parameters that you use for an ability, enabling you to make fast changes to how your ability works without having to open the scripts to go through code and change variables.

To create an Ability object, navigate to the menu tab **Object** and select **Create Ability**.

This spawns a single ability object in your project Hierarchy. On its own, it doesn't do anything--but that leads us into the next step of the tutorial!

## Examples

*FAA_GameMode* includes functioning abilities.  
*Spellshock* includes advanced abilities using ability objects. 