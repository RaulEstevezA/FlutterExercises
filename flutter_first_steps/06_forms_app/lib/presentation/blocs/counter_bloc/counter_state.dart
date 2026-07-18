part of 'counter_bloc.dart';

class CounterState extends Equatable {

  final int counter;
  final int transactionCount;

  const CounterState({
    this.counter = 10, 
    this.transactionCount = 0
    });
  
  @override
  List<Object> get props => [counter, transactionCount];
}

