import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management_riverpod/countdown/model/countdown_model.dart';
import 'package:state_management_riverpod/countdown/product/enum/timer_state_enum.dart';
import 'package:state_management_riverpod/countdown/provider/countdown_provider.dart';
import 'package:state_management_riverpod/counter/model/counter_model.dart';



final countdownPageTitle = Provider<String>((ref) => "Countdown (Riverpod)");
final counterTextTitle = Provider<String>((ref) => "Add Countdown");

final countdownNotifierProvider = StateNotifierProvider<CountdownNotifier,List<CountDownModel>>((ref)=>  CountdownNotifier());
final timerFilter = StateProvider<TimerState>((ref) => TimerState.all);

final filteredCountdownList = Provider<List<CountDownModel>>((ref) {
  final filter = ref.watch(timerFilter);
  final todoList = ref.watch(countdownNotifierProvider);

  switch (filter) {


    case TimerState.all: 
      return todoList;
    case TimerState.continues:
      return todoList.where((element) => element.state == TimerState.continues).toList();
    case TimerState.paused:
      return todoList.where((element) => element.state == TimerState.paused).toList();
    case TimerState.end:
      return todoList.where((element) => element.state == TimerState.end).toList();

  }
});