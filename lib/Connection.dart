import 'package:eo2_map_charger/qr_scaner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/src/provider.dart';

import 'ConstantFunction/custom_navigation.dart';
import 'Home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'VisibilityWidgets.dart';

class Connection extends StatefulWidget {
  const Connection({Key key}) : super(key: key);

  @override
  connection createState() => connection();
}

class connection extends State<Connection> {
  VisibilityWidgets visibilityWidgetsRead;
  VisibilityWidgets visibilityWidgetsWatch;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      visibilityWidgetsRead = context.read<VisibilityWidgets>();
      visibilityWidgetsRead.setsocket(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    visibilityWidgetsWatch = context.watch<VisibilityWidgets>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        actions: [
          InkWell(
            onTap: () {
              FocusScope.of(context).unfocus();
              CustomNavigation.push(
                  context: context, className: QRViewExample());
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10),
              child: Container(
                child: Icon(Icons.qr_code_scanner),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              TextFormField(
                  style: TextStyle(color: Colors.black),
                  onChanged: (value) async {
                      visibilityWidgetsWatch.setQr(value);
                      final pref = await SharedPreferences.getInstance();
                      pref.setString("qrtxt", visibilityWidgetsWatch.qrText);
                  },
                  initialValue:visibilityWidgetsWatch.qrText,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                      labelText: "Mac Address",
                      labelStyle: TextStyle(color: Colors.green),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)))),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                child: Center(
                  child: RaisedButton(
                    textColor: Colors.black,
                    color: Colors.white,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.navigate_next,
                              color: Colors.green,
                              size: 30,
                            ),
                            Text("Connect"),
                          ],
                        ),
                      ),
                    ),
                    onPressed: () {
                      CustomNavigation.push(
                          context: context, className: Home());
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
