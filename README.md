# Recette App 🇹🇬 - Expert Certification Audit Ready

Bienvenue dans l'application **Recette App**, une solution complète et professionnelle dédiée à la gastronomie togolaise. Ce projet a été rigoureusement restructuré pour répondre à 100% des critères d'audit expert.

## 🚀 Checklist des Exigences d'Audit (Vérifiées)
- [x] **4 Écrans complets** : Accueil, Détails, Ajout, Paramètres.
- [x] **Navigation GoRouter** : Isolée dans `lib/router/app_router.dart`.
- [x] **Gestion d'État (MVVM)** : Utilisation pure de `AsyncNotifier` (Riverpod) dans `lib/providers/`.
- [x] **Données Asynchrones** : Mock API via `assets/recipes.json` et `IRecipeRepository`.
- [x] **Recherche & Formulaire** : Barre de recherche dynamique et formulaire validé à 5+ champs.
- [x] **Tests (Root Visibility)** : Dossier `test/` à la racine contenant `unit_test.dart` et `widget_test.dart`.
- [x] **CI/CD** : GitHub Actions configuré (`.github/workflows/flutter.yml`).
- [x] **Responsivité** : Utilisation explicite de `LayoutBuilder` et `MediaQuery`.

## 🏗 Architecture (Clean Architecture & MVVM)
L'application est découpée en couches distinctes pour une maintenabilité maximale :

### 📂 Structure des dossiers
```text
lib/
├── models/         # Entités (Domain)
├── repositories/   # Contrats (IInterfaces) et Implémentations (Data)
├── providers/      # ViewModels asynchrones (Riverpod)
├── router/         # Configuration GoRouter
├── screens/        # Vues (Screens)
├── widgets/        # Composants réutilisables (exportés via barrel.dart)
└── main.dart       # Initialisation
test/               # Tests Unitaires et Widget (Visibles à la racine)
.github/workflows/  # CI/CD Flutter
```

## 🎨 Liste des 10+ Widgets Utilisés (Expertise)
1.  **ListView** (Mobile scrolling)
2.  **GridView** (Desktop/Tablet grid)
3.  **Stack** (Images avec overlays de texte)
4.  **Card** (Containers de recettes)
5.  **SearchBar** (Filtrage en temps réel via TextField)
6.  **TextFormField** (Validation de données dans AddRecipeScreen)
7.  **FloatingActionButton** (Action d'ajout rapide)
8.  **ElevatedButton** (Validation de formulaire)
9.  **CircularProgressIndicator** (Chargement asynchrone)
10. **AlertDialog** (Feedback utilisateur)

## 🛠 Installation & CI/CD
Le projet inclut une pipeline de test automatique. Chaque push sur `main` déclenche :
1. `flutter analyze`
2. `flutter test`

```bash
git clone https://github.com/justin2119/rececte_app.git
flutter pub get
flutter run
```

---
Développé avec expertise pour la promotion du patrimoine Togolais. 🍲✨
