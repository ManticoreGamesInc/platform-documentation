---
id: player_animations_sockets
name: Player Animations & Sockets
title: Player Animations & Sockets
tags:
    - API
    - Reference
---

# Player Animations & Sockets

In Core, all ability animations are valid on any of the available body types. Each of the ability animations timing and/or translation values should behave identically across the body types.
All ability animations have a long "tail" that gracefully transitions the character back to idle pose. This animation tail is intended to only be seen if the player does not execute any other ability or movement. In nearly all practical use cases, the ability animation tails will be interrupted to do other game mechanics.

!!! Note
    If the intent is to have an ability "execute" as quickly as possible after the button press, it is still generally a good idea to have a very small cast phase value (0.1 second or so). This will help with minor server/client latency issues and will also help to ensure smoother playback of character animations.

## Sockets

Sockets are different points on a player's character mesh. They can be used for attaching objects, controlling a ragdoll effect and more.

![!Sockets Overview](../img/sockets.jpg){: .center loading="lazy" }

| Left Body       | Center Body   | Right Body       |
| --------------- | ------------- | ---------------- |
| `left_clavicle` | `nameplate`   | `right_clavicle` |
| `left_shoulder` | `camera`      | `right_shoulder` |
| `left_elbow`    | `root`        | `right_elbow`    |
| `left_wrist`    | `head`        | `right_wrist`    |
| `left_prop`     | `neck`        | `right_prop`     |
| `left_hip`      | `upper_spine` | `right_hip`      |
| `left_knee`     | `lower_spine` | `right_knee`     |
| `left_ankle`    | `pelvis`      | `right_ankle`    |
| `left_arm_prop` |               |                  |

## Player Animations

### Unarmed

| Unarmed Animations            | Description | Notes |
| ----------------------------- | ------------------------------------------------------------------------------------ | ----- |
| `unarmed_thumb_up`            | Thumbs up!                                                                           | Currently does NOT support a variable cast phase time. Currently does NOT support a time-stretched execute phase time |
| `unarmed_thumb_down`          | Thumbs down!                                                                         | Currently does NOT support a variable cast phase time. Currently does NOT support a time-stretched execute phase time |
| `unarmed_rochambeau_rock`     | Rock, paper, scissors game. This chooses rock as the end result.                     | Currently does NOT support a variable cast phase time. Currently does NOT support a time-stretched execute phase time |
| `unarmed_rochambeau_paper`    | Rock, paper, scissors game. This chooses paper as the end result.                    | Currently does NOT support a variable cast phase time. Currently does NOT support a time-stretched execute phase time |
| `unarmed_rochambeau_scissors` | rock, paper, scissors game. This chooses scissors as the end result.                 | Currently does NOT support a variable cast phase time. Currently does NOT support a time-stretched execute phase time |
| `unarmed_magic_bolt`          | Magic casting animation which appears to launch a projectile forward from the hands. | Supports variable cast time. |
| `unarmed_magic_up`            | A magic casting animation that ends with the arms generally "up" (as opposed to forward. Generally useful for omnidirectional casting (traditional buff spells, heals. etc) and magic attacks that do not need or want a strong directional implication (casting a ground AoE spell would be a likely use case).                      | Supports variable cast time. |
| `unarmed_punch_left`          | A left punch animation.                                                              | Supports variable cast time. |
| `unarmed_punch_right`         | A right punch animation.                                                             | Supports variable cast time. |
| `unarmed_throw`               | An over-the-shoulder right-handed throw animation.                                   | Supports variable cast time. |
| `unarmed_wave`                | Stand in place and wave.                                                             | This animation works best with a cast phase duration of 0.266 or less. |
| `unarmed_pickup`              | Stand in place and pick up items from the ground.                                    | This animation works best with a cast phase duration of 0.266 or less. |
| `unarmed_kick_ball`           | A kick motion that moves the character forward as well.                              | This animation works best with a cast phase duration of 0.18 or less. This animation has root motion, and is designed to play full body. Controller/mouse rotation can affect the course of the kick by default, but this behavior can be changed in the ability script. |
| `unarmed_roll`                | A roll animation that moves the character forward.                                   | This animation works best with a cast phase duration of 0.18 or less. This animation has root motion, and is designed to play full body. |
| `unarmed_use`                 | A generic use item motion of fiddling with something held in the player's hands.     | Supports variable cast phase time. Does NOT support a time-stretched execute phase time. |
| `unarmed_use_bandage`         | The player wraps a bandage around their forearms.                                    | Supports variable cast phase time. Does NOT support a time-stretched execute phase time. |
| `unarmed_shove`               | A simple forward shove with both hands.                                              | Supports variable cast time. Supports time-stretched execute phase time. |
| `unarmed_flying_side_kick `   | A simple jump kick animation. | Supports variable cast phase time. Supports time-stretched execute phase time. |
| `unarmed_flying_reverse_roundhouse_kick ` | A jump kick that spins left to right.| Supports variable cast phase time. Supports time-stretched execute phase time. |
| `unarmed_drink`              | A drinking animation, useful for potion drinking abilities, etc. | Supports variable cast phase time. |
| `unarmed_eat`                | An eating animation. The character is taking a bite of something held in the right hand. | Supports variable cast phase time. |
| `unarmed_shout`              | A shout animation. The character shouts at the sky during cast loop, and directs a shout forward in the execute | Supports variable cast phase time. |
| `unarmed_stomp`              | A stomp animation. The cast loop holds the right foot in the air. | Supports variable cast phase time. |
| `unarmed_punch_right_flying_uppercut` | A jumping right uppercut punch. | Supports variable cast phase time. Supports time-stretched execute phase time.  |

### One-Hand

| One-Hand Melee Animations                    | Description | Notes |
| -------------------------------------------- | ----------- | ----- |
| `1hand_melee_shield_bash`                    | A bash attack using a shield on the left arm (assumes shield geometry attached to `left_arm_prop`) | Supports variable cast time. Supports time-stretched execute phase time. |
| `1hand_melee_slash_left`                     | A horizontal melee swing to the left. | Supports variable cast phase time. Supports time-stretched execute phase time. |
| `1hand_melee_slash_right`                    | A horizontal melee swing to the right. | Supports variable cast phase time. Supports time-stretched execute phase time. |
| `1hand_melee_slash_vertical`                 | An overhead vertical slash. | Supports variable cast time. Supports time-stretched execute phase time. |
| `1hand_melee_thrust`                         | A melee forward lunge attack. | Supports variable cast phase time. Supports time-stretched execute phase time. |
| `1hand_melee_unsheathe`                      | Pulls the one-handed melee weapon from a belt sheath. | works best with a cast phase duration of 0.31 or less. Currently does NOT support a variable cast phase time. Currently does NOT support a time-stretched execute phase time |
| `1hand_melee_rm_combo_opener_vertical_slash` | A one handed overhead slash. | This animation is intended to be the first attack in the one hand melee combo. However, it can be used in any order, or by itself. This animation does not have a looping cast animation. Does not scale with execution phase duration. Moves the player forward with root motion. |
| `1hand_melee_rm_combo_middle_diagonal_slash` | A one handed overhead slash from the upper left to bottom right. | This animation is intended to be the middle attack in the one hand melee combo. However, it can be used in any order, or by itself. This animation does not have a looping cast animation. Does not scale with execution phase duration. Moves the player forward with root motion. |
| `1hand_melee_rm_combo_closer_uppercut`       | A one handed weapon upward slash that takes the player slightly in the air. | This animation is intended to be the third attack in the one hand melee combo. However, it can be used in any order, or by itself. This animation does not have a looping cast animation. Does not scale with execution phase duration. Moves the player forward with root motion. |

| One-Hand Pistol Animations     | Description | Notes |
| ------------------------------ | ----------- | ----- |
| `1hand_pistol_shoot`           | A pistol shoot animation. | Supports variable cast time. |
| `1hand_pistol_unsheathe`       | Pulls the pistol from an invisible belt holster. | This animation works best with a cast phase duration of 0.21 or less. |
| `1hand_pistol_reload_magazine` | Reloads a bottom-loading pistol clip. | Supports variable cast time. |
| `1hand_pistol_whip` | A melee attack that uses the handle of the pistol. | Supports variable cast phase time. Supports time-stretched execute phase time.  |

### Two-Hand

| Two-Hand Melee Animations                    | Description | Notes |
| -------------------------------------------- | ----------- | ----- |
| `2hand_melee_dig_shovel`                     | A simple dig animation using a shovel. | Supports variable cast phase time. Supports time-stretched execute phase time. |
| `2hand_melee_rm_combo_closer_vertical_slash` | A spinning two handed melee attack that swings from top to bottom in a vertical line in front of the player. | This animation is intended to be the third attack in the two hand melee combo. However, it can be used in any order, or by itself. This animation does not have a looping cast animation. Does not scale with execution phase duration. Moves the player forward with root motion. |
| `2hand_melee_rm_combo_middle_vertical_slash` | A two handed melee attack that swings from top to bottom in a vertical line in front of the player. | This animation is intended to be the second attack in the two hand melee combo. However, it can be used in any order, or by itself. This animation does not have a looping cast animation. Does not scale with execution phase duration. Moves the player forward with root motion. |
| `2hand_melee_rm_combo_opener_diagonal_slash` | A two handed melee attack that swings from right to left in a diagonal line in front of the player. | This animation is intended to be the first attack in the two hand melee combo. However, it can be used in any order, or by itself. This animation does not have a looping cast animation. Does not scale with execution phase duration. Moves the player forward with root motion. |
| `2hand_melee_slash_right`                    | A horizontal melee swing to the right. | Supports variable cast phase time. Supports time-stretched execute phase time. |
| `2hand_melee_slash_vertical`                 | A downward melee swing. | Supports variable cast phase time. Supports time-stretched execute phase time. |

| Two-Hand Sword Animations | Description | Notes |
| ------------------------- | ----------- | ----- |
| `2hand_sword_slash_right` | A horizontal melee swing to the right. | Supports variable cast phase time. Supports time-stretched execute phase time. |
| `2hand_sword_slash_left`  | A horizontal melee swing to the left. | Supports variable cast phase time. Supports time-stretched execute phase time. |
| `2hand_sword_slash_spin`  | A spinning two handed sword attack that swings the sword from right to left horizontally.  | Supports variable cast phase time. Supports time-stretched execute phase time. |
| `2hand_sword_slash_vertical` | A downward melee swing. | Supports variable cast phase time. Supports time-stretched execute phase time. |
| `2hand_sword_thrust` | A forward sword thrust melee attack. | Supports variable cast phase time. Supports time-stretched execute phase time. |
| `2hand_sword_unsheathe` | Pulls the one-handed melee weapon from a belt sheath. | This animation works best with a cast phase duration of 0.31 or less. |
| `2hand_sword_rm_combo_opener_cone` | A two handed sword attack that swings from right to left in a horizontal cone in front of the player. | This animation is intended to be the first attack in the two hand sword combo. However, it can be used in any order, or by itself. This animation does not have a looping cast animation. Does not scale with execution phase duration. Moves the player forward with root motion. |
| `2hand_sword_rm_combo_middle_spin` | A two handed sword attack that pins from left to right horizontally, hitting targets in a 360 degree arc. | This animation is intended to be the second attack in the two hand sword combo  However, it can be used in any order, or by itself. This animation does not have a looping cast animation. Does not scale with execution phase duration. Moves the player forward with root motion. |
| `2hand_sword_rm_combo_closer_spin` | A two handed sword attack that swings from right to left in a horizontal cone in front of the player. | This animation is intended to be the third attack in the two hand sword combo. However, it can be used in any order, or by itself. This animation does not have a looping cast animation. Does not scale with execution phase duration. Moves the player forward with root motion. |

| Two-Hand Staff Animations                    | Description | Notes |
| -------------------------------------------- | ----------- | ----- |
| `2hand_staff_magic_bolt`                     | Magic casting animation which appears to launch a projectile forward from the staff. | Supports variable cast time. |
| `2hand_staff_magic_up`                       | Magic casting animation which raises the staff on cast. This animation is not direction specific. | Supports variable cast time. |
| `2hand_staff_rm_combo_opener_upward_slash`   | A two handed staff attack that swings the bottom of the staff upwards in front of the player. | This animation is intended to be the first attack in the two hand staff combo. However, it can be used in any order, or by itself. This animation does not have a looping cast animation. Does not scale with execution phase duration. Moves the player forward with root motion. |
| `2hand_staff_rm_combo_middle_thrust`         | A two handed staff attack thrusts the weapon far out in front of the player. | This animation is intended to be the second attack in the two hand sword combo. However, it can be used in any order, or by itself. This animation does not have a looping cast animation. Does not scale with execution phase duration. Moves the player forward with root motion. |
| `2hand_staff_rm_combo_closer_vertical_slash` | A two handed staff attack that slaps the weapon down vertically in front of the player. | This animation is intended to be the third attack in the two hand sword combo. However, it can be used in any order, or by itself. This animation does not have a looping cast animation. Does not scale with execution phase duration. Moves the player forward with root motion. |

| Two-Hand Rifle Animations      | Description | Notes |
| ------------------------------ | ----------- | ----- |
| `2hand_rifle_shoot`            | A rifle shoot animation. | Supports variable cast time. |
| `2hand_rifle_unsheathe`        | Pulls the rifle from a back scabbard. | This animation works best with a cast phase duration of 0.22 or less. |
| `2hand_rifle_reload_magazine`  | Reloads an automatic rifle magazine. | Supports variable cast time. |
| `2hand_rocket_reload_magazine` | A reload that works better for `over the shoulder` weapon geometry using the 2hand_rifle_stance and associated animations. | Supports variable cast time. |
| `2hand_rifle_butt` | A melee attack that uses the stock of the rifle. | Supports variable cast phase time. Supports time-stretched execute phase time.  |

### Dual Wield Melee

| Dual Wield Melee Animations         | Description                                                                    | Notes                                                                          |
| ----------------------------------- | ------------------------------------------------------------------------------ | ------------------------------------------------------------------------------ |
| `dual_melee_dual_thrust`            | A melee attack which uses both hands to thrust weapons forward simultaneously. | Supports variable cast phase time. Supports time-stretched execute phase time. |
| `dual_melee_left_hand_slash_left`   | A melee attack in which the left hand swings a weapon from left to right.      | Supports variable cast phase time. Supports time-stretched execute phase time. |
| `dual_melee_left_hand_slash_right`  | A melee attack in which the left hand swings a weapon from right to left.      | Supports variable cast phase time. Supports time-stretched execute phase time. |
| `dual_melee_left_hand_thrust`       | A melee attack in which the left hand thrusts a weapon forward.                | Supports variable cast phase time. Supports time-stretched execute phase time. |
| `dual_melee_right_hand_slash_left`  | A melee attack in which the right hand swings a weapon from left to right.     | Supports variable cast phase time. Supports time-stretched execute phase time. |
| `dual_melee_right_hand_slash_right` | A melee attack in which the right hand swings a weapon from right to left.     | Supports variable cast phase time. Supports time-stretched execute phase time. |
| `dual_melee_right_hand_thrust`      | A melee attack in which the right hand thrusts a weapon forward.               | Supports variable cast phase time. Supports time-stretched execute phase time. |
| `dual_melee_unsheathe`              | Pulls the weapons off the back.                                                | Supports variable cast phase time. Supports time-stretched execute phase time. |

## Animation Stances

- All animation stances are valid on either of the available body types.
- Each animation stance should behave identically across the body types (with regard to timing).
- All animation stances are (or end in) looping animations that can be played indefinitely
- No animation stances have root motion
- Each animation stance has custom blending behavior for what happens while moving (specified below)

### Unarmed

| Unarmed Stances              | Description |
| ---------------------------- | ----------- |
| `unarmed_stance`             | This will cause the Player to walk or stand with nothing being held in their hands. |
| `unarmed_carry_object_high`  | A one (right) handed carry animation with the arm raised to roughly eye level. Ideal for holding a torch up to see better, etc. When running/jumping, the right arm will retain the lifted arm pose. The left arm will inherit the animation underneath. This works best if the animation set is unarmed. This animation assumes the prop is attached to the right_prop socket. |
| `unarmed_carry_object_low`   | A one (right) handed carry animation with the arm at waist height. Ideal for holding a mug, potion, etc. When running/jumping, the right arm will retain the lifted arm pose. The left arm will inherit the animation underneath. This works best if the animation set is unarmed. This animation assumes the prop is attached to the right_prop socket. |
| `unarmed_carry_object_heavy` | A two handed carry animation with the arms in front of the body. When running/jumping etc., the entire upper body will retain the aiming pose. |
| `unarmed_carry_score_card`   | A two handed carry animation with the arms all the way extended above the head. Ideal for holding text signs, etc. When running/jumping etc., the entire upper body will retain the aiming pose. The attachment point for the card is the right prop, and it registers to the center of the bottom edge of the card/sign. It also assumes x forward. |
| `unarmed_sit_car_low`        | A full body animation that is sitting at ground level with arms up on a wheel. Ideal for driving a go-kart style vehicle When running/jumping etc., the entire body will retain the sitting pose. Currently cannot mix the lower body of this pose with other animation stances (holding a torch, etc). Ability animations, however, can be used. |
| `unarmed_death`              | A full body animation that is falling to the floor, face-up. The hips will end roughly on the spot where the game thinks the character is. Suggested to turn on ragdoll. |
| `unarmed_death_spin`         | A full body animation that spins 360 and then falls to the floor, face-up. The hips will end roughly on the spot where the game thinks the character is. |
| `unarmed_sit_chair_upright`  | A pose that will transition to a (looping) sitting position assuming a chair. For best results, create a "registration point" for the player by positioning and orienting the player so that they are facing directly away from the chair geometry, and in front of it (roughly 60 units from the direct center of the seat surface.) The seat surface should be around 0.5 meters higher than the player registration point. Collisions will likely have to be turned off on at least some of the chair geometry to align the player with the chair very closely. |
| `unarmed_sit_ground_crossed` | An animation that will transition to a (looping) sitting position on the ground. The character will maintain their general position as they sit. |
| `unarmed_sit_ground_ledge`   | An animation that will transition to a (looping) sitting position on the ground with legs dangling off an edge. For best results, create a `registration point` for the player by orienting the player directly toward the ledge, and positioning the player roughly 0.2 meters from the ledge. |
| `unarmed_steer_ship_wheel`   | This will cause the Player to stand with their arms out as if they were steering a ship using the helm (steering wheel) of a ship. |
| `unarmed_stun_dizzy`         | A looping animation that has the player swaying as if dizzy. This animation does not have root motion, and will not inhibit or influence player control unless specifically scripted to do so. |
| `unarmed_stun_electric`      | A looping animation that has the player tense and twitching as if being electrocuted. This animation does not have root motion, and will not inhibit or influence player control unless specifically scripted to do so. |
| `unarmed_dance_basic`        | A simple basic dance loop. |
| `unarmed_dance_party`        | A house party dance loop. |
| `unarmed_waiting`            | An animation which has the character check their watch once, and then goes into a loop of foot tapping. |
| `unarmed_idle_relaxed_look_around` | An alternate idle loop in which the player looks around. |
| `unarmed_browse_virtual_interface` | A looping animation that features the player looking at a virtual interface and swiping down at 1 second and swiping right at 4 seconds.  There are lua animation events on players for these moments which return the string "action."  There is also a corresponding vfx asset in the core catalog which has swiping behavior which can be used with this animation. |
| `unarmed_dance_basic_side_to_side` | A basic dance with the character swaying from side to side. |
| `unarmed_dance_basic_arm_swing` | A basic dance with the character swinging their arms. |
| `unarmed_dance_basic_head_bop` | A basic dance with the character holding their arms up and nodding their head to a beat. |

### One-Hand

| One-Hand Stances             | Description |
| ---------------------------- | ----------- |
| `1hand_melee_shield_block`   | An animation that has the left arm drawn up as if defensively holding a shield. Assume shield geometry is attached to `left_arm_prop.` |
| `1hand_melee_stance`         | This will cause the Player to walk or stand with the right hand posed to hold a one handed weapon, and the left arm is assumed to possibly have a shield. |
| `1hand_pistol_aim`           | A simple aiming pose for pistol. When running/jumping etc., the entire upper body will retain the aiming pose. |
| `1hand_pistol_stance`        | This will cause the Player to walk or stand with the right hand posed to hold a pistol. |

### Two-Hand

| Two-Hand Stances             | Description |
| ---------------------------- | ----------- |
| `2hand_melee_stance`         | This will cause the Player to walk or stand posed to hold a two handed weapon. |
| `2hand_sword_stance`         | This will cause the Player to walk or stand with the left and right hand posed to hold a two handed sword. |
| `2hand_staff_stance`         | This will cause the Player to walk or stand with the left and right hand posed to hold a two handed staff. |
| `2hand_rifle_stance`         | This will cause the Player to walk or stand with the left and right hand posed to hold a two handed rifle. |
| `2hand_rifle_aim_shoulder`   | Has the shoulder stock up to the shoulder. When running/jumping etc., the entire upper body will retain the aiming pose. |
| `2hand_rifle_aim_hip`        | Has the stock at the hip. When running/jumping etc., the entire upper body will retain the aiming pose. |
| `2hand_sword_ready`          | Has the sword held with both hands in front of the body. When running/jumping etc., the entire upper body will retain the ready pose. |
| `2hand_sword_block_high`     | Has the sword held with both hands in front of the body. When running/jumping etc., the entire upper body will retain the ready pose. |

### Dual Wield Melee

| Dual Wield Melee Stances | Description                                                                               |
| ------------------------ | ----------------------------------------------------------------------------------------- |
| `dual_melee_stance`      | This will cause the Player to walk or stand with both hands posed to hold a melee weapon. |
| `dual_melee_block_high`  | A stance that has both weapons held in front of the Player in a defensive pose.           |

## How to Turn on Ragdoll

If you want to turn on the [ragdoll](https://en.wikipedia.org/wiki/Ragdoll_physics) effect on players, use the following:

```lua
player.animationStance = "unarmed_death"
Task.Wait(0.9)
player:EnableRagdoll("lower_spine", .4)
player:EnableRagdoll("right_shoulder", .2)
player:EnableRagdoll("left_shoulder", .6)
player:EnableRagdoll("right_hip", .6)
player:EnableRagdoll("left_hip", .6)
```
