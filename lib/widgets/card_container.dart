import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  //const CardContainer({Key? key}) : super(key: key);

  final Widget child;

  const CardContainer({
  Key? key,
  required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),        
      decoration: _createCard(),
      child: child,
    );
  }

  BoxDecoration _createCard() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: const [
      BoxShadow( color: Colors.black12,
      blurRadius: 15,
      offset: Offset(0, 5)
  )]
    
  );
}