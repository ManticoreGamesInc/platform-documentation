### Abstract

A core component of making quality video games is good user interface design. Health bars, time limits, and dialogue are all in the category of user interface, also abbreviated as “UI”. This includes anything that you want to display in 2D to the player. CORE comes with built-in progress bars, images, and buttons that can all be used to make any kind of UI.


- Creating UI in CORE is mostly a drag-and-drop process.

- All UI elements can be found under View > UI Editor.

- All of these do different things and be combined in different ways. 

- All UI elements need to be contained within a Canvas widget. Drag a Canvas widget into the hierarchy to start working on UI.

!!! info
    Words like *widget*, *control* and *element* are used interchangeably here to refer to a CoreObject that is dragged from the UI Editor.

### Tutorial


Each widget works a little differently, but all are set up in the same basic way. 
Below is an example using the Text Box control:


1. Click on View in the top left of the CORE window. 

2. At the bottom of the list, click "UI Editor" to view all UI options.

3. Drag a Canvas into the Hierarchy window.

4. Drag a Text Box into the Canvas to display the text directly onto the screen.

5. Move the Text Box into the desired location using either the white dotted bounding box around the element in the editor window, or by adjusting the numbers of the X / Y Offset in the Properties window.  
 ![TextBoxPropertiesWindow](/img/EditorManual/UI/WidgetExampole.PNG)

6. The Text Box has several properties that can be changed via the Properties window, that all alter the display and behavior of a UI element on different screens.


!!! info "Widget Placement for Different Screen Resolutions"
    Once dragged in, if the widget is properly in the Canvas, it should be showing up in the top left corner. 
    It is in this location because it is by default **anchored** and **docked** to the top left.  
     UI elements need to be anchored to a part of the screen so that the elements still snap to the correct locations on different screen resolutions. These positions can be changed in the Properties window.


![TransformBoundingBox](/img/EditorManual/UI/TextBoxUiElement.PNG)

Adjustable properties of the Text Box: 


**X and Y Offset** determine the position away from the anchor origin that the UI widget will display. 

**Width and Height** refer to that of the widget.

**Inherit Parent Size** will determine whether the widget stretches in size to fit the transformations of the parent.

**Transform Pivot** is where changes to height and width will start from.

**Rotation Angle** is as it says--based on the Transform Pivot.

**Text** is unique to the Text Box control and determines what text is displayed.

**Color** decides the color of the font.

**Size** is the size of the font.

**Justification** is the alignment of the text within the text box.


Different widgets will have slightly different settings in the properties window, and all of these can be manipulated both in-editor and in code.

!!! info "For Scripting Help"
    *See Lua API for functions & properties of UI controls.*

### CORE 2D Images

There is a large collection of different images to use in Core. These could be stretched, layered, and combined in any sort of way to create UI!

These are all the current images available to use in Core:

![UI Borders](/img/EditorManual/UI/uiAssets_borders.png)
![UI Buttons](/img/EditorManual/UI/uiAssets_buttons.png)
![UI Icons](/img/EditorManual/UI/uiAssets_icons.png)
![UI Reticles](/img/EditorManual/UI/uiAssets_reticles.png)

### Example

*FAA_GameMode* includes functioning UI. 

*Have U Herd?* Includes functional commented UI.
