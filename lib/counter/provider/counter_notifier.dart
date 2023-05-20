import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management_riverpod/counter/model/counter_model.dart';


class CounterNotifier extends StateNotifier<CounterModel> {
  CounterNotifier(): super(CounterModel(counter: 0));

  void increment()
  {
    var currentValue = state.counter;
    state = CounterModel(counter: currentValue+1);
  }

  void deincrement()
  {
    var currentValue = state.counter;
    state = CounterModel(counter: currentValue-1);
  }
  
}