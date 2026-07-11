import '../models/recipe.dart';

const List<Recipe> mockRecipes = [
  Recipe(
    id: '1',
    title: 'Foufou à la sauce graine',
    ingredients: [
      'Ignames de qualité',
      'Noix de palme',
      'Viande de bœuf ou mouton',
      'Poisson fumé',
      'Piment, oignon, ail',
    ],
    instructions: '1. Faire bouillir et piler l\'igname jusqu\'à obtenir une pâte homogène. 2. Préparer la sauce avec le jus des noix de palme, la viande et les condiments. 3. Servir chaud.',
    category: 'Plat traditionnel Togolais',
    imageUrl: 'https://images.unsplash.com/photo-1627308595229-7830a5c91f9f?auto=format&fit=crop&w=500',
  ),
  Recipe(
    id: '2',
    title: 'Djenkoumé au Poulet',
    ingredients: [
      'Farine de maïs rouge',
      'Tomates fraîches et concentrées',
      'Poulet grillé',
      'Huile de palme ou arachide',
      'Oignons et piment vert',
    ],
    instructions: '1. Préparer un bouillon de tomate assaisonné. 2. Verser progressivement la farine de maïs en remuant vigoureusement sur le feu. 3. Servir avec le poulet grillé et une sauce pimentée.',
    category: 'Plat traditionnel Togolais',
    imageUrl: 'https://images.unsplash.com/photo-1547592166-23ac45744acd?auto=format&fit=crop&w=500',
  ),
  Recipe(
    id: '3',
    title: 'Ayimolou',
    ingredients: [
      'Riz',
      'Haricots rouges ou noirs',
      'Potasse (optionnel)',
      'Oignons frits',
      'Sauce piment noire (Wagashi)',
    ],
    instructions: '1. Cuire les haricots jusqu\'à tendreté. 2. Ajouter le riz et cuire ensemble jusqu\'à absorption complète de l\'eau. 3. Servir avec de l\'oignon frit et du piment noir.',
    category: 'Cuisine de rue / Togo',
    imageUrl: 'https://images.unsplash.com/photo-1512058560566-d8b437a17305?auto=format&fit=crop&w=500',
  ),
  Recipe(
    id: '4',
    title: 'Poulet Yassa',
    ingredients: [
      'Poulet',
      'Beaucoup d\'oignons',
      'Citrons verts',
      'Moutarde',
      'Riz blanc',
    ],
    instructions: '1. Mariner le poulet avec citron, oignons et moutarde. 2. Griller le poulet. 3. Faire revenir les oignons de la marinade et cuire le poulet dedans. Servir avec du riz.',
    category: 'Spécialité Ouest-Africaine',
    imageUrl: 'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d?auto=format&fit=crop&w=500',
  ),
];
