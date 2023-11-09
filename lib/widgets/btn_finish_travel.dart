import 'package:inri_driver/service/addresses_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inri_driver/blocs/blocs.dart';
import 'package:inri_driver/widgets/button_options.dart';

class BtnFinishTravel extends StatelessWidget {

  const BtnFinishTravel({Key? key}) : super(key: key);
  
  bool get mounted => true;

  @override
  Widget build(BuildContext context) {

    late AddressService addressService = AddressService();
    final locationBloc = BlocProvider.of<LocationBloc>(context);    
    final addressBloc     = BlocProvider.of<AddressBloc>(context);
    
    final size = MediaQuery.sizeOf(context);
    final alto = size.height;


    return alto >= 860?

    Positioned(
                top: 750,
                left: 90,
                right: 90,
                child: BlocBuilder<MapBloc, MapState>(
                  builder: (context, state) {
                    return ButtonOptions(iconData: Icons.free_cancellation_outlined,
                           buttonText: 'Finalizar Viaje',
                           onTap: () async {

                             // Eliminando viaje de base de datos
                            final address = addressBloc.state.address;                     
                            await  addressService.finishTravel(address!);                            

                            // ocultando boton finalizar: ISACCEPTED= FALSE
                            addressBloc.add(OnIsDeclinedTravel());
                            
                            // intentando emitir un evento 
                            addressBloc.add(const DeleteAddressEvent());
                           
                            //dejar de emitir posicion del conductor
                            locationBloc.stopPeriodicTask();

                            if (!mounted) return;

                            Navigator.pushReplacementNamed(context, 'loading' );
                                                    

                           },
                             
                     );
                  }, 
                  
                ),
                
              )
              : Positioned(
                top: 600,
                left: 90,
                right: 90,
                child: BlocBuilder<MapBloc, MapState>(
                  builder: (context, state) {
                    return ButtonOptions(iconData: Icons.free_cancellation_outlined,
                           buttonText: 'Finalizar Viaje',
                           onTap: () async {

                             // Eliminando viaje de base de datos
                            final address = addressBloc.state.address;                     
                            await  addressService.finishTravel(address!);                            

                            // ocultando boton finalizar: ISACCEPTED= FALSE
                            addressBloc.add(OnIsDeclinedTravel());
                            
                            // intentando emitir un evento 
                            addressBloc.add(const DeleteAddressEvent());
                           
                            //dejar de emitir posicion del conductor
                            locationBloc.stopPeriodicTask();

                            if (!mounted) return;

                            Navigator.pushReplacementNamed(context, 'loading' );
                                                    

                           },
                             
                     );
                  }, 
                  
                ),
                
              );
  }
}

