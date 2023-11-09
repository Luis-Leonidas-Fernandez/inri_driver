// ignore_for_file: avoid_print

import 'package:flutter/material.dart';



class BtnMyTracking extends StatelessWidget { 
  

  const BtnMyTracking({
  Key? key,   
  }) : super(key: key);

  @override
  Widget build(BuildContext context) { 

    
  

    return Positioned(
            top: 490,
            left: 350,
            right: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        
        
          children:  <Widget>[
    
            FloatingActionButton(
              heroTag: UniqueKey(),
              child: const Icon(Icons.gps_fixed, color: Colors.black),
              onPressed: () {}
                 
                        
            )
          ] 
      ),
    );
  }
}


