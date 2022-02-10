import 'package:eo2_map_charger/qr_scaner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/src/provider.dart';

import 'Connection.dart';
import 'ConstantFunction/custom_navigation.dart';
import 'ConstantFunction/size_constants.dart';
import 'Home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'VisibilityWidgets.dart';

class UserName extends StatefulWidget {
  const UserName({Key key}) : super(key: key);

  @override
  user_name createState() => user_name();
}

class user_name extends State<UserName> {
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
    SizeConstants.setScreenAwareConstant(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Eo2 Charger",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: SingleChildScrollView(
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
                        visibilityWidgetsWatch.setuser_name(value);
                        final pref = await SharedPreferences.getInstance();
                        pref.setString("user_name", visibilityWidgetsWatch.user_name);
                      },
                      initialValue:visibilityWidgetsWatch.user_name,
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                          labelText: "Enter Your Name",
                          labelStyle: TextStyle(color: Colors.green),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green)))),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Container(
                      height: 50,
                      child: Center(
                        child: RaisedButton(
                          textColor: Colors.black,
                          color: Colors.green,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  Text("Save",style: TextStyle(color: Colors.white),),
                                ],
                              ),
                            ),
                          ),
                          onPressed: () {
                            if(visibilityWidgetsRead.qrText == "" || visibilityWidgetsRead.qrText == " " || visibilityWidgetsRead.qrText == null){
                              CustomNavigation.pushReplacement(
                                  context: context, className: Connection());
                            }
                            else{
                              CustomNavigation.pushReplacement(
                                  context: context, className: Home());
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}