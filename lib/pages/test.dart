import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inri_driver/blocs/blocs.dart';
import 'package:geolocator/geolocator.dart';

class TestMap extends StatefulWidget {
  const TestMap({Key? key}) : super(key: key);

  @override
  State<TestMap> createState() => _TestMapState();
}

class _TestMapState extends State<TestMap> {
  late GpsBloc gpsBloc;
  late LocationBloc locationBloc;
  late AddressBloc addressBloc;

  @override
  void initState() {
    super.initState();

    final gpsBloc = BlocProvider.of<GpsBloc>(context);
    gpsBloc.init();

    final locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.startFollowingUser();

    final addressBloc = BlocProvider.of<AddressBloc>(context);
    addressBloc.getOrder;
  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getCurrentPosition();

    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, locationState) {

        if (locationState.lastKnownLocation == null)
        { return const Center(child: Text('Espere'));
       
        }

        return BlocBuilder<AddressBloc, AddressState>(
          builder: (context, addressState) {
            return Center(
                child: Text(
                    '${addressState.address!}',
                    
              ),
              
            );
          },
        );
      }),
    );
  }

  Future getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition(
      forceAndroidLocationManager: true,
      desiredAccuracy: LocationAccuracy.best,
    ).timeout(const Duration(seconds: 20));

    // ignore: avoid_print
    print('Position: $position ***************');
  }
}
