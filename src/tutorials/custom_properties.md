---
id: custom_properties
name: Custom Properties
title: Custom Properties
tags:
    - Reference
---

# Custom Properties

## Summary

**Custom Properties** are incredibly powerful tools that allow game creators to assign custom values as a part of an object, template, or script. These values can be edited in the editor or during runtime to allow for easy customization and to give something its own configuration or personality.

## Adding Custom Properties

There are two major ways to add a **Custom Property** to an object.

### Add Custom Property Button

This is the best option for many simple data types like strings, numbers, and booleans.

1. Left-click on the object that the **Custom Property** should be assigned to.
2. Left-click on the **Add Custom Property** button at the bottom of the **Properties** panel.
3. Left-click on the data type the value of the **Custom Property** will contain.
4. Type the name the **Custom Property** will be referred by.
5. Edit the value of the **Custom Property** as needed.

### Drag-and-Drop

This is the best option for complex/advanced data types like Core Object References, Asset References, and Net References.

1. Left-click on the object that the **Custom Property** should be assigned to.
2. Hold left-click on the other object that will be the **Custom Property** for the first object.
3. Drag the other object into bottom of the **Properties** panel of the first object.

## Copying Custom Properties

**Custom Properties** can be copied and pasted to other objects.

1. Left-click on the object that the **Custom Properties** should be copied from.
2. Right-click on or around the **Add Custom Property** button at the bottom of the **Properties** panel.
3. Left-click **Copy All Custom Properties**.
4. Left-click on the object that the **Custom Properties** should be pasted to.
5. Right-click on or around the **Add Custom Property** button at the bottom of the **Properties** panel.
6. Left-click **Add Copied Custom Properties**.

!!! note
    When copying-and-pasting an object itself, all of the **Custom Properties** of the original object will already be pasted into the copied object.

## Editing Custom Properties Through Script

**Custom Properties** can by edited during runtime through scripts.

### Enable Networking

Firstly, the object and the **Custom Property** need to have networking enabled for the **Custom Property** to be edited during runtime.

1. Right-click on the object
2. Left-click **Enable Networking**.
3. Right-click on the **Custom Property** that will be edited during runtime.
4. Left-click **Enable Property Networking**.

### Change the Value of the Custom Property

To change the value of the **Custom Property** of a CoreObject, type this in the script:

```lua
CoreObject:SetNetworkedCustomProperty("Custom Property Name", newValue)
```

This will change the value of the **Custom Property** to be newValue and will be replicated to the client.

!!! note
    The script will error if the new value is either not the same data type as the **Custom Property** or if the **Custom Property** is not networked.

More information can be found in the [CoreObject API Reference Functions](/api/coreobject/#functions) and [CoreObject API Reference Examples](/api/coreobject/#setnetworkedcustomproperty).

### Custom Property Changed Event

When a **Custom Property** is changed, an event is fired on the object.

To listen to this event of a CoreObject, type this in the script:

```lua
function OnCustomPropertyChanged(coreObject, customPropertyName)
    local newValue = coreObject:GetCustomProperty(customPropertyName)

    print(string.format("New value of %s for %s is now %s", customPropertyName, coreObject.name, newValue))
end

CorObject.networkedPropertyChangedEvent:Connect(OnCustomPropertyChanged)
```

More information can be found in the [CoreObject API Reference Events](/api/coreobject/#events) and [CoreObject API Reference Examples](/api/coreobject/#networkedpropertychangedevent).

## Simple Data Types

For more information on simple data types such as string, number, and boolean, check out our [Data Types Reference](/tutorials/scripting_intro/#data-types).

The simple data types that are supported as custom properties are:

- Bool
- Color
- Float
- Int
- Rotation
- String
- Vector2
- Vector3
- Vector4

### Bool

A **Boolean** is only ever `true` or `false`. This can be best compared to on/off, yes/no, etc.

In custom properties, they are expressed as a check box that is either checked (`true`) or unchecked (`false`).

**Booleans** are most often used in if-statements that allow you to write code that is only executed if certain conditions are met, such as the boolean being `true`.

### Color

A **Color** is a Core class that contains values for `red`, `green`, `blue`, and `alpha` (transparency).

**Colors** are helpful constants that can assist in UI programming, spawning assets of different colors, etc.

More information can be found in the [Color API](/api/color).

### Float

A **Float** is a number that can have decimals, such as `0.1`, `1.2`, `139.8`, etc.

### Int

An **Int** is a number that can not have decimals and must be whole, such as `0`, `1`, `139`, etc.

### Rotation

A **Rotation** is a Core class that contains values for `x`, `y`, and `z` on rotation axis.

More information can be found in the [Rotation API](/api/rotation/).

### String

A **String** is a collection of any value you want, such as numbers, letters, punctuation, and emojis. They are represented in double quotes (" ") in code so that the computer does not mistake them for code. However, this is not necessary for custom properties as **String** custom properties are represented as a text box that can be typed in.

### Vector2

A **Vector2** contains values for `x` and `y` and is usually useful for storing UI positions/size or any two-dimensional structures.

More information can be found in the [Vector2 API](/api/vector2/).

### Vector3

A **Vector3** contains values for `x`, `y`, and `z` and is usually useful for storing 3D positions/size or any three-dimensional structures.

More information can be found in the [Vector3 API](/api/vector3/).

### Vector4

A **Vector4** contains values for `x`, `y`, `z`, and `w` and is useful for any four-dimensional structures.

More information can be found in the [Vector4 API](/api/vector4/).

## Advanced Data Types

The advanced/complex data types that are supported as custom properties are:

- Asset Reference
- Core Object Reference
- Net Reference

### Asset Reference

### Core Object Reference

### Net Reference

## Learn More

[Data Types Reference](/tutorials/scripting_intro/#data-types) | [Color API](/api/color) | [Leaderboards Tutorial](leaderboards.md) | [Shared Storage Tutorial](shared_storage.md) | [Rotation API](/api/rotation/) | [CoreObject API Reference Functions](/api/coreobject/#functions) | [CoreObject API Reference Examples](/api/coreobject/#setnetworkedcustomproperty) | [CoreObject API Reference Events](/api/coreobject/#events) | [CoreObject API Reference Examples](/api/coreobject/#networkedpropertychangedevent)
