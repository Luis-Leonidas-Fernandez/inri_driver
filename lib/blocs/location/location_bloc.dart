// ignore_for_file: avoid_print

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import 'package:inri_driver/service/socket_service.dart';
import 'package:inri_driver/service/storage_service.dart';
import 'package:latlong2/latlong.dart' show LatLng;

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {

  
  StreamSubscription<Position>? positionStream;
  Timer? timer;
 
  LocationBloc() : super(const LocationState()) {

    on<OnStartFollowingUser>((event, emit) => emit(state.copyWith(followingUser: true)));
    on<OnStopFollowingUser>((event, emit) => emit(state.copyWith(followingUser: false)));

    on<OnNewUserLocationEvent>((event, emit) {
      emit(state.copyWith(
          lastKnownLocation: event.newLocation,
          myLocationHistory: [...state.myLocationHistory, event.newLocation]));
    });
  }

  Future getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    print('Position: $position ***************');

    add(OnNewUserLocationEvent(LatLng(position.latitude, position.longitude)));
  }

  void startFollowingUser() {
    //Inicializa el socket
    SocketService.instance.initSocket();

    // FollowingUser = true;
    add(OnStartFollowingUser());

    positionStream = Geolocator.getPositionStream().listen((event) {
      final position = event;

      //Agrega la ubicacion del usuario a un evento
      add(OnNewUserLocationEvent(
          LatLng(position.latitude, position.longitude)));
    });
  }

  

  void sendPeriodicPosition() {
   
    timer = Timer.periodic(const Duration(minutes: 1), (timer) async {
      print(timer.tick);
    
         final position = state.lastKnownLocation!;       
        
         sendLocationDriver(position);
        
      //}
    });
  }

  Future<void> sendLocationDriver(LatLng position) async {

    final socket = SocketService.instance.socket;

    final location = position;
    final data = LatLng(location.longitude, location.latitude);

    print("*******EMIT FROM SOCKET POSITION: $data***********");
    final idUser = await StorageService.instance.getId();
    final idOrder = await StorageService.instance.getIdOrder();
    
    await Future.delayed(const Duration(seconds: 2));

    socket!.emit('driver-location',
        {'mensaje': data, 'idDriver': idUser, 'idOrder': idOrder});
    await Future.delayed(const Duration(seconds: 2));
  }

  void stopPeriodicTask() {
    timer?.cancel();
    timer = null;
   
  }

  void stopFollowingUser() {
    positionStream?.cancel();
    add(OnStopFollowingUser());
  }

  @override
  Future<void> close() {
    SocketService.instance.finishSocket();
    stopFollowingUser();
    stopPeriodicTask();
    return super.close();
  }
}
