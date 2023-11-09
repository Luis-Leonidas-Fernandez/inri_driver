

import 'package:inri_driver/models/usuario.dart';
import 'package:inri_driver/service/auth_service.dart';

class ProfileService {

late AuthService authService;
Usuario? user;


getProfile(){

final usuario = authService.usuario.nombre;
final user = usuario;
return user;

}






}