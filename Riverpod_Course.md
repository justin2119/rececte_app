# Master Class : Gestion d'État Avancée avec Riverpod pour Flutter

Bienvenue dans ce guide de référence sur Riverpod. Nous allons explorer en profondeur comment concevoir des applications Flutter scalables, testables et maintenables. Ici, on ne parle pas juste de syntaxe, mais des patterns architecturaux qui rendent ton code robuste.

## 1. Concepts Fondamentaux : La Trinité Riverpod

Pour maîtriser Riverpod, tu dois comprendre l'interaction entre ces trois entités :

### Providers
Un `Provider` est un conteneur pour une portion d'état. Il est accessible globalement, mais reste "scopé" (portée limitée).
- **Déclaration :** Déclare toujours tes providers en tant que variables globales `final`.
- **Auto-dispose :** Utilise `.autoDispose` pour garantir que l'état est nettoyé lorsqu'il n'est plus utilisé, évitant ainsi les fuites de mémoire.

### Ref
L'objet `Ref` est ton point d'entrée dans l'écosystème Riverpod.
- **WidgetRef :** Utilisé dans les widgets (via `ConsumerWidget`) pour écouter les providers.
- **ProviderRef :** Utilisé à l'intérieur des providers pour accéder à d'autres providers.
- **Méthodes Clés :** `ref.watch` (reconstruit le widget lors d'un changement), `ref.read` (accès ponctuel, idéal pour les callbacks), `ref.listen` (pour déclencher des effets de bord sans reconstruire).

### Consumers
Les `Consumers` sont les points de jonction entre Riverpod et ton UI.
- **ConsumerWidget :** Remplace `StatelessWidget`.
- **ConsumerStatefulWidget :** Remplace `StatefulWidget`.
- **Consumer :** Un widget granulaire pour des reconstructions localisées.

---

## 2. Gestion d'État : Notifier vs AsyncNotifier

C'est ici que le vrai travail commence. Riverpod 2.0+ se concentre sur ces deux piliers.

### Notifier
Utilise `Notifier` pour un état **synchrone**. Si ton état peut être calculé instantanément (comme un compteur ou un bouton switch), c'est l'outil qu'il te faut.

**Best Practice :** Garde l'état immuable. Ne modifie jamais les propriétés directement ; émet toujours un nouvel objet d'état.

### AsyncNotifier
Utilise `AsyncNotifier` pour un état **asynchrone** (appels API, lecture en base de données). Il encapsule ton état dans une `AsyncValue`.

**Quand l'utiliser :**
- Récupération de données depuis un repository.
- Exécution de mutations (POST/PUT/DELETE) nécessitant un retour visuel.
- Gestion native des états de chargement (loading) et d'erreur.

---

## 3. Clean Architecture : L'Approche Riverpod

La structuration de ton app est vitale pour la maintenance à long terme. Voici le flux recommandé :

1.  **Data Sources :** Accès brut aux données (Dio pour les API, Drift pour le local).
2.  **Repositories :** Abstraction des sources de données. Ils renvoient des `Future<T>` ou `Stream<T>`. Pas de logique Riverpod ici.
3.  **Notifiers (Couche Domaine/Application) :** C'est là que Riverpod vit. Ton `AsyncNotifier` appelle le Repository et gère l'état `AsyncValue`.
4.  **UI Layer :** Observe les Notifiers. Utilise `.when` sur l' `AsyncValue` pour gérer proprement les états Data, Loading et Error.

---

## 4. Exemple Concret : Gestion de Recettes

Puisque tu développes une application de recettes, voyons comment gérer une liste de recettes.

```dart
// 1. Modèle (Immuable avec Freezed)
@freezed
class Recipe with _$Recipe {
  const factory Recipe({
    required String id,
    required String title,
    @Default(false) bool isFavorite,
  }) = _Recipe;
}

// 2. Notifier
@riverpod
class RecipeList extends _$RecipeList {
  @override
  FutureOr<List<Recipe>> build() async {
    // Accès au repository via ref.watch
    final repo = ref.watch(recipeRepositoryProvider);
    return repo.fetchAllRecipes();
  }

  Future<void> toggleFavorite(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(recipeRepositoryProvider);
      await repo.updateFavorite(id);
      // Rafraîchir l'état local ou re-fetcher
      return ref.refresh(recipeListProvider.future);
    });
  }
}
```

---

## 5. Bonnes Pratiques & Pro-Tips

### L'Immuabilité est une Loi
Utilise systématiquement des packages comme `freezed`. Modifier un champ dans une classe sans changer la référence de l'objet ne déclenchera PAS de reconstruction dans Riverpod.

### Éviter ref.watch dans les méthodes build ?
Au contraire, `ref.watch` a **toute sa place** dans la méthode `build` d'un `ConsumerWidget` ou d'un autre provider. C'est ainsi que tu crées des dépendances réactives.
**Où l'éviter :** À l'intérieur des gestionnaires d'événements comme `onPressed`. Utilise `ref.read` dans ce cas précis.

### Bases du Testing
Riverpod rend les tests triviaux car tu peux surcharger (override) les providers.
```dart
final container = ProviderContainer(
  overrides: [
    recipeRepositoryProvider.overrideWith((ref) => MockRepository()),
  ],
);
```

### La Règle d'Or
N'utilise jamais `ref.read` à l'intérieur d'une méthode `build`. C'est le moyen le plus sûr de créer des bugs où ton UI ne se met pas à jour. Observe tout ce dont tu as besoin pour le rendu.
