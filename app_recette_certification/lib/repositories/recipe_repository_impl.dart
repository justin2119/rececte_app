import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/recipe.dart';
import 'i_recipe_repository.dart';

class RecipeRepositoryImpl implements IRecipeRepository {
  @override
  Future<List<Recipe>> getRecipes() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final String response = await rootBundle.loadString('assets/recipes.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Recipe.fromJson(json)).toList();
  }
}
