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
        title: Text("Eo2 Charger",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        // actions: [
        //   InkWell(
        //     onTap: () {
        //       FocusScope.of(context).unfocus();
        //       CustomNavigation.push(
        //           context: context, className: QRViewExample());
        //     },
        //     child: Padding(
        //       padding: const EdgeInsets.only(right: 10.0, left: 10),
        //       child: Container(
        //         child: Icon(Icons.qr_code_scanner),
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: Center(
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
                  child: Text("Scan & Charge",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                ),
                InkWell(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    CustomNavigation.push(
                        context: context, className: QRViewExample());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 0, left: 0,bottom: 30,top: 0),
                      child: Icon(Icons.qr_code_scanner,color: Colors.green,size: 150.0,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,5, 0, 10),
                  child: Text("Click & Scan",style: TextStyle(color: Colors.black),),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 100,
                        height: 4,
                        color: Colors.black,
                      ),
                      Text(" OR ",style:TextStyle(fontWeight: FontWeight.bold),),
                      Container(
                        width: 100,
                        height: 4,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Text("Please enter the station code as seen on the box.",style: TextStyle(color: Colors.black,fontSize: 10,),maxLines: 2,),
                ),
                TextFormField(
                    style: TextStyle(color: Colors.black),
                    onChanged: (value) async {
                        visibilityWidgetsWatch.setQr(value);
                        final pref = await SharedPreferences.getInstance();
                        pref.setString("qrtxt", visibilityWidgetsWatch.qrText);
                    },
                    initialValue:visibilityWidgetsWatch.qrText,
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                        labelText: "Station Code",
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
                                Text("Proceed",style: TextStyle(color: Colors.white),),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
