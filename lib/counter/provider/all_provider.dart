import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management_riverpod/counter/model/counter_model.dart';

import 'counter_notifier.dart';

final counterPageTitle = Provider<String>((ref) => "Counter with Riverpod(State Notifier)");
final counterTextTitle = Provider<String>((ref) => "Push Button Count");
final counterOddEven = Provider<String>((ref) => ref.watch(counterNotifierProvider).counter %2 == 0 ? "is EVEN" : "is ODD");
final counterNotifierProvider = StateNotifierProvider<CounterNotifier,CounterModel>((ref) => CounterNotifier());
