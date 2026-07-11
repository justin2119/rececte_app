import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../main.dart'; // Import to access themeNotifier

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Recipe List'),
            ElevatedButton(
              onPressed: () => context.push('/recipe/1'),
              child: const Text('Go to Recipe 1'),
            ),
            ElevatedButton(
              onPressed: () => context.push('/add-recipe'),
              child: const Text('Add Recipe'),
            ),
            ElevatedButton(
              onPressed: () => context.push('/about'),
              child: const Text('About'),
            ),
          ],
        ),
      ),
    );
  }
}
