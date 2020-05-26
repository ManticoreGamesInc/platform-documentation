---
id: extensions
name: Editor Extensions
title: Editor Extensions
tags:
    - Misc
---

# Editor Extensions

There are a bunch of ways you can improve the experience of scripting in Core. If you are happy with the in-built editor, feel free to skip this section.

If you want Core to use an external editor by default when you open a script file, press <kbd>ESC</kbd> to open up the options, then go to "**Settings**" and then change the path for "**External Script Editor**" to the one you prefer.

## External editors

There are of course several good editors out there for Lua development, but we suggest one of the following since they have tons of good plugins available.

| Name                                                                    | Details                                             | Core Autocomplete | Price                  |
| ----------------------------------------------------------------------- | --------------------------------------------------- | ----------------- | ---------------------- |
| [Visual Studio Code](https://code.visualstudio.com/download)            | Popular powerful editor with many plugins           | Supported         | Free                   |
| [Atom](https://atom.io/)                                                | Middle-range power/speed editor with plugin support | Supported         | Free                   |
| [SublimeText](https://www.sublimetext.com/3)                            | Lightweight text editor with plugins                | Not Supported     | Free Evaluation / Paid |
| [Notepad++](https://notepad-plus-plus.org/)                             | Very lightweight text editor                        | Not Supported     | Free                   |

### Plugins / Extensions

For Visual Studio Code and Atom, we have collected a few extensions that make developing in Core and Lua easier:

#### Visual Studio Code

| Plugin Name                                                                            | Details                  |
| -------------------------------------------------------------------------------------- | ------------------------ |
| [VSCode-Lua](https://marketplace.visualstudio.com/items?itemName=trixnz.vscode-lua)    | Adds Lua support         |
| [Lua Language Server](https://marketplace.visualstudio.com/items?itemName=sumneko.lua) or [Lua Coder Assist](https://marketplace.visualstudio.com/items?itemName=liwangqian.luacoderassist) | Auto Completion and more |

#### Atom

| Plugin Name                                                   | Details                    |
| ------------------------------------------------------------- | -------------------------- |
| [language-lua](https://atom.io/packages/language-lua)         | Adds Lua support           |
| [autocomplete-lua](https://atom.io/packages/autocomplete-lua) | Adds Lua autocomplete      |
| [Linter](https://atom.io/packages/linter)                     | Adds linting support       |
| [Linter UI](https://atom.io/packages/linter-ui-default)       | Adds a UI to Linter        |
| [Linter: Luacheck](https://atom.io/packages/linter-luacheck)  | Adds Lua support to Linter |

### Autocomplete

While we do not provide our own editor extensions, we supply an API JSON dump that can be used to create one. We do provide autocompletion files with all Core API for VS Code, Atom and every other editor that supports `.luacompleterc` though.

* :fontawesome-solid-download: Download: [CoreLuaAPI-Prod.json](./assets/api/CoreLuaAPI-Prod.json "CoreLuaAPI-Prod.json")

#### Atom

* :fontawesome-solid-download: Download: [luacompleterc.zip](./assets/api/luacompleterc.zip "API Autocomplete Files")
* :fontawesome-solid-angle-double-right: Install: Extract the `.luacompleterc` file to your `Documents\My Games\Core\Saved\Maps` folder.

#### Visual Studio Code

* :fontawesome-solid-download: Download: [luacompleterc.zip](./assets/api/luacompleterc.zip "API Autocomplete Files")
* :fontawesome-solid-angle-double-right: Install: Extract the `.luacompleterc` file to your `Documents\My Games\Core\Saved\Maps` folder.

You need to add the folder containing `.luacompleterc` to the library settings of the Lua Language Server extension.
To do this, open up the VS Code settings via <kbd>CTRL</kbd> + <kbd>SHIFT</kbd> + <kbd>P</kbd>, type "Open Settings (JSON)" and hit enter.

Now add the following to the end:

```json
"Lua.workspace.library": { "C:\\Users\\YOURUSERNAME\\Documents\\My Games\\Core\\Saved\\Maps": true },
"Lua.diagnostics.enable": false,
```

We are setting Lua diagnostics to `false` since we are going to use the Luacheck integration that comes with VSCode-Lua.

!!! warning "You need to open your project in VS Code directly, not via double-clicking the script file in Core, otherwise autocomplete will not work."

### Installing a Linter

[Luacheck](https://github.com/mpeterv/luacheck), which also serves as a static analyzer, is **the** Lua Linter to use. You can add a `.luacheckrc` config file to your project that tells it what to check for and it will point out any mistakes you may make. Check out their [documentation](https://luacheck.readthedocs.io/en/stable/) for more info. A statically linked binary with all deps included is available on [GitHub](https://github.com/mpeterv/luacheck/releases/).

* :fontawesome-solid-download: Download: [Luacheck](https://github.com/mpeterv/luacheck/releases/)
* :fontawesome-solid-angle-double-right: Install: Copy `luacheck.exe` to a folder and add it to your `PATH` environment variable. ([HowTo](https://www.architectryan.com/2018/03/17/add-to-the-path-on-windows-10/))

In addition, we provide a `.luacheckrc` settings file with all Core API whitelisted so they don't show up as undeclared global variables:

* :fontawesome-solid-download: Download: [luacheckrc.zip](./assets/api/luacheckrc.zip "luacheckrc.zip")
* :fontawesome-solid-angle-double-right: Install: Extract the `.luacheckrc` file to your `C:\\Users\YOURUSERNAME\Documents\My Games\Core\Saved\Maps` folder.
