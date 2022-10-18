import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonStyles
{
  static ButtonStyle commonButtonStyle(BuildContext context , {Color color})
  {
    return ElevatedButton.styleFrom(
        primary: color != null ? color : const Color(0xFFE77721),
        padding: EdgeInsets.symmetric(horizontal: 55.w , vertical: 12.h ),
        textStyle: TextStyle(
            fontWeight: FontWeight.bold , fontSize: 18.sp));
  }
}