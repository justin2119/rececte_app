import 'package:flutter/foundation.dart';

@immutable
class Recipe {
  final String id;
  final String title;
  final List<String> ingredients;
  final String instructions;
  final String category;
  final String imageUrl;
  final String prepDuration;
  final double rating;
  final String description;

  const Recipe({
    required this.id,
    required this.title,
    required this.ingredients,
    required this.instructions,
    required this.category,
    required this.imageUrl,
    required this.prepDuration,
    required this.rating,
    required this.description,
  });

  Recipe copyWith({
    String? id,
    String? title,
    List<String>? ingredients,
    String? instructions,
    String? category,
    String? imageUrl,
    String? prepDuration,
    double? rating,
    String? description,
  }) {
    return Recipe(
      id: id ?? this.id,
      title: title ?? this.title,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      prepDuration: prepDuration ?? this.prepDuration,
      rating: rating ?? this.rating,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'ingredients': ingredients,
      'instructions': instructions,
      'category': category,
      'imageUrl': imageUrl,
      'prepDuration': prepDuration,
      'rating': rating,
      'description': description,
    };
  }

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] as String,
      title: json['title'] as String,
      ingredients: List<String>.from(json['ingredients'] as List),
      instructions: json['instructions'] as String,
      category: json['category'] as String,
      imageUrl: json['imageUrl'] as String,
      prepDuration: json['prepDuration'] as String,
      rating: (json['rating'] as num).toDouble(),
      description: json['description'] as String,
    );
  }
}
