// ignore_for_file: avoid_print

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
    
     final size = MediaQuery.sizeOf(context);
    final alto = size.height;
    

    return alto >= 860?

    Positioned(
                top: 750,
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
                                                        

                           }, 
                     );
                  },
                ),
              )
            : Positioned(
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
                                                        

                           }, 
                     );
                  },
                ),
              );
            
      }
}