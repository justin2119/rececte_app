import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/recipe.dart';
import '../repository/implement.repository.dart';
import '../repository/recette.repo.dart';

class RecipeState {
  final List<Recipe> allRecipes;
  final List<Recipe> filteredRecipes;
  final String searchQuery;
  final String selectedCategory;
  final bool isLoading;

  RecipeState({
    required this.allRecipes,
    required this.filteredRecipes,
    this.searchQuery = '',
    this.selectedCategory = 'Tous',
    this.isLoading = false,
  });

  RecipeState copyWith({
    List<Recipe>? allRecipes,
    List<Recipe>? filteredRecipes,
    String? searchQuery,
    String? selectedCategory,
    bool? isLoading,
  }) {
    return RecipeState(
      allRecipes: allRecipes ?? this.allRecipes,
      filteredRecipes: filteredRecipes ?? this.filteredRecipes,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class RecipeNotifier extends Notifier<RecipeState> {
  late final RecetteRepo _repository;

  @override
  RecipeState build() {
    _repository = ImplementRepository();
    _loadRecipes();
    return RecipeState(allRecipes: [], filteredRecipes: [], isLoading: true);
  }

  Future<void> _loadRecipes() async {
    final recipes = await _repository.getRecette();
    state = state.copyWith(
      allRecipes: recipes,
      filteredRecipes: recipes,
      isLoading: false,
    );
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
    _applyFilters();
  }

  void setCategory(String category) {
    state = state.copyWith(selectedCategory: category);
    _applyFilters();
  }

  void _applyFilters() {
    final filtered = state.allRecipes.where((recipe) {
      final matchesCategory = state.selectedCategory == 'Tous' ||
          recipe.category == state.selectedCategory;
      final matchesSearch = recipe.title.toLowerCase().contains(state.searchQuery.toLowerCase()) ||
          recipe.ingredients.any((i) => i.toLowerCase().contains(state.searchQuery.toLowerCase()));
      return matchesCategory && matchesSearch;
    }).toList();
    state = state.copyWith(filteredRecipes: filtered);
  }
}

final recipeNotifierProvider = NotifierProvider<RecipeNotifier, RecipeState>(() {
  return RecipeNotifier();
});
