part of 'counter_bloc.dart';

sealed class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object> get props => [];
}


class CounterIncresed extends CounterEvent {
  final int value;

  const CounterIncresed({required this.value});

}

class CounterReset extends CounterEvent {}