import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/src/provider.dart';

import 'ConstantFunction/Constants.dart';
import 'VisibilityWidgets.dart';
import 'addCards.dart';

class CardSettings extends StatefulWidget {
  CardSettings();

  @override
  CardSettingsState createState() => CardSettingsState();
}

class CardSettingsState extends State<CardSettings> {
  VisibilityWidgets visibilityWidgetsRead;
  VisibilityWidgets visibilityWidgetsWatch;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      visibilityWidgetsRead = context.read<VisibilityWidgets>();
    });
      // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    visibilityWidgetsWatch = context.watch<VisibilityWidgets>();
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('RFID Cards'),
            actions: [
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0,0,5,0),
                  child: Icon(Icons.add_outlined,color: Colors.white,),
                ),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddCard()));
                },
              )
            ],),
          body: visibilityWidgetsWatch.rfidList.length>0
          ? ListView.builder(
          physics:
          const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: visibilityWidgetsWatch.rfidList.length,
          itemBuilder:
              (context, index) {
            return showListOfrfidsInfo(index);
          })
          : Center(
            child: Text('No Card'),
          ),
    ));
  }

  Widget showListOfrfidsInfo(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Constants.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            Text('Card ${index+1}',style: TextStyle(color: Colors.grey,fontSize: 17),),
            Text('${visibilityWidgetsWatch.rfidList[index].idTag}',style: TextStyle(color: Colors.green,fontSize: 18),),
          ],
        ),
      ),
    );
  }

}