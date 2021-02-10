---
id: leaderboards_reference
name: Leaderboards Reference
title: Leaderboards Reference
tags:
    - Reference
---

# Leaderboards

## Overview

**Global Leaderboards** store data for players across play sessions which is automatically sorted by the entry scores. This can be used to call out player excellence in metrics that fit your game, but can also be used for tracking data for players who are not currently connected to your game.

### Number of Entries

There is a limited number of Leaderboards and Leaderboard Entries per project, and entries per board.

#### Maximum Numbers

- Each Leaderboard can only have **one entry per player**.
- The maximum entries on a Leaderboard must be **between 10 and 100 entries**.
- One project can have **up to 100 Leaderboards**.
- Combined, Leaderboards in a project can have **up to 1000 total entries**.

### Daily, Weekly, Monthly Leaderboards

Each Leaderboard has the option to track **Daily**, **Weekly**, and **Monthly** scores, by creating a separate copy of the Leaderboard which deletes entries that are more than 1, 7, or 30 days old.

!!! note
    Each Daily, Weekly, or Monthly Leaderboard contributes to the total number of entries. that a project can have.

## Creating a Leaderboard

Leaderboards are created through the **Global Leaderboards** window, and can be referenced in scripts using a **NetRef**.

### Create a New Leaderboard

1. Click **Window** in the top menu toolbar, and then select **Global Leaderboards**.
2. Click the **Create New Leaderboard** button.
3. Give the Leaderboard a name that reflects the information it tracks.
4. Choose **Higher Is Better** or **Lower is Better** depending on which should put a player at the top of the Leaderboard.
5. Specify how many total entries the Leaderboard should track in the **Rank Entries** field.
6. Check the boxes by **Track Daily Data**, **Track Weekly Data**, or **Track Monthly Data** to create additional copies of the Leaderboard that delete entries after a certain amount of time.

### Add a NetRef as a Custom Property



### Add an Entry to a Leaderboard

### Loading Leaderboards

```lua
function loadLeaderboard()

    while not Leaderboards.HasLeaderboards() do -- just keep checking until this until the Leaderboards are loaded
        Task.Wait(1) -- wait one second
    end

    -- Code to display Leaderboard goes here

end

Task.Spawn(loadLeaderboard) -- spawn this task instead of just calling the function so that the Task.Wait doesn't make anything else wait.
```

### Displaying Leaderboard Entries

## What Next

- Nicholas' CC
- Persistent Storage Tutorial
- Leaderboards API
