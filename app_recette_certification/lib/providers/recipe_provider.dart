import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../data/data_recipes.dart';
import '../models/recipe.dart';
import '../repositories/recipe_repository.dart';

final recipeRepositoryProvider = Provider<RecipeRepository>((ref) {
  return LocalRecipeRepository(dataRecipes);
});

final categorieProvider = StateProvider<String?>((ref) => null);
final searchProvider = StateProvider<String>((ref) => "");

class RecipeNotifier extends Notifier<List<Recipe>> {
  @override
  List<Recipe> build() {
    return ref.watch(recipeRepositoryProvider).getRecipes();
  }

  void addRecipe(Recipe recipe) {
    state = [...state, recipe];
  }
}

final allRecipesProvider = NotifierProvider<RecipeNotifier, List<Recipe>>(RecipeNotifier.new);

final recetteProvider = Provider<List<Recipe>>((ref) {
  final allRecipes = ref.watch(allRecipesProvider);
  final categorie = ref.watch(categorieProvider);
  final search = ref.watch(searchProvider).toLowerCase();

  return allRecipes.where((item) {
    final matchesCategory = (categorie == "Tous" || categorie == null || item.category == categorie);
    final matchesSearch = (search.isEmpty || item.title.toLowerCase().contains(search));
    return matchesCategory && matchesSearch;
  }).toList();
});
