# Performance Estimation Panel

The aim of the Performance Estimation panel is to provide Creators a way to estimate the performance of their game on various computers over the different video settings.

![PerformancePanel](../img/getting_started/performance_panel.png){: .center loading="lazy" }

In brief, this is done by measuring the effect of certain metrics on the performance of the current system, and comparing it to benchmarks gathered across our reference computers, in order to get a realtime Performance Rating for the current section of the Game for those reference computers across all the different video settings.

Please keep in mind that the **Performance Rating system is only an estimation**, and there will always be some difference in the way the game actually runs on other computers with varying hardware specs.

There is also a sub-panel which gives the Performance Rating for the current computer, which is helpful for Creators to get an idea of performance on their machine with the currently selected video setting, and how it might scale up or down over the grid.

Since the panel gives a running estimate over the scene, it helps to walk through the scene and identify possible problematic areas.

The panel consists of 2 visualizations which help to give an idea of the estimation: A **Colored bar** and a **Number**.

![PerformancePanel2](../img/getting_started/performance_panel_2.png){: .center loading="lazy" }

With both the visualizations, the key point to make is "**Lower is Better**". The Performance Rating is more analogous (without having a direct correlation) to Frame times than it is to Frame rate, hence lower numbers mean better performance.

- The **colored bar** serves to give a quick visual idea of how the changing content in the current scene affects the estimated performance over the grid of machine specs and video settings.

- The **number** serves to give a slightly more granular view of the effect of the current content in the scene on the estimated performance over the grid of machine specs and video settings.

- **Green zone | Value < 0.67**{: style="color: var(--core-color-green)" }

    - The game is expected to run smoothly.

- **Yellow zone | 0.67 < Value < 1.0**{: style="color: #DE9300" }

    - The game is expected to run decently with some minor performance problems.

    - The creator should keep in mind that there might be some content optimizations needed in order to avoid going into the Red zone.

- **Red zone | Value > 1.0**{: style="color: var(--core-color-error-state)" }

    - The game is expected to run poorly.

    - The creator needs to walk through their scene and perform some content optimizations in order to get the game region out of the Red zone into the Yellow or Green zones.

Again, it is worth reiterating that **this panel only serves to give an estimation of performance on other computers**, and should not be the only factor considered when thinking about how the game might actually run on players' computers. Playtests and player feedback is very valuable when it comes to understanding this aspect of game development.
