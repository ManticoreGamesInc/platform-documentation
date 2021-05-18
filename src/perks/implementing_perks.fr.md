---
id: perks_fr
name: Comment implémenter les Avantages
title: Comment implémenter les Avantages
tags:
    - Perks
---

# Avantages

## Aperçu

Les Avantages sont le système permettant de créer des achats au sein du jeu, afin que les joueurs puissent soutenir les créateurs en échange de contenu exclusif. Pour utiliser les Avantages dans un jeu, les créateurs doivent remplir certaines conditions [minimum requirements](joining_perks.md) et postuler au Programme Avantages [Perks Program](perks_program.md).

## Types d'Avantages

Les Avantages sont divisés en plusieurs types, basés sur le moment et la fréquence auxquels le joueur peut les acheter.

### Permanents

Chaque joueur ne peut acheter un **Avantage permanent** qu'une seule fois.

### Durée limitée

Les **Avantages à durée limitée** ne peuvent être achetés qu'une fois au cours d'une durée définie, puis rachetés au terme de cette durée.

### Répétables

Les **Avantages répétables** peuvent être achetés autant de fois que le joueur le souhaite.

Pour plus d'informations sur les types d'Avantages, consultez l'article À propos des Avantages en jeu [About In-Game Perks](https://support.coregames.com/hc/en-us/articles/360060361453-About-In-Game-Perks) dans le Centre d'assistance Core.

## Créer des Avantages

Les Avantages sont créés et modifiés via la fenêtre **Gestion des Avantages**. Ils peuvent être associés à un ou plusieurs projet(s) du même créateur.

### Créer un Avantage

![Open the Perks Manager](../img/Perks/Perks_OpenPerksManager.png){: .center loading="lazy" }

1. Ouvrez la **Gestion des Avantages** en cliquant sur **Fenêtres** dans le menu supérieur puis en sélectionnant **Gestion des Avantages**.
2. Cliquez sur le bouton **Créer nouvel Avantage** en bas de la fenêtre.
3. Donnez un nom à l'Avantage et sélectionnez son type.
4. S'il s'agit d'un Avantage à durée limitée, modifiez le champ **Durée**.
5. Renseignez le **Prix** de l'Avantage en Crédits Core.
6. Activez l'option **Ajouter au projet actuel** pour utiliser l'Avantage.

!!! info
    Le nombre de projets auxquels vous pouvez ajouter un Avantage n'est pas limité.

Votre nouvel Avantage apparaîtra maintenant dans la section **Mes Avantages** de la fenêtre **Contenus du projet**.

### Ajouter une référence à un Avantage

Pour modifier l'expérience d'un joueur en fonction des Avantages qu'il possède, vous devez faire référence aux Avantages dans un script.

1. Créez ou sélectionnez un script dans la Hiérarchie, et ouvrez la fenêtre **Propriétés**.
2. Dans **Contenus du projet**, ouvrez la section **Mes Avantages** et localisez votre Avantage.
3. Cliquez sur votre Avantage dans **Contenus du projet** et glissez-le dans **Ajouter propriété personnalisée**.

![Adding a Perk as a Custom Property](../img/Perks/Perks_PerkReferenceCustomProperty.png){: .center loading="lazy" }

### Scripts et Avantages

Vous pouvez utiliser la fonction `player:HasPerk(perkReference)` pour savoir si un joueur dispose d'un Avantage, et la fonction `player:GetPerkCount()` pour connaître le nombre d'Avantages répétables qu'un joueur a achetés.

Pour en savoir plus sur les fonctions et événements associés aux Avantages, consultez [the Player type in the Core API Reference](../api/player.md).

## Tester les Avantages

Les créateurs peuvent tester les Avantages dans un projet local pour s'assurer de leur bon fonctionnement, en utilisant la fenêtre **Test des Avantages**.

### Autoriser le test des Avantages

![Open Perks Testing](../img/Perks/Perks_OpenPerkTestingFromManager.png){: .center loading="lazy" }

1. Ouvrez la fenêtre **Gestion des Avantages** en cliquant sur **Fenêtre** dans le menu supérieur, puis sélectionnez **Test des Avantages**.
2. Activez l'Avantage pour **Joueur 1** si vous voulez le tester lorsqu'un seul joueur le possède.
3. Activez l'Avantage pour **Joueur 2+** pour le tester dans les conditions du multijoueur.

!!! info
    Vous pouvez ouvrir la fenêtre *Test des Avantages** directement depuis le menu **Fenêtre**.

![Open Perks Testing](../img/Perks/Perks_OpenPerkTesting.png){: .center loading="lazy" }

### Tester en Aperçu multijoueur

Une fois les Avantages activés dans le menu test, lancez un Aperçu multijoueur. Si vous avez accordé un Avantage au **Joueur 1**, vous devriez le voir sur **Bot1** dans la première fenêtre d'aperçu. Tous les bénéfices en jeu accordés au joueur ayant débloqué ces Avantages doivent être présents dans cette fenêtre. Concernant **Joueur 2+**, toutes les instances d'aperçu multijoueur doivent montrer les joueurs possédant cet Avantage, y compris ceux ajoutés après le début de l'aperçu.

## Ajouter un bouton d'achat d'Avantages

Les Avantages ne peuvent être achetés qu'en utilisant un **Bouton UI d'achat d'Avantages**. Une boîte de dialogue sera utilisée pour confirmer l'achat.

## Ajouter un bouton d'achat d'Avantages à un projet

1. Dans la section **Objets de jeu** des **Contenus Core**, ouvrez la catégorie **Outils Avantages**.
2. Trouvez l'objet **Bouton UI d'achat d'Avantages** et glissez-le dans votre Hiérarchie.
3. Ouvrez la section **Mes Avantages** des **Contenus du projet** pour trouver votre Avantage.
4. Quand le **Bouton UI d'achat d'Avantages** est sélectionné, ouvrez la fenêtre **Propriétés**.
5. Glissez l'Avantage que vous souhaitez associer au bouton de **Mes Avantages** à la propriété **Référence Avantage** du Bouton d'achat.

!!! warning
    Ajouter une référence en tant que propriété personnalisée n'activera **PAS** la bouton d'achat de l'Avantage. La référence doit pour cela être ajoutée au champ **Référence Avantage** des propriétés du bouton d'achat.

![Open Perks Testing](../img/Perks/Perks_UIButton.png){: .center loading="lazy" }

## Activer les Avantages

Les Avantages existent à plusieurs niveaux qui vous permettent de contrôler leur activation par le joueur. Pour pouvoir être utilisés, les Avantages doivent être associés à un jeu publié, ce qui implique plusieurs étapes avant qu'un joueur ne puisse les acheter.

## Avantages inactifs

!!! warning
    Les Avantages doivent être publiés comme **inactifs** avant d'être activés !

Lorsqu'un Avantage est créé, il est considéré comme **inactif**. Les Avantages doivent être associés à un projet avant d'être activés et, pour cela, ils doivent être publiés à l'état inactif.

### Étapes d'activation d'un Avantage

1. Créez un Avantage avec la **Gestion des Avantages**.
2. Vérifiez que l'option **Ajouter au projet actuel** de l'Avantage est bien sélectionnée.
3. Publiez le jeu.
4. Ouvrez à nouveau la **Gestion des Avantages** et sélectionnez **Actif** dans le menu déroulant de la colonne **Statut**.

![Change status to active](../img/Perks/Perks_ActivatePerk.png){: .center loading="lazy" }

!!! warning
    Une fois que l'Avantage est activé, il ne peut pas être désactivé de suite. De plus, il devient soumis aux [Terms of Service](https://support.coregames.com/hc/en-us/articles/1500000105081-Joining-the-Perks-Program) propres aux Avantages.

## Modifier et suspendre les Avantages

Les Avantages actifs pour les joueurs ne peuvent pas être désactivés instantanément. Ils doivent d'abord passer par l'état **Désactivé**, dans lequel ils resteront actifs pour les joueurs les ayant achetés, tout en étant désormais indisponibles à la vente.

Pour modifier un Avantage actif, vous devez d'abord le suspendre.

### Suspendre un Avantage actif

1. Trouvez votre Avantage dans la **Gestion des Avantages**.
2. Sélectionnez **Suspendu** dans la colonne **Statut**.

![Change status to suspended](../img/Perks/Perks_SuspendPerk.png){: .center loading="lazy" }

### Désactiver un Avantage

Si un Avantage suspendu n'a aucun utilisateur actif associé, il peut être désactivé en toute sécurité.

1. Trouvez votre Avantage dans la **Gestion des Avantages**.
2. Sélectionnez **Désactivé** dans la colonne **Statut**.

### Avantages désactivés et suspendus

Les Avantages peuvent être désactivés ou suspendus s'ils causent de nombreuses requêtes d'assistance ou s'ils violent les Conditions d'utilisation.

Si un Avantage est désactivé ou suspendu, vous pouvez soumettre une requête au Centre d'assistance Core [Core Help Center](https://support.coregames.com/hc/en-us) pour y remédier.

### États des Avantages

La couleur d'un Avantage ![Perks Icon](../img/EditorManual/icons/AssetType_PerkReference.png){: style="width: 2em;" } dans la section **Mes Avantages** des **Contenus du projet** indique le statut actuel de l'Avantage dans votre projet.
{: .image-inline-text .image-background }

![Perks status colors](../img/Perks/Perks_PerkStateColors.png){: .center loading="lazy" }

---

## En savoir plus

[The Perks Program](perks_program.md) | [Core API Reference](../api/player.md) | [Joining the Perks Program](joining_perks.md) | [About In-Game Perks](https://support.coregames.com/hc/en-us/articles/360060361453-About-In-Game-Perks) | [Guidelines for Creating Perks](perks_rules.md)
