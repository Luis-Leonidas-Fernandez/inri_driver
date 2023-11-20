// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:inri_driver/blocs/blocs.dart';
import 'package:inri_driver/service/addresses_service.dart';
import 'package:inri_driver/widgets/button_options.dart';

class AcceptButton extends StatelessWidget {
  const AcceptButton({Key? key}) : super(key: key);
  
  bool get mounted => true;

  @override
  Widget build(BuildContext context) {
    
    late AddressService addressService = AddressService();
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final addressBloc = BlocProvider.of<AddressBloc>(context);
    

    final size = MediaQuery.sizeOf(context);
    final alto = size.height;
    

    return alto >= 860?
     Positioned(
            top: 750,
            left: 30,
            right: 210,
            child: BlocBuilder<MapBloc, MapState>(
              builder: (context, state) {
                return ButtonOptions(
                  iconData: Icons.thumb_up_alt_outlined,
                  buttonText: 'Aceptar Viaje',
                  onTap: () async {

                    //Se actualizó el estado del viaje a en camino
                    final address = addressBloc.state.address;
                    await addressService.updateEnCamino(address!);

                    //VISIBILIZA EL BOTON FINALIZAR VIAJE: ISACCEPTED = TRUE
                    addressBloc.add(OnIsAcceptedTravel());

                    //Se emite la posicion del conductor                    
                      locationBloc.sendPeriodicPosition();                                     
                             
                    
                  },
                );
              },
            ),
          )
        : Positioned(
            top: 600,
            left: 20,
            right: 217,
            child: BlocBuilder<MapBloc, MapState>(
              builder: (context, state) {
                return ButtonOptions(
                  iconData: Icons.thumb_up_alt_outlined,
                  buttonText: 'Aceptar Viaje',
                  onTap: () async {

                    //Se actualizó el estado del viaje a en camino
                    final address = addressBloc.state.address;
                    await addressService.updateEnCamino(address!);

                    //VISIBILIZA EL BOTON FINALIZAR VIAJE: ISACCEPTED = TRUE
                    addressBloc.add(OnIsAcceptedTravel());

                    //Se emite la posicion del conductor                    
                      locationBloc.sendPeriodicPosition();                     

                    
                  },
                );
              },
            ),
          );
  }
}


