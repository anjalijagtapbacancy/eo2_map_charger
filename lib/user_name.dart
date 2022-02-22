import 'package:eo2_map_charger/ConstantFunction/Constants.dart';
import 'package:eo2_map_charger/qr_scaner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  final GlobalKey<FormState> user_key = GlobalKey<FormState>();

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
      // appBar: AppBar(
      //   backgroundColor: Colors.green,
      //   title: Text("Eo2 Charger",style: TextStyle(color: Constants.white,fontWeight: FontWeight.bold),),
      // ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height:ScreenUtil().setHeight(50)),
                Text("Your Name",
                    style: TextStyle(color: Constants.black, fontSize: 20.sp)),
                SizedBox(height:ScreenUtil().setHeight(20)),
                Form(
                  key: user_key,
                  child:TextFormField(
                        style: TextStyle(color: Colors.black),
                        validator: (value) {
                          return value.isEmpty ? 'Name Should not be Empty' : null;
                        },
                        onChanged: (value) async {
                          visibilityWidgetsWatch.setuser_name(value);
                          final pref = await SharedPreferences.getInstance();
                          pref.setString(
                              "user_name", visibilityWidgetsWatch.user_name);
                        },
                        initialValue: visibilityWidgetsWatch.user_name,
                        cursorColor: Constants.blue,
                        maxLength: 10,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderSide:const BorderSide(),),
                            labelText: "Enter Your Name",
                            fillColor: Colors.grey[200],
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)))),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Container(
                    height: 50,
                    child: Center(
                      child: RaisedButton(
                        textColor: Colors.black,
                        color: Constants.blue,
                        child: Center(
                          child:Text(
                            "Save & Continue",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        onPressed: () {
                          if (user_key.currentState.validate()) {
                            user_key.currentState.save();
                            if (visibilityWidgetsRead.qrText == "" ||
                                visibilityWidgetsRead.qrText == " " ||
                                visibilityWidgetsRead.qrText == null) {
                              CustomNavigation.pushReplacement(
                                  context: context, className: Connection());
                            } else {
                              CustomNavigation.pushReplacement(
                                  context: context, className: Home());
                            }
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
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
    );
  }
}
