import '../models/recipe.dart';

abstract class IRecipeRepository {
  Future<List<Recipe>> getRecipes();
}
