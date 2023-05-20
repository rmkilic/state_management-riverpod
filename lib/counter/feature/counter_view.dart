

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management_riverpod/counter/provider/all_provider.dart';



class CounterView extends ConsumerWidget {
  const CounterView({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("[Counter View - PAGE] : rebuild");
    return Scaffold(
      appBar: _appbar(ref),
      body: _body(ref),
      floatingActionButton: _fab(), 
    );
  }


   _appbar(WidgetRef ref) {
    debugPrint("[Counter View - APPBAR] : rebuild");
        return AppBar(
          title: Text(ref.watch(counterPageTitle),style: const TextStyle(fontSize: 17.0),),
        );
  }

  Center _body(WidgetRef ref) {
        debugPrint("[Counter View - BODY] : rebuild");
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  <Widget>[
          const Text("is Even & is Odd  \nTwo proivders use!",style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          const SizedBox(height: 50.0,),
          Text("${ref.watch(counterTextTitle)} : ${ref.watch(counterOddEven)}",style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          const Counter(),
        ],
      ),
    );
  }

     _fab() {
      
    return Consumer(
      builder: (context, ref, child) {
        debugPrint("[Counter View - FAB] : rebuild");
        return FloatingActionButton(
          onPressed:ref.read(counterNotifierProvider.notifier).increment,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        );
      }
    );
  }



}

class Counter extends ConsumerWidget {
  const Counter({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentCounterValue = ref.watch(counterNotifierProvider);
    debugPrint("[Counter View - COUNTER] : rebuild");
    
    return Text(
      currentCounterValue.counter.toString(),
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}