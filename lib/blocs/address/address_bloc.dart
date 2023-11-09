// ignore_for_file: avoid_print

import 'dart:async';



import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inri_driver/models/address.dart';



import 'package:inri_driver/service/addresses_service.dart';
import 'package:inri_driver/service/location_service.dart';


part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  
  
  AddressService addressService;
  Address? address;
  StreamSubscription<List<Address>>? addressStream;
  

  final StreamController<Address> _addressController = StreamController();
  Stream get  addressOrder => _addressController.stream;

  AddressBloc({

     required this.addressService,     
  
  }) : super( const AddressState()) {

  on<OnStartLoadingAddress>((event, emit) => emit(state.copyWith(loading: true)));
  on<OnStopLoadingAddress> ((event, emit)  => emit(state.copyWith(loading: false)));
  on<ExistOrderUserEvent>((event, emit)  => emit(state.copyWith(existOrder: false)));
  on<OnIsAcceptedTravel>((event, emit) => emit(state.copyWith(isAccepted: true)));
  on<OnIsDeclinedTravel>((event, emit) => emit(state.copyWith(isAccepted: false)));
  on<DeleteAddressEvent> ((event, emit)  => emit(const UserInitialState()));  
  
  on<AddAddressEvent>((event, emit) {

      emit(state.copyWith(
        address: event.address,
        existOrder: true,
        addresshistory: [...state.addressHistory, event.address]
      
      ));
      
    });

    
    
  }
  // Guarda una Address dentro de un evento tipo Address
  Stream<Address> get getOrder async* { 
     
    
    final respOrder = await addressService.getAddresses();
   
    final id =respOrder.idDriver;
    

    if(id == '0' ){

      add(const DeleteAddressEvent());
      return;
    }else{
     
      add(AddAddressEvent(respOrder));
      
     _addressController.add(respOrder);

     LocationService.instance.saveOrderUser(respOrder);     

      yield respOrder;
     
    }    
    

  } 

  
  
  
  void startLoadingAddress(){ 

    add(OnStartLoadingAddress());  
    getOrder;
   
  } 

  void stopLoadingAddress(){    
    addressStream?.cancel();
    _addressController.close;
    add(OnStopLoadingAddress());
   
  }


  @override
  Future<void> close() {
    stopLoadingAddress();
    return super.close();
  }

}
