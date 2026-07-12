import 'package:recipe_certification_project/models/recipe.dart';
import 'package:recipe_certification_project/repository/recette.repo.dart';

import '../data/data_recipes.dart';

class ImplementRepository implements RecetteRepo{
  @override
  Future<List<Recipe>> getRecette() async {
    return dataRecipes;
  }
}