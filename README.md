# Documentation

Base styling provided by [material](https://squidfunk.github.io/mkdocs-material/).

## Contributing

You can edit a markdown file directly through GitHub, so it's very easy!

- Select the `.md` file you want to edit.
- Click on the pencil shaped edit icon in the top right.
- Make your changes.
  - Here's how [markdown](https://daringfireball.net/projects/markdown/syntax) works, for those not familiar.
  - Additional tools provided by [extensions](https://squidfunk.github.io/mkdocs-material/extensions/admonition/)
- Make sure the changes look good (change the tab on the top to 'Preview changes').
- Add a helpful commit message and add it!
  - If you're making a lot of changes please make it a new branch and use a pull request :)

Alternatively you can clone the repository and create a pull request for larger scale changes.

#### New Pages

If you want to add a new page, create a markdown file (.md extension).

Then, to make it findable, you have to add it to the index of pages.

- Go to `mkdocs.yml` and follow the existing format.

In case that isn't enough explanation, here is more info:

If it is a page in an existing folder:

- Go to `nav: -ExistingFolder:`
- Add in a new (indented) line with `- Page Name: 'ExistingFolder/pagename.md'`

If it is in a new folder, add `-FolderName:` to the `nav:` root, like the others.

#### Full Setup

[Install python and pip](https://www.makeuseof.com/tag/install-pip-for-python/) if you don't have them already.

- Navigate to the location you want to clone this project to (e.g. `cd folder/to/clone-into/`)
- Clone this project from GitHub (e.g. `git clone https://github.com/ManticoreGamesInc/Documentation.git`)
- `pip install -r requirements.txt` --installs required files
- `mkdocs serve` --starts server
- Navigate to `http://127.0.0.1:8000/`

If you need a standalone and lightweight Markdown editor, [Typora](https://typora.io/) is a good one.