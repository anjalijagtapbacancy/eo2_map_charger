import 'dart:io';

import 'package:eo2_map_charger/card_setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/src/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'CommonWidgets.dart';
import 'ConstantFunction/Constants.dart';
import 'ConstantFunction/size_constants.dart';
import 'VisibilityWidgets.dart';
import 'charger_settings.dart';
import 'network_gsm_settings.dart';

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
  final GlobalKey<FormState> url_key = GlobalKey<FormState>();
  String url,pswd,ssid;

  settings_state();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      visibilityWidgetsRead = context.read<VisibilityWidgets>();
      visibilityWidgetsRead.setappbar_name("Settings");
      visibilityWidgetsRead.CommonRequests(19);
      init();
    });
    super.initState();
  }

  Future<void> init() async{
    visibilityWidgetsWatch.setSettingsLoader(true);
    await Future.delayed(Duration(milliseconds: 500));
    visibilityWidgetsWatch.CommonRequests(25);
    ssid = visibilityWidgetsWatch.wifi_ssid;
    pswd = visibilityWidgetsWatch.wifi_pswd;
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
      body:  SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: visibilityWidgetsWatch.SettingsLoader == false
          ? SingleChildScrollView(
        child: Padding(
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
                                //visibilityWidgetsWatch.setSettingsLoader(true);
                                //visibilityWidgetsWatch.CommonRequests(25);
                                visibilityWidgetsWatch.SendRequest18(18, 3);
                                showDialog(
                                    barrierDismissible: true,
                                    context: context,
                                    builder: (BuildContext context) => WillPopScope(
                                        onWillPop: () => Future.value(true),
                                        child: Url()));
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
                child: MaterialButton(
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
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              Container(
                height: ScreenUtil().setHeight(60),
                child: MaterialButton(
                  textColor: Constants.blue,
                  color: Constants.white,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Network / GSM Settings",
                          style: TextStyle(color: Constants.blue),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(10),
                        ),
                        Icon(Icons.navigate_next,color: Constants.blue,),
                      ],
                    ),
                  ),
                  onPressed: () {
                    visibilityWidgetsWatch.CommonRequests(25);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Network_gsm_settings()));
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Constants.blue),
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              Container(
                height: ScreenUtil().setHeight(60),
                child: MaterialButton(
                  textColor: Constants.blue,
                  color: Constants.white,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Charger Settings",
                          style: TextStyle(color: Constants.blue),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(10),
                        ),
                        Icon(Icons.navigate_next,color: Constants.blue,),
                      ],
                    ),
                  ),
                  onPressed: () {
                    visibilityWidgetsWatch.CommonRequests(27);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Charger_settings()));
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
      ) : CommonWidgets().CommonLoader(context),
    ),);
  }

  Dialog Url() {
    return Dialog(
      child: SizedBox(
        //height: ScreenUtil().setHeight(300),
        child: SingleChildScrollView(
          child: Form(
            key: url_key,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  Text("Share link and credentials for OCPP Mode",
                      style: TextStyle(
                          color: Constants.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp)),
                  SizedBox(height: ScreenUtil().setHeight(20)),
                  Text("WIFI SSID",
                      style:
                      TextStyle(color: Constants.black, fontSize: 15.sp)),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  TextFormField(
                      initialValue: visibilityWidgetsWatch.wifi_ssid,
                      style: TextStyle(color: Constants.blue),
                      validator: (value) {
                        return value.isEmpty || value.contains(' ')
                            ? 'Field Should not be Empty'
                            : null;
                      },
                      onChanged: (value) async {
                        ssid = value;
                      },
                      cursorColor: Constants.blue,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(),
                          ),
                          labelText: "Enter WIFI SSID",
                          fillColor: Colors.grey[200],
                          labelStyle: TextStyle(color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)))),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  Text("WIFI Password",
                      style:
                      TextStyle(color: Constants.black, fontSize: 15.sp)),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  TextFormField(
                      initialValue: visibilityWidgetsWatch.wifi_pswd,
                      style: TextStyle(color: Constants.blue),
                      validator: (value) {
                        return value.isEmpty || value.contains(' ')
                            ? 'Field Should not be Empty'
                            : null;
                      },
                      onChanged: (value) async {
                        pswd = value;
                      },
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(),
                          ),
                          labelText: "Enter WIFI Password",
                          fillColor: Colors.grey[200],
                          labelStyle: TextStyle(color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)))),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  Text("Link",
                      style:
                      TextStyle(color: Constants.black, fontSize: 15.sp)),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  TextFormField(
                      style: TextStyle(color: Constants.blue),
                      validator: (value) {
                        return value.isEmpty || value.contains(' ')
                            ? 'Field Should not be Empty or not Contains Space'
                            : null;
                      },
                      onChanged: (value) async {
                        url = value;
                      },
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(),
                          ),
                          labelText: "Enter Url",
                          fillColor: Colors.grey[200],
                          labelStyle: TextStyle(color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)))),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Container(
                        height: ScreenUtil().setHeight(50),
                        width: ScreenUtil().setWidth(150),
                        child: Center(
                          child: MaterialButton(
                            textColor: Colors.black,
                            color: Constants.blue,
                            child: Center(
                              child: Text(
                                "Send",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            onPressed: () async {
                              if (url_key.currentState.validate()) {
                                url_key.currentState.save();
                                visibilityWidgetsWatch.SendRequest28(28, url);
                                await Future.delayed(Duration(milliseconds: 500));
                                visibilityWidgetsWatch.SendRequest24(24,ssid,pswd,visibilityWidgetsWatch.interface,
                                    "2","0",visibilityWidgetsWatch.apn_name,visibilityWidgetsWatch.apn_pswd,"0","1");
                                Navigator.pop(context);
                              }
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
