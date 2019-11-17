# Welcome to the CORE Creator Hub

!!! warning
    Flagged for Review.
    Incomplete or outdated information may be present.

Welcome to the official documentation of CORE, the community-focused game creation tool!

This page aims at giving a broad presentation of the engine and of the contents of this
documentation.

## About CORE

This is the official documentation for CORE, the game editor built by [Manticore].

A game engine is a complex tool, and it is therefore difficult to present CORE in a few words. There
are however a few things that set us apart:

- **AAA quality on an accessible level.**  For creators this means you can make amazing content at
  rapid speed, and for players it means a wealth of great games at their fingertips.
- **Built-in multiplayer.** This saves creators tons of time and allows for a great interactive
  experience for players.
- **Social gaming.** Shared, communal content for creators and users alike means everyone is
  involved in the latest and greatest games.
- **Mutually aligned interests.** Manticore is committed to empowering creators and helping players,
  so everyone is here to participate in something truly amazing.

In essence, we are doing our best to _make game creation as enjoyable as possible_.

For details regarding the engine, you are encouraged to read this documentation further, especially
the [Getting Started] section.

Alternatively, check out the list of topics to the left to get started.

## About the Documentation

This documentation is continuously written and edited by both Manticore as well as members of the
community. Contributions are more than welcome! It is easy to do so, as files are simply text files
with some [Markdown] extras for formatting. We then compile the markdown files into a static website
using the open source [MkDocs] tool, and host the site using [Netlify].

!!! info "Contributions Welcome!"
    Just click on the :fa-edit: icon on the top right of any page.

    You'll need a GitLab account, with contribution permissions. If you
    don't already have that, just email
    [max@manticoregames.com](mailto:max@manticoregames.com) with the name of
    your GitLab account (make one if necessary first) to get set up.

    More specific contribution details can be found [here](https://gitlab.com/manticore-games/platform-documentation/blob/production/CONTRIBUTING.MD), if needed.

## Organization of the Documentation

- The [Getting Started] section is the main purpose of this documentation, as it contains all the
  necessary information on using the engine to make games. It includes the [Light Bulb] tutorial
  which should be the entry point for all new users. It also contains the [FAQs].
- The [Scripting] section is also intended for all users that intend to add gameplay elements, as it
  contains all the information you need to know about scripting in CORE. It includes sections on Lua
  (including a primer for programmers and resources for complete beginners), as well as best
  practices and debugging tools.
- The [Project Workflow] expands on the previous sections with information on
  how to set up the workspace to get the most out of the CORE editor.
- The [Editor Manual] section contains specific information on the various
  aspects of the editor, encompassing everything from GUIs to hotkeys to networking.
- The [Tutorials] section, on the other hand, can be read as needed, in any order. It contains both
  full games and various feature-specific tutorials. This is the best place to go for information on
  larger projects.
- The [Community] section points to various community channels like Reddit and Discord and contains
  a list of recommended third-party tutorial links.
- Finally, the [CORE API] section is provided as a reference. It is generated automatically,
  and therefore is the only section that strictly cannot be edited by community
  members.
  Note: Currently WIP, check out the Google Doc [here](https://docs.google.com/document/d/1l4yKz5lT2hr2RJd_yewYMGJA6hZ9O3zbbnSa79n9anE) for the API reference.

In addition to this documentation you may also want to take a look at the various [example]
projects and templates.

Have fun reading and making games with CORE!

[Manticore]: http://www.manticoregames.com/

[Getting Started]: /getting_started/step_by_step
[Markdown]:https://daringfireball.net/projects/markdown/syntax
[MkDocs]: https://www.mkdocs.org/
[ReadTheDocs]: https://readthedocs.org/
[Netlify]: https://www.netlify.com
[Godot]: https://godot.readthedocs.io/en/3.0/
[Material]: https://squidfunk.github.io/mkdocs-material

[FAQs]: /faqs
[Light Bulb Game]: tutorials/gameplay/lua_basics_lightbulb.md
[Scripting]: /scripting/lua/introduction
[Project Workflow]: /project_workflow/project_setup
[Editor Manual]: /editor/overview
[Tutorials]: /tutorials/
[Community]: /community/links
[example]: /examples/links
[CORE API]: core_api.md
