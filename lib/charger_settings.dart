import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/src/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'ConstantFunction/Constants.dart';
import 'ConstantFunction/size_constants.dart';
import 'VisibilityWidgets.dart';

class Charger_settings extends StatefulWidget {
  Charger_settings();

  @override
  charger_settings_status createState() => charger_settings_status();
}

class charger_settings_status extends State<Charger_settings> {
  charger_settings_status();

  final GlobalKey<FormState> charger_key = GlobalKey<FormState>();
  VisibilityWidgets visibilityWidgetsRead;
  VisibilityWidgets visibilityWidgetsWatch;
  String chargername, chargertype, chargercapacity, connectiontype;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      visibilityWidgetsRead = context.read<VisibilityWidgets>();
      chargername = visibilityWidgetsRead.chargername;
      chargertype = visibilityWidgetsRead.chargertype;
      chargercapacity = visibilityWidgetsRead.chargercapacity;
      connectiontype = visibilityWidgetsRead.connectiontype;
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
          "Charger Settings",
          style: TextStyle(color: Constants.blue, fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Form(
                key: charger_key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: ScreenUtil().setHeight(10)),
                    Text("Charger Setting",
                        style: TextStyle(
                            color: Constants.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp)),
                    SizedBox(height: ScreenUtil().setHeight(10)),
                    // Text("Charger Name",
                    //     style:
                    //         TextStyle(color: Constants.black, fontSize: 15.sp)),
                    // SizedBox(height: ScreenUtil().setHeight(5)),
                    TextFormField(
                        initialValue: visibilityWidgetsWatch.chargername,
                        style: TextStyle(color: Colors.black),
                        validator: (value) {
                          return value.isEmpty || value.contains(' ')
                              ? 'Name Should not be Empty or not Contains Space'
                              : null;
                        },
                        onChanged: (value) async {
                          chargername = value;
                        },
                        maxLength: 10,
                        cursorColor: Colors.green,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(),
                            ),
                            labelText: "Enter Charger Name",
                            fillColor: Colors.grey[200],
                            labelStyle: TextStyle(color: Colors.grey),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)))),
                    SizedBox(height: ScreenUtil().setHeight(10)),
                    Text("Charger Type",
                        style:
                            TextStyle(color: Constants.black, fontSize: 15.sp)),
                    SizedBox(height: ScreenUtil().setHeight(5)),
                    DropdownButtonFormField(
                      value: visibilityWidgetsWatch.chargertype,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(),
                          ),
                          fillColor: Colors.grey[200],
                          labelStyle: TextStyle(color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey))),
                      hint: const Text(
                        'Select Charger Type',
                      ),
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 42,
                      onChanged: (newvalue) =>
                          setState(() => chargertype = newvalue),
                      validator: (value) =>
                          value == null ? 'Field Should not be Empty' : null,
                      items: ['Single Phase', 'Three Phase']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(10)),
                    Text("Charger Capacity",
                        style:
                            TextStyle(color: Constants.black, fontSize: 15.sp)),
                    SizedBox(height: ScreenUtil().setHeight(5)),
                    DropdownButtonFormField(
                      value: visibilityWidgetsWatch.chargercapacity,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(),
                          ),
                          fillColor: Colors.grey[200],
                          labelStyle: TextStyle(color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey))),
                      hint: const Text(
                        'Select Charger Cpacity',
                      ),
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 42,
                      onChanged: (newvalue) =>
                          setState(() => chargercapacity = newvalue),
                      validator: (value) =>
                          value == null ? 'Field Should not be Empty' : null,
                      items: ['16 A', '32 A']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(10)),
                    Text("Connection Type",
                        style:
                            TextStyle(color: Constants.black, fontSize: 15.sp)),
                    SizedBox(height: ScreenUtil().setHeight(5)),
                    DropdownButtonFormField(
                      value: visibilityWidgetsWatch.connectiontype,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(),
                          ),
                          fillColor: Colors.grey[200],
                          labelStyle: TextStyle(color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey))),
                      hint: const Text(
                        'Select Connection Type',
                      ),
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 42,
                      onChanged: (newvalue) =>
                          setState(() => connectiontype = newvalue),
                      validator: (value) =>
                          value == null ? 'Field Should not be Empty' : null,
                      items: ['Socket', 'Cable']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: ScreenUtil().setHeight(10)),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Container(
                        height: 50,
                        child: Center(
                          child: MaterialButton(
                            textColor: Colors.black,
                            color: Constants.blue,
                            child: const Center(
                              child: Text(
                                "Submit Charger Setting",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            onPressed: () {
                              if (charger_key.currentState.validate()) {
                                charger_key.currentState.save();
                                visibilityWidgetsWatch.SendRequest26(
                                    26,
                                    chargername,
                                    chargertype,
                                    chargercapacity,
                                    connectiontype);
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
      ),
    );
  }
}
