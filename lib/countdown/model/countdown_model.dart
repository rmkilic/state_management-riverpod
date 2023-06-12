
import 'package:state_management_riverpod/countdown/product/enum/timer_state_enum.dart';

class CountDownModel{
  String id; // I will use uuid for unique id
  TimerState state;
  int initialValue;
  Duration remainingTime; 

  CountDownModel({required this.id, required this.initialValue, required this.state, required this.remainingTime});
}