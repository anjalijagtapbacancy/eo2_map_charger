import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ConstantFunction/Constants.dart';

class CommonWidgets {
  Widget CommonLoader(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(
            AssetConstants.loader,
            height: 100,
            width: 100,
          ),
        ],
      ),
    );
  }

  showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  Widget showErrorSnackbar(BuildContext context, num id,
      [Color color, Duration duration]) {
    Map ids = {
      0: "Success in Response",
      1: "Failure in Response ",
      2: "Valid Json PayLoad",
      3: "Invalid Msg Code",
      4: "Invalid Device MAC",
      5: "Invalid Json Property",
      6: "Invalid Payload Data",
      7: "Json String Null Pointer",
      8: "Json Root Error",
      9: "BLE Error",
      10: "WIFI Error",
      11: "NVS Flash",
      12: "Data Not Found",
      13: "Threshold Error"
    };
    ids.forEach((key, value) {
      if (key == id) {
        String errorText = value;
        /* if (value.toString().contains("CMD_")) {
          errorText = value.toString().replaceAll("CMD_", "");
        }
        errorText = value.replaceAll("_", " ");*/
        log("errorText is $errorText");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorText),
          backgroundColor: color ?? Colors.red,
          duration: Duration(seconds: 1),
        ));
      }
    });
  }
}
