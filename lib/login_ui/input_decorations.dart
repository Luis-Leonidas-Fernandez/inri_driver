import 'package:flutter/material.dart';

class InputDecorations {

static InputDecoration authInputDecoration({
  required String hintText,
  required String labelText,
  IconData? prefixIcon,
}){
    return InputDecoration(
             enabledBorder: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(25),          
                 borderSide: const BorderSide(
                 color: Colors.indigo,
                 width: 2,
               ),   
             ), 
             focusedBorder: OutlineInputBorder(
               borderRadius: BorderRadius.circular(25),          
                 borderSide: const BorderSide(
                 color: Colors.indigo,
                 width: 2,
               ),
             ), 
             hintText: hintText,
             labelText: labelText,
             labelStyle: const TextStyle(
               color: Colors.blue
             ),
             prefixIcon: prefixIcon != null
             ? Icon(prefixIcon, color: Colors.indigo,)
             : null
           );

}

}