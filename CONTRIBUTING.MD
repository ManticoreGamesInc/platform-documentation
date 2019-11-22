# Contributing

Thanks for contributing! Your assistance is much appreciated!

## Workflow

When starting a new feature:

- Create a new branch from `production` with that feature as the name (e.g. `camera-controls`)
- Commit any changes to that branch
- When it is done, create a merge request, merging your feature branch into `production`
- It will build a version of the site to view live (check #docs-updates in slack
  for the link, can search by commit message to find it as well)
- Others can then comment on the pull request, and once it has been audited it
  will be merged.
- Make sure to include `TODO: XX` comments for stuff that needs clarification or you are planning changes for.

### Definition of Done (Alpha)

The document must complete all of the following:

- Syntax pass (spelling/grammar/style guide adherence/markdown format)
- Dependencies pass (make sure anything referenced in community content will
  exist in the future, e.g. by checking with gameplay team)
- Content pass (pass by main editors for overall quality)

**Note**: If we have a file that is no longer 'done' due to editor changes, include
the following at the top of the file in question:

```markdown
!!! warning
    Flagged for review.
    Incomplete or outdated information may be present.
```

### Editing Pages

You can edit a markdown file directly through GitLab, so it's very easy!

- Click on the `Edit` icon (top right) of the file you want to change.
- Make your changes.
    - Here's how
        [markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) works, for those not familiar. You can also uses GitLab's tools to quickly add formatting.
    - Additional tools provided by [extensions](https://squidfunk.github.io/mkdocs-material/extensions/admonition/) (e.g. code highlighting, info blocks, icons, etc.)
    - We also have a few custom markdown features that help with getting good layouts done faster:
        - `{: .image-inline-text}` for positioning text vertically centered next to an image.

            Usage:

            ```markdown
            ![alt_text](../../img/EnvironIntro/terrain_subtract.png "image_tooltip") **Subtract Terrain**: Lower the terrain level
            {: .image-inline-text}
            ```

        - `{: .image-cluster}` for easily placing two images next to each other and centering a description text below them.

            Usage:

            ```markdown
            ![alt_text](../../img/EnvironIntro/image9.png "image_tooltip")
            ![alt_text](../../img/EnvironIntro/image44.png "image_tooltip")
            _Randomized Color unchecked (left) vs. checked (right)_
            {: .image-cluster}
            ```

        - `{: .center}` to quickly center elements like images.

            Usage:

            ```markdown
            ![MyFirstScript](../../img/scripting/MyFirstScript.png){: .center}
            ```

        - `{: style="color: $css_color_code"}` to color text elements.

            Usage:

            ```markdown
            **Pancakes**{: style="color: red"}
            ```

        - `{: .style-good|.style-bad|.style-exception}` to highlight good/bad practice code examples.

            Usage:

            ```markdown
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
            ```

- Make sure the changes look good (check the 'Preview' tab on the top left).
- Add a helpful commit message and add it!

**Notes:**

1. The integrated preview mode won't display advanced markdown functionality (e.g. `!!!
info` blocks and our custom ones). To check out the live display for commits, you can go to `https://{branch}--manticore-docs.netlify.com`, so for production it would be [this](https://production--manticore-docs.netlify.com).
2. That means this flow is best for simple changes, for larger ones you should go with the [full setup](#full-setup).

### New Pages

If you want to add a new page, create a markdown file (`.md` extension).
Then, to make it findable, simply add it to the index of pages.

- Go to `mkdocs.yml` and follow the existing format.

If it is a page in an existing folder:

- Go to `nav: -ExistingFolder:`
- Add in a new (indented) line with `- Page Name: 'ExistingFolder/pagename.md'`

If it is in a new folder, add `-FolderName:` to the `nav:` root, like the
others.

### Branch Structure

There are multiple version of the CORE documentation, and therefore multiple
branches on this repository that correspond to each.

- [production](https://production--manticore-docs.netlify.com) - the staging site
- [production-publish](https://docs.manticoreplatform.com/) - the live, production state
- [PTS](https://pts-publish--manticore-docs.netlify.com/)- the public test server
version (useful for details on impending updates)
- [Dev](https://dev-publish--manticore-docs.netlify.com/) - for in-development,
bleeding edge changes (useful for internal development, or for particularly
invested developers to know what upcoming changes are on the horizon)

**Note:** Currently only prod and prod-publish exist.

#### Branch Details

Each state of the published website has a corresponding branch-pair on GitLab, a
commit-able version and a `*-publish` version. So the pair of `production` and
`production-publish` is one example. The `*-publish` version is a protected
branch and _cannot_ be pushed to directly! Instead, all changes must go through
the main branch (`production`), then merged into the publish one
(`production-publish`) via an approval process by the documentation team. This
ensures quality on all public sources of documentation. The (slightly-outdated)
picture below gives a visual representation of this flow.

![BranchStructure](src/img/readme_branches.png)

When a branch is merged to `*-publish`, it will use `--no-ff`, so as to not clutter
up the history, and simply allow upstream commits for builds.

#### [Full Setup](#full-setup)

1. Download and install [Python (with pip included)](https://www.python.org/).
    - In your installation, make sure to **checkmark to option box to "Add Python to PATH"**.
    - You can check it's properly installed via instructions [here](https://www.makeuseof.com/tag/install-pip-for-python/).
    - To manually add Python to PATH if you did not install it as so, reference [here](https://datatofish.com/add-python-to-windows-path/).

2. Download and install [Git](https://git-scm.com/).

3. Create a new [Gitlab](https://gitlab.com/) account associated with your Manticore e-mail.

4. Clone the repositiory
    - Open the command prompt.
    - Navigate to the location you want to clone this project to (e.g. `cd folder/to/clone-into/`)
    - Clone this project from GitLab (e.g. `git clone https://gitlab.com/manticore-games/platform-documentation`)
    - When prompted by popup, sign in with your Gitlab account associated with your Manticore email.
        If you mistype your information, you can edit your information:
            - Navigate to Control Panel > User Accounts > Credential Manager > Windows Credentials.
            - Find Git credentials in the list (e.g. git:<https://).>
            - Delete your Git credentials and restart the process to be prompted again.

5. Install mkdocs
    - Navigate to the `platform-documentation` location (via command line with `cd platform-documentation`)
    - Enter `pip install -r requirements.txt` into the commmand line to install required files
    - Enter `mkdocs serve` into the command line to start the server which will watch for changes upon saving and update live
    - Navigate to `http://127.0.0.1:8000/` for changes upon saving and and live updates

To update your local branch to the latest version of `production`,

- Navigate to the `platform-documentation` location via command line
- In the command prompt, enter `git pull origin` (fetches the latest version and merges the latest commits into your branch)
- To learn more, visit [Git's Documentation](https://git-scm.com/docs/git-pull).

Any new session, you make need to start up a server again with `mkdocs serve` after navigating to your platform-documentation folder.

### Files

#### Pictures

For now drop them in the `img/` folder and reference them via links as expected
(examples present throughout). Use folder names that represent the page the pictures are going to be embedded on.
Optimization will likely be handled by the host (Netlify).

##### Size

Please resize your images to TBD/TBD pixels.
Please use TBD to reduce your image file size before adding them.
Please convert your GIFs into videos.
`ffmpeg -i input.gif -b:v 0 -crf 25 output.mp4`

```html
<video autoplay loop muted playsinline>
<source src="cat.mp4" type="video/mp4">
</video>
```

### Videos

- Message Tasha to get access to our YouTube account, upload them there and then use Markdown to embed them into your documents.

Format: `![YOUTUBE](LRLQE2N0DKc)` where the part in parentheses is the video id.

---

## Tutorial Styling

To encourage consistent styling, here are CORE tutorial styling and writing guidelines.

### Tutorial, Background Info

- Tutorial Prerequisites
- Topic Tag
- Estimated Time for Completion
- Difficulty Level

### Tutorial Prerequisites

- Author/Audience Assumptions
- Link to any recommended basic tutorials
- If applicable, link to other tutorials in the series

### Topic Tag(s)

|Topic Tag | Example Tutorial|
|---|---|
| Game Creation | First Platformer, First FPS
| Scripting | Intro to Lua, Coding Best Practices
| Editor Essentials | Player Settings, Script Debugger
| Audio | SFX, Rhythm Games
| Networking | Replicators, Client-Server
| UI | Main Menu Creation, Regen HP Bar
| Terrain | Basic Terrain, Import Height Maps
| Weapon | Intro to Melee Weapons, Intro to Guns
| Ability | How to Sprint, How to Cast a Magic Spell

### Estimated Time for Completion

It is recommended to keep your tutorials short and below the 30 minute mark for estimated time of completion.
If longer, it is recommendeded to split your tutorial into a series.

### Difficulty Level

- Beginner
- Intermediate
- Advanced

### Content

#### Overview

- Introduction with goal of the tutorial (2-3 sentences)
- Image of finished work
- Skills the learner will acquire (3-5 bullet points)

#### Tutorial Content

- Include commented code that follows conventions
- Include pictures of the Hierarchy often
- Link to the finished example project at the end
- Published project should be on Prod before Alpha
- Provide related tutorials / Additional Resources

#### Writing Conventions

- Follow the [CORE Lua Style Guide](tutorials/gameplay/lua_style_guide), which most notably script writing and casing conventions.
- Make functions and variables local unless global is completely necessary.
- If describing a command outside a code snippet, put the command in code format like so `tostring`.
- Encourage use of the Event Log and use `print()` more than `UI.PrintToScreen()`.
- Put parentheses around your conditions in any compound conditional
- Bold any button or object a user has to click on like `**Edit Terrain*`
- Please use the Oxford comma.

### Expectations

#### Review Process

- Should be in Markdown, with additional tools provided by extensions for infoboxes, tips, questions, and warnings.
- Tutorials should be reviewed by 2-3 people minimum who have completely gone through the tutorial before the writer pushes to prod.

#### Content Quality

- Name your objects in the hierarchy informatively.
- Favor best practices [using CoreObject Asset References rather than script.parent.parent:GetChildren(](3)).
- Tutorials should be less than an hour in length, and if higher, should be split into multi-part tutorials as part of a series.
