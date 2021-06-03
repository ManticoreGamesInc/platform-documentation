---
id: perks_program_fr
name: À propos du programme Perks et de la monétisation
title: À propos du programme Perks et de la monétisation
tags:
    - Perks
---

<style>
.md-typeset img {
    max-width: 100% !important;
}
</style>

# À propos du programme Perks et de la monétisation

Le programme Perks permet aux créateurs Core d'être rémunérés par leurs jeux, grâce à un système de monétisation très complet pouvant être adapté à n'importe quel type de jeu. [Participer au programme](joining_perks.md) vous donne accès à des [**Perks**](implementing_perks.md), des achats en jeu spécialement conçus pour Core.

Pour pouvoir ajouter des Perks à vos jeux, deux conditions doivent être remplies:

- Posséder un compte depuis au moins 30 jours.
- Avoir en moyenne 50 utilisateurs actifs quotidiens cumulés sur tous vos jeux dans une période de 30 jours.

!!! note
    Les membres de l'ancien programme Creator Payouts auront automatiquement accès aux Perks.

Les créateurs participant au programme ont accès au système de Perks de Core, qui permet de vendre des bonus en jeu aux joueurs contre des Core Credits. Les créateurs Core peuvent ensuite échanger ces Core Credits contre de l'argent réel.

## Fonctionnement des Perks

![Player Credit Purchase Flow](../img/Perks/Perks_PlayerPurchaseFlow.png){: .center loading="lazy"}

Les créateurs peuvent monétiser leurs jeux grâce aux Perks, qui leur permettent de vendre des bonus en jeu aux joueurs contre des Core Credits. Il existe trois types de Perks, classés en fonction de la fréquence à laquelle les joueurs peuvent les acheter:

- Permanents: Achats débloquant un bénéfice permanent, comme des objets esthétiques, des améliorations ou l'accès à un jeu
- Répétables: Achats d'objets à utilisation unique, comme des objets consommables, des boosts ou des monnaies virtuelles
- À durée limitée: Achats temporaires conférant des bénéfices pendant 7, 15 ou 30 jours, comme un battle pass

!!! note
    Les Perks à durée limitée ne sont pas automatiquement renouvelés.

Les créateurs décident du type de Perk et de la façon dont ils les implémentent dans leurs jeux. Aucune limite n'est imposée au nombre de Perks possédés par un créateur, et un même Perk peut être appliqué à plusieurs jeux d'un même créateur.

Les Perks s'ajoutent dans l'Éditeur Core, où le créateur peut définir leur prix, leur comportement et leur apparence. Il est possible de les personnaliser davantage avec [Lua et l'API Core](https://docs.coregames.com/core_api/#player). Le système de Perks comprend également des outils très complets pour tester les achats ou obtenir des analyses quotidiennes, permettant au créateur de contrôler entièrement la monétisation de son jeu.

Lorsqu'un joueur achète un Perk, Core gère la transaction du début à la fin. Les Credits sont ajoutés au compte du créateur, et celui-ci peut alors les dépenser dans d'autres jeux Core ou dans la boutique Core.

Pour en savoir plus sur la création de Perks dans vos jeux, consultez l'article dédié [Implémentation des Perks](implementing_perks.md).

## Échanger des Core Credits

![Obtention de Credits pour le créateur](../img/Perks/Perks_CreatorCreditFlow.png){: .center loading="lazy"}

Les créateurs reçoivent directement tous les Core Credits dépensés pour acheter leurs Perks. Quand un créateur accumule suffisamment de Credits pour dépasser un certain seuil, il peut alors convertir ses crédits en argent réel. La conversion s'effectue sur le [tableau de bord de créateur](https://www.coregames.com/create/dashboard).

Consultez l'article [Échange de Core Credits](https://support.coregames.com/hc/en-us/articles/1500000063422-Earned-vs-Purchased-Core-Credits) du centre d'assistance Core pour plus d'informations.

## Répartition des revenus des créateurs

> Core partage ses revenus avec les créateurs à hauteur de 50 %.

![50/50 graphic](../img/Perks/Perks_FiftyFifty.png){: .center loading="lazy"}

Les créateurs peuvent recevoir cette moitié en choisissant de convertir leurs Core Credits en argent réel, comme expliqué ci-dessus. Lors de la conversion, les créateurs reçoivent 50 % des revenus générés par leurs Perks.

### Pourquoi 50%?

Avec les outils fournis par Core, les créateurs peuvent développer des jeux extrêmement variés: du MMO avec abonnement mensuel au jeu de simulation avec achats de skins en jeu, du jeu de tir entièrement gratuit aux jeux d'arcade, etc. En plus des outils de développement, Core gère l'hébergement des serveurs, les réseaux multijoueur et la publication instantanée sur le Store Core. Avec les Perks, Core s'occupe également de tous les coûts de transaction, comme les frais de traitement des cartes bancaires, l'assistance clientèle et les royalties pour l'utilisation du moteur intégré, l'Unreal Engine.

La plupart des autres plateformes de développement ne proposent qu'une portion de ces avantages, et laissent le reste à la charge des créateurs. D'autres plateformes de contenu généré par les utilisateurs, comme Roblox, prélèvent une part bien plus importante des revenus, ou n'autorisent simplement pas la monétisation.

![Core Revenue Split vs Competitor](../img/Perks/Perks_CoreRoblox.png){: .center loading="lazy"}

![Core Revenue Split vs Competitor](../img/Perks/Perks_PlatformCostChart.png){: .center loading="lazy"}

En utilisant Core, les créateurs touchent une part plus importante de leurs revenus par rapport aux plateformes similaires, et ont à leur disposition une suite complète d'outils pour créer, publier et faire grandir leurs jeux.

## Postuler au programme Perks

Lorsque vous aurez atteint le minimum d'utilisateurs actifs quotidiens, vous pourrez [postuler au programme Perks](joining_perks.md) ici. Si vous souhaitez des conseils pour améliorer votre jeu afin d'atteindre le minimum d'utilisateurs actifs quotidiens, consultez le [guide dédié](https://docs.coregames.com/tutorials/improving_your_game/).

---

## En savoir plus

[Implémenter des Perks](implementing_perks.fr.md) | [Analyse de données](creator_analytics.md) | [Comment participer au programme Perks](https://support.coregames.com/hc/en-us/articles/1500000063182-How-to-Join-the-Perks-Program) | [S'inscrire au programme Perks](https://support.coregames.com/hc/en-us/articles/1500000063581-Enrolling-in-the-Perks-Program) | [Recommandations pour la création de Perks](perks_rules.fr.md)
