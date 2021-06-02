---
id: editor_intro_fr
name: Introduction à l'Éditeur Core
title: Introduction à l'Éditeur Core
tags:
    - Reference
---

# Introduction à l'Éditeur Core

<lite-youtube videoid="TKOtPN9ujEE" playlabel="Introduction to the Core Editor"></lite-youtube>
{: .video-container }

## Créer un nouveau projet

Il existe trois options pour démarrer un nouveau projet:

- **New Empty Project** crée un projet à partir d'éléments basiques.
- **Core Game Frameworks** propose des styles de jeux à modifier et personnaliser.
- Les **Community Shared Games** sont des jeux créés et partagés par les créateurs Core en vue d'être personnalisés ou totalement transformés par d'autres créateurs.

## Fenêtres de l'Éditeur

L'Éditeur Core est composé de plusieurs fenêtres que vous pouvez redimensionner et positionner librement. Toutes les fenêtres peuvent être ouvertes à partir de l'onglet **Window** du menu supérieur. Vous pouvez restaurer la disposition par défaut en utilisant l'option **Reset View to Default** du menu **Window**.

## Vue principale

La Vue principale correspond à la fenêtre dans laquelle apparaissent tous les éléments visuels du projet. Cette fenêtre porte le nom du projet.

### Modifier la vue

- Maintenez le **bouton droit de la souris** pour changer l'orientation de la vue.
    - ++Z++, ++Q++, ++S++ et ++D++ déplacent le point de vue vers l'avant, la gauche, la droite et l'arrière.
    - ++Alt++ permet de tourner autour d'un objet sélectionné.
- Utilisez la **molette** pour zoomer ou dézoomer.
- Maintenez le **bouton de la molette** pour glisser la vue vers la gauche, la droite, le haut ou le bas.
- Appuyez sur ++F++ quand un objet est sélectionné pour centrer la vue sur cet objet.

### Mode Aperçu

Le mode Aperçu montre le projet du point de vue du joueur, ce qui vous permet de le tester par vous-même.

- ![Play](../img/EditorManual/icons/Icon_Play.png) ou ++equal++ lance le mode Aperçu.
{: .image-inline-text .image-background}
- ++tab++ met l'aperçu en pause.
- ![Stop](../img/EditorManual/icons/Icon_Stop.png) ou ++equal++ met fin à l'aperçu.
{: .image-inline-text .image-background}

### Mode Aperçu multijoueur

Le **mode Aperçu multijoueur** vous permet de tester votre projet dans un contexte multijoueur, avec plusieurs clients (joueurs) en parallèle.

- ![Multiplayer Preview Mode](../img/EditorManual/icons/Icon_MultiplayerTest.png) pour passer du mode Aperçu au mode Aperçu multijoueur.
{: .image-inline-text .image-background}
- Utilisez le menu déroulant pour sélectionner le nombre de joueurs au test.
- ![Play](../img/EditorManual/icons/Icon_Play.png) lance l'aperçu. Cela ouvrira une fenêtre de jeu pour chaque joueur.
{: .image-inline-text .image-background}
- ![Stop](../img/EditorManual/icons/Icon_Stop.png) met fin à l'aperçu et ferme toutes les fenêtres.
{: .image-inline-text .image-background}

!!! tip
    Le **mode Aperçu multijoueur** est le plus fiable pour savoir comment votre jeu se comportera en ligne. Utilisez-le donc le plus souvent possible.

## Hierarchy

La **Hierarchy** montre tous les objets actuellement utilisés dans le projet. Vous pouvez les organiser en les glissant et en les déposant. Glissez un objet sur un autre pour en faire un **enfant** de ce dernier.

Les **objets enfants** sont placés en fonction de la position de leur **objet parent**, et peuvent accéder aux propriétés de l'objet parent via leurs scripts.

## Contenus

### Core Content

La fenêtre **Core Content** contient tous les éléments graphiques, sonores et ludiques nécessaires à l'élaboration de votre jeu. Vous pouvez les parcourir à travers les différentes catégories, ou en utilisant la fonction **Recherche**.

### Community Content

L'onglet **Community Content** propose des templates réalisés par les autres créateurs Core et partagés avec la communauté.

### Project Content

Les objets et scripts que vous créez apparaissent dans cette fenêtre, de même que ceux que vous importez depuis les Contenus de la communauté.

## Manipuler des objets

La barre d'outils contient les différentes options de manipulation.

- ![Transform Position](../img/EditorManual/icons/Icon_TransformPosition.png) ou ++Z++ pour **Transformer la position**. Cela affichera trois flèches partant de la position actuelle de l'objet. Suivez l'une des flèches pour déplacer l'objet le long de l'axe correspondant.
{: .image-inline-text .image-background}
- ![Snap position](../img/EditorManual/icons/Icon_SnapPosition.png) ou ++G++ pour **Adapter la position**. Cela déplacera l'objet sur une grille en fonction de la taille sélectionnée.
{: .image-inline-text .image-background}
- ![Rotate tool](../img/EditorManual/icons/Icon_TransformRotation.png) ou ++E++ pour **Transformer la rotation**. Cela affichera trois courbes. Cliquez et glissez l'une d'elles pour faire tourner l'objet le long de la direction correspondante.
{: .image-inline-text .image-background}
- ![Snap position](../img/EditorManual/icons/Icon_SnapRotation.png) ou ++G++ pour **Adapter la rotation** et faire tourner l'objet en fonction de l'angle sélectionné.
{: .image-inline-text .image-background}
- ![Scale Tool](../img/EditorManual/icons/Icon_TransformScale.png) ou ++R++ pour **Transformer l'échelle**. Cela affichera trois bras portant des cubes et partant du centre de l'objet. Faites glisser l'un des cubes pour modifier la taille de l'objet en fonction de la dimension correspondante ou sélectionnez le cube central pour dimensionner l'objet en conservant ses proportions.
{: .image-inline-text .image-background}
- ![Snap Scale](../img/EditorManual/icons/Icon_SnapScale.png) ou ++G++ pour **Transformer l'échelle**. Cela redimensionnera l'objet en fonction de la taille sélectionnée.
{: .image-inline-text .image-background}

!!! note
    Tous les outils **Adapter** apparaissent au même endroit, à droite des outils de Transformation. Cette icône change d'apparence et de fonction selon l'outil de Transformation sélectionné, et s'active toujours avec ++G++.

## Ajouter des scripts

Les scripts vous permettent de programmer le comportement des différents objets du projet. Les scripts de Core utilisent le langage [Lua](https://www.lua.org/manual/5.3/) et [l'API Lua de Core](../api/index.md).

- ![Script](../img/EditorManual/icons/Icon_Script.png) crée un script qui apparaîtra dans votre **Project Content**.
{: .image-inline-text .image-background}
- Les scripts peuvent être glissés directement dans la **Hierarchy** ou sur un objet censé devenir son parent.

### Journal des événements

Utilisez le Journal des événements, **Event Log**, afin d'accéder aux lignes de debug générés par les scripts ainsi qu'aux erreurs. Il n'est pas ouvert par défaut mais vous pouvez le trouver dans le menu **Window**.

## Sauvegarder le projet

L'Éditeur Core enregistre automatiquement votre projet de façon régulière, mais vous pouvez sauvegarder manuellement via **File** > **Save** ou ++ctrl+S++.

## En savoir plus

[Mon premier jeu multijoueur](my_first_multiplayer_game.fr.md) | [Raccourcis clavier de l'Éditeur Core](editor_keybindings.md)
