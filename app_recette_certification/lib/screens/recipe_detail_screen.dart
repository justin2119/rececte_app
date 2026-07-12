import 'package:flutter/material.dart';
import '../widgets/carte.dart';

class RecipeDetailScreen extends StatelessWidget {
  final String id;
  const RecipeDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details Recette',style: TextStyle(fontSize: 25),)),
      body: const Column(
        children: [
          Carte()
        ],
      )
    );
  }
}
