# Documentation

[![Build Status](https://github.com/ManticoreGamesInc/platform-documentation/workflows/mkdocs/badge.svg)](https://github.com/ManticoreGamesInc/platform-documentation/actions?workflow=mkdocs)

Welcome to the source for the official CORE documentation! Please check out the [contribution](CONTRIBUTING.MD) document if you are interested in
helping out!

## Related Repositories

- [external-editor-api-support](https://github.com/ManticoreGamesInc/external-editor-api-support) - Generates the files in the `src/assets/api` directory.
- [LuaAPIDocumentation](https://github.com/ManticoreGamesInc/LuaAPIDocumentation) - Generates `src/core_api.md`.
- [mkdocs-material](https://github.com/ManticoreGamesInc/mkdocs-material) - Is the submodule that provides the theme.

## Branch Structure

There are multiple version of the CORE documentation, and therefore multiple branches on this repository that correspond to each.

Production:

- [production](https://production--manticore-docs.netlify.com) - the staging site.
- [production-publish](https://www.coregames.com/docs) - the live, production site.

Public Test Server:

- [pts-publish](https://pts-publish--manticore-docs.netlify.com/)- the public test server.

Development:

- [dev-publish](https://dev-publish--manticore-docs.netlify.com/) - for in-development, bleeding edge changes.

**Note:** Currently only `production` and `production-publish` are used.

### Branch Details

Each state of the published website is a corresponding branch-pair on GitHub, a commit-able version and a `*-publish` version.

So the pair of `production` and `production-publish` is one example. The `*-publish` version is a protected branch and _cannot_ be pushed to directly!

Instead, all changes must go through the main branch (`production`), then merged into the publish one (`production-publish`) via an approval process by the documentation team.
This
ensures quality on all public sources of documentation.

When a branch is merged to `*-publish`, it will use `--no-ff`, so as to not clutter up the history, and simply allow upstream commits for builds.
