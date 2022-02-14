import 'dart:async';

import 'package:eo2_map_charger/ConnectServer.dart';
import 'package:eo2_map_charger/Connection.dart';
import 'package:eo2_map_charger/ota.dart';
import 'package:eo2_map_charger/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'ConstantFunction/Constants.dart';
import 'ConstantFunction/size_constants.dart';
import 'VisibilityWidgets.dart';
import 'charging_summary.dart';
import 'contact_us.dart';
import 'dash_board2.dart';

class Home extends StatefulWidget {
  Home();

  @override
  home_state createState() => home_state();
}

enum ConfirmAction { Cancel, Accept }

class home_state extends State<Home> {
  VisibilityWidgets visibilityWidgetsRead;
  VisibilityWidgets visibilityWidgetsWatch;
  final GlobalKey<FormState> form_key = GlobalKey<FormState>();
  String userName="";
  home_state();

  @override
  void initState() {
    // ConnectivityResult connectivityResult =
    // await (Connectivity().checkConnectivity());
    // if (connectivityResult == ConnectivityResult.wifi) {
    //   final gatewayinfo = await Gateway.info;
    //   final ServerIp = gatewayinfo.ip;
    //   print(ServerIp);
    //   print("object");
    // } else {
    //   print("Wifi is not on or Mobile data is on");
    //
    //   // SystemNavigator.pop();
    //   if (context1 != null)
    //     Navigator.of(context1).pushAndRemoveUntil(
    //         MaterialPageRoute(builder: (context1) => Connection()),
    //             (Route<dynamic> route) => false);
    //   AppSettings.openWIFISettings();
    // }
    ConnectServer(context);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      visibilityWidgetsRead = context.read<VisibilityWidgets>();
      visibilityWidgetsRead.setIndex(0);
      //visibilityWidgetsRead.ConnectServer(context);
    });
    // VisibilityWidgets().ConnectServer(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    visibilityWidgetsWatch = context.watch<VisibilityWidgets>();
    SizeConstants.setScreenAwareConstant(context);
    return WillPopScope(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.green),
              backgroundColor: Colors.white,
              title: const Text(
                'Charger',
                style: TextStyle(color: Colors.green),
              ),
            ),
            body: showBody(),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Row(
                      children: [
                        SizedBox(width: 5, height: 50),
                        Image.asset(AssetConstants.charging_gun_icon),
                        SizedBox(width: 5, height: 5),
                        Text(
                          "Hi  ${visibilityWidgetsWatch.user_name}!",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                            child: Icon(
                          Icons.change_circle,
                          color: Colors.white,
                        ),
                        onTap: (){
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) => WillPopScope(onWillPop: () => Future.value(false),child: Dialog(
                                  backgroundColor: Colors.white,
                                  child: Container(
                                    height: ScreenUtil().setHeight(300),
                                    width: 100,
                                    child: Center(
                                      child: Form(
                                        key: form_key,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            TextFormField(
                                                maxLength:10,
                                                initialValue: visibilityWidgetsWatch.user_name,
                                                style: TextStyle(color: Colors.black),
                                                validator: (value) {
                                                  return value.isEmpty ? 'Name Should not be Empty' : null;
                                                },
                                                onChanged: (value) {
                                                  if (value.isNotEmpty) {
                                                    userName=value;
                                                  }
                                                },
                                                cursorColor: Colors.green,
                                                decoration: InputDecoration(
                                                    labelText: "User Name",
                                                    labelStyle: TextStyle(color: Colors.green),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(color: Colors.green)))),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                MaterialButton(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(30.0),
                                                  ),
                                                  elevation: 5,
                                                  onPressed: () {
                                                      userName="";
                                                      Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                        color: Colors.green, fontWeight: FontWeight.bold),
                                                  ),
                                                  color: Colors.white,
                                                ),
                                                MaterialButton(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(30.0),
                                                  ),
                                                  elevation: 5,
                                                  onPressed: () {
                                                    if (form_key.currentState.validate()) {
                                                      Navigator.pop(context);
                                                      form_key.currentState.save();
                                                      visibilityWidgetsWatch.setuser_name(userName);
                                                    } else {
                                                      print('invalid');
                                                    }
                                                  },
                                                  child: Text(
                                                    "Ok",
                                                    style: TextStyle(
                                                        color: Colors.green, fontWeight: FontWeight.bold),
                                                  ),
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),)));
                        },),
                      ],
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                    ),
                  ),
                  ListTile(
                    leading: Image.asset(AssetConstants.dashboard),
                    title: const Text('Dashboard'),
                    onTap: () {
                      visibilityWidgetsWatch.setIndex(0);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Image.asset(AssetConstants.charging_summary),
                    title: const Text('Charging Summary'),
                    onTap: () {
                      visibilityWidgetsWatch.setIndex(1);
                      Navigator.pop(context);
                    },
                  ),
                  Visibility(
                    child: ListTile(
                      leading: Image.asset(AssetConstants.settings),
                      title: const Text('Settings'),
                      onTap: () {
                        visibilityWidgetsWatch.setIndex(2);
                        Navigator.pop(context);
                      },
                    ),
                    visible: visibilityWidgetsWatch.isSetting_OTA(),
                  ),
                  Visibility(
                    child: ListTile(
                      leading: Image.asset(AssetConstants.ota),
                      title: const Text('OTA'),
                      onTap: () {
                        visibilityWidgetsWatch.setIndex(3);
                        Navigator.pop(context);
                      },
                    ),
                    visible: visibilityWidgetsWatch.isSetting_OTA(),
                  ),
                  ListTile(
                    leading: Image.asset(AssetConstants.contact_us),
                    title: const Text('Contact Us'),
                    onTap: () {
                      visibilityWidgetsWatch.setIndex(4);
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                    child: Text(
                      "Firmware Version : ${visibilityWidgetsWatch.firmwareVersion}",
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          if (visibilityWidgetsWatch.index == 0) {
            final ConfirmAction action = await _asyncConfirmDialog(context);
          } else {
            visibilityWidgetsWatch.setIndex(0);
            return Future.value(false);
          }
        });
  }

  Widget showBody() {
    switch (visibilityWidgetsWatch.index) {
      case 0:
        return DashBoard2();
      case 1:
        return ChargingSummary();
      case 2:
        return Settings();
      case 3:
        return OTA();
      case 4:
        return ContactUs();
    }
  }

  Future<ConfirmAction> _asyncConfirmDialog(BuildContext context) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Container(
              width: MediaQuery.of(context).size.width,
              child: Text('Do you want to Disconnect?')),
          actions: <Widget>[
            FlatButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.Cancel);
              },
            ),
            FlatButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.Accept);
                visibilityWidgetsRead.responseMsgId8 = null;
                visibilityWidgetsWatch.setIsPaused(false);
                if (visibilityWidgetsWatch.socket != null) {
                  visibilityWidgetsWatch.socket.close();
                } else {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => Connection()),
                      (Route<dynamic> route) => false);
                }
              },
            )
          ],
        );
      },
    );
  }
}
