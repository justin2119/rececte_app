import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/recipe.dart';

class Mobile extends StatelessWidget {
  final List<Recipe> recette;
  const Mobile({super.key,required this.recette});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        itemCount: recette.length,
        itemBuilder: (context, index) => Expanded(
          child: InkWell(
            onTap: () {
              context.push('/detail', extra: recette[index]);
            },
            child: ListTile(
              leading:CachedNetworkImage(
                  imageUrl: recette[index].imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
              ) ,
              title: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Text(recette[index].title,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                     Text(recette[index].category,style: const TextStyle(color: Colors.grey,fontSize: 15,fontWeight: FontWeight.bold),)
                  ],
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
            ),
          ),
        ),
    
    );
  }
}
