<div align="center">

# Core Platform Documentation

[![Open in VSCode](https://open.vscode.dev/badges/open-in-vscode.svg)](https://open.vscode.dev/ManticoreGames/platform-documentation) [![Website Build Status](https://api.netlify.com/api/v1/badges/c0780d7f-a678-49fd-b50e-ffe26f95147f/deploy-status)](https://app.netlify.com/sites/manticore-docs/deploys) [![Build Status](https://github.com/ManticoreGamesInc/platform-documentation/workflows/Build%20&%20Deploy%20(Development)/badge.svg)](https://github.com/ManticoreGamesInc/platform-documentation/actions?query=workflow%3A%22Build+%26+Deploy+%28Development%29%22) [![Build Status](https://github.com/ManticoreGamesInc/platform-documentation/workflows/Build%20&%20Deploy%20(Production)/badge.svg)](https://github.com/ManticoreGamesInc/platform-documentation/actions?query=workflow%3A%22Build+%26+Deploy+%28Production%29%22)

![Logo](https://i.imgur.com/qGXJGGE.jpeg)
</div>

Welcome to the source of the official Core platform documentation! Please check out the [contribution](CONTRIBUTING.md) document if you are interested in
helping out!

## Stack

The Core Documentation Platform is built on [mkdocs](https://github.com/mkdocs/mkdocs/) and following plugins for it:

- [mkdocs-material](https://github.com/squidfunk/mkdocs-material/)
- [mkdocs-ezlinks](https://github.com/orbikm/mkdocs-ezlinks-plugin)
- [mkdocs-git-revision-date-localized](https://github.com/timvink/mkdocs-git-revision-date-localized-plugin)
- [mkdocs-material-extensions](https://github.com/facelessuser/mkdocs-material-extensions)
- [mkdocs-redirects](https://github.com/datarobot/mkdocs-redirects)
- [mkdocs-static-i18n](https://github.com/ultrabug/mkdocs-static-i18n/)

## Related Repositories

- [vscode-core](https://github.com/ManticoreGamesInc/vscode-core) - A [VS Code](https://code.visualstudio.com/) extension that adds support for the Core Lua API. (public)
- [LuaAPIDocumentation](https://github.com/ManticoreGamesInc/LuaAPIDocumentation) - Generates the API pages in `src/api/` as well as the index and enums pages and the `.luacheckrc` and `.luacompleterc` files. (private)
- [mkdocs-material](https://github.com/ManticoreGamesInc/mkdocs-material) - Our fork of the [mkdocs-material](https://github.com/squidfunk/mkdocs-material/) theme. Included as a submodule. (public)

## Branch Structure

There are multiple version of the Core documentation, and therefore multiple branches on this repository that correspond to each.

- [development](https://development.docs.coregames.com) - the staging site, accessible at [https://development.docs.coregames.com](https://development.docs.coregames.com).
- [production](https://docs.coregames.com) - the live site, accessible at [https://docs.coregames.com](https://docs.coregames.com).

Note: `production` is a protected branch and _cannot_ be pushed to directly! Instead, all changes must go through the `development` branch which gets then merged into `production` via an approval process by the documentation team.

In addition, we use **Netlify** to generate preview pages for every pull request and branch. Those URLs will be listed in the status window on every pull request.
