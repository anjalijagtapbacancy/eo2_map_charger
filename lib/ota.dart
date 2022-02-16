import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/src/provider.dart';

import 'VisibilityWidgets.dart';

class OTA extends StatefulWidget {
  OTA();

  @override
  ota_state createState() => ota_state();
}

class ota_state extends State<OTA> {
  VisibilityWidgets visibilityWidgetsRead;
  VisibilityWidgets visibilityWidgetsWatch;
  final GlobalKey<FormState> file_name_key = GlobalKey<FormState>();
  String fileName="EO2_Charger.bin",
      fileLink="http://bacancy-system-nptl.s3.ap-south-1.amazonaws.com/MAP/OTA/File/MAPChargerV1_0.bin";

  @override
  Future<void> initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      visibilityWidgetsRead = context.read<VisibilityWidgets>();
      visibilityWidgetsRead.setappbar_name("OTA");
      visibilityWidgetsRead.setfileName(fileName);
      visibilityWidgetsRead.setfileUrl(fileLink);
    });
  }

  @override
  Widget build(BuildContext context) {
    visibilityWidgetsWatch = context.watch<VisibilityWidgets>();
    if (mounted && visibilityWidgetsWatch.responseMsgId8 != null)
      visibilityWidgetsWatch.Network(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
          height: 400,
          child: Form(
              key: file_name_key,
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Text("Current Firmware Version: ${visibilityWidgetsWatch.firmwareVersion}"),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white60,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: TextFormField(
                          initialValue: fileName,
                            validator: (value) {
                             return value.isEmpty ? 'Value Should not be Empty' : null;
                            },
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
                          initialValue: fileLink,
                          style: TextStyle(color: Colors.black),
                          validator: (value) {
                           return value.isEmpty ? 'Value Should not be Empty' : null;
                          },
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      elevation: 5,
                      onPressed: () {
                        if (file_name_key.currentState.validate()) {
                          {file_name_key.currentState.save();
                            visibilityWidgetsWatch.SendRequest4(
                                4,
                                visibilityWidgetsWatch.fileUrl,
                                visibilityWidgetsWatch.fileName);

                          }
                        } else {
                          print('invalid');
                        }
                        // if (visibilityWidgetsWatch.fileName != null &&
                        //     visibilityWidgetsWatch.fileName != "" &&
                        //     visibilityWidgetsWatch.fileUrl != "" &&
                        //     visibilityWidgetsWatch.fileUrl != null) {
                        //
                        // }
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}
