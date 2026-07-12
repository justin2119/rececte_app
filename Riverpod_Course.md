# Master Class: Advanced Flutter State Management with Riverpod

Welcome to the definitive guide on Riverpod. We're going to dive deep into how to build scalable, testable, and maintainable Flutter applications using the Riverpod ecosystem. This isn't just about syntax; it's about the architectural patterns that make your app robust.

## 1. Core Concepts: The Riverpod Trinity

To master Riverpod, you must understand the interplay between these three entities:

### Providers
A Provider is a container for a piece of state. It is globally accessible, but scoped. 
- **Declaration:** Always declare providers as `final` top-level variables.
- **Auto-dispose:** Use `.autoDispose` to ensure state is cleaned up when no longer in use, preventing memory leaks.

### Ref
The `Ref` object is your gateway to the Riverpod world. 
- **WidgetRef:** Used within widgets (via `ConsumerWidget`) to listen to providers.
- **ProviderRef:** Used within providers to access other providers.
- **Key Methods:** `ref.watch` (rebuilds on change), `ref.read` (one-time access, use in callbacks), `ref.listen` (fire-and-forget side effects).

### Consumers
Consumers are the entry points for Riverpod into your UI.
- **ConsumerWidget:** Replaces `StatelessWidget`.
- **ConsumerStatefulWidget:** Replaces `StatefulWidget`.
- **Consumer:** A fine-grained widget for localized rebuilds.

---

## 2. State Management: Notifier vs. AsyncNotifier

This is where the real work happens. Riverpod 2.0+ focuses on these two powerhouses.

### Notifier
Use `Notifier` for **synchronous** state. If your state can be computed instantly (like a counter or a toggle), this is your tool.

**Best Practice:** Keep the state immutable. Never mutate properties directly; always emit a new state object.

### AsyncNotifier
Use `AsyncNotifier` for **asynchronous** state (API calls, database reads). It wraps your state in an `AsyncValue`.

**When to use:**
- Fetching data from a repository.
- Performing mutations (POST/PUT/DELETE) that require UI feedback.
- Handling loading and error states out of the box.

---

## 3. Clean Architecture: The Riverpod Way

Structuring your app is crucial for long-term maintenance. Here is the recommended flow:

1.  **Data Sources:** Raw data access (Dio for APIs, Drift for local DB).
2.  **Repositories:** Abstract the data sources. They return `Future<T>` or `Stream<T>`. No Riverpod logic here.
3.  **Notifiers (Domain/Application Layer):** This is where Riverpod lives. Your `AsyncNotifier` calls the Repository and manages the `AsyncValue` state.
4.  **UI Layer:** Watches the Notifiers. Use `.when` on `AsyncValue` to handle Data, Loading, and Error states gracefully.

---

## 4. Real-World Example: Recipe Management

Since you're building a Recipe app, let's look at how to manage a list of recipes.

```dart
// 1. Model (Immutable)
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
    // Access repository via ref.watch
    final repo = ref.watch(recipeRepositoryProvider);
    return repo.fetchAllRecipes();
  }

  Future<void> toggleFavorite(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(recipeRepositoryProvider);
      await repo.updateFavorite(id);
      // Refresh local state or re-fetch
      return ref.refresh(recipeListProvider.future);
    });
  }
}
```

---

## 5. Best Practices & Pro-Tips

### Immutability is Law
Always use packages like `freezed` or `built_value`. Modifying a field in a class without changing the object reference will NOT trigger a rebuild in Riverpod.

### Avoid ref.watch in build methods?
Actually, `ref.watch` **belongs** in the `build` method of a `ConsumerWidget` or the `build` method of another provider. This is how you create reactive dependencies. 
**Where to avoid it:** Inside button `onPressed` handlers. Use `ref.read` there.

### Testing Basics
Riverpod makes testing a breeze because you can override providers.
```dart
final container = ProviderContainer(
  overrides: [
    recipeRepositoryProvider.overrideWith((ref) => MockRepository()),
  ],
);
```

### The Golden Rule
Never use `ref.read` inside a `build` method. It’s the fastest way to create bugs where your UI doesn't update. Watch everything you depend on for rendering.
