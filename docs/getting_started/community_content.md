# Shared Content

Shared content is one of the most fundamentally important aspects of game
creation in Core. It allows for you to use, improve, and remix creations you or
others have made public in order to create a wealth of content for all game
creators on the platform - speeding up game development more than ever before.
With that in mind, here's how to use it.

!!! Warning
    The shared content for Staging and Production is _not_ the same.

## Using Shared Content

Open up the `Shared Content` tab (go to `View -> Shared Content` to open the
window if you don't see it already).

Here you can browse the content or search (by username or template name).

Press the `+` button to import the template, and then you can see it in your
`Asset Manifest -> Project Content -> Imported Shared Content`.

!!! Note
    To see sub-content brought along by each template, click on each element in
    the expanded category of imported shared content.

## Importing A New Map

- Go to `Object -> Remove Old Sky`
- Go to shared content and import `ForestArena`
- Go to Project Content and drag the template into the 3D Viewport or the Hierarchy
- Run around the fancy level, examine it in the hierarchy to see how it was
  constructed, etc.

## Importing New Game Logic

- Go to shared content and import `FFA_GameMode`
  - Like before, it has to be dragged into the hierarchy
- Check out the READ_ME for details, or just play around

Optionally, add weapons via `FFA_Spawners` and you have a full game mode!

!!! Warning
    This is not a perfect example, it is outdated and doesn't follow all the
    best practices - it is simply included as inspiration for if you need some
    direction; don't follow it exactly.

## Next Steps

Feel free to publish the game and play with others (save the map, exit to the
main menu, and click on the game, choose publish, and then go to the site
[[staging](https://staging.manticoreplatform.com)/[production](https://prod.manticoreplatform.com)])

Browse [examples](/examples), download them, and play around with everything!

---

# Abstract

Collaboration is an important aspect of art and design as well as key to developing rich and unique games. Templates are a fundamental tool to Core that enables creators to develop assets and publish them to be used by other creators across the platform.

Templates can be created, shared, and updated in real time across the platform. Enabling creators to quickly and dynamically make changes to their scenes and games.

Templates can be identified in the Asset Manifest by this icon: ![TemplateIcon](/img/EditorManual/UI/templateicon.PNG)


# Tutorial
## Creating A Template
Creating a template is fast and easy! To make a template follow these steps:

1. Drag in your assets from the Asset Manifest. Place them how you’d like.
2. When satisfied with your creation, select all assets in the hierarchy that you desire to be in the template. Right click and select “Group and Create New Template from These”.
![TemplateTut1](/img/EditorManual/UI/TemplateTut1.PNG)

!!! note "Alternatively you can group the assets first and then create the template. You'll find that like a lot of game development software, ther are multiple ways to go about achieving a task. The process is whichever comes natural to you!"

3. Name Your Template and click the New Template button.
![TemplateTut2](/img/EditorManual/UI/TemplateTut2.PNG)

The template is now recognized in your project as its own object and can be found in the Project Content folder of the Asset Manifest and you may quickly and easily drag out multiple instances into your scene.

Once your template is created, you may use it for just this project alone, or you can now publish the template to Shared Content. Unpublished templates have white names in the Project Content folder while published template names are green. However, Templates in the hierarchy will always be green, published or not.
![TemplateTut3](/img/EditorManual/UI/TemplateTut3.PNG)

## Publishing Your Template
1. Click on your template in the Project Content Folder of the Asset Manifest.
2. You may either right click and select Publish to Shared Content OR click the Publish to Shared Content button in the Properties menu.
![TemplateTut4](/img/EditorManual/UI/TemplateTut4.PNG)
3. This option box will appear:

![TemplateTut3](/img/EditorManual/UI/TemplateTut5.PNG)

a. Check or create a new template name. A template’s name must be between 5 to 30 characters.

b. Write a description for your template. A template’s description must be between 1 to 255 characters.

c. Mark your permissions as either public or private. If private, only you can see the template in Shared Content. If public, the template can be seen and used by everyone on the platform.

4. Click Review & Publish and review your settings, but don’t worry as they may be edited after publishing.
5. Click Publish.

The template’s white name should now be green and the template can be found and downloaded from Shared Content. From here, you may edit, re-download or delete templates you’ve published!
![TemplateTut4](/img/EditorManual/UI/TemplateTut6.PNG)

Congratulations! You’ve created, edited, and published a template that can be shared and used by other creators in Core!
## Tips and Tricks with Templates!
### Deinstancing Templates

Once your template is created, you must “deinstance” it in order to edit the template again. Deinstancing a template still keeps its reference in mind, but allows you to make changes so that you can re-update or re-upload the template.

To deinstance a template, right click and select “Deinstance this object”.

![TemplateTut5](/img/EditorManual/UI/TemplateTut7.PNG)

The object’s name will now be blue and you may edit the template as you wish!
Don’t like the changes you made? You can always select “Reset to Template” to restore back to the original template.

### Updating Templates

Have tons of instances of a template in your scene but you want to do something as minor as change their material? Have no fear! With templates, you can make changes and update every instance of that template in your scene at once.

Updating templates is based only in your project. If you wish to update a template across the platform, you must select the template in the Project Content Folder and click the Republish button in the Properties menu.

To update a template, simply right click on an altered template, deinstanced or not and select “Update template from this”. You should be able to see all the instances of that template change in your scene!

### Downloading Latest

If another creator has re-published their template across the platform, in order to assign the changes to the template in your project you must download the latest version of the shared template.

To download the latest template, either right click on the template in Asset Manifest and select Download Latest OR select the template and click the Download Latest Button. 

# Examples

Link to examples, with at least one good example project (WIP)