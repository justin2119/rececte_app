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
                    itemCount: 20,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: crossAxisCount == 1 ? 3 : 1,
                    ),
                    itemBuilder: (context, index) => Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        onTap: () {
                          context.push('/detail');
                        },
                        leading: Container(
                          height: 100,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blueGrey,
                          ),
                        ),
                        title: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Ayimolou", style: TextStyle(fontWeight: FontWeight.bold)),
                            Text("Catégorie", style: TextStyle(color: Colors.grey, fontSize: 12)),
                            Row(
                              children: [
                                Icon(Icons.star, size: 16, color: Colors.amber),
                                Icon(Icons.star, size: 16, color: Colors.amber),
                                Icon(Icons.star, size: 16, color: Colors.amber),
                                Icon(Icons.star_half, size: 16, color: Colors.amber),
                                Icon(Icons.star_border, size: 16, color: Colors.amber),
                              ],
                            )
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            context.push('/detail');
                          },
                          icon: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
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
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
