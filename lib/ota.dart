import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/src/provider.dart';

import 'ConstantFunction/Constants.dart';
import 'ConstantFunction/size_constants.dart';
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
    SizeConstants.setScreenAwareConstant(context);
    if (mounted && visibilityWidgetsWatch.responseMsgId8 != null)
      visibilityWidgetsWatch.Network(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
                key: file_name_key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: ScreenUtil().setHeight(10),),
                    Text("File Name",
                        style: TextStyle(color: Constants.black, fontSize: 15.sp,fontWeight: FontWeight.bold)),
                    SizedBox(height:ScreenUtil().setHeight(20)),
                    TextFormField(
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
                            cursorColor: Colors.green,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(borderSide:const BorderSide(),),
                                labelText: "File Name",
                                fillColor: Colors.grey[200],
                                labelStyle: TextStyle(color: Colors.grey),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)))),
                    SizedBox(height:ScreenUtil().setHeight(20)),
                    Text("File Link",
                        style: TextStyle(color: Constants.black, fontSize: 15.sp,fontWeight: FontWeight.bold)),
                    SizedBox(height:ScreenUtil().setHeight(20)),
                    TextFormField(
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
                        cursorColor: Colors.green,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderSide:const BorderSide(),),
                            labelText: "File Link",
                            fillColor: Colors.grey[200],
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)))),
                    SizedBox(height:ScreenUtil().setHeight(30)),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Container(
                        height: 50,
                        child: Center(
                          child: RaisedButton(
                            textColor: Colors.black,
                            color: Constants.green,
                            child: Center(
                              child:Text(
                                "Submit",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            onPressed: () {
                              if (file_name_key.currentState.validate()) {
                                {file_name_key.currentState.save();
                                visibilityWidgetsWatch.SendRequest4(
                                    4,
                                    visibilityWidgetsWatch.fileUrl,
                                    visibilityWidgetsWatch.fileName);
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
                    SizedBox(height: 20,),
                    Center(child: Text("Current Firmware Version: ${visibilityWidgetsWatch.firmwareVersion}",style: TextStyle(color: Colors.grey,fontSize: 15),)),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
