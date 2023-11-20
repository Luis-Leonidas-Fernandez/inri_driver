import 'dart:io';

class Environment {

  //urls services
  static String apiUrl    = Platform.isAndroid ? 'https://www.inriservice.com/api' : 'http://localhost:3000/api';
  static String urlSocket = Platform.isAndroid ? 'https://www.inriservice.com/'  : 'http://localhost:3000';
  
 
}