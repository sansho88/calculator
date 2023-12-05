import 'package:flutter/material.dart';

class MyButton extends StatelessWidget{
  final color;
  final textColor;
  final String buttonText;
  final numKey;

  const MyButton({super.key, this.color, this.textColor, required this.buttonText, this.numKey});

  @override
  Widget build(BuildContext context) {
   return GestureDetector(
     onTap: numKey,
     child:  Padding(
       padding: const EdgeInsets.all(0.2),
       child: ClipRRect(
         borderRadius: BorderRadius.circular(21),
         child: Container(
           color: color,
           child: Center(
             child: Text(
               buttonText,
               style: TextStyle(
                 color: textColor,
                 fontSize: 22,
                 fontWeight: FontWeight.bold,
               ),
             ),
           ),
         ),

       ),
     ),
   );
  }

}