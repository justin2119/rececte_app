import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/recipe.dart';

abstract class RecipeRepository {
  Future<List<Recipe>> getRecipes();
}

class JsonRecipeRepository implements RecipeRepository {
  @override
  Future<List<Recipe>> getRecipes() async {
    // Simulate network delay for audit requirements
    await Future.delayed(const Duration(milliseconds: 500));
    final String response = await rootBundle.loadString('assets/recipes.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Recipe.fromJson(json)).toList();
  }
}
