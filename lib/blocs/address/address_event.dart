part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object?> get props => [];
}

class AddAddressEvent extends AddressEvent{

  final Address address;  
  const AddAddressEvent(this.address);

}



class DeleteAddressEvent extends AddressEvent{
  
  const DeleteAddressEvent();

}

class ExistOrderUserEvent extends AddressEvent{}
class OnStartLoadingAddress extends AddressEvent{}
class OnStopLoadingAddress extends AddressEvent{}
class OnIsAcceptedTravel extends AddressEvent{}
class OnIsDeclinedTravel extends AddressEvent{}
class OnLockBtnArriveEvent extends AddressEvent{}
//class OnArriveDriverEvent extends AddressEvent{}



