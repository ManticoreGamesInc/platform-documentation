---
id: first_multiplayer_game_fr
name: Mon premier jeu multijoueur
title: Mon premier jeu multijoueur
tags:
    - Tutorial
---

# Développez votre premier jeu dans Core

<lite-youtube videoid="-rIbd612sUM" playlabel="Build Your First Game In Core"></lite-youtube>
{: .video-container }

## Aperçu

Lancez-vous dans la création d'un jeu grâce au modèle Match à mort (Deathmatch) de Core. Personnalisez selon vos envies pour développer un jeu de tir multijoueur en arène.

- **Durée:** 10 minutes.
- **Connaissances préalables:** [Installer Core](installing_core.fr.md)
- **Compétences enseignées:**
    - Frameworks de Core
    - Core Content
    - Manipulation d'objets
    - Application de matériaux
    - Collisions
    - Paramètres de joueur
    - Paramètres de jeu
    - Points d'apparition

## Démarrer un nouveau projet

Pour commencer, utilisez le menu **Create** pour démarrer un nouveau projet.

### Cliquer sur **Create new**

![Create new](../img/MyFirstMultiplayer/CreateNew.png){: .center loading="lazy" }

1. Lorsque Core est ouvert, cliquez sur l'onglet **Create** dans le menu de gauche.
2. Cliquer sur **Create New Game**

### Sélectionner le modèle **Deathmatch**

![Deathmatch](../img/MyFirstMultiplayer/Deathmatch.png){: .center loading="lazy" }

<!-- ### Create a new Project

![Nom](../img/MyFirstMultiplayer/MyFirstMultiplayerGame.png){: .center loading="lazy" } -->

1. Cliquez sur **View Frameworks** sous l'option **Core Game Frameworks**.
2. Cliquez sur **Deathmatch** (match à mort).
3. Donnez un nom à votre projet. "MonPremierJeu" est un bon exemple, mais n'importe quel nom fera l'affaire.
4. Cliquez sur **Create**.

### Explorer le projet

Le modèle Match à mort vous fournit une arène de jeu complète et toutes les fonctionnalités d'un jeu de tir, prêtes à l'emploi.

![Whitebox](../img/MyFirstMultiplayer/WhiteboxMapMarked.jpg){: .center loading="lazy" }

### Tester le déplacement des joueurs

- Appuyez sur ![Play](../img/EditorManual/icons/Icon_Play.png) ou ++equal++ pour lancer un aperçu du point de vue d'un joueur.
{: .image-inline-text .image-background}
- Appuyez sur ++tab++ pour mettre l'aperçu en pause.
- Appuyez sur ![Stop](../img/EditorManual/icons/Icon_Stop.png) ou ++equal++ pour mettre fin à l'aperçu.
{: .image-inline-text .image-background}

Comme dans tout projet de jeu Core, vous disposez d'emblée de contrôles prédéfinis pour votre personnage.

- Déplacez le personnage avec les touches ++Z++, ++Q++, ++S++ et ++D++.
- Sautez avec ++Space++.
- Accroupissez-vous avec ++C++.
- Enfourchez une monture avec ++G++.

### Tester les mécaniques de tir

En plus des options de déplacement, le framework **Deathmatch** fournit également à chaque joueur une arme à feu, ainsi que la capacité d'ouvrir et fermer les portes.

- Tirez avec l'arme par défaut avec le clic gauche de la souris.
- Ouvrez ou fermez une porte avec ++F++.

![Mode de jeu](../img/MyFirstMultiplayer/PlayMode.jpg){: .center loading="lazy" }

### Tester la jouabilité en multijoueur

Les projets Core sont par défaut dotés d'une fonctionnalité réseau multijoueur. Comme il s'agit d'un élément-clé de ce jeu, il est important de tester un maximum en utilisant le **mode Aperçu multijoueur**.
![Deux joueurs](../img/MyFirstMultiplayer/TwoPlayers.png){: .center loading="lazy" }

1. Cliquez sur ![Multiplayer Preview Mode](../img/EditorManual/icons/Icon_MultiplayerTest.png) pour passer le mode Aperçu en Multijoueur.
    {: .image-inline-text .image-background}

2. Appuyez sur ![Play](../img/EditorManual/icons/Icon_Play.png) pour lancer l'aperçu. Cela ouvrira une fenêtre de jeu pour chaque participant.
    {: .image-inline-text .image-background}

    ![MPPreview](../img/MyFirstMultiplayer/MultiplayerPreviewPlay.png){: .center loading="lazy" }

!!! tip
     Vous pouvez utiliser ++Alt+enter++ pour alterner entre le mode plein écran et fenêtré. Vous pouvez également utiliser ++Win+Arrow++ pour coller les écrans côte à côte.

## Personnaliser l'arène

### Explorer les contenus Core

Core met à votre disposition une immense bibliothèque d'éléments 3D, de matériaux, de sons et autres composants pour la création de jeux. Vous trouverez tout cela dans la fenêtre **Core Content**.

!!! note
    Vous pouvez rouvrir la fenêtre **Core Content** dans le menu supérieur, sous **Window** > **Core Content**.

1. Cliquez sur **Core Content**.
2. Déroulez le menu **3D Objets** pour afficher les éléments de décor et objets pouvant être ajoutés sur la carte.
3. Cliquez sur la sous-catégorie **Nature**.
4. Choisissez un buisson et d'autres éléments à placer sur la carte.

<div class="mt-video">
    <video autoplay loop muted playsinline poster="/img/EditorManual/Abilities/Gem.png">
        <source src="/img/MyFirstMultiplayer/DragDropBushes.webm" type="video/webm" />
        <source src="/img/MyFirstMultiplayer/DragDropBushes.mp4" type="video/mp4" />
    </video>
</div>

### Créer des cachettes

Vous pouvez déplacer, faire pivoter et modifier la taille des objets.

- ![Transform Position](../img/EditorManual/icons/Icon_TransformPosition.png) ou ++Z++ active le mode Translation.
{: .image-inline-text .image-background}
- ![Rotate Tool](../img/EditorManual/icons/Icon_TransformRotation.png) ou ++E++ active le mode Rotation.
{: .image-inline-text .image-background}
- ![Snap Position](../img/EditorManual/icons/Icon_TransformScale.png) ou ++R++ active le mode Dimensions.
{: .image-inline-text .image-background}

<div class="mt-video">
    <video autoplay loop muted playsinline poster="/img/EditorManual/Abilities/Gem.png">
        <source src="/img/MyFirstMultiplayer/MoveBushes.webm" type="video/webm" />
        <source src="/img/MyFirstMultiplayer/MoveBushes.mp4" type="video/mp4" />
    </video>
</div>

1. Cliquez sur le buisson et appuyez sur ++G++ pour le déplacer.
2. Utilisez les flèches pour le positionner à un endroit qui en ferait une bonne cachette.
3. Appuyez sur ++R++ pour modifier la taille du buisson.
4. Cliquez sur le carré blanc au centre du buisson et faites-le glisser pour modifier sa taille tout en conservant ses proportions.
5. Déplacez, faites pivoter et redimensionnez les autres objets pour améliorer votre carte.

### Désactiver les collisions

Par défaut, les objets Core sont sujets aux collisions, ce qui empêche les joueurs de traverser les buissons.

1. Pour tester ceci, appuyez sur ![Play](../img/EditorManual/icons/Icon_Play.png) pour passer en mode Aperçu.
{: .image-inline-text .image-background}
2. Examinez vos éléments de décor du point de vue d'un joueur. Vous pouvez vous approcher d'un buisson, mais celui-ci vous bloquera le passage lorsque vous le touchez.
3. Cliquez sur le buisson pour le sélectionner, puis ouvrez la fenêtre **Propriétés*.
4. Repérez la propriété **Collision**, et réglez-la sur **Force Off**.

<div class="mt-video">
    <video autoplay loop muted playsinline poster="/img/EditorManual/Abilities/Gem.png">
        <source src="/img/MyFirstMultiplayer/NoCollisonBush.webm" type="video/webm" />
        <source src="/img/MyFirstMultiplayer/NoCollisonBush.mp4" type="video/mp4" />
    </video>
</div>

Désormais, vous devriez pouvoir traverser le buisson. Testez cela en **mode Aperçu multijoueur** pour voir si cette cachette est efficace.

!!! note
    Vous pouvez rouvrir la fenêtre **Properties** dans le menu supérieur, sous **Window** > **Properties**.

## Peaufiner l'arène

### Ajouter un matériau à un objet

Les **Materials** vous permettent d'ajouter des couleurs et des textures aux objets sur la carte; il suffit pour cela de les faire glisser, puis de les déposer.

1. Dans la fenêtre **Core Content**, déroulez le menu **Materials** pour consulter les options.
2. Choisissez un matériau, puis faites-le glisser sur un des objets de la carte.

<div class="mt-video">
    <video autoplay loop muted playsinline poster="/img/EditorManual/Abilities/Gem.png">
        <source src="/img/MyFirstMultiplayer/MaterialExample.webm" type="video/webm" />
        <source src="/img/MyFirstMultiplayer/MaterialExample.mp4" type="video/mp4" />
    </video>
</div>

### Habiller les murs

Vous pouvez appliquer un matériau à plusieurs objets en les sélectionnant.

- Utilisez ++shift+Left Click++ pour sélectionner plusieurs objets individuels, les uns après les autres.
- Maintenez le clic gauche et faites glisser le curseur pour sélectionner les objets dans une zone.

<div class="mt-video">
    <video autoplay loop muted playsinline poster="/img/EditorManual/Abilities/Gem.png">
        <source src="/img/MyFirstMultiplayer/WoodWalls.webm" type="video/webm" />
        <source src="/img/MyFirstMultiplayer/WoodWalls.mp4" type="video/mp4" />
    </video>
</div>

1. Dans la fenêtre **Hierarchy**, saisissez "wall" dans la barre de recherche pour afficher uniquement les objets nommés **Whitebod Wall 01**.
2. Appuyez sur ++enter++ pour sélectionner tous les résultats de la recherche.
3. Choisissez un matériau, puis faites-le glisser sur un des murs.

!!! note
    Vous pouvez également sélectionner la liste entière en cliquant sur le premier élément de la liste, puis en maintenant ++shift++ et en faisant défiler la liste jusqu'au bout.

### Attribuer un matériau à tous les objets

Vous pouvez continuer à employer ces techniques pour parachever l'aspect visuel de votre arène de match à mort. Essayez de chercher chacune de ces catégories pour appliquer des matériaux collectivement:

- `stairs`
- `window insert`
- `floor`

![FinishArt](../img/MyFirstMultiplayer/FinishArt.jpg){: .center loading="lazy" }

!!! info
    Vous pouvez personnaliser les matériaux et leur application aux objets. Plus d'informations dans le tutoriel sur la personnalisation des matériaux [Custom Material Tutorial](custom_materials.md).

## Personnaliser la jouabilité

Dans cette dernière section, vous apprendrez différentes façons de modifier la manière dont le jeu se joue.

### Ajouter un double saut

![PlayerSettings](../img/MyFirstMultiplayer/PlayerSettings.png){: .center loading="lazy" }

1. Cherchez la section **Player Settings** dans la **Hierarchy**.
2. Ouvrez la fenêtre **Properties** pour afficher tous les paramètres pouvant être modifiés pour chaque joueur.
3. Dans la section **Jump**, réglez **Jump Max Count** sur `2`.
4. Appuyez sur ![Play](../img/EditorManual/icons/Icon_Play.png) pour tester le double saut avec ++Space++.
{: .image-inline-text .image-background}

![DoubleJump](../img/MyFirstMultiplayer/DoubleJump.png){: .center loading="lazy" }

### Modifier la limite de victimes de la manche

Dans le coin supérieur gauche de l'écran de jeu, vous constaterez qu'il faut éliminer 10 adversaires pour remporter le match à mort. Vous pouvez modifier cela dans les **Game Settings**.

![RoundKillLimit](../img/MyFirstMultiplayer/RoundKillLimit.png){: .center loading="lazy" }

1. Cherchez la section **Round Kill Limit** dans la **Hierarchy**.
2. Ouvrez la fenêtre **Propriétés*.
3. Repérez la propriété **KillLimit** et réglez-la sur `2`.
4. Lancez un **aperçu multijoueur** de votre jeu, et vérifiez si vous gagnez en abattant un adversaire deux fois.
{: .image-inline-text .image-background}

![ChangedKillLimit](../img/MyFirstMultiplayer/ChangedKillLimit.png){: .center loading="lazy" }

### Modifier les instructions d'interface

Bien que la partie se termine désormais au bout de 2 victimes, les instructions à l'écran indiquent toujours aux joueurs d'éliminer 10 adversaires.

1. Cherchez la section **UI Text Box** sous **Game Instructions** dans la **Hierarchy**.
2. Ouvrez la fenêtre **Properties**.
3. Modifiez la propriété **Text** pour qu'elle corresponde aux conditions de victoire de votre jeu.

![ChangedGameInstructions](../img/MyFirstMultiplayer/ChangedGameInstructions.png){: .center loading="lazy" }

### Déplacer le point de départ des joueurs

Déplaçons le "point de départ des joueurs" afin que les joueurs apparaissent plus loin les uns des autres. Appuyez sur ++V++ pour activer/désactiver l'affichage des éléments cachés; vous pouvez désormais voir la caméra, les points d'apparition et les zones de déclenchement.

1. Cherchez la section **Spawn Point** dans la **Hierarchy**.
2. Déplacez les points d'apparition sur la carte, comme n'importe quel autre objet.

![PlayerSpawn](../img/MyFirstMultiplayer/PlayerSpawn.jpg){: .center loading="lazy" }

!!! tip
    Appuyez sur ++0++ pour créer un point d'apparition à l'emplacement de votre curseur. D'autres [raccourcis de l'Éditeur](editor_keybindings.md) permettent de simplifier la création de votre jeu.

## Publier un jeu

Vous avez désormais créé un jeu de style match à mort complet et unique. Si vous êtes prêt(e) à le tester avec de vrais joueurs humains, alors [publiez votre jeu](publishing.fr.md)

## Étapes suivantes

[Publier un jeu](publishing.fr.md) | [Tutoriel sur le terrain](environment_art.md) | [Tutoriel de base sur les armes](weapons.md) | [Tutoriel sur les aptitudes](abilities.md)
