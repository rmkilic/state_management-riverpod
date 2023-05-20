

import 'package:flutter/material.dart';
import 'package:state_management_riverpod/counter/feature/counter_view.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("[SetState - PAGE] : rebuild");
    return Scaffold(
      appBar: _appbar(),
      body: _body(context),
      floatingActionButton: _fab(), 
    );
  }

  FloatingActionButton _fab() {
    debugPrint("[SetState - FAB] : rebuild");
    return FloatingActionButton(
      onPressed: _incrementCounter,
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }

  Center _body(BuildContext context) {
    debugPrint("[SetState - BODY] : rebuild");
    return Center(
      child: Column(       
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You can check the rebuild from the debug console',
          ),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }

  AppBar _appbar() {
    debugPrint("[SetState - APPBAR] : rebuild");
    return AppBar(      
      title: Text(widget.title),
      actions: [
        ElevatedButton(onPressed: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const CounterView())),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        child: const Text("Go Riverpod"),
        )
      ],
    );
  }
}
