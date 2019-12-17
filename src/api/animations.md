### Animation

General Ability Animation Information

All Ability animations are valid on any of the available body types.
Each of the Ability animations timing and/or translation values should behave identically across the body types.
All Ability animations have a long "tail" that gracefully transitions the character back to idle pose. This animation tail is intended to only be seen if the Player does not execute any other Ability or movement. In nearly all practical use cases, the Ability animation tails will be interrupted to do other game mechanics.

!!! Note
    If the intent is to have an Ability "execute" as quickly as possible after the button press, it is still generally a good idea to have a very small cast phase value (0.1 second or so). This will help with minor server/client latency issues and will also help to ensure smoother playback of character animations.

#### Socket Names

Sockets are different points on a Player's character mesh. They can be used for attacking objects, controlling a ragdoll effect and more.

All socket names: root, pelvis, lower_spine, upper_spine, neck, head, right_hip, right_knee, right_ankle, left_hip, left_knee, left_ankle, right_clavicle, right_shoulder, right_elbow, right_wrist, right_prop, left_clavicle, left_shoulder, left_elbow, left_wrist left_arm_prop, left_prop, camera, nameplate.

#### 1hand_melee Strings

`1hand_melee_slash_left` - A horizontal melee swing to the left.

- This animation supports a variable cast phase time.
- This animation supports a time stretched execute phase time

`1hand_melee_slash_right` - A horizontal melee swing to the right.

- This animation supports a variable cast phase time.
- This animation supports a time stretched execute phase time

`1hand_melee_slash_vertical` - A downward melee swing.

- This animation supports a variable cast phase time.
- This animation supports a time stretched execute phase time

`1hand_melee_thrust` - A melee forward lunge attack..

- This animation supports a variable cast phase time.
- This animation supports a time stretched execute phase time

`1hand_melee_unsheathe` - Pulls the one-handed melee weapon from a belt sheath.

- works best with a cast phase duration of 0.31 or less
- currently does NOT support a variable cast phase time.
- currently does NOT support a time stretched execute phase time

#### 2hand_sword Strings

`2hand_sword_slash_left` - A horizontal melee swing to the left.

- This animation supports a variable cast phase time.
- This animation supports a time stretched execute phase time

`2hand_sword_slash_right` - A horizontal melee swing to the right.

- This animation supports a variable cast phase time.
- This animation supports a time stretched execute phase time

`2hand_sword_slash_vertical` - A downward melee swing.

- This animation supports a variable cast phase time.
- This animation supports a time stretched execute phase time

`2hand_sword_thrust` - A forward sword thrust melee attack.

`2hand_sword_unsheathe` - Pulls the one-handed melee weapon from a belt sheath.

- This animation works best with a cast phase duration of 0.31 or less

#### 2hand_staff Strings

`2hand_staff_magic_bolt` - Magic casting animation which appears to launch a projectile forward from the staff.

- This animation supports a variable cast time.

`2hand_staff_magic_up` - Magic casting animation which raises the staff on cast. This animation is not direction specific.

- This animation supports a variable cast time.

#### 1hand_pistol Strings

`1hand_pistol_shoot` - A pistol shoot animation.

- This animation supports a variable cast time.

`1hand_pistol_unsheathe` - Pulls the pistol from an invisible belt holster.

- This animation works best with a cast phase duration of 0.21 or less

`1hand_pistol_reload_magazine` - Reloads a bottom-loading pistol clip.

- This animation supports a variable cast time.

#### 2hand_rifle Strings

`2hand_rifle_shoot` - A rifle shoot animation.

- This animation supports a variable cast time.

`2hand_rifle_reload_magazine` - Reloads an automatic rifle magazine.

- This animation supports a variable cast time.

`2hand_rifle_unsheathe` - Pulls the rifle from a back scabbard.

- This animation works best with a cast phase duration of 0.22 or less

#### Unarmed Strings

`unarmed_thumbs_up` - thumbs up.

- currently does NOT support a variable cast phase time.
- currently does NOT support a time stretched execute phase time

`unarmed_thumbs_down` - thumbs down.

- currently does NOT support a variable cast phase time.
- currently does NOT support a time stretched execute phase time

`unarmed_rochambeau_rock` - rock, paper, scissors game. This chooses rock as the end result.

- currently does NOT support a variable cast phase time.
- currently does NOT support a time stretched execute phase time

`unarmed_rochambeau_paper` - rock, paper, scissors game. This chooses paper as the end result.

- currently does NOT support a variable cast phase time.
- currently does NOT support a time stretched execute phase time

`unarmed_rochambeau_scissors` - rock, paper, scissors game. This chooses scissors as the end result.

- currently does NOT support a variable cast phase time.
- currently does NOT support a time stretched execute phase time

`unarmed_magic_bolt` - Magic casting animation which appears to launch a projectile forward from the hands.

- This animation supports a variable cast time.

`unarmed_punch_left` - A left punch animation.

- This animation supports a variable cast time.

`unarmed_punch_right` - A right punch animation.

- This animation supports a variable cast time.

`unarmed_throw` - An over-the-shoulder right-handed throw animation.

- This animation supports a variable cast time.

`unarmed_wave` - Stand in place and wave.

- This animation works best with a cast phase duration of 0.266 or less.

`unarmed_pickup` - Stand in place and pick up items from the ground.

- This animation works best with a cast phase duration of 0.266 or less.

### General Animation Stance Information

- All animation stances are valid on either of the available body types.
- Each animation stance should behave identically across the body types (with regard to timing).
- All animation stances are (or end in) looping animations that can be played indefinitely
- No animation stances have root motion
- Each animation stance has custom blending behavior for what happens while moving (specified below)

### Animation Stance Strings

Animation Stance Strings

`unarmed_stance` - This will cause the Player to walk or stand with nothing being held in their hands.

`1hand_melee_stance` - This will cause the Player to walk or stand with the right hand posed to hold a one handed weapon, and the left arm is assumed to possibly have a shield.

`1hand_pistol_stance` - This will cause the Player to walk or stand with the right hand posed to hold a pistol.

`2hand_sword_stance` - This will cause the Player to walk or stand with the left and right hand posed to hold a two handed sword.

`2hand_staff_stance` - This will cause the Player to walk or stand with the left and right hand posed to hold a two handed staff.

`2hand_rifle_stance` - This will cause the Player to walk or stand with the left and right hand posed to hold a two handed rifle.

`2hand_rifle_aim_shoulder` - A simple aiming pose in 2hand_rifle set. Has the shoulder stock up to the shoulder.
When running/jumping etc, the entire upper body will retain the aiming pose.

`2hand_rifle_aim_hip` - A simple aiming pose in 2hand_rifle set. Has the stock at the hip.
When running/jumping etc, the entire upper body will retain the aiming pose.

`1hand_pistol_aim` - A simple aiming pose for pistol.
When running/jumping etc, the entire upper body will retain the aiming pose.

`2hand_sword_ready` - A simple ready pose 2hand_sword set. Has the sword held with both hands in front of the body.
When running/jumping etc, the entire upper body will retain the ready pose.

`2hand_sword_block_high` - A simple ready pose 2hand_sword set. Has the sword held with both hands in front of the body.
When running/jumping etc, the entire upper body will retain the ready pose.

`unarmed_carry_object_high` - A one (right) handed carry animation with the arm raised to roughly eye level. Ideal for holding a torch up to see better, etc
When running/jumping, the right arm will retain the lifted arm pose. The left arm will inherit the animation underneath. This works best if the animation set is unarmed.
This animation assumes the prop is attached to the right_prop socket.

`unarmed_carry_object_low` - A one (right) handed carry animation with the arm at waist height. Ideal for holding a mug, potion, etc
When running/jumping, the right arm will retain the lifted arm pose. The left arm will inherit the animation underneath. This works best if the animation set is unarmed.
This animation assumes the prop is attached to the right_prop socket.

`unarmed_carry_object_heavy` - A two handed carry animation with the arms in front of the body. When running/jumping etc, the entire upper body will retain the aiming pose.

`unarmed_carry_score_card` - A two handed carry animation with the arms all the way extended above the head. Ideal for holding text signs, etc. When running/jumping etc, the entire upper body will retain the aiming pose. The attachment point for the card is the right prop, and it registers to the center of the bottom edge of the card/sign. It also assumes x forward.

`unarmed_sit_car_low` - A full body animation that is sitting at ground level with arms up on a wheel. Ideal for driving a go-kart style vehicle
When running/jumping etc, the entire body will retain the sitting pose.
Currently cannot mix the lower body of this pose with other animation stances (holding a torch, etc). Ability animations, however, can be used.
<!--
`unarmed_sit_chair_upright` -
`unarmed_sit_ground_crossed` -
`unarmed_sit_ground_ledge` -
-->
`unarmed_death` - A full body animation that is falling to the floor, face-up. The hips will end roughly on the spot where the game thinks the character is. Suggested to turn on ragdoll.

`unarmed_death_spin` - A full body animation that spins 360 and then falls to the floor, face-up. The hips will end roughly on the spot where the game thinks the character is.

??? note "How to Turn on Ragdoll"
    ```lua
    player.animationStance = "unarmed_death"
    Task.Wait(0.9)
    player:EnableRagdoll("lower_spine", .4)
    player:EnableRagdoll("right_shoulder", .2)
    player:EnableRagdoll("left_shoulder", .6)
    player:EnableRagdoll("right_hip", .6)
    player:EnableRagdoll("left_hip", .6)

    ```
