
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management_riverpod/countdown/feature/countdown/components/linear_indicator.dart';
import 'package:state_management_riverpod/countdown/model/countdown_model.dart';
import 'package:state_management_riverpod/countdown/product/constant/color_constant.dart';
import 'package:state_management_riverpod/countdown/product/constant/pagepadding_constant.dart';
import 'package:state_management_riverpod/countdown/product/enum/icon_enum.dart';
import 'package:state_management_riverpod/countdown/product/enum/timer_state_enum.dart';
import 'package:state_management_riverpod/countdown/provider/all_provider.dart';
import 'package:uuid/uuid.dart';

TextEditingController _controllerTextField = TextEditingController();

class CountdownView extends ConsumerStatefulWidget {
  const CountdownView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CountdownViewState();
}

class _CountdownViewState extends ConsumerState<CountdownView> {
  var _currentFilter = TimerState.all;

  @override
  Widget build(BuildContext context) {
    _currentFilter = ref.watch(timerFilter);
    return Scaffold(
      appBar: _appbar(),
      body: _body(),
    );
  }
  AppBar _appbar() => AppBar(
    title: Text(ref.watch(countdownPageTitle)),
    actions: [
      IconButton(onPressed: (){
        ref.read(countdownNotifierProvider.notifier).clearAll();
      }, icon: Icon(IconEnum.deleteAll.icon))
    ],
  );


  Column _body() {
    List<CountDownModel> _liste =ref.watch(filteredCountdownList);
    return Column(
      children: [
        _newSandWatch(),
        topMenu(),
        Expanded(child: 
        ListView.builder(
          itemCount:_liste.length,
          itemBuilder: (context , index)
          {
            return listItem(_liste[index]);
          })
        )
      ],
    );
  }

  _newSandWatch()
  {
    return Padding(
      padding: const PagePadding.alllow(), //   product/constant/pagepadding_constant
      child: Card(
        elevation: 20.0,
        color: ConsColor.cardLight,
        child: Padding(
          padding: const PagePadding.alllow(),
          child: Row(
            children: [
              Expanded(child: _cardLeft()),
              Expanded(
                flex: 3,
                child: _cardMid()),
              Expanded(child: _cardRight())
            ],
          ),
        )
        ),
    
    );
  }
  Icon _cardLeft() => Icon(IconEnum.hourglassEmpty.icon, color: ConsColor.armyGreen,);
  Column _cardMid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
              Text("New Countdown",style: Theme.of(context).textTheme.titleSmall!.copyWith(color: ConsColor.armyGreen),),
               TextField(
                controller: _controllerTextField,
                keyboardType: TextInputType.number,
                
                decoration: InputDecoration(
                  hintText: "initial Value [ seconds  ]",
                  hintStyle: Theme.of(context).textTheme.labelMedium!.copyWith(color: ConsColor.armyGreen),
                  fillColor: ConsColor.cardMidLight,
                  filled: true,
                  focusColor: ConsColor.armyGreen,
                ),
                           ),
            ],);
  }

  Widget _cardRight() => InkWell(
    onTap: ()
    {
          ref.read(countdownNotifierProvider.notifier).add(CountDownModel(id: const Uuid().v4(), initialValue: int.tryParse(_controllerTextField.text) ?? 10, state: TimerState.continues, remainingTime: Duration(seconds: 0)));
          _controllerTextField.clear();
    },

    child: CircleAvatar(
      backgroundColor: ConsColor.cardMidLight,
      child: Icon(IconEnum.add.icon, color: ConsColor.armyGreen,),),
  );

  topMenu()
{
 return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Card(
      elevation: 10.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [

          Container(
            height: 40.0,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0),
            color: Colors.white54
            ),
            child: Row(children: [
              _topMenuItem(onPressed: (){
                ref.read(timerFilter.notifier).state = TimerState.all;
              }, icon: IconEnum.all.icon,isActive: _currentFilter == TimerState.all ),
              _dist(),
              _topMenuItem(onPressed: (){
                                ref.read(timerFilter.notifier).state = TimerState.continues;


              }, icon: IconEnum.play.icon, isActive: _currentFilter == TimerState.continues),
              _dist(),
              _topMenuItem(onPressed: (){
                               ref.read(timerFilter.notifier).state = TimerState.end;


              }, icon: IconEnum.stop.icon, isActive: _currentFilter == TimerState.end),
    
            ],),
          ),
        ],
      ),
    ),
  );
}

Padding _dist() {
  return Padding(
        padding: const EdgeInsets.symmetric(vertical:5.0),
        child: Container(height: double.infinity, width: .8,color:  Colors.black38,),
      );
}
_topMenuItem({required void Function()? onPressed,required IconData icon, String ?labelText, required bool isActive})
{
  return Expanded(
    child: InkWell(
      onTap: onPressed,
      child: Icon(icon,color: isActive ? ConsColor.neonBlue : Colors.black54,),
    ),
  );
}


listItem(CountDownModel item)
{
  return Padding(
    padding: const PagePadding.alllow(),
    child: Card(
      elevation: 10.0,
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 30,
        height: 80,
        child: Stack(
          children: [
             Positioned.fill(
               child: SizedBox(
                width: MediaQuery.of(context).size.width,
                
                child: LinearIndicatorConsumer(item: item )),
             ),
             Positioned(
              top: 0,
              bottom: 0,
              left: 10,
              
              child: Text("${item.initialValue} / ${item.initialValue - item.remainingTime.inSeconds}",style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: ConsColor.armyGreen),)),
           item.state == TimerState.end ? Container():
             Center(child: InkWell(
              onTap: (){
                item.state = TimerState.end;
                ref.read(countdownNotifierProvider.notifier).add(item);
              },
               child: CircleAvatar(
                radius: 30,
                child: Icon(IconEnum.stop.icon)),
             ))
            
          ],
        ),
      ),
    ),
  );
}


}