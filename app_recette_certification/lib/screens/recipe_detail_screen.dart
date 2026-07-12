import 'package:flutter/material.dart';
import '../widgets/carte.dart';

class RecipeDetailScreen extends StatelessWidget {
  final String id;
  const RecipeDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details Recette',style: TextStyle(fontSize: 25),)),
      body: Container(
        padding: const EdgeInsets.all(5),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Carte(),
            SizedBox(height: 10),
            Text("Recettes: Ayimolou",style: TextStyle(fontSize:30,fontWeight: FontWeight.bold),),
            SizedBox(height:15),
            Text("Description",style: TextStyle(fontSize:30,fontWeight: FontWeight.bold),),
            SizedBox(height:15),
            Text("Ingredients",style: TextStyle(fontSize:30,fontWeight: FontWeight.bold),),
            SizedBox(height:15),
            Text("Instructions",style: TextStyle(fontSize:30,fontWeight: FontWeight.bold),),


          ],
        ),
      )
    );
  }
}
