import 'package:flutter/foundation.dart';
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
    final recette = ref.watch(recetteProvider);
    if (kDebugMode) {
      print(recette);
    }
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
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.error_outline_outlined),
          )
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
              child: Flex(
                spacing: 5,
                direction: Axis.horizontal,
                children: [
                  FilterButton(
                    title: 'Tous',
                    onPressed: () {
                      ref.read(categorieProvider.notifier).state = "Tous";
                    },
                  ),
                  FilterButton(
                    title: 'Petit-déjeuner',
                    onPressed: () {
                      ref.read(categorieProvider.notifier).state =
                          "Petit-déjeuner";
                    },
                  ),
                  FilterButton(
                    title: 'Déjeuner',
                    onPressed: () {
                      ref.read(categorieProvider.notifier).state = "Déjeuner";
                    },
                  ),
                  FilterButton(
                    title: 'Dîner',
                    onPressed: () {
                      ref.read(categorieProvider.notifier).state = "Dîner";
                    },
                  ),
                  FilterButton(
                    title: 'Collation',
                    onPressed: () {
                      ref.read(categorieProvider.notifier).state = "Collation";
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = 1;
                  if (constraints.maxWidth > 900) {
                    crossAxisCount = 3;
                  } else if (constraints.maxWidth > 600) {
                    crossAxisCount = 2;
                  }
                  return GridView.builder(
                    itemCount: recette.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: crossAxisCount == 1 ? 3 : 1,
                    ),
                    itemBuilder: (context, index) => Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green[900],
                        ),
                        child: InkWell(
                          onTap: () {
                            context.push('/detail', extra: recette[index]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            child: IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: SizedBox(
                                      width: 100,
                                      child: Image(
                                        image: NetworkImage(recette[index].imageUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          recette[index].title,
                                          style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
                                        ),
                                        Text(
                                          recette[index].category,
                                          style: const TextStyle(color: Colors.grey, fontSize: 15),
                                        ),

                                      ],
                                    ),
                                  ),

                                  // Trailing : bouton
                                  IconButton(
                                    onPressed: () {
                                      context.push('/detail', extra: recette[index]);
                                    },
                                    icon: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
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
