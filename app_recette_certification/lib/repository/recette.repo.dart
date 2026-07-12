import '../models/recipe.dart';

abstract class RecetteRepo {
  Future<List<Recipe>> getRecette();
}