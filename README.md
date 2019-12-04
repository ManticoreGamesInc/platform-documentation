# Documentation

[![Website Build Status](https://api.netlify.com/api/v1/badges/c0780d7f-a678-49fd-b50e-ffe26f95147f/deploy-status)](https://app.netlify.com/sites/manticore-docs/deploys)

The source for the official CORE documentation.
The password is `I love documentation!`

## Branch Structure

There are multiple version of the CORE documentation, and therefore multiple branches on this repository that correspond to each.

* [production](https://production--manticore-docs.netlify.com) - the staging site.
* [production-publish](https://docs.coregames.com/) - the live, production site.
* [PTS](https://pts-publish--manticore-docs.netlify.com/)- the public test server
    version.
* [Dev](https://dev-publish--manticore-docs.netlify.com/) - for in-development,
    bleeding edge changes.

**Note:** Currently only `production` and `production-publish` exist and are used.

### Branch Details

Each state of the published website has a corresponding branch-pair on GitLab, a
commit-able version and a `*-publish` version. So the pair of `production` and
`production-publish` is one example. The `*-publish` version is a protected
branch and *cannot* be pushed to directly! Instead, all changes must go through
the main branch (`production`), then merged into the publish one
(`production-publish`) via an approval process by the documentation team. This
ensures quality on all public sources of documentation. The (slightly-outdated)
picture below gives a visual representation of this flow.

![BranchStructure](src/img/readme_branches.png)

When a branch is merged to `*-publish`, it will use `--no-ff`, so as to not clutter
up the history, and simply allow upstream commits for builds.

Check out the [contribution](CONTRIBUTING.MD) document if you are interested in
helping out!
