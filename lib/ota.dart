import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/src/provider.dart';

import 'ConstantFunction/Constants.dart';
import 'VisibilityWidgets.dart';

class OTA extends StatefulWidget {
  OTA();

  @override
  ota_state createState() => ota_state();
}

class ota_state extends State<OTA> {
  VisibilityWidgets visibilityWidgetsRead;
  VisibilityWidgets visibilityWidgetsWatch;

  @override
  Future<void> initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      visibilityWidgetsRead = context.read<VisibilityWidgets>();
    });
  }

  @override
  Widget build(BuildContext context) {
    visibilityWidgetsWatch = context.watch<VisibilityWidgets>();
    if(mounted && visibilityWidgetsWatch.responseMsgId8 != null)
      visibilityWidgetsWatch.Network(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(242, 255, 229, 1),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          height: 400,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.white,
            elevation: 10,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white60,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            visibilityWidgetsWatch.setfileName(value);
                          }
                        },
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                            labelText: "File Name",
                            labelStyle: TextStyle(color: Colors.green),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green)))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            visibilityWidgetsWatch.setfileUrl(value);
                          }
                        },
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                            labelText: "File Link",
                            labelStyle: TextStyle(color: Colors.green),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green)))),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    if (visibilityWidgetsWatch.fileName != null &&
                        visibilityWidgetsWatch.fileName != "" &&
                        visibilityWidgetsWatch.fileUrl != "" &&
                        visibilityWidgetsWatch.fileUrl != null) {
                      visibilityWidgetsWatch.SendRequest4(
                          4,
                          visibilityWidgetsWatch.fileUrl,
                          visibilityWidgetsWatch.fileName);
                    }
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                  color: Colors.grey[200],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}