// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inri_driver/blocs/blocs.dart';
import 'package:inri_driver/widgets/button_options.dart';
import 'package:inri_driver/service/addresses_service.dart';

class DeclineButton extends StatelessWidget {

  const DeclineButton({Key? key}) : super(key: key);
  
  bool get mounted => true;

  @override
  Widget build(BuildContext context) {

    late AddressService addressService = AddressService();
    final addressBloc =  BlocProvider.of<AddressBloc>(context);
    
    final alto = MediaQuery.sizeOf(context).height;  
   

    return alto >= 840?

    BigButton(
    addressBloc: addressBloc,
    addressService: addressService)
    
    : SmallButton(
    addressBloc: addressBloc,
    addressService: addressService);
            
    }
}




class SmallButton extends StatelessWidget {
  const SmallButton({
    Key? key,
    required this.addressBloc,
    required this.addressService,
  }) : super(key: key);

  final AddressBloc addressBloc;
  final AddressService addressService;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 600,
        left: 210,
        right: 20,
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            return ButtonOptions(iconData: Icons.thumb_down_alt_outlined,
                   buttonText: 'Rechazar Viaje',
                   onTap: () async{
                     
                     final address = addressBloc.state.address;

                     await  addressService.finishTravel(address!);
                     
                     addressBloc.add(OnIsDeclinedTravel());
                     addressBloc.add(ExistOrderUserEvent()); 

                     Navigator.pushReplacementNamed(context, 'notification');
                                                

                   }, 
             );
          },
        ),
      );
  }
}

class BigButton extends StatelessWidget {
  const BigButton({
    Key? key,
    required this.addressBloc,
    required this.addressService,
  }) : super(key: key);

  final AddressBloc addressBloc;
  final AddressService addressService;

  @override
  Widget build(BuildContext context) {
    return Positioned(
                top: 780,
                left: 220,
                right: 20,
                child: BlocBuilder<MapBloc, MapState>(
                  builder: (context, state) {
                    return ButtonOptions(iconData: Icons.thumb_down_alt_outlined,
                           buttonText: 'Rechazar Viaje',
                           onTap: () async{
                             
                             final address = addressBloc.state.address;

                             await  addressService.finishTravel(address!);
                             
                             addressBloc.add(OnIsDeclinedTravel());
                             addressBloc.add(ExistOrderUserEvent()); 

                             Navigator.pushReplacementNamed(context, 'notification');
                                                        

                           }, 
                     );
                  },
                ),
              );
  }
}