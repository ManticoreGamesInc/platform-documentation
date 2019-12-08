# Manticore Documentation Style Guide

## Markdown

In addition to the standard [Markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) we also use [additional extensions](https://squidfunk.github.io/mkdocs-material/extensions/admonition/) for code highlighting, info blocks, icons, etc. and, also a few custom features that help with getting good layouts done faster:

* `{: .image-inline-text}` for positioning text vertically centered next to an image.

    Usage:

  ```markdown
  ![alt_text](../../img/EnvironIntro/terrain_subtract.png "image_tooltip") **Subtract Terrain**: Lower the terrain level
  {: .image-inline-text}
  ```

* `{: .image-cluster}` for easily placing two images next to each other and centering a description text below them.

    Usage:

  ```markdown
  ![alt_text](../../img/EnvironIntro/image9.png "image_tooltip")
  ![alt_text](../../img/EnvironIntro/image44.png "image_tooltip")
  _Randomized Color unchecked (left) vs. checked (right)_
  {: .image-cluster}
  ```

* `{: .center}` to quickly center elements like images.

    Usage:

  ```markdown
  ![MyFirstScript](../../img/scripting/MyFirstScript.png){: .center}
  ```

* `{: style="color: $css_color_code"}` to color text elements.

    Usage:

  ```markdown
  **Pancakes**{: style="color: red"}
  ```

* `{: .style-good|.style-bad|.style-exception}` to highlight good/bad practice code examples.

    Usage:

  ````markdown
      Good:
      ```
      local foo = {
          bar = 2,
      }

      if foo then
          -- do something
      end
      ```
      {: .style-good}
  ````

## Pictures

1. Create a new folder for your tutorial inside of `src/img/` and name it appropriately.
2. Reference images using a relative path, examples present throughout.
3. Please make sure your images are all the same size or at least stick to a common ratio.
4. If you want to use GIFs, make sure they are not huge or convert them into videos.

### Converting GIF to Video

Get ffmpeg from [here](https://ffmpeg.zeranoe.com/builds/) and put it onto your \\$PATH or the same folder as the GIF.
Now run `ffmpeg -i input.gif -b:v 0 -crf 25 output.mp4` from the command line.

After that is done, embed video like this:

```html
<div class="mt-video">
    <video autoplay loop muted playsinline>
        <source src="cat.mp4" type="video/mp4" />
    </video>
</div>
```

## Long Tutorial Videos

* Message Tasha to get access to the CORE YouTube account, upload and then use Markdown to embed them into your documents.

    Usage:

    `![YOUTUBE](LRLQE2N0DKc)`

    Where the part in parentheses is the video ID

    `![YOUTUBELIVE](LRLQE2N0DKc)`

    Where the part in parentheses is the channel ID, for live streams.

---

## Tutorial Layout

To encourage consistent styling, we provide CORE tutorial styling and writing guidelines.

### Topic Categories

Topic categories are added at the top of every file in this format:

```yaml
---
name: Costumes in CORE
categories:
    - Reference
    - Art
---

```

The following categories are available: <!-- TODO: Talk about which ones we want -->

| Topic Category    | Example Tutorial                         |
| ----------------- | ---------------------------------------- |
| Game Creation     | First Platformer, First FPS              |
| Scripting         | Intro to Lua, Coding Best Practices      |
| Editor Essentials | Player Settings, Script Debugger         |
| Audio             | SFX, Rhythm Games                        |
| Networking        | Replicators, Client-Server               |
| UI                | Main Menu Creation, Regen HP Bar         |
| Terrain           | Basic Terrain, Import Height Maps        |
| Weapon            | Intro to Melee Weapons, Intro to Guns    |
| Ability           | How to Sprint, How to Cast a Magic Spell |

Setting a `name` is mandatory, `categories` are optional. If you add categories to a file, they will be listed on the [sitemap](generated/sitemap.md). (once Ben automates that)

### Overview

* Introduction with goal of the tutorial (2-3 sentences)
* Image of finished work
* Skills the learner will acquire (3-5 bullet points)
* Estimated Time for Completion
* Difficulty Level
* Author/Audience Assumptions
* Link to any recommended basic tutorials
* If applicable, link to other tutorials in the series

#### Estimated Time for Completion

It is recommended to keep your tutorials short and below the 30 minute mark for estimated time of completion.
If longer, it is recommendeded to split your tutorial into a series.

#### Difficulty Level

* Beginner
* Intermediate
* Advanced

### Tutorial Content

* Include commented code that follows conventions
* Include pictures of the Hierarchy often
* Link to the finished example project at the end
* Published project should be on Prod
* Provide related tutorials / additional resources

### Writing Conventions

* If you are copy-pasting from Google Docs, please make sure you disable "Smart Quotes" in "Tools" -> "Preferences" before.
* Follow the [CORE Lua Style Guide](tutorials/gameplay/lua_style_guide) for scripting.
* Name your objects in the hierarchy informatively.
* Favor best practices like using `CoreObject` Asset References rather than `script.parent.parent:GetChildren([3])`.
* Tutorials should be less than an hour in length, and if higher, should be split into multi-part tutorials as part of a series.
* Make functions and variables local unless global is completely necessary.
* If describing a command outside a code snippet, put the command in code format like so `tostring`.
* Encourage use of the **Event Log** and use `print()` more than `UI.PrintToScreen()`.
* Put parentheses around your conditions in any compound conditional.
* Bold any button or object a user has to click on like `**Edit Terrain*`.
* Mke sure anything referenced in "**Community Content**" will exist in the future. (e.g. by checking with the gameplay team)
* Make sure to include `<!-- TODO: XX -->` comments for stuff that needs clarification or you are planning changes for.
* Please use the Oxford comma.

**Note**: If we have a file that is no longer "done" due to editor changes, include the following after the `# Title` section of your file.

```markdown
!!! warning
    Flagged for review.
    Incomplete or outdated information may be present.
```
