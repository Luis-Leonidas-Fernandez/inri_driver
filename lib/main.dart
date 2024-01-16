import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:inri_driver/blocs/blocs.dart';
import 'package:inri_driver/pages/notifications_access.dart';
import 'package:inri_driver/repositories/background_instance.dart';

import 'package:inri_driver/service/addresses_service.dart';
import 'package:inri_driver/service/background_service.dart';

import 'package:inri_driver/service/auth_service.dart';
import 'package:inri_driver/routes/routes.dart';

import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:intl/number_symbols_data.dart';

import 'package:intl/number_symbols.dart';
import 'package:inri_driver/config/namber_symbol.dart';
import 'package:path_provider/path_provider.dart';



void main() async {

    WidgetsFlutterBinding.ensureInitialized();    
    await BackgroundService.instance.initializeService();


    HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );    

    Intl.defaultLocale = 'es_ARG';

    
    initializeDateFormatting('es_ARG', '');
    
    final enUS = numberFormatSymbols['en_US'] as NumberSymbols;

    numberFormatSymbols['es_ARG'] = enUS.copyWith(
      currencySymbol: r'$',
    );
    
  runApp(

    MultiBlocProvider(
      providers: [

        BlocProvider(create: (context) => AuthBloc(authService: AuthService())),
        BlocProvider(create: (context) => GpsBloc() ), 
        BlocProvider(create: (context) => NotificationBloc()),       
        BlocProvider(create: (context) => LocationBloc() ),
        BlocProvider(create: (context) => AddressBloc(addressService: AddressService(),),  ),
        BlocProvider(create: (context) => MapBloc(locationBloc: BlocProvider.of<LocationBloc>(context),
        addressBloc: BlocProvider.of<AddressBloc>(context), backgroundLocationRepository: BackgroundInstance() )),
               
      ],

      child: const MyApp() 
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'driver inri',
      initialRoute: 'login',
      routes: {  
    
        'login'         : (BuildContext context) => const LoginPage(),
        'register'      : (BuildContext context) => const RegisterPage(),
        'home'          : (BuildContext context) => const HomePage(),
        'gps'           : (BuildContext context) => const GpsAccessPage(),
        'loading'       : (BuildContext context) => const LoadingPage(),
        'notification': (BuildContext context) => const NotificationsAccessPage(),
         
                          
      },
    
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300]
      ),
    );
  }
}

