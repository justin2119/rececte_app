import 'package:flutter/material.dart';

class RecipeDetailScreen extends StatelessWidget {
  final String id;
  const RecipeDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recipe Detail')),
      body: Column(
        children: [
          Stack(
            children:[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.4,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.brown,
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child:Row(
                  children: [
                    const Text("Ayimolou"),
                    ElevatedButton(onPressed: (){},style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ), child: const Text("soir")),
                  ],
                ),

              )
            ],
          )
        ],
      )
    );
  }
}
