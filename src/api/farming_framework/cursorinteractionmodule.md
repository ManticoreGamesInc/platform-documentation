---
id: cursor interaction module
name: Cursor Interaction Module
title: Cursor Interaction Module
---

# Cursor Interaction Module

## Functions

| Class Function Name | Return Type | Description | Tags |
| ------------------- | ----------- | ----------- | ---- |
| `BeginDrag(Vector3, Vector3, string, boolean, boolean, Vector3)` | `None` | Begins dragging the current target. | None |
| `ClearOverrideSettings()` | `None` | Clears any override settings if they exist. | None |
| `Deselect(CoreObject, string, Player)` | `None` | Removes the target from the current selection set for a player. | None |
| `EndDrag()` | `None` | Stops dragging the current target. | None |
| `GetDragInfo()` | `table` | Returns a table with drag information. This table contains the following information: - IsDragging - True if a drag is currently happening - DragTarget - The target currently being dragged - DragData - Any drag data associated with the target (See SetDragData()) - DropTargetId - Any drop target id for a target underneath the dragged object - DropTargetData - Any drop target data for a target underneath the dragged object (See SetDropTargetData()) - OriginalParent - The original parent of the dragged object - StartPosition - The position of the object when the drag started - StartRotation - The rotation of the object when the drag started - InputOffset - The distance between the input and the object when the drag started - ResetOnDrop - If true the object will reset its position and rotation when dropped - ValidDropTargetIds - The valid drop target ids for this object - SnapToInput - If true the object will move to the input when the drag starts - SnapOffset - The offset the object will maintain from the input while being dragged | None |
| `GetInputPosition()` | `Vector3` | Returns the current position for this Input Module. | None |
| `GetPotentialTargets()` | `table` | Returns the current potential targets or an empty table. This module does not work in the same way as APIPointerInteractionModule and APILookInteractionModule so it cannot track multiple potential targets. | None |
| `GetSelection(string, Player)` | `table` | Returns the selection set for a player. | None |
| `IsDragging(CoreObject)` | `boolean` | Returns true if the target is being dragged. | None |
| `IsSelected(CoreObject, string, Player)` | `boolean` | Returns true if the target is in the selection set for a player. | None |
| `OverrideSettings(table<InteractionSetting, any>)` | `None` | This allows objects using this module to temporarily override settings. | None |
| `RegisterDraggable(CoreObject, UIButton, table)` | `boolean` | Registers a draggable target and handlers with this input module. The handlers can include any of the below callbacks: - SetDragData(isValidDragFunction, getDragProxyFunction, ...) - GetDragData() - IsValidDrag() - GetDragProxy() | None |
| `RegisterDropTarget(CoreObject, UIButton, table)` | `boolean` | Registers a drop target and handlers to use with this input module. The handlers can include any of the below callbacks: - IsValidDropTarget(dropTargetIds, ...) - SetDropTargetData(isValidDropTargetFunction, ...) - GetDropTargetId() - GetDropTargetData() | None |
| `RegisterTarget(CoreObject, UIButton, table)` | `boolean` | Registered targets will be checked each frame for cursor interactions. Targets will be unregistered automatically when they are destroyed. A target can be registered multiple times with different handlers to allow components to stack. The handlers can include any of the below callbacks: - HoverBegin(position, normal) - Hover(position, normal) - HoverEnd(position, normal, wasDragging) - PressBegin(binding, position, normal) - PressEnd(binding, position, normal, wasDragging) - DragOverBegin() - DragOverEnd() - DragBegin(position, normal) - DragEnd(position, normal) - Dropped(position, normal, ...) - Selected() - Deselected() - SetData(component, ...) | None |
| `Select(CoreObject, string, Player)` | `None` | Adds the target to the current selection set for a player. | None |
| `UnregisterDraggable(CoreObject)` | `None` | Unregisters a draggable and all of its input handlers with this input module. It can be called manually if needed but will normally be automatically called. | None |
| `UnregisterDropTarget(CoreObject)` | `None` | Unregisters a drop target and all of its handlers with this input module. It can be called manually if needed but will normally be automatically called. | None |
| `UnregisterTarget(CoreObject)` | `None` | This will unregister a target and all of its input handlers. It can be called manually if needed but will normally be automatically called. | None |
