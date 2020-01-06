# Contributing

Thanks for your interested in helping out by contributing! Your assistance is much appreciated!

## Getting Started

In case you only want to do some small wording changes, just use the GitHub WebUI and skip ahead to [Easy Mode](#easy-mode).

### Set up your Environment ([Hard Mode](#hard-mode))

1. Download and install [Python](https://www.python.org/)(3.7+).

    - During setup, make sure to check the option to **"Add Python to PATH"**.
    - You can check if it's properly installed via instructions listed [here](https://www.makeuseof.com/tag/install-pip-for-python/).
    - To manually add Python to PATH if you did not install it as so, reference [here](https://datatofish.com/add-python-to-windows-path/).

2. Download and install [Git](https://git-scm.com/).

    - In the "**Select Components**" window, leave all default options checked and check any other additional components you want installed.
    - Next you will chose the default editor used by Git. Use a text editor you're comfortable using.
    - In the "**Adjusting your PATH environment**" section, chose "**Git from the command line and, also from 3rd-party software**"
    - Next in "**Choosing HTTPS transport backend**", leave the default selected as "**Use OpenSSH**".
    - In "**Configuring the line ending conversions**" use "**Checkout as-is, commit Unix-style endings**".
    - In "**Configuring the terminal emulator**" use "**Use Windows' default console window**".
    - In "**Configuring extra options**", check all three boxes.
    - In a console, set `git config --global pull.rebase true`

3. Create a new [GitLab](https://gitlab.com/) account, use your Manticore email if your are an employee.

4. Fork the repository, no need to do this for Manticore employees, use main repo branches instead.

5. Clone the forked repository
    - Open the command prompt.
    - Navigate to the location you want to clone this project to (e.g. `cd folder/to/clone-into/`)
    - Clone this project from GitHub (e.g. `git clone https://github.com/YOURNAME/platform-documentation`)
    - When prompted by popup, sign in with your GitLab account associated with your Manticore email.
      If you mistype your information, you can edit your information: - Navigate to Control Panel > User Accounts > Credential Manager > Windows Credentials. - Find Git credentials in the list (e.g. git:<https://).> - Delete your Git credentials and restart the process to be prompted again.
    - Update the Git submodule via `git submodule update --init --recursive --depth=1`
    - Add the Manticore repository as a remote (`git remote add upstream https://github.com/ManticoreGamesInc/platform-documentation`).

6. Install mkdocs
    - Navigate to the `platform-documentation` location (`cd platform-documentation`).
    - Enter `pip install -r requirements.txt` into the command line to install required files.
    - Enter `mkdocs serve` into the command line to start the server which will watch for changes upon saving and update live.
    - Navigate to `http://127.0.0.1:8000/` in your browser. The page will automatically refresh upon saving.
    - Right click into the site, select "Inspect", go to "Application" > "Service Workers" and select "Update on reload".

7. Install an [EditorConfig](https://editorconfig.org/) extension for your editor.
8. Install a [MarkdownLint](https://github.com/DavidAnson/markdownlint) extension for your editor.

Now you are ready to write!

### Starting a new Tutorial

- Make sure your `production` branch is up to date with upstream. (`git checkout production && git pull upstream production`)
- Create a new branch from `production`, using that feature as the name. (e.g. `camera-controls`)
- If you add a new page, create a markdown file (e.g. `learn_camera.md`) in the appropriate folder.
- Go to `mkdocs.yml` and add it to the index of pages, following the existing format. (e.g. `- Camera Controls: Tutorials/learn_camera.md`)
- Commit any changes to your branch and push to your repository. (e.g. `git push origin camera-controls`)
- When you are done and your changes meet all of [our requirements](DOCUMENTATION.md), create a new merge request on GitLab, requesting your feature branch to be merged into `production`.
- Our system will automatically build a version of the site for you to view live (check `#docs-updates` in Slack).
- Others can then comment on the merge request. Once it has been audited it will be merged to `production` and later `production-publish` which will make your content appear on the main site.

## Staying up to Date

To update your local branch to the latest version of `production`:

- Navigate to the `platform-documentation` location via command line.
- We use rebase instead of merge, so please make sure your client respects that or set `git config --global pull.rebase true`
- In the command prompt, enter `git pull upstream` (fetches the latest version and merges the latest commits into your branch).
- To learn more, visit [Git Documentation](https://git-scm.com/docs/git-pull).

## [Easy Mode](#easy-mode)

If you don't want to deal with all the technicalities, you can just use the GitLab WebUI to edit a markdown file directly!

- Click on the `Edit` icon (top right) of the page you want to change.
- Make your changes.
- Make sure the changes look good and follow our [guidelines](DOCUMENTATION.md) (check the "**Preview**" tab on the top left).
- Add a helpful commit message and add it!

**Note:**
The integrated preview mode won't display advanced markdown functionality (e.g. `!!! info` blocks and our custom Markdown features won't work. To check out how they will end up looking on the site, you can go to `https://{branch}--manticore-docs.netlify.com`, so for `production` it would be [production--manticore-docs.netlify.com](https://production--manticore-docs.netlify.com). <!-- TODO: This will only work with an open merge request or Manticore employees -->
