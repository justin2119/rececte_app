import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Carte extends StatelessWidget {
  final String title;
  final String image;
  const Carte({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children:[
        CachedNetworkImage(
          imageUrl: image,
          imageBuilder: (context, imageProvider) => Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.3,
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Colors.brown,
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover
              )
            ),
          ),
          placeholder: (context, url) => Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.3,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[300],
            ),
            child: const Center(child: CircularProgressIndicator()),
          ),
          errorWidget: (context, url, error) => Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.3,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[300],
            ),
            child: const Icon(Icons.error),
          ),
        ),
        Positioned(
          bottom: 13,
          left: 15,
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
              ),),

            ],
          ),

        )
      ],
    );
  }
}
