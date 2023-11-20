// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inri_driver/widgets/alert_screen.dart';

import 'package:provider/provider.dart';
import 'package:inri_driver/routes/routes.dart';

import 'package:inri_driver/login_ui/input_decorations.dart';
import 'package:inri_driver/providers/login_form_validar.dart';

import 'package:inri_driver/service/auth_service.dart';
import 'package:inri_driver/widgets/card_container.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
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
    )));
  }
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
    final authService = Provider.of<AuthService>(context);
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
                onPressed: authService.autenticando
                    ? () {}
                    : () async {

                        final loginOk = await authService.login(
                            emailCtrl.text.toString(),
                            passCtrl.text.toString());


                        
                        
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
                    Navigator.pushReplacementNamed(context, 'register'),
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
