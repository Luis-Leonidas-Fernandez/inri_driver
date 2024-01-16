import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {

  final String text = 'Aun no ingresan viajes';
  
  const SearchView({
  Key? key,
  
  }) : super(key: key);

  @override
  Widget build(BuildContext context) { 

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 110, bottom: 50),
        width: double.infinity,
        height: 70,
        decoration: _cardBorders(),
        child: Stack(
          
          children: [
            
            
            _AddressDetails(
              text: text,
                
            ),
            Container(              
              margin: const EdgeInsets.only(top: 10, bottom: 12), 
              alignment: Alignment.bottomRight,             
              height: 50,
              width: 63,
              color: Colors.transparent,
              child: Image.asset('assets/person.jpg'),
            ),
            Container(
              alignment: Alignment.centerRight,
              height: 330,
              width: 330,
              child:const Icon(Icons.location_pin, 
              color:  Colors.white,
              size: 32,
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

  final String text;   

  const _AddressDetails({
  required this.text,
    
  
  }); 

  @override
  Widget build(BuildContext context) {
     
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 400,
        color: Colors.indigo,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          verticalDirection: VerticalDirection.up,          
          children: [

            Text(
              text,
              style: const TextStyle( fontSize: 19, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 3), 
            
          ],
        ),     
      ),
    );
  }
}
