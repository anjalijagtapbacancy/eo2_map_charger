import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SizeConstants {
  static void setScreenAwareConstant(context) {
    ScreenUtil.init(
        context,
        designSize: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height )
    );
  }
}
