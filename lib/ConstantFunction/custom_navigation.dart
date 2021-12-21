import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomNavigation {
  static Future<void> push (
      {@required BuildContext context, @required Widget className}) async {
    await Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) => className),
    );
  }

  static Future<void> pushReplacement({BuildContext context, Widget className}) {
    Navigator.of(context).pushReplacement(
      CupertinoPageRoute(builder: (context) => className),
    );
  }

  static pushAndRemoveUntil({BuildContext context, Widget className}) {
    Navigator.pushAndRemoveUntil(context,
        CupertinoPageRoute(builder: (context) => className), (route) => false);
  }
}
