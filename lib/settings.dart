import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/src/provider.dart';

import 'VisibilityWidgets.dart';

class Settings extends StatefulWidget {
  Settings();

  @override
  settings_state createState() => settings_state();
}

class settings_state extends State<Settings> {
  bool isAlert = false;
  String supplyValue;
  VisibilityWidgets visibilityWidgetsRead;
  VisibilityWidgets visibilityWidgetsWatch;

  settings_state();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      visibilityWidgetsRead = context.read<VisibilityWidgets>();
      visibilityWidgetsRead.CommonRequests(19);
    });
    super.initState();
  }

  void toggleSwitch(bool value) {
    if (isAlert == false) {
      setState(() {
        isAlert = true;
      });
    } else {
      setState(() {
        isAlert = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    visibilityWidgetsWatch = context.watch<VisibilityWidgets>();
    if(mounted && visibilityWidgetsWatch.responseMsgId8 != null)
      visibilityWidgetsWatch.Network(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Alert"),
                  Switch(
                    onChanged: toggleSwitch,
                    value: isAlert,
                    activeColor: Colors.green,
                    activeTrackColor: Colors.grey,
                    inactiveThumbColor: Colors.black,
                    inactiveTrackColor: Colors.grey,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Mode"),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButton<String>(
                        value: visibilityWidgetsWatch.modeValue,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 42,
                        underline: SizedBox(),
                        onChanged: (String newValue) {
                          setState(() {
                            visibilityWidgetsWatch.setmodeValue(newValue);
                            if (visibilityWidgetsWatch.modeValue ==
                                "Normal Mode") {
                              visibilityWidgetsWatch.SendRequest18(18, 0);
                              // GlobalVariables.modeValue = mode_value;
                            } else if (visibilityWidgetsWatch.modeValue ==
                                "Plug and Play Mode") {
                              visibilityWidgetsWatch.SendRequest18(18, 1);
                              //GlobalVariables.modeValue = mode_value;
                            } else if (visibilityWidgetsWatch.modeValue ==
                                "RFID Mode") {
                              visibilityWidgetsWatch.SendRequest18(18, 2);
                              // GlobalVariables.modeValue = mode_value;
                            } else if (visibilityWidgetsWatch.modeValue ==
                                "OCPP Mode") {
                              visibilityWidgetsWatch.SendRequest18(18, 3);
                              // GlobalVariables.modeValue = mode_value;
                            }
                            print(visibilityWidgetsWatch.modeValue);
                            if (visibilityWidgetsWatch.modeValue ==
                                "Normal Mode") {
                              visibilityWidgetsWatch.setAutoMode(0);
                            } else if (visibilityWidgetsWatch.modeValue ==
                                "Plug and Play Mode") {
                              visibilityWidgetsWatch.setAutoMode(1);
                            } else if (visibilityWidgetsWatch.modeValue ==
                                "RFID Mode") {
                              visibilityWidgetsWatch.setAutoMode(2);
                            } else if (visibilityWidgetsWatch.modeValue ==
                                "OCPP Mode") {
                              visibilityWidgetsWatch.setAutoMode(3);
                            }
                          });
                        },
                        items: <String>[
                          'Normal Mode',
                          'Plug and Play Mode',
                          'RFID Mode',
                          'OCPP Mode'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList()),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Home Electricity Supply"),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),

                    // dropdown below..
                    child: DropdownButton<String>(
                        value: supplyValue,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 42,
                        underline: SizedBox(),
                        onChanged: (String newValue) {
                          setState(() {
                            supplyValue = newValue;
                          });
                        },
                        items: <String>['One', 'Two', 'Three', 'Four']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
