# Contributing

Thanks for contributing! Your assistance is much appreciated :)

## Editing Pages

You can edit a markdown file directly through GitLab, so it's very easy!

- Click on the `Edit` icon (top right) of the file you want to change.
- Make your changes.
  - Here's how
    [markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)
    works, for those not familiar. You can also uses GitLab's tools to quickly
    add formatting.
  - Additional tools provided by
    [extensions](https://squidfunk.github.io/mkdocs-material/extensions/admonition/)
    (e.g. code highlighting, info blocks, icons, etc.)
- Make sure the changes look good (check the 'Preview' tab on the top left).
- Add a helpful commit message and add it!

Note that this flow is best for simple changes, for larger ones you should use
the Web IDE (or clone the repository and push commits from your IDE of choice).

Note that integrated preview modes won't display advanced markdown functionality (e.g. `!!!
info` blocks). To check out the live display for commits, you can go to `https://{branch}--manticore-docs.netlify.com`, so for production it would be [this](https://production--manticore-docs.netlify.com).

## New Pages

If you want to add a new page, create a markdown file (`.md` extension).
Then, to make it findable, simply add it to the index of pages.

- Go to `mkdocs.yml` and follow the existing format.

In case that isn't enough explanation, here is more info:

If it is a page in an existing folder:

- Go to `nav: -ExistingFolder:`
- Add in a new (indented) line with `- Page Name: 'ExistingFolder/pagename.md'`

If it is in a new folder, add `-FolderName:` to the `nav:` root, like the
others.

## Branch Workflow

When starting a new feature:
- Check out a new branch with that feature as the name (e.g. `camera-controls`)
- Commit any changes to that branch
- When it is done, create a merge request, merging your feature branch into `production`
- Others can then comment on the pull request, and once it has been audited it
  will be merged

---

# Details

Detailed information (e.g. branch structure) below here

## Branch Structure

![](/img/readme_branches.png)

### Branch Workflow

There are multiple version of the Core documentation, and therefore multiple
branches on this repository that correspond to each.

- [Prod](https://docs.manticoreplatform.com/) - the live, production state (useful
for all current or newly created games)
- [PTS](https://pts-publish--manticore-docs.netlify.com/)- the public test server
version (useful for details on impending updates)
- [Dev](https://dev-publish--manticore-docs.netlify.com/) - for in-development,
bleeding edge changes (useful for internal development, or for particularly
invested developers to know what upcoming changes are on the horizon)

**For now just create a pull-request to production for all changes**. When we get
closer to public launch and the various environments become more relevant this
will change and we will use the whole flow.

#### Branch Details

Each state of the published website has a corresponding branch-pair on GitHub, a
commit-able version and a `*-publish` version. So the pair of `production` and
`production-publish` is one example. The `*-publish` version is a protected
branch and _cannot_ be pushed to directly! Instead, all changes must go through
the main branch (`production`), then merged into the publish one
(`production-publish`) via an approval process by the documentation team. This
ensures quality on all public sources of documentation. The (slightly-outdated)
picture below gives a visual representation of this flow.

When a branch is merged to *-publish, it will use --no-ff, so as to not clutter
up the history, and simply allow upstream commits for builds.

#### Definition of Done (Alpha)

When you are ready for your doc to be done
- Create a merge request from your branch (with your changed file(s)) to `production`:
- It will build a version of the site to view live (check #docs-updates in slack
  for the link, can search by commit message to find it as well)

Then the document must complete all of the following:
- Syntax pass (spelling/grammar/style guide adherence/markdown format)
- Dependencies pass (make sure anything referenced in community content will
  exist in the future, e.g. by checking with gameplay team)
- Content pass (pass by main editors for overall quality)
- Done (merged and live)

Note: If we have a file that is no longer 'done' due to editor changes, include
the following at the top of the file in question: !!!warning Flagged for review.
Incomplete or outdated information may be present.

#### Full Setup

[Install Python (with pip included)](https://www.python.org/) if you don't have them already. In your installation, make sure to **checkmark to option box to "Add Python to PATH"**. You can check it's properly installed via instructions [here](https://www.makeuseof.com/tag/install-pip-for-python/). To manually add Python to PATH if you did not install it as so, reference [here](https://datatofish.com/add-python-to-windows-path/).

Download [Git](https://git-scm.com/) and make a [Gitlab](https://gitlab.com/) account associated with your Manticore e-mail, otherwise sign up a new account.

- Open the command prompt.
- Navigate to the location you want to clone this project to (e.g. `cd folder/to/clone-into/`)
- Clone this project from GitHub (e.g. `git clone https://gitlab.com/manticore-games/platform-documentation`)
- When prompted by popup, sign in with your Gitlab account associated with your Manticore email.*
- Navigate to the platform-documentation location (via command line with `cd platform-documentation`)
- Enter `pip install -r requirements.txt` into the commmand line to install required files
- Enter `mkdocs serve` into the command line to start the server which will watch for changes upon saving and update live
- Navigate to `http://127.0.0.1:8000/` for changes upon saving and and live updates

* If you mistype your information, you can edit your information
- Navigate to Control Panel > User Accounts > Credential Manager > Windows Credentials.
- Find Git credentials in the list (e.g. git:https://).
- Delete your Git credentials and restart the process to be prompted again.

Any new session, you make need to start up a server again with `mkdocs serve` after navigating to your platform-documentation folder.

If you need a standalone and lightweight Markdown editor,
[Typora](https://typora.io/) is a good one.

Base styling provided by
[material](https://squidfunk.github.io/mkdocs-material/).

### Files

#### Videos

Must be under 100MB and sourced in the Google Drive under
CoreUserDocumentation/DocsVideos. Click on the video, in the upper right corner
click on the three dots -> open in new window -> three dots -> embed item ->
paste that html code in the docs. Eventually we will embed YouTube links, but
for now this works for tiny (but private) clips.

#### Pictures

For now drop them in the `img/` folder and reference them via links as expected
(examples present throughout). Optimization will likely be handled by the host
(Netlify).
