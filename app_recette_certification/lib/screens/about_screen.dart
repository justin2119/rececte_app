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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Column(
                children: [
                  Icon(Icons.restaurant_menu, size: 80, color: Colors.green),
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
              'Notre Vision',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'L\'application Recette App se consacre à la promotion des saveurs authentiques du Togo et à la préservation de notre riche patrimoine culinaire. À travers une interface moderne, nous créons un pont entre les traditions ancestrales et l\'innovation technologique.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 24),
            const Text(
              'Le Développeur',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.green,
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Justin Bina',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Développeur Flutter & Dart',
                        style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Certifié NextFlutter',
                        style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Justin est un architecte logiciel passionné, fervent défenseur de la souveraineté numérique africaine et collaborateur actif du projet TogoLM. Connu pour son exigence de "Clean Code" (faveur absolue pour l\'immutabilité et les constantes), il rejette les "usines à gaz" au profit de solutions élégantes et performantes.',
              style: TextStyle(fontSize: 15, height: 1.6),
            ),
            const SizedBox(height: 12),
            const Text(
              'Fin gourmet et gardien des traditions, il gère personnellement cette base de données de 55 recettes authentiques pour offrir une expérience culinaire togolaise sans compromis.',
              style: TextStyle(fontSize: 15, height: 1.6),
            ),
            const SizedBox(height: 48),
            Center(
              child: Column(
                children: [
                  Text(
                    '© 2026 Justin Bina',
                    style: TextStyle(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Interaction Company of California',
                    style: TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
