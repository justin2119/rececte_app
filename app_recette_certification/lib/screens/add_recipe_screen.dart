import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../models/recipe.dart';
import '../providers/recipe_provider.dart';

class AddRecipeScreen extends ConsumerStatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  ConsumerState<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends ConsumerState<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedCategory = 'Petit-déjeuner';
  final List<TextEditingController> _ingredientControllers = [TextEditingController()];
  final List<TextEditingController> _instructionControllers = [TextEditingController()];

  final List<String> _categories = ['Petit-déjeuner', 'Déjeuner', 'Dîner', 'Collation'];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    for (var controller in _ingredientControllers) {
      controller.dispose();
    }
    for (var controller in _instructionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addIngredient() {
    setState(() {
      _ingredientControllers.add(TextEditingController());
    });
  }

  void _removeIngredient(int index) {
    if (_ingredientControllers.length > 1) {
      setState(() {
        _ingredientControllers[index].dispose();
        _ingredientControllers.removeAt(index);
      });
    }
  }

  void _addInstruction() {
    setState(() {
      _instructionControllers.add(TextEditingController());
    });
  }

  void _removeInstruction(int index) {
    if (_instructionControllers.length > 1) {
      setState(() {
        _instructionControllers[index].dispose();
        _instructionControllers.removeAt(index);
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final ingredients = _ingredientControllers
          .map((c) => c.text.trim())
          .where((t) => t.isNotEmpty)
          .toList();
      final instructions = _instructionControllers
          .map((c) => c.text.trim())
          .where((t) => t.isNotEmpty)
          .join('\n');

      final newRecipe = Recipe(
        id: const Uuid().v4(),
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        category: _selectedCategory,
        ingredients: ingredients,
        instructions: instructions,
        imageUrl: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c', // Placeholder
        rating: 0.0,
      );

      ref.read(allRecipesProvider.notifier).addRecipe(newRecipe);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une recette'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Titre', border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? 'Entrez un titre' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(labelText: 'Catégorie', border: OutlineInputBorder()),
                items: _categories.map((cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
                onChanged: (val) => setState(() => _selectedCategory = val!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
                maxLines: 3,
                validator: (value) => value == null || value.isEmpty ? 'Entrez une description' : null,
              ),
              const SizedBox(height: 24),
              const Text('Ingrédients', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ..._ingredientControllers.asMap().entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: entry.value,
                          decoration: InputDecoration(labelText: 'Ingrédient ${entry.key + 1}'),
                          validator: (value) => value == null || value.isEmpty ? 'Champ requis' : null,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () => _removeIngredient(entry.key),
                      ),
                    ],
                  ),
                );
              }),
              TextButton.icon(
                onPressed: _addIngredient,
                icon: const Icon(Icons.add),
                label: const Text('Ajouter un ingrédient'),
              ),
              const SizedBox(height: 24),
              const Text('Instructions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ..._instructionControllers.asMap().entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: entry.value,
                          decoration: InputDecoration(labelText: 'Étape ${entry.key + 1}'),
                          validator: (value) => value == null || value.isEmpty ? 'Champ requis' : null,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () => _removeInstruction(entry.key),
                      ),
                    ],
                  ),
                );
              }),
              TextButton.icon(
                onPressed: _addInstruction,
                icon: const Icon(Icons.add),
                label: const Text('Ajouter une étape'),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Enregistrer la recette'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
