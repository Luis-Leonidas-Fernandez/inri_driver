// ignore_for_file: avoid_print
import 'dart:async';
import 'package:equatable/equatable.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:inri_driver/models/address.dart';

import 'package:inri_driver/service/addresses_service.dart';
import 'package:inri_driver/service/location_service.dart';


part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends HydratedBloc<AddressEvent, AddressState> {
  
  
  AddressService addressService;
  //Address? address;
  //StreamSubscription<List<Address>>? addressStream;
  

  final StreamController<Address> _addressController = StreamController();
  Stream get  addressOrder => _addressController.stream;

  AddressBloc({

     required this.addressService,     
  
  }) : super( const AddressState()) {

  on<OnStartLoadingAddress>((event, emit) => emit(state.copyWith(loading: true)));
  on<OnStopLoadingAddress> ((event, emit)  => emit(state.copyWith(loading: false)));
  on<ExistOrderUserEvent>((event, emit)  => emit(state.copyWith(existOrder: false)));
  on<OnIsAcceptedTravel>((event, emit) => emit(state.copyWith(isAccepted: true, isPressed: true)));
  on<OnIsDeclinedTravel>((event, emit) => emit(state.copyWith(isAccepted: false)));
  on<DeleteAddressEvent> ((event, emit)  => emit(const UserInitialState()));    
  on<OnLockBtnArriveEvent>((event, emit) => emit(state.copyWith(isPressed: false)));

  on<AddAddressEvent>((event, emit) {

      emit(state.copyWith(
        address: event.address,
        existOrder: true,        
        addresshistory: [...state.addressHistory, event.address]
      
      ));
      
    });

    
    
  }

    @override
  Map<String, dynamic>? toJson(AddressState state) {

    if (state.address != null) {

      final data = state.address!.toJson();
     
      return data;
    }
    return null;

  }

  @override
  AddressState? fromJson(Map<String, dynamic> json) {
      

      try {
        
       final order = Address.fromJson(json);

       final obj = AddressState(
       address:  order,
       existOrder: order.id != null? true : false,       
       addressHistory: [...state.addressHistory, order] );      
               
       return obj;  

        
      } catch (e) {
        return null;
      }       
     
  } 



  // Guarda una Address dentro de un evento tipo Address
  Stream<Address> getOrder() async* { 
     
    
    final respOrder = await addressService.getAddresses();    
    
    final id =respOrder.idDriver;
    

    if(id == '0'){

       
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
    _addressController.close;
    add(OnStopLoadingAddress());
   
  }


  @override
  Future<void> close() {
    stopLoadingAddress();
    return super.close();
  }

}
