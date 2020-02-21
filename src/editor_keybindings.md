---
id: keybindings
name: Core Editor Key Bindings
title: Core Editor Key Bindings
categories:
    - Reference
---

<style>
    .md-typeset table:not([class]) tr td:first-child {
        width: auto;
    }

    .md-typeset table:not([class]) tr td:nth-child(2) {
        width: 20%;
    }
</style>

# Core Editor Key Bindings

## Editor Tabs

| **Operation**          | **Key**      | **Description**                                   | **Requirements / Context** |
| ---------------------- | ------------ | ------------------------------------------------- | -------------------------- |
| Open Hierarchy tab     | <kbd>H</kbd> | Opens Hierarchy (Selects It If Already Open)      | None                       |
| Open Properties tab    | <kbd>I</kbd> | Opens Properties (Selects It If Already Open)     | None                       |
| Open Core Content tab  | <kbd>M</kbd> | Opens Core Content (Selects If Already Open)      | None                       |
| Open Community Content | <kbd>K</kbd> | Opens Community Content (Selects If Already Open) | None                       |

## Editor Navigation

| **Operation**       | **Key**                   | **Key 2**                      | **Description**                               | **Requirements / Context** |
| ------------------- | ------------------------- | ------------------------------ | --------------------------------------------- | -------------------------- |
| Navigate Selections | <kbd>Arrow Keys</kbd>     |                                | Moves Selection Up / Down (Even Through Tabs) | None                       |
| Navigate Selection  | <kbd>Tab</kbd>            |                                | Go To Next Element In Editor Selection        | Viewport Not Active        |
| Main Menu           | <kbd>ESC</kbd>            | <kbd>CTRL</kbd> + <kbd>P</kbd> | Opens Pause Menu                              | None                       |

## Hierarchy Organization

| **Operation**         | **Key**      | **Key 2**       | **Key 3**        | **Description**                                   | **Requirements / Context** |
| --------------------- | ------------ | --------------- | ---------------- | ------------------------------------------------- | -------------------------- |
| Wrap Object in Group  | <kbd>G</kbd> | <kbd>CTRL</kbd> |                  | Create a Group Containing The Selected Objects    | Selection                  |
| Unwrap Grouped Object | <kbd>G</kbd> | <kbd>CTRL</kbd> | <kbd>SHIFT</kbd> | Remove a Folder / Group Without Deleting Children | Selection                  |
| Create New Folder     | <kbd>N</kbd> | <kbd>CTRL</kbd> |                  | Create a New Folder in the Hierarchy              | None                       |

## Viewport Movement

| **Operation**            | **Key**                           | **Key 2**                       | **Description**                                            | **Requirements / Context** |
| ------------------------ | --------------------------------- | ------------------------------- | ---------------------------------------------------------- | -------------------------- |
| Move in Editor           | Mouse Wheel (Hold) + Move         |                                 | Moves In 3D Space                                          | Viewport Active            |
| Move in Editor           | <kbd>RB</kbd> (Hold) + WASDQE           |                                 | QE = Up / Down, WASD = Normal                              | Viewport Active            |
| Move Forward / Backwards | Mouse Wheel                       | <kbd>ALT</kbd> + <kbd>RB</kbd> + Move | Moves Forwards And Backwards                               | Viewport Active            |
| Move Camera              | <kbd>RB</kbd> (Hold) + Move             |                                 | Aims Camera                                                | Viewport Active            |
| Orbit Camera             | <kbd>ALT</kbd> + <kbd>LB</kbd> Drag     |                                 | Pivots Camera Around Central Point                         | Viewport Active            |
| Orbit Last Selected      | <kbd>ALT</kbd> + <kbd>SHIFT</kbd> |                                 | Works Even After A Viewport Change                         | None                       |
| Pan Camera               | M-Click + Move                    |                                 | Moves Camera Perpendicular To View Direction               | Viewport Active            |
| Slow Movement            | <kbd>C</kbd> (Hold)                          |                                 | Hold To Slow Down Movement Rate                            | Viewport Active, Moving    |
| Drag Zoom                | <kbd>ALT</kbd> + <kbd>RB</kbd> Drag     |                                 | Zoom In And Out With Either Up / Down Or Left / Right Drag | Viewport Active            |
| Fast Movement            | <kbd>SHIFT</kbd> (Hold)           |                                 | Hold To Increase Movement Rate                             | Viewport Active, Moving    |

## Object Selection

| **Operation**                               | **Key**                          | **Description**       | **Requirements / Context** |
| ------------------------------------------- | ---------------------------------| --------------------- | -------------------------- |
| Selection Area                              | <kbd>LB</kbd> (Hold) + Move      | Creates Selection Box | Viewport Active            |
| Select / Deselect                           | <kbd>LB</kbd>                    | If Object over Cursor select it, otherwise Deselect All | Viewport Active |
| Select All                                  | <kbd>CTRL</kbd>                  | Select Everything in the Scene | None |                      |
| Add to Selection                            | <kbd>SHIFT</kbd> + <kbd>LB</kbd> | Adds Object to Selection, or Makes Already Selected Object the Current Pivot. | Selection |
| Add / Subtract from Selection               | <kbd>CTRL</kbd> + <kbd>LB</kbd>  | Adds or Removes Object from Current Selection                                 | Selection |
| Deselect All                                | <kbd>ESC</kbd>                   | Deselects All (same as <kbd>CTRL</kbd> + <kbd>P</kbd>)                                                                 | Selection  |
| Place Selected                              | <kbd>X</kbd>                     | Places Selected Asset at Cursor Location                                      | Asset Selected, Viewport Active |
| Place Selected Align Surface Normal         | <kbd>SHIFT</kbd> + <kbd>X</kbd>  | Places Selected Asset at Cursor Location, align up Vector with Cursor Raycast Normal, takes into account extra settings on Object Generator tab, like randomize scale/color, etc | Asset Selected, Viewport Active |
| Navigate Hierarchy                          | Up / Down                         | Selects Next / Previous Item in List | Viewport or Hierarchy Active |
| Navigate Child/Parent                       | Left / Right                            | Selects Parent or First Child, or Expands / Collapses Current Parent Node (group etc.) | Viewport or Hierarchy Active    |
| Expand / Collapse Recursive                 | <kbd>SHIFT</kbd> + <kbd>LB</kbd> |   Expand / Collapse Selected Item and Children Under It | On Expansion Arrow |

## New Objects

| **Operation**         | **Key**              | **Description**                                 | **Requirements / Context** |
| --------------------- | -------------------- | ----------------------------------------------- | -------------------------- |
| Create Spawn Point    | <kbd>0</kbd>         | Creates Spawn Point Object at Cursor Location   | Viewport Active            |
| Create UI Text        | <kbd>1</kbd>         | Creates UI Text Object                          | Viewport Active            |
| Create UI Stat Bar    | <kbd>2</kbd>         | Creates UI Stat Bar Object                      | Viewport Active            |
| Create Text Renderer  | <kbd>5</kbd>         | Creates Text Renderer Object at Cursor Location | Viewport Active            |
| Create Point Light    | <kbd>7</kbd>         | Creates Point Light Object at Cursor Location   | Viewport Active            |
| Create Spot Light     | <kbd>8</kbd>         | Creates Spot Light Object at Cursor Location    | Viewport Active            |
| Create Trigger        | <kbd>9</kbd>         | Creates Trigger Object at Cursor Location       | Viewport Active            |
| Create Equipment      | <kbd>Page Up</kbd>   | Creates Equipment Object at Cursor Location     | Viewport Active            |
| Create Weapon         | <kbd>Page Down</kbd> | Creates Weapon Object at Cursor Location        | Viewport Active            |
| Select / Edit Terrain | <kbd>L</kbd>         | Selects and Edits the Terrain                   | Viewport Active            |

## Toolbar

| **Operation**              | **Key**            | **Key 2**        | **Description**                              | **Requirements / Context** |
| -------------------------- | ------------------ | ---------------- | -------------------------------------------- | -------------------------- |
| Select Move Tool           | <kbd>W</kbd>       |                  | Selects Move Tool                            | None                       |
| Select Rotate Tool         | <kbd>E</kbd>       |                  | Selects Rotate Widget                        | None                       |
| Select Scale Tool          | <kbd>R</kbd>       |                  | Selects Scale Tool                           | None                       |
| Toggle Grid Snapping       | <kbd>G</kbd>       |                  | Enables or Disables Objects Snapping to Grid | None                       |
| Decrease Move Snap         | <kbd>\[</kbd>      |                  | Decrease Grid Snap Scale for Move Tool       | None                       |
| Increase Move Snap         | <kbd>]</kbd>       |                  | Increase Grid Snap Scale for Move Tool       | None                       |
| Decrease Rotate Snap       | <kbd>\[</kbd>      | <kbd>SHIFT</kbd> | Decrease Grid Snap Scale for Rotate Tool     | None                       |
| Increase Rotate Snap       | <kbd>]</kbd>       | <kbd>SHIFT</kbd> | Increase Grid Snap Scale for Rotate Tool     | None                       |
| Decrease Scale Snap        | <kbd>\[</kbd>      | <kbd>CTRL</kbd>  | Decrease Grid Snap Scale for Scale Tool      | None                       |
| Increase Scale Snap        | <kbd>]</kbd>       | <kbd>CTRL</kbd>  | Increase Grid Snap Scale for Scale Tool      | None                       |
| Toggle World / Local Space | <kbd>T</kbd>       |                  | Toggles Between Local and World Space        | None                       |

## Editor Misc

| **Operation**           | **Key**           | **Key 2**       | **Key 3**      | **Description**                                    | **Requirements / Context** |
| ----------------------- | ----------------- | --------------- | -------------- | -------------------------------------------------- | -------------------------- |
| Undo                    | <kbd>Z</kbd>      | <kbd>CTRL</kbd> |                | Undo Last Action                                   | None                       |
| Redo                    | <kbd>Y</kbd>      | <kbd>CTRL</kbd> |                | Redo Last Action                                   | None                       |
| Cut                     | <kbd>X</kbd>      | <kbd>CTRL</kbd> |                | Cut Selection from Scene and Add to Clipboard      | Selection                  |
| Copy                    | <kbd>C</kbd>      | <kbd>CTRL</kbd> |                | Copy Selection to Clipboard                        | Selection                  |
| Duplicate               | <kbd>W</kbd>      | <kbd>CTRL</kbd> |                | Duplicates Object                                  | Selection                  |
| Paste                   | <kbd>V</kbd>      | <kbd>CTRL</kbd> |                | Paste Selection                                    | Selection                  |
| Rename                  | <kbd>F2</kbd>     |                 |                | Rename Selected Object                             | Selection                  |
| Drop to Floor           | <kbd>End</kbd>    |                 |                | Drops Selection to Nearest Surface Below           | Selection                  |
| Toggle Gizmo Visibility | <kbd>V</kbd>      |                 |                | Enables or Disables Visibility of Gizmo Indicators | Viewport Open              |
| Copy MUID               | <kbd>C</kbd>      | <kbd>CTRL</kbd> | <kbd>ALT</kbd> | Copies MUID to Clipboard                           | Selection                  |
| Delete                  | <kbd>Delete</kbd> |                 |                | Deletes Object and Removes References to It        | Selection                  |

## Play Mode

| **Operation**    | **Key**        | **Description**                    | **Requirements / Context** |
| ---------------- | -------------- | ---------------------------------- | -------------------------- |
| Toggle Play Mode | <kbd>=</kbd>   | Start or Stop Preview Mode         | Viewport Open              |
| Stop Play Mode   | <kbd>ESC</kbd> | Cancels Play Mode (same as Equals) | Game Running in Edit Mode  |
| Pause Play       | <kbd>TAB</kbd> | Pauses Running Game                | Game Running in Edit Mode  |
| Pause Editor     | <kbd>ESC</kbd> | Brings up Pause Screen             | None                       |

## Save

| **Operation** | **Key**      | **Key 2**       | **Key 3**        | **Description**                          | **Requirements / Context** |
| ------------- | ------------ | --------------- | ---------------- | ---------------------------------------- | -------------------------- |
| Save Map      | <kbd>S</kbd> | <kbd>CTRL</kbd> |                  | Saves the Game or Current Script to Disk | None (or Selection)        |
| Save All      | <kbd>S</kbd> | <kbd>CTRL</kbd> | <kbd>SHIFT</kbd> | Saves Game and Modified Scripts to Disk  | None                       |

## Misc

| **Operation**         | **Key**         | **Description**                                                    | **Requirements / Context** |
| --------------------- | --------------- | ------------------------------------------------------------------ | -------------------------- |
| Terrain Brush Enlarge | <kbd>&gt;</kbd> | Increase Terrain Brush Size (+ <kbd>SHIFT</kbd> = Increase Faster) | Active Terrain Editing     |
| Terrain Brush Shrink  | <kbd>&lt;</kbd> | Decrease Terrain Brush Size (+ <kbd>SHIFT</kbd> = Decrease Faster) | Active Terrain Editing     |

## Text Editor

| **Operation**  | **Key**       | **Key 2**        | **Description**                           | **Requirements / Context** |
| -------------- | ------------- | ---------------- | ----------------------------------------- | -------------------------- |
| Find           | <kbd>F</kbd>  | <kbd>CTRL</kbd>  | Highlights Selection                      | In Text Editor             |
| Find Next      | <kbd>F3</kbd> |                  | When in Find, Selects Next Occurrence     | In Text Editor             |
| Find Previous  | <kbd>F3</kbd> | <kbd>SHIFT</kbd> | When in Find, Selects Previous Occurrence | In Text Editor             |
| Compile script | <kbd>F5</kbd> |                  | Compiles Script With Uncompiled Changes   | Script Open                |
