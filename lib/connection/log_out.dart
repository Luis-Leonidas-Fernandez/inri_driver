
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:inri_driver/Generators/isolate_parse_json.dart';
import 'package:inri_driver/service/addresses_service.dart';
import 'package:inri_driver/service/socket_service.dart';
import 'package:inri_driver/service/storage_service.dart';

class LogOutApp {


   LogOutApp._internal();

   static final LogOutApp _instance = LogOutApp._internal();
   static LogOutApp get instance => _instance;
   late AddressService addressService = AddressService();

   void finishApp() async {

     //Desconectar Conductor
     addressService.disconnectDriver();
     Future.delayed(const Duration(seconds: 3));      
   
    //Cerrar conexcion del socket
    SocketService.instance.finishSocket();

    //Eliminar ID ORDER
    StorageService.instance.deleteIdOrder(); 

    // Eliminar token
    StorageService.instance.logout();

    //finalizar Isolate get Orders

    ParseData.instance.stopIsolate();

    // Finalizar BackgroundService
    final service = FlutterBackgroundService();
    service.invoke('stopService');
    
    


   }
}