# Recette App 🇹🇬

Bienvenue dans l'application **Recette App**, votre guide culinaire ultime dédié à la richesse et à l'authenticité de la cuisine togolaise.

## 🏗 Architecture & Design Patterns
Le projet suit strictement les principes de la **Clean Architecture** et du pattern **MVVM** pour garantir une certification de haut niveau :

### 📂 Structure des dossiers
```text
lib/
├── models/         # Entités métier immuables (Domain)
├── repositories/   # Abstractions et implémentations de données (Clean Arch)
├── providers/      # Gestion d'état asynchrone avec Riverpod (ViewModel)
├── router/         # Configuration GoRouter centralisée (app_router.dart)
├── screens/        # Écrans principaux de l'UI (View)
├── widgets/        # Composants UI réutilisables et adaptatifs
└── main.dart       # Point d'entrée et initialisation
assets/
└── recipes.json    # Source de données asynchrone
```

### 🚀 Points clés pour l'Audit
- **4 Écrans complets** : Accueil, Détails, Ajout de recette, et Paramètres.
- **Navigation Propre** : Implémentation de `GoRouter` isolée dans `app_router.dart`.
- **Données Asynchrones** : Chargement des recettes via un `RecipeRepository` depuis un fichier JSON (`assets/recipes.json`) avec gestion d'état `AsyncNotifier` (Riverpod).
- **MVVM Pur** : Séparation totale entre les widgets (View) et les Notifiers (ViewModel).
- **Adaptivité & Thème** : Support complet du mode sombre et interface responsive (Mobile/Tablette/Desktop).

## 🛠 Tech Stack
- **Framework** : [Flutter](https://flutter.dev/)
- **Gestion d'État** : [Riverpod](https://riverpod.dev/)
- **Navigation** : [GoRouter](https://pub.dev/packages/go_router)
- **Persistence & Qualité** : Linter strict et architecture modulaire.

---
Développé avec passion pour la gastronomie togolaise. 🍲✨
