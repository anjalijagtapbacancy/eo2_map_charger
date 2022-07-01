import 'package:eo2_map_charger/card_setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/src/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'ConstantFunction/Constants.dart';
import 'ConstantFunction/size_constants.dart';
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
      visibilityWidgetsRead.setappbar_name("Settings");
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
    SizeConstants.setScreenAwareConstant(context);
    visibilityWidgetsWatch = context.watch<VisibilityWidgets>();
    if(mounted && visibilityWidgetsWatch.responseMsgId8 != null)
      visibilityWidgetsWatch.Network(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    activeColor: Constants.blue,
                    activeTrackColor: Colors.grey,
                    inactiveThumbColor: Colors.black,
                    inactiveTrackColor: Colors.grey,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            } else if (visibilityWidgetsWatch.modeValue ==
                                "Plug and Play Mode \nWith Push Button") {
                              visibilityWidgetsWatch.SendRequest18(18, 4);
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
                            } else if (visibilityWidgetsWatch.modeValue ==
                                "Plug and Play Mode \nWith Push Button") {
                              visibilityWidgetsWatch.setAutoMode(4);
                            }
                          });
                        },
                        items: <String>[
                          'Normal Mode',
                          'Plug and Play Mode',
                          'RFID Mode',
                          'OCPP Mode',
                          'Plug and Play Mode \nWith Push Button'
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
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            Container(
              height: ScreenUtil().setHeight(60),
              child: RaisedButton(
                textColor: Constants.blue,
                color: Constants.white,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "RFID Card",
                        style: TextStyle(color: Constants.blue),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  visibilityWidgetsWatch.CommonRequests(33);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CardSettings()));
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: Constants.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
