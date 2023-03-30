import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/src/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'ConstantFunction/Constants.dart';
import 'ConstantFunction/size_constants.dart';
import 'VisibilityWidgets.dart';

class Network_gsm_settings extends StatefulWidget {
  Network_gsm_settings();

  @override
  network_gsm_settings_status createState() => network_gsm_settings_status();
}

class network_gsm_settings_status extends State<Network_gsm_settings> {
  network_gsm_settings_status();

  final GlobalKey<FormState> network_key = GlobalKey<FormState>();
  VisibilityWidgets visibilityWidgetsRead;
  VisibilityWidgets visibilityWidgetsWatch;
  String ssid, pswd, interface, apnpswd = "", apnName = "",selectedInterface = "AP";

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      visibilityWidgetsRead = context.read<VisibilityWidgets>();
      ssid = visibilityWidgetsRead.wifi_ssid;
      pswd = visibilityWidgetsRead.wifi_pswd;
      interface = visibilityWidgetsRead.interface;
      apnpswd = visibilityWidgetsRead.apn_pswd;
      apnName = visibilityWidgetsRead.apn_name;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    visibilityWidgetsWatch = context.watch<VisibilityWidgets>();
    SizeConstants.setScreenAwareConstant(context);
    if (mounted && visibilityWidgetsWatch.responseMsgId8 != null)
      visibilityWidgetsWatch.Network(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.white,
        iconTheme: IconThemeData(color: Constants.blue),
        title: Text(
          "Network / GSM Settings",
          style: TextStyle(color: Constants.blue, fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: Form(
              key: network_key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  Text("Network Settings",
                      style: TextStyle(
                          color: Constants.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp)),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  // Text("WiFi SSID",
                  //     style:
                  //         TextStyle(color: Constants.black, fontSize: 15.sp)),
                  // SizedBox(height: ScreenUtil().setHeight(5)),
                  TextFormField(
                      initialValue: visibilityWidgetsWatch.wifi_ssid,
                      style: TextStyle(color: Colors.black),
                      validator: (value) {
                        return value.isEmpty
                            ? 'Field Should not be Empty'
                            : null;
                      },
                      onChanged: (value) async {
                        ssid = value;
                      },
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(),
                          ),
                          labelText: "Enter WiFi SSID",
                          fillColor: Colors.grey[200],
                          labelStyle: TextStyle(color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)))),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  // Text("WiFi Password",
                  //     style:
                  //         TextStyle(color: Constants.black, fontSize: 15.sp)),
                  // SizedBox(height: ScreenUtil().setHeight(5)),
                  TextFormField(
                      initialValue: visibilityWidgetsWatch.wifi_pswd,
                      style: TextStyle(color: Colors.black),
                      validator: (value) {
                        return value.isEmpty
                            ? 'Field Should not be Empty'
                            : null;
                      },
                      onChanged: (value) async {
                        pswd = value;
                      },
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(),
                          ),
                          labelText: "Enter WiFi Password",
                          fillColor: Colors.grey[200],
                          labelStyle: TextStyle(color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)))),
                  /*SizedBox(height: ScreenUtil().setHeight(10)),
                  Text("Security",
                      style:
                      TextStyle(color: Constants.black, fontSize: 15.sp)),
                  SizedBox(height: ScreenUtil().setHeight(5)),
                  DropdownButtonFormField(
                      //value: 'WPA',
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(),
                          ),
                          fillColor: Colors.grey[200],
                          labelStyle: TextStyle(color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey))),
                      hint: const Text(
                        'Select WiFi Security',
                      ),
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 42,
                      onChanged: (newvalue) =>
                          setState(() => security = newvalue),
                      validator: (value) => value == null ? 'Field Should not be Empty' : null,
                      items:
                      ['WPA', 'WPA2', 'WEP',].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),*/
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  Text("GSM Settings",
                      style: TextStyle(
                          color: Constants.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp)),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  // Text("APN Name",
                  //     style:
                  //         TextStyle(color: Constants.black, fontSize: 15.sp)),
                  // SizedBox(height: ScreenUtil().setHeight(5)),
                  TextFormField(
                      initialValue: visibilityWidgetsWatch.apn_name,
                      style: TextStyle(color: Colors.black),
                      /*validator: (value) {
                        return value.isEmpty
                            ? 'Field Should not be Empty'
                            : null;
                      },*/
                      onChanged: (value) async {
                        apnName = value;
                      },
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(),
                          ),
                          labelText: "Enter APN Name",
                          fillColor: Colors.grey[200],
                          labelStyle: TextStyle(color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)))),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  // Text("APN Password",
                  //     style:
                  //         TextStyle(color: Constants.black, fontSize: 15.sp)),
                  // SizedBox(height: ScreenUtil().setHeight(5)),
                  TextFormField(
                      initialValue: visibilityWidgetsWatch.apn_pswd,
                      style: TextStyle(color: Colors.black),
                      /*validator: (value) {
                        return value.isEmpty
                            ? 'Field Should not be Empty'
                            : null;
                      },*/
                      onChanged: (value) async {
                        apnpswd = value;
                      },
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(),
                          ),
                          labelText: "Enter APN Password",
                          fillColor: Colors.grey[200],
                          labelStyle: TextStyle(color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)))),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  Text("Interface",
                      style: TextStyle(
                          color: Constants.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp)),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  // Text("Interface",
                  //     style:
                  //         TextStyle(color: Constants.black, fontSize: 15.sp)),
                  // SizedBox(height: ScreenUtil().setHeight(5)),
                  DropdownButtonFormField(
                    value: visibilityWidgetsWatch.interface,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(),
                        ),
                        fillColor: Colors.grey[200],
                        labelStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey))),
                    hint: const Text(
                      'Select Interface',
                    ),
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 42,
                    onChanged: (newvalue) =>
                        setState(() => interface = newvalue),
                    validator: (value) =>
                        value == null ? 'Field Should not be Empty' : null,
                    items: ['WIFI', 'GSM']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(10)),
                  interface == "WIFI" ? Row(
                    children: [
                      Radio(
                        activeColor: Constants.blue,
                        value: "AP",
                        groupValue: selectedInterface,
                        onChanged: (val){
                          selectedInterface = val;
                        },
                      ),
                      Text("AP Mode"),
                      Radio(
                        activeColor: Constants.blue,
                        value: "STA",
                        groupValue: selectedInterface,
                        onChanged: (val){
                          selectedInterface = val;
                        },
                      ),
                      Text("STA Mode"),
                    ],
                  ) : Container(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Container(
                      height: 50,
                      child: Center(
                        child: MaterialButton(
                          textColor: Colors.black,
                          color: Constants.blue,
                          child: Center(
                            child: Text(
                              "Submit Network/GSM Setting",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          onPressed: () {
                            if (network_key.currentState.validate()) {
                              network_key.currentState.save();
                              visibilityWidgetsWatch.SendRequest24(
                                  24,
                                  ssid,
                                  pswd,
                                  interface,
                                  selectedInterface == "AP" ? "1" : "2",
                                  "0",
                                  apnName,
                                  apnpswd,
                                  "0",
                                  "0");
                              Navigator.pop(context);
                            }
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(5)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
