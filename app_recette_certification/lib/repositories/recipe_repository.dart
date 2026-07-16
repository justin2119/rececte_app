import '../models/recipe.dart';

abstract class RecipeRepository {
  List<Recipe> getRecipes();
}

class LocalRecipeRepository implements RecipeRepository {
  final List<Recipe> _recipes;

  LocalRecipeRepository(this._recipes);

  @override
  List<Recipe> getRecipes() {
    return _recipes;
  }
}
