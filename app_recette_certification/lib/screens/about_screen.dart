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
              'Tech Stack',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.flash_on, color: Colors.blue),
              title: Text('Flutter'),
              subtitle: Text('Framework UI multi-plateforme'),
            ),
            const ListTile(
              leading: Icon(Icons.waves, color: Colors.indigo),
              title: Text('Riverpod'),
              subtitle: Text('Gestion d\'état robuste'),
            ),
            const ListTile(
              leading: Icon(Icons.route, color: Colors.orange),
              title: Text('GoRouter'),
              subtitle: Text('Navigation déclarative'),
            ),
            const SizedBox(height: 24),
            const Text(
              'Contact',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.email, color: Colors.red),
              title: Text('Support Email'),
              subtitle: Text('support@rececteapp.com'),
            ),
            const ListTile(
              leading: Icon(Icons.web, color: Colors.green),
              title: Text('Site Web'),
              subtitle: Text('www.rececteapp.com'),
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
