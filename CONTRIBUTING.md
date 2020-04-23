# Contributing

Thanks for your interest in helping out by contributing! Your assistance is very much appreciated!

If you don't want to deal with all the technicalities because you only want to do some small wording changes, you can just use the GitHub WebUI to edit a markdown file directly!

- Click on the `Edit` icon (top right) of the page you want to change.
- Make your changes.
- Make sure the changes look good and follow our [guidelines](https://github.com/ManticoreGamesInc/platform-documentation/wiki/Documentation-Style-Guide) (check the **Preview** tab on the top left).
- Add a helpful commit message and add it!

**Note:** The integrated preview mode won't display advanced markdown functionality (e.g. `!!! info` blocks and our custom Markdown features won't work. To check out how they will end up looking on the site, open a pull request and check out the Netlify preview.

## Setting up your Environment

### Prerequisites

First, make sure that you have:

- [Visual Studio Code](https://github.com/ManticoreGamesInc/platform-documentation/wiki/Editor-Setup)
- [Python](https://www.microsoft.com/en-us/p/python-38/9mssztt1n39l)
- [Node.js](https://nodejs.org/en/download/) >= 12.0.0
- [Git](https://git-scm.com/downloads)
    - The CLI Method:
        - Download [Git](https://git-scm.com/downloads).
        - In the **Select Components** window, leave all default options checked and check any other additional components you want installed.
        - Next you will chose the default editor used by Git. Use a text editor you're comfortable using.
        - In the **Adjusting your PATH environment** section, chose **Git from the command line and, also from 3rd-party software**
        - Next in **Choosing HTTPS transport backend**, leave the default selected as **Use OpenSSH**.
        - In **Configuring the line ending conversions** use **Checkout as-is, commit Unix-style endings**.
        - In **Configuring the terminal emulator** use **Use Windows' default console window**.
        - In **Configuring extra options**, check all three boxes.
    - The GUI Method:
        - Download and install [Fork](https://git-fork.com/).

### Clone the Repository

- The CLI Method:

    ```console
    cd folder/to/clone-into/
    git clone https://github.com/ManticoreGamesInc/platform-documentation
    cd platform-documentation
    git submodule update --init --recursive --depth=1
    git config pull.rebase true # We use rebase instead of merge
    ```

    - When prompted by a popup, sign in with your GitHub account.
    - If you mistype your information, you can edit your information:
        - Navigate to **Control Panel** > **User Accounts** > **Manage your Credentials** > **Windows Credentials**.
        - Find Git credentials in the list (e.g. `git:https://github.com`)
        - Delete your Git credentials and restart the process to be prompted again.

- The GUI Method:

    - Open Fork.
    - Go to **File** > **Clone...** and paste in `https://github.com/ManticoreGamesInc/platform-documentation`.
    - When prompted by a popup, sign in with your GitHub account.
    - **Don't commit changes to the submodule** unless you now what you are doing. If it shows as changed, just leave it like that.
    - Remember to select **Rebase instead of merge** when pulling changes.

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

- The CLI Method:

    ```console
    git checkout development
    git pull # Make sure `development` is up to date with upstream
    git checkout -b camera-controls # Create a new branch using your feature as the name
    cd src/tutorials # Navigate to the correct folder
    echo some-text > learn-camera.md # Create a new markdown file
    ```

- The GUI Method

    - Double click the `development` branch.
    - Click **Pull** and check **Rebase instead of merge** if unchecked.
    - Click **New Branch**, check **Check out after create**, enter **camera-controls** and click **Create and checkout**.
    - Click **Open in** and select **Open in Visual Studio Code**.
    - Right click the folder you want the file to be in and select **New File**.

### Check in your Changes

- Make sure to add your new page to the index of pages in `mkdocs.yml` and `mkdocs-prod.yml`.
- Commit any changes to your branch and push to the repository. (e.g. `git push origin camera-controls`)
- When you are done and your changes meet all of [our requirements](https://github.com/ManticoreGamesInc/platform-documentation/wiki/Documentation-Style-Guide), create a new pull request on GitHub, requesting your feature branch to be merged into `development`.
- Our system will automatically build a version of the site for you to view live.
- Your pull request will then be reviewed by other members of the team. Once it passes, it will be merged to `development` and later `production` which will make your content appear on the main site.

## Staying up to Date

Always make sure your `development` branch is up to date before creating a new feature branch! To update your local version to the latest version:

- The CLI Method:

    ```console
    git checkout development
    git pull # Make sure `development` is up to date with upstream
    ```

- The GUI Method:

    - Double click the `development` branch.
    - Press the **Pull** button and check **Rebase instead of merge**.
    - Double click your feature branch.
    - Right click the `development` branch in the sidebar and select **Rebase your-feature-branch on development**.
