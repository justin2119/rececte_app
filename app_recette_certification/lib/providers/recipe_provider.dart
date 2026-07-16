import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/recipe.dart';
import '../repositories/recipe_repository.dart';

final recipeRepositoryProvider = Provider<RecipeRepository>((ref) {
  return JsonRecipeRepository();
});

final categorieProvider = StateProvider<String?>((ref) => null);
final searchProvider = StateProvider<String>((ref) => "");

class RecipeNotifier extends AsyncNotifier<List<Recipe>> {
  @override
  Future<List<Recipe>> build() async {
    return ref.watch(recipeRepositoryProvider).getRecipes();
  }

  Future<void> addRecipe(Recipe recipe) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final currentRecipes = await future;
      return [...currentRecipes, recipe];
    });
  }
}

final allRecipesProvider = AsyncNotifierProvider<RecipeNotifier, List<Recipe>>(RecipeNotifier.new);

final recetteProvider = Provider<AsyncValue<List<Recipe>>>((ref) {
  final allRecipesAsync = ref.watch(allRecipesProvider);
  final categorie = ref.watch(categorieProvider);
  final search = ref.watch(searchProvider).toLowerCase();

  return allRecipesAsync.whenData((recipes) {
    return recipes.where((item) {
      final matchesCategory = (categorie == "Tous" || categorie == null || item.category == categorie);
      final matchesSearch = (search.isEmpty || item.title.toLowerCase().contains(search));
      return matchesCategory && matchesSearch;
    }).toList();
  });
});
