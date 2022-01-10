import 'dart:async';

import 'package:eo2_map_charger/ConnectServer.dart';
import 'package:eo2_map_charger/Connection.dart';
import 'package:eo2_map_charger/ota.dart';
import 'package:eo2_map_charger/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import 'ConstantFunction/Constants.dart';
import 'VisibilityWidgets.dart';
import 'charging_summary.dart';
import 'contact_us.dart';
import 'dash_board.dart';

class Home extends StatefulWidget {
  Home();

  @override
  home_state createState() => home_state();
}

enum ConfirmAction { Cancel, Accept }

class home_state extends State<Home> {
  VisibilityWidgets visibilityWidgetsRead;
  VisibilityWidgets visibilityWidgetsWatch;

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
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: const Text('Charger'),
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
                        'Device Id: ${visibilityWidgetsWatch.device_id}',
                        style: TextStyle(color: Colors.white),
                      ),
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
              ],
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
        return DashBoard();
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
          title: Text('Do you want to Exit'),
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
                if(visibilityWidgetsWatch.socket!=null) {
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
