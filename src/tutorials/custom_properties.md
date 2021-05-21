---
id: custom_properties
name: Custom Properties
title: Custom Properties
tags:
    - Reference
---

# Custom Properties

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

[Data Types Reference](/tutorials/scripting_intro/#data-types) | [Color API](/api/color) | [Leaderboards Tutorial](leaderboards.md) | [Shared Storage Tutorial](shared_storage.md) | [Rotation API](/api/rotation/)
