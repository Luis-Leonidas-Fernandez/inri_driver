import 'package:flutter/material.dart';
import 'package:inri_driver/models/address.dart';

import 'package:intl/intl.dart';



class CardView extends StatelessWidget {

  final Address address;
  
  const CardView({
  Key? key,
  required this.address,
 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) { 

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 110, bottom: 50),
        width: double.infinity,
        height: 120,
        decoration: _cardBorders(),
        child: Stack(
          
          children: [
            
            
            _AddressDetails(
              nombre: address.nombre?? '',
              email: address.email?? '',
              cupon: address.cupon?? {}              
            ),
            Container(              
              margin: const EdgeInsets.only(top: 28, bottom: 12), 
              alignment: Alignment.bottomRight,             
              height: 50,
              width: 63,
              color: Colors.transparent,
              child: Image.asset('assets/person.jpg'),
            ),
            Align(
               alignment: const Alignment(0.7, -1.0),
              child: Container(
                alignment: Alignment.centerRight,
                height: 330,
                width: 330,
                child:const Icon(Icons.location_pin, 
                color:  Colors.white,
                size: 32,
                ),
                
                ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: const [
      BoxShadow(
        color: Colors.black38,
        offset: Offset(0,10),
        blurRadius: 15
      )
    ]
  );
}

class _AddressDetails extends StatelessWidget {

  final String nombre;
  final String email;
  final Map<String, dynamic> cupon;

  const _AddressDetails({
  required this.nombre,
  required this.email,
  required this.cupon  
  
  }); 

  @override
  Widget build(BuildContext context) {

    final idCupon = cupon.entries.isNotEmpty ? cupon.values.first : 0;
    final price    = cupon.entries.isNotEmpty ? cupon.values.last :  0;
    final idCuponCustom   = 'cupon N°: $idCupon';  

     
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 400,
        color: Colors.indigo,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,                  
          children: [
           
           
            Align(
              alignment: const Alignment(0.1, -0.9),
              child: Text(
                email.toString(),
                style: const TextStyle( fontSize: 18, color: Colors.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 3),
            Align(
              alignment: const Alignment(0.0, -0.9),
              child: Text(
                
                nombre,
                style: const TextStyle( fontSize: 18, color: Colors.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 3),
            
            Align(
              alignment: const Alignment(0.1, -0.9),
              child: Text(
                  idCupon is String ? idCuponCustom 
                  : '',
                  style: const TextStyle( fontSize: 18, color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ),
              const SizedBox(height: 3), 
              
                        
            Align(
              alignment: const Alignment(0.1, -0.9),
              child: Text(
                   price is int?
                  'descuento: ${NumberFormat.currency(decimalDigits: 0).format(price)}'
                  : '',                
                  style: const TextStyle( fontSize: 18, color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ),
          ],
        ),     
      ),
    );
  }
}
