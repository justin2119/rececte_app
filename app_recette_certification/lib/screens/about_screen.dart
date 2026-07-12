import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('À propos'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Column(
                children: [
                  Icon(Icons.restaurant_menu, size: 100, color: Colors.green),
                  SizedBox(height: 16),
                  Text(
                    'Recette App',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Text('Version 1.0.0+1', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Description',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'L\'application Recette App se consacre à la promotion des saveurs authentiques du Togo et à la préservation de notre riche patrimoine culturel. Nous rendons la cuisine traditionnelle accessible à tous grâce à une interface moderne et épurée, créant ainsi un pont entre les traditions culinaires ancestrales et les technologies d\'aujourd\'hui.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 32),
            Center(
              child: Text(
                '© 2026 Interaction Company',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
