!!! warning
    Flagged for Review.
    Incomplete or outdated information may be present.

## Abstract

The CORE™ editor comes with all sorts of built-in 3D models and props for using and combining in any way that you can imagine!

By resizing and combining different shapes and props, anything can be made!

You won’t need to understand 3D software or modeling to create beautiful art in CORE. While some aspects are similar, it’s up to you how complex you wish to work. You could skip the art-making phase and use the finished props from the **Asset Manifest**, or you could browse through what other creators have shared on **Community Content**.

![Carnival](../../img/EditorManual/Art/carneval_screenshot.jpg)

----

### Pre-Made Props & Assets

To find all the 3D models already included in CORE, start by looking in the **Asset Manifest**, found in the bottom left window of the editor.

This window can also be accessed via the dropdown “View → Asset Manifest”.

![Asset Manifest](../../img/EditorManual/Art/AssetManifest.png)

Currently, there are 4 different sections that contain models to use right away:


- **3D Text**
    - All 3D letters and symbols found on an English keyboard.
- **Basic Shapes**
    - Cubes, cylinders, spheres and more.
- **Environment**
    - Buildings, foliage, and all props related to setting a scene.
- **Props**
    - Whole objects like benches, shields, tables, and various weapon parts.

These larger categories also have subcategories, that can be opened by clicking the little gray arrow:

![Asset Manifest Drop Downs](../../img/EditorManual/Art/AssetManifestDropDowns.png)

To use any of these models, simply click and drag one out from the Asset Manifest and into the scene or the hierarchy.

![Drag out Assets](../../img/EditorManual/Art/DragOutAsset.gif)

----

### Move, Rotate, & Scale

![Move, Rotate, Scale](../../img/EditorManual/Art/MoveRotateScale.png)

The red, blue, and green arrows indicate the different directions a model can be moved along. Modeling and placement uses 3 main functions: **Move**, **Rotate**, and **Scale**. These different modes can be toggled between by either clicking the different buttons at the top left of the CORE editor, or by using the keys **W**, **E**, and **R**, respectively.

![Move, Rotate, Scale](../../img/EditorManual/Art/TransformManipulators.gif)

----

### Color Your Way: Changing Model Materials

While CORE does have a distinct art style, all of this can be changed and modified to whatever your vision may be.
The colors and patterns on a 3D model are known as “materials”. The easiest way to create a dramatic change is to alter the materials of a model--either to a completely different material, or by editing the settings of a material.

![Different Materials](../../img/EditorManual/Art/differentMats.png)

When a model is selected, all of its settings will show up in the **Properties** window. To find the settings for altering a material, scroll down in the Properties window to the section labeled “Base Material”. Different objects may have different names for their material slots.

Some models can only have one material, while others are able to have **multiple materials** applied on different parts of the model.

![Material Properties](../../img/EditorManual/Art/AssetMaterialSlots.png)

In the case of this “Craftsman Chair 01”, there are 3 different material slots. One for the wooden base, one for the cushion, and one for the metal details.

There are two ways to change these material slots:

- **Drag a material** from the Materials section of the Asset Manifest into the Material slot in the Properties window. Check out how it’s done below:

![Drag a Material](../../img/EditorManual/Art/DragMaterialOut.gif)

Or:

- **Double-click the material slot** and select a material from the pop-up window:

![Double-Click a Material](../../img/EditorManual/Art/DoubleClickMaterialSlot.gif)

Applying materials in this way allows you to adjust the color of the material. To alter even more options for the material, such as roughness and emissive amount, you can create your own custom material.

#### Creating Your Own Custom Materials

In your own project, you have the ability to create **Custom Materials**. This allows you to customize the settings of a specific material, and apply it to multiple objects. This way when your custom material is updated, it changes all models with that material at once!

!!! info "Even More Material Tips"
    To read more about creating custom materials, as well as more in-depth details about materials, check out our **Materials Guide**.

![Different Materials](../../img/EditorManual/Art/differentMats2.png)

----

### Getting Complex: Combining Models

Using pre-made models in CORE is not the only way to create art. By arranging different props together, your imagination is the limit!

![Bug Ship](../../img/EditorManual/Art/BugShip.gif)
*All of these objects and scenes were created using basic shapes and props combined in CORE.*

The process of making more complex models in CORE is all about groups and folders. Build whatever shapes you would like, and use either folders or groups to combine them.

Using a **folder** to combine objects will allow you to select a single object when clicking. See this below:

![Folder](../../img/EditorManual/Art/FolderSelect.gif)

Using a **group** to combine objects will select the entire group at once when clicking a single object:

![Group](../../img/EditorManual/Art/groupSelect.gif)

Use whichever method suits your needs more.

#### Efficient Game Model Creation

A huge part of creating video games is making sure that they work, and that they run smoothly!

Whenever you create models that **will never change during gameplay** and will always stay stationary--such as a tree--they will need to be kept in a **Static Context** folder. This way their data is never updated while the game plays, so they don’t take up power that would be useful for other mechanics.

![Dragon Set](../../img/EditorManual/Art/staticContext.png)

On the other end, you might make a model that **does move during game runtime**: like a gear that rotates or a windmill. This process of continuous movement is pretty expensive for the game to run--it can cause lag. To better optimize this, place all objects and scripts that will be moving in a **Client Context** folder.

![Dragon Set](../../img/EditorManual/Art/ClientContextFolder.png)

!!! info "Give Me More Context, Please"
    To understand the differences between contexts in more detail, read our **Context Guide**.

![Dragon Set](../../img/EditorManual/Art/ClientContextCollision.gif)

When placing objects in a Client Context folder, players will not be able to collide with them. They’ll just pass right through. To give them collision for gameplay, place other shapes around the whole object that are outside of the Client Context folder, and turn their visibility off. Make sure their Collidable checkbox is also marked. These settings can be changed from the object's Properties window.

This is a great way to create **fake collision**. The player will collide with the invisible object, rather than the moving shapes.

----

### Share Your Creations: Creating Templates

Have you made something awesome or weird? Want to use it in your other future projects? What about letting others use it in their own games? One of the best parts about CORE is the ability to create and share what we make as **templates** for ourselves and for others to download.

Another benefit to using templates is that when one is updated, it updates every instance of the template. So you could make a castle using a complex tower template, make a change to one tower, update the template, and then all other towers will be updated automatically for you.

#### Creating New Templates

To make something a template, right click on it in the Hierarchy and choose “**Create New Template From This**”. Choose a name for your template, and you’ll then notice the color of the text in the Hierarchy change to green.

![Create New Template](../../img/EditorManual/Art/CreateNewTEmplate.png)

#### Publishing a Template to Community Content

Now that you’ve made a template for yourself, let’s share it with the world!

Navigate to the template you wish to publish within Project Content. Right click it, and select “**Publish to Community Content**”. It may prompt you to save, and then a window will open for filling out more details of your template.

![Publish](../../img/EditorManual/Art/publishToCC.png)

![Publish Dialog Box](../../img/EditorManual/Art/PublishtoCCBox.png)

In this window, you can name your template and give it a description. Make sure to check the box **Is Public** for other players to find it. When you’re ready, click “**Review & Publish**”. Confirm that everything looks right, and click Publish.
Now other users can find and search for your template on Community Content!

#### Updating and Republishing Templates

One of the huge benefits of templates is being able to update many objects at the same time! When using several of the same template, changes can be made to one and then automatically sent to update all the others.

![Update Template](../../img/EditorManual/Art/updateTemplate.gif)

You will notice when making changes to a template, it will ask if you would like to “**Deinstance**” the template. Click yes when this prompt appears.
A deinstanced template will have text color change from green to blue. It is still a template, but has changes that the other instances of this template will not.

Once you have made changes you would like to send to all other instances of the template, right click the altered template. Click “**Update Template From This**” to send changes. All the templates will now match the updated one!

![Update Template From This](../../img/EditorManual/Art/updateTempFromThis.gif)

This will update the template for your project personally, but in order to update a template that has been published to Community Content, we will need to re-publish the template.

In your Project Content, find the published template that you wish to update. Right click the template, and click “**Republish**”. It’ll bring up the same window as for Publishing a template, so that you may update the description if you like.

![Republish](../../img/EditorManual/Art/RepublishTemplate.png)

"**Download Latest**" will update your local project template with whatever the most recent published version of template exists on Community Content.

#### I Change My Mind: Resetting a Deinstanced Template

When you make a change to an instance of a template, the text turns blue and it is “Deinstanced”. There might be times when you don’t like the changes you’ve made, and you would like to return to your original template.

To do this, right click an object in the template and select “**Reset to Template**”. This will revert the template back to the original design!

#### Downloading & Using Other Creator’s Templates

Templates made by other people can be downloaded from Community Content and re-used as anything you like. This is a great way to focus on getting to your final idea faster than creating everything from scratch!

If you wish to publish a re-used template to Community Content, it must be as its own new and separate template.

![Community Content Template](../../img/EditorManual/Art/CCtemplate.png)
