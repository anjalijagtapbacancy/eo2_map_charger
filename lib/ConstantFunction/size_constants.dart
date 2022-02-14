import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SizeConstants {
  static void setScreenAwareConstant(context) {
    ScreenUtil.init(
      BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
          maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(360, 800),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);
  }
}