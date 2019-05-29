# IDE Tools

There are a bunch of ways you can improve the experience of scripting in Core.
If you are happy with the inbuilt editor, feel free to skip this section (it is
only intended for power users).

## External editors

Here are some popular IDEs you can use (all are free)

Name | Details
-- | --
[ZeroBrane Studio](https://studio.zerobrane.com/support) | Lua based lightweight editor
[Visual Studio Code](https://code.visualstudio.com/download) | Popular powerful editor with many plugins
[Atom](https://atom.io/) | Middle-range power/speed editor with plugin support
[SublimeText](https://www.sublimetext.com/3) | Lightweight text editor with plugins
[Notepad++](https://notepad-plus-plus.org/) | Very lightweight text editor

* Note: We (will) support autocomplete for ZeroBrane, VSCode, and Atom so those
  are the recommended editors

## IDE+

### Plugins/Extensions

VSCode

Plugin Name | Details
-- | --
[VSCode-Lua](https://marketplace.visualstudio.com/items?itemName=trixnz.vscode-lua) | Adds Lua support
[LuaCoderAssist](https://marketplace.visualstudio.com/items?itemName=liwangqian.luacoderassist) | More Lua tools

Note: in Settings->Extensions->Lua Coder Assist, disable "code metric codelens"

Atom

Plugin Name | Details
-- | --
[language-lua](https://atom.io/packages/language-lua) | Adds Lua support
[autocomplete-lua](https://atom.io/packages/autocomplete-lua) | Adds Lua autocomplete

### Autocomplete

Download and extract the following zip file (
<a test href="/img/external_editor_autocomplete_05-28-2019.zip" download>
  :fa-download:
</a>) and simply follow the directions included in the bundled setup instructions.

Copy .luacompleterc file to Platform/Saved/Maps folder, or the parent directory
where content files are stored. As long as it is in a parent directory it should
work.

!!! info
    If the date of the linked direct download is old, instead go to this
    [repository](https://github.com/ManticoreGamesInc/external-editor-api-support),
    download it as a zip, and follow the instructions for your specific editor in
    the read me file included.

### Linting

1. Download this, and remember where the file is: https://github.com/mpeterv/luacheck#windows-binary-download
2. Download the linter-luacheck plugin for Atom (just like with the other
   packages). You'll have to install dependencies for it too, just click yes
   when Atom give you the popup.
3. Go to the preferences and configure the executable path to luacheck to be
   wherever you put the file from step 1.
4. Add the following .luacheckrc file to the /maps folder (so right beside the
   .luacomplete file)
5. I believe a quick restart is required, but not sure 
6. Open up your editor and rejoice, for it will be smart and will tell you to do
   things right!

---

Alternatively download the following dependencies and build luacheck yourself
(protip: don't do this unless you have a strong need to).

* Luacheck
    * Luarocks
        * .\install /p c:\users\public\lua\LuaRocks /L /MW, add to path
        * GCC via TDM (http://tdm-gcc.tdragon.net/)
  * LuaDist (https://github.com/LuaDist/Repository/wiki/LuaDist%3A-Installation)
    * CMake (https://cmake.org/)
    * Git (https://gitforwindows.org/)