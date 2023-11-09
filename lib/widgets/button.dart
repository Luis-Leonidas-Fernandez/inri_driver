import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  
  const Button({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ()=> Navigator.pushReplacementNamed(context, 'login'),
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.2))
            ),              
            child:  const Text('Tengo una Cuenta', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)
    );
  }
}