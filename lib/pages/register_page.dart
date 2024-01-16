import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inri_driver/blocs/user/auth_bloc.dart';
import 'package:inri_driver/widgets/alert_screen.dart';
import 'package:provider/provider.dart';

import 'package:inri_driver/login_ui/input_decorations.dart';
import 'package:inri_driver/providers/login_form_validar.dart';

import 'package:inri_driver/routes/routes.dart';
import 'package:inri_driver/widgets/card_container.dart';

class RegisterPage extends StatelessWidget {

  
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          
        
        child: Column(

          children: [

           const SizedBox( height: 250),

            CardContainer(

              child: Column(

                children:  [

               const   SizedBox(height: 10,),

                Text('Registrar Conductor',
                  style: GoogleFonts.lobster(
                    color: Colors.black, fontSize: 25
                    ),
                    ),

                 const SizedBox(height: 45,),

                  ChangeNotifierProvider(
                    create: (_) => LoginFormValidar(),
                    child: const _LoginForm(),
                    
                    )
                
                ],
              )
            ),
          
            
          
          ],
        ),
        )
      )
            
      );
    
  }
}
class _LoginForm extends StatefulWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  
  final nameCtrl        = TextEditingController();
  final emailCtrl       = TextEditingController();
  final passCtrl        = TextEditingController();
  final apellidoCtrl    = TextEditingController();
  final nacimientoCtrl  = TextEditingController();
  final domicilioCtrl   = TextEditingController();
  final vehiculoCtrl    = TextEditingController();
  final modeloCtrl      = TextEditingController();
  final patenteCtrl     = TextEditingController();
  final licenciaCtrl    = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final loginFormValidar = Provider.of<LoginFormValidar>(context);
    final authUser = BlocProvider.of<AuthBloc>(context);

    return Form(

      key: loginFormValidar.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,

     child: Column(

       children: [

         TextFormField(
           autocorrect: false,
           keyboardType: TextInputType.emailAddress,            
           decoration: InputDecorations.authInputDecoration(
             hintText: 'exequiel7@gmail.com',
             labelText: 'email',
             prefixIcon: Icons.alternate_email_rounded,
           ),

           onChanged: (value) => loginFormValidar.email,
             validator:(value){
               String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp  = RegExp(pattern);
                  
                  return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El valor ingresado no luce como un correo';
             },
             controller: emailCtrl,             
           ),

           const SizedBox(height: 10,),
            TextFormField(
           autocorrect: false,
           obscureText: true,
           keyboardType: TextInputType.emailAddress,            
           decoration: InputDecorations.authInputDecoration(
             hintText: '********',
             labelText: 'password',
             prefixIcon: Icons.lock_outline
           ),
           onChanged: (value) => loginFormValidar.password,
            validator: ( value ) {

                  return ( value != null && value.length >= 8 ) 
                    ? null
                    : 'La contraseña debe de ser de 8 caracteres';                                    
                  
              },
              controller: passCtrl, 
         ),

        const SizedBox(height: 10),
         TextFormField(
           autocorrect: false,
           keyboardType: TextInputType.text,                     
           decoration: InputDecorations.authInputDecoration(
             hintText: 'exequiel',
             labelText: 'nombre',
             prefixIcon: Icons.person_pin_sharp,      

           ),
           controller: nameCtrl,            
           ),

        const SizedBox(height: 10,),
        TextFormField(
           autocorrect: false,
           obscureText: false,
           keyboardType: TextInputType.text,            
           decoration: InputDecorations.authInputDecoration(
             hintText: 'aguirre',
             labelText: 'apellido',
             prefixIcon: Icons.add_circle,
           ),
            controller: apellidoCtrl, 
         ),        
         
        const SizedBox(height: 10),        
        TextFormField(
           autocorrect: false,
           obscureText: false,
           keyboardType: TextInputType.datetime,            
           decoration: InputDecorations.authInputDecoration(
             hintText: '18-07-1980',
             labelText: 'fecha de nacimiento',
             prefixIcon: Icons.add_circle
           ),
           onChanged: (value) => loginFormValidar.password,
            validator: ( value ) {

                  return ( value != null && value.length >= 6 ) 
                    ? null
                    : 'La fecha debe de ser de 8 caracteres';                                    
                  
              },
              controller: nacimientoCtrl, 
         ),

         const SizedBox(height: 10,),
        TextFormField(
           autocorrect: false,
           obscureText: false,
           keyboardType: TextInputType.streetAddress,            
           decoration: InputDecorations.authInputDecoration(
             hintText: 'avenida chaco 3000',
             labelText: 'domicilio',
             prefixIcon: Icons.add_circle
           ),           
           controller: domicilioCtrl, 
         ),

         const SizedBox(height: 10,),
        TextFormField(
           autocorrect: false,
           obscureText: false,
           keyboardType: TextInputType.text,            
           decoration: InputDecorations.authInputDecoration(
             hintText: 'corsa classic',
             labelText: 'vehiculo',
             prefixIcon: Icons.time_to_leave_rounded
           ),           
           controller: vehiculoCtrl, 
         ),

         const SizedBox(height: 10,),
        TextFormField(
           autocorrect: false,
           obscureText: false,
           keyboardType: const TextInputType.numberWithOptions(),            
           decoration: InputDecorations.authInputDecoration(
             hintText: '2019',
             labelText: 'modelo',
             prefixIcon: Icons.add_circle
           ),
           onChanged: (value) => loginFormValidar.password,
            validator: ( value ) {

                  return ( value != null && value.length >= 4 ) 
                    ? null
                    : 'El modelo debe de ser de 4 caracteres';                                    
                  
              },
              controller: modeloCtrl, 
         ),

         const SizedBox(height: 10,),
        TextFormField(
           autocorrect: false,
           obscureText: false,
           keyboardType: TextInputType.text,            
           decoration: InputDecorations.authInputDecoration(
             hintText: 'AA289HE',
             labelText: 'patente',
             prefixIcon: Icons.add_circle
           ),
           onChanged: (value) => loginFormValidar.password,
            validator: ( value ) {

                  return ( value != null && value.length >= 5 ) 
                    ? null
                    : 'La patente debe de ser de 5 caracteres';                                    
                  
              },
              controller: patenteCtrl, 
         ),

         const SizedBox(height: 10,),
        TextFormField(
           autocorrect: false,
           obscureText: false,
           keyboardType: const TextInputType.numberWithOptions(),            
           decoration: InputDecorations.authInputDecoration(
             hintText: '230',
             labelText: 'licencia',
             prefixIcon: Icons.add_circle
           ),           
           controller: licenciaCtrl, 
         ),         

         const SizedBox(height: 25),       
         
         MaterialButton(
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
           disabledColor: Colors.grey,
           elevation: 0,
           color: Colors.indigo,
           onPressed:  authUser.state.authenticando == true ? (){} 
           : () async {

            final registerOk =await authUser.initRegister(nameCtrl.text.toString(), emailCtrl.text.toString(), passCtrl.text.toString(),
            apellidoCtrl.text.toString(), nacimientoCtrl.text.toString(), domicilioCtrl.text.toString(),
            vehiculoCtrl.text.toString(),modeloCtrl.text.toString(), patenteCtrl.text.toString(), licenciaCtrl.text.toString()); 
                        
            
           
            if(!mounted) return;

            if(registerOk && mounted){

              Navigator.pushReplacementNamed(context, 'loading');

            }else{
              
              mostrarAlerta(context, 'Registro incorrecto', registerOk.toString() );
            }    


           
        },
           child: Container(
             padding: const EdgeInsets.symmetric(horizontal:  80, vertical: 15),
             child: Text(
               loginFormValidar.isLoading? 'Espere'
               : 'Registrar',
               style: const TextStyle(color: Colors.white, fontSize: 18),
             ),
           )          
      ),
      const  SizedBox(height: 15),            
              
             ElevatedButton(onPressed: ()=> Navigator.pushReplacementNamed(context, 'login'),
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.2))
            ),
             
              
              child: const Text('Tengo una Cuenta', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)
            )
      ],
     ) 
    );
  }
  

}



