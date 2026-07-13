import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/recipe.dart';

class Tablette extends StatelessWidget {
  final List<Recipe> recette;
  const Tablette({super.key,   required this.recette});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: recette.length,
          itemBuilder: (context, index) => InkWell(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey),
                    color: Colors.white,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: recette[index].imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const CircularProgressIndicator(
                      color: Colors.green,
                      strokeWidth: 2,
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 5,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(recette[index].title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepOrange)),
                             Text(recette[index].category,style: TextStyle(color: Colors.grey,fontSize: 15,fontWeight: FontWeight.bold),)
                          ],
                        ),
                        ElevatedButton(
                            onPressed: (){
                              context.push('/detail', extra: recette[index]);
                        },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text("Detail")
                        ),
                      ],
                    ),
                  )
                  
                )
              ],
            ),
          )),
    );
  }
}
