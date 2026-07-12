import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/data_recipes.dart';
import '../models/recipe.dart';

final categorieProvider = StateProvider<String?>((ref) => null);
final searchProvider = StateProvider<String>((ref) => "");

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
  final search = ref.watch(searchProvider).toLowerCase();

  return allRecipes.where((item) {
    final matchesCategory = (categorie == "Tous" || categorie == null || item.category == categorie);
    final matchesSearch = (search.isEmpty || item.title.toLowerCase().contains(search));
    return matchesCategory && matchesSearch;
  }).toList();
});
