import 'package:flutter/material.dart';

class Carte extends StatelessWidget {
  final String title;
  final String image;
  Carte({required this.title,required this.image});

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children:[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*0.3,
          padding: const EdgeInsets.all(5),
          margin: const EdgeInsets.all(10),
          decoration:  BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.brown,
            image: DecorationImage(
                image:NetworkImage(image),
                fit: BoxFit.cover
            )
          ),
        ),
        Positioned(
          bottom: 13,
          left: 15,
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,style: TextStyle(
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
