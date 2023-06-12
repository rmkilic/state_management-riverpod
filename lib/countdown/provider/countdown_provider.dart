
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management_riverpod/countdown/model/countdown_model.dart';
import 'package:state_management_riverpod/countdown/product/enum/timer_state_enum.dart';




class CountdownNotifier extends StateNotifier<List<CountDownModel>> {
  CountdownNotifier([List<CountDownModel> ? initialList]): super( initialList ?? []);
  


  void add(CountDownModel item)
  {
    //Ön planda gelen bildirimleri burada ekliyoruz . 
      if(state.any((element) => element.id == item.id)) {
        _update(item);
      } else {
        _add(item);
      }


  }
  void _add(CountDownModel item)
  {
 
    state = [...state, item];
     _startTimer2(item);  

  }
  void _update(CountDownModel item)
  {

    state = [ 
        for(var count in state)
          if(item.id == count.id)
          item          
          else
          count   
    ];
  }

  void clearAll()
  {
    state = [];
    clearStream();

  }
  void clearStream()
  {
    _subList.clear();
    _myStreamList.clear();
  }

List<Stream> _myStreamList = [];
List<StreamSubscription> _subList = [];


_startTimer2(CountDownModel model)
{   
  Stream<int> _stream = Stream<int>.periodic(const Duration(seconds: 1), ( spendTime) {
    return spendTime+1;
  }).takeWhile((element) => (element ) <= model.initialValue);
  StreamSubscription _sub = _stream.listen((event) {
    model.remainingTime = Duration(seconds:event);
      state = [
      for(var item in state)
        if(item.id != model.id)
        item
        else
          _getCheckTimeOut(model, _myStreamList.indexWhere((element) => element == _stream), event) 
        
    ];
    
    
   });
    
      _myStreamList.add(_stream);
      _subList.add(_sub);
}

CountDownModel _getCheckTimeOut(CountDownModel model, int subIndex, int event)
{
 
    if(model.state == TimerState.end)
    {
      if(subIndex > -1)
      {
        _subList[subIndex].cancel();
      _subList.removeAt(subIndex);
      _myStreamList.removeAt(subIndex);
      }
    }
   else if(model.remainingTime.inSeconds == model.initialValue)
   {
   
      model.state = TimerState.end;
      if(subIndex > -1)
      {
        _subList[subIndex].cancel();
      _subList.removeAt(subIndex);
      _myStreamList.removeAt(subIndex);
      }
   }
   return model;
}



  
}



