import 'package:eo2_map_charger/ConstantFunction/Constants.dart';
import 'package:eo2_map_charger/qr_scaner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/src/provider.dart';

import 'ConstantFunction/custom_navigation.dart';
import 'ConstantFunction/size_constants.dart';
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
  final GlobalKey<FormState> qr_key = GlobalKey<FormState>();

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
      //   title: Text("Eo2 Charger",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
      //   // actions: [
      //   //   InkWell(
      //   //     onTap: () {
      //   //       FocusScope.of(context).unfocus();
      //   //       CustomNavigation.push(
      //   //           context: context, className: QRViewExample());
      //   //     },
      //   //     child: Padding(
      //   //       padding: const EdgeInsets.only(right: 10.0, left: 10),
      //   //       child: Container(
      //   //         child: Icon(Icons.qr_code_scanner),
      //   //       ),
      //   //     ),
      //   //   ),
      //   // ],
      // ),
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Text(
                      "Scan & Charge",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      CustomNavigation.push(
                          context: context, className: QRViewExample());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 0, left: 0, bottom: 20, top: 0),
                      child: Image.asset(
                        AssetConstants.scan_qr_icon,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                    child: Text(
                      "Click & Scan",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: ScreenUtil().setWidth(100),
                          height: ScreenUtil().setHeight(2),
                          color: Colors.grey,
                        ),
                        Text(
                          " OR ",
                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,),
                        ),
                        Container(
                          width: ScreenUtil().setWidth(100),
                          height: ScreenUtil().setHeight(2),
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                    child: Text(
                      "Please enter the station code as seen on the box.",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Form(
                    key: qr_key,
                    child: TextFormField(
                        validator: (value) {
                          return value.isEmpty
                              ? 'Station Code Should not be Empty'
                              : null;
                        },
                        style: TextStyle(color: Constants.black),
                        onChanged: (value) async {
                          visibilityWidgetsWatch.setQr(value);
                          final pref = await SharedPreferences.getInstance();
                          pref.setString(
                              "qrtxt", visibilityWidgetsWatch.qrText);
                        },
                        initialValue: visibilityWidgetsWatch.qrText,
                        cursorColor: Constants.blue,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderSide:const BorderSide(),),
                            fillColor: Colors.grey[200],
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)),
                            labelText: "Station Code",)),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Container(
                      height: 50,
                      child: Center(
                        child: MaterialButton(
                          textColor: Constants.black,
                          color: Constants.blue,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Text(
                                "Proceed",
                                style: TextStyle(color: Constants.white),
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (qr_key.currentState.validate()) {
                              qr_key.currentState.save();
                              CustomNavigation.push(
                                  context: context, className: Home());
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
      ),
    );
  }
}
