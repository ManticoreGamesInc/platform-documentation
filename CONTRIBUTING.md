# Contributing

Thanks for your interest in helping out by contributing! Your assistance is very much appreciated!

## Simple Edits

If you don't want to deal with all the technicalities because you only want to do some small wording changes, you can just use the GitHub WebUI to edit a markdown file directly!

- Click on the `Edit` icon (top right) of the page you want to change.
- Make your changes.
- Make sure the changes look good and follow our [guidelines](https://github.com/ManticoreGamesInc/platform-documentation/wiki/Documentation-Style-Guide) (check the **Preview** tab on the top left).
- Add a helpful commit message and submit it!
- Now open a pull request with your changes and fill out the template.

**Note:** The integrated preview mode won't display advanced markdown functionality (e.g. `!!! info` blocks and our custom Markdown features won't work. To check out how they will end up looking on the site, open a pull request and check out the Netlify preview.

- Our system will automatically build a version of the site for you to view live.
- Your pull request will then be reviewed by other members of the team. Once it passes, it will be merged to `development` and later `production` which will make your content appear on the main site.

## Adding new Content

### Prerequisites

First, make sure that you have:

- [Visual Studio Code](https://github.com/ManticoreGamesInc/platform-documentation/wiki/Editor-Setup) (not required)
- [Python](https://www.python.org/) >= 3.7.0
- [Node.js](https://nodejs.org/en/download/) >= 12.0.0

### Clone the Repository

```console
cd folder/to/clone-into/
git clone https://github.com/ManticoreGamesInc/platform-documentation
cd platform-documentation
git submodule update --init --recursive --depth=1
git config pull.rebase true # We use rebase instead of merge
```

### Install the Platform

1. Install mkdocs

    ```console
    pip install -r requirements.txt --upgrade
    ```

    - Note: This step might be re-required after updates, will be noted in commit notes if needed.

2. Install Node.js Packages

    ```console
    npm install
    ```

    - Note: This step might be re-required after updates, will be noted in commit notes if needed.

### Spin up the Platform

```console
mkdocs serve
```

- Navigate to `http://127.0.0.1:8000/` in your browser. The page will automatically refresh upon saving files.
- Right click into the site, select **Inspect**, go to **Application** > **Service Workers** and select **Update on reload** to make sure you always see the latest content.

## Adding Content

### Create a new Feature Branch

```console
git checkout development
git pull # Make sure `development` is up to date with upstream
git checkout -b camera-controls # Create a new branch using your feature as the name
```

Now, depending on what you want to add, you can create your new Markdown files and start writing. Our file structure is pretty self explanatory, tutorials go into `src/tutorials/` and so on.

### Check in your Changes

- Make sure to add your new page to the index of pages in `mkdocs.yml` and `mkdocs-prod.yml`.
- Commit any changes to your branch and push to the repository. (e.g. `git push -u origin camera-controls`)
- When you are done and your changes meet all of [our requirements](https://github.com/ManticoreGamesInc/platform-documentation/wiki/Documentation-Style-Guide), create a new pull request on GitHub, requesting your feature branch to be merged into `development`.
- Our system will automatically build a version of the site for you to view live.
- Your pull request will then be reviewed by other members of the team. Once it passes, it will be merged to `development` and later `production` which will make your content appear on the main site.

## Staying up to Date

Always make sure your `development` branch is up to date before creating a new feature branch! To update your local version to the latest version:

```console
git checkout development
git pull # Make sure `development` is up to date with upstream
```

If you want to sync an ongoing feature branch to the current state of `development` you have to rebase it on top of it and then force push. Warning: [force pushing](https://www.git-tower.com/learn/git/faq/git-force-push/) is a desctructive action and you should make sure to you are not overwriting anything.

```console
git checkout development
git pull # Make sure `development` is up to date with upstream
git checkout camera-controls
git rebase origin/development
git push --force-with-lease
```
