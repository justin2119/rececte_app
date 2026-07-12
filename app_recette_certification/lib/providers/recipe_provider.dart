import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../data/data_recipes.dart';
import '../models/recipe.dart';
final categorieProvider=StateProvider<String?>((ref)=>null);
final recetteProvider=Provider<List<Recipe>>((ref) {
  final categorie=ref.watch(categorieProvider);
  if(categorie=="Tous"){
    return dataRecipes;
  }
  return dataRecipes.where((item)=>item.category==categorie).toList();
});