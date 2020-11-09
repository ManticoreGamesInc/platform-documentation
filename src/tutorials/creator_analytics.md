---
id: creator_analytics
name: Creator Analytics
title: Creator Analytics
tags:
    - Tutorial
---

# Creator Analytics

## Overview

The **Creator Analytics** feature is designed to give creators more information about the number of players playing your game for the first time each day, and how many return later.

!!! note
    Currently, **Creator Analytics** is only available to members of the **Creator Payouts Program**. To learn more about monetizing your games, see the [Creator Payouts FAQ](https://support.coregames.com/hc/en-us/articles/360051489213-Creator-Payouts-FAQ). All creators can access information about their games through the [Creator Dashboard](https://www.coregames.com/creator-dashboard).

## Downloading and Importing Data

### Finding the Data

To find the monthly retention data for all your games, see the [Create Page](https://www.coregames.com/create) on the web. In the left side navigation, you should find links for the **Creator Dashboard**, and a new one for **Creator Analytics**.

### Downloading the CSV

Data for all your games is aggregated by month into a single CSV file. By default, this will select the most recent month, but you can also choose data from previous months with the drop-down menu.

!!! note
    The earliest data availabe will be from October 2020 for creators who joined the Payouts Program before October 2020.

### Importing the CSV

!!! info
    **CSV** files are a lightweight data files that separate values by commas that can be easily imported into your preferred spreadsheet software.

In Chrome, you can open a CSV file and see options to import into various spreadsheet programs.

Specific instructions to import by program:

- [Google Sheets](https://support.google.com/docs/answer/40608?co=GENIE.Platform%3DDesktop&hl=en)
- [Microsoft Excel](https://support.microsoft.com/en-us/office/import-or-export-text-txt-or-csv-files-5250ac4c-663c-47ce-937b-339e391393ba)
- [OpenOffice Calc](https://smallbusiness.chron.com/import-csv-file-openoffice-79038.html)

## Interpreting Data

### Cohorted Data

Data for each game is **cohorted**, meaning that it follows the group of users who try the game for the first time (**D0**) on a given day and tracks how many of each of them return later in the month.

#### Example

| date |  players_d0 | players_d1 | players_d2 |
| --- | --- | --- | --- | --- |
| 2020-10-14 |  51 | 1 | 1 |

In the example above, on the 14th of October, there were **51** players playing for the first time (Day 0 or D0). The **players_d1** column tracks how many of those original 51 players returned the next day (Day 1 or D1). In this case, only 1. The third column tracks how many players from the original group of 51 played again two days later, on October 16th.

### Getting the Most Recent Data

Data for a given day is added two days later to make sure that it is fully accurate.

### Terminology

|  Column Name | Definition |
| --- | --- |
|  account_id | Your unique creator ID |
|  user_name | Your creator username |
|  game_id | The unique ID of one of your games |
|  game_name | The name of the game. Both ID and name are provided because creators can have multiple games with the same name. |
|  date | The date of the new cohort of users playing for the first time. |
|  dau | The number of daily users for the day in date |
|  dau_average_month_to_date | The average of those daily users for the month so far. |
|  sessions | Total number of plays of the game that day |
|  session_time_minutes | The average time a player spent in the game that day |
|  players_d0 | The number of players playing on the date for the first time. |
|  players_d7 | The number of the players who played for the first time on the date and returned seven days later. |
|  players_d0_month_to_date | Average number of new players per day from the beginning of the month to the date |
|  retention_d1_percent | The percent of new players from the date who returned one day later. |
|  retention_d1_month_to_date_percent | The average percentage of players who return one day later from the beginning of the month to the date. |

---

## Learn More

[Creator Payouts FAQ](https://support.coregames.com/hc/en-us/articles/)
