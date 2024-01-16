// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:inri_driver/global/environment.dart';
import 'package:inri_driver/models/login.dart';
import 'package:inri_driver/models/usuario.dart';

import 'package:inri_driver/service/storage_service.dart';


class AuthService with ChangeNotifier {

bool _autenticando = false;
final storage = StorageService.instance;

//determina la autenticacion

bool get autenticando => _autenticando;

set autenticando( bool valor ) {
  _autenticando = valor;

  notifyListeners();
}  

  

    //Registro de Usuario
    Future<Usuario> register(String nombre, String email, String password,
    String apellido, String nacimiento, String domicilio,
    String vehiculo, String modelo, String patente, String licencia ) async {

   

    final data = {'nombre': nombre,'email': email,'password': password,
    'apellido': apellido, 'nacimiento': nacimiento, 'domicilio': domicilio,
    'vehiculo': vehiculo, 'modelo': modelo, 'patente': patente,  'licencia': licencia
    };        

    final body = jsonEncode(data);
    final headers = {'Content-Type': 'application/json'};

    final resp = await http.post(Uri.parse('${Environment.apiUrl }/logindriver/newdriver'), body: body, headers: headers);       
    
    

    if ( resp.statusCode == 200 ) {
    
    final loginResponse = loginResponseFromJson( resp.body );
    final usuario = loginResponse.usuario as Usuario;   

    await storage.saveToken(loginResponse.token);

    return usuario;
    
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }

  }

  Future<bool> isLoggedIn(String token) async {
    
    final token  = await StorageService.instance.getTokenUser();
    
    final Map<String, String> headers = {'Content-Type': 'application/json', 'x-token': token.toString()};
  
    
    final resp = await http.get( Uri.parse('${Environment.apiUrl }/login/renew'),   headers: headers);

    if ( resp.statusCode == 200 ) {

      final loginResponse = loginResponseFromJson( resp.body );
      loginResponse.usuario as Usuario;

      await storage.saveToken(loginResponse.token);

      return true;

    } else {

      await storage.logout();

      return false;
    }

  }

  Future<dynamic> loginUser( String email, String password ) async {    
   

    final data = {'email': email, 'password': password};
    final headers = {'Content-Type': 'application/json'};    
    final body = jsonEncode(data);


    final resp = await http.post(Uri.parse('${ Environment.apiUrl }/logindriver'), body: body, headers: headers  );      
   
   
    if ( resp.statusCode == 200 ) {

      final loginResponse = loginResponseFromJson( resp.body );

      final usuario = loginResponse.usuario as Usuario;      
      
      final privateToken = loginResponse.token; 
     
      await  storage.saveToken(privateToken);    
      await  storage.saveId(usuario.id);
      await  storage.saveNameDriver(usuario.nombre);
      
      return usuario;
    } else {     
       final respBody = jsonDecode(resp.body);
      final data = loginResponseFromJson(respBody);
      return data.ok;
     
      }
      

    }
    
   

    
  
}