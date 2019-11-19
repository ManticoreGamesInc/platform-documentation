# Development Environment

!!! warning
    Flagged for Review.
    Incomplete or outdated information may be present.

There are a bunch of ways you can improve the experience of scripting in CORE. If you are happy with the in-built editor, feel free to skip this section.

## External editors

There are of course several good editors out there for Lua development, but we suggest one of the following since they have tons of good plugins available.

| Name                                                         | Details                                             | CORE Autocomplete         | Price
| ------------------------------------------------------------ | --------------------------------------------------- |-------------------------- |-----------
| [ZeroBrane Studio](https://studio.zerobrane.com/download?not-this-time)     | Lua based lightweight editor         | Supported                 | Free
| [Visual Studio Code](https://code.visualstudio.com/download) | Popular powerful editor with many plugins           | Supported                 | Free
| [Atom](https://atom.io/)                                     | Middle-range power/speed editor with plugin support | Supported                 | Free
| [SublimeText](https://www.sublimetext.com/3)                 | Lightweight text editor with plugins                | Not Supported             | Free Evaluation / Paid
| [Notepad++](https://notepad-plus-plus.org/)                  | Very lightweight text editor                        | Not Supported             | Free

### Plugins / Extensions

For VS Code and Atom, we have collected a few extensions that make developing in CORE and Lua easier:

|VS Code|Atom|
|--|--|
|<table> <tr><th>Plugin Name</th><th>Details</th></tr><tr><td>[language-lua](https://atom.io/packages/language-lua)</td><td>Adds Lua support</td></tr><tr><td>[autocomplete-lua](https://atom.io/packages/autocomplete-lua)</td><td>Adds Lua autocomplete</td></tr><tr><td>[Linter](https://atom.io/packages/linter)</td><td>Adds linting support</td></tr><tr><td>[Linter: Luacheck](https://atom.io/packages/linter-luacheck)</td><td>Adds Lua support to Linter </td></tr></table>|<table><tr><th>Plugin Name</th><th>Details</th></tr><tr><td>[VSCode-Lua](https://marketplace.visualstudio.com/items?itemName=trixnz.vscode-lua)</td><td>Adds Lua support</td></tr><tr><td>[Lua Language Server](https://marketplace.visualstudio.com/items?itemName=sumneko.lua)</td><td>Auto Completion and more</td></tr></table>|

### Autocomplete

We provide autocompletion files with all CORE API for VS Code, Atom and ZeroBrane:

#### VS Code & Atom
* :fa-download: Download: <a title="External Editor Autocomplete" href="/assets/luacompleterc.zip">luacompleterc.zip</a>
* :fa-angle-double-right: Install: Extract the `.luacompleterc` file to your `CORE\Prod\Platform\Saved\Maps` folder.

!!! note
    For VS Code, you need to add the folder containing `.luacompleterc` to the library settings of the Lua Language Server extension.

    Example: `"Lua.workspace.library": {"E:\\CORE\\Dev\\Platform\\Saved\\Maps\\": true}`

    Also we are going to set `Diagnostics: Enable` to `off` since we are going to use the luacheck integration that comes with VSCode-Lua.

#### ZeroBrane
* :fa-download: Download: <a title="External Editor Autocomplete" href="/assets/manticoreapi.lua">manticoreapi.lua</a>
* :fa-angle-double-right: Install:
    * Add `manticoreapi.lua` file to `ZeroBraneStudio/api/lua/` folder.
    * Go to **Edit -> Preferences -> Settings: System** and add `api = {"manticoreapi"}` to your settings.
    * Save and restart ZeroBraneStudio.

### Installing a Linter

[Luacheck](https://github.com/mpeterv/luacheck), which also serves as a static analyzer, is **the** Lua Linter to use. You can add a `.luacheckrc` config file to your project that tells it what to check for and it will point out any mistakes you may make. Check out their [documentation](https://luacheck.readthedocs.io/en/stable/) for more info. A statically linked binary with all deps included is available on [GitHub](https://github.com/mpeterv/luacheck/releases/).

* :fa-download: Download: <a title="Luacheck" href="https://github.com/mpeterv/luacheck/releases/download/0.23.0/luacheck.exe">luacheck.exe</a>
* :fa-angle-double-right: Install: Copy `luacheck.exe` to a folder and add it to your `PATH` environment variable. ([HowTo](https://www.architectryan.com/2018/03/17/add-to-the-path-on-windows-10/))

In addition, we provide a `.luacheckrc` settings file with all CORE API whitelisted so they don't show up as undeclared globals:

* :fa-download: Download: <a title=".luacheckrc" href="/assets/luacheckrc.zip">luacheckrc.zip</a>
* :fa-angle-double-right: Install: Extract the `.luacheckrc` file to your `CORE\Prod\Platform\Saved\Maps` folder.

That's it! You're now all set up for developing in CORE and Lua.
