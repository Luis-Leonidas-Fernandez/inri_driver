// ignore_for_file: avoid_print

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inri_driver/blocs/user/auth_bloc.dart';
import 'package:inri_driver/widgets/alert_screen.dart';

import 'package:provider/provider.dart';
import 'package:inri_driver/routes/routes.dart';

import 'package:inri_driver/login_ui/input_decorations.dart';
import 'package:inri_driver/providers/login_form_validar.dart';
import 'package:inri_driver/widgets/card_container.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: StreamBuilder(
          stream:  Connectivity().onConnectivityChanged,
          builder: (context, AsyncSnapshot<ConnectivityResult> snapshot){
            
            print(snapshot.toString());

             if(snapshot.hasData) {
          ConnectivityResult ? result = snapshot.data;
          if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi){

           return authScaffold();
           
          
          }else{
            return disconnected();
          }

        }else{

         return disconnected();
         
        }
            

          }


          )
    );
  }

Widget loading(){
    return const Center(
      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),),
    );
  }

 Widget connected(String type){

    return Center(
      child: Text(
        "$type Connected",
        style: const TextStyle(
          color: Colors.indigo,
          fontSize: 20,
        ),
      ),
    );
  }
  
  Widget disconnected(){
  
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [

      Image.asset('assets/no_internet.png',
      color: Colors.red,
      height: 100,
      ),
      Container(
        margin: const EdgeInsets.only(top: 20, bottom: 10, left: 30, right: 30),        
        child: const Text(
          "No estas Conectado a Internet",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: const Text(
          "Comprueba tu conección por favor",
           style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 17
            )
        ),
      )

    ],
  );
 }

}

Widget authScaffold(){
  return AuthBackground(
            child: SingleChildScrollView(

      child: Column(
        children: [
          const SizedBox(height: 250),
          CardContainer(
              child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                'Inicio Sesion Conductor',
                style: GoogleFonts.lobster(color: Colors.black, fontSize: 25),
              ),

              const SizedBox(height: 45),

              ChangeNotifierProvider(
                create: (_) => LoginFormValidar(),
                child: const _LoginForm(),
              )
            ],
          )),
        ],
      ),
    )
    );
}

class _LoginForm extends StatefulWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authUser = BlocProvider.of<AuthBloc>(context);
    final loginFormValidar = Provider.of<LoginFormValidar>(context);

    return Form(

        key: loginFormValidar.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,

        child: Column(
          children: [

            const SizedBox(height: 05),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'exequiel7@gmail.com',
                labelText: 'correo electrónico',
                prefixIcon: Icons.alternate_email_rounded,
              ),
              onChanged: (value) => loginFormValidar.email,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El valor ingresado no luce como un correo';
              },
              controller: emailCtrl,
            ),
            const SizedBox(height: 10),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: '********',
                  labelText: 'contraseña',
                  prefixIcon: Icons.lock_outline),
              onChanged: (value) => loginFormValidar.password,
              validator: (value) {
                return (value != null && value.length >= 7)
                    ? null
                    : 'La contraseña debe de ser de 8 caracteres';
              },
              controller: passCtrl,
            ),
            const SizedBox(height: 25),

            MaterialButton(

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                    ),
                    disabledColor: Colors.grey,
                    elevation: 0,
                    color: Colors.indigo,
                    onPressed: authUser.state.authenticando == true? () {}
                    : () async {                     
                      

                        final loginOk = await authUser.initLogin(emailCtrl.text.toString(), passCtrl.text.toString());
                                                 
                        
                        
                        if(!mounted) return;
                        
                        if (loginOk && mounted) {

                          Navigator.pushReplacementNamed(context, 'loading');

                        } else {
                           
                          mostrarAlerta(context, 'Login incorrecto','Revise sus credenciales nuevamente');
                        }
                      },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: Text(
                    loginFormValidar.isLoading ? 'Espere' : 'Ingresar',
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )),
            const SizedBox(height: 15),
            ElevatedButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, 'privacy'),
                style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                        Colors.indigo.withOpacity(0.2))),
                child: const Text(
                  'Crear una Cuenta',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ))
          ],
        ));
  }
  
}
