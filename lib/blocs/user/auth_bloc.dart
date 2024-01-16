import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:inri_driver/models/login.dart';
import 'package:inri_driver/models/usuario.dart';
import 'package:inri_driver/service/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {

  AuthService authService;

  AuthBloc({required this.authService}) : super(const AuthState(authenticando: false, usuario:  null)) {
    
    on<OnAuthenticatingEvent>((event, emit) => emit(state.copyWith(autenticando: true)));
    on<OnClearUserSessionEvent>((event, emit) => emit(const UserSessionInitialState()));
    on<OnAddUserSessionEvent>((event, emit) { 
    
    emit(state.copyWith(    
      usuario: event.usuario,
      autenticando: true,    
    ));
  });
  }



  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    
      try {

      final response = json.toString();
      final usuario  = loginResponseFromJson(response).usuario;
            
      final authUserState = AuthState(
      usuario: usuario,
      authenticando: state.authenticando      
       );

      final data = authUserState.usuario!.id;
      
      // ignore: avoid_print
      print("USER UID: $data");      
      
      return authUserState;  

      
    } catch (e) {
      return null;
    }
  }
  
  @override
  Map<String, dynamic>? toJson(AuthState state) {
       
      if(state.usuario != null){
      final data = state.usuario!.toJson();      
     
      return data;
     }else{
      return null;
     }     
  }

  Future<bool> initRegister(String nombre, String email, String password,
    String apellido, String nacimiento, String domicilio,
    String vehiculo, String modelo, String patente, String licencia ) async {

    
    final usuario = await authService.register(nombre, email, password,
    apellido, nacimiento, domicilio, vehiculo, modelo, patente, licencia );   

      
    
     if(usuario.id.isNotEmpty){

    add(OnAddUserSessionEvent(usuario));
  

      return true;
     }else{

      
      return false;
     }    

  }

  Future<bool> initLogin(String email, String password) async {

    
    final usuario = await authService.loginUser(email, password);

    final result = usuario.toString();

    // ignore: avoid_print
    print("INIT LOGIN BLOC: $result");     
    
     if(usuario is Usuario){

      add(OnAddUserSessionEvent(usuario));   
   
      return true;
     }else{     
      return false;
     }    

  }

  void deleteUser(){
   add(const OnClearUserSessionEvent());
  }

  @override
  Future<void> close() {
    deleteUser();
    return super.close();
  }  


}

