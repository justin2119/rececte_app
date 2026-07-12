import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../main.dart';
import '../providers/recipe_provider.dart';
import '../widgets/filtter_button.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipeState = ref.watch(recipeNotifierProvider);
    final recipeNotifier = ref.read(recipeNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tous les Recettes", style: TextStyle(fontSize: 30)),
        actions: [
          ValueListenableBuilder<ThemeMode>(
            valueListenable: themeNotifier,
            builder: (context, mode, child) {
              return IconButton(
                icon: Icon(mode == ThemeMode.light
                    ? Icons.dark_mode
                    : Icons.light_mode),
                onPressed: () {
                  themeNotifier.value = mode == ThemeMode.light
                      ? ThemeMode.dark
                      : ThemeMode.light;
                },
                tooltip: 'Toggle Theme',
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) => recipeNotifier.setSearchQuery(value),
                    decoration: InputDecoration(
                      hintText: "Rechercher une recette....",
                      suffixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  'Tous',
                  'Petit-déjeuner',
                  'Déjeuner',
                  'Dîner',
                  'Collation'
                ].map((category) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: FiltterButton(
                      title: category,
                      isSelected: recipeState.selectedCategory == category,
                      onPressed: () => recipeNotifier.setCategory(category),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: recipeState.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : recipeState.filteredRecipes.isEmpty
                      ? const Center(child: Text("Aucune recette trouvée"))
                      : ListView.separated(
                          itemCount: recipeState.filteredRecipes.length,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, index) {
                            final recipe = recipeState.filteredRecipes[index];
                            return ListTile(
                              onTap: () {
                                context.push('/recipe/${recipe.id}');
                              },
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  recipe.imageUrl,
                                  height: 60,
                                  width: 60,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                    height: 60,
                                    width: 60,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    recipe.title,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(recipe.category),
                                  Row(
                                    children: List.generate(5, (starIndex) {
                                      return Icon(
                                        starIndex < recipe.rating.floor()
                                            ? Icons.star
                                            : (starIndex < recipe.rating
                                                ? Icons.star_half
                                                : Icons.star_border),
                                        size: 16,
                                        color: Colors.orange,
                                      );
                                    }),
                                  )
                                ],
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  context.push('/recipe/${recipe.id}');
                                },
                                icon: const Icon(Icons.arrow_forward_ios_rounded),
                              ),
                            );
                          },
                        ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/add-recipe');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
