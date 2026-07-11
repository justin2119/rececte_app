import 'package:flutter/material.dart';

class RecipeDetailScreen extends StatelessWidget {
  final String id;
  const RecipeDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recipe Detail')),
      body: Center(
        child: Text('Recipe ID: $id'),
      ),
    );
  }
}
