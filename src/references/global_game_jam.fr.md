---
id: global_game_jam_fr
name: Core pour Global Game Jam
title: Découvrir Core pour la Global Game Jam
tags:
    - Reference
---

# Découvrir Core pour la Global Game Jam

## Bienvenue dans Core

<lite-youtube videoid="fL6HMs9frgw" playlabel="GGJ Online (2021) Keynote and Theme Reveal Video"></lite-youtube>
{: .video-container }

Bienvenue aux participants de la Global Game Jam!

Core est une plateforme de développement, d'édition et d'organisation de jeux (multijoueurs ou non) combinant une interface intuitive à un rendu professionnel. Dans ce document, vous trouverez une présentation des systèmes à l'œuvre dans Core ainsi que plusieurs suggestions de tutoriels et d'outils pour démarrer.

Cette année, Manticore Games a sponsorisé la [Global Game Jam Diversifier](https://globalgamejam.org/news/ggj-online-diversifiers) en vue de faire un jeu dans Core intégrant des contenus de la communauté créés par d'autres participants. Vous allez donc découvrir par quoi commencer, ce que sont les contenus de la communauté, et comment exploiter Core au mieux pour donner vie à votre projet de jeu.

### Créateurs sur d'autres plateformes

Ce document regroupe plusieurs introductions destinées spécifiquement aux créateurs habitués à d'autres moteurs de jeu comme [Unity](unity.md), ou à d'autres plateformes de création comme [Roblox](roblox.md) et [Fortnite](fortnite_creative.md).

!!! note
    Si vous avez de l'expérience sur un moteur ou une plateforme non répertorié ici, vous pouvez nous en faire part ou créer un sujet sur le [Core Documentation GitHub](https://github.com/ManticoreGamesInc/platform-documentation) afin de partager votre expérience!

### Collaboration

Les jeux Core reposent sur des fichiers stockés localement. La collaboration au sein des jeux passe généralement par [GitHub](github.md). Les systèmes de modèles et de contenus de la communauté sont des moyens pour les créateurs de développer des éléments à intégrer à leurs projets.

## Bâtir à partir des modèles

Les modèles de Core vous permettent de démarrer un projet disposant déjà de mécanismes fonctionnels, afin de vous concentrer sur son univers ou l'agencement des niveaux. Ces tutoriels vous présenteront quelques-uns des types de jeu disponibles.

- [Combat à mort](my_first_multiplayer_game.fr.md)
- [Donjon](first_game_rpg.fr.md)

### Jeux ouverts de la communauté

Au-delà des modèles de Core, il existe des centaines de jeux développés par la communauté et dont les créateurs autorisent la modification. Voici quelques exemples:

![Jeux de la communauté](../img/GGJ/GGJ_CommunityGames.png){: .center loading="lazy" }

- Le [Kit de survie des Game Jam](survival_kit.md) a été créé pour une précédente Game Jam et inclut des fonctionnalités comme l'inventaire et la fabrication d'objets, ainsi qu'une documentation complète et un [tutoriel](survival_tutorial.md).

- La plupart des jeux créés par [Manticore Games](https://www.coregames.com/user/37edf67a267b45bd8b93be513218b428) et par [Core's Team META](https://www.coregames.com/user/901b7628983c4c8db4282f24afeda57a) sont ouverts à la modification. Ils peuvent être plus complexes à appréhender mais donnent de bons exemples des possibilités infinies de Core.

- **Tower of Terror** est un jeu de course d'obstacles dans lequel les joueurs doivent grimper en haut d'une tour. Il est doté de niveaux générés aléatoirement et de plus en plus complexes. Créé par [NicholasForeman](https://medium.com/core-games/climbing-the-tower-90f9429f73e5). Il s'agit d'un très bon exemple de génération de niveaux distincts obtenue à partir du système de modèles.

- **Murder Mansion** de [standardcombo](https://www.coregames.com/user/b4c6e32137e54571814b5e8f27aa2fcd) est un jeu d'enquête et de trahison dans lequel les joueurs doivent collecter des indices pour échapper à un assassin désigné aléatoirement. Vous pouvez l'utiliser comme modèle pour créer un jeu d'enquête, ou simplement reprendre le décor du manoir, comme l'a fait le jeu [Spider Bite](https://www.coregames.com/games/bb231b/spider-bite).

- **Tycoon Framework** créé par [Aphrim](https://medium.com/core-games/a-rising-star-4db15f8709f4) a servi de base à plusieurs jeux de gestion économique créés dans Core.

- **Race to the Finish Template** ou **Mount Racer - Test Track** par [WaveParadigm](https://medium.com/core-games/know-when-to-roll-em-6a71a0d3be1b) proposent l'architecture de base d'un jeu de course, avec notamment les montures personnalisées disponibles dans le menu **Ma Collection** de Core.

## Les bases de Core

### Aptitudes

Les [Aptitudes](ability_tutorial.md) constituent le premier outil d'animation et d'interaction du joueur. Elles se composent de plusieurs phases distinctes et renvoient les données concernant l'orientation du joueur au moment de leur utilisation. Vous trouverez en outre la liste complète des [Animations et Postures d'Animation](../api/animations.md) disponibles.

### Terrain

Le système de Terrain de Core vous permet de générer un terrain à partir de cartes en relief ou de modeler le terrain à partir de zéro, puis d'y ajouter des matériaux ou de la végétation.

### Modeling

La [Création artistique dans Core](art.md) se fait principalement par **kitbashing**. Vous ne pouvez pas importer vos propres éléments et la création se base sur les modèles disponibles dans Core. Ensuite, les structures comme les **Groupes** et les **Modèles** vous permettent de traiter les éléments comme des objets distincts.

### Armes

Les [Armes](weapons.md) dans Core peuvent être utilisées pour plusieurs outils, et vous permettent d'associer des effets spéciaux ou des sons, des effets visuels, des projectiles et des effets d'impact. Il existe de nombreux modèles d'armes dans les **Contenus Core** ou encore dans les **Contenus de la communauté**.

### Composants de Core

![Éléments de jeu](../img/GGJ/GGJ_GameComponents.png){: .center loading="lazy" }

Les [Éléments de jeu](../api/components.md) disponibles dans les **Contenus Core** incluent de nombreux systèmes destinés à ajouter des fonctionnalités à votre jeu: classements, plaques de joueur, ressources à collecter...

### Lua

Core utilise le langage Lua pour gérer les scripts dans les jeux. S'il est possible de développer des jeux en utilisant les composants proposés par Core et par les autres créateurs, vous pouvez également lire et écrire vous-même des scripts afin de rendre vos jeux réellement uniques.

- [Le tutoriel des bases de Lua](lua_basics_lightbulb.md) est un tutoriel complet présentant Lua, ainsi que la façon dont les scripts et objets interagissent dans Core.
- [Le guide de style Lua](lua_style_guide.md) donnera aux programmeurs plus expérimentés un aperçu du fonctionnement de Lua dans Core.

Vous trouverez également plusieurs vidéos sur la [chaîne YouTube de CoreGames](https://www.youtube.com/channel/UCBPqo7cK1bktfRfMGAAqnbQ) montrant comment relever les défis, quels que soient votre niveau et votre expérience.

### Contenus de la communauté

Les [**Contenus de la communauté**](../getting_started/community_content.fr.md) constituent une immense collection d'accessoires, scripts, costumes, armes et systèmes de jeu créés et partagés par les créateurs. Core est conçu pour intégrer facilement ces différents éléments dans les jeux, et le système de [Template](templates.md) encourage la collaboration entre graphistes et programmeurs.

![Outils des contenus de la communauté](../img/GGJ/GGJ_CommunityContentInstruments.png){: .center loading="lazy" }

### Exemple: Construire une ville vivante virtuellement sans script

En utilisant les contenus de la communauté, vous pouvez créer une zone remplie de PNJ avec lesquels interagir. Mais ils peuvent tout aussi bien vaquer à leurs propres occupations. Pour ceci, vous pouvez utiliser deux éléments des contenus de la communauté:

- **Choreographer by Chris** vous permet de glisser des scripts dans des dossiers pour créer des séquences d'animations qui elles-mêmes tourneront en boucle ou déclencheront des événements.
- **Dialogue System with NPCs by Hani**, créé pour le jeu CoreHaven par ManticoreGames, est un système de dialogue permettant de créer des dialogues avec des animations, avant de les associer à des PNJ. Trouvez le script appelé **DialogsLibrary_Conversations** puis suivez le format de la conversation pour créer la vôtre.

### Autres Contenus de la communauté importants

- Le **NPC AI Kit by standardcombo** est le modèle le plus téléchargé parmi les Contenus de la communauté. Il s'agit d'un outil populaire de création de PNJ ennemis apparaissant lorsque le joueur est proche, capables de traquer celui-ci selon des zones définites par NavMesh et d'infliger et subir des dégâts.
    - Autre outil utile: le **NPC Costume Script by standardcombo**, qui permet de créer des PNJ personnalisés en disposant des objets sur des emplacements. Le poulet de [Farmer's Market](https://www.coregames.com/games/67442e/farmers-market), par exemple, a été créé en connectant des objets à un raptor.

    ![Chicken in Farmer's Market](../img/GGJ/GGJ_FarmersMarketChicken.png){: .center loading="lazy" }

- **EaseUI & Ease3D by NicholasForeman** est une bibliothèque de fonctionnalités pouvant être appliquées pour créer des mouvements fluides au niveau des interfaces 2D et des objets 3D.
- **Team META** a créé une collection d'outils utiles allant des classements aux inventaires en passant par les écrans de victoire.

    ![Team META on Community Content](../img/GGJ/GGJ_METACC.png){: .center loading="lazy" }

- **Day Night Sky by Rasm** vous permet d'ajouter un cycle jour/nuit à votre projet, pour plus de réalisme.

- **Universal Object Spawner by standardcombo** vous permet de générer des copies d'objets afin que vos joueurs ne manquent jamais de ressources, d'équipements ni d'armes.
