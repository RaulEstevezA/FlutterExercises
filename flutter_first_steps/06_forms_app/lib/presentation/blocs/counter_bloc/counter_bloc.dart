import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState()) {

    on<CounterIncresed>( _onCounterIncrease );
    on<CounterReset>( _onCounterReset );

  }

  void _onCounterIncrease( CounterIncresed event, Emitter<CounterState> emit) {
    emit(state.copyWith(
        counter: state.counter + event.value,
        transactionCount: state.transactionCount + 1
      ));
  }

  void _onCounterReset( CounterReset event, Emitter<CounterState> emit) {
    emit(state.copyWith(
        counter: 0,
        transactionCount: state.transactionCount
      ));
  }

  // operar con eventos dentro del bloc
  void increaseBy(int value){
    add( CounterIncresed(value: value));
  }

  void resetCounter(){
    add( CounterReset());
  }
  // fin ejemplo de operar con eventos

}
