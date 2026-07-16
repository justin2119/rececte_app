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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _prepDurationController = TextEditingController();
  String _selectedCategory = 'Petit-déjeuner';
  final List<TextEditingController> _ingredientControllers = [TextEditingController()];
  final List<TextEditingController> _instructionControllers = [TextEditingController()];

  final List<String> _categories = ['Petit-déjeuner', 'Déjeuner', 'Dîner', 'Collation', 'Sauces Togolaises'];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _prepDurationController.dispose();
    for (TextEditingController controller in _ingredientControllers) {
      controller.dispose();
    }
    for (TextEditingController controller in _instructionControllers) {
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
      if (_ingredientControllers.any((c) => c.text.trim().isEmpty)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Veuillez remplir tous les ingrédients ou en supprimer')),
        );
        return;
      }

      final List<String> ingredients = _ingredientControllers
          .map((TextEditingController c) => c.text.trim())
          .where((String t) => t.isNotEmpty)
          .toList();
      
      final String instructions = _instructionControllers
          .map((TextEditingController c) => c.text.trim())
          .where((String t) => t.isNotEmpty)
          .join('\n');

      final Recipe newRecipe = Recipe(
        id: const Uuid().v4(),
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        category: _selectedCategory,
        ingredients: ingredients,
        instructions: instructions,
        imageUrl: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c', // Placeholder
        prepDuration: _prepDurationController.text.trim(),
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
                validator: (String? value) {
                  if (value == null || value.isEmpty) return 'Entrez un titre';
                  if (value.length < 3) return 'Le titre est trop court';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(labelText: 'Catégorie', border: OutlineInputBorder()),
                items: _categories.map((String cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
                onChanged: (String? val) => setState(() => _selectedCategory = val!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description', border: OutlineInputBorder()),
                maxLines: 3,
                validator: (String? value) {
                  if (value == null || value.isEmpty) return 'Entrez une description';
                  if (value.length < 10) return 'La description doit faire au moins 10 caractères';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _prepDurationController,
                decoration: const InputDecoration(labelText: 'Durée de préparation (ex: 45 min)', border: OutlineInputBorder()),
                validator: (String? value) {
                  if (value == null || value.isEmpty) return 'Entrez une durée';
                  if (!RegExp(r'\d+').hasMatch(value)) return 'La durée doit contenir un chiffre';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              const Text('Ingrédients', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ..._ingredientControllers.asMap().entries.map((MapEntry<int, TextEditingController> entry) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: entry.value,
                          decoration: InputDecoration(labelText: 'Ingrédient ${entry.key + 1}'),
                          validator: (String? value) => value == null || value.isEmpty ? 'Champ requis' : null,
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
              ..._instructionControllers.asMap().entries.map((MapEntry<int, TextEditingController> entry) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: entry.value,
                          decoration: InputDecoration(labelText: 'Étape ${entry.key + 1}'),
                          validator: (String? value) => value == null || value.isEmpty ? 'Champ requis' : null,
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
