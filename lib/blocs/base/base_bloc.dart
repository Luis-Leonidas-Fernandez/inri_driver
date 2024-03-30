import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:inri_driver/models/base.dart';

part 'base_event.dart';
part 'base_state.dart';

class BaseBloc extends Bloc<BaseEvent, BaseState> {


  BaseBloc() : super(const BaseState(baseSelected: null)) {

     on<AddBaseEvent>((event, emit) {
      emit(state.copyWith( baseSelected: event.baseSelected));      
    });
  }

  void addBase(BaseModel data) async {
    
    final obj = BaseModel(zona: data.zona, base: data.base);
  
    add(AddBaseEvent(obj));

    final base = state.baseSelected;
    final result = base.toString();
    // ignore: avoid_print
    print("STATE base bloc: $result");

  }


}
