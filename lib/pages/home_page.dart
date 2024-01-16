// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:inri_driver/blocs/blocs.dart';
import 'package:inri_driver/connection/log_out.dart';
import 'package:inri_driver/models/address.dart';
import 'package:inri_driver/models/usuario.dart';
import 'package:inri_driver/views/views.dart';
import 'package:inri_driver/widgets/btn_arrived.dart';

import 'package:inri_driver/widgets/widgets.dart';

import 'package:latlong2/latlong.dart';

class HomePage extends StatefulWidget {

  
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AddressBloc? addressBloc;
  LocationBloc? locationBloc;
  AuthBloc? usuarioBloc;
  Usuario? usuario;

  @override
  void initState() {
    super.initState();

    final locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.startFollowingUser();

    final addressBloc = BlocProvider.of<AddressBloc>(context);
    //addressBloc.getOrder;
    addressBloc.state.loading;
    addressBloc.startLoadingAddress();

    final mapBloc = BlocProvider.of<MapBloc>(context);
    mapBloc.initBackgroundService();   

    BlocProvider.of<LocationBloc>(context);
    BlocProvider.of<AuthBloc>(context);
  }

  @override
  void dispose() {
    locationBloc?.stopFollowingUser();
    locationBloc?.stopPeriodicTask();
    addressBloc?.stopLoadingAddress();
    usuarioBloc?.deleteUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final usuarioBloc = BlocProvider.of<AuthBloc>(context);
    final addressBloc = BlocProvider.of<AddressBloc>(context);   
    // final locationBloc = BlocProvider.of<LocationBloc>(context);
    //

    final usuario = usuarioBloc.state.usuario;
    //addressBloc.getOrder;
    addressBloc.state.loading;

    return Scaffold(

      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        )
        ),
        title: Center(
            child: Text(
          'Bienvenido a Inri ${usuario!.nombre}',
          style: GoogleFonts.satisfy(color: Colors.white, fontSize: 25),
        )
        ),
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(
              Icons.exit_to_app_rounded,
              color: Colors.white,
            ),
            onPressed: () async {      

                

              LogOutApp.instance.finishApp();
                     
              if (!mounted) return;              
              Navigator.pushReplacementNamed(context, 'login');
              setState(() {});
            },
          );
        }),
      ),
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          if (state.lastKnownLocation == null) return const Center(child: Text('Espere por favor...'),);
          final long = (state.lastKnownLocation!.longitude);
          final lat = state.lastKnownLocation!.latitude;         
         

          return StreamBuilder(
              stream: addressBloc.getOrder(),
              builder: (context, AsyncSnapshot<Address> snapshot) {             
              final address = snapshot.data;            
                              
                
                return SingleChildScrollView(

                  child: Stack(

                    children: [

                            addressBloc.state.existOrder == true && address != null
                          ? MapView(initialLocation: LatLng(lat, long))
                          : MapViewNoData(initialLocation: LatLng(lat, long)),


                            address?.id != null && addressBloc.state.existOrder == true?
                            CardView(address: address!)
                          : const SearchView(),
                          

                           //BUTONS

                           //aqui boton aceptar viaje
                            addressBloc.state.existOrder == true &&
                            addressBloc.state.isAccepted == false
                          ? const AcceptButton()
                          : Container(),

                           // aqui boton rechazar viaje
                            addressBloc.state.existOrder == true &&
                            addressBloc.state.isAccepted == false
                          ? const DeclineButton()
                          : Container(),

                           // aqui boton finalizar viaje

                           addressBloc.state.isAccepted == true
                          ? const BtnFinishTravel()
                          : Container(),

                      const BtnMyTracking(),

                      addressBloc.state.isPressed == true?
                      const BtnArrived()
                      : Container()
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
