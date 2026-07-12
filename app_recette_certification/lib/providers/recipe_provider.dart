import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/data_recipes.dart';
import '../models/recipe.dart';

final categorieProvider = StateProvider<String?>((ref) => null);

class RecipeNotifier extends Notifier<List<Recipe>> {
  @override
  List<Recipe> build() {
    return dataRecipes;
  }

  void addRecipe(Recipe recipe) {
    state = [...state, recipe];
  }
}

final allRecipesProvider = NotifierProvider<RecipeNotifier, List<Recipe>>(RecipeNotifier.new);

final recetteProvider = Provider<List<Recipe>>((ref) {
  final allRecipes = ref.watch(allRecipesProvider);
  final categorie = ref.watch(categorieProvider);
  if (categorie == "Tous" || categorie == null) {
    return allRecipes;
  }
  return allRecipes.where((item) => item.category == categorie).toList();
});
