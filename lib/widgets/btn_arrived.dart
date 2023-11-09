// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inri_driver/service/addresses_service.dart';



class BtnArrived extends StatelessWidget { 
  

  const BtnArrived({
  Key? key,   
  }) : super(key: key);

  @override
  Widget build(BuildContext context) { 
  
  late AddressService addressService = AddressService();
  bool tap = true;
  
    return  tap == true? Positioned(
            top: 412,
            left: 350,
            right: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        
        
          children:  <Widget>[
    
            FloatingActionButton(
              backgroundColor: Colors.indigo,
              heroTag: UniqueKey(),
              child: llego(),
              onPressed: () async{

                await addressService.arrivedDriver(); 
                tap = false;

              }
                 
                        
            )
          ] 
      ),
    ): Container();
  }
}

Widget llego(){
  return  Text("Llegó", style: GoogleFonts.lato (color: Colors.white, fontSize: 15),
  textAlign: TextAlign.end,
  );
  
}


