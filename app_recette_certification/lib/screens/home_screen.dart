import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../main.dart';
import '../providers/recipe_provider.dart';
import '../widgets/filtter_button.dart';
import '../widgets/mobile.dart';
import '../widgets/tablette.dart';
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recette = ref.watch(recetteProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Tous les Recettes (${recette.length})", style: const TextStyle(fontSize: 30)),
        actions: [
          ValueListenableBuilder<ThemeMode>(
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
            }, valueListenable: themeNotifier,
          ),
          IconButton(
            onPressed: () {
              context.push('/about');
            },
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
                    onChanged: (value) {
                      ref.read(searchProvider.notifier).state = value;
                    },
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
                  FilterButton(
                    title: 'Sauces Togolaises',
                    onPressed: () {
                      ref.read(categorieProvider.notifier).state = "Sauces Togolaises";
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: LayoutBuilder(
                  builder:(context, constraints){
                    if(constraints.maxWidth <= 600){
                      return Mobile(recette: recette,);
                    }
                    else if(constraints.maxWidth>600 && constraints.maxWidth<=900){
                      return Tablette(recette:recette,);
                    }
                    else{
                      return const Text("Cette Application n'est pas encores disponible sur votre appareil");
                    }
                  }
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
