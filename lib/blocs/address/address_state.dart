part of 'address_bloc.dart';


class AddressState extends Equatable {  

final bool loading;
final bool existOrder; 
final Address? address;
final List<Address> addressHistory;
final bool isAccepted;




const AddressState({
  this.loading = false,
  this.existOrder= false,  
  this.address,
  this.isAccepted = false,  
  addressHistory   

}): addressHistory = addressHistory ?? const[];

AddressState copyWith({
  bool? loading,
  bool? existOrder,  
  Address? address,
  bool? isAccepted,  
  List<Address>? addresshistory
})
=> AddressState(
  loading: loading?? this.loading,
  existOrder: existOrder?? this.existOrder, 
  address: address?? this.address,
  isAccepted: isAccepted?? this.isAccepted,  
  addressHistory: addresshistory?? addressHistory
);

  
  @override
  List<Object?> get props => [loading, existOrder,  isAccepted, address, addressHistory,];
}

class UserInitialState extends AddressState {
  const UserInitialState(): super( existOrder: false, address: null );
}

