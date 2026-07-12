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
    final recette=ref.watch(recetteProvider);
    if (kDebugMode) {
      print(recette);
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text("Tous les Recettes",style: TextStyle(fontSize: 30,)),
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
            IconButton(onPressed: () {  }, icon:const Icon(Icons.error_outline_outlined),)
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
              const SizedBox(height: 4,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Flex(
                    spacing:5,
                    direction: Axis.horizontal,
                    children:[
                      FilterButton(title: 'Tous', onPressed: () {
                        ref.read(categorieProvider.notifier).state="Tous";
                      },),
                      FilterButton(title: 'Petit-déjeuner', onPressed: () {
                        ref.read(categorieProvider.notifier).state="Petit-déjeuner";
                      },),
                      FilterButton(title: 'Déjeuner', onPressed: () {
                        ref.read(categorieProvider.notifier).state="Déjeuner";
                      },),
                      FilterButton(title: 'Dîner', onPressed: () {
                        ref.read(categorieProvider.notifier).state="Dîner";
                      },),
                      FilterButton(title: 'Collation', onPressed: () {
                        ref.read(categorieProvider.notifier).state="Collation";
                      },),

                    ]
                ),
              ),
              const SizedBox(height: 4,),
              Expanded(
                child: ListView.separated(
                    itemCount: 20,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) => ListTile(
                        onTap: (){
                          context.push('/detail');
                        },
                        leading: Container(
                          height: 100,
                          width: 100,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blueGrey,
                          ),
                        ),
                        title: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Ayimolou"),
                            Text("Catégorie"),
                            Row(
                              children: [
                                Icon(Icons.star),
                                Icon(Icons.star),
                                Icon(Icons.star),
                                Icon(Icons.star_half),
                                Icon(Icons.star_border),
                              ],
                            )
                          ],
                        ),
                        trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(onPressed: (){
                                context.push('/detail');
                              }, icon: const Icon(Icons.arrow_forward_ios_rounded)),
                            ]
                        )
                    )
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        )
    );
  }
}
