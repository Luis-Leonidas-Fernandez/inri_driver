part of 'base_bloc.dart';

abstract class BaseEvent extends Equatable {

  const BaseEvent();

  @override
  List<Object> get props => [];
}

class AddBaseEvent extends BaseEvent{

  final BaseModel baseSelected;  
  const AddBaseEvent(this.baseSelected);

}