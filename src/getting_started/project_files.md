---
id: project_files
name: Project Files and Folders
title: Project Files and Folders
tags:
    - Reference
---

# Core Project Files

The files that make up Core games are all stored locally the computer where they are created. Because of the way Core builds all games out of assets downloaded with the Core installation, they are also quite small files, that can be found by default in the **My Games** > **Core** (it may be **CORE**) > **Maps** folder.

## Essential Files of a Core Game Project

In the game file directory, there are two folders that determine the way the project is built, **Tree** and **Asset Manifest**. They contain the essential blueprints of what objects are needed and where they should be to build up the game using these definitions. They can be found in the **Data** folder of the project.

### Tree

The **Tree** folder contains a file called **Tree.pbt** which essentially lists every single object in the **Hierarchy**, and all the properties of each object found in the **Properties** window, like materials, transforms, visibility and lifespans. The tree will only list a property that is different from the default values.

### AssetManifest

The **AssetManifest.pbt** file in the **Tree** folder is a list of all CoreObjects and Materials that are used in the **Hierarchy**.

!!! info "You can think of **AssetManifest** as a list of parts, and **Tree** as instructions on how to build them into the game."

### Folders

**Folders** exist to partition the project into smaller sub-trees, to keep every single object of the project from being listed as a single file. By contrast, **Groups** exist to organize models and make their parts able to scale uniformly together. In the **Tree.pbt** file, both are listed as a "Folder", but the objects called "Folder" in the **Hierarchy** are special type with the property **IsFilePartition** marked as `true`.

Each Folder created in a project creates an actual folder inside the **Tree** folder, each of which include their own **AssetManifest.pbt** and **Tree.pbt** files, listing the asset references and property data for the objects in the Folder in the Hierarchy.

!!! note "Using **Folders** to partition workspaces for each collaborator on a project will prevent merge conflicts in the **Tree.pbt** file. See the [GitHub Tutorial](../tutorials/github.md) for more information."

### Templates

**Templates** are stored in a separate location from the Tree and AssetManifest files, which you can find in **Data** > **Templates**. Each template is a single `.pbt` file which lists both the required objects and what their properties should be to build up the template. When templates are added to the Hierarchy, they are listed in the **Tree.pbt** file as a `TemplateInstance`, with any changed properties listed, just like an CoreObject.

When a template in the Hierarchy is **deinstanced**, it stop being listed as a `TemplateInstance` and instead add the tree of objects and properties needed to build it directly to the Tree.pbt file.

### Community Content

Community Content imported in a project or published is added to a **Community Content** folder in the main project folder, which lists all the templates and scripts used in the Community Content piece, as well as a **FolderMeta.pbt** file that lists the author and description, covering the information found in the listing where it is published.

Once Community Content is added to a project by double clicking it from the **Core Content** window and dragging into the **Hierarchy**, it will appear in the **Imported Content** section of the **Project Content** window, and the template folder will be added to the **Data** > **Subfolders** folder in the project files.

---

## Learn More

[Templates](../references/templates.md) | [GitHub Tutorial](../tutorials/github.md) | [Community Content](community_content.md) | [Backing Up a Project](backups.md)
