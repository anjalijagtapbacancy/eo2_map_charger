import 'package:eo2_map_charger/CommonWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/src/provider.dart';

import 'ConstantFunction/Constants.dart';
import 'VisibilityWidgets.dart';

class AddCard extends StatefulWidget {
  AddCard();

  @override
  AddCardState createState() => AddCardState();
}

class AddCardState extends State<AddCard> {
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
  Widget build(BuildContext) {
    visibilityWidgetsWatch = context.watch<VisibilityWidgets>();
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Add Cards'),),
          body: visibilityWidgetsWatch.rfidShowLoader == false
              ? Column(
            children: [
              Text('Please tap your card to the sensing area of the target charger.'),
              SizedBox(height: 20,),
              Text('Please add one card at a time and finish this process in 1 min.'),
              SizedBox(height: 20,),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  onPressed: () {
                    visibilityWidgetsWatch.SendRequest32(32,1);
                    visibilityWidgetsWatch.setRfidShowLoader(true);
                  },
                  child: Text(
                    "Start",
                    style: TextStyle(
                      color: Constants.blue,
                    ),
                  ),
                  color: Constants.white,
                  padding: EdgeInsets.all(5),
                ),)
            ],
          )
              : CommonWidgets().CommonLoader(context),
        ));
  }

}