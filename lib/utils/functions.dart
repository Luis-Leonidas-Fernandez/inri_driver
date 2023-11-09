

class Functions {

Functions._internal();
 static final Functions _instance = Functions._internal();
 static Functions get instance => _instance;

 

dynamic testNull(address) {

  final arrayAddress= [];      
  final len = address.length;  
  final addressNull =  [{'id': "1"}];

  if(len != 0) {
      
  for(int i= 0; i < address.length; i++){      
      
    final obj = address[i];            
    arrayAddress.add(obj);
            
   }
    
    return arrayAddress.first;//devuelve un objeto address 

  } else {    
    
    
    final  result = addressNull;

    return result; //devuelve un objeto address con id:1

  }   

    
}




}