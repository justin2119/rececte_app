import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../widgets/carte.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;
  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    // Split instructions by the pattern "digit followed by a dot"
    final instructionsList = recipe.instructions
        .split(RegExp(r'\d+\.'))
        .where((s) => s.trim().isNotEmpty)
        .map((s) => s.trim())
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          recipe.title,
          style: const TextStyle(fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Carte(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(recipe.category),
                  backgroundColor: Colors.brown.shade100,
                ),
                _buildRatingStars(recipe.rating),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Description",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              recipe.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              "Ingrédients",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...recipe.ingredients.map((item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text("• $item", style: const TextStyle(fontSize: 16)),
                )),
            const SizedBox(height: 20),
            const Text(
              "Instructions",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (instructionsList.isEmpty)
              Text(
                recipe.instructions,
                style: const TextStyle(fontSize: 16),
              )
            else
              ...instructionsList.asMap().entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${entry.key + 1}. ",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          entry.value,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingStars(double rating) {
    List<Widget> stars = [];
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;

    for (int i = 0; i < 5; i++) {
      if (i < fullStars) {
        stars.add(const Icon(Icons.star, color: Colors.orange));
      } else if (i == fullStars && hasHalfStar) {
        stars.add(const Icon(Icons.star_half, color: Colors.orange));
      } else {
        stars.add(const Icon(Icons.star_border, color: Colors.orange));
      }
    }
    return Row(children: stars);
  }
}
