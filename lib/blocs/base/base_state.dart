part of 'base_bloc.dart';

class BaseState extends Equatable {  


final BaseModel? baseSelected;

const BaseState({
   
  this.baseSelected,

});

BaseState copyWith({
    
  BaseModel? baseSelected,
 
})
=> BaseState(
  
  baseSelected: baseSelected?? this.baseSelected,

);

  
  @override
  List<Object?> get props => [baseSelected];
}


class BaseInitialState extends BaseState {
  const BaseInitialState(): super( baseSelected: null);
}