import 'package:go_router/go_router.dart';

import '../models/recipe.dart';
import '../screens/about_screen.dart';
import '../screens/add_recipe_screen.dart';
import '../screens/home_screen.dart';
import '../screens/recipe_detail_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: "/detail",
      builder: (context, state) {
        final recipe = state.extra as Recipe;
        return RecipeDetailScreen(recipe: recipe);
      },
    ),
    GoRoute(
      path: '/add-recipe',
      builder: (context, state) => const AddRecipeScreen(),
    ),
    GoRoute(
      path: '/about',
      builder: (context, state) => const AboutScreen(),
    ),
  ],
);