// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:inri_driver/models/usuario.dart';
import 'package:inri_driver/service/auth_service.dart';
import 'package:latlong2/latlong.dart';
import 'package:inri_driver/blocs/blocs.dart';
import 'package:provider/provider.dart';


class MapView extends StatefulWidget {

final LatLng initialLocation;


const MapView({
Key? key,
required this.initialLocation
}) : super(key: key);   

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {

  late LocationBloc locationBloc;
  late AddressBloc addressBloc;
  late final MapController _mapController;
  late Usuario usuario;
  AuthService? authService;

  @override
  void initState() {    
    super.initState();

    BlocProvider.of<AuthBloc>(context, listen:false);
    BlocProvider.of<LocationBloc>(context);
    BlocProvider.of<AddressBloc>(context);
    BlocProvider.of<MapBloc>(context);
    _mapController = MapController();
    
  }
@override
  void dispose() {
   
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {  

    final  usuario      = Provider.of<AuthBloc>(context).state.usuario!;  
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final myLocation = locationBloc.state.lastKnownLocation!;
    final location =BlocProvider.of<AddressBloc>(context).state.address!.ubicacion;
    final mapBloc = BlocProvider.of<MapBloc>(context); 

    final zoom = mapBloc.getZoom(location!);     
    final center = mapBloc.bounds(location);  
   
    
    final userLocation = LatLng(location[0], location[1]);

    final size = MediaQuery.of(context).size; 

       return SizedBox(
        width: size.width,
        height: size.height,
        child: FlutterMap(          
          mapController: _mapController,          
          options: MapOptions(             
            zoom: zoom,
            minZoom: 1.0,
            maxZoom: 20.0,            
            center:  center,
          ),
          nonRotatedChildren: [
            TileLayer(
              urlTemplate: usuario.urlMapbox,
              additionalOptions: {               
                'accessToken': usuario.tokenMapBox,
                'id':  usuario.idMapBox,
              },
              
            ),
            
              MarkerLayer(
              markers: [
                Marker(                  
                  point: LatLng(myLocation.latitude, myLocation.longitude),
                  width: 90,
                  height: 90,
                  builder: (context) => 
                 Container(                                                   
                  color: Colors.transparent,
                  child: Image.asset('assets/car2.jpg'),                  
                 ) 
                ),

                   Marker(
                  width: 70,
                  height: 70,  
                  point: LatLng(userLocation.latitude, userLocation.longitude),                  
                  builder: (context) =>                   
                  Container(                                                   
                  color: Colors.transparent,
                  child: Image.asset('assets/icon.jpg'),                  
                 ) 
                )
              ],            
            ), 
          ],          
        ),
       );
     
  }
}
