# Recette App 🇹🇬

Bienvenue dans l'application **Recette App**, votre guide culinaire ultime dédié à la richesse et à l'authenticité de la cuisine togolaise.

##  Aperçu détaillé
**Recette App** est une application mobile moderne conçue pour préserver et promouvoir le patrimoine culinaire du Togo. Elle propose une collection soigneusement sélectionnée de **45 recettes authentiques**, allant des plats emblématiques aux délices locaux moins connus.

## 🏗 Architecture & Design Patterns
Le projet suit les principes de la **Clean Architecture** combinés au pattern **MVVM (Model-View-ViewModel)** pour assurer une maintenabilité et une testabilité optimales :

- **Couche Data** : Gère la source des données (ici `data_recipes.dart` simulant une base de données).
- **Couche Domain** : Contient les entités métier (`Recipe`) et les contrats.
- **Couche Presentation** : Utilise le pattern **MVVM** avec **Riverpod** pour la gestion d'état.
  - **Models** : Objets de données immuables.
  - **View** : Widgets Flutter (UI) réactifs.
  - **Providers (ViewModel)** : Notifiers gérant la logique métier et l'état de l'interface.

## Fonctionnalités
- **Recherche & Filtrage Dynamique** : Système performant propulsé par **Riverpod**.
- **Gestion de Thème** : Mode clair/sombre synchronisé via Riverpod.
- **Adaptivité Totale** : Mise en page responsive s'adaptant des smartphones aux écrans Desktop large.
- **Validation Formulaire** : Système de création de recettes avec contrôles stricts.

## 🛠 Tech Stack
- **Framework** : [Flutter](https://flutter.dev/)
- **Gestion d'État** : [Riverpod](https://riverpod.dev/)
- **Navigation** : [GoRouter](https://pub.dev/packages/go_router)
- **Qualité de code** : Linter personnalisé (Strict rules)

## 🚀 Installation
1.  **Cloner le dépôt** :
    ```bash
    git clone https://github.com/justin2119/rececte_app.git
    cd rececte_app
    ```
2.  **Installer les dépendances** :
    ```bash
    flutter pub get
    ```
3.  **Lancer l'application** :
    ```bash
    flutter run
    ```

---
Développé avec passion pour la gastronomie togolaise. 🍲✨
