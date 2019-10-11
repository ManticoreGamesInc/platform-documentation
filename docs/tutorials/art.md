## Abstract

The Core editor comes with all sorts of built-in 3D models and props for using and combining in any way that you can imagine!

By resizing and combining different shapes and props, anything can be made!

You won’t need to understand 3D software or modeling to create beautiful art in Core. While some aspects are similar, it’s up to you how complex you wish to work. You could skip the art-making phase and use the finished props from the **Asset Manifest**, or you could browse through what other creators have shared on **Community Content**. 

*Need a pretty in-game photo here*

### Pre-Made Props & Assets

To find all the 3D models already included in Core, start by looking in the Asset Manifest, found in the bottom left window of the editor.  
This window can also be accessed via the dropdown “View → Asset Manifest”.

*Photo of Asset Manifest here*

Currently, there are 4 different sections that contain models to use right away:


- 3D Text
    - All 3D letters and symbols found on an English keyboard.
- Environment
    - Buildings, foliage, and all props related to setting a scene.
- Basic Shapes
    - Cubes, cylinders, spheres and more.
- Props
    - Whole objects like benches, shields, tables, and various gun parts.

To use any of these models, simply click and drag one out from the Asset Manifest and into the scene or the hierarchy.

*GIF of bench dragging here*

### Move, Rotate, & Scale

The red, blue, and green arrows indicate the different directions a model can be moved along. Modeling and placement uses 3 main functions: **Move**, **Rotate**, and **Scale**. These different modes can be toggled between by either clicking the different buttons at the top left of the Core editor, or by using the keys **W**, **E**, and **R**, respectively.  

![Move, Rotate, Scale](/src/img/EditorManual/Art/MoveRotateScale.PNG)

![Move, Rotate, Scale](/src/img/EditorManual/Art/TransformManipulators.GIF)

### Color Your Way: Changing Model Materials

While Core does have a distinct art style, all of this can be changed and modified to whatever your vision may be. 
The colors and patterns on a 3D model are known as “materials”. The easiest way to create a dramatic change is to alter the materials of a model--either to a completely different material, or by editing the settings of a material.

*photos of mat changes here*

When a model is selected, all of its settings will show up in the **Properties** window. To find the settings for altering a material, scroll down in the Properties window to the section labeled “Material 1”--the numbers will continue for as many different material “slots” there are.

Some models can only have one material, while others are able to have **multiple materials** applied on different parts of the model. 

*photo of mat properties here*

In the case of this “Chest Small Opened”, there are 3 different material slots. One for the metal details, one for the wooden base, and one for the treasure on the inside.

There are two ways to change these material slots:  

- **Drag a material** from the Materials section of the Asset Manifest into the Material slot in the Properties window. Check out how it’s done below:

*photo of how^ here*

Or:

- Double-click the material slot and select a material from the pop-up window:

*photo of how^ here*

You’ll notice that once a material is changed, the settings available beneath it change. These are all the “parameters” or options that can be changed about the material. Aspects like the color, whether it glows, and how metallic it looks can be changed from here. All materials have different settings, so have fun and experiment!

#### Copying a Material From One Model to Another

To copy material settings from one slot to another--including on other models--right click on the Material slot and click “Copy MUID [Material #]”. This will copy the Material itself, but not the settings you may have changed. To copy those over as well, right-click again and select “Copy Material Params for slot [#]”. 

*photo of how^ here*

To paste those into another material, right click the desired material slot and first select “Paste [Material #] MUID ####”. Now the basic material should be applied--to paste the settings you made, right click the Material slot again and click “Paste Material Params for slot [#]”. 

*photo of how^ here*

#### The Advanced Material

If you want even more customization to get the look you want, there is a material that has all kinds of settings to mess with. 

Choose **Advanced Material** when selecting a new material and alter settings from there. Options like Metallic, Emissive, Roughness, Distortion and more are editable!

*photo of spheres here*

### Getting Complex: Combining Models

Using pre-made models in Core is not the only way to create art. By arranging different props together, your imagination is the limit!

*photos of cool models here*
*All of these objects and scenes were created using basic props and shapes combined in Core.*

The process of making more complex models in Core is all about groups and folders. Build whatever shapes you would like, and use either folders or groups to combine them.

Using a **folder** to combine objects will allow you to select a single object when clicking.

Using a **group** to combine objects will select the entire group at once when clicking a single object.

*GIFs of models here*
*Folder* *Group*

Use whichever method suits your needs more.

#### Efficient Game Model Creation

A huge part of creating video games is making sure that they work, and that they run smoothly!

Whenever you create models that **will never be changing during gameplay**, and will always stay stationary, they will need to be kept in a **Static Context** folder. This way their data is never updated while the game plays, so they don’t take up power that would be useful for other mechanics.

*photo of static context here*

On the other end, you might make a model that **does move during game runtime**: like a gear that rotates or a windmill. This process of continuous movement is pretty expensive for the game to run--it can cause lag. To better optimize this, place all objects and scripts that will be moving in a **Client Context** folder.

*photo of client context here*

To understand the differences between contexts in more detail, read our Context Guide.

*GIF of rotating objects here here*

When placing objects in a Client Context folder, players will not be able to collide with them. They’ll just pass right through. To give them collision for gameplay, place other shapes around the whole object that are outside of the Client Context folder, and turn their visibility off. Make sure their Collidable checkbox is also marked. This is a great way to create **fake collision**. The player will collide with the invisible object, rather than the moving shapes.

### SHARE YOUR CREATIONS: CREATING TEMPLATES

Have you made something awesome or weird? Want to use it in your other future projects? What about letting others use it in their own games? One of the best parts about Core is the ability to create and share what we make as templates for ourselves and for others to download.

Another benefit to using templates is that when one is updated, it updates every instance of the template. So you could make a castle using a complex tower template, make a change to one tower, update the template, and then all other towers will be updated automatically for you.

#### CREATING NEW TEMPLATES

To make something a template, right click on it in the Hierarchy and choose “Create New Template From This”. Choose a name for your template, and you’ll then notice the color of the text in the Hierarchy change to green. 

#### PUBLISHING A TEMPLATE TO COMMUNITY CONTENT

Now that you’ve made a template for yourself, let’s share it with the world!

Navigate to the template you wish to publish within Project Content. Right click it, and select “Publish to Community Content”. It may prompt you to save, and then a window will open for filling out more details of your template.
