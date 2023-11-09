import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inri_driver/blocs/blocs.dart';
import 'package:inri_driver/pages/notifications_access.dart';
import 'package:inri_driver/routes/routes.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      body: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) {
          
            return state.isAllGranted
            ? const NotificationsAccessPage()
            : const GpsAccessPage();           
            
        }, 
        )
    );
  }
}