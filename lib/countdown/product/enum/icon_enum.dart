import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum IconEnum
{
  counter, todo_app,countdown,
  hourglassEmpty, hourglassStart, hourglassHalf ,hourglassEnd,
  add,
  all,play,pause,stop,
  deleteAll 
}

extension IconEnumExt on IconEnum
{


  IconData get icon{
    switch(this)
    {      
      case IconEnum.hourglassEmpty:
          return FontAwesomeIcons.hourglass;
      case IconEnum.hourglassStart:
          return FontAwesomeIcons.hourglassStart;
      case IconEnum.hourglassHalf:
          return FontAwesomeIcons.hourglassHalf;
      case IconEnum.hourglassEnd:
          return FontAwesomeIcons.hourglassEnd;
      case IconEnum.add:
          return Icons.add;
      case IconEnum.all:
          return FontAwesomeIcons.list;    
      case IconEnum.play:
          return FontAwesomeIcons.play;
      case IconEnum.pause:
          return FontAwesomeIcons.pause;
      case IconEnum.stop:
          return FontAwesomeIcons.stop;
      case IconEnum.deleteAll:
          return Icons.delete_sweep;      
      case IconEnum.counter:
          return FontAwesomeIcons.arrowUp19;
      case IconEnum.todo_app:
          return FontAwesomeIcons.clipboardList;
      case IconEnum.countdown:
          return Icons.av_timer;

    }
  }
}