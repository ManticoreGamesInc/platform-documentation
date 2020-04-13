---
id: collaboration
name: Collaboration Reference
title: Collaboration Reference
tags:
    - Reference
---

# Templates in Core

## Overview

Have you made something awesome or weird? Want to use it in your other future projects? What about letting others use it in their own games? One of the best parts about Core is the ability to create and share what we make as **templates** for ourselves and for others to download.

Collaboration is an important aspect of art and design as well as key to developing rich and unique games. Templates can be created, shared, and updated in real time across the platform.

When one template is updated, it updates every instance of the template. So you could make a castle using a complex tower template, make a change to one tower, update the template, and then all other towers will be updated automatically for you.

!!! info "What IS a template?"
    Think of a template as a package of things you made, exactly the way you made them.

    You could make a palm tree that drops coconuts when a player walks up to it, and by turning the scripts and objects that make this palm tree into a template, you can share this with anyone so they may make their own palm tree forests!

    Or perhaps they'll modify it to drop a monkey. That's the beauty of template sharing!

Templates can be identified in the **Core Content** tab by this icon: ![TemplateIcon](../img/EditorManual/UI/templateicon.png "Templates are signified by a set of three cubes."){: .center}

- **Completion Time:** 5 minutes
- **Knowledge Level:** None needed!
- **Skills you will learn:**
    - How to make a template
    - How to publish a template to Community Content & what that means

---

## Tutorial

### Creating A Template

Creating a template is fast and easy! To make a template follow these steps:

1. Drag in your assets and objects from Core Content. Arrange and organize them how you'd like.

     Templates can contain 3D objects, scripts, vfx, or whatever else you want to combine.

2. When satisfied with your creation, select all assets in the project Hierarchy tab that you desire to be in the template. Right click on them and select "Group and Create New Template from These".

      ![TemplateTut1](../img/EditorManual/UI/TemplateTut1.png "Right click all of your selected objects at once in the Hierarchy."){: .center}

      *Alternatively you can group the assets first and then create the template. You'll find that like a lot of game development software, there are multiple ways to go about achieving a task. The process is whichever comes natural to you!*

3. Name your template and click the **New Template** button.

     ![TemplateTut2](../img/EditorManual/UI/TemplateTut2.png "Pick somethin' catchy."){: .center}

     The template is now recognized in your project as its own object and can be found in the **Project Content** folder of **Core Content** and you may easily drag out as many instances of your template into your scene as you like. *(And that your game can handle--keep an eye on that Perfromance tab to see if you have too many objects!)*

!!! info "The Hierarchy text color changed?"
     Once something becomes a template, its name changes to **blue**{: style="color: var(--core-color-templetized)"} text.

### Publishing Your Template

Once your template is created, you may use it for just this project alone, or you can now further publish the template to **Community Content** for sharing with others and between different projects.

1. Click on your template in the **Project Content** folder of **Core Content**.

2. You may either right click and select Publish to Community Content OR click the Publish to Community Content button in the Properties menu.

     ![Publish](../img/EditorManual/UI/PublishToCC.png "Publish by right clicking--"){: .center}
     ![Publish](../img/EditorManual/UI/PublishToCC_properts.png "Or publish via the Properties window!"){: .center}

3. This dialogue box will appear:

     ![Publish Dialog Box](../img/EditorManual/Art/PublishtoCCBox.png "Fill this up with info about your template."){: .center}

     a. Check or create a new **template name**.

     b. Write a **description** for your template.

     c. Mark your **permissions** as either public or private. If private, only you can see the template in Community Content. If public, the template can be seen and used by everyone on the platform.

     d. **Release notes** are useful as you update and re-publish your template, so that you may explain what changes you have made!

     e. **Tags** are great for helping your template be found easier in Community Content.

     f. **Screenshots** for glamour and fame!

4. Click **Review & Publish** and review your settings. Don't worry about it being perfect, as this may all be edited after publishing.

5. Click **Publish**.

   While still within **Project Content**, the template's white name should now be green and the template can be found and downloaded from **Community Content**. From there, anyone can download your template and use it for even more awesome content! Of course, this is only if you set your template to *public*.

   By setting your template to *private*, only you will be able to download it from Community Content into other projects. This can be very handy for working on a template on different computers without having to publish the work-in-progress version of what you are making.

![TemplateTut4](../img/EditorManual/UI/greenUserTemplate.png "Your template has been greenlit!"){: .center}

Congratulations! You've created, edited, and published a template that can be shared and used by other creators in Core!

![TemplateTut4](../img/EditorManual/UI/TemplateTut6.png "image_tooltip"){: .center}

---

### Tips and Tricks with Templates

#### Updating and Republishing Templates

One of the huge benefits of templates is being able to update many objects at the same time! When using several of the same template, changes can be made to one and then automatically sent to update all the others.

<div class="mt-video">
    <video autoplay loop muted playsinline poster="/img/EditorManual/Abilities/Gem.png">
        <source src="/img/EditorManual/Art/updateTemplate.webm" type="video/webm" />
        <source src="/img/EditorManual/Art/updateTemplate.mp4" type="video/mp4" />
    </video>
</div>

You will notice when making changes to a template, it will ask if you would like to "**Deinstance**" the template. Click "**Yes**" when this prompt appears.
A deinstanced template will have text color change from *blue*{: style="color: var(--core-color-templetized)"} to *teal*{: style="color: var(--core-color-deinstanced)"}. It is still a template, but has changes that the other instances of this template will not.

Once you have made changes you would like to send to all other instances of the template, right click the altered template. Click "**Update Template From This**" to send changes. All the templates will now match the updated one!

<div class="mt-video">
    <video autoplay loop muted playsinline poster="/img/EditorManual/Abilities/Gem.png">
        <source src="/img/EditorManual/Art/updateTempFromThis.webm" type="video/webm" />
        <source src="/img/EditorManual/Art/updateTempFromThis.mp4" type="video/mp4" />
    </video>
</div>

This will update the template for your project personally, but in order to update a template that has been published to **Community Content**, we will need to re-publish the template.

In your **Project Content**, find the published template that you wish to update. Right click the template, and click "**Republish**". It'll bring up the same window as for publishing a template, so that you may update the description if you like.

![Republish](../img/EditorManual/Art/RepublishTemplate.png "Republish"){: .center}

"**Download Latest**" will update your local project template with whatever the most recent published version of the template exists on **Community Content**.

---

#### I Change My Mind: Resetting a Deinstanced Template

When you make a change to an instance of a template, the text turns *teal*{: style="color: var(--core-color-deinstanced)"} and it is "**Deinstanced**". There might be times when you don't like the changes you've made, and you would like to return to your original template.

To do this, right click the template within the Hierarchy and select "**Reset to Template**". This will revert the template back to the original design!

---

#### Downloading & Using Other Creator's Templates

Templates made by other people can be downloaded from **Community Content** and re-used as anything you like. This is a great way to focus on getting to your final idea faster than creating everything from scratch!

If you wish to publish a re-used template to Community Content, it must be as its own new and separate template.

![Community Content Template](../img/EditorManual/Art/CCtemplate.png "Community Content Template"){: .center}
