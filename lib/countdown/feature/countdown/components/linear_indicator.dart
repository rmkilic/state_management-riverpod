

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management_riverpod/countdown/model/countdown_model.dart';



class LinearIndicatorConsumer extends ConsumerStatefulWidget {
  final CountDownModel item;
  const LinearIndicatorConsumer({required this.item,super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LinearIndicatorConsumerState();
}

class _LinearIndicatorConsumerState extends ConsumerState<LinearIndicatorConsumer> {

  @override
  Widget build(BuildContext context) { 
  
   Duration _duration = widget.item.remainingTime;
   int _initialValue = widget.item.initialValue;

    return LinearProgressIndicator(
          value: 1- ((_duration.inSeconds * 100)/(Duration(seconds: _initialValue).inSeconds*100)),
          color: Colors.red.shade300,
          backgroundColor: Colors.grey.withOpacity(.4),
        );
    
    
  }
}

