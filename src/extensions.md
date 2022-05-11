---
id: extensions
name: Editor Extensions
title: Editor Extensions
tags:
  - Misc
---

# Editor Extensions

There are a bunch of ways you can improve the experience of scripting in Core. If you are happy with the in-built editor, feel free to skip this section.

If you want Core to use an external editor by default when you open a script file, press ++esc++ to open up the options, then go to "**Settings**" and then change the path for "**External Script Editor**" to the one you prefer.

## External editors

There are of course several good editors out there for Lua development, but we suggest one of the following since they have tons of good plugins available.

| Name                                                         | Details                                             | Core API      | Price                  |
| ------------------------------------------------------------ | --------------------------------------------------- | ------------- | ---------------------- |
| [Visual Studio Code](https://code.visualstudio.com/download) | Popular powerful editor with many plugins           | Supported     | Free                   |
| [Atom](https://atom.io/)                                     | Middle-range power/speed editor with plugin support | Supported     | Free                   |
| [SublimeText](https://www.sublimetext.com/3)                 | Lightweight text editor with plugins                | Not Supported | Free Evaluation / Paid |
| [Notepad++](https://notepad-plus-plus.org/)                  | Very lightweight text editor                        | Not Supported | Free                   |

### Plugins / Extensions

For Visual Studio Code and Atom, we have collected a few extensions that make developing in Core and Lua easier.

#### Visual Studio Code

| Plugin Name                                                                                   | Details                                                                                    |
| --------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| [vscode-core](https://marketplace.visualstudio.com/items?itemName=ManticoreGames.vscode-core) | The official extension that adds support for the Core Games API to the Lua Language Server |
| [vscode-lua](https://marketplace.visualstudio.com/items?itemName=trixnz.vscode-lua)           | Adds Lua & Luacheck support                                                                |

As of version 1.0.0, our own extension uses [Sumneko's](https://marketplace.visualstudio.com/items?itemName=sumneko.lua) Lua [Language Server](https://microsoft.github.io/language-server-protocol/) with [auto-generated](https://github.com/kerwanp/core-types-generator) [EmmyLua](https://github.com/sumneko/lua-language-server/wiki/EmmyLua-Annotations) annotations.

!!! warning "If you have previously been using vscode-core together with the "**Lua Coder Assist**" extension, make sure to uninstall it for the best results."

Sumneko's Lua extension also comes with it's own "**Diagnostics**" feature, so if you have been using other extensions that use Luacheck and a `.luacheckrc` file, you might want to either disable those extensions or the "**Diagnostics**" feature in Sumneko's.

#### Atom

| Plugin Name                                                   | Details                    |
| ------------------------------------------------------------- | -------------------------- |
| [language-lua](https://atom.io/packages/language-lua)         | Adds Lua support           |
| [autocomplete-lua](https://atom.io/packages/autocomplete-lua) | Adds Lua autocomplete      |
| [Linter](https://atom.io/packages/linter)                     | Adds linting support       |
| [Linter UI](https://atom.io/packages/linter-ui-default)       | Adds a UI to Linter        |
| [Linter: Luacheck](https://atom.io/packages/linter-luacheck)  | Adds Lua support to Linter |

For editors where we do not provide our own editor extensions, we supply a JSON dump of our API that can be used to create one. We also provide autocompletion files with all of the Core API for Atom and every other editor that supports `.luacompleterc`.

#### API Dump

- :fontawesome-solid-download: Download: [CoreLuaAPI.json](./assets/api/CoreLuaAPI.json "CoreLuaAPI.json")

#### `.luacompleterc`

- :fontawesome-solid-download: Download: [luacompleterc.zip](./assets/api/luacompleterc.zip "API Autocomplete Files")
- :fontawesome-solid-angles-right: Install: Extract the `.luacompleterc` file to your `Documents\My Games\Core\Saved\Maps` folder.

### Installing a Linter

[Luacheck](https://github.com/luarocks/luacheck), which also serves as a static analyzer, is **the** Lua Linter to use. You can add a `.luacheckrc` config file to your project that tells it what to check for and it will point out any mistakes you may make. Check out their [documentation](https://luacheck.readthedocs.io/en/stable/) for more info. A statically linked binary with all deps included is available on [GitHub](https://github.com/luarocks/luacheck/releases/).

- :fontawesome-solid-download: Download: [Luacheck](https://github.com/luarocks/luacheck/releases/)
- :fontawesome-solid-angles-right: Install: Copy `luacheck.exe` to a folder and add it to your `PATH` environment variable. ([HowTo](https://www.architectryan.com/2018/03/17/add-to-the-path-on-windows-10/))

In addition, we provide a `.luacheckrc` settings file with all Core API so they don't show up as undeclared global variables.

- :fontawesome-solid-download: Download: [luacheckrc.zip](./assets/api/luacheckrc.zip "luacheckrc.zip")
- :fontawesome-solid-angles-right: Install: Extract the `.luacheckrc` file to your `C:\\Users\YOURUSERNAME\Documents\My Games\Core\Saved\Maps` folder.

!!! alert "If you want to use **vscode-core** together with a Luacheck extension, you might want to disable the "**Diagnostics**" feature in Sumneko's Lua extension."
