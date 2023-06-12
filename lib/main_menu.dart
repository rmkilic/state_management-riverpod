import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:state_management_riverpod/countdown/feature/countdown/countdown_view.dart';
import 'package:state_management_riverpod/countdown/product/constant/color_constant.dart';
import 'package:state_management_riverpod/countdown/product/constant/pagepadding_constant.dart';
import 'package:state_management_riverpod/countdown/product/enum/icon_enum.dart';
import 'package:state_management_riverpod/counter/feature/counter_basic.dart';
import 'package:state_management_riverpod/proje/todo_app.dart';

class MainMenuView extends StatefulWidget {
  const MainMenuView({super.key});

  @override
  State<MainMenuView> createState() => _MainMenuViewState();
}

class _MainMenuViewState extends State<MainMenuView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: _body(),
    );
  }

  Widget _body() {
    return Column(
      children: [
        _button(title: "Counter", icon: IconEnum.counter.icon, onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const MyHomePage()))),
        _button(title: "Todo App", icon: IconEnum.todo_app.icon, onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=> TodoApp()))),
        _button(title: "Count Down", icon: IconEnum.countdown.icon, onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const CountdownView()))),
      ],
    );
  }
  _button({required String title, required IconData icon,required VoidCallback onTap})
  {
     return Expanded(
       child: Padding(padding: const PagePadding.alllow(),
       child: ElevatedButton(onPressed: (){
        onTap();
       }, child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: [
            Icon(icon, color: ConsColor.neonCyan,),
           Text(title, style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ConsColor.neonCyan),),
         ],
       ),
       style: ElevatedButton.styleFrom(
        backgroundColor: ConsColor.nightSkyBlue
       ),
       
       ),
       ),
     );
  }

  AppBar _appbar() => AppBar(
    title: const Text("Project Contents"),
  );
}