import 'package:go_router/go_router.dart';

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
      path: '/recipe/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return RecipeDetailScreen(id: id);
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