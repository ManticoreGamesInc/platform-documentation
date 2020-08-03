---
id: keybindings
name: Core Editor Key Bindings
title: Core Editor Key Bindings
tags:
    - Reference
---

<style>
    .md-typeset table:not([class]) tr td:first-child {
        width: auto;
    }

    table > thead > tr > th:nth-child(3),
    .md-typeset table:not([class]) tr td:nth-child(2) {
        width: 25%;
    }
</style>

# Core Editor Key Bindings

## Editor Tabs

| **Operation**          | **Key** | **Description**                                   | **Requirements / Context** |
| ---------------------- | --------| ------------------------------------------------- | -------------------------- |
| Open Hierarchy tab     | ++H++   | Opens Hierarchy (Selects It If Already Open)      | None                       |
| Open Properties tab    | ++I++   | Opens Properties (Selects It If Already Open)     | None                       |
| Open Core Content tab  | ++M++   | Opens Core Content (Selects If Already Open)      | None                       |
| Open Community Content | ++K++   | Opens Community Content (Selects If Already Open) | None                       |

## Editor Navigation

| **Operation**       | **Key**            | **Key 2**  | **Description**                               | **Requirements / Context** |
| ------------------- | ------------------ | ---------- | --------------------------------------------- | -------------------------- |
| Navigate Selections | ++Arrow-Up++ ++Arrow-Down++ ++Arrow-Left++ ++Arrow-Right++ | | Moves Selection Up / Down (Even Through Tabs) | None |
| Navigate Selection  | ++tab++            |            | Go To Next Element In Editor Selection        | Viewport Not Active        |
| Main Menu           | ++escape++         | ++ctrl+P++ | Opens Pause Menu                              | None                       |

## Hierarchy Organization

| **Operation**         | **Key** | **Key 2** | **Key 3** | **Description**                                   | **Requirements / Context** |
| --------------------- | ------- | --------- | --------- | ------------------------------------------------- | -------------------------- |
| Wrap Object in Group  | ++G++   | ++ctrl++  |           | Create a Group Containing The Selected Objects    | Selection                  |
| Unwrap Grouped Object | ++G++   | ++ctrl++  | ++shift++ | Remove a Folder / Group Without Deleting Children | Selection                  |
| Create New Folder     | ++N++   | ++ctrl++  |           | Create a New Folder in the Hierarchy              | None                       |

## Viewport Movement

| **Operation**            | **Key**              | **Key 2**            | **Description**                                            | **Requirements / Context** |
| ------------------------ | -------------------- | ---------------------| ---------------------------------------------------------- | -------------------------- |
| Move in Editor           | ++middle-button++    |                      | Drag to Move In 3D Space                                   | Viewport Active            |
| Move in Editor           | ++right-button++     |                      | Hold to Move In 3D Space - QE = Up / Down, WASD = Normal   | Viewport Active            |
| Move Forward / Backwards | ++middle-button++    | ++alt+right-button++ | Moves Forwards And Backwards                               | Viewport Active            |
| Move Camera              | ++right-button++     |                      | Hold to Move the Camera Instead of the Character           | Viewport Active            |
| Orbit Camera             | ++alt+left-button++  |                      | Hold and then Drag to Pivot Camera Around Central Point    | Viewport Active            |
| Orbit Last Selected      | ++alt+shift++        |                      | Works Even After A Viewport Change                         | None                       |
| Pan Camera               | ++middle-button++    |                      | Hold to Move The Camera Perpendicular To View Direction    | Viewport Active            |
| Slow Movement            | ++C++                |                      | Hold To Slow Down Movement Rate                            | Viewport Active, Moving    |
| Drag Zoom                | ++alt+right-button++ |                      | Hold to Zoom In And Out - Up / Down Or Left / Right Drag   | Viewport Active            |
| Fast Movement            | ++shift++            |                      | Hold To Increase Movement Rate                             | Viewport Active, Moving    |

## Object Selection

| **Operation**                       | **Key**                          | **Description**       | **Requirements / Context** |
| ----------------------------------- | ---------------------------------| --------------------- | -------------------------- |
| Selection Area                      | ++left-button++                  | Creates Selection Box | Viewport Active            |
| Select / Deselect                   | ++left-button++                  | If Object over Cursor select it, otherwise Deselect All | Viewport Active |
| Select All                          | ++ctrl++                         | Select Everything in the Scene | None |                      |
| Add to Selection                    | ++shift+left-button++            | Adds Object to Selection, or Makes Already Selected Object the Current Pivot. | Selection |
| Add / Subtract from Selection       | ++ctrl+left-button++             | Adds or Removes Object from Current Selection                                 | Selection |
| Deselect All                        | ++esc++                          | Deselects All (same as ++ctrl+P++)                                                                 | Selection  |
| Place Selected                      | ++X++                            | Places Selected Asset at Cursor Location                                      | Asset Selected, Viewport Active |
| Place Selected Align Surface Normal | ++shift+X++                      | Places Selected Asset at Cursor Location, align up Vector with Cursor Raycast Normal, takes into account extra settings on Object Generator tab, like randomize scale/color, etc | Asset Selected, Viewport Active |
| Navigate Hierarchy                  | ++Arrow-Up++ ++Arrow-Down++    | Selects Next / Previous Item in List | Viewport or Hierarchy Active |
| Navigate Child/Parent               | ++Arrow-Left++ ++Arrow-Right++ | Selects Parent or First Child, or Expands / Collapses Current Parent Node (group etc.) | Viewport or Hierarchy Active    |
| Expand / Collapse Recursive         | ++shift+left-button++            |   Expand / Collapse Selected Item and Children Under It | On Expansion Arrow |

## New Objects

| **Operation**         | **Key**       | **Description**                                 | **Requirements / Context** |
| --------------------- | --------------| ----------------------------------------------- | -------------------------- |
| Create Spawn Point    | ++0++         | Creates Spawn Point Object at Cursor Location   | Viewport Active            |
| Create UI Text        | ++1++         | Creates UI Text Object                          | Viewport Active            |
| Create UI Stat Bar    | ++2++         | Creates UI Stat Bar Object                      | Viewport Active            |
| Create Text Renderer  | ++5++         | Creates Text Renderer Object at Cursor Location | Viewport Active            |
| Create Point Light    | ++7++         | Creates Point Light Object at Cursor Location   | Viewport Active            |
| Create Spot Light     | ++8++         | Creates Spot Light Object at Cursor Location    | Viewport Active            |
| Create Trigger        | ++9++         | Creates Trigger Object at Cursor Location       | Viewport Active            |
| Create Equipment      | ++Page-Up++   | Creates Equipment Object at Cursor Location     | Viewport Active            |
| Create Weapon         | ++Page-Down++ | Creates Weapon Object at Cursor Location        | Viewport Active            |
| Select / Edit Terrain | ++L++         | Selects and Edits the Terrain                   | Viewport Active            |

## Toolbar

| **Operation**              | **Key**           | **Key 2** | **Description**                              | **Requirements / Context** |
| -------------------------- | ----------------- | --------- | -------------------------------------------- | -------------------------- |
| Select Move Tool           | ++W++             |           | Selects Move Tool                            | None                       |
| Select Rotate Tool         | ++E++             |           | Selects Rotate Widget                        | None                       |
| Select Scale Tool          | ++R++             |           | Selects Scale Tool                           | None                       |
| Toggle Grid Snapping       | ++G++             |           | Enables or Disables Objects Snapping to Grid | None                       |
| Decrease Move Snap         | ++open-bracket++  |           | Decrease Grid Snap Scale for Move Tool       | None                       |
| Increase Move Snap         | ++close-bracket++ |           | Increase Grid Snap Scale for Move Tool       | None                       |
| Decrease Rotate Snap       | ++open-bracket++  | ++shift++ | Decrease Grid Snap Scale for Rotate Tool     | None                       |
| Increase Rotate Snap       | ++close-bracket++ | ++shift++ | Increase Grid Snap Scale for Rotate Tool     | None                       |
| Decrease Scale Snap        | ++open-bracket++  | ++ctrl++  | Decrease Grid Snap Scale for Scale Tool      | None                       |
| Increase Scale Snap        | ++close-bracket++ | ++ctrl++  | Increase Grid Snap Scale for Scale Tool      | None                       |
| Toggle World / Local Space | ++T++             |           | Toggles Between Local and World Space        | None                       |

## Editor Misc

| **Operation**           | **Key**    | **Key 2** | **Key 3** | **Description**                                    | **Requirements / Context** |
| ----------------------- | ---------- | --------- | --------- | -------------------------------------------------- | -------------------------- |
| Undo                    | ++Z++      | ++ctrl++  |           | Undo Last Action                                   | None                       |
| Redo                    | ++Y++      | ++ctrl++  |           | Redo Last Action                                   | None                       |
| Cut                     | ++X++      | ++ctrl++  |           | Cut Selection from Scene and Add to Clipboard      | Selection                  |
| Copy                    | ++C++      | ++ctrl++  |           | Copy Selection to Clipboard                        | Selection                  |
| Duplicate               | ++W++      | ++ctrl++  |           | Duplicates Object                                  | Selection                  |
| Paste                   | ++V++      | ++ctrl++  |           | Paste Selection                                    | Selection                  |
| Rename                  | ++F2++     |           |           | Rename Selected Object                             | Selection                  |
| Drop to Floor           | ++end++    |           |           | Drops Selection to Nearest Surface Below           | Selection                  |
| Toggle Gizmo Visibility | ++V++      |           |           | Enables or Disables Visibility of Gizmo Indicators | Viewport Open              |
| Copy MUID               | ++C++      | ++ctrl++  | ++alt++   | Copies MUID to Clipboard                           | Selection                  |
| Delete                  | ++Delete++ |           |           | Deletes Object and Removes References to It        | Selection                  |

## Play Mode

| **Operation**    | **Key**   | **Description**                    | **Requirements / Context** |
| ---------------- | --------- | ---------------------------------- | -------------------------- |
| Toggle Play Mode | ++equal++ | Start or Stop Preview Mode         | Viewport Open              |
| Stop Play Mode   | ++esc++   | Cancels Play Mode (same as Equals) | Game Running in Edit Mode  |
| Pause Play       | ++tab++   | Pauses Running Game                | Game Running in Edit Mode  |
| Pause Editor     | ++esc++   | Brings up Pause Screen             | None                       |

## Save

| **Operation** | **Key** | **Key 2** | **Key 3** | **Description**                          | **Requirements / Context** |
| ------------- | ------- | --------- | --------- | ---------------------------------------- | -------------------------- |
| Save Map      | ++S++   | ++ctrl++  |           | Saves the Game or Current Script to Disk | None (or Selection)        |
| Save All      | ++S++   | ++ctrl++  | ++shift++ | Saves Game and Modified Scripts to Disk  | None                       |

## Misc

| **Operation**         | **Key** | **Description**                                            | **Requirements / Context** |
| --------------------- | ------- | ---------------------------------------------------------- | -------------------------- |
| Terrain Brush Enlarge | ++gt++  | Increase Terrain Brush Size (++shift++ to Increase Faster) | Active Terrain Editing     |
| Terrain Brush Shrink  | ++lt++  | Decrease Terrain Brush Size (++shift++ to Decrease Faster) | Active Terrain Editing     |

## Text Editor

| **Operation**  | **Key** | **Key 2** | **Description**                           | **Requirements / Context** |
| -------------- | ------- | --------- | ----------------------------------------- | -------------------------- |
| Find           | ++F++   | ++ctrl++  | Highlights Selection                      | In Text Editor             |
| Find Next      | ++F3++  |           | When in Find, Selects Next Occurrence     | In Text Editor             |
| Find Previous  | ++F3++  | ++shift++ | When in Find, Selects Previous Occurrence | In Text Editor             |
| Compile script | ++F5++  |           | Compiles Script With Uncompiled Changes   | Script Open                |
