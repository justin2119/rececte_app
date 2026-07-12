import 'package:flutter/material.dart';

class FiltterButton extends StatelessWidget {
  final String title;
  const FiltterButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(onPressed: (){},style: ElevatedButton.styleFrom(
      backgroundColor: Colors.grey[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ), child: Text(title));
  }
}
