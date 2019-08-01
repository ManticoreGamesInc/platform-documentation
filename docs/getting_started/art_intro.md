# Map

## Meshes and Materials

We have an asset library, of content available to you. It's via the `Asset
Manifest` tab. Everything that _isn't_ under Project Content is material that
you can add to your scene. Note that there are categories and subcategories,
pressing the `+` will expand it. For example, we can only display castle parts
by finding that subsection and expanding it, as shown in the image below:

![](/src/img/getting_started/Asset_Manifest.png)

Now, simply drag an object in to your scene, and you'll see it appear both in
the viewport and the hierarchy!

![](/src/img/getting_started/Asset_01.png)

There's a couple things to note:

1. Widget
2. Hierarchy - Element
3. Properties
4. Properties - Mesh
5. Properties - Material

> Widget

The 3D Widget is how you modify the tranformation of elements in 3D space inside
the editor. You'll note it currently has the translation tool selected. You can
change to the rotate or scale tools by pressing the icons at the top, or by
pressing the `W`, `E`, or `R` hotkeys, respectively. 

!!! Note
    In this example grid is enabled, so every translation will move the object
    by 50 units.

> Hierarchy - Element

The object was added to the hierarchy. You can move it around, add it to a
folder or group, toggle the visibility or lock it from being altered. Operations
in the hierarchy become much more useful when more objects are added to the
scene.

> Properties

Our empty properties panel from before is now full of information, as we have an
object selected. Note that some elements have tooltips, which will appear after
hovering over the name (e.g. `Visible`) for a second.

> Properties - Mesh

This is the object we dragged in, in our case the arch shape.

> Properties - Material

This is the default material, in our case the stone texture. Note that it can be
replaced by using other materials.

!!! info
    In the simplest terms, the mesh is the shape and the material is the
    appearance. By mixing and matching the two, there is a lot of room for
    creative expression.

#### Mixing Materials

Let's explore what the possibility of applying new materials gives us.

First, select the arch as before. Next, apply a new material to it, e.g. sand,
by using the searchbar in the Asset Manifest,
finding `Sand (tileable)` and then dragging and dropping that on the material
field for the arch, we now have a nice sandstone
arch instead of one made of stone! You can even recolor it, or change to scale
(e.g. coloring it black and changing the texture scale to 100 gives the
appearance of a menacing stone arch sculpted out of some smooth igneous stone).
Apply a grass texture, tint it cyan and suddenly you have the entrance to an
elven hedge maze - the possibilities are endless!

### Camera Manipulation and Moving in a 3D Space

To really manipulate your objects, you'll want to know how to move the camera
around in this 3D space.

To rotate the camera:

Hotkey | Action
--- | ---
Right click + move mouse | Move camera
Hold mouse wheel + move mouse | Pan camera

To move in 3D Space:

Hotkey | Action
--- | ---
Right click + `QWEASD` | Move up, forward, down, left, back, right (respectively)
Scroll mouse wheel | Move forwards and backwards
Hold `C`/`Shift` | Move slower/faster

Optional Tools:

Hotkey | Action
--- | ---
`Alt` + left click drag (+ `Shift`) | Orbit around point, using shift just keeps it in the same position

Also, don't forget about the configurable editor camera settings in the top
right of the editor! This can be tremendously helpful, especially if you are
working on something large scale or something very detailed.

Lastly, all the hotkeys can be found by going to `Help -> Hotkeys`, or by
clicking
[here](https://docs.google.com/spreadsheets/d/1kCLYmrwiNemczk1E3S1uYLNcIxBA5LPaIpZlGkCkoG8/edit?usp=sharing).

!!! Takeaway
    In essence, this configuration results in the user typically just holding down right click, using
    WASD and the mouse wheel (and Shift as needed) to move, and aiming the
    camera as you see fit. Then, if you need to model as 3D object, using the orbit keys
    (alt + left click) can be very helpful to see it from all angles easily.
    Play around with it, it's more intuitive than this wall of text describes :)

## Creating a Scene

TODO:

- Add new sky
- Remove old sky and floor
- Make new objects, group in hierarchy
- Use hotkeys to make this faster
- ???
- Profit

## Wrapping Up

Now that you're done, don't forget to save, and you should be good to go!

Hotkey | Action
--- | ---
Ctr + S | Save

Next up is adding functionality through scripting.