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

    final alto = MediaQuery.sizeOf(context).height;
    
    return alto >= 840 ?

    MyBigButton(
    addressBloc: addressBloc,
    addressService: addressService,
    locationBloc: locationBloc)

    : MySmallButton(
    addressBloc: addressBloc,
    addressService: addressService,
    locationBloc: locationBloc);
        
  }
}





 class MyBigButton extends StatelessWidget {
  const MyBigButton({
    Key? key,
    required this.addressBloc,
    required this.addressService,
    required this.locationBloc,
  }) : super(key: key);

  final AddressBloc addressBloc;
  final AddressService addressService;
  final LocationBloc locationBloc;

  @override
  Widget build(BuildContext context) {

    return Positioned(
           top: 780,
           left: 30,
           right: 210,
           child: ButtonOptions(
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

                 final accepted =addressBloc.state.isAccepted;

                 print("************IS ACCEPTED: $accepted**********"); 

               //VISIBILIZA EL BOTO LLEGO: TAP = TRUE

               //addressBloc.add(OnArriveDriverEvent());  

                                                     
                        
               
             },
           ),
         );
  }
}

class MySmallButton extends StatelessWidget {
  const MySmallButton({
    Key? key,
    required this.addressBloc,
    required this.addressService,
    required this.locationBloc,
  }) : super(key: key);

  final AddressBloc addressBloc;
  final AddressService addressService;
  final LocationBloc locationBloc;

  @override
  Widget build(BuildContext context) {

    return Positioned(
           top: 600,
           left: 30,
           right: 210,
           child: ButtonOptions(
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

               //VISIBILIZA EL BOTO LLEGO: TAP = TRUE

               //addressBloc.add(OnArriveDriverEvent());                                     
                        
               
             },
           ),
         );
  }
}
 
