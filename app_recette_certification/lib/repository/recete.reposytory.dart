import '../models/recipe.dart';

abstract class ReceteRepository {
  Future<Recipe> getRecette();
}